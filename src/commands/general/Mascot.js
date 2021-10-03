import KiramekiHelper from '../../KiramekiHelper.js';

class Mascot {
    constructor() {
        this.name = 'mascot';
        this.category = KiramekiHelper.categories.GENERAL;
        this.help = {
            message: 'Display the official animated mascot of Kirameki!',
            usage: 'mascot',
            example: 'mascot',
            inline: true
        }
    }

    async execute(message, kirCore) {
        message.channel.createEmbed(new KiramekiHelper.Embed()
            .setColor('DEFAULT')
            .setImage(KiramekiHelper.images.KIRAMEKI_MASCOT_ANIMATED)
        );

        KiramekiHelper.log(KiramekiHelper.LogLevel.COMMAND, 'MASCOT', `${KiramekiHelper.userLogCompiler(message.author)} used the ${this.name} command.`);
    }
}

export default new Mascot();