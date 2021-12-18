import KiramekiHelper from '../../KiramekiHelper.js';
import { ChartJSNodeCanvas } from 'chartjs-node-canvas';
import uniqid from 'uniqid';
import Canvas from 'canvas';


class OsuStrain {
    constructor() {
        this.category = KiramekiHelper.categories.OSU;
        this.name = 'strain';
        this.owner = false;
        this.cooldown = 15;
        this.permissions = ['attachFiles'];
        this.aliases = ['osustrain'];
        this.help = {
		    message: 'Calculate the aim, speed and total strain of a previously posted osu! beatmap. Providing mods is optional defaulting to no mods.',
		    usage: 'strain [mods]',
		    example: ['strain', 'strain +HD,HR', 'strain +HD,HR,DT,FL']
		}
    }

    async execute(message, kirCore) {
        const [command, args]   = KiramekiHelper.tailedArgs(message.content, ' ', 1);
        const strainMods        = (args) ? KiramekiHelper.modToNumbers(args) : 0;
        const beatmapID         = await KiramekiHelper.getLatestBMID(kirCore.DB, message.channel.id);

        if (beatmapID === -1) {
            return message.channel.createEmbed(new KiramekiHelper.Embed()
                .setColor(0xF06DA8)
                .setAuthor("osu! Strain Graph", KiramekiHelper.images.OSU_LOGO)
                .setDescription("It appears there hasn't been any recent beatmap interaction in this particular channel before! To use this command a recent score or beatmap link must have been published at least once in this channel!")
            );
        }

        const loadingMessage        = await message.channel.createEmbed(new KiramekiHelper.Embed().setColor("GREEN").setTitle(`${KiramekiHelper.emojis.STATUS.LOADING} Calculating ...`));
        const doesChartAlreadyExist = await KiramekiHelper.preparedQuery(kirCore.DB, 'SELECT beatmap_title, graph FROM osu_strain_graphs WHERE beatmap_id = ? AND mods = ? LIMIT 1;', [beatmapID, strainMods]);

        if (doesChartAlreadyExist.length > 0) {
            try {
                const databaseGraph = await KiramekiHelper.getStrainGraphBuffer(doesChartAlreadyExist[0].graph);

                await message.channel.createMessage(undefined, { file: databaseGraph, name: `${uniqid()}.png` });
                loadingMessage.edit({ embed: new KiramekiHelper.Embed().setColor("GREEN").setTitle(`Finished processing **${doesChartAlreadyExist[0].beatmap_title}**`) });

                return KiramekiHelper.log(KiramekiHelper.LogLevel.COMMAND, 'osu! STRAIN CACHED', `${KiramekiHelper.userLogCompiler(message.author)} used the osu! Strain command on a cached map!`);
            } catch (fileBufferError) {
                KiramekiHelper.log(KiramekiHelper.LogLevel.ERROR, 'STRAIN GRAPH FILE BUFFER ERROR', fileBufferError);
            }
        }

        const chartNode             = new ChartJSNodeCanvas({width: 800, height: 450});
        const beatmapOsuFile        = await KiramekiHelper.obtainAndCacheOsuFile(beatmapID);
        const beatmapStrainObject   = KiramekiHelper.getBeatmapStrain(beatmapOsuFile, strainMods);
	console.log(beatmapStrainObject);
        const modStringParsed       = (KiramekiHelper.numberToMod(strainMods).length) ? `+${KiramekiHelper.numberToMod(strainMods).join(',')}` : '';
        const graphingOptions       = {
            type: 'line',
            data: {
                labels: beatmapStrainObject.timing,
                datasets: [
                    {
                        data: beatmapStrainObject.total,
                        label: "Total Strain",
                        borderColor: "#FF9185",
                        fill: true,
                        pointRadius: 0,
                        tension: 0
                    },
                    {
                        data: beatmapStrainObject.speed,
                        label: "Speed Strain",
                        borderColor: "#2ECC71",
                        fill: true,
                        pointRadius: 0
                    },
                    {
                        data: beatmapStrainObject.aim,
                        label: "Aim Strain",
                        borderColor: "#3498DB",
                        fill: true,
                        pointRadius: 0
                    },
                ]
            },
            options: {
                plugins: {
                    title: {
                        display: true,
                        color: '#d2d9dc',
                        font: {
                            size: 18,
                        },
                        padding: 20,
                        text: `${beatmapStrainObject.map.artist} - ${beatmapStrainObject.map.title} [${beatmapStrainObject.map.version}] ${modStringParsed}`
                    },
                    legend: {
                        labels: {
                            color: '#d2d9dc',
                            font: {
                                size: 16,
                            },
                        }
                    }
                }
            }
        }
	
	const graphBuffer = await chartNode.renderToBuffer(graphingOptions);
        // const graphInstance = await chartNode.drawChart(graphingOptions);
        // const graphBuffer   = await chartNode.getImageBuffer('image/png');

        // chartNode.destroy();

        const modCanvas     = Canvas.createCanvas(800, 450);
        const ctx           = modCanvas.getContext('2d');
        const graphImage    = await Canvas.loadImage(graphBuffer);

        let bgImage;

        try {
	    console.log(`https://assets.ppy.sh/beatmaps/${beatmapStrainObject.map.beatmapsetId}/covers/cover.jpg`)
            bgImage = await Canvas.loadImage(`https://assets.ppy.sh/beatmaps/${beatmapStrainObject.map.beatmapsetId}/covers/cover.jpg`); 
        } catch (e) {
            bgImage = await Canvas.loadImage(KiramekiHelper.images.OSU_STRAIN_GRAPH_BACKGROUND);
        }

        // Draw background image
        ctx.drawImage(bgImage, modCanvas.width / 2 - (450 * bgImage.width / bgImage.height) / 2, 0, 450 * bgImage.width / bgImage.height, 450);

        // Draw background alpha
        ctx.fillStyle = 'rgba(9, 9, 9, .85)';
        ctx.fillRect(0, 0, 800, 450);

        // Draw graph
        ctx.drawImage(graphImage, 0, 0, 800, 450);

        const graphResult = modCanvas.toBuffer();

        await message.channel.createMessage(undefined, { file: graphResult, name: `${uniqid()}.png` });
        loadingMessage.edit({ embed: new KiramekiHelper.Embed().setColor("GREEN").setTitle(`Finished processing **${beatmapStrainObject.map.title}**`) });
        KiramekiHelper.cacheStrainGraph(kirCore.DB, beatmapID, beatmapStrainObject.map.title, strainMods, graphResult);
        KiramekiHelper.log(KiramekiHelper.LogLevel.COMMAND, 'osu! STRAIN UNCACHED', `${KiramekiHelper.userLogCompiler(message.author)} used the osu! Strain command on an uncached map!`);
    }
}

export default new OsuStrain();

