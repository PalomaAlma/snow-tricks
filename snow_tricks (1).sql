-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 03 jan. 2023 à 19:59
-- Version du serveur :  5.7.31
-- Version de PHP : 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `snow_tricks`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20220511184744', '2022-05-11 18:47:56', 153),
('DoctrineMigrations\\Version20220511185251', '2022-05-11 18:52:57', 50),
('DoctrineMigrations\\Version20220516112323', '2022-05-16 11:23:28', 46),
('DoctrineMigrations\\Version20220516112700', '2022-05-16 11:27:07', 49),
('DoctrineMigrations\\Version20220516132857', '2022-05-16 13:29:04', 54),
('DoctrineMigrations\\Version20220516132951', '2022-05-16 13:29:59', 55),
('DoctrineMigrations\\Version20220516140804', '2022-05-16 14:08:13', 48),
('DoctrineMigrations\\Version20220518112856', '2022-05-18 11:29:00', 82),
('DoctrineMigrations\\Version20220518113348', '2022-05-18 11:33:55', 318),
('DoctrineMigrations\\Version20220525125203', '2022-05-25 12:52:11', 205),
('DoctrineMigrations\\Version20220607162255', '2022-06-07 16:23:00', 169),
('DoctrineMigrations\\Version20220607162844', '2022-06-07 16:28:46', 59),
('DoctrineMigrations\\Version20220705095957', '2022-07-05 10:00:03', 195),
('DoctrineMigrations\\Version20220705115325', '2022-07-05 11:53:34', 83),
('DoctrineMigrations\\Version20220706084107', '2022-07-06 08:41:15', 209),
('DoctrineMigrations\\Version20220816104449', '2022-08-16 10:45:02', 209);

-- --------------------------------------------------------

--
-- Structure de la table `group`
--

