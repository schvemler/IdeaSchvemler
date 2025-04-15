CREATE DATABASE  IF NOT EXISTS `asistenciahuellas`;
USE `asistenciahuellas`;
DROP TABLE IF EXISTS `calendario`;
CREATE TABLE `calendario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` varchar(50) DEFAULT NULL,
  `dia` int(11) DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `id_dia` int(11) DEFAULT NULL,
  `laborable` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `calendario_usuario`;
CREATE TABLE `calendario_usuario` (
  `id_usuario` int(11) NOT NULL,
  `id_calendario` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_calendario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `dia_semana`;
CREATE TABLE `dia_semana` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `fichaje`;
CREATE TABLE `fichaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `fecha` varchar(50) DEFAULT NULL,
  `dia` int(11) DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `hash` varchar(250) DEFAULT NULL,
  `hora` time DEFAULT NULL,
  PRIMARY KEY (`id`)
)  DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `hora`;
CREATE TABLE `hora` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `usuario_hora_dia`;
CREATE TABLE `usuario_hora_dia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_hora` int(11) NOT NULL,
  `id_dia` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `entrada` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dia_semana_hora` (`id_hora`),
  KEY `fk_dia_semana_horas` (`id_dia`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `fk_dia_semana_hora` FOREIGN KEY (`id_hora`) REFERENCES `hora` (`id`),
  CONSTRAINT `fk_dia_semana_horas` FOREIGN KEY (`id_dia`) REFERENCES `dia_semana` (`id`),
  CONSTRAINT `usuario_hora_dia_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`)
) DEFAULT CHARSET=utf8;
