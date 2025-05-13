
create Database asistenciahuellas;
Use asistenciahuellas;
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
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fichaje`
--

DROP TABLE IF EXISTS `fichaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=17937 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hora`
--

DROP TABLE IF EXISTS `hora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hora` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario_hora_dia`
--

DROP TABLE IF EXISTS `usuario_hora_dia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=941 DEFAULT CHARSET=utf8;




CREATE VIEW vista_horario_trabajo AS
SELECT
    uhd.id AS usuario_hora_dia_id,
    u.id AS usuario_id,
    u.nombre AS nombre_usuario,
    ds.id AS dia_semana_id,
    ds.nombre AS nombre_dia,
    h.id AS hora_id,
    h.nombre AS nombre_hora,
    uhd.entrada
FROM usuario_hora_dia uhd
JOIN usuarios u ON uhd.id_user = u.id
JOIN dia_semana ds ON uhd.id_dia = ds.id
JOIN hora h ON uhd.id_hora = h.id;


CREATE VIEW vista_horario_trabajo AS
SELECT
    uhd.id AS usuario_hora_dia_id,
    u.id AS usuario_id,
    u.nombre AS nombre_usuario,
    ds.id AS dia_semana_id,
    ds.nombre AS nombre_dia,
    h.id AS hora_id,
    h.nombre AS nombre_hora,
    uhd.entrada
FROM usuario_hora_dia uhd
JOIN usuarios u ON uhd.id_user = u.id
JOIN dia_semana ds ON uhd.id_dia = ds.id
JOIN hora h ON uhd.id_hora = h.id;




DELIMITER //
CREATE PROCEDURE ObtenerHorariosUsuario (IN UsuarioId INT)
BEGIN
    SELECT
        usuario_hora_dia_id,
        usuario_id,
        nombre_usuario,
        dia_semana_id,
        nombre_dia,
        hora_id,
        nombre_hora,
        entrada
    FROM vista_horario_trabajo
    WHERE usuario_id = UsuarioId;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ObtenerHorariosPorDia (IN DiaSemanaId INT)
BEGIN
    SELECT
        usuario_hora_dia_id,
        usuario_id,
        nombre_usuario,
        dia_semana_id,
        nombre_dia,
        hora_id,
        nombre_hora,
        entrada
    FROM vista_horario_trabajo
    WHERE dia_semana_id = DiaSemanaId;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE VerificarEntradaUsuarioHoraDia (
    IN UsuarioId INT,
    IN DiaSemanaId INT,
    IN HoraId INT,
    OUT ExisteEntrada INT
)
BEGIN
    SELECT COUNT(*) INTO ExisteEntrada
    FROM usuario_hora_dia
    WHERE id_user = UsuarioId
      AND id_dia = DiaSemanaId
      AND id_hora = HoraId;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE InsertarHorarioTrabajo (
    IN UsuarioId INT,
    IN DiaSemanaId INT,
    IN HoraId INT,
    IN Entrada DATETIME
)
BEGIN
    INSERT INTO usuario_hora_dia (id_user, id_dia, id_hora, entrada)
    VALUES (UsuarioId, DiaSemanaId, HoraId, Entrada);
END //
DELIMITER ;














