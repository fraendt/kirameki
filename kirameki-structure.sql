/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `animes`
--

DROP TABLE IF EXISTS `animes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text COLLATE utf8mb4_bin NOT NULL,
  `language` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40839 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banned`
--

DROP TABLE IF EXISTS `banned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banned` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_tag` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `ban_reason` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `ban_date` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `birthday_ignores`
--

DROP TABLE IF EXISTS `birthday_ignores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `birthday_ignores` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guild_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blacklisted_guild`
--

DROP TABLE IF EXISTS `blacklisted_guild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklisted_guild` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guild_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `command_usage`
--

DROP TABLE IF EXISTS `command_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command_usage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `commandname` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `commandcount` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_commands`
--

DROP TABLE IF EXISTS `custom_commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `command_name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `command_value` text COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_login_logs`
--

DROP TABLE IF EXISTS `dashboard_login_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_login_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `discord_id` bigint(20) NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `access_token` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `date` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devflags`
--

DROP TABLE IF EXISTS `devflags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devflags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devtag` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `devstatus` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gurus`
--

DROP TABLE IF EXISTS `gurus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gurus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discord_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ignored_channels`
--

DROP TABLE IF EXISTS `ignored_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ignored_channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ignored_commands`
--

DROP TABLE IF EXISTS `ignored_commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ignored_commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `command_name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `memes`
--

DROP TABLE IF EXISTS `memes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `memes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `meme_link` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mute`
--

DROP TABLE IF EXISTS `mute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discord_id` bigint(20) NOT NULL,
  `guild_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_accounts`
--

DROP TABLE IF EXISTS `osu_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `country` varchar(10) COLLATE utf8mb4_bin NOT NULL,
  `pp_raw` double(10,2) NOT NULL,
  `pp_rank` int(255) NOT NULL,
  `accuracy` double(10,2) NOT NULL,
  `playcount` bigint(20) NOT NULL,
  `score_ss` int(255) NOT NULL,
  `score_s` int(255) NOT NULL,
  `score_a` int(255) NOT NULL,
  `last_update` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_beatmap_files`
--

DROP TABLE IF EXISTS `osu_beatmap_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_beatmap_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `beatmap_id` bigint(20) NOT NULL,
  `beatmapfile` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_beatmaps`
--

DROP TABLE IF EXISTS `osu_beatmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_beatmaps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mods` int(30) NOT NULL,
  `beatmap_id` bigint(20) NOT NULL,
  `pp` double(10,2) NOT NULL,
  `beatmapset_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75739 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_beatmaps_vt`
--

DROP TABLE IF EXISTS `osu_beatmaps_vt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_beatmaps_vt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mods` bigint(20) NOT NULL,
  `beatmap_id` bigint(20) NOT NULL,
  `pp` double(10,2) NOT NULL,
  `beatmapset_id` bigint(20) NOT NULL,
  `beatmap_artist` text COLLATE utf8mb4_bin NOT NULL,
  `beatmap_title` text COLLATE utf8mb4_bin NOT NULL,
  `beatmap_difficulty` text COLLATE utf8mb4_bin NOT NULL,
  `beatmap_length` bigint(20) NOT NULL,
  `beatmap_bpm` bigint(20) NOT NULL,
  `beatmap_stars` double(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `beatmapsearch` (`beatmap_artist`,`beatmap_title`,`beatmap_difficulty`)
) ENGINE=InnoDB AUTO_INCREMENT=121893 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_bmlink_cards`
--

DROP TABLE IF EXISTS `osu_bmlink_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_bmlink_cards` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `channel_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_channel_ocr`
--

DROP TABLE IF EXISTS `osu_channel_ocr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_channel_ocr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_discord_links`
--

DROP TABLE IF EXISTS `osu_discord_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_discord_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discord_id` bigint(20) NOT NULL,
  `discord_username` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `osu_id` int(50) NOT NULL,
  `osu_username` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_leaderboards`
--

DROP TABLE IF EXISTS `osu_leaderboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_leaderboards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` bigint(20) NOT NULL,
  `guild_name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `guild_avatar` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `osu_ids` longtext COLLATE utf8mb4_bin NOT NULL,
  `osu_ids_hash` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1545 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_link_verifications`
--

DROP TABLE IF EXISTS `osu_link_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_link_verifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `discord_id` bigint(20) NOT NULL,
  `discord_tag` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `osu_id` bigint(20) NOT NULL,
  `osu_username` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `verification_code` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `verified` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_recents`
--

DROP TABLE IF EXISTS `osu_recents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_recents` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `discord_id` bigint(20) NOT NULL,
  `beatmap_id` bigint(20) NOT NULL,
  `channel_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4403 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `osu_strain_graphs`
--

DROP TABLE IF EXISTS `osu_strain_graphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osu_strain_graphs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `beatmap_id` bigint(20) NOT NULL,
  `beatmap_title` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `mods` bigint(20) NOT NULL,
  `graph` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `peacekeepers`
--

DROP TABLE IF EXISTS `peacekeepers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `peacekeepers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `discord_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile_xp`
--

DROP TABLE IF EXISTS `profile_xp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_xp` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `discord_id` bigint(20) NOT NULL,
  `discord_tag` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `discord_avatar` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `level` bigint(20) NOT NULL,
  `xp` bigint(20) NOT NULL,
  `accent_color` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `bg_img` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `pats` bigint(20) NOT NULL DEFAULT '0',
  `last_pat` bigint(20) NOT NULL DEFAULT '1546970004',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=218433 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sounds`
--

DROP TABLE IF EXISTS `sounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sounds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soundName` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `soundDesc` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `soundPlaycount` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `date` bigint(20) NOT NULL,
  `description` text COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_locations`
--

DROP TABLE IF EXISTS `weather_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weather_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discord_id` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_blacklist`
--

DROP TABLE IF EXISTS `word_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` bigint(20) NOT NULL,
  `word` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=518 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

