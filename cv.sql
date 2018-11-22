/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : cv

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-11-22 18:34:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activite
-- ----------------------------
DROP TABLE IF EXISTS `activite`;
CREATE TABLE `activite` (
  `activiteId` int(11) NOT NULL AUTO_INCREMENT,
  `activiteDescription` varchar(255) NOT NULL,
  `activiteExperience` int(11) NOT NULL,
  PRIMARY KEY (`activiteId`),
  KEY `activiteFkExp` (`activiteExperience`),
  CONSTRAINT `activiteFkExp` FOREIGN KEY (`activiteExperience`) REFERENCES `experiencepro` (`experienceProId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for categcompetence
-- ----------------------------
DROP TABLE IF EXISTS `categcompetence`;
CREATE TABLE `categcompetence` (
  `categCompetenceId` int(11) NOT NULL AUTO_INCREMENT,
  `categCompetenceTitle` varchar(255) NOT NULL,
  `categCompetenceCv` int(11) NOT NULL,
  PRIMARY KEY (`categCompetenceId`),
  KEY `categCompetenceFkCv` (`categCompetenceCv`),
  CONSTRAINT `categCompetenceFkCv` FOREIGN KEY (`categCompetenceCv`) REFERENCES `cv` (`cvId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for commune
-- ----------------------------
DROP TABLE IF EXISTS `commune`;
CREATE TABLE `commune` (
  `communeId` int(11) NOT NULL AUTO_INCREMENT,
  `communeCodeINSEE` double(255,0) DEFAULT NULL,
  `communeNom` varchar(255) DEFAULT NULL,
  `communeCodePostal` varchar(255) DEFAULT NULL,
  `communeLibelleAcheminement` varchar(255) DEFAULT NULL,
  `communeLigne5` varchar(255) DEFAULT NULL,
  `communeCoordonneesGps` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`communeId`)
) ENGINE=InnoDB AUTO_INCREMENT=39202 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for competence
-- ----------------------------
DROP TABLE IF EXISTS `competence`;
CREATE TABLE `competence` (
  `competenceId` int(11) NOT NULL AUTO_INCREMENT,
  `competenceLibelle` varchar(255) NOT NULL,
  `competenceDescription` varchar(255) NOT NULL,
  `competenceCateg` int(11) NOT NULL,
  PRIMARY KEY (`competenceId`),
  KEY `competenceFkCateg` (`competenceCateg`),
  CONSTRAINT `competenceFkCateg` FOREIGN KEY (`competenceCateg`) REFERENCES `categcompetence` (`categCompetenceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cv
-- ----------------------------
DROP TABLE IF EXISTS `cv`;
CREATE TABLE `cv` (
  `cvId` int(11) NOT NULL AUTO_INCREMENT,
  `cvTitle` varchar(255) NOT NULL,
  `cvProprietaire` int(11) NOT NULL,
  PRIMARY KEY (`cvId`),
  KEY `cvFkProprio` (`cvProprietaire`),
  CONSTRAINT `cvFkProprio` FOREIGN KEY (`cvProprietaire`) REFERENCES `utilisateur` (`utilisateurId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for experiencepro
-- ----------------------------
DROP TABLE IF EXISTS `experiencepro`;
CREATE TABLE `experiencepro` (
  `experienceProId` int(11) NOT NULL AUTO_INCREMENT,
  `experienceProNomEntreprise` varchar(255) NOT NULL,
  `experienceProJourDebut` varchar(255) DEFAULT NULL,
  `experienceProJourFin` varchar(255) DEFAULT NULL,
  `experienceProMoisDebut` varchar(255) DEFAULT NULL,
  `experienceProMoisFin` varchar(255) DEFAULT NULL,
  `experienceProAnneeDebut` varchar(255) NOT NULL,
  `experienceProAnneeFin` varchar(255) DEFAULT NULL,
  `experienceProStatue` varchar(255) DEFAULT NULL,
  `experienceProCv` int(11) NOT NULL,
  PRIMARY KEY (`experienceProId`),
  KEY `expFkCv` (`experienceProCv`),
  CONSTRAINT `expFkCv` FOREIGN KEY (`experienceProCv`) REFERENCES `cv` (`cvId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for formation
-- ----------------------------
DROP TABLE IF EXISTS `formation`;
CREATE TABLE `formation` (
  `formationId` int(11) NOT NULL AUTO_INCREMENT,
  `formationTitle` varchar(255) NOT NULL,
  `formationAnneeDebut` int(11) NOT NULL,
  `formationAnneeFin` int(11) DEFAULT NULL,
  `formationEtablissement` varchar(255) NOT NULL,
  `formationDescription` varchar(255) DEFAULT NULL,
  `formationSpécialisation` varchar(255) DEFAULT NULL,
  `formationCv` int(11) NOT NULL,
  PRIMARY KEY (`formationId`),
  KEY `formationFkCv` (`formationCv`),
  CONSTRAINT `formationFkCv` FOREIGN KEY (`formationCv`) REFERENCES `cv` (`cvId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `roleId` int(11) NOT NULL AUTO_INCREMENT,
  `roleLibelle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userrole
-- ----------------------------
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole` (
  `userRoleId` int(255) NOT NULL AUTO_INCREMENT,
  `userRoleUtilisateur` int(11) NOT NULL,
  `userRoleRole` int(11) NOT NULL,
  PRIMARY KEY (`userRoleId`),
  KEY `userRoleFkUser` (`userRoleUtilisateur`),
  KEY `userRoleFkRole` (`userRoleRole`),
  CONSTRAINT `userRoleFkRole` FOREIGN KEY (`userRoleRole`) REFERENCES `role` (`roleId`),
  CONSTRAINT `userRoleFkUser` FOREIGN KEY (`userRoleUtilisateur`) REFERENCES `utilisateur` (`utilisateurId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for utilisateur
-- ----------------------------
DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE `utilisateur` (
  `utilisateurId` int(11) NOT NULL AUTO_INCREMENT,
  `utilisateurNom` varchar(255) NOT NULL,
  `utilisateurPrenom` varchar(255) NOT NULL,
  `utilisateurAdresseMail` varchar(255) NOT NULL,
  `utilisateurLogin` varchar(255) NOT NULL,
  `utilisateurPassword` varchar(255) NOT NULL,
  `utilisateurNumTel` varchar(255) DEFAULT NULL,
  `utilisateurNumVoie` varchar(255) DEFAULT NULL,
  `utilisateurNomVoie` varchar(255) DEFAULT NULL,
  `utilisateurCommuneId` int(255) DEFAULT NULL,
  `utilisateurDateNaissance` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `utilisateurStatutMarital` varchar(255) NOT NULL,
  `utilisateurPermisB` tinyint(4) NOT NULL,
  PRIMARY KEY (`utilisateurId`),
  KEY `utilisateurFKCommune` (`utilisateurCommuneId`),
  CONSTRAINT `utilisateurFKCommune` FOREIGN KEY (`utilisateurCommuneId`) REFERENCES `commune` (`communeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET FOREIGN_KEY_CHECKS=1;
