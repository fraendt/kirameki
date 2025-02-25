import KiramekiHelper from '../../KiramekiHelper.js';

class ProfanityFilter {
    constructor() {
        this.name = 'profanityfilterMC';
        this.wsEvent = 'MESSAGE_CREATE';
    }

    async execute(message, kirCore) {
        if (!message) return;
        if (message.channel.type != 0) return;
        if (!message.author) return;
        if (message.author.bot) return;
        
        const wordExists        = await KiramekiHelper.preparedQuery(kirCore.DB, 'SELECT * FROM word_blacklist WHERE guild_id = ?;', [message.channel.guild.id]);
        const isMuted           = await KiramekiHelper.preparedQuery(kirCore.DB, 'SELECT * FROM mute WHERE discord_id = ? AND guild_id = ?;', [message.author.id, message.channel.guild.id]);
        const sanitizedContent  = KiramekiHelper.sanitizeMarkdown(message.content);

        if (wordExists.length > 0) {
            for (let i = 0; i < wordExists.length; i++) {
                if (sanitizedContent.includes(wordExists[i].word.toLowerCase()) && !isMuted.length) {
                    return message.delete().catch((error) => {
                        KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, 'PROFANITY FILTER', `Couldn't delete message because of: ${error}`);
                    });
                }
            }
        }
    }
}

export default new ProfanityFilter();