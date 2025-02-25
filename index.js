// import { KiramekiHelperInstance as KiramekiHelper } from './src/KiramekiHelper.js';
import KiramekiHelper from './src/KiramekiHelper.js';
import MessageHandler from './src/MessageHandler.js';
import ModuleHandler from './src/ModuleHandler.js';
// import * as Eris           from 'eris-additions';
import * as mysql          from 'mysql';
import * as nodesu         from 'nodesu';
import read from 'fs-readdir-recursive';

import KiramekiConfig from './config/KiramekiConfig.js';
import ErisBase from 'eris';
import * as ErisBasic from 'eris';

Object.keys(ErisBasic).forEach((val) => (ErisBase[val] = ErisBasic[val]))
const Eris = ErisBasic;
const erisadditions = import("eris-additions")
const ea = await erisadditions;
ea.default(Eris);


/*
const KiramekiConfig    = require('./config/KiramekiConfig');
const KiramekiHelper    = require('./src/KiramekiHelper');
const MessageHandler    = require('./src/MessageHandler');
const ModuleHandler     = require('./src/ModuleHandler');
const Eris              = require('eris-additions')(require('eris'));
const mysql             = require('mysql');
const nodesu            = require('nodesu');
const read              = require('fs-readdir-recursive');
*/


/**
 * Kirameki Discord bot. The main Discord bot instance of the Kirameki project.
 * Copyright (C) 2019  Riya <kato.hana@outlook.jp>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 * 
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/agpl-3.0.en.html>.
 */
class Kirameki extends Eris.Client {
    constructor() {
        super(KiramekiConfig.token, KiramekiConfig.erisOptions);
        this.eligibleForXp  = new Set();
        this.commands       = new Eris.Collection();
        this.modules        = new Eris.Collection();
        this.messageHandler = new MessageHandler(this);
        this.moduleHandler  = new ModuleHandler(this);
        this.osu            = new nodesu.Client(KiramekiConfig.osuApiKey);

        this.prefix         = KiramekiConfig.prefix;
        this.commandFiles   = read('./src/commands').filter(file => file.endsWith('.js'));
        this.moduleFiles    = read('./src/modules').filter(file => file.endsWith('.js'));
        this.DB             = mysql.createConnection(KiramekiConfig.mysqlOptions);

        this.DB.connect(this._initKiramekiDatabase);

        this._addEventListeners();
        this._registerKiramekiCommands();
        this._registerKiramekiModules();
        this._catchUnhandledRejections();
        this.connect();
    }

    /**
     * Registers all available gateway event modules
     */
    _registerKiramekiModules() {
        for (const kiramekiModuleFile of this.moduleFiles) {
            const kiramekiModule = import(`./src/modules/${kiramekiModuleFile}`);
            kiramekiModule.then(module => {
                this.modules.set(module.default.name, module.default)
            }).catch((error) => {
                console.log(error)
            })
        }
    }

    /**
     * Registers all available commands
     */
    _registerKiramekiCommands() {
        for (const kiramekiCommandFile of this.commandFiles) {
            const kiramekiCommand = import(`./src/commands/${kiramekiCommandFile}`);
            kiramekiCommand.then(command => {
                this.commands.set(command.default.name, command.default)
            }).catch((error) => {
                console.log(error)
            })
        }
    }