DROP TABLE IF EXISTS `group`;
CREATE TABLE IF NOT EXISTS `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `group`
--

INSERT INTO `group` (`id`, `name`, `description`) VALUES
(1, 'Ski', 'Figure de Ski'),
(2, 'SnowBoard', 'Figure de SnowBoard');

-- --------------------------------------------------------

--
-- Structure de la table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trick_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6A2CA10CB281BE2E` (`trick_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `media`
--

INSERT INTO `media` (`id`, `name`, `type`, `trick_id`) VALUES
(16, '62c5590fb6fbc.jpeg', NULL, 20),
(18, '62c5590fb7792.jpeg', NULL, 20),
(27, '62cc21df8d8df.jpeg', NULL, 23),
(28, '62cc21df8dbca.jpeg', NULL, 23),
(29, '62cc21df8dd40.webp', NULL, 23),
(35, '62e7a2ebc48e4.jpeg', NULL, 25),
(36, '62e7a2ebc4b26.jpeg', NULL, 25),
(38, '62e7a2ebc5066.jpeg', NULL, 25),
(39, '62e7a2ebc5326.webp', NULL, 25),
(40, '62e7d6d91339b.jpeg', NULL, 27),
(41, '62e7d6d913702.jpeg', NULL, 27),
(42, '62e7d6d9139d0.jpeg', NULL, 27);

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `reporting` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `trick_id` int(11) DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B6BD307FF675F31B` (`author_id`),
  KEY `IDX_B6BD307FB281BE2E` (`trick_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `message`
--

INSERT INTO `message` (`id`, `create_at`, `reporting`, `is_active`, `author_id`, `trick_id`, `content`) VALUES
(16, '2022-07-06 09:54:01', NULL, NULL, 2, 20, 'Bonjour'),
(17, '2022-07-06 09:55:38', NULL, NULL, 2, 20, 'ok'),
(18, '2022-07-06 09:56:24', NULL, NULL, 2, 20, 'ok'),
(19, '2022-07-18 08:08:19', NULL, NULL, 3, 23, 'Bonjour'),
(25, '2022-08-30 13:07:16', NULL, NULL, 8, 23, 'Ok'),
(26, '2022-08-30 13:07:31', NULL, NULL, 8, 23, 'hallo'),
(27, '2022-09-08 21:18:42', NULL, NULL, 2, 20, 'Bonjour'),
(28, '2022-09-08 21:19:07', NULL, NULL, 2, 20, 'ok'),
(29, '2022-09-08 21:21:40', NULL, NULL, 2, 20, 'hello'),
(30, '2022-09-21 13:35:18', NULL, NULL, 2, 23, 'Bonjour');

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
CREATE TABLE IF NOT EXISTS `reset_password_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `selector` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashed_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `trick`
--

DROP TABLE IF EXISTS `trick`;
CREATE TABLE IF NOT EXISTS `trick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D8F0A91E5E237E06` (`name`),
  KEY `IDX_D8F0A91EF675F31B` (`author_id`),
  KEY `IDX_D8F0A91E12469DE2` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `trick`
--

INSERT INTO `trick` (`id`, `name`, `description`, `banner`, `author_id`, `category_id`, `created_at`, `updated_at`) VALUES
(20, 'Liberty Short', 'C’est tout simplement l’inverse du Blackflip (cf. : figure #1) pour lequel vous devez vous déséquilibrer en arrière, le front flip consiste à faire un salto avant.\r\n\r\nPour l’entraînement on vous conseille de faire des kickers en gardant un espace entre vos deux pieds. Le pied qui n’est pas votre pied d’appui est celui que vous devez choisir pour le lancer en arrière au moment où vous faites votre kicker !', '62e792e594b41.jpg', 2, 1, '2022-07-06 09:42:37', '2022-10-02 18:20:03'),
(23, 'Macy Park', 'Rerum fugiat aut ad', '62cc21df8deb4.jpeg', 3, 1, '2022-07-11 13:13:01', '2022-07-11 13:13:01'),
(25, 'Yael Rutledge', 'Enim pariatur Volup', '62e7a2ebc5542.jpeg', 2, 2, '2022-08-01 09:54:51', '2022-08-01 09:54:51'),
(27, 'Irene Bolton', 'Ut assumenda cupidat', '62e7d6d913ca2.jpeg', 2, 2, '2022-08-01 13:36:24', '2022-08-01 13:36:24'),
(28, 'augue vel accumsan', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.\r\n\r\nMaecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.\r\n\r\nNullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.\r\n\r\nMorbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '6339bab66e7dd.jpg', 5, 2, '2022-04-01 19:04:12', NULL),
(29, 'penatibus', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.\r\n\r\nIn congue. Etiam justo. Etiam pretium iaculis justo.', '6339bab66e7dd.jpg', 5, 2, '2022-03-31 18:15:09', NULL),
(30, 'duis bibendum', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.\r\n\r\nAenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '6339bab66e7dd.jpg', 6, 1, '2022-04-18 02:49:27', NULL),
(31, 'nulla neque', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.\r\n\r\nMorbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.\r\n\r\nFusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.\r\n\r\nSed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.\r\n\r\nPellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '6339bab66e7dd.jpg', 6, 1, '2022-06-03 03:51:04', NULL),
(32, 'in leo', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '6339bab66e7dd.jpg', 6, 1, '2022-09-29 04:46:54', NULL),
(33, 'non mi', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.\r\n\r\nInteger tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.\r\n\r\nPraesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '6339bab66e7dd.jpg', 6, 1, '2022-08-11 16:01:28', NULL),
(34, 'donec', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.\r\n\r\nFusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.\r\n\r\nSed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.\r\n\r\nPellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.\r\n\r\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '6339bab66e7dd.jpg', 6, 1, '2022-08-28 08:08:00', NULL),
(35, 'eget eleifend', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.\r\n\r\nFusce consequat. Nulla nisl. Nunc nisl.\r\n\r\nDuis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '6339bab66e7dd.jpg', 6, 2, '2022-11-06 08:47:20', NULL),
(36, 'tempus', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\r\n\r\nProin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.\r\n\r\nAenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '6339bab66e7dd.jpg', 6, 1, '2022-11-07 21:08:21', NULL),
(37, 'eu', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.\r\n\r\nNullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.\r\n\r\nIn quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '6339bab66e7dd.jpg', 5, 2, '2022-09-17 01:11:04', NULL),
(38, 'quam', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.\r\n\r\nNullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', '6339bab66e7dd.jpg', 6, 2, '2022-12-20 20:05:38', NULL),
(39, 'pellentesque ultrices', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.\r\n\r\nCurabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '6339bab66e7dd.jpg', 6, 2, '2022-03-03 15:26:48', NULL),
(40, 'cubilia', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.\r\n\r\nNullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.\r\n\r\nIn quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '6339bab66e7dd.jpg', 5, 1, '2022-10-11 05:32:14', NULL),
(41, 'velit eu', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.\r\n\r\nProin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.\r\n\r\nInteger ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.\r\n\r\nNam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '6339bab66e7dd.jpg', 5, 2, '2022-11-18 00:36:37', NULL),
(42, 'neque duis bibendum', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.\r\n\r\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\r\n\r\nEtiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '6339bab66e7dd.jpg', 5, 1, '2022-03-16 02:36:49', NULL),
(43, 'diam', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.\r\n\r\nAenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.\r\n\r\nCurabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.\r\n\r\nPhasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '6339bab66e7dd.jpg', 6, 1, '2022-12-08 17:16:08', NULL),
(44, 'ac', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.\r\n\r\nProin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '6339bab66e7dd.jpg', 6, 1, '2022-08-20 10:28:23', NULL),
(45, 'nunc', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.\r\n\r\nCras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\r\n\r\nProin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.\r\n\r\nAenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '6339bab66e7dd.jpg', 5, 1, '2022-08-09 07:13:08', NULL),
(46, 'aliquet', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.\r\n\r\nCurabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '6339bab66e7dd.jpg', 5, 2, '2022-10-09 13:40:24', NULL),
(47, 'ipsum primis', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.\r\n\r\nIn hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.\r\n\r\nAliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '6339bab66e7dd.jpg', 6, 2, '2022-08-22 03:53:19', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pseudo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `picture` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `is_verified`, `firstname`, `lastname`, `pseudo`, `birthday`, `picture`) VALUES
(1, 'rexo@mailinator.com', '[]', '$2y$13$EvUPo1hC/ib5YXvFH9bsH.YotSOZFLm7MgUPWAvD0mj844TEvrN.u', 0, 'Cairo', 'Chambers', 'Magnam beatae et voluptas mollit dicta velit aut omnis', '2025-12-12', '62b9bbe459cfb.jpg'),
(2, 'palomavacheron@gmail.com', '[]', '$2y$13$yPusBuiUS51rmREGhPiZPO91ralgnHaosoGJLD.AXrfomwfQA5h6i', 0, 'Paloma', 'Vn', 'Palo', '2017-10-26', '62b9bbe459cfb.jpg'),
(3, 'xewasy@mailinator.com', '[]', '$2y$13$3PelJGXKt8k0s6zZzcyEkuEAvfMW2WSkHbXhpBmNCvA0XbSTSyarW', 0, 'Mariam', 'Burnett', 'Enim repudiandae modi duis elit dolor velit excepturi accusamus praesentium consequat Dicta voluptas autem fugiat voluptatibus sed fuga Magni', '2022-01-11', '62b9bbe459cfb.jpg'),
(4, '5808e9b061@boxomail.live', '[]', '$2y$13$RNlFWTYgyep/9NCvRtGJteSFPPYzHa6YE0kD25W9UB/sRq82quesa', 0, 'Xerxes', 'Fleming', 'Ea quae consequatur', '2016-08-04', '62b9bbe459cfb.jpg'),
(5, '60762542c7@boxomail.live', '[]', '$2y$13$48y6ZfPoqBG9.WdyNVc5juFCbpO8AY5PQ71DolDvUzRYPVw7sygWK', 1, 'Xerxes', 'Fleming', 'Ea quae consequatur', '2016-08-04', '62b9bbe459cfb.jpg'),
(6, '4579cb6087@boxomail.live', '[]', '$2y$13$5SzwWw8KOlKgfI5O27po5u0ogHwBd/uXZV1vOB18Qm.ICN6GOUfom', 1, 'Hillary', 'Morris', 'pop', '1980-02-04', '62b9bbe459cfb.jpg'),
(7, 'tilysys@mailinator.com', '[]', '$2y$13$Wmo63L3gTXVQRuuGL/uQze7pyZ5QpaJ9ID/0rA17XjnWfpUT87Mry', 0, 'Erin', 'Fox', 'In ullamco est elig', '2013-08-08', '62b9bbe459cfb.jpg'),
(8, 'qefyxyq@mailinator.com', '[]', '$2y$13$r0ItGIJBMLiHXyInbZQ2ZukLwPquG9Xkh2R6OtBqOMGe.VmmwrGMO', 0, 'Charity', 'Blake', 'Illo tempor nulla no', '2000-09-23', '630e0b4f6bedc.png');

-- --------------------------------------------------------

--
-- Structure de la table `video`
--

DROP TABLE IF EXISTS `video`;
CREATE TABLE IF NOT EXISTS `video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trick_id` int(11) NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7CC7DA2CB281BE2E` (`trick_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `video`
--

INSERT INTO `video` (`id`, `trick_id`, `url`) VALUES
(5, 20, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/MFdWoHgDuf4\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>'),
(6, 20, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/UAvMnJwlucM\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>'),
(9, 23, '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/FHjW4hWsMwQ\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>'),
(10, 23, ' <iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/FHjW4hWsMwQ\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>'),
(12, 20, 'lkm'),
(13, 25, 'Lorem voluptatem Au'),
(15, 27, 'kjlk'),
(16, 27, ' lkjlk');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `FK_6A2CA10CB281BE2E` FOREIGN KEY (`trick_id`) REFERENCES `trick` (`id`);

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `FK_B6BD307FB281BE2E` FOREIGN KEY (`trick_id`) REFERENCES `trick` (`id`),
  ADD CONSTRAINT `FK_B6BD307FF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `trick`
--
ALTER TABLE `trick`
  ADD CONSTRAINT `FK_D8F0A91E12469DE2` FOREIGN KEY (`category_id`) REFERENCES `group` (`id`),
  ADD CONSTRAINT `FK_D8F0A91EF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `FK_7CC7DA2CB281BE2E` FOREIGN KEY (`trick_id`) REFERENCES `trick` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
