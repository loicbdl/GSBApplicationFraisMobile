-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Apr 21, 2019 at 12:13 AM
-- Server version: 5.6.38
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `gsb`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_frais_forfait`
--

CREATE TABLE `detail_frais_forfait` (
  `id` int(11) NOT NULL,
  `frais_forfait_id` int(11) NOT NULL,
  `quantite` int(11) NOT NULL,
  `fiche_frais_id` int(11) NOT NULL,
  `etat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail_frais_forfait`
--

INSERT INTO `detail_frais_forfait` (`id`, `frais_forfait_id`, `quantite`, `fiche_frais_id`, `etat_id`) VALUES
(4, 1, 3, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `detail_frais_non_forfait`
--

CREATE TABLE `detail_frais_non_forfait` (
  `id` int(11) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `montant` decimal(10,0) NOT NULL,
  `fiche_frais_id` int(11) NOT NULL,
  `etat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail_frais_non_forfait`
--

INSERT INTO `detail_frais_non_forfait` (`id`, `libelle`, `montant`, `fiche_frais_id`, `etat_id`) VALUES
(4, 'Train', '90', 1, 2),
(5, 'Billet d\'avion', '390', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `etat`
--

CREATE TABLE `etat` (
  `id` int(11) NOT NULL,
  `libelle` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `etat`
--

INSERT INTO `etat` (`id`, `libelle`) VALUES
(1, 'Validée'),
(2, 'Refusée');

-- --------------------------------------------------------

--
-- Table structure for table `fiche_frais`
--

CREATE TABLE `fiche_frais` (
  `id` int(11) NOT NULL,
  `mois` int(2) NOT NULL,
  `annee` int(4) NOT NULL,
  `etat_id` int(11) NOT NULL,
  `utilisateur_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fiche_frais`
--

INSERT INTO `fiche_frais` (`id`, `mois`, `annee`, `etat_id`, `utilisateur_id`) VALUES
(1, 12, 2018, 1, 1),
(3, 11, 2018, 1, 1),
(4, 1, 2019, 1, 1),
(5, 2, 2019, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `frais_forfait`
--

CREATE TABLE `frais_forfait` (
  `id` int(11) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `montant` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `frais_forfait`
--

INSERT INTO `frais_forfait` (`id`, `libelle`, `montant`) VALUES
(1, 'Hotel', '100.00'),
(2, 'Frais kilométrique', '0.10');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `libelle` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `libelle`) VALUES
(1, 'visiteur'),
(2, 'comptable'),
(3, 'Administrateur');

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `ville` varchar(255) NOT NULL,
  `code_postal` varchar(5) NOT NULL,
  `date_embauche` date NOT NULL,
  `nom_utilisateur` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `nom`, `prenom`, `adresse`, `ville`, `code_postal`, `date_embauche`, `nom_utilisateur`, `mot_de_passe`, `role_id`) VALUES
(1, 'Doe', 'John', 'test', 'test', '69000', '2018-12-11', 'test', 'test', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_frais_forfait`
--
ALTER TABLE `detail_frais_forfait`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detail_frais_forfait_fiche_frais` (`fiche_frais_id`),
  ADD KEY `fk_detail_frais_forfait_frais_forfait` (`frais_forfait_id`),
  ADD KEY `fk_dff_e` (`etat_id`);

--
-- Indexes for table `detail_frais_non_forfait`
--
ALTER TABLE `detail_frais_non_forfait`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detail_frais_non_forfait_fiche_frais` (`fiche_frais_id`),
  ADD KEY `fk_dfnf_e` (`etat_id`);

--
-- Indexes for table `etat`
--
ALTER TABLE `etat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fiche_frais`
--
ALTER TABLE `fiche_frais`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_fiche_frais_utilisateur` (`utilisateur_id`),
  ADD KEY `fk_fiche_frais_etat` (`etat_id`);

--
-- Indexes for table `frais_forfait`
--
ALTER TABLE `frais_forfait`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_role` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_frais_forfait`
--
ALTER TABLE `detail_frais_forfait`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `detail_frais_non_forfait`
--
ALTER TABLE `detail_frais_non_forfait`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `etat`
--
ALTER TABLE `etat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `fiche_frais`
--
ALTER TABLE `fiche_frais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `frais_forfait`
--
ALTER TABLE `frais_forfait`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_frais_forfait`
--
ALTER TABLE `detail_frais_forfait`
  ADD CONSTRAINT `fk_detail_frais_forfait_fiche_frais` FOREIGN KEY (`fiche_frais_id`) REFERENCES `fiche_frais` (`id`),
  ADD CONSTRAINT `fk_detail_frais_forfait_frais_forfait` FOREIGN KEY (`frais_forfait_id`) REFERENCES `frais_forfait` (`id`),
  ADD CONSTRAINT `fk_dff_e` FOREIGN KEY (`etat_id`) REFERENCES `etat` (`id`);

--
-- Constraints for table `detail_frais_non_forfait`
--
ALTER TABLE `detail_frais_non_forfait`
  ADD CONSTRAINT `fk_detail_frais_non_forfait_fiche_frais` FOREIGN KEY (`fiche_frais_id`) REFERENCES `fiche_frais` (`id`),
  ADD CONSTRAINT `fk_dfnf_e` FOREIGN KEY (`etat_id`) REFERENCES `etat` (`id`);

--
-- Constraints for table `fiche_frais`
--
ALTER TABLE `fiche_frais`
  ADD CONSTRAINT `fk_fiche_frais_etat` FOREIGN KEY (`etat_id`) REFERENCES `etat` (`id`),
  ADD CONSTRAINT `fk_fiche_frais_utilisateur` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`);

--
-- Constraints for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
