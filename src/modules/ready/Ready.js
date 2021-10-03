import KiramekiHelper from '../../KiramekiHelper.js';

class Ready {
    constructor() {
        this.name = 'ready';
        this.wsEvent = 'READY';
    }

    async execute(message, kirCore) {
        kirCore.editStatus("online", { name: `kirameki.one | ${kirCore.prefix}help` });
        KiramekiHelper.log(KiramekiHelper.LogLevel.EVENT, "STARTUP", `Kirameki was restarted successfully and is now ready! Serving ${kirCore.commands.size} commands and ${kirCore.modules.size} modules.`);
    }
}

export default new Ready();