    /**
     * Catches all unhandled promise rejections in case any were to pop up 
     */
    _catchUnhandledRejections() {
        if (KiramekiConfig.debug) {
            process.on('unhandledRejection', (error, promise) => {
                KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, 'UNHANDLED PROMISE REJECTION', `An unhandled promise rejection occurred. Promise: ${promise} | Rejection: ${error}`);
                console.log(promise)
                process.exit(1);
            });
        }
    }

    /**
     * Connection handler for the database
     * @param {*} connectionError A possible error thrown by the database connector
     */
    _initKiramekiDatabase(connectionError) {
        if (connectionError) {
            KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, "DATABASE ERROR", `A connection error surfaced: ${connectionError}`);
        }

        KiramekiHelper.log(KiramekiHelper.LogLevel.EVENT, "DATABASE CONNECTION", "Successfully connected to the database!");
    }

    /**
     * The main event module listener. This method gets triggered for each pre-processed event
     * @param {object} message The message object emitted from the Discord API 
     * @param {enum} wsEvent The WS Event enum 
     * @param {object} other Any other data passed to the module handler 
     */
    _moduleListener(message, wsEvent, other) {
        try {
            this.moduleHandler.handle(message, this.modules, wsEvent, other);
        } catch (moduleListenerError) {
            KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, "MODULE LISTENER ERROR", `A module couldn't be processed because of: ${moduleListenerError}`);
        }
    }

    /**
     * The main message listener. This method gets triggered for each pre-processed message
     * @param {object} message The message object emitted from the Discord API 
     */
    async _messageListener(message) {
        try {
            if (message.channel.type !== 0) return;
            if (message.author.bot) return;
            
            const isMuted = await KiramekiHelper.preparedQuery(this.DB, 'SELECT * FROM mute WHERE discord_id = ? AND guild_id = ?;', [message.author.id, message.channel.guild.id]);
            if (isMuted.length > 0) return message.delete();
            if (!message.content.startsWith(this.prefix)) return;
            if (message.content === this.prefix) return;
            
            this.messageHandler.handle(message, this.commands);
        } catch (messageListenerError) {
            KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, "MESSAGE LISTENER ERROR", `A message couldn't be processed because of: ${messageListenerError}`);
        }
    }

    /**
     * Execute all needed processors for the MESSAGE_CREATE event including the command handling and the module handling
     * @param {object} message The message object emitted from the Discord API 
     */
    _runMessageOperators(message) {
        this._messageListener(message);
        this._moduleListener(message, this.moduleHandler.wsEvents.MESSAGE_CREATE);
    }

    /**
     * Execute all needed processors for the READY event
     */
    _runReadyOperators() {
        this._moduleListener(undefined, this.moduleHandler.wsEvents.READY);
    }

    /**
     * Execute all needed processors for the GUILD_CREATE event. Remember: The client joining a new guild will emit this event
     * @param {object} guild The guild object emitted from the Discord API 
     */
    _runGuildCreateOperators(guild) {
        this._moduleListener(undefined, this.moduleHandler.wsEvents.GUILD_CREATE, { guild });
    }

    /**
     * Execute all needed processors for the MESSAGE_UPDATE event
     * @param {object} message The message object emitted from the Discord API 
     * @param {*} oldMessage The old message object emitted from the Discord API 
     */
    _runMessageUpdateOperators(message, oldMessage) {
        this._moduleListener(message, this.moduleHandler.wsEvents.MESSAGE_UPDATE, { oldMessage });
    }

    /**
     * Execute all needed processors for the USER_UPDATE event
     * @param {object} newUser The new user object
     * @param {object} oldUser The old user object
     */
    _runUserUpdateOperators(newUser, oldUser) {
        this._moduleListener(undefined, this.moduleHandler.wsEvents.USER_UPDATE, { newUser });
    }

    /**
     * Register all websocket event listeners running sub pre-processors for a single event once to reduce event binding overload
     */
    _addEventListeners() {
        this.on('ready', this._runReadyOperators);
        this.on('messageCreate', this._runMessageOperators);
        this.on('guildCreate', this._runGuildCreateOperators);
        this.on('userUpdate', this._runUserUpdateOperators);
        this.on('messageUpdate', this._runMessageUpdateOperators);
        this.on('error', (error) => KiramekiHelper.log(KiramekiHelper.LogLevel.DEBUG, 'SHARD ERROR', `A shard error appeared but re-established connection: ${error}`));
    }
}

export default new Kirameki();
