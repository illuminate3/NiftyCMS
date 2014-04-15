-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 15, 2014 at 05:40 PM
-- Server version: 5.5.24-log
-- PHP Version: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `niftycms`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Uncategorised', '2014-04-14 14:09:04', '2014-04-14 14:09:04'),
(2, 'News', '2014-04-15 11:55:24', '2014-04-15 11:55:24'),
(3, 'Fun Facts', '2014-04-15 11:56:09', '2014-04-15 11:56:09');

-- --------------------------------------------------------

--
-- Table structure for table `category_post`
--

CREATE TABLE IF NOT EXISTS `category_post` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_post_category_id_index` (`category_id`),
  KEY `category_post_post_id_index` (`post_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `category_post`
--

INSERT INTO `category_post` (`id`, `category_id`, `post_id`) VALUES
(1, 2, 1),
(2, 2, 2),
(3, 2, 3),
(4, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `groups_name_unique` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', NULL, '2014-04-14 14:09:04', '2014-04-14 14:09:04'),
(2, 'Publisher', NULL, '2014-04-14 14:09:04', '2014-04-14 14:09:04');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_03_24_172630_create_users_table', 1),
('2014_03_24_172649_create_groups_table', 1),
('2014_03_24_172706_create_users_groups_table', 1),
('2014_03_24_172723_create_throttle_table', 1),
('2014_03_24_172740_create_pages_table', 1),
('2014_03_24_173510_create_categories_table', 1),
('2014_03_24_173527_create_posts_table', 1),
('2014_03_24_173705_create_category_post_table', 1),
('2014_03_24_173845_create_settings_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `summary` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `featured_image` text COLLATE utf8_unicode_ci,
  `link` text COLLATE utf8_unicode_ci,
  `order` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `is_online` tinyint(1) NOT NULL DEFAULT '0',
  `is_current` tinyint(1) NOT NULL DEFAULT '0',
  `is_latest` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pages_parent_id_index` (`parent_id`),
  KEY `pages_lft_index` (`lft`),
  KEY `pages_rgt_index` (`rgt`),
  KEY `pages_slug_index` (`slug`),
  KEY `pages_user_id_foreign` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=19 ;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `user_id`, `parent_id`, `lft`, `rgt`, `depth`, `title`, `slug`, `summary`, `content`, `featured_image`, `link`, `order`, `version`, `is_online`, `is_current`, `is_latest`, `is_deleted`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 2, 0, 'Home Page', 'home-page', 'Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It''s also called placeholder (or filler) text. It''s a convenient tool for mock-ups', '<h1>Home Page</h1>\r\n\r\n<p><strong>Lorem ipsum</strong> is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It&#39;s also called placeholder (or filler) text. It&#39;s a convenient tool for mock-ups. It helps to outline the visual elements of a document or presentation, eg typography, font, or layout. Lorem ipsum is mostly a part of a Latin text by the classical author and philospher Cicero. Its words and letters have been changed by addition or removal, so to deliberately render its content nonsensical; it&#39;s not genuine, correct, or comprehensible Latin anymore. While <strong>lorem ipsum</strong>&#39;s still resembles classical Latin, it actually has no meaning whatsoever. As Cicero&#39;s text doesn&#39;t contain the letters K, W, or Z, alien to latin, these, and others are often inserted randomly to mimic the typographic appearence of European languages, as are digraphs not to be found in the original.</p>\r\n\r\n<p>In a professional context it often happens that private or corporate clients corder a publication to be made and presented with the actual content still not being ready. Think of a news blog that&#39;s filled with content hourly on the day of going live. However, reviewers tend to be distracted by comprehensible content, say, a random text copied from a newspaper or the internet. The are likely to focus on the text, disregarding the layout and its elements. Besides, random text risks to be unintendedly humorous or offensive, an unacceptable risk in corporate environments. <strong>Lorem ipsum</strong> and its many variants have been employed since the early 1960ies, and quite likely since the sixteenth century.</p>', NULL, NULL, 0, 1, 1, 1, 1, 0, '2014-04-14 14:14:40', '2014-04-14 14:28:55'),
(2, 1, NULL, 3, 4, 0, 'Home Page', 'home-page', 'Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It''s also called placeholder (or filler) text. It''s a convenient tool for mock-ups', '<h1>Home Page</h1>\r\n\r\n<p><strong>Lorem ipsum</strong> is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It&#39;s also called placeholder (or filler) text. It&#39;s a convenient tool for mock-ups. It helps to outline the visual elements of a document or presentation, eg typography, font, or layout. Lorem ipsum is mostly a part of a Latin text by the classical author and philospher Cicero. Its words and letters have been changed by addition or removal, so to deliberately render its content nonsensical; it&#39;s not genuine, correct, or comprehensible Latin anymore. While <strong>lorem ipsum</strong>&#39;s still resembles classical Latin, it actually has no meaning whatsoever. As Cicero&#39;s text doesn&#39;t contain the letters K, W, or Z, alien to latin, these, and others are often inserted randomly to mimic the typographic appearence of European languages, as are digraphs not to be found in the original.</p>\r\n\r\n<p>In a professional context it often happens that private or corporate clients corder a publication to be made and presented with the actual content still not being ready. Think of a news blog that&#39;s filled with content hourly on the day of going live. However, reviewers tend to be distracted by comprehensible content, say, a random text copied from a newspaper or the internet. The are likely to focus on the text, disregarding the layout and its elements. Besides, random text risks to be unintendedly humorous or offensive, an unacceptable risk in corporate environments. <strong>Lorem ipsum</strong> and its many variants have been employed since the early 1960ies, and quite likely since the sixteenth century.</p>\r\n\r\n<blockquote>\r\n<p>Lorem ipsizzle dolizzle for sure amizzle, consectetuer adipiscing for sure. Bling bling sapien velizzle, gizzle volutpat, doggy fo shizzle, gravida vizzle, arcu. Pellentesque stuff phat. Sizzle erizzle. Owned izzle cool dapibus bizzle tempus shit. Mauris pellentesque uhuh ... yih! izzle turpizzle. Mammasay mammasa mamma oo sa izzle tortizzle. Shizzle my nizzle crocodizzle crunk bizzle. In hac shut the shizzle up platea dictumst. Bow wow wow dapibizzle. Own yo&#39; bling bling phat, pretizzle eu, mattis boofron, funky fresh vitae, nunc. Fo shizzle suscipit. Integizzle semper pizzle get down get down the bizzle.</p>\r\n\r\n<p>Praesent mi non maurizzle dang shizzlin dizzle. Aliquam lacinia yo lectizzle. Cras izzle dawg sizzle leo sodales euismod. Aliquizzle lobortis, mauris ghetto dapibizzle convallis, nulla ligula bibendizzle metus, et venenatis augue dui ghetto tellivizzle. Vivamizzle boom shackalack lacus izzle ipsum. Vivamus arcu uhuh ... yih!, fermentizzle ma nizzle amet, faucibizzle izzle, hizzle izzle, yo. Sizzle shit laorizzle mofo. Vestibulizzle erat own yo&#39;, hendrerit izzle, fizzle izzle, yo hizzle, hizzle. Morbi shizzlin dizzle placerat shit. Ma nizzle malesuada erizzle phat erizzle. That&#39;s the shizzle ma nizzle sizzle, tellivizzle own yo&#39;, accumsizzle quis, elementizzle eget, neque. Cool iaculis nunc a orci dizzle its fo rizzle. Fusce sagittizzle, nulla pimpin&#39; get down get down dang, lacus quam gizzle own yo&#39;, vitae cool augue purizzle vitae owned. Etizzle ma nizzle lacizzle. Brizzle mofo mi. Duis yippiyo turpizzle. Vestibulum a dizzle. Sizzle tellivizzle erat, consectetuer izzle, tempizzle izzle, pot shit, fo shizzle. Nunc tellus. Brizzle fo shizzle erizzle, tristique sit pot, ultricizzle shit, tellivizzle owned, augue.</p>\r\n</blockquote>', NULL, NULL, 0, 2, 1, 0, 0, 0, '2014-04-14 14:16:21', '2014-04-14 14:27:04'),
(3, 1, NULL, 5, 8, 0, 'Who We Are', 'who-we-are', 'Dolphin far before strived before and a scooped bled much faint wasp goodness blind darn forewent far frivolous subtle newt pending affable that gregarious goodness cattily yikes swept knew naked across oh pled hello flippantly activated off essentially.', '<h1>Who Are We?</h1>\r\n\r\n<p>The saluted that frowned along lewdly or other involuntary poured that neutral returned thus hey below wrote crud immense wow far and goodness strove hey with.</p>\r\n\r\n<p>Dolphin far before strived before and a scooped bled much faint wasp goodness blind darn forewent far frivolous subtle newt pending affable that gregarious goodness cattily yikes swept knew naked across oh pled hello flippantly activated off essentially.</p>\r\n\r\n<p>Where jeez much less hello besides near alongside affirmative beneath yikes lizard dear less lighted jeepers knelt the misspelled caterpillar for wolverine darn according along overdid more smiled one strode that sheared thanks far that goodness in trout across yet hence some flexed.</p>\r\n\r\n<p>Ruefully the this jeepers greyhound gibbered notwithstanding hey kangaroo toward goodness ouch excluding taut and harmful effortless solicitously seal mindfully alas thus invaluable so piranha hence or far as innocuous browbeat well some coughed less that hungrily more coarsely.</p>\r\n\r\n<p>Vulture toucan constructive far less crud iguana across or hey within far crud darn pending wow far goodness a one some this impressively jeez austerely one hey fantastically to and more one symbolically outside the far goldfish seriously wherever then dear raging maladroitly.</p>', NULL, NULL, 1, 1, 1, 1, 1, 0, '2014-04-14 14:19:22', '2014-04-14 14:38:22'),
(4, 1, NULL, 9, 12, 0, 'What We Do', 'what-we-do', 'Eeh gerritetten any rooad. Aye shu'' thi gob gi'' o''er eeh. Bloomin'' ''eck. Ah''ll box thi ears breadcake. Where''s tha bin nobbut a lad. Shu'' thi gob ah''ll gi'' thi summat to rooer abaht t''foot o'' our stairs soft lad ne''ermind', '<h1>We do Yorkshire</h1>\r\n\r\n<p>Ne&#39;ermind. Eeh gerritetten any rooad. Aye shu&#39; thi gob gi&#39; o&#39;er eeh. Bloomin&#39; &#39;eck. Ah&#39;ll box thi ears breadcake. Where&#39;s tha bin nobbut a lad. Shu&#39; thi gob ah&#39;ll gi&#39; thi summat to rooer abaht t&#39;foot o&#39; our stairs soft lad ne&#39;ermind. Breadcake ey up tha knows tha what what&#39;s that when it&#39;s at ooam t&#39;foot o&#39; our stairs. Dahn t&#39;coil oil ne&#39;ermind chuffin&#39; nora. Ey up big girl&#39;s blouse how much be reet breadcake. Where&#39;s tha bin sup wi&#39; &#39;im any rooad chuffin&#39; nora ey up. Soft lad cack-handed gerritetten appens as maybe cack-handed shurrup.</p>\r\n\r\n<p>Gerritetten god&#39;s own county. What&#39;s that when it&#39;s at ooam any rooad dahn t&#39;coil oil be reet a pint &#39;o mild tintintin. A pint &#39;o mild ah&#39;ll box thi ears soft southern pansy tell thi summat for nowt t&#39;foot o&#39; our stairs any rooad. Will &#39;e &#39;eckerslike gerritetten appens as maybe ah&#39;ll gi&#39; thee a thick ear ne&#39;ermind any rooad. Nay lad ee by gum bobbar. By &#39;eck god&#39;s own county any rooad. Ey up chuffin&#39; nora aye. Big girl&#39;s blouse. What&#39;s that when it&#39;s at ooam appens as maybe tha knows shu&#39; thi gob gi&#39; o&#39;er bloomin&#39; &#39;eck. Nah then. Th&#39;art nesh thee a pint &#39;o mild will &#39;e &#39;eckerslike eeh soft southern pansy. Nobbut a lad wacken thi sen up a pint &#39;o mild mardy bum.</p>\r\n\r\n<p>That&#39;s champion. Where&#39;s tha bin bobbar breadcake that&#39;s champion. Any rooad shu&#39; thi gob by &#39;eck ah&#39;ll learn thi. T&#39;foot o&#39; our stairs tell thi summat for nowt gerritetten. Tha what big girl&#39;s blouse cack-handed eeh ey up tha what. Nay lad. Bobbar. Tha what sup wi&#39; &#39;im th&#39;art nesh thee tha what. Michael palin ah&#39;ll gi&#39; thi summat to rooer abaht. Cack-handed by &#39;eck mardy bum tha knows. Nah then tha knows what&#39;s that when it&#39;s at ooam ah&#39;ll gi&#39; thi summat to rooer abaht. Bobbar. Soft lad ne&#39;ermind ey up by &#39;eck tha daft apeth soft lad.</p>\r\n\r\n<p>Bobbar ne&#39;ermind where&#39;s tha bin ee by gum michael palin bloomin&#39; &#39;eck. Ah&#39;ll gi&#39; thi summat to rooer abaht tintintin ah&#39;ll learn thi ee by gum that&#39;s champion breadcake. Tha daft apeth nobbut a lad t&#39;foot o&#39; our stairs chuffin&#39; nora bobbar aye. What&#39;s that when it&#39;s at ooam bobbar shurrup bobbar bloomin&#39; &#39;eck. Ne&#39;ermind tha what. Will &#39;e &#39;eckerslike ne&#39;ermind mardy bum. Gi&#39; o&#39;er big girl&#39;s blouse appens as maybe a pint &#39;o mild wacken thi sen up. Gi&#39; o&#39;er sup wi&#39; &#39;im big girl&#39;s blouse wacken thi sen up sup wi&#39; &#39;im any rooad. Any rooad aye tha daft apeth mardy bum aye. Ne&#39;ermind big girl&#39;s blouse where there&#39;s muck there&#39;s brass. Gerritetten ey up is that thine nah then ah&#39;ll gi&#39; thi summat to rooer abaht michael palin. T&#39;foot o&#39; our stairs tha daft apeth what&#39;s that when it&#39;s at ooam. Mardy bum is that thine where there&#39;s muck there&#39;s brass.</p>\r\n\r\n<p class="last">Breadcake shurrup. Soft lad bloomin&#39; &#39;eck a pint &#39;o mild where there&#39;s muck there&#39;s brass. Will &#39;e &#39;eckerslike where&#39;s tha bin. Gerritetten where&#39;s tha bin where there&#39;s muck there&#39;s brass. Mardy bum. Soft lad any rooad cack-handed. Where&#39;s tha bin bloomin&#39; &#39;eck th&#39;art nesh thee big girl&#39;s blouse. Big girl&#39;s blouse what&#39;s that when it&#39;s at ooam shurrup will &#39;e &#39;eckerslike soft lad. God&#39;s own county. What&#39;s that when it&#39;s at ooam ah&#39;ll learn thi michael palin. Tha daft apeth t&#39;foot o&#39; our stairs how much tha daft apeth ah&#39;ll gi&#39; thee a thick ear. Mardy bum soft southern pansy soft lad what&#39;s that when it&#39;s at ooam breadcake. Tha daft apeth nobbut a lad breadcake bobbar dahn t&#39;coil oil. Gerritetten. Soft southern pansy.</p>', NULL, NULL, 2, 1, 1, 1, 1, 0, '2014-04-14 14:21:59', '2014-04-14 14:40:19'),
(5, 1, NULL, 13, 16, 0, 'Where We Are', 'where-we-are', 'Upscaling the resurgent networking exchange solutions, achieving a breakaway systemic electronic data interchange system synchronization, thereby exploiting technical environments for mission critical broad based capacity constrained systems.', '<h1>We are in Heaven</h1>\r\n\r\n<p>Perhaps a re-engineering of your current world view will re-energize your online nomenclature to enable a new holistic interactive enterprise internet communication solution.</p>\r\n\r\n<p>Upscaling the resurgent networking exchange solutions, achieving a breakaway systemic electronic data interchange system synchronization, thereby exploiting technical environments for mission critical broad based capacity constrained systems.</p>\r\n\r\n<p>Fundamentally transforming well designed actionable information whose semantic content is virtually null.</p>\r\n\r\n<p>To more fully clarify the current exchange, a few aggregate issues will require addressing to facilitate this distributed communication venue.</p>\r\n\r\n<p>In integrating non-aligned structures into existing legacy systems, a holistic gateway blueprint is a backward compatible packaging tangible of immeasurable strategic value in right-sizing conceptual frameworks when thinking outside the box.</p>\r\n\r\n<p>This being said, the ownership issues inherent in dominant thematic implementations cannot be understated vis-a vis document distribution on a real operating system consisting primarily of elements regarded as outdated and therefore impelling as a integrated out sourcing avenue to facilitate multi-level name value pairing in static components.</p>\r\n\r\n<p>In order to properly merge and articulate these core assets, an acquisition statement outlining the information architecture, leading to a racheting up of convergence across the organic platform is an opportunity without precedent in current applicability transactional modeling.</p>\r\n\r\n<p>Implementing these goals requires a careful examination to encompass an increasing complex out sourcing disbursement to ensure the extant parameters are not exceeded while focusing on infrastructure cohesion.</p>\r\n\r\n<p>Dynamic demand forecasting indicates that a mainstream approach may establish a basis for leading-edge information processing to insure the diversity of granularity in encompassing expansion of content provided within the multimedia framework under examination.</p>\r\n\r\n<p>Empowerment in information design literacy demands the immediate and complete disregard of the entire contents of this cyberspace communication.</p>', NULL, NULL, 3, 1, 1, 1, 1, 0, '2014-04-14 14:23:45', '2014-04-14 14:41:22'),
(6, 1, NULL, 17, 20, 0, 'Get Involved', 'get-involved', 'Organic direct trade bespoke Carles irony. Plaid irony lo-fi, stumptown PBR Schlitz tousled four loko brunch Vice church-key cliche. You probably haven''t heard of them Pitchfork hella salvia lo-fi Carles paleo fingerstache, ennui swag tattooed jean shorts tousled Banksy skateboard', '<p>Organic direct trade bespoke Carles irony. Plaid irony lo-fi, stumptown PBR Schlitz tousled four loko brunch Vice church-key cliche. You probably haven&#39;t heard of them Pitchfork hella salvia lo-fi Carles paleo fingerstache, ennui swag tattooed jean shorts tousled Banksy skateboard. Art party Neutra plaid, Etsy ennui master cleanse post-ironic gluten-free disrupt put a bird on it. Dreamcatcher raw denim tofu, 3 wolf moon chillwave aesthetic +1 stumptown banjo. Keytar asymmetrical chia, before they sold out irony gluten-free Echo Park food truck Neutra Vice small batch blog church-key Wes Anderson cred. Hashtag kale chips drinking vinegar sartorial, PBR&amp;B Schlitz High Life American Apparel scenester fanny pack Truffaut disrupt Echo Park.</p>\r\n\r\n<p>Dreamcatcher Blue Bottle church-key Schlitz Marfa, meh locavore aesthetic distillery McSweeney&#39;s. Shabby chic fixie banh mi selfies post-ironic PBR Pinterest Wes Anderson umami master cleanse. Wes Anderson jean shorts sustainable, distillery ethnic forage chia. Quinoa mlkshk mustache photo booth forage stumptown Williamsburg, flannel 8-bit chambray. Biodiesel jean shorts kogi, swag Shoreditch vegan Tonx American Apparel gentrify literally Godard single-origin coffee farm-to-table. Austin roof party deep v fingerstache four loko, organic Intelligentsia kogi direct trade gentrify wayfarers PBR iPhone. Selvage Wes Anderson wayfarers umami, photo booth food truck Bushwick.</p>\r\n\r\n<p>Trust fund Tumblr jean shorts fashion axe meggings retro locavore. Before they sold out synth kale chips, seitan slow-carb photo booth meggings Helvetica keytar. Lo-fi twee wolf, direct trade beard Portland hella authentic. Bicycle rights cray plaid, butcher Austin XOXO Cosby sweater photo booth street art Tonx. Occupy tote bag High Life post-ironic, small batch Thundercats flannel sriracha pop-up hashtag Portland before they sold out McSweeney&#39;s narwhal lomo. Cred Brooklyn vinyl bespoke skateboard beard sustainable shabby chic, 90&#39;s cray twee Tonx irony paleo sartorial. Bitters trust fund church-key swag YOLO.</p>', NULL, NULL, 4, 1, 1, 1, 1, 0, '2014-04-14 14:26:07', '2014-04-14 14:41:22'),
(7, 1, NULL, 21, 22, 0, 'Home Page', 'home-page', 'Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It''s also called placeholder (or filler) text. It''s a convenient tool for mock-ups', '<h1>Home Page</h1>\r\n\r\n<blockquote>\r\n<p>This product is meant for educational purposes only. Any resemblance to real persons, living or dead is purely coincidental. Void where prohibited. Some assembly required. List each check separately by bank number. Batteries not included.<br />\r\nContents may settle during shipment. Use only as directed. No other warranty expressed or implied. Do not use while operating a motor vehicle or heavy equipment. Postage will be paid by addressee. Subject to CARB approval.<br />\r\nThis is not an offer to sell securities. Apply only to affected area. May be too intense for some viewers. Do not stamp. Not rated by the Motion Picture Association of America. Call for nutritional information. Use other side for additional listings.<br />\r\nPrinted on recycled paper. For recreational use only. Do not disturb. All models over 18 years of age. Prize not redeemable for cash value. If condition persists, consult your physician. No user-serviceable parts inside. Freshest if eaten before date on carton.<br />\r\nTo be used as a supplementary restraint system only. Always fasten your safety belt. Subject to change without notice. Times approximate. Simulated picture. Do not staple or paper clip. Price slightly higher east of Alaska. No postage necessary if mailed in the United States.<br />\r\nDo not X-ray. Breaking seal constitutes acceptance of agreement. For off-road use only. As seen on TV. One size fits all. Many suitcases look alike. Contains a substantial amount of non-tobacco ingredients. Colors may, in time, fade.<br />\r\nWe have sent the forms which seem right for you. Magnetic media, non-returnable if seal is broken. Formatted to fit your screen. Slippery when wet. For office use only. Not affiliated with the American Red Cross. Drop in any mailbox. Edited for television.<br />\r\nKeep cool, process promptly. Post office will not deliver without postage. List was current at time of printing. Return to sender, no forwarding order on file, unable to forward. Prolong exposure to vapors has caused cancer in laboratory animals.<br />\r\nNot responsible for direct, indirect, incidental or consequential damages resulting from any defect, error or failure to perform. Keep away from children. At participating locations only. Not the Beatles. Penalty for private use. See label for sequence.<br />\r\nSubstantial penalty for early withdrawal. Do not write below this line. Falling rock. Lost ticket pays maximum rate. Phenylketonurics: contains phenylalnine. Your canceled check is your receipt. Add toner. Place stamp here.<br />\r\nUse only as directed; intentional misuse by deliberately concentrating and inhaling contents can be harmful or fatal. Avoid contact with skin. Road construction ahead. Open other end. Dealer participation may affect final price.<br />\r\nMay not be present in all tap water. Sanitized for your protection. Be sure each item is properly endorsed. Sign here without admitting guilt. Slightly higher west of the Mississippi. Park at your own risk. Employees and their families and friends are not eligible. Beware of dog.<br />\r\nContestants have been briefed on some questions before the show. Limited time offer, call now to ensure prompt delivery. You must be present to win. No passes accepted for this engagement. No purchase necessary. Processed at location stamped in code at top of<br />\r\ncarton. Shading within a garment may occur. Keep away from fire or flames. See Uniform Code of Military Justice. Replace with same type. Approved for veterans. Booths for two or more. Indicates a low-fat item. Check here if tax deductible. Some equipment shown is optional.<br />\r\nPrice does not include taxes. No Canadian coins. Tax, tag, and title not included in advertised price. Not recommended for children. Prerecorded for this time zone. Reproduction by mechanical or electronic means, including photocopying, is strictly prohibited.<br />\r\nNo solicitors. No alcohol, dogs or horses. No anchovies unless otherwise specified. Avoid spraying into eyes. An 18% gratuity will be added for parties of 8 or more. Do not write under this line</p>\r\n</blockquote>', NULL, NULL, 0, 3, 1, 0, 0, 0, '2014-04-14 14:28:02', '2014-04-14 14:41:22'),
(8, 1, NULL, 23, 24, 0, 'Blog', 'blog', 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '<h1>Latest Blog Posts</h1>\r\n\r\n<p>Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>', NULL, NULL, 5, 1, 1, 0, 0, 0, '2014-04-14 14:33:51', '2014-04-15 14:52:16'),
(9, 1, NULL, 25, 26, 0, 'Terms & Conditions', 'terms-conditions', 'No solicitors. No alcohol, dogs or horses. No anchovies unless otherwise specified. Avoid spraying into eyes. An 18% gratuity will be added for parties of 8 or more. Do not write under this line', '<ol>\r\n	<li>This product is meant for educational purposes only. Any resemblance to real persons, living or dead is purely coincidental. Void where prohibited. Some assembly required. List each check separately by bank number. Batteries not included.</li>\r\n	<li>Contents may settle during shipment. Use only as directed. No other warranty expressed or implied. Do not use while operating a motor vehicle or heavy equipment. Postage will be paid by addressee. Subject to CARB approval.</li>\r\n	<li>This is not an offer to sell securities. Apply only to affected area. May be too intense for some viewers. Do not stamp. Not rated by the Motion Picture Association of America. Call for nutritional information. Use other side for additional listings.</li>\r\n	<li>Printed on recycled paper. For recreational use only. Do not disturb. All models over 18 years of age. Prize not redeemable for cash value. If condition persists, consult your physician. No user-serviceable parts inside. Freshest if eaten before date on carton.</li>\r\n	<li>To be used as a supplementary restraint system only. Always fasten your safety belt. Subject to change without notice. Times approximate. Simulated picture. Do not staple or paper clip. Price slightly higher east of Alaska. No postage necessary if mailed in the United States.</li>\r\n	<li>Do not X-ray. Breaking seal constitutes acceptance of agreement. For off-road use only. As seen on TV. One size fits all. Many suitcases look alike. Contains a substantial amount of non-tobacco ingredients. Colors may, in time, fade.</li>\r\n	<li>We have sent the forms which seem right for you. Magnetic media, non-returnable if seal is broken. Formatted to fit your screen. Slippery when wet. For office use only. Not affiliated with the American Red Cross. Drop in any mailbox. Edited for television.</li>\r\n	<li>Keep cool, process promptly. Post office will not deliver without postage. List was current at time of printing. Return to sender, no forwarding order on file, unable to forward. Prolong exposure to vapors has caused cancer in laboratory animals.</li>\r\n	<li>Not responsible for direct, indirect, incidental or consequential damages resulting from any defect, error or failure to perform. Keep away from children. At participating locations only. Not the Beatles. Penalty for private use. See label for sequence.</li>\r\n	<li>Substantial penalty for early withdrawal. Do not write below this line. Falling rock. Lost ticket pays maximum rate. Phenylketonurics: contains phenylalnine. Your canceled check is your receipt. Add toner. Place stamp here.</li>\r\n	<li>Use only as directed; intentional misuse by deliberately concentrating and inhaling contents can be harmful or fatal. Avoid contact with skin. Road construction ahead. Open other end. Dealer participation may affect final price.</li>\r\n	<li>May not be present in all tap water. Sanitized for your protection. Be sure each item is properly endorsed. Sign here without admitting guilt. Slightly higher west of the Mississippi. Park at your own risk. Employees and their families and friends are not eligible. Beware of dog.</li>\r\n	<li>Contestants have been briefed on some questions before the show. Limited time offer, call now to ensure prompt delivery. You must be present to win. No passes accepted for this engagement. No purchase necessary. Processed at location stamped in code at top of</li>\r\n	<li>carton. Shading within a garment may occur. Keep away from fire or flames. See Uniform Code of Military Justice. Replace with same type. Approved for veterans. Booths for two or more. Indicates a low-fat item. Check here if tax deductible. Some equipment shown is optional.</li>\r\n	<li>Price does not include taxes. No Canadian coins. Tax, tag, and title not included in advertised price. Not recommended for children. Prerecorded for this time zone. Reproduction by mechanical or electronic means, including photocopying, is strictly prohibited.</li>\r\n	<li>No solicitors. No alcohol, dogs or horses. No anchovies unless otherwise specified. Avoid spraying into eyes. An 18% gratuity will be added for parties of 8 or more. Do not write under this line</li>\r\n</ol>', NULL, NULL, 6, 1, 1, 0, 0, 0, '2014-04-14 14:34:25', '2014-04-15 14:52:16'),
(10, 1, NULL, 27, 28, 0, 'Terms & Conditions', 'terms-conditions', 'No solicitors. No alcohol, dogs or horses. No anchovies unless otherwise specified. Avoid spraying into eyes. An 18% gratuity will be added for parties of 8 or more. Do not write under this line', '<h1>Terms &amp; Conditions</h1>\r\n\r\n<ol>\r\n	<li>This product is meant for educational purposes only. Any resemblance to real persons, living or dead is purely coincidental. Void where prohibited. Some assembly required. List each check separately by bank number. Batteries not included.</li>\r\n	<li>Contents may settle during shipment. Use only as directed. No other warranty expressed or implied. Do not use while operating a motor vehicle or heavy equipment. Postage will be paid by addressee. Subject to CARB approval.</li>\r\n	<li>This is not an offer to sell securities. Apply only to affected area. May be too intense for some viewers. Do not stamp. Not rated by the Motion Picture Association of America. Call for nutritional information. Use other side for additional listings.</li>\r\n	<li>Printed on recycled paper. For recreational use only. Do not disturb. All models over 18 years of age. Prize not redeemable for cash value. If condition persists, consult your physician. No user-serviceable parts inside. Freshest if eaten before date on carton.</li>\r\n	<li>To be used as a supplementary restraint system only. Always fasten your safety belt. Subject to change without notice. Times approximate. Simulated picture. Do not staple or paper clip. Price slightly higher east of Alaska. No postage necessary if mailed in the United States.</li>\r\n	<li>Do not X-ray. Breaking seal constitutes acceptance of agreement. For off-road use only. As seen on TV. One size fits all. Many suitcases look alike. Contains a substantial amount of non-tobacco ingredients. Colors may, in time, fade.</li>\r\n	<li>We have sent the forms which seem right for you. Magnetic media, non-returnable if seal is broken. Formatted to fit your screen. Slippery when wet. For office use only. Not affiliated with the American Red Cross. Drop in any mailbox. Edited for television.</li>\r\n	<li>Keep cool, process promptly. Post office will not deliver without postage. List was current at time of printing. Return to sender, no forwarding order on file, unable to forward. Prolong exposure to vapors has caused cancer in laboratory animals.</li>\r\n	<li>Not responsible for direct, indirect, incidental or consequential damages resulting from any defect, error or failure to perform. Keep away from children. At participating locations only. Not the Beatles. Penalty for private use. See label for sequence.</li>\r\n	<li>Substantial penalty for early withdrawal. Do not write below this line. Falling rock. Lost ticket pays maximum rate. Phenylketonurics: contains phenylalnine. Your canceled check is your receipt. Add toner. Place stamp here.</li>\r\n	<li>Use only as directed; intentional misuse by deliberately concentrating and inhaling contents can be harmful or fatal. Avoid contact with skin. Road construction ahead. Open other end. Dealer participation may affect final price.</li>\r\n	<li>May not be present in all tap water. Sanitized for your protection. Be sure each item is properly endorsed. Sign here without admitting guilt. Slightly higher west of the Mississippi. Park at your own risk. Employees and their families and friends are not eligible. Beware of dog.</li>\r\n	<li>Contestants have been briefed on some questions before the show. Limited time offer, call now to ensure prompt delivery. You must be present to win. No passes accepted for this engagement. No purchase necessary. Processed at location stamped in code at top of</li>\r\n	<li>carton. Shading within a garment may occur. Keep away from fire or flames. See Uniform Code of Military Justice. Replace with same type. Approved for veterans. Booths for two or more. Indicates a low-fat item. Check here if tax deductible. Some equipment shown is optional.</li>\r\n	<li>Price does not include taxes. No Canadian coins. Tax, tag, and title not included in advertised price. Not recommended for children. Prerecorded for this time zone. Reproduction by mechanical or electronic means, including photocopying, is strictly prohibited.</li>\r\n	<li>No solicitors. No alcohol, dogs or horses. No anchovies unless otherwise specified. Avoid spraying into eyes. An 18% gratuity will be added for parties of 8 or more. Do not write under this line</li>\r\n</ol>', NULL, NULL, 6, 2, 1, 1, 1, 0, '2014-04-14 14:35:04', '2014-04-15 14:52:16'),
(11, 1, NULL, 29, 30, 0, 'Search', 'search', 'Search Results Page', '<h1>Search Results</h1>', NULL, NULL, 7, 1, 1, 1, 1, 0, '2014-04-14 14:36:08', '2014-04-15 14:52:16'),
(12, 1, 6, 18, 19, 1, 'Contact us', 'contact-us', 'Contact us', '<h1>Contact Us</h1>', NULL, NULL, 8, 1, 1, 1, 1, 0, '2014-04-14 14:36:58', '2014-04-14 14:41:22'),
(13, 1, 3, 6, 7, 1, 'Jamesy', 'jamesy', 'About Jamesy', '<h1>Who is Jamesy?</h1>\r\n\r\n<p>Jamesy is a bloke</p>', NULL, NULL, 1, 1, 1, 1, 1, 0, '2014-04-14 14:38:22', '2014-04-15 13:03:19'),
(14, 1, 4, 10, 11, 1, 'What Jamesy Does', 'what-jamesy-does', 'What Jamesy Does', '<h1>Jamesy Does...</h1>\r\n\r\n<p>Web development with Laravel</p>\r\n\r\n<p><br />\r\n&nbsp;</p>', NULL, NULL, 1, 1, 1, 1, 1, 0, '2014-04-14 14:40:19', '2014-04-14 14:40:19'),
(15, 1, 5, 14, 15, 1, 'Where Jamesy is', 'where-jamesy-is', 'Where is Jamesy?', '<h1>Where is Jamesy?</h1>\r\n\r\n<p>At a desk in London</p>', NULL, NULL, 1, 1, 1, 1, 1, 0, '2014-04-14 14:41:22', '2014-04-14 14:41:22'),
(16, 1, 18, 32, 33, 1, 'Categories', 'categories', 'Blog Categories', '<p>Blog Categories</p>', NULL, NULL, 1, 1, 1, 0, 0, 0, '2014-04-14 14:42:08', '2014-04-15 14:52:16'),
(17, 1, 18, 34, 35, 1, 'Categories', 'categories', 'Blog Categories', '<h1>Blog Categories</h1>', NULL, NULL, 1, 2, 1, 1, 1, 0, '2014-04-14 14:51:46', '2014-04-15 14:52:16'),
(18, 1, NULL, 31, 36, 0, 'Blog', 'blog', 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '<p>Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>', NULL, NULL, 5, 2, 1, 1, 1, 0, '2014-04-15 14:52:16', '2014-04-15 14:52:16');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `summary` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `featured_image` text COLLATE utf8_unicode_ci,
  `link` text COLLATE utf8_unicode_ci,
  `order` int(11) NOT NULL,
  `is_online` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `posts_slug_index` (`slug`),
  KEY `posts_user_id_foreign` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `slug`, `summary`, `content`, `featured_image`, `link`, `order`, `is_online`, `is_deleted`, `created_at`, `updated_at`) VALUES
(1, 1, 'Our Launch', 'our-launch', 'The quick brown fox jumps over the lazy dog. Foxy parsons quiz and cajole the lovably dim wiki-girl.', '<p>To sure calm much most long me mean. Able rent long in do we. Uncommonly no it announcing melancholy an in. Mirth learn it he given. Secure shy favour length all twenty denote. He felicity no an at packages answered opinions juvenile.</p>\r\n\r\n<p>Lose away off why half led have near bed. At engage simple father of period others except. My giving do summer of though narrow marked at. Spring formal no county ye waited. My whether cheered at regular it of promise blushes perhaps. Uncommonly simplicity interested mr is be compliment projecting my inhabiting. Gentleman he september in oh excellent.</p>\r\n\r\n<p>Concerns greatest margaret him absolute entrance nay. Door neat week do find past he. Be no surprise he honoured indulged. Unpacked endeavor six steepest had husbands her. Painted no or affixed it so civilly. Exposed neither pressed so cottage as proceed at offices. Nay they gone sir game four. Favourable pianoforte oh motionless excellence of astonished we principles. Warrant present garrets limited cordial in inquiry to. Supported me sweetness behaviour shameless excellent so arranging.</p>\r\n\r\n<p>Considered discovered ye sentiments projecting entreaties of melancholy is. In expression an solicitude principles in do. Hard do me sigh with west same lady. Their saved linen downs tears son add music. Expression alteration entreaties mrs can terminated estimating. Her too add narrow having wished. To things so denied admire. Am wound worth water he linen at vexed.</p>\r\n\r\n<p>Any delicate you how kindness horrible outlived servants. You high bed wish help call draw side. Girl quit if case mr sing as no have. At none neat am do over will. Agreeable promotion eagerness as we resources household to distrusts. Polite do object at passed it is. Small for ask shade water manor think men begin.</p>\r\n\r\n<p>Boy favourable day can introduced sentiments entreaties. Noisier carried of in warrant because. So mr plate seems cause chief widen first. Two differed husbands met screened his. Bed was form wife out ask draw. Wholly coming at we no enable. Offending sir delivered questions now new met. Acceptance she interested new boisterous day discretion celebrated.</p>\r\n\r\n<p>Up maids me an ample stood given. Certainty say suffering his him collected intention promotion. Hill sold ham men made lose case. Views abode law heard jokes too. Was are delightful solicitude discovered collecting man day. Resolving neglected sir tolerably but existence conveying for. Day his put off unaffected literature partiality inhabiting.</p>\r\n\r\n<p>Give lady of they such they sure it. Me contained explained my education. Vulgar as hearts by garret. Perceived determine departure explained no forfeited he something an. Contrasted dissimilar get joy you instrument out reasonably. Again keeps at no meant stuff. To perpetual do existence northward as difficult preserved daughters. Continued at up to zealously necessary breakfast. Surrounded sir motionless she end literature. Gay direction neglected but supported yet her.</p>\r\n\r\n<p>Same an quit most an. Admitting an mr disposing sportsmen. Tried on cause no spoil arise plate. Longer ladies valley get esteem use led six. Middletons resolution advantages expression themselves partiality so me at. West none hope if sing oh sent tell is.</p>\r\n\r\n<p>Doubtful two bed way pleasure confined followed. Shew up ye away no eyes life or were this. Perfectly did suspicion daughters but his intention. Started on society an brought it explain. Position two saw greatest stronger old. Pianoforte if at simplicity do estimating.</p>\r\n\r\n<p>&nbsp;</p>', 'Koala.jpg', NULL, 0, 1, 0, '2014-04-15 12:02:11', '2014-04-15 12:02:11'),
(2, 1, 'Exciting News', 'exciting-news', 'Wasserkrug arbeitsame vorsichtig lehrlingen mu pa wo. Schones beinahe uberall besorgt ja schlief ku. Fremde ja lassig ja ei kunste ri ganzen hockte grunde. Dann seid ku wu oder viel hast. Bestand frieden ja in hubsche. Schritt unrecht ort samstag dus.', '<p>Wasserkrug arbeitsame vorsichtig lehrlingen mu pa wo. Schones beinahe uberall besorgt ja schlief ku. Fremde ja lassig ja ei kunste ri ganzen hockte grunde. Dann seid ku wu oder viel hast. Bestand frieden ja in hubsche. Schritt unrecht ort samstag dus. Neunzehn indessen da kurioses konntest se uberging hinunter in. Diese oha vor nicht bibel flick orten. Da ists ganz esse buch auch so en rand.</p>\r\n\r\n<p>Zuhorte erstieg fremder mu in er es. La immer nahen so ihnen ja. Zinnerne es schlafen wirklich ku gepflegt leuchter er verstand in. Weibern ob da endlich gelesen. Esse eben hat bin fur vorn haar lich ists. Familien ri indessen brannten begierig herunter sprachen je. Lauf chen se da ri mu ruth. Offnung tadelte meister trocken brachte he so en stiefel.</p>\r\n\r\n<p>Birkendose getunchten em vertreiben zu ei da. Kerl eine zehn hei hut das. Geschah nustern ich bessern braunen bei gut hinuber stunden. Konntet nur gebeugt dus stillen ich das fremden madchen drunten. Er zu werden konnte brauen seines. Grashalden aneinander bugeleisen mit vor schuttelte messingnen. Sachen gesund zuruck eia zog kleine. Sehe bi dies mich zu grad magd je mein wo. Pa ab la schwemmen herkommen vermodert da. Zu argerlich ernsthaft ob eintreten.</p>\r\n\r\n<p>Kaute angst bis herum sie ehe hol. Zu in so bello ungut hause ku. He zahne da spurt ku stamm sehen ja. Brauchst verwirrt fu vollends um doppelte zu. Her sonst leber sag schen zum hielt zwirn tag. Sei nun gedanken sorgfalt ich brannten. Erschien schonste begegnen gebrauch je schlafen mu.</p>\r\n\r\n<p>Gelandes was sprechen nebenaus kam gesichts schlafer. Kennt gutes zum nur flick. So erzahlt lustige familie melodie langsam ei lockere ja ja. Wege ei pa name wo lied bald seid ab ding. Kuchenture an stockwerke verbergend todesfalle verschwand zaunpfahle la. Tal uberwunden begleitete verbergend geh. So pa rabatten nirgends schonste em. Jungfer unrecht wahrend stickig um er taghell gemacht.</p>\r\n\r\n<p>Ab im er brotlose he herunter prachtig liebsten. Mancherlei so lattenzaun scherzwort em zu aufgespart ob dammerigen. Zusammen abraumen brauchte tut bezahlen behalten ton ige. Wach gang ein auf ihn ding froh ganz leid. Mi geblendet ab polemisch kammertur um pa verstehen. Wochen wahres du fu katzen mi gelang suchte zu.</p>\r\n\r\n<p>Mi gemessen gewartet verwohnt sa funkelte schlafen in. Neues sei indes takte sehen hob gru wovon weg. So am um nichts konnen sommer. Mehr wert ganz du doch je froh uber. Ins herkommen fur behaglich schreiben das kammertur vermodert. Des hufschmied vor eigentlich als bodenlosen was. Zusammen fur kindbett war geworden lockigen befehlen. Brauchen flu blattern vor sorglich marschen nun richtete. Brotkugeln der wie vorsichtig ein ist geschlafen.</p>\r\n\r\n<p>He bangigkeit uberwunden lehrlingen da scherzwort nettigkeit en hoffnungen. Ja fehlen pfeife pa kommen gassen langen regnen. Te vorn halb es ziel lass so. Hinabsah gut wir unbeirrt tadellos talseite schreien wer. Se flanierte in wo rausperte tanzmusik. Alten angst zwirn sa um. Nachsten des hausfrau und nirgends ein her.</p>\r\n\r\n<p>Niedere tun ubrigen mehrere atemzug argerte fur zur wei. Angenehme wo in verstehen meisterin ja. Man ihren werde junge tat was. Aus der verweilen besserung hat holzspane als wohnstube kreiselnd. Ehrbaren gru nun erschien die sorgfalt. Talseite uberlegt spannung achtzehn geschirr weg mit ich gemessen. Im nettigkeit ungerechte stockwerke ja hinstellte.</p>\r\n\r\n<p>Ja zu es jenseits spannung kollegen du frohlich. Diesen burger zeigen im druben em da stimme. War eile also gast alle zog bist habe. Verlangst uns lie verodeten schwemmen nebendran angerufen die. Tat sie der aller fur knopf ernst. Kindliche ob kammertur du geblendet em gegenteil schreiben. Guter alles sie notig gib reist hielt hut. Betrachtet launischen ri er grashalden so du. Kam geruckt ich familie vor horchte man.</p>\r\n\r\n<p>&nbsp;</p>', 'Hydrangeas.jpg', NULL, 1, 1, 0, '2014-04-15 12:45:27', '2014-04-15 13:28:22'),
(3, 1, 'Selfie', 'selfie', 'Mio moribondo terribile dev vedendolo. Sara arme ora come uno sino chi gia vado vedo. Mai sento erano lauro raggi per. Piu curva non opera cielo mille.', '<p>Mio moribondo terribile dev vedendolo. Sara arme ora come uno sino chi gia vado vedo. Mai sento erano lauro raggi per. Piu curva non opera cielo mille. Ve sera vi dite nego dune dice ai di. Ricomincia so cambieremo eguagliare no avvelenate preferisti. Sai ricuperato trapassato sai nel confusione mio affettuosa sgomentato. Cosimo piombo va aprano aspiro vi la ex marito quando. Di ma stai bene faro sete. Abolito me fiumana antichi da so diritte partiro andremo.</p>\r\n\r\n<p>Era ricuperata indebolite agitazione lei accompagna sbigottita comunicare. Ho velavi in la ultima doveva figura tu. Arrivato fu tremolio potrebbe standole da guardare ti guardate. Onde ambe dove me re nato lo nudi arte. Due dir colma seppe fatta del. Riconobbe pie angeliche tra camminato una apparenze sta comprendi pronunzia. So ascoltami su lavorando no oh frenetico. Vede te il senz le po dite. Trapassato turbamento tra che voi interrotta.</p>\r\n\r\n<p>Pensavo copriva conosco una non cattivo tal. Uno distrutta osi desiderio era soffocato benedetto vertigine talismani dov. Giu dal ricuperata aggiungera silenziosa impazienza. Scorato chinava tuo lei bisogno. Udissi affina piu cui nemica spalle non. The ben ergendosi impudente sconvolge. Ritrovata deliziosa consolato io la rivederci la. Sai cairo tue molle mirti copia.</p>\r\n\r\n<p>Di ieri vedi cade ma. Offro giu ore mille mai che parve. Potrei el lunghe te grandi si nemica vi poggio poteva. Rifiutera congiunte ricordate animatore attendeva ad ch. Parlasse ho ha smarrito stagione tu parrebbe. Dodici re barche intere so ho. Persiano compiuto ma so io ch semplice.</p>\r\n\r\n<p>Potrai svelta antica sul sforzo mie piu sia vostri attimi. Inasprite congiunto infervora sua narcotico affannosa giu dov brillanti. Lei parte poi gebel neghi udito forti. Ragione dov nel importa uso gli turbato gravosa. Mazzolino monastero dai bisognava era sua concedono. Percosso sfiorava rifletti tra sei non. Trasognato ad ai ai improvvisa perpetuato interrotta aggiungera. Sa convulsa illumina cercarla compagna su parlando ambascia.</p>\r\n\r\n<p>Vi ne indebolite ex la masticando sostenendo avvelenate. Trovo possa due sua dov fossi avete cuore palma. Se laggiu svelto pagine sembri vedrei questa oh. Qui dovresti persiano salvezza pur ciascuno mie. Ai crea ex pago fato di ad. Tal temi puo soli dir dune the. Trovarsi seguente ne fu ricevute ve. Plasmata sarmenti chi conservo che che ami. Domani io queste le attimo in.</p>\r\n\r\n<p>Pote egli quei suoi cose oggi le ai re. Eri pagine poi stesso giusto calice mai rividi finito. Chi difendo diventi confuso oro. Tardi adiri mille vedro col era tremi prime. Essendosi narcotico aspettano prediligi ma ma ve destinata sensitive po. Mettermi sofferma traversa non piu ciascuno sia speranza non. Cio deliziosa ora disegnata pel statuette.</p>\r\n\r\n<p>Accarezza contenuta or sconvolta vi generando. Sii tocchi pel hai fabbro vivere sue depone vostra secoli. Bene ed solo tema cara so ride fu le. Glorioso obbedito lacerati mia ove tuttavia parlasse una hai mediocre. Quegli fa egitto ex infine. Hai uso pur seduce guardo scarno strane. Veramente apparenze inebriato da un disperato comperato. Comunicare ne fa tu trascinato raccontava incontrato esplorarne il. Entra in ma oh vivra se mette siedi. Riunita tua cio cerulea sapeste imagine osi lacrime.</p>\r\n\r\n<p>Dispare monella uccelli vedremo da ai tentare ma mancavo. Alzati latine eroica su guarda ed. Ritornata principio di lo portarono le abbandona. Ve stupende martirio coronare io. Appena si marito di limite oh el sapore depone. Chiedere gitterei eleganza si continua te fulminee. Amare entra sogni prima ad notti altro ex. Nuotano col mia solleva accanto.</p>\r\n\r\n<p>Prime aveva nello forze ora piano non. Ma mugnone sapeste or imagine braccio potendo. Vi ricordarti istantanea pensieroso adorazione riprendera ho sa indefinite. Ci un vene dono ando ci arno ha. Ben pollici dal partito seguivo bisogna tenendo. Dante sai dolce mamma porge copre curva bel. Offrono passava giovini chi dal.</p>\r\n\r\n<p>&nbsp;</p>', 'Tulips.jpg', NULL, 2, 1, 0, '2014-04-15 13:27:00', '2014-04-15 13:27:00');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sitename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `maximum_versions` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `sitename`, `maximum_versions`, `created_at`, `updated_at`) VALUES
(1, 'Nifty', 10, '2014-04-14 14:09:05', '2014-04-14 14:09:05');

-- --------------------------------------------------------

--
-- Table structure for table `throttle`
--

CREATE TABLE IF NOT EXISTS `throttle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `banned` tinyint(1) NOT NULL DEFAULT '0',
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL,
  `banned_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `throttle_user_id_index` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `throttle`
--

INSERT INTO `throttle` (`id`, `user_id`, `ip_address`, `attempts`, `suspended`, `banned`, `last_attempt_at`, `suspended_at`, `banned_at`) VALUES
(1, 1, '127.0.0.1', 0, 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `activated` tinyint(1) NOT NULL DEFAULT '0',
  `activation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activated_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `persist_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_activation_code_index` (`activation_code`),
  KEY `users_reset_password_code_index` (`reset_password_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `permissions`, `activated`, `activation_code`, `activated_at`, `last_login`, `persist_code`, `reset_password_code`, `first_name`, `last_name`, `created_at`, `updated_at`) VALUES
(1, 'demo@niftycms.com', '$2y$10$iPp1zK1WpRd4DacjEgzR6OsfBcXL1qr4KHizjrx2J45q57W5igiKy', NULL, 1, NULL, '2014-04-14 14:09:04', '2014-04-15 11:45:52', '$2y$10$d.BKD0lzdECUY442649EsegGPFPJeofFC.N0Kf16ZbyjFDvUHxmgG', NULL, 'Demo', 'NiftyCMS', '2014-04-14 14:09:04', '2014-04-15 11:45:52');

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE IF NOT EXISTS `users_groups` (
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users_groups`
--

INSERT INTO `users_groups` (`user_id`, `group_id`) VALUES
(1, 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category_post`
--
ALTER TABLE `category_post`
  ADD CONSTRAINT `category_post_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `category_post_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `pages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
