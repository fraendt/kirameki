import KiramekiHelper from './KiramekiHelper.js';
import Eris from 'eris';
import juration from 'juration';

class MessageHandler {
    constructor(kirCore) {
        this.kirCore = kirCore;
        this.cooldowns = new Eris.Collection();
        this.minimumPermissions = ['readMessages', 'sendMessages', 'embedLinks'];
    }

    /**
     * The main method which is running for each message received that's passed the initial filtration
     * @param {object} message The message object emitted from Discord 
     * @param {object} commands An Eris collection containing all loaded commands
     */
    async handle(message, commands) {
        KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, "handling")
        console.log('in message handler')
        const commandArguments  = message.content.slice(this.kirCore.prefix.length).split(/ +/);
        const commandName       = commandArguments.shift().toLowerCase();
        KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, "fuck"+message)
        const command           = commands.get(commandName) || commands.find(kirCommand => kirCommand.aliases && kirCommand.aliases.includes(commandName));

        // Stop handling if no registered command was found
        if (!command) return;
        
        KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, message)
        // Check if the channel is currently being ignored
        const isChannelIgnored = await KiramekiHelper.preparedQuery(this.kirCore.DB, 'SELECT * FROM ignored_channels WHERE channel_id = ?;', [message.channel.id]);
        
        if ((isChannelIgnored.length > 0) && !message.member.permission.has('administrator')) return;

        // Check if the command is currently being ignored in the channel
        const isCommandIgnoredInChannel = await KiramekiHelper.preparedQuery(this.kirCore.DB, 'SELECT * FROM ignored_commands WHERE channel_id = ? AND command_name = ?;', [message.channel.id, command.name.toLowerCase()]);

        if ((isCommandIgnoredInChannel.length > 0) && !message.member.permission.has('administrator')) return;

        // Check if the user is banned from using Kirameki
        console.log("checking if user is banned....");
        const isBanned = await KiramekiHelper.preparedQuery(this.kirCore.DB, 'SELECT * FROM banned WHERE user_id = ? LIMIT 1;', [message.author.id]);
        console.log("banned: " + isBanned);

        if (isBanned.length > 0) {
            return message.channel.createEmbed(new KiramekiHelper.Embed()
                .setColor('DEFAULT')
                .setTitle('You are banned from using Kirameki!')
                .setDescription(`It appears you have been banned from using **Kirameki** indefinitely. A complete exclusion of Kirameki takes only place when the bot and/or its infrastructure have been heavily abused.\n\nIf you feel like this is an error, you may feel free to appeal over the [Contact Form on Kirameki's Website](${KiramekiHelper.links.WEBSITE.CONTACT})`)
                .setThumbnail(KiramekiHelper.images.KIRAMEKI_SAD)
                .addField('Reason', `\`\`\`${isBanned[0].ban_reason}\`\`\``, false)
            ).catch((error) => {
                KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, 'MUTED', 'Cannot speak at all.')
            });
        }
        
        // Check if the bot has adequate permissions
        const pendingPermissions = (!command.permissions) ? this.minimumPermissions : this.minimumPermissions.concat(command.permissions);
        let missingPermissions = [];

        for (let i = 0; i < pendingPermissions.length; i++) {
            if (!message.channel.permissionsOf(this.kirCore.user.id).has(pendingPermissions[i])) {
                missingPermissions.push(pendingPermissions[i]);
            }
        }

        if (missingPermissions.length) {
            return message.channel.createMessage(`Can't run command **${command.name}** because I lack following permissions: **${missingPermissions.join(', ')}**\nIf you want to make use of this feature please grant me the missing permissions.`).catch((error) => {
                KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, 'MUTED', 'Cannot speak at all.')
            });
        }

        // Check if the user has adequate permissions
        const pendingUserPermissions = (!command.userPermissions) ? false : command.userPermissions;
        let missingUserPermissions = [];

        if (pendingUserPermissions) {
            for (let x = 0; x < pendingUserPermissions.length; x++) {
                if (!message.member.permission.has(pendingUserPermissions[x])) {
                    missingUserPermissions.push(pendingUserPermissions[x]);
                }
            }

            if (missingUserPermissions.length) {
                return message.channel.createEmbed(new KiramekiHelper.Embed()
                    .setColor("RED")
                    .setTitle("Insufficient Permissions!")
                    .setDescription(`You lack following permissions to use this command: **${missingUserPermissions.join(', ')}**`)
                );
            }
        } 

        // Check if the command is restricted to the bot owner 
        if (command.owner && !KiramekiHelper.checkIfOwner(message.author.id)) {
            return message.channel.createEmbed(new KiramekiHelper.Embed().setColor("RED").setTitle("Insufficient Permissions!"));
        }

        // Check if an NSFW command is only used in an NSFW channel
        if (command.nsfw && !message.channel.nsfw) {
            return message.channel.createEmbed(new KiramekiHelper.Embed().setColor("RED").setTitle(`Command **${command.name}** is only available in NSFW channels!`));
        }

        // Command cooldowns 
        if (!this.cooldowns.has(command.name)) {
            this.cooldowns.set(command.name, new Eris.Collection());
        }

        const now = Date.now();
        const timestamps = this.cooldowns.get(command.name);
        const cooldownAmount = (command.cooldown || 2) * 1000;

        if (timestamps.has(message.author.id)) {
            const expirationTime = timestamps.get(message.author.id) + cooldownAmount;

            if (now < expirationTime) {
                const timeLeft = (expirationTime - now) / 1000;
                const timeLeftFormatted = juration.stringify(timeLeft, { format: 'long', units: 1 });

                return message.channel.createEmbed(new KiramekiHelper.Embed()
                    .setColor(0xFF9185)
                    .setTitle(`Please wait **${timeLeftFormatted}** before using **${command.name}** again`)
                );
            }
        }

        timestamps.set(message.author.id, now);
        setTimeout(() => timestamps.delete(message.author.id), cooldownAmount);

        try {
            command.execute(message, this.kirCore, this.cooldowns);

            const doesCommandExist = await KiramekiHelper.preparedQuery(this.kirCore.DB, 'SELECT commandname FROM command_usage WHERE commandname = ?;', [command.name]);

            if (doesCommandExist.length > 0) {
                KiramekiHelper.preparedQuery(this.kirCore.DB, 'UPDATE command_usage SET commandcount = commandcount + 1 WHERE commandname = ?;', [command.name]);
            } else {
                KiramekiHelper.preparedQuery(this.kirCore.DB, 'INSERT INTO command_usage (id, commandname, commandcount) VALUES (NULL, ?, ?);', [command.name, 1]);
            }
        } catch (commandExecutionError) {
            KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, "COMMAND EXECUTION ERROR", `A command couldn't be executed because of: ${commandExecutionError}`);
        }
    }
}

// module.exports = MessageHandler;

export default MessageHandler;