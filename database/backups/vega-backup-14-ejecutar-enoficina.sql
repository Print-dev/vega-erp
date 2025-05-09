/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 10.4.32-MariaDB : Database - vega_producciones_erp
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `agenda_asignaciones` */

DROP TABLE IF EXISTS `agenda_asignaciones`;

CREATE TABLE `agenda_asignaciones` (
  `idasignacion` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`idasignacion`),
  KEY `iddetalle_presentacion` (`iddetalle_presentacion`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `agenda_asignaciones_ibfk_1` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`) ON DELETE CASCADE,
  CONSTRAINT `agenda_asignaciones_ibfk_2` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `agenda_asignaciones` */

/*Table structure for table `agenda_commanager` */

DROP TABLE IF EXISTS `agenda_commanager`;

CREATE TABLE `agenda_commanager` (
  `idagendacommanager` int(11) NOT NULL AUTO_INCREMENT,
  `idagendaeditor` int(11) NOT NULL,
  `idusuarioCmanager` int(11) NOT NULL,
  `portalpublicar` varchar(120) DEFAULT NULL,
  `fechapublicacion` datetime DEFAULT NULL,
  `copy` text DEFAULT NULL,
  `estado` smallint(6) DEFAULT 1,
  PRIMARY KEY (`idagendacommanager`),
  KEY `fk_idagendaeditor_cm` (`idagendaeditor`),
  KEY `fk_idusuarioCmanaget` (`idusuarioCmanager`),
  CONSTRAINT `fk_idagendaeditor_cm` FOREIGN KEY (`idagendaeditor`) REFERENCES `agenda_editores` (`idagendaeditor`),
  CONSTRAINT `fk_idusuarioCmanaget` FOREIGN KEY (`idusuarioCmanager`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `agenda_commanager` */

/*Table structure for table `agenda_edicion` */

DROP TABLE IF EXISTS `agenda_edicion`;

CREATE TABLE `agenda_edicion` (
  `idagendaedicion` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) NOT NULL,
  PRIMARY KEY (`idagendaedicion`),
  KEY `fk_iddp_ag_edicion` (`iddetalle_presentacion`),
  CONSTRAINT `fk_iddp_ag_edicion` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`)
) ENGINE=InnoDB AUTO_INCREMENT=456 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `agenda_edicion` */

insert  into `agenda_edicion`(`idagendaedicion`,`iddetalle_presentacion`) values 
(333,1),
(334,2),
(335,3),
(336,4),
(337,5),
(338,6),
(339,7),
(340,8),
(341,9),
(342,10),
(343,11),
(344,12),
(345,13),
(346,14),
(347,15),
(348,16),
(349,17),
(350,18),
(351,19),
(352,20),
(353,21),
(354,22),
(355,23),
(356,24),
(357,25),
(358,26),
(359,27),
(360,28),
(361,29),
(362,30),
(363,31),
(364,32),
(365,33),
(366,34),
(367,35),
(368,36),
(369,37),
(370,38),
(371,39),
(372,40),
(373,41),
(374,42),
(375,43),
(376,44),
(377,45),
(378,46),
(379,47),
(380,48),
(381,49),
(382,50),
(383,51),
(384,52),
(385,53),
(386,54),
(387,55),
(388,56),
(389,57),
(390,58),
(391,59),
(392,60),
(393,61),
(394,62),
(395,63),
(396,65),
(397,66),
(398,67),
(399,68),
(400,69),
(401,70),
(402,71),
(403,72),
(404,73),
(405,74),
(406,75),
(407,76),
(408,77),
(409,78),
(410,79),
(411,80),
(412,81),
(413,82),
(414,83),
(415,84),
(416,85),
(417,86),
(418,87),
(419,88),
(420,89),
(421,90),
(422,91),
(423,92),
(424,93),
(425,94),
(426,95),
(427,96),
(428,97),
(429,98),
(430,99),
(431,100),
(432,101),
(433,102),
(434,103),
(435,104),
(436,115),
(437,116),
(438,117),
(439,118),
(440,119),
(441,120),
(442,121),
(443,122),
(444,123),
(445,124),
(446,125),
(447,126),
(448,127),
(449,128),
(450,130),
(451,131),
(452,132),
(453,133),
(454,134),
(455,135);

/*Table structure for table `agenda_editores` */

DROP TABLE IF EXISTS `agenda_editores`;

CREATE TABLE `agenda_editores` (
  `idagendaeditor` int(11) NOT NULL AUTO_INCREMENT,
  `idagendaedicion` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idtipotarea` int(11) NOT NULL,
  `estado` int(11) DEFAULT 1,
  `altoketicket` int(11) DEFAULT 1,
  `fecha_asignacion` datetime DEFAULT current_timestamp(),
  `fecha_entrega` date NOT NULL,
  `hora_entrega` time NOT NULL,
  PRIMARY KEY (`idagendaeditor`),
  KEY `fk_idagendaedicion` (`idagendaedicion`),
  KEY `fk_idusuario_ag_edit` (`idusuario`),
  KEY `fk_idtipotarea_agen` (`idtipotarea`),
  CONSTRAINT `fk_idagendaedicion` FOREIGN KEY (`idagendaedicion`) REFERENCES `agenda_edicion` (`idagendaedicion`),
  CONSTRAINT `fk_idtipotarea_agen` FOREIGN KEY (`idtipotarea`) REFERENCES `tipotarea` (`idtipotarea`),
  CONSTRAINT `fk_idusuario_ag_edit` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `agenda_editores` */

insert  into `agenda_editores`(`idagendaeditor`,`idagendaedicion`,`idusuario`,`idtipotarea`,`estado`,`altoketicket`,`fecha_asignacion`,`fecha_entrega`,`hora_entrega`) values 
(2,450,7,1,1,2,'2025-05-08 15:40:15','2025-05-08','15:45:00');

/*Table structure for table `cajachica` */

DROP TABLE IF EXISTS `cajachica`;

CREATE TABLE `cajachica` (
  `idcajachica` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) DEFAULT NULL,
  `idmonto` int(11) NOT NULL,
  `ccinicial` double(10,2) NOT NULL,
  `incremento` double(10,2) NOT NULL,
  `decremento` double(10,2) NOT NULL,
  `ccfinal` double(10,2) NOT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `fecha_cierre` datetime DEFAULT NULL,
  `fecha_apertura` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idcajachica`),
  KEY `fk_iddp_cajachicaa` (`iddetalle_presentacion`),
  KEY `fk_idmonto_caja` (`idmonto`),
  CONSTRAINT `fk_iddp_cajachicaa` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  CONSTRAINT `fk_idmonto_caja` FOREIGN KEY (`idmonto`) REFERENCES `montocajachica` (`idmonto`),
  CONSTRAINT `ck_estado_cajch` CHECK (`estado` in (1,2))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `cajachica` */

insert  into `cajachica`(`idcajachica`,`iddetalle_presentacion`,`idmonto`,`ccinicial`,`incremento`,`decremento`,`ccfinal`,`estado`,`fecha_cierre`,`fecha_apertura`) values 
(1,NULL,1,0.00,0.00,0.00,0.00,1,NULL,'2025-05-06 21:44:10');

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `tipodoc` int(11) DEFAULT NULL,
  `iddistrito` int(11) DEFAULT NULL,
  `ndocumento` char(20) DEFAULT NULL,
  `razonsocial` varchar(130) DEFAULT NULL,
  `representantelegal` varchar(130) DEFAULT NULL,
  `telefono` char(15) DEFAULT NULL,
  `correo` varchar(130) DEFAULT NULL,
  `direccion` varchar(130) DEFAULT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE KEY `uk_telefono` (`telefono`),
  UNIQUE KEY `uk_numdocumento_cli` (`ndocumento`),
  KEY `fk_iddistrito_cli` (`iddistrito`),
  CONSTRAINT `fk_iddistrito_cli` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  CONSTRAINT `chk_tipodoc` CHECK (`tipodoc` in (1,2))
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `clientes` */

insert  into `clientes`(`idcliente`,`tipodoc`,`iddistrito`,`ndocumento`,`razonsocial`,`representantelegal`,`telefono`,`correo`,`direccion`) values 
(1,1,1335,'72754790','R.E Kiño',NULL,NULL,NULL,'falso 1234568'),
(2,NULL,NULL,NULL,'sol del norte isaias',NULL,NULL,NULL,NULL),
(3,NULL,NULL,NULL,'diestra',NULL,NULL,NULL,NULL),
(4,NULL,NULL,NULL,'shugar',NULL,NULL,NULL,NULL),
(5,NULL,NULL,NULL,'junior',NULL,NULL,NULL,NULL),
(6,NULL,NULL,NULL,'Emerson Erasmo Torres Enma',NULL,NULL,NULL,NULL),
(7,NULL,NULL,NULL,'lucho la rosa producciones',NULL,'932060008',NULL,NULL),
(8,NULL,NULL,NULL,'Marcelino Elvis Navarro',NULL,NULL,NULL,NULL),
(9,NULL,NULL,NULL,'empresario',NULL,NULL,NULL,NULL),
(10,NULL,NULL,NULL,'carlos rupay',NULL,NULL,NULL,NULL),
(11,NULL,NULL,NULL,'Ruben Wilder Bocanegra',NULL,NULL,NULL,NULL),
(12,NULL,NULL,NULL,'chicho',NULL,NULL,NULL,NULL),
(13,NULL,NULL,NULL,'eduardo cardenas',NULL,NULL,NULL,NULL),
(14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(15,NULL,NULL,NULL,'arturo',NULL,'975724742',NULL,NULL),
(16,NULL,NULL,NULL,'dani gutierrez',NULL,'983156846',NULL,NULL),
(17,2,955,'10727547521','koki','koki koki test','973189399','prueba9@gmail.com','...'),
(18,NULL,NULL,NULL,'gilton',NULL,NULL,NULL,NULL),
(19,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20,NULL,NULL,NULL,'sr orlando',NULL,NULL,NULL,NULL),
(21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(22,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(23,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(24,NULL,NULL,NULL,'piti',NULL,NULL,NULL,NULL),
(25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(26,NULL,NULL,NULL,'antoni calderon',NULL,NULL,NULL,NULL),
(27,NULL,NULL,NULL,'sr arquimedes',NULL,NULL,NULL,NULL),
(28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(29,NULL,NULL,NULL,'orquesta la unica',NULL,NULL,NULL,NULL),
(30,NULL,NULL,NULL,'radio satelite',NULL,NULL,NULL,NULL),
(31,NULL,NULL,NULL,'sr gema',NULL,NULL,NULL,NULL),
(32,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(33,NULL,NULL,NULL,'correa',NULL,NULL,NULL,NULL),
(34,NULL,NULL,NULL,'gema hugo',NULL,NULL,NULL,NULL),
(35,NULL,NULL,NULL,'pablo yaipen',NULL,NULL,NULL,NULL),
(36,NULL,NULL,NULL,'pizarro',NULL,NULL,NULL,NULL),
(37,NULL,NULL,NULL,'juan carlos',NULL,NULL,NULL,NULL),
(38,NULL,NULL,NULL,'rolando',NULL,NULL,NULL,NULL),
(39,NULL,NULL,NULL,'sonido genesis star',NULL,NULL,NULL,NULL),
(40,NULL,NULL,NULL,'cesar',NULL,NULL,NULL,NULL),
(41,NULL,NULL,NULL,'gerber huaman',NULL,NULL,NULL,NULL),
(42,NULL,NULL,NULL,'palmus eventos - luis palomino',NULL,'959392731',NULL,NULL),
(43,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(44,NULL,NULL,NULL,'flor santamaria',NULL,NULL,NULL,NULL),
(45,NULL,NULL,NULL,'margiory acosta',NULL,NULL,NULL,NULL),
(46,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(47,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(48,NULL,NULL,NULL,'yaqueline piña',NULL,NULL,NULL,NULL),
(49,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(50,NULL,NULL,NULL,'jaime huaman perez',NULL,'990763910',NULL,NULL),
(51,NULL,NULL,NULL,'pamela serrano',NULL,'943284983',NULL,NULL),
(52,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(53,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(54,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(55,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(56,NULL,NULL,NULL,'Ever Rashuaman',NULL,'995479587',NULL,NULL),
(57,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(58,NULL,NULL,NULL,'oscar',NULL,NULL,NULL,NULL),
(59,NULL,NULL,NULL,'oscar flores',NULL,NULL,NULL,NULL),
(60,NULL,NULL,NULL,'hugo moreno',NULL,NULL,NULL,NULL),
(61,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(62,NULL,NULL,NULL,'chino estiven',NULL,NULL,NULL,NULL),
(63,NULL,NULL,NULL,'liliana pobes',NULL,NULL,NULL,NULL),
(64,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(65,NULL,NULL,NULL,'julian',NULL,NULL,NULL,NULL),
(66,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(67,NULL,NULL,NULL,'diego',NULL,NULL,NULL,NULL),
(68,NULL,NULL,NULL,'mirian',NULL,NULL,NULL,NULL),
(69,NULL,NULL,NULL,'carlos vilches',NULL,NULL,NULL,NULL),
(70,NULL,NULL,NULL,'Hermandad Santísima Cruz del Cerro Saltur',NULL,NULL,NULL,NULL),
(71,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(72,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(73,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(74,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(75,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(76,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(77,1,86,'72754752','jose',NULL,'','','av callao'),
(78,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(79,NULL,NULL,NULL,'adadasdsad',NULL,NULL,NULL,NULL),
(80,NULL,NULL,NULL,'adadasdsad',NULL,NULL,NULL,NULL),
(81,NULL,NULL,NULL,'adadasdsad',NULL,NULL,NULL,NULL),
(82,NULL,NULL,NULL,'adadasdsad',NULL,NULL,NULL,NULL),
(83,NULL,NULL,NULL,'adadasdsad',NULL,NULL,NULL,NULL),
(84,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(85,1,1324,'72754422','jhon',NULL,'999333111','test2@gmail.com','abcd 123'),
(86,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(87,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `comprobantes` */

DROP TABLE IF EXISTS `comprobantes`;

CREATE TABLE `comprobantes` (
  `idcomprobante` int(11) NOT NULL AUTO_INCREMENT,
  `iddetallepresentacion` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idtipodoc` char(2) NOT NULL,
  `tipopago` int(11) NOT NULL,
  `fechaemision` date DEFAULT current_timestamp(),
  `horaemision` time DEFAULT current_timestamp(),
  `nserie` char(4) NOT NULL,
  `correlativo` char(8) NOT NULL,
  `tipomoneda` varchar(40) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tieneigv` tinyint(4) NOT NULL,
  `noperacion` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idcomprobante`),
  KEY `fk_idcliente_comp` (`idcliente`),
  KEY `fk_idsucursal_comp` (`idsucursal`),
  KEY `fk_iddp_comp` (`iddetallepresentacion`),
  CONSTRAINT `fk_idcliente_comp` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`idcliente`),
  CONSTRAINT `fk_iddp_comp` FOREIGN KEY (`iddetallepresentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  CONSTRAINT `fk_idsucursal_comp` FOREIGN KEY (`idsucursal`) REFERENCES `sucursales` (`idsucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `comprobantes` */

insert  into `comprobantes`(`idcomprobante`,`iddetallepresentacion`,`idsucursal`,`idcliente`,`idtipodoc`,`tipopago`,`fechaemision`,`horaemision`,`nserie`,`correlativo`,`tipomoneda`,`monto`,`tieneigv`,`noperacion`) values 
(3,132,1,17,'01',1,'2025-05-09','00:10:41','F001','00000001','PEN',1309.80,1,NULL),
(4,135,1,1,'02',3,'2025-05-09','08:13:51','2025','00000001','PEN',1110.00,0,'231232412312'),
(5,9,1,1,'02',1,'2025-05-09','08:19:53','2025','00000002','PEN',81700.00,0,NULL);

/*Table structure for table `contratos` */

DROP TABLE IF EXISTS `contratos`;

CREATE TABLE `contratos` (
  `idcontrato` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) NOT NULL,
  `estado` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idcontrato`),
  KEY `fk_dp_cs` (`iddetalle_presentacion`),
  CONSTRAINT `fk_dp_cs` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  CONSTRAINT `ck_estado` CHECK (`estado` in (1,2,3))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `contratos` */

insert  into `contratos`(`idcontrato`,`iddetalle_presentacion`,`estado`,`created_at`,`updated_at`) values 
(1,13,1,'2025-04-16 17:31:22',NULL),
(2,85,1,'2025-05-05 10:06:41',NULL),
(3,119,2,'2025-05-06 16:36:03','2025-05-06 23:41:22'),
(4,121,2,'2025-05-06 21:58:10','2025-05-06 22:29:39'),
(5,122,2,'2025-05-07 00:29:16','2025-05-07 00:36:52'),
(6,124,2,'2025-05-07 08:17:47','2025-05-07 08:17:54'),
(7,126,1,'2025-05-07 08:33:56',NULL),
(8,131,1,'2025-05-08 23:04:19',NULL);

/*Table structure for table `convenios` */

DROP TABLE IF EXISTS `convenios`;

CREATE TABLE `convenios` (
  `idconvenio` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) NOT NULL,
  `abono_garantia` decimal(10,2) DEFAULT NULL,
  `abono_publicidad` decimal(10,2) DEFAULT NULL,
  `porcentaje_vega` int(11) NOT NULL,
  `porcentaje_promotor` int(11) NOT NULL,
  `propuesta_cliente` text NOT NULL,
  `estado` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idconvenio`),
  KEY `fk_dp_cv` (`iddetalle_presentacion`),
  CONSTRAINT `fk_dp_cv` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  CONSTRAINT `ck_estado` CHECK (`estado` in (1,2,3))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `convenios` */

insert  into `convenios`(`idconvenio`,`iddetalle_presentacion`,`abono_garantia`,`abono_publicidad`,`porcentaje_vega`,`porcentaje_promotor`,`propuesta_cliente`,`estado`,`created_at`,`updated_at`) values 
(3,16,500.00,800.00,60,40,'',2,'2025-04-16 14:57:32','2025-04-16 15:13:54'),
(4,99,500.00,500.00,50,50,'',1,'2025-05-05 10:09:44',NULL),
(5,100,500.00,500.00,60,40,'',1,'2025-05-05 10:11:55',NULL),
(6,101,500.00,500.00,60,40,'',1,'2025-05-05 10:14:27',NULL),
(7,102,500.00,500.00,60,40,'',1,'2025-05-05 10:16:30',NULL),
(8,103,500.00,500.00,60,40,'',1,'2025-05-05 10:17:57',NULL),
(9,113,500.00,500.00,60,40,'',1,'2025-05-05 10:30:36',NULL),
(10,112,500.00,500.00,60,40,'',2,'2025-05-05 10:31:01','2025-05-07 15:31:20'),
(11,120,333.00,444.00,60,40,'',2,'2025-05-06 16:22:15','2025-05-06 16:22:56'),
(12,123,555.00,223.00,60,40,'',2,'2025-05-07 00:49:10','2025-05-07 00:49:16'),
(13,125,444.00,555.00,60,40,'',2,'2025-05-07 08:19:18','2025-05-07 08:19:24'),
(14,104,333.00,444.00,60,40,'',2,'2025-05-07 16:19:19','2025-05-07 16:19:39'),
(15,1,3123.00,3123.00,60,40,'',2,'2025-05-07 19:19:54','2025-05-07 19:19:59');

/*Table structure for table `cuotas_comprobante` */

DROP TABLE IF EXISTS `cuotas_comprobante`;

CREATE TABLE `cuotas_comprobante` (
  `idcuotacomprobante` int(11) NOT NULL AUTO_INCREMENT,
  `idcomprobante` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fechapagado` date DEFAULT NULL,
  `horapagado` time DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`idcuotacomprobante`),
  KEY `fk_idcuotacomprobante` (`idcomprobante`),
  CONSTRAINT `fk_idcuotacomprobante` FOREIGN KEY (`idcomprobante`) REFERENCES `comprobantes` (`idcomprobante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `cuotas_comprobante` */

/*Table structure for table `departamentos` */

DROP TABLE IF EXISTS `departamentos`;

CREATE TABLE `departamentos` (
  `iddepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `idnacionalidad` int(11) NOT NULL,
  `departamento` varchar(100) NOT NULL,
  PRIMARY KEY (`iddepartamento`),
  KEY `fk_idnacionalidad` (`idnacionalidad`),
  CONSTRAINT `fk_idnacionalidad` FOREIGN KEY (`idnacionalidad`) REFERENCES `nacionalidades` (`idnacionalidad`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `departamentos` */

insert  into `departamentos`(`iddepartamento`,`idnacionalidad`,`departamento`) values 
(1,31,'Amazonas'),
(2,31,'Áncash'),
(3,31,'Apurímac'),
(4,31,'Arequipa'),
(5,31,'Ayacucho'),
(6,31,'Cajamarca'),
(7,31,'Callao'),
(8,31,'Cusco'),
(9,31,'Huancavelica'),
(10,31,'Huánuco'),
(11,31,'Ica'),
(12,31,'Junín'),
(13,31,'La Libertad'),
(14,31,'Lambayeque'),
(15,31,'Lima'),
(16,31,'Loreto'),
(17,31,'Madre de Dios'),
(18,31,'Moquegua'),
(19,31,'Pasco'),
(20,31,'Piura'),
(21,31,'Puno'),
(22,31,'San Martín'),
(23,31,'Tacna'),
(24,31,'Tumbes'),
(25,31,'Ucayali');

/*Table structure for table `detalles_comprobante` */

DROP TABLE IF EXISTS `detalles_comprobante`;

CREATE TABLE `detalles_comprobante` (
  `iddetallecomprobante` int(11) NOT NULL AUTO_INCREMENT,
  `idcomprobante` int(11) NOT NULL,
  `estado` varchar(10) NOT NULL,
  `info` varchar(60) NOT NULL,
  PRIMARY KEY (`iddetallecomprobante`),
  KEY `fk_iddetallefactura` (`idcomprobante`),
  CONSTRAINT `fk_iddetallefactura` FOREIGN KEY (`idcomprobante`) REFERENCES `comprobantes` (`idcomprobante`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalles_comprobante` */

insert  into `detalles_comprobante`(`iddetallecomprobante`,`idcomprobante`,`estado`,`info`) values 
(4,3,'ACEPTADA','La Factura numero F001-00000001, ha sido aceptada');

/*Table structure for table `detalles_presentacion` */

DROP TABLE IF EXISTS `detalles_presentacion`;

CREATE TABLE `detalles_presentacion` (
  `iddetalle_presentacion` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `iddistrito` int(11) DEFAULT NULL,
  `ncotizacion` char(9) DEFAULT NULL,
  `fecha_presentacion` date NOT NULL,
  `horainicio` time DEFAULT NULL,
  `horafinal` time DEFAULT NULL,
  `establecimiento` varchar(80) DEFAULT NULL,
  `referencia` varchar(200) DEFAULT NULL,
  `acuerdo` text DEFAULT NULL,
  `tipo_evento` int(11) DEFAULT NULL,
  `modalidad` int(11) DEFAULT NULL,
  `modotransporte` int(11) DEFAULT NULL,
  `validez` int(11) DEFAULT NULL,
  `igv` tinyint(4) NOT NULL,
  `reserva` tinyint(4) DEFAULT 0,
  `pagado50` tinyint(4) DEFAULT 0,
  `tienecaja` tinyint(4) DEFAULT 0,
  `estado` tinyint(4) DEFAULT 1,
  `created_at` date DEFAULT current_timestamp(),
  `esExtranjero` tinyint(4) DEFAULT NULL,
  `idnacionalidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddetalle_presentacion`),
  UNIQUE KEY `uk_idp` (`iddetalle_presentacion`),
  UNIQUE KEY `uk_ncotizacion` (`ncotizacion`),
  KEY `fk_idusuario_dp` (`idusuario`),
  KEY `fk_idcliente_dp` (`idcliente`),
  KEY `fk_iddistrito_dp` (`iddistrito`),
  KEY `fk_idnacionalidad_dp` (`idnacionalidad`),
  CONSTRAINT `fk_idcliente_dp` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`idcliente`),
  CONSTRAINT `fk_iddistrito_dp` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  CONSTRAINT `fk_idnacionalidad_dp` FOREIGN KEY (`idnacionalidad`) REFERENCES `nacionalidades` (`idnacionalidad`),
  CONSTRAINT `fk_idusuario_dp` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `chk_detalle_p` CHECK (`modalidad` in (1,2)),
  CONSTRAINT `ck_estado_dp` CHECK (`estado` in (1,2,3)),
  CONSTRAINT `ck_tevento_dp` CHECK (`tipo_evento` in (1,2))
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalles_presentacion` */

insert  into `detalles_presentacion`(`iddetalle_presentacion`,`idusuario`,`idcliente`,`iddistrito`,`ncotizacion`,`fecha_presentacion`,`horainicio`,`horafinal`,`establecimiento`,`referencia`,`acuerdo`,`tipo_evento`,`modalidad`,`modotransporte`,`validez`,`igv`,`reserva`,`pagado50`,`tienecaja`,`estado`,`created_at`,`esExtranjero`,`idnacionalidad`) values 
(1,2,1,1269,NULL,'2025-04-19','00:00:00','00:00:00','Local praxigas ex finca Nario',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(2,3,1,1269,NULL,'2025-04-19','00:00:00','00:00:00','Local praxigas ex finca Nario',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(3,3,2,221,NULL,'2025-04-20','18:00:00','21:30:00','Aniversario de azucena /pisina',NULL,NULL,1,1,1,NULL,0,0,0,0,1,'2025-04-16',0,31),
(4,2,3,1183,NULL,'2025-04-30','21:00:00','02:00:00','Casa grande Club Gema de Casa grande',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(5,2,4,613,NULL,'2025-05-04','00:00:00','00:00:00',NULL,NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(6,2,4,1,NULL,'2025-05-04','00:00:00','00:00:00',NULL,NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(7,2,5,1577,NULL,'2025-05-31','22:00:00','00:00:00',NULL,NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(8,3,5,1577,NULL,'2025-05-31','00:30:00','03:00:00',NULL,NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(9,2,6,979,'0001-2025','2025-04-26','00:00:00','04:00:00','Sindicato de obreros',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(10,2,7,1183,'0002-2025','2025-04-27','01:30:00','04:00:00','Tabaco marino',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(11,2,8,1104,'0003-2025','2025-05-01','00:00:00','00:00:00','Recepciones Marcelita muruhuay',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(12,3,9,495,'0004-2025','2025-05-01','23:00:00','03:00:00','Centro poblado Santa filomena',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(13,2,9,1342,'0005-2025','2025-05-03','16:00:00','20:00:00',NULL,NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(14,2,10,672,'0006-2025','2025-05-09','20:00:00','22:00:00',NULL,NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(15,2,11,1154,'0007-2025','2025-05-10','23:00:00','01:00:00','retamaz','fiesta patronal honor a la santisima virgen de la puerta y dia de la madre',NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(16,2,12,323,'0043-2025','2025-05-11','22:00:00','02:00:00','cerro colorado',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(17,2,13,323,'0008-2025','2025-05-17','00:00:00','00:00:00','rio grande iquipi',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(18,2,13,326,'0009-2025','2025-05-18','00:00:00','00:00:00','estadio municipal',NULL,NULL,2,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(19,4,14,1034,'0010-2025','2025-10-25','00:00:00','00:00:00','huancayo, aun no hay locacion',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-16',0,31),
(20,2,15,964,NULL,'2025-04-13','22:00:00','02:00:00','discoteca 10 lukas',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(21,2,16,1338,NULL,'2025-04-12','23:00:00','03:00:00','discoteca tropical',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(22,2,17,1225,NULL,'2025-04-06','18:00:00','22:00:00','aventura  park 7 aniversario',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(23,2,18,1337,NULL,'2025-04-04','22:00:00','00:30:00','yacumama',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(24,2,19,1293,NULL,'2025-03-30','18:00:00','22:30:00','piscina las palmeras',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(25,2,20,1153,NULL,'2025-03-23','20:00:00','00:00:00','recreo municipal',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(26,2,21,1270,NULL,'2025-03-22','21:00:00','01:00:00','coco bongo',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(27,2,22,1345,NULL,'2025-03-15','23:00:00','03:00:00','el aguaje',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(28,2,23,1352,NULL,'2025-03-14','22:00:00','01:00:00','discoteca anubis boulevard la hacienda',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(29,2,24,1225,NULL,'2025-03-09','22:00:00','02:00:00',NULL,'El día 8 de Marzo día de la Mujer desde las 8 pm hasta las 4 am',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(30,2,25,667,NULL,'2025-03-08','23:00:00','03:00:00','bailodromo','BAILODROMO de la Av. Tomas Valle #Mz E Lt 2 Urb El condor Callao..Callao',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(31,2,3,546,NULL,'2025-03-02','00:00:00','00:00:00','punta sal',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(32,2,17,1118,NULL,'2025-03-01','00:00:00','00:00:00','discoteca',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(33,2,2,1568,NULL,'2025-02-16','22:00:00','02:00:00','coliseo cerrado huadalupe ruiz',NULL,NULL,1,1,1,NULL,0,0,0,0,1,'2025-04-16',0,31),
(34,3,2,1568,NULL,'2025-02-16','18:00:00','21:00:00','coliseo cerrado huadalupe',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(35,2,2,1546,NULL,'2025-02-15','18:00:00','21:00:00','Calle Bolognesi','Calle Bolognesi',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(36,3,2,1546,NULL,'2025-02-15','21:00:00','00:00:00','calle bolognesi','calle bolognesi',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(37,2,26,1547,NULL,'2025-02-15','00:00:00','03:00:00','yunce rosado \"el progreso\"','san martin occidente',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(38,4,27,1293,NULL,'2025-02-09','17:00:00','19:30:00','piscina las palmeras','el valle de anexo 22',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(39,2,28,1338,NULL,'2025-02-09','16:00:00','19:00:00','piscina el paraiso',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(40,2,27,1293,NULL,'2025-02-09','20:00:00','23:00:00','piscina las palmeras','el valle de anexo 22',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(41,3,29,672,NULL,'2025-02-09','19:00:00','21:00:00','parasol',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(42,2,30,672,NULL,'2025-02-08','01:00:00','04:00:00','arius disco',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(43,2,31,1359,NULL,'2025-02-08','21:00:00','00:00:00','frontis municipalidad','feliz 63 aniversario, distrito lugar frontis municipalidad',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(44,3,31,1359,NULL,'2025-02-08','21:00:00','00:00:00','frontis municipalidad','feliz 63 aniversario distrito lugar frontis municipalidad',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(45,2,32,601,NULL,'2025-02-04','21:00:00','01:00:00','coliseo municipal',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(46,2,3,1115,NULL,'2025-02-02','15:00:00','19:00:00','playa mal abrigo',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(47,2,33,1563,NULL,'2025-02-01','22:00:00','02:00:00','calle cristobal','calle cristobal colon sin numero a la espalda del mercadillo',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(48,2,34,1183,NULL,'2025-01-28','00:00:00','00:00:00','coliseo municipal de simbal',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(49,2,35,672,NULL,'2025-01-26','15:00:00','19:00:00','centro recreacional parasol piscina','piscina',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(50,3,36,1804,NULL,'2025-01-20','21:00:00','01:00:00','club libertad',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(51,2,2,1535,NULL,'2025-01-19','20:00:00','00:00:00','club deportivo el caysa',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(52,2,2,1537,NULL,'2025-01-19','15:00:00','19:00:00','calle 2 de mayo',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(53,4,37,1345,NULL,'2025-01-19','20:00:00','02:00:00','aguaje',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(54,2,36,1578,NULL,'2025-01-18','21:00:00','01:00:00','mz d1 el san sebastian',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(55,2,38,1128,NULL,'2025-01-17','23:00:00','03:00:00','local casa vieja','32 aniversario identica de chepen',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(56,2,39,1570,NULL,'2025-01-13','22:30:00','02:30:00','fiesta patronal','gran fiesta patronal san francisco',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(57,2,17,1203,NULL,'2025-01-12','15:00:00','19:00:00','playa lagunas mocupe',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(58,2,17,1206,NULL,'2025-01-12','21:00:00','00:00:00',NULL,'feliz aniversario santa rosa',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(59,2,40,1263,NULL,'2025-01-10','23:00:00','03:00:00','estadio san luis','feliz 154 aniversario distrito san luis cañete',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(60,2,41,1355,NULL,'2025-01-05','21:00:00','01:00:00','el mueble internacional',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(61,2,3,1115,NULL,'2025-01-02','20:00:00','01:00:00','estadio municipal de chicama','Distrito de chicama celebrar 168 años de creación política Local Estadío Municipal de Chicama',NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(62,2,42,971,NULL,'2025-01-01','22:00:00','01:00:00','piscinazo bailable',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(63,2,43,964,NULL,'2025-01-01','18:30:00','21:30:00','piscina club el tumi',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-16',0,31),
(65,2,44,1327,'0011-2025','2025-03-22','23:00:00','01:00:00','garden palace',NULL,NULL,2,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(66,5,45,1188,'0012-2025','2025-03-22','22:00:00','00:00:00',NULL,'cumpleaños sorpresa',NULL,2,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(67,2,46,672,'0013-2025','2025-03-16','16:00:00','18:00:00','aquapark','aquapark/ventanilla',NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(68,4,47,1104,'0014-2025','2025-03-11','00:00:00','00:00:00',NULL,NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(69,4,48,1707,'0015-2025','2025-03-01','21:00:00','03:00:00','San martin de alao - C.P: Sinami','San martin de alao - C.P: Sinami',NULL,2,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(70,3,49,1345,'0016-2025','2025-02-23','00:00:00','00:00:00','piscinazo el anden',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(71,2,50,722,'0017-2025','2025-02-23','20:00:00','23:00:00','oropeza cusco',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(72,2,51,1793,'0018-2025','2025-02-22','22:00:00','01:00:00','el local chololo - pocollay',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(73,4,52,138,'0019-2025','2025-02-21','00:00:00','00:00:00',NULL,NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(74,4,53,1352,'0020-2025','2025-02-16','20:00:00','22:00:00','villa de armas - zarate',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(75,4,54,1293,'0021-2025','2025-02-16','00:00:00','00:00:00','club el padrino',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(76,4,55,1015,'0022-2025','2025-02-15','00:00:00','00:00:00',NULL,NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(77,4,56,1034,'0023-2025','2025-02-15','00:00:00','00:00:00','local mil maravillas',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(78,2,57,1167,'0024-2025','2025-02-14','22:00:00','01:00:00','pedregal disco lounge',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(79,4,58,1322,'0025-2025','2025-02-14','04:00:00','06:00:00','local angaraes',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(80,4,58,1355,'0026-2025','2025-02-14','23:00:00','01:00:00','unicachi',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(81,4,58,1352,'0027-2025','2025-02-14','20:00:00','22:00:00','crucero del amor','estacion san carlos',NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(82,4,59,910,'0028-2025','2025-02-11','22:00:00','00:00:00','llata',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(83,2,60,546,'0029-2025','2025-02-10','22:00:00','01:00:00','cajabamba',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(84,4,61,1331,'0030-2025','2025-02-08','01:00:00','03:00:00','larcay',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(85,2,62,214,'0031-2025','2025-02-02','00:30:00','03:30:00','discoteca explanada beta disco',NULL,NULL,2,2,1,7,0,1,0,0,1,'2025-04-21',0,31),
(86,4,58,1352,'0032-2025','2025-01-25','00:00:00','00:00:00','crucero del amor','estacion san carlos',NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(87,2,37,1338,'0033-2025','2025-01-25','03:00:00','04:00:00','local mia club',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(88,4,63,1062,'0034-2025','2025-01-22','01:00:00','03:00:00','local cour de basket',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(89,4,64,1331,'0035-2025','2025-01-18','23:30:00','00:00:00','local ilarcay',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(90,4,65,824,'0036-2025','2025-01-14','23:00:00','02:00:00','local plaza principal de paucara','plaza principal de paucara',NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(91,4,66,1034,'0037-2025','2025-01-12','00:30:00','03:00:00','aniversario artista sunqucha','aniversario artista sunqucha',NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(92,4,1,1490,'0038-2025','2025-01-11','21:00:00','23:00:00','69 aniversario santa ana de tusi','69 aniversario santa ana de tusi',NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(93,2,67,1345,'0039-2025','2025-01-05','03:40:00','05:40:00','piscina chepita royer','changrila',NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(94,4,68,824,'0040-2025','2025-01-02','21:30:00','00:30:00','villa san francisco',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-21',0,31),
(95,3,9,1104,'0041-2025','2025-05-01','23:00:00','03:00:00','Centro poblado Santa filomena',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-04-25',0,31),
(96,2,69,1557,NULL,'2025-05-04','00:00:00','00:00:00','salsa de la cumbia',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-04-25',0,31),
(97,8,70,1214,NULL,'2025-04-30','22:00:00','03:00:00','Local de la Institución Educativa Antoni Raimondi de Saltur',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-05',0,31),
(98,8,71,1183,'0042-2025','2025-05-01','18:00:00','21:00:00','Explanada de Huanchaco',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-05',0,31),
(99,8,72,214,NULL,'2025-05-01','00:00:00','04:00:00','beta disco lounge',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-05',0,31),
(100,8,73,1,NULL,'2025-05-02','22:00:00','02:00:00','discoteca la hacienda',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-05',0,31),
(101,8,74,625,NULL,'2025-05-03','22:00:00','02:00:00','Paramo Centro Recreacional',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-05',0,31),
(102,8,75,1701,NULL,'2025-05-04','15:00:00','18:00:00','La Choza CutervinaMedio Dia',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-05',0,31),
(103,8,76,78,NULL,'2025-05-04','20:00:00','00:00:00','Discoteca La Hacienda Noche',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-05',0,31),
(104,8,77,1183,NULL,'2025-05-09','19:00:00','03:00:00','el barco primer turno',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-05',0,31),
(112,8,85,1557,NULL,'2025-05-12','22:00:00','02:00:00','la casa de la cumbia',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-05',0,31),
(113,2,86,1335,NULL,'2025-05-17','19:00:00','03:00:00','Estadio Municipal Mi Perú',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-05',0,31),
(115,8,17,NULL,'0044-2025','2025-05-16','19:00:00','23:00:00','coliseo',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-06',0,31),
(116,5,17,955,'0045-2025','2025-05-08','13:00:00','18:00:00','plaza de armas',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-06',0,31),
(117,8,17,959,'0046-2025','2025-05-10','17:00:00','23:00:00','plaza nueva',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-06',0,31),
(118,8,17,NULL,'0047-2025','2025-05-21','14:00:00','16:00:00','casa',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-06',0,31),
(119,2,17,NULL,'0048-2025','2025-05-21','19:00:00','23:00:00','luri',NULL,NULL,1,2,1,7,0,1,1,0,1,'2025-05-06',0,31),
(120,8,17,NULL,NULL,'2025-05-29','18:00:00','23:00:00','larcomar',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-06',0,31),
(121,8,17,955,'0049-2025','2025-05-07','13:00:00','21:00:00','plaza falsa',NULL,NULL,1,2,1,8,0,1,1,0,1,'2025-05-06',0,31),
(122,8,17,NULL,'0050-2025','2025-05-08','13:00:00','23:00:00','cuarto',NULL,NULL,1,2,1,7,0,1,1,0,1,'2025-05-07',0,31),
(123,8,17,NULL,NULL,'2025-05-21','07:00:00','13:00:00','hola',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-07',0,31),
(124,8,17,955,'0051-2025','2025-05-08','06:00:00','08:00:00','equisde',NULL,NULL,1,2,1,7,1,0,1,0,1,'2025-05-07',0,31),
(125,8,17,NULL,NULL,'2025-05-08','09:00:00','11:00:00','palacio',NULL,NULL,1,1,1,0,1,0,0,0,1,'2025-05-07',0,31),
(126,8,17,NULL,'0052-2025','2025-05-09','15:00:00','16:00:00','san antonio',NULL,NULL,1,2,1,7,0,1,0,0,1,'2025-05-07',0,31),
(127,8,87,NULL,'0053-2025','2025-05-16','19:00:00','03:00:00','montevideo',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-07',0,31),
(128,8,17,NULL,'0054-2025','2025-05-16','07:00:00','12:00:00','montevideo',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-07',1,35),
(129,8,17,NULL,'0055-2025','2025-05-02','15:03:00','18:00:00','fose',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-08',1,35),
(130,8,17,NULL,'0056-2025','2025-05-02','19:00:00','20:00:00','fugas',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-08',1,35),
(131,8,17,NULL,'0057-2025','2025-05-09','22:00:00','23:00:00','calle',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-08',1,35),
(132,8,17,NULL,'0058-2025','2025-05-09','01:00:00','03:00:00','larco',NULL,NULL,1,2,1,7,1,0,0,0,1,'2025-05-08',1,35),
(133,8,17,NULL,NULL,'2025-05-10','01:00:00','03:00:00','chacha',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-09',1,35),
(134,8,17,NULL,NULL,'2025-05-10','04:00:00','06:00:00','atm',NULL,NULL,1,1,1,0,0,0,0,0,1,'2025-05-09',1,35),
(135,8,17,NULL,'0059-2025','2025-05-10','07:00:00','08:00:00','xd',NULL,NULL,1,2,1,7,0,0,0,0,1,'2025-05-09',1,35);

/*Table structure for table `distritos` */

DROP TABLE IF EXISTS `distritos`;

CREATE TABLE `distritos` (
  `iddistrito` int(11) NOT NULL AUTO_INCREMENT,
  `idprovincia` int(11) NOT NULL,
  `distrito` varchar(80) NOT NULL,
  PRIMARY KEY (`iddistrito`),
  KEY `fk_idprovincia` (`idprovincia`),
  CONSTRAINT `fk_idprovincia` FOREIGN KEY (`idprovincia`) REFERENCES `provincias` (`idprovincia`)
) ENGINE=InnoDB AUTO_INCREMENT=1830 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `distritos` */

insert  into `distritos`(`iddistrito`,`idprovincia`,`distrito`) values 
(1,1,'Bagua'),
(2,1,'Aramango'),
(3,1,'Copallín'),
(4,1,'El Parco'),
(5,1,'Imaza'),
(6,1,'La Peca'),
(7,2,'Jumbilla'),
(8,2,'Chisquilla'),
(9,2,'Churuja'),
(10,2,'Corosha'),
(11,2,'Cuispes'),
(12,2,'Florida'),
(13,2,'Jazán'),
(14,2,'Recta'),
(15,2,'San Carlos'),
(16,2,'Shipasbamba'),
(17,2,'Valera'),
(18,2,'Yambrasbamba'),
(19,3,'Chachapoyas'),
(20,3,'Asunción'),
(21,3,'Balsas'),
(22,3,'Cheto'),
(23,3,'Chiliquin'),
(24,3,'Chuquibamba'),
(25,3,'Granada'),
(26,3,'Huancas'),
(27,3,'La Jalca'),
(28,3,'Leimebamba'),
(29,3,'Levanto'),
(30,3,'Magdalena'),
(31,3,'Mariscal Castilla'),
(32,3,'Molinopampa'),
(33,3,'Montevideo'),
(34,3,'Olleros'),
(35,3,'Quinjalca'),
(36,3,'San Francisco de Daguas'),
(37,3,'San Isidro de Maino'),
(38,3,'Soloco'),
(39,3,'Sonche'),
(40,4,'Santa María de Nieva'),
(41,4,'El Cenepa'),
(42,4,'Río Santiago'),
(43,5,'Lamud'),
(44,5,'Camporredondo'),
(45,5,'Cocabamba'),
(46,5,'Colcamar'),
(47,5,'Conila'),
(48,5,'Inguilpata'),
(49,5,'Longuita'),
(50,5,'Lonya Chico'),
(51,5,'Luya'),
(52,5,'Luya Viejo'),
(53,5,'María'),
(54,5,'Ocalli'),
(55,5,'Ocumal'),
(56,5,'Pisuquía'),
(57,5,'Providencia'),
(58,5,'San Cristóbal'),
(59,5,'San Francisco del Yeso'),
(60,5,'San Jerónimo'),
(61,5,'San Juan de Lopecancha'),
(62,5,'Santa Catalina'),
(63,5,'Santo Tomás'),
(64,5,'Tingo'),
(65,5,'Trita'),
(66,6,'San Nicolás'),
(67,6,'Chirimoto'),
(68,6,'Cochamal'),
(69,6,'Huambo'),
(70,6,'Limabamba'),
(71,6,'Longar'),
(72,6,'Mariscal Benavides'),
(73,6,'Milpuc'),
(74,6,'Omia'),
(75,6,'Santa Rosa'),
(76,6,'Totora'),
(77,6,'Vista Alegre'),
(78,7,'Bagua Grande'),
(79,7,'Cajaruro'),
(80,7,'Cumba'),
(81,7,'El Milagro'),
(82,7,'Jamalca'),
(83,7,'Lonya Grande'),
(84,7,'Yamón'),
(85,8,'Aija'),
(86,8,'Coris'),
(87,8,'Huacllan'),
(88,8,'La Merced'),
(89,8,'Succha'),
(90,9,'Llamellín'),
(91,9,'Aczo'),
(92,9,'Chaccho'),
(93,9,'Chingas'),
(94,9,'Mirgas'),
(95,9,'San Juan de Rontoy'),
(96,10,'Chacas'),
(97,10,'Acochaca'),
(98,11,'Chiquián'),
(99,11,'Abelardo Pardo Lezameta'),
(100,11,'Antonio Raymondi'),
(101,11,'Aquia'),
(102,11,'Cajacay'),
(103,11,'Canis'),
(104,11,'Colquioc'),
(105,11,'Huallanca'),
(106,11,'Huasta'),
(107,11,'Huayllacayan'),
(108,11,'La Primavera'),
(109,11,'Mangas'),
(110,11,'Pacllon'),
(111,11,'San Miguel de Corpanqui'),
(112,11,'Ticllos'),
(113,12,'Carhuaz'),
(114,12,'Acopampa'),
(115,12,'Amashca'),
(116,12,'Anta'),
(117,12,'Ataquero'),
(118,12,'Marcara'),
(119,12,'Pariahuanca'),
(120,12,'San Miguel de Aco'),
(121,12,'Shilla'),
(122,12,'Tinco'),
(123,12,'Yungar'),
(124,13,'San Luis'),
(125,13,'San Nicolás'),
(126,13,'Yauya'),
(127,14,'Casma'),
(128,14,'Buena Vista Alta'),
(129,14,'Comandante Noel'),
(130,14,'Yautan'),
(131,15,'Corongo'),
(132,15,'Aco'),
(133,15,'Bambas'),
(134,15,'Cusca'),
(135,15,'La Pampa'),
(136,15,'Yanac'),
(137,15,'Yupan'),
(138,16,'Huaraz'),
(139,16,'Cochabamba'),
(140,16,'Colcabamba'),
(141,16,'Huanchay'),
(142,16,'Independencia'),
(143,16,'Jangas'),
(144,16,'La Libertad'),
(145,16,'Olleros'),
(146,16,'Pampas'),
(147,16,'Pariacoto'),
(148,16,'Pira'),
(149,16,'Tarica'),
(150,17,'Huari'),
(151,17,'Anra'),
(152,17,'Cajay'),
(153,17,'Chavin de Huantar'),
(154,17,'Huacachi'),
(155,17,'Huacchis'),
(156,17,'Huachis'),
(157,17,'Huantar'),
(158,17,'Masin'),
(159,17,'Paucas'),
(160,17,'Ponto'),
(161,17,'Rahuapampa'),
(162,17,'Rapayan'),
(163,17,'San Marcos'),
(164,17,'San Pedro de Chana'),
(165,17,'Uco'),
(166,18,'Huarmey'),
(167,18,'Cochapeti'),
(168,18,'Culebras'),
(169,18,'Huayan'),
(170,18,'Malvas'),
(171,19,'Piscobamba'),
(172,19,'Casca'),
(173,19,'Eleazar Guzmán Barrón'),
(174,19,'Fidel Olivas Escudero'),
(175,19,'Llama'),
(176,19,'Llumpa'),
(177,19,'Lucma'),
(178,19,'Musga'),
(179,20,'Ocros'),
(180,20,'Acas'),
(181,20,'Cajamarquilla'),
(182,20,'Carhuapampa'),
(183,20,'Cochas'),
(184,20,'Congas'),
(185,20,'Llipa'),
(186,20,'San Cristóbal de Rajan'),
(187,20,'San Pedro'),
(188,20,'Santiago de Chilcas'),
(189,21,'Cabana'),
(190,21,'Bolognesi'),
(191,21,'Conchucos'),
(192,21,'Huacaschuque'),
(193,21,'Huandoval'),
(194,21,'Lacabamba'),
(195,21,'Llapo'),
(196,21,'Pallasca'),
(197,21,'Pampas'),
(198,21,'Santa Rosa'),
(199,21,'Tauca'),
(200,22,'Pomabamba'),
(201,22,'Huayllan'),
(202,22,'Parobamba'),
(203,22,'Quinuabamba'),
(204,23,'Recuay'),
(205,23,'Catac'),
(206,23,'Cotaparaco'),
(207,23,'Huayllapampa'),
(208,23,'Llacllin'),
(209,23,'Marca'),
(210,23,'Pampas Chico'),
(211,23,'Pararin'),
(212,23,'Tapacocha'),
(213,23,'Ticapampa'),
(214,24,'Chimbote'),
(215,24,'Cáceres del Perú'),
(216,24,'Coishco'),
(217,24,'Macate'),
(218,24,'Moro'),
(219,24,'Nepeña'),
(220,24,'Samanco'),
(221,24,'Santa'),
(222,24,'Nuevo Chimbote'),
(223,25,'Sihuas'),
(224,25,'Acobamba'),
(225,25,'Alfonso Ugarte'),
(226,25,'Cashapampa'),
(227,25,'Chingalpo'),
(228,25,'Huayllabamba'),
(229,25,'Quiches'),
(230,25,'Ragash'),
(231,25,'San Juan'),
(232,25,'Sicsibamba'),
(233,26,'Yungay'),
(234,26,'Cascapara'),
(235,26,'Mancos'),
(236,26,'Matacoto'),
(237,26,'Quillo'),
(238,26,'Ranrahirca'),
(239,26,'Shupluy'),
(240,26,'Yanama'),
(241,27,'Abancay'),
(242,27,'Chacoche'),
(243,27,'Circa'),
(244,27,'Curahuasi'),
(245,27,'Huanipaca'),
(246,27,'Lambrama'),
(247,27,'Pichirhua'),
(248,27,'San Pedro de Cachora'),
(249,27,'Tamburco'),
(250,28,'Andahuaylas'),
(251,28,'Andarapa'),
(252,28,'Chiara'),
(253,28,'Huancarama'),
(254,28,'Huancaray'),
(255,28,'Huayana'),
(256,28,'José María Arguedas'),
(257,28,'Kaquiabamba'),
(258,28,'Kishuara'),
(259,28,'Pacobamba'),
(260,28,'Pacucha'),
(261,28,'Pampachiri'),
(262,28,'Pomacocha'),
(263,28,'San Antonio de Cachi'),
(264,28,'San Jerónimo'),
(265,28,'San Miguel de Chaccrampa'),
(266,28,'Santa María de Chicmo'),
(267,28,'Talavera'),
(268,28,'Tumay Huaraca'),
(269,28,'Turpo'),
(270,29,'Antabamba'),
(271,29,'El Oro'),
(272,29,'Huaquirca'),
(273,29,'Juan Espinoza Medrano'),
(274,29,'Oropesa'),
(275,29,'Pachaconas'),
(276,29,'Sabaino'),
(277,30,'Chalhuanca'),
(278,30,'Capaya'),
(279,30,'Caraybamba'),
(280,30,'Chapimarca'),
(281,30,'Colcabamba'),
(282,30,'Cotaruse'),
(283,30,'Ihuayllo'),
(284,30,'Justo Apu Sahuaraura'),
(285,30,'Lucre'),
(286,30,'Pocohuanca'),
(287,30,'San Juan de Chacña'),
(288,30,'Sañayca'),
(289,30,'Soraya'),
(290,30,'Tapairihua'),
(291,30,'Tintay'),
(292,30,'Toraya'),
(293,30,'Yanaca'),
(294,31,'Tambobamba'),
(295,31,'Cotabambas'),
(296,31,'Coyllurqui'),
(297,31,'Haquira'),
(298,31,'Mara'),
(299,31,'Challhuahuacho'),
(300,32,'Chincheros'),
(301,32,'Anco-Huallo'),
(302,32,'Cocharcas'),
(303,32,'Huaccana'),
(304,32,'Ocobamba'),
(305,32,'Ongoy'),
(306,32,'Uranmarca'),
(307,32,'Ranracancha'),
(308,32,'Rocchacc'),
(309,33,'Chuquibambilla'),
(310,33,'Curpahuasi'),
(311,33,'Gamarra'),
(312,33,'Huayllati'),
(313,33,'Mamara'),
(314,33,'Micaela Bastidas'),
(315,33,'Pataypampa'),
(316,33,'Progreso'),
(317,33,'San Antonio'),
(318,33,'Santa Rosa'),
(319,33,'Turpay'),
(320,33,'Vilcabamba'),
(321,33,'Virundo'),
(322,33,'Curasco'),
(323,34,'Arequipa'),
(324,34,'Alto Selva Alegre'),
(325,34,'Cayma'),
(326,34,'Cerro Colorado'),
(327,34,'Characato'),
(328,34,'Chiguata'),
(329,34,'Jacobo Hunter'),
(330,34,'La Joya'),
(331,34,'Mariano Melgar'),
(332,34,'Miraflores'),
(333,34,'Mollebaya'),
(334,34,'Paucarpata'),
(335,34,'Pocsi'),
(336,34,'Polobaya'),
(337,34,'Quequeña'),
(338,34,'Sabandía'),
(339,34,'Sachaca'),
(340,34,'San Juan de Siguas'),
(341,34,'San Juan de Tarucani'),
(342,34,'Santa Isabel de Siguas'),
(343,34,'Santa Rita de Siguas'),
(344,34,'Socabaya'),
(345,34,'Tiabaya'),
(346,34,'Uchumayo'),
(347,34,'Vitor'),
(348,34,'Yanahuara'),
(349,34,'Yarabamba'),
(350,34,'Yura'),
(351,35,'Camaná'),
(352,35,'José María Quimper'),
(353,35,'Mariano Nicolás Valcárcel'),
(354,35,'Mariscal Cáceres'),
(355,35,'Nicolás de Piérola'),
(356,35,'Ocoña'),
(357,35,'Quilca'),
(358,35,'Samuel Pastor'),
(359,36,'Caravelí'),
(360,36,'Acarí'),
(361,36,'Atico'),
(362,36,'Atiquipa'),
(363,36,'Bella Unión'),
(364,36,'Cahuacho'),
(365,36,'Chala'),
(366,36,'Chaparra'),
(367,36,'Huanuhuanu'),
(368,36,'Jaqui'),
(369,36,'Lomas'),
(370,36,'Quicacha'),
(371,36,'Yauca'),
(372,37,'Aplao'),
(373,37,'Andagua'),
(374,37,'Ayo'),
(375,37,'Chachas'),
(376,37,'Chilcaymarca'),
(377,37,'Choco'),
(378,37,'Huancarqui'),
(379,37,'Machaguay'),
(380,37,'Orcopampa'),
(381,37,'Pampacolca'),
(382,37,'Tipán'),
(383,37,'Uñón'),
(384,37,'Uraca'),
(385,37,'Viraco'),
(386,38,'Chivay'),
(387,38,'Achoma'),
(388,38,'Cabanaconde'),
(389,38,'Callalli'),
(390,38,'Caylloma'),
(391,38,'Coporaque'),
(392,38,'Huambo'),
(393,38,'Huanca'),
(394,38,'Ichupampa'),
(395,38,'Lari'),
(396,38,'Lluta'),
(397,38,'Maca'),
(398,38,'Madrigal'),
(399,38,'San Antonio de Chuca'),
(400,38,'Sibayo'),
(401,38,'Tapay'),
(402,38,'Tisco'),
(403,38,'Tuti'),
(404,38,'Yanque'),
(405,39,'Chuquibamba'),
(406,39,'Andaray'),
(407,39,'Cayarani'),
(408,39,'Chichas'),
(409,39,'Iray'),
(410,39,'Río Grande'),
(411,39,'Salamanca'),
(412,39,'Yanaquihua'),
(413,40,'Mollendo'),
(414,40,'Cocachacra'),
(415,40,'Dean Valdivia'),
(416,40,'Islay'),
(417,40,'Mejía'),
(418,40,'Punta de Bombón'),
(419,41,'Cotahuasi'),
(420,41,'Alca'),
(421,41,'Charcana'),
(422,41,'Huaynacotas'),
(423,41,'Pampamarca'),
(424,41,'Puyca'),
(425,41,'Quechualla'),
(426,41,'Sayla'),
(427,41,'Tauría'),
(428,41,'Tomepampa'),
(429,41,'Toro'),
(430,42,'Cangallo'),
(431,42,'Chuschi'),
(432,42,'Los Morochucos'),
(433,42,'María Parado de Bellido'),
(434,42,'Paras'),
(435,42,'Totos'),
(436,43,'Ayacucho'),
(437,43,'Acocro'),
(438,43,'Acos Vinchos'),
(439,43,'Carmen Alto'),
(440,43,'Chiara'),
(441,43,'Jesús Nazareno'),
(442,43,'Ocros'),
(443,43,'Pacaycasa'),
(444,43,'Quinua'),
(445,43,'San José de Ticllas'),
(446,43,'San Juan Bautista'),
(447,43,'Santiago de Pischa'),
(448,43,'Socos'),
(449,43,'Tambillo'),
(450,43,'Vinchos'),
(451,43,'Andrés Avelino Cáceres Dorregaray'),
(452,44,'Sancos'),
(453,44,'Carapo'),
(454,44,'Sacsamarca'),
(455,44,'Santiago de Lucanamarca'),
(456,45,'Huanta'),
(457,45,'Ayahuanco'),
(458,45,'Huamanguilla'),
(459,45,'Iguain'),
(460,45,'Luricocha'),
(461,45,'Santillana'),
(462,45,'Sivia'),
(463,45,'Llochegua'),
(464,45,'Canayre'),
(465,45,'Uchuraccay'),
(466,45,'Pucacolpa'),
(467,46,'San Miguel'),
(468,46,'Anco'),
(469,46,'Ayna'),
(470,46,'Chilcas'),
(471,46,'Chungui'),
(472,46,'Luis Carranza'),
(473,46,'Santa Rosa'),
(474,46,'Tambo'),
(475,46,'Samugari'),
(476,46,'Anchihuay'),
(477,47,'Puquio'),
(478,47,'Aucara'),
(479,47,'Cabana'),
(480,47,'Carmen Salcedo'),
(481,47,'Chaviña'),
(482,47,'Chipao'),
(483,47,'Huac-Huas'),
(484,47,'Laramate'),
(485,47,'Leoncio Prado'),
(486,47,'Llauta'),
(487,47,'Lucanas'),
(488,47,'Ocaña'),
(489,47,'Otoca'),
(490,47,'Saisa'),
(491,47,'San Cristóbal'),
(492,47,'San Juan'),
(493,47,'San Pedro'),
(494,47,'San Pedro de Palco'),
(495,47,'Sancos'),
(496,47,'Santa Ana de Huaycahuacho'),
(497,48,'Coracora'),
(498,48,'Chumpi'),
(499,48,'Coronel Castañeda'),
(500,48,'Pacapausa'),
(501,48,'Pullo'),
(502,48,'Puyusca'),
(503,48,'San Francisco de Ravacayco'),
(504,48,'Upahuacho'),
(505,49,'Pausa'),
(506,49,'Colta'),
(507,49,'Corculla'),
(508,49,'Lampa'),
(509,49,'Marcabamba'),
(510,49,'Oyolo'),
(511,49,'Pararca'),
(512,49,'San Javier de Alpabamba'),
(513,49,'San José de Ushua'),
(514,49,'Sara Sara'),
(515,50,'Querobamba'),
(516,50,'Belén'),
(517,50,'Chalcos'),
(518,50,'San Pedro de Larcay'),
(519,50,'San Salvador de Quije'),
(520,50,'Santiago de Paucaray'),
(521,50,'Soras'),
(522,51,'Huancapi'),
(523,51,'Alcamenca'),
(524,51,'Apongo'),
(525,51,'Asquipata'),
(526,51,'Canaria'),
(527,51,'Cayara'),
(528,51,'Colca'),
(529,51,'Huamanquiquia'),
(530,51,'Huancaraylla'),
(531,51,'Huaya'),
(532,51,'Sarhua'),
(533,51,'Vilcanchos'),
(534,52,'Vilcas Huamán'),
(535,52,'Accomarca'),
(536,52,'Carhuanca'),
(537,52,'Concepción'),
(538,52,'Huambalpa'),
(539,52,'Independencia'),
(540,52,'Saurama'),
(541,52,'Vischongo'),
(542,53,'Cajabamba'),
(543,53,'Cachachi'),
(544,53,'Condebamba'),
(545,53,'Sitacocha'),
(546,54,'Cajamarca'),
(547,54,'Asunción'),
(548,54,'Chetilla'),
(549,54,'Cospán'),
(550,54,'Jesús'),
(551,54,'Los Baños del Inca'),
(552,54,'Magdalena'),
(553,54,'Matara'),
(554,54,'Namora'),
(555,54,'San Juan'),
(556,55,'Celendín'),
(557,55,'Chumuch'),
(558,55,'Cortegana'),
(559,55,'Huasmin'),
(560,55,'Jorge Chávez'),
(561,55,'José Gálvez'),
(562,55,'Miguel Iglesias'),
(563,55,'Oxamarca'),
(564,55,'Sorochuco'),
(565,55,'Sucre'),
(566,55,'Utco'),
(567,55,'La Libertad de Pallán'),
(568,56,'Chota'),
(569,56,'Anguía'),
(570,56,'Chadin'),
(571,56,'Chiguirip'),
(572,56,'Chimban'),
(573,56,'Choropampa'),
(574,56,'Cochabamba'),
(575,56,'Conchán'),
(576,56,'Huambos'),
(577,56,'Lajas'),
(578,56,'Llama'),
(579,56,'Miracosta'),
(580,56,'Paccha'),
(581,56,'Pion'),
(582,56,'Querocoto'),
(583,56,'San Juan de Licupis'),
(584,56,'Tacabamba'),
(585,56,'Tocmoche'),
(586,56,'Chalamarca'),
(587,57,'Contumazá'),
(588,57,'Chilete'),
(589,57,'Cupisnique'),
(590,57,'Guzmango'),
(591,57,'San Benito'),
(592,57,'Santa Cruz de Toledo'),
(593,57,'Tantarica'),
(594,57,'Yonan'),
(595,58,'Cutervo'),
(596,58,'Callayuc'),
(597,58,'Choros'),
(598,58,'Cujillo'),
(599,58,'La Ramada'),
(600,58,'Pimpingos'),
(601,58,'Querocotillo'),
(602,58,'San Andrés de Cutervo'),
(603,58,'San Juan de Cutervo'),
(604,58,'San Luis de Lucma'),
(605,58,'Santa Cruz'),
(606,58,'Santo Domingo de la Capilla'),
(607,58,'Santo Tomás'),
(608,58,'Socota'),
(609,58,'Toribio Casanova'),
(610,59,'Bambamarca'),
(611,59,'Chugur'),
(612,59,'Hualgayoc'),
(613,60,'Jaén'),
(614,60,'Bellavista'),
(615,60,'Chontali'),
(616,60,'Colasay'),
(617,60,'Huabal'),
(618,60,'Las Pirias'),
(619,60,'Pomahuaca'),
(620,60,'Pucará'),
(621,60,'Sallique'),
(622,60,'San Felipe'),
(623,60,'San José del Alto'),
(624,60,'Santa Rosa'),
(625,61,'San Ignacio'),
(626,61,'Chirinos'),
(627,61,'Huarango'),
(628,61,'La Coipa'),
(629,61,'Namballe'),
(630,61,'San José de Lourdes'),
(631,61,'Tabaconas'),
(632,62,'Pedro Gálvez'),
(633,62,'Chancay'),
(634,62,'Eduardo Villanueva'),
(635,62,'Gregorio Pita'),
(636,62,'Ichocán'),
(637,62,'José Manuel Quiroz'),
(638,62,'José Sabogal'),
(639,63,'San Miguel'),
(640,63,'Bolívar'),
(641,63,'Calquis'),
(642,63,'Catilluc'),
(643,63,'El Prado'),
(644,63,'La Florida'),
(645,63,'Llapa'),
(646,63,'Nanchoc'),
(647,63,'Niepos'),
(648,63,'San Gregorio'),
(649,63,'San Silvestre de Cochan'),
(650,63,'Tongod'),
(651,63,'Unión Agua Blanca'),
(652,64,'San Pablo'),
(653,64,'San Bernardino'),
(654,64,'San Luis'),
(655,64,'Tumbadén'),
(656,65,'Santa Cruz'),
(657,65,'Andabamba'),
(658,65,'Catache'),
(659,65,'Chancaybaños'),
(660,65,'La Esperanza'),
(661,65,'Ninabamba'),
(662,65,'Pulán'),
(663,65,'Saucepampa'),
(664,65,'Sexi'),
(665,65,'Uticyacu'),
(666,65,'Yauyucan'),
(667,66,'Callao'),
(668,66,'Bellavista'),
(669,66,'Carmen de la Legua Reynoso'),
(670,66,'La Perla'),
(671,66,'La Punta'),
(672,66,'Ventanilla'),
(673,66,'Mi Perú'),
(674,67,'Acomayo'),
(675,67,'Acopia'),
(676,67,'Acos'),
(677,67,'Mosoc Llacta'),
(678,67,'Pomacanchi'),
(679,67,'Rondocan'),
(680,67,'Sangarará'),
(681,68,'Anta'),
(682,68,'Ancahuasi'),
(683,68,'Cachimayo'),
(684,68,'Chinchaypujio'),
(685,68,'Huarocondo'),
(686,68,'Limatambo'),
(687,68,'Mollepata'),
(688,68,'Pucyura'),
(689,68,'Zurite'),
(690,69,'Calca'),
(691,69,'Coya'),
(692,69,'Lamay'),
(693,69,'Lares'),
(694,69,'Pisac'),
(695,69,'San Salvador'),
(696,69,'Taray'),
(697,69,'Yanatile'),
(698,70,'Yanaoca'),
(699,70,'Checca'),
(700,70,'Kunturkanki'),
(701,70,'Langui'),
(702,70,'Layo'),
(703,70,'Pampamarca'),
(704,70,'Quehue'),
(705,70,'Tupac Amaru'),
(706,71,'Sicuani'),
(707,71,'Checacupe'),
(708,71,'Combapata'),
(709,71,'Marangani'),
(710,71,'Pitumarca'),
(711,71,'San Pablo'),
(712,71,'San Pedro'),
(713,71,'Tinta'),
(714,72,'Santo Tomás'),
(715,72,'Capacmarca'),
(716,72,'Chamaca'),
(717,72,'Colquemarca'),
(718,72,'Livitaca'),
(719,72,'Llusco'),
(720,72,'Quiñota'),
(721,72,'Velille'),
(722,73,'Cusco'),
(723,73,'Ccorca'),
(724,73,'Poroy'),
(725,73,'San Jerónimo'),
(726,73,'San Sebastián'),
(727,73,'Santiago'),
(728,73,'Saylla'),
(729,73,'Wanchaq'),
(730,74,'Espinar'),
(731,74,'Condoroma'),
(732,74,'Coporaque'),
(733,74,'Ocoruro'),
(734,74,'Pallpata'),
(735,74,'Pichigua'),
(736,74,'Suyckutambo'),
(737,74,'Alto Pichigua'),
(738,75,'Quillabamba'),
(739,75,'Echarati'),
(740,75,'Huayopata'),
(741,75,'Maranura'),
(742,75,'Ocobamba'),
(743,75,'Santa Ana'),
(744,75,'Santa Teresa'),
(745,75,'Vilcabamba'),
(746,76,'Paruro'),
(747,76,'Accha'),
(748,76,'Ccapi'),
(749,76,'Colcha'),
(750,76,'Huanoquite'),
(751,76,'Omacha'),
(752,76,'Paccaritambo'),
(753,76,'Pillpinto'),
(754,76,'Yaurisque'),
(755,77,'Paucartambo'),
(756,77,'Caicay'),
(757,77,'Challabamba'),
(758,77,'Colquepata'),
(759,77,'Huancarani'),
(760,77,'Kosñipata'),
(761,78,'Urcos'),
(762,78,'Andahuaylillas'),
(763,78,'Camanti'),
(764,78,'Ccarhuayo'),
(765,78,'Ccatca'),
(766,78,'Cusipata'),
(767,78,'Huaro'),
(768,78,'Lucre'),
(769,78,'Marcapata'),
(770,78,'Ocongate'),
(771,78,'Oropesa'),
(772,78,'Quiquijana'),
(773,79,'Urubamba'),
(774,79,'Chinchero'),
(775,79,'Huayllabamba'),
(776,79,'Machupicchu'),
(777,79,'Maras'),
(778,79,'Ollantaytambo'),
(779,79,'Yucay'),
(780,80,'Acobamba'),
(781,80,'Andabamba'),
(782,80,'Anta'),
(783,80,'Caja'),
(784,80,'Marcas'),
(785,80,'Paucara'),
(786,80,'Pomacocha'),
(787,80,'Rosario'),
(788,81,'Lircay'),
(789,81,'Anchonga'),
(790,81,'Callanmarca'),
(791,81,'Ccochaccasa'),
(792,81,'Chincho'),
(793,81,'Congalla'),
(794,81,'Huanca-Huanca'),
(795,81,'Huayllay Grande'),
(796,81,'Julcamarca'),
(797,81,'San Antonio de Antaparco'),
(798,81,'Santo Tomas de Pata'),
(799,81,'Secclla'),
(800,82,'Castrovirreyna'),
(801,82,'Arma'),
(802,82,'Aurahua'),
(803,82,'Capillas'),
(804,82,'Chupamarca'),
(805,82,'Cocas'),
(806,82,'Huachos'),
(807,82,'Huamatambo'),
(808,82,'Mollepampa'),
(809,82,'San Juan'),
(810,82,'Santa Ana'),
(811,82,'Tantara'),
(812,82,'Ticrapo'),
(813,83,'Churcampa'),
(814,83,'Anco'),
(815,83,'Chinchihuasi'),
(816,83,'El Carmen'),
(817,83,'La Merced'),
(818,83,'Locroja'),
(819,83,'Paucarbamba'),
(820,83,'San Miguel de Mayocc'),
(821,83,'San Pedro de Coris'),
(822,83,'Pachamarca'),
(823,83,'Cosme'),
(824,84,'Huancavelica'),
(825,84,'Acobambilla'),
(826,84,'Acoria'),
(827,84,'Conayca'),
(828,84,'Cuenca'),
(829,84,'Huachocolpa'),
(830,84,'Huayllahuara'),
(831,84,'Izcuchaca'),
(832,84,'Laria'),
(833,84,'Manta'),
(834,84,'Mariscal Cáceres'),
(835,84,'Moya'),
(836,84,'Nuevo Occoro'),
(837,84,'Palca'),
(838,84,'Pilchaca'),
(839,84,'Vilca'),
(840,84,'Yauli'),
(841,84,'Ascensión'),
(842,85,'Huaytará'),
(843,85,'Ayaví'),
(844,85,'Córdova'),
(845,85,'Huayacundo Arma'),
(846,85,'Laramarca'),
(847,85,'Ocoyo'),
(848,85,'Pilpichaca'),
(849,85,'Querco'),
(850,85,'Quito-Arma'),
(851,85,'San Antonio de Cusicancha'),
(852,85,'San Francisco de Sangayaico'),
(853,85,'San Isidro'),
(854,85,'Santiago de Chocorvos'),
(855,85,'Santiago de Quirahuara'),
(856,85,'Santo Domingo de Capillas'),
(857,85,'Tambo'),
(858,86,'Pampas'),
(859,86,'Acostambo'),
(860,86,'Acraquia'),
(861,86,'Ahuaycha'),
(862,86,'Colcabamba'),
(863,86,'Daniel Hernández'),
(864,86,'Huachocolpa'),
(865,86,'Huaribamba'),
(866,86,'Ñahuimpuquio'),
(867,86,'Pazos'),
(868,86,'Quishuar'),
(869,86,'Salcabamba'),
(870,86,'Salcahuasi'),
(871,86,'San Marcos de Rocchac'),
(872,86,'Surcubamba'),
(873,86,'Tintay Puncu'),
(874,86,'Quichuas'),
(875,86,'Andaymarca'),
(876,86,'Roble'),
(877,86,'Santiago de Tucuma'),
(878,87,'Ambo'),
(879,87,'Cayna'),
(880,87,'Colpas'),
(881,87,'Conchamarca'),
(882,87,'Huacar'),
(883,87,'San Francisco'),
(884,87,'San Rafael'),
(885,87,'Tomay Kichwa'),
(886,88,'La Unión'),
(887,88,'Chuquis'),
(888,88,'Marías'),
(889,88,'Pachas'),
(890,88,'Quivilla'),
(891,88,'Ripan'),
(892,88,'Shunqui'),
(893,88,'Sillapata'),
(894,88,'Yanas'),
(895,89,'Huacaybamba'),
(896,89,'Canchabamba'),
(897,89,'Cochabamba'),
(898,89,'Pinra'),
(899,90,'Llata'),
(900,90,'Arancay'),
(901,90,'Chavín de Pariarca'),
(902,90,'Jacas Grande'),
(903,90,'Jircan'),
(904,90,'Miraflores'),
(905,90,'Monzón'),
(906,90,'Punchao'),
(907,90,'Puños'),
(908,90,'Singa'),
(909,90,'Tantamayo'),
(910,91,'Huánuco'),
(911,91,'Amarilis'),
(912,91,'Chinchao'),
(913,91,'Churubamba'),
(914,91,'Margos'),
(915,91,'Quisqui (Kichki)'),
(916,91,'San Francisco de Cayrán'),
(917,91,'San Pedro de Chaulán'),
(918,91,'Santa María del Valle'),
(919,91,'Yarumayo'),
(920,91,'Pillco Marca'),
(921,92,'Jesús'),
(922,92,'Baños'),
(923,92,'Jivia'),
(924,92,'Queropalca'),
(925,92,'Rondos'),
(926,92,'San Francisco de Asís'),
(927,92,'San Miguel de Cauri'),
(928,93,'Rupa Rupa'),
(929,93,'Daniel Alomía Robles'),
(930,93,'Hermílio Valdizán'),
(931,93,'José Crespo y Castillo'),
(932,93,'Luyando'),
(933,93,'Mariano Dámaso Beraún'),
(934,94,'Huacrachuco'),
(935,94,'Cholon'),
(936,94,'San Buenaventura'),
(937,95,'Panao'),
(938,95,'Chaglla'),
(939,95,'Molino'),
(940,95,'Umari'),
(941,96,'Puerto Inca'),
(942,96,'Codo del Pozuzo'),
(943,96,'Honoria'),
(944,96,'Tournavista'),
(945,96,'Yuyapichis'),
(946,97,'Chavinillo'),
(947,97,'Cahuac'),
(948,97,'Chacabamba'),
(949,97,'Aparicio Pomares'),
(950,97,'Jacas Chico'),
(951,97,'Obas'),
(952,97,'Pampamarca'),
(953,97,'Choras'),
(954,98,'Alto Larán'),
(955,98,'Chincha Alta'),
(956,98,'Chincha Baja'),
(957,98,'El Carmen'),
(958,98,'Grocio Prado'),
(959,98,'Pueblo Nuevo'),
(960,98,'San Juan de Yanac'),
(961,98,'San Pedro de Huacarpana'),
(962,98,'Sunampe'),
(963,98,'Tambo de Mora'),
(964,99,'Ica'),
(965,99,'La Tinguiña'),
(966,99,'Los Aquijes'),
(967,99,'Ocucaje'),
(968,99,'Pachacútec'),
(969,99,'Parcona'),
(970,99,'Pueblo Nuevo'),
(971,99,'Salas'),
(972,99,'San José de los Molinos'),
(973,99,'San Juan Bautista'),
(974,99,'Santiago'),
(975,99,'Tate'),
(976,99,'Yauca del Rosario'),
(977,100,'Changuillo'),
(978,100,'El Ingenio'),
(979,100,'Marcona'),
(980,100,'Nazca'),
(981,100,'Vista Alegre'),
(982,101,'Llipata'),
(983,101,'Palpa'),
(984,101,'Río Grande'),
(985,101,'Santa Cruz'),
(986,101,'Tibillo'),
(987,102,'Huancano'),
(988,102,'Humay'),
(989,102,'Independencia'),
(990,102,'Paracas'),
(991,102,'Pisco'),
(992,102,'San Andrés'),
(993,102,'San Clemente'),
(994,102,'Túpac Amaru Inca'),
(995,103,'Chanchamayo'),
(996,103,'Perene'),
(997,103,'Pichanaqui'),
(998,103,'San Luis de Shuaro'),
(999,103,'San Ramón'),
(1000,103,'Vitoc'),
(1001,104,'Ahuac'),
(1002,104,'Chongos Bajo'),
(1003,104,'Chupaca'),
(1004,104,'Huachac'),
(1005,104,'Huamancaca Chico'),
(1006,104,'San Juan de Iscos'),
(1007,104,'San Juan de Jarpa'),
(1008,104,'Tres de Diciembre'),
(1009,104,'Yanacancha'),
(1010,105,'Aco'),
(1011,105,'Andamarca'),
(1012,105,'Chambara'),
(1013,105,'Cochas'),
(1014,105,'Comas'),
(1015,105,'Concepción'),
(1016,105,'Heroínas Toledo'),
(1017,105,'Manzanares'),
(1018,105,'Mariscal Castilla'),
(1019,105,'Matahuasi'),
(1020,105,'Mito'),
(1021,105,'Nueve de Julio'),
(1022,105,'Orcotuna'),
(1023,105,'San José de Quero'),
(1024,105,'Santa Rosa de Ocopa'),
(1025,106,'Carhuacallanga'),
(1026,106,'Chacapampa'),
(1027,106,'Chicche'),
(1028,106,'Chilca'),
(1029,106,'Chongos Alto'),
(1030,106,'Chupuro'),
(1031,106,'Colca'),
(1032,106,'Cullhuas'),
(1033,106,'El Tambo'),
(1034,106,'Huancayo'),
(1035,106,'Huacrapuquio'),
(1036,106,'Hualhuas'),
(1037,106,'Huancan'),
(1038,106,'Huasicancha'),
(1039,106,'Huayucachi'),
(1040,106,'Ingenio'),
(1041,106,'Pariahuanca'),
(1042,106,'Pilcomayo'),
(1043,106,'Pucara'),
(1044,106,'Quichuay'),
(1045,106,'Quilcas'),
(1046,106,'San Agustín'),
(1047,106,'San Jerónimo de Tunán'),
(1048,106,'Santo Domingo de Acobamba'),
(1049,106,'Sapallanga'),
(1050,106,'Sicaya'),
(1051,106,'Viques'),
(1052,107,'Acolla'),
(1053,107,'Apata'),
(1054,107,'Ataura'),
(1055,107,'Canchayllo'),
(1056,107,'Curicaca'),
(1057,107,'El Mantaro'),
(1058,107,'Huamali'),
(1059,107,'Huaripampa'),
(1060,107,'Huertas'),
(1061,107,'Janjaillo'),
(1062,107,'Jauja'),
(1063,107,'Julcán'),
(1064,107,'Leonor Ordóñez'),
(1065,107,'Llocllapampa'),
(1066,107,'Marco'),
(1067,107,'Masma'),
(1068,107,'Masma Chicche'),
(1069,107,'Molinos'),
(1070,107,'Monobamba'),
(1071,107,'Muqui'),
(1072,107,'Muquiyauyo'),
(1073,107,'Paca'),
(1074,107,'Paccha'),
(1075,107,'Pancan'),
(1076,107,'Parco'),
(1077,107,'Pomacancha'),
(1078,107,'Ricran'),
(1079,107,'San Lorenzo'),
(1080,107,'San Pedro de Chunan'),
(1081,107,'Sincos'),
(1082,107,'Tunanmarca'),
(1083,107,'Yauli'),
(1084,107,'Yauyos'),
(1085,108,'Carhuamayo'),
(1086,108,'Junín'),
(1087,108,'Ondores'),
(1088,108,'Ulcumayo'),
(1089,109,'Coviriali'),
(1090,109,'Llaylla'),
(1091,109,'Mazamari'),
(1092,109,'Pampa Hermosa'),
(1093,109,'Pangoa'),
(1094,109,'Río Negro'),
(1095,109,'Río Tambo'),
(1096,109,'Satipo'),
(1097,110,'Acobamba'),
(1098,110,'Huaricolca'),
(1099,110,'Huasahuasi'),
(1100,110,'La Unión'),
(1101,110,'Palca'),
(1102,110,'Palcamayo'),
(1103,110,'San Pedro de Cajas'),
(1104,110,'Tarma'),
(1105,111,'Huay-Huay'),
(1106,111,'La Oroya'),
(1107,111,'Marcapomacocha'),
(1108,111,'Morococha'),
(1109,111,'Paccha'),
(1110,111,'Santa Bárbara de Carhuacayan'),
(1111,111,'Santa Rosa de Sacco'),
(1112,111,'Suitucancha'),
(1113,111,'Yauli'),
(1114,112,'Ascope'),
(1115,112,'Chicama'),
(1116,112,'Chocope'),
(1117,112,'Magdalena de Cao'),
(1118,112,'Paiján'),
(1119,112,'Rázuri'),
(1120,112,'Santiago de Cao'),
(1121,112,'Casa Grande'),
(1122,113,'Bolívar'),
(1123,113,'Bambamarca'),
(1124,113,'Condormarca'),
(1125,113,'Longotea'),
(1126,113,'Uchumarca'),
(1127,113,'Ucuncha'),
(1128,114,'Chepén'),
(1129,114,'Pacanga'),
(1130,114,'Pueblo Nuevo'),
(1131,115,'Cascas'),
(1132,115,'Lucma'),
(1133,115,'Marmot'),
(1134,115,'Sayapullo'),
(1135,116,'Julcán'),
(1136,116,'Calamarca'),
(1137,116,'Carabamba'),
(1138,116,'Huaso'),
(1139,117,'Otuzco'),
(1140,117,'Agallpampa'),
(1141,117,'Charat'),
(1142,117,'Huaranchal'),
(1143,117,'La Cuesta'),
(1144,117,'Mache'),
(1145,117,'Paranday'),
(1146,117,'Salpo'),
(1147,117,'Sinsicap'),
(1148,117,'Usquil'),
(1149,118,'San Pedro de Lloc'),
(1150,118,'Guadalupe'),
(1151,118,'Jequetepeque'),
(1152,118,'Pacasmayo'),
(1153,118,'San José'),
(1154,119,'Tayabamba'),
(1155,119,'Buldibuyo'),
(1156,119,'Chillia'),
(1157,119,'Huancaspata'),
(1158,119,'Huaylillas'),
(1159,119,'Huayo'),
(1160,119,'Ongón'),
(1161,119,'Parcoy'),
(1162,119,'Pataz'),
(1163,119,'Pías'),
(1164,119,'Santiago de Challas'),
(1165,119,'Taurija'),
(1166,119,'Urpay'),
(1167,120,'Huamachuco'),
(1168,120,'Chugay'),
(1169,120,'Cochorco'),
(1170,120,'Curgos'),
(1171,120,'Marcabal'),
(1172,120,'Sanagorán'),
(1173,120,'Sarin'),
(1174,120,'Sartimbamba'),
(1175,121,'Santiago de Chuco'),
(1176,121,'Angasmarca'),
(1177,121,'Cachicadán'),
(1178,121,'Mollebamba'),
(1179,121,'Mollepata'),
(1180,121,'Quiruvilca'),
(1181,121,'Santa Cruz de Chuca'),
(1182,121,'Sitabamba'),
(1183,122,'Trujillo'),
(1184,122,'El Porvenir'),
(1185,122,'Florencia de Mora'),
(1186,122,'Huanchaco'),
(1187,122,'La Esperanza'),
(1188,122,'Laredo'),
(1189,122,'Moche'),
(1190,122,'Poroto'),
(1191,122,'Salaverry'),
(1192,122,'Simbal'),
(1193,122,'Víctor Larco Herrera'),
(1194,123,'Virú'),
(1195,123,'Chao'),
(1196,123,'Guadalupito'),
(1197,124,'Chiclayo'),
(1198,124,'Chongoyape'),
(1199,124,'Eten'),
(1200,124,'Eten Puerto'),
(1201,124,'José Leonardo Ortiz'),
(1202,124,'La Victoria'),
(1203,124,'Lagunas'),
(1204,124,'Monsefú'),
(1205,124,'Nueva Arica'),
(1206,124,'Oyotún'),
(1207,124,'Patapo'),
(1208,124,'Picsi'),
(1209,124,'Pimentel'),
(1210,124,'Pomalca'),
(1211,124,'Pucalá'),
(1212,124,'Reque'),
(1213,124,'Santa Rosa'),
(1214,124,'Saña'),
(1215,124,'Tuman'),
(1216,125,'Cañaris'),
(1217,125,'Ferreñafe'),
(1218,125,'Incahuasi'),
(1219,125,'Manuel Antonio Mesones Muro'),
(1220,125,'Pitipo'),
(1221,125,'Pueblo Nuevo'),
(1222,126,'Chochope'),
(1223,126,'Illimo'),
(1224,126,'Jayanca'),
(1225,126,'Lambayeque'),
(1226,126,'Mochumí'),
(1227,126,'Morrope'),
(1228,126,'Motupe'),
(1229,126,'Olmos'),
(1230,126,'Pacora'),
(1231,126,'Salas'),
(1232,126,'San José'),
(1233,126,'Túcume'),
(1234,127,'Barranca'),
(1235,127,'Paramonga'),
(1236,127,'Pativilca'),
(1237,127,'Supe'),
(1238,127,'Supe Puerto'),
(1239,128,'Cajatambo'),
(1240,128,'Copa'),
(1241,128,'Gorgor'),
(1242,128,'Huancapon'),
(1243,128,'Manas'),
(1244,129,'Arahuay'),
(1245,129,'Canta'),
(1246,129,'Huamantanga'),
(1247,129,'Huaros'),
(1248,129,'Lachaqui'),
(1249,129,'San Buenaventura'),
(1250,129,'Santa Rosa de Quives'),
(1251,130,'Asia'),
(1252,130,'Calango'),
(1253,130,'Cerro Azul'),
(1254,130,'Chilca'),
(1255,130,'Coayllo'),
(1256,130,'Imperial'),
(1257,130,'Lunahuana'),
(1258,130,'Mala'),
(1259,130,'Nuevo Imperial'),
(1260,130,'Pacaran'),
(1261,130,'Quilmana'),
(1262,130,'San Antonio'),
(1263,130,'San Luis'),
(1264,130,'Santa Cruz de Flores'),
(1265,130,'Zuniga'),
(1266,131,'Atavillos Alto'),
(1267,131,'Atavillos Bajo'),
(1268,131,'Aucallama'),
(1269,131,'Chancay'),
(1270,131,'Huaral'),
(1271,131,'Ihuari'),
(1272,131,'Lampian'),
(1273,131,'Pacaraos'),
(1274,131,'San Miguel de Acos'),
(1275,131,'Santa Cruz de Andamarca'),
(1276,131,'Sumbilca'),
(1277,131,'Veintisiete de Noviembre'),
(1278,132,'Antioquia'),
(1279,132,'Callahuanca'),
(1280,132,'Carampoma'),
(1281,132,'Chicla'),
(1282,132,'Cuenca'),
(1283,132,'Huachupampa'),
(1284,132,'Huanza'),
(1285,132,'Huarochiri'),
(1286,132,'Lahuaytambo'),
(1287,132,'Langa'),
(1288,132,'Laraos'),
(1289,132,'Mariatana'),
(1290,132,'Matucana'),
(1291,132,'Ricardo Palma'),
(1292,132,'San Andrés de Tupicocha'),
(1293,132,'San Antonio'),
(1294,132,'San Bartolome'),
(1295,132,'San Damian'),
(1296,132,'San Juan de Iris'),
(1297,132,'San Juan de Tantaranche'),
(1298,132,'San Lorenzo de Quinti'),
(1299,132,'San Mateo'),
(1300,132,'San Mateo de Otao'),
(1301,132,'San Pedro de Casta'),
(1302,132,'San Pedro de Huancayre'),
(1303,132,'Sangallaya'),
(1304,132,'Santa Cruz de Cocachacra'),
(1305,132,'Santa Eulalia'),
(1306,132,'Santiago de Anchucaya'),
(1307,132,'Santiago de Tuna'),
(1308,132,'Santo Domingo de los Olleros'),
(1309,132,'Surco'),
(1310,133,'Ambar'),
(1311,133,'Caleta de Carquin'),
(1312,133,'Checras'),
(1313,133,'Hualmay'),
(1314,133,'Huaura'),
(1315,133,'Leoncio Prado'),
(1316,133,'Paccho'),
(1317,133,'Santa Leonor'),
(1318,133,'Santa Maria'),
(1319,133,'Sayan'),
(1320,133,'Vegueta'),
(1321,134,'Ancón'),
(1322,134,'Ate'),
(1323,134,'Barranco'),
(1324,134,'Breña'),
(1325,134,'Carabayllo'),
(1326,134,'Chaclacayo'),
(1327,134,'Chorrillos'),
(1328,134,'Cieneguilla'),
(1329,134,'Comas'),
(1330,134,'El Agustino'),
(1331,134,'Independencia'),
(1332,134,'Jesús María'),
(1333,134,'La Molina'),
(1334,134,'La Victoria'),
(1335,134,'Lima'),
(1336,134,'Lince'),
(1337,134,'Los Olivos'),
(1338,134,'Lurigancho'),
(1339,134,'Lurín'),
(1340,134,'Magdalena del Mar'),
(1341,134,'Miraflores'),
(1342,134,'Pachacamac'),
(1343,134,'Pucusana'),
(1344,134,'Pueblo Libre'),
(1345,134,'Puente Piedra'),
(1346,134,'Punta Hermosa'),
(1347,134,'Punta Negra'),
(1348,134,'Rímac'),
(1349,134,'San Bartolo'),
(1350,134,'San Borja'),
(1351,134,'San Isidro'),
(1352,134,'San Juan de Lurigancho'),
(1353,134,'San Juan de Miraflores'),
(1354,134,'San Luis'),
(1355,134,'San Martín de Porres'),
(1356,134,'San Miguel'),
(1357,134,'Santa Anita'),
(1358,134,'Santa María del Mar'),
(1359,134,'Santa Rosa'),
(1360,134,'Santiago de Surco'),
(1361,134,'Surquillo'),
(1362,134,'Villa El Salvador'),
(1363,134,'Villa María del Triunfo'),
(1364,135,'Andajes'),
(1365,135,'Caujul'),
(1366,135,'Cochamarca'),
(1367,135,'Navan'),
(1368,135,'Oyón'),
(1369,135,'Pachangara'),
(1370,136,'Alis'),
(1371,136,'Allauca'),
(1372,136,'Ayaviri'),
(1373,136,'Azángaro'),
(1374,136,'Cacra'),
(1375,136,'Carania'),
(1376,136,'Catahuasi'),
(1377,136,'Chocos'),
(1378,136,'Cochas'),
(1379,136,'Colonia'),
(1380,136,'Hongos'),
(1381,136,'Huampara'),
(1382,136,'Huancaya'),
(1383,136,'Huangascar'),
(1384,136,'Huantán'),
(1385,136,'Huañec'),
(1386,136,'Laraos'),
(1387,136,'Lincha'),
(1388,136,'Madean'),
(1389,136,'Miraflores'),
(1390,136,'Omas'),
(1391,136,'Putinza'),
(1392,136,'Quinches'),
(1393,136,'Quinocay'),
(1394,136,'San Joaquín'),
(1395,136,'San Pedro de Pilas'),
(1396,136,'Tanta'),
(1397,136,'Tauripampa'),
(1398,136,'Tomas'),
(1399,136,'Tupe'),
(1400,136,'Viñac'),
(1401,136,'Vitis'),
(1402,137,'Balsapuerto'),
(1403,137,'Jeberos'),
(1404,137,'Lagunas'),
(1405,137,'Santa Cruz'),
(1406,137,'Teniente Cesar López Rojas'),
(1407,137,'Yurimaguas'),
(1408,138,'Andoas'),
(1409,138,'Barranca'),
(1410,138,'Cahuapanas'),
(1411,138,'Manseriche'),
(1412,138,'Morona'),
(1413,138,'Pastaza'),
(1414,139,'Nauta'),
(1415,139,'Parinari'),
(1416,139,'Tigre'),
(1417,139,'Trompeteros'),
(1418,139,'Urarinas'),
(1419,140,'Pebas'),
(1420,140,'Ramón Castilla'),
(1421,140,'San Pablo'),
(1422,140,'Yavarí'),
(1423,141,'Alto Nanay'),
(1424,141,'Fernando Lores'),
(1425,141,'Indiana'),
(1426,141,'Iquitos'),
(1427,141,'Las Amazonas'),
(1428,141,'Mazan'),
(1429,141,'Napo'),
(1430,141,'Punchana'),
(1431,141,'Torres Causana'),
(1432,141,'Belén'),
(1433,141,'San Juan Bautista'),
(1434,142,'Putumayo'),
(1435,142,'Rosa Panduro'),
(1436,142,'Teniente Manuel Clavero'),
(1437,142,'Yaguas'),
(1438,143,'Alto Tapiche'),
(1439,143,'Capelo'),
(1440,143,'Emilio San Martín'),
(1441,143,'Jenaro Herrera'),
(1442,143,'Maquia'),
(1443,143,'Puinahua'),
(1444,143,'Requena'),
(1445,143,'Saquena'),
(1446,143,'Soplin'),
(1447,143,'Tapiche'),
(1448,143,'Yaquerana'),
(1449,144,'Contamana'),
(1450,144,'Inahuaya'),
(1451,144,'Padre Márquez'),
(1452,144,'Pampa Hermosa'),
(1453,144,'Sarayacu'),
(1454,144,'Vargas Guerra'),
(1455,145,'Fitzcarrald'),
(1456,145,'Madre de Dios'),
(1457,145,'Manu'),
(1458,145,'Huepetuhe'),
(1459,146,'Iñapari'),
(1460,146,'Iberia'),
(1461,146,'Tahuamanu'),
(1462,147,'Inambari'),
(1463,147,'Las Piedras'),
(1464,147,'Laberinto'),
(1465,147,'Tambopata'),
(1466,148,'Chojata'),
(1467,148,'Coalaque'),
(1468,148,'Ichuña'),
(1469,148,'La Capilla'),
(1470,148,'Lloque'),
(1471,148,'Matalaque'),
(1472,148,'Omate'),
(1473,148,'Puquina'),
(1474,148,'Quinistaquillas'),
(1475,148,'Ubinas'),
(1476,148,'Yunga'),
(1477,149,'El Algarrobal'),
(1478,149,'Ilo'),
(1479,149,'Pacocha'),
(1480,150,'Carumas'),
(1481,150,'Cuchumbaya'),
(1482,150,'Moquegua'),
(1483,150,'Samegua'),
(1484,150,'San Cristóbal'),
(1485,150,'Torata'),
(1486,151,'Chacayan'),
(1487,151,'Goyllarisquizga'),
(1488,151,'Paucar'),
(1489,151,'San Pedro de Pillao'),
(1490,151,'Santa Ana de Tusi'),
(1491,151,'Tapuc'),
(1492,151,'Vilcabamba'),
(1493,151,'Yanahuanca'),
(1494,152,'Chontabamba'),
(1495,152,'Constitución'),
(1496,152,'Huancabamba'),
(1497,152,'Oxapampa'),
(1498,152,'Palcazu'),
(1499,152,'Pozuzo'),
(1500,152,'Puerto Bermúdez'),
(1501,152,'Villa Rica'),
(1502,153,'Chaupimarca'),
(1503,153,'Huachon'),
(1504,153,'Huariaca'),
(1505,153,'Huayllay'),
(1506,153,'Ninacaca'),
(1507,153,'Pallanchacra'),
(1508,153,'Paucartambo'),
(1509,153,'San Francisco de Asís de Yarusyacán'),
(1510,153,'Simón Bolívar'),
(1511,153,'Ticlacayán'),
(1512,153,'Tinyahuarco'),
(1513,153,'Vicco'),
(1514,153,'Yanacancha'),
(1515,154,'Ayabaca'),
(1516,154,'Frias'),
(1517,154,'Jilili'),
(1518,154,'Lagunas'),
(1519,154,'Montero'),
(1520,154,'Pacaipampa'),
(1521,154,'Paimas'),
(1522,154,'Sapillica'),
(1523,154,'Sicchez'),
(1524,154,'Suyo'),
(1525,155,'Canchaque'),
(1526,155,'El Carmen de la Frontera'),
(1527,155,'Huancabamba'),
(1528,155,'Huarmaca'),
(1529,155,'Lalaquiz'),
(1530,155,'San Miguel de El Faique'),
(1531,155,'Sondor'),
(1532,155,'Sondorillo'),
(1533,156,'Buenos Aires'),
(1534,156,'Chalaco'),
(1535,156,'Chulucanas'),
(1536,156,'La Matanza'),
(1537,156,'Morropon'),
(1538,156,'Salitral'),
(1539,156,'San Juan de Bigote'),
(1540,156,'Santa Catalina de Mossa'),
(1541,156,'Santo Domingo'),
(1542,156,'Yamango'),
(1543,157,'Amotape'),
(1544,157,'Arenal'),
(1545,157,'Colan'),
(1546,157,'La Huaca'),
(1547,157,'Paita'),
(1548,157,'Tamarindo'),
(1549,157,'Vichayal'),
(1550,158,'Castilla'),
(1551,158,'Catacaos'),
(1552,158,'Cura Mori'),
(1553,158,'El Tallan'),
(1554,158,'La Arena'),
(1555,158,'La Union'),
(1556,158,'Las Lomas'),
(1557,158,'Piura'),
(1558,158,'Tambo Grande'),
(1559,159,'Bellavista de la Union'),
(1560,159,'Bernal'),
(1561,159,'Cristo Nos Valga'),
(1562,159,'Rinconada Llicuar'),
(1563,159,'Sechura'),
(1564,159,'Vice'),
(1565,160,'Bellavista'),
(1566,160,'Ignacio Escudero'),
(1567,160,'Lancones'),
(1568,160,'Marcavelica'),
(1569,160,'Miguel Checa'),
(1570,160,'Querecotillo'),
(1571,160,'Salitral'),
(1572,160,'Sullana'),
(1573,161,'El Alto'),
(1574,161,'La Brea'),
(1575,161,'Lobitos'),
(1576,161,'Los Organos'),
(1577,161,'Mancora'),
(1578,161,'Parinas'),
(1579,162,'Azángaro'),
(1580,162,'Achaya'),
(1581,162,'Arapa'),
(1582,162,'Asillo'),
(1583,162,'Caminaca'),
(1584,162,'Chupa'),
(1585,162,'José Domingo Choquehuanca'),
(1586,162,'Muñani'),
(1587,162,'Potoni'),
(1588,162,'Samán'),
(1589,162,'San Antón'),
(1590,162,'San José'),
(1591,162,'San Juan de Salinas'),
(1592,162,'Santiago de Pupuja'),
(1593,162,'Tirapata'),
(1594,163,'Carabaya'),
(1595,163,'Ajoyani'),
(1596,163,'Ayapata'),
(1597,163,'Coasa'),
(1598,163,'Corani'),
(1599,163,'Crucero'),
(1600,163,'Ituata'),
(1601,163,'Macusani'),
(1602,163,'Ollachea'),
(1603,163,'San Gabán'),
(1604,163,'Usicayos'),
(1605,164,'Chucuito'),
(1606,164,'Desaguadero'),
(1607,164,'Huacullani'),
(1608,164,'Juli'),
(1609,164,'Kelluyo'),
(1610,164,'Pisacoma'),
(1611,164,'Pomata'),
(1612,164,'Zepita'),
(1613,165,'El Collao'),
(1614,165,'Capaso'),
(1615,165,'Conduriri'),
(1616,165,'Ilave'),
(1617,165,'Pilcuyo'),
(1618,165,'Santa Rosa'),
(1619,166,'Huancané'),
(1620,166,'Cojata'),
(1621,166,'Huancané'),
(1622,166,'Huatasani'),
(1623,166,'Inchupalla'),
(1624,166,'Pusi'),
(1625,166,'Rosaspata'),
(1626,166,'Taraco'),
(1627,166,'Vilque Chico'),
(1628,167,'Lampa'),
(1629,167,'Cabanilla'),
(1630,167,'Calapuja'),
(1631,167,'Lampa'),
(1632,167,'Nicasio'),
(1633,167,'Ocuviri'),
(1634,167,'Palca'),
(1635,167,'Paratía'),
(1636,167,'Pucará'),
(1637,167,'Santa Lucía'),
(1638,167,'Vilavila'),
(1639,168,'Melgar'),
(1640,168,'Antauta'),
(1641,168,'Ayaviri'),
(1642,168,'Cupi'),
(1643,168,'Llalli'),
(1644,168,'Macari'),
(1645,168,'Nuñoa'),
(1646,168,'Orurillo'),
(1647,168,'Santa Rosa'),
(1648,168,'Umachiri'),
(1649,169,'Moho'),
(1650,169,'Conima'),
(1651,169,'Huayrapata'),
(1652,169,'Moho'),
(1653,169,'Tilali'),
(1654,170,'Puno'),
(1655,170,'Acora'),
(1656,170,'Amantani'),
(1657,170,'Atuncolla'),
(1658,170,'Capachica'),
(1659,170,'Chucuito'),
(1660,170,'Coata'),
(1661,170,'Huata'),
(1662,170,'Mañazo'),
(1663,170,'Paucarcolla'),
(1664,170,'Pichacani'),
(1665,170,'Platería'),
(1666,170,'Puno'),
(1667,170,'San Antonio'),
(1668,170,'Tiquillaca'),
(1669,170,'Vilque'),
(1670,171,'San Antonio de Putina'),
(1671,171,'Ananea'),
(1672,171,'Pedro Vilca Apaza'),
(1673,171,'Putina'),
(1674,171,'Quilcapuncu'),
(1675,171,'Sina'),
(1676,172,'San Román'),
(1677,172,'Cabana'),
(1678,172,'Cabanillas'),
(1679,172,'Caracoto'),
(1680,172,'Juliaca'),
(1681,173,'Sandia'),
(1682,173,'Alto Inambari'),
(1683,173,'Cuyocuyo'),
(1684,173,'Limbani'),
(1685,173,'Patambuco'),
(1686,173,'Phara'),
(1687,173,'Quiaca'),
(1688,173,'San Juan del Oro'),
(1689,173,'San Pedro de Putina Punco'),
(1690,173,'Sandia'),
(1691,173,'Yanahuaya'),
(1692,174,'Yunguyo'),
(1693,174,'Anapia'),
(1694,174,'Copani'),
(1695,174,'Cuturapi'),
(1696,174,'Ollaraya'),
(1697,174,'Tinicachi'),
(1698,174,'Unicachi'),
(1699,175,'Alto Biavo'),
(1700,175,'Bajo Biavo'),
(1701,175,'Bellavista'),
(1702,175,'Huallaga'),
(1703,175,'San Pablo'),
(1704,175,'San Rafael'),
(1705,176,'Agua Blanca'),
(1706,176,'San José de Sisa'),
(1707,176,'San Martín'),
(1708,176,'Santa Rosa'),
(1709,176,'Shatoja'),
(1710,177,'Alto Saposoa'),
(1711,177,'El Eslabón'),
(1712,177,'Piscoyacu'),
(1713,177,'Sacanche'),
(1714,177,'Saposoa'),
(1715,177,'Tingo de Saposoa'),
(1716,178,'Alonso de Alvarado'),
(1717,178,'Barranquita'),
(1718,178,'Caynarachi'),
(1719,178,'Cuñumbuqui'),
(1720,178,'Lamas'),
(1721,178,'Pinto Recodo'),
(1722,178,'Rumisapa'),
(1723,178,'San Roque de Cumbaza'),
(1724,178,'Shanao'),
(1725,178,'Tabalosos'),
(1726,178,'Zapatero'),
(1727,179,'Campanilla'),
(1728,179,'Huicungo'),
(1729,179,'Juanjuí'),
(1730,179,'Pachiza'),
(1731,179,'Pajarillo'),
(1732,180,'Calzada'),
(1733,180,'Habana'),
(1734,180,'Jepelacio'),
(1735,180,'Moyobamba'),
(1736,180,'Soritor'),
(1737,180,'Yantalo'),
(1738,181,'Buenos Aires'),
(1739,181,'Caspisapa'),
(1740,181,'Picota'),
(1741,181,'Pilluana'),
(1742,181,'Pucacaca'),
(1743,181,'San Cristóbal'),
(1744,181,'San Hilarión'),
(1745,181,'Shamboyacu'),
(1746,181,'Tingo de Ponasa'),
(1747,181,'Tres Unidos'),
(1748,182,'Awajun'),
(1749,182,'Elias Soplin Vargas'),
(1750,182,'Nueva Cajamarca'),
(1751,182,'Pardo Miguel'),
(1752,182,'Posic'),
(1753,182,'Rioja'),
(1754,182,'San Fernando'),
(1755,182,'Yorongos'),
(1756,182,'Yuracyacu'),
(1757,183,'Alberto Leveau'),
(1758,183,'Cacatachi'),
(1759,183,'Chazuta'),
(1760,183,'Chipurana'),
(1761,183,'El Porvenir'),
(1762,183,'Huimbayoc'),
(1763,183,'Juan Guerra'),
(1764,183,'La Banda de Shilcayo'),
(1765,183,'Morales'),
(1766,183,'Papaplaya'),
(1767,183,'San Antonio'),
(1768,183,'Sauce'),
(1769,183,'Shapaja'),
(1770,183,'Tarapoto'),
(1771,184,'Nuevo Progreso'),
(1772,184,'Polvora'),
(1773,184,'Shunte'),
(1774,184,'Tocache'),
(1775,184,'Uchiza'),
(1776,185,'Cairani'),
(1777,185,'Camilaca'),
(1778,185,'Candarave'),
(1779,185,'Curibaya'),
(1780,185,'Huanuara'),
(1781,185,'Quilahuani'),
(1782,186,'Ilabaya'),
(1783,186,'Ite'),
(1784,186,'Locumba'),
(1785,187,'Alto de la Alianza'),
(1786,187,'Calana'),
(1787,187,'Ciudad Nueva'),
(1788,187,'Inclán'),
(1789,187,'Pachía'),
(1790,187,'Palca'),
(1791,187,'Pocollay'),
(1792,187,'Sama'),
(1793,187,'Tacna'),
(1794,187,'Coronel Gregorio Albarracín Lanchipa'),
(1795,188,'Estique'),
(1796,188,'Estique-Pampa'),
(1797,188,'Sitajara'),
(1798,188,'Susapaya'),
(1799,188,'Tarata'),
(1800,188,'Tarucachi'),
(1801,188,'Ticaco'),
(1802,189,'Canoas de Punta Sal'),
(1803,189,'Casitas'),
(1804,189,'Zorritos'),
(1805,190,'Corrales'),
(1806,190,'La Cruz'),
(1807,190,'Pampas de Hospital'),
(1808,190,'San Jacinto'),
(1809,190,'San Juan de la Virgen'),
(1810,190,'Tumbes'),
(1811,191,'Aguas Verdes'),
(1812,191,'Matapalo'),
(1813,191,'Papayal'),
(1814,191,'Zarumilla'),
(1815,192,'Raymondi'),
(1816,192,'Sepahua'),
(1817,192,'Tahuanía'),
(1818,192,'Yurúa'),
(1819,193,'Callería'),
(1820,193,'Campoverde'),
(1821,193,'Iparía'),
(1822,193,'Masisea'),
(1823,193,'Yarinacocha'),
(1824,193,'Nueva Requena'),
(1825,193,'Manantay'),
(1826,194,'Padre Abad'),
(1827,194,'Irazola'),
(1828,194,'Curimaná'),
(1829,195,'Purús');

/*Table structure for table `egresos_evento` */

DROP TABLE IF EXISTS `egresos_evento`;

CREATE TABLE `egresos_evento` (
  `idegreso` int(11) NOT NULL AUTO_INCREMENT,
  `idreparticion` int(11) NOT NULL,
  `descripcion` varchar(80) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tipopago` tinyint(4) NOT NULL,
  `noperacion` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idegreso`),
  KEY `fk_idreparticion_egre` (`idreparticion`),
  CONSTRAINT `fk_idreparticion_egre` FOREIGN KEY (`idreparticion`) REFERENCES `reparticion_ingresos` (`idreparticion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `egresos_evento` */

/*Table structure for table `empresa` */

DROP TABLE IF EXISTS `empresa`;

CREATE TABLE `empresa` (
  `idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `ruc` char(11) DEFAULT NULL,
  `logoempresa` varchar(80) DEFAULT NULL,
  `razonsocial` varchar(120) DEFAULT NULL,
  `nombrecomercial` varchar(120) DEFAULT NULL,
  `nombreapp` varchar(120) DEFAULT NULL,
  `direccion` varchar(120) DEFAULT NULL,
  `web` varchar(120) DEFAULT NULL,
  `correo` varchar(120) DEFAULT NULL,
  `contrasenagmailapp` varchar(120) DEFAULT NULL,
  `ncuenta` varchar(30) DEFAULT NULL,
  `ncci` varchar(30) DEFAULT NULL,
  `banco` varchar(30) DEFAULT NULL,
  `moneda` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idempresa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `empresa` */

insert  into `empresa`(`idempresa`,`ruc`,`logoempresa`,`razonsocial`,`nombrecomercial`,`nombreapp`,`direccion`,`web`,`correo`,`contrasenagmailapp`,`ncuenta`,`ncci`,`banco`,`moneda`) values 
(1,'12345678901','vegaimagenes/cyh8cnkpolkljrj2bdyr','Razón Social Ejemplo S.A.','Nombre Comercial S.A.','Vega Producciones','Av. Ejemplo 123','https://www.ejemplo.com',NULL,NULL,'123456789','987654321','BCP','Soles');

/*Table structure for table `gastos_cajachica` */

DROP TABLE IF EXISTS `gastos_cajachica`;

CREATE TABLE `gastos_cajachica` (
  `idgasto` int(11) NOT NULL AUTO_INCREMENT,
  `idcajachica` int(11) NOT NULL,
  `fecha_gasto` datetime DEFAULT current_timestamp(),
  `concepto` varchar(250) NOT NULL,
  `monto` double(10,2) NOT NULL,
  PRIMARY KEY (`idgasto`),
  KEY `fk_idcaja_gastos` (`idcajachica`),
  CONSTRAINT `fk_idcaja_gastos` FOREIGN KEY (`idcajachica`) REFERENCES `cajachica` (`idcajachica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `gastos_cajachica` */

/*Table structure for table `ingresos_evento` */

DROP TABLE IF EXISTS `ingresos_evento`;

CREATE TABLE `ingresos_evento` (
  `idingreso` int(11) NOT NULL AUTO_INCREMENT,
  `idreparticion` int(11) NOT NULL,
  `descripcion` varchar(80) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tipopago` tinyint(4) NOT NULL,
  `noperacion` varchar(15) DEFAULT NULL,
  `medio` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idingreso`),
  KEY `fk_idreparticion_ing` (`idreparticion`),
  CONSTRAINT `fk_idreparticion_ing` FOREIGN KEY (`idreparticion`) REFERENCES `reparticion_ingresos` (`idreparticion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ingresos_evento` */

/*Table structure for table `items_comprobante` */

DROP TABLE IF EXISTS `items_comprobante`;

CREATE TABLE `items_comprobante` (
  `iditemcomprobante` int(11) NOT NULL AUTO_INCREMENT,
  `idcomprobante` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `valorunitario` decimal(10,2) NOT NULL,
  `valortotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`iditemcomprobante`),
  KEY `fk_items_factura` (`idcomprobante`),
  CONSTRAINT `fk_items_factura` FOREIGN KEY (`idcomprobante`) REFERENCES `comprobantes` (`idcomprobante`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `items_comprobante` */

insert  into `items_comprobante`(`iditemcomprobante`,`idcomprobante`,`cantidad`,`descripcion`,`valorunitario`,`valortotal`) values 
(7,3,1,'Presentación artística de Nataly Ramirez',510.00,601.80),
(8,3,1,'Puesto en la locación de null',600.00,708.00),
(9,4,1,'Presentación artística de Nataly Ramirez',510.00,510.00),
(10,4,1,'Puesto en la locación de null',600.00,600.00),
(11,5,1,'Presentación artística de Azucena Calvay',80000.00,80000.00),
(12,5,1,'Puesto en la locación de Nazca',1700.00,1700.00);

/*Table structure for table `montocajachica` */

DROP TABLE IF EXISTS `montocajachica`;

CREATE TABLE `montocajachica` (
  `idmonto` int(11) NOT NULL AUTO_INCREMENT,
  `monto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idmonto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `montocajachica` */

insert  into `montocajachica`(`idmonto`,`monto`) values 
(1,0.00);

/*Table structure for table `nacionalidades` */

DROP TABLE IF EXISTS `nacionalidades`;

CREATE TABLE `nacionalidades` (
  `idnacionalidad` int(11) NOT NULL AUTO_INCREMENT,
  `nacionalidad` varchar(100) NOT NULL,
  `pais` varchar(50) NOT NULL,
  PRIMARY KEY (`idnacionalidad`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `nacionalidades` */

insert  into `nacionalidades`(`idnacionalidad`,`nacionalidad`,`pais`) values 
(1,'Afgana','Afganistán'),
(2,'Albanesa','Albania'),
(3,'Alemana','Alemania'),
(4,'Andorrana','Andorra'),
(5,'Angoleña','Angola'),
(6,'Argentina','Argentina'),
(7,'Australiana','Australia'),
(8,'Belga','Bélgica'),
(9,'Boliviana','Bolivia'),
(10,'Brasileña','Brasil'),
(11,'Canadiense','Canadá'),
(12,'Chilena','Chile'),
(13,'China','China'),
(14,'Colombiana','Colombia'),
(15,'Costarricense','Costa Rica'),
(16,'Cubana','Cuba'),
(17,'Ecuatoriana','Ecuador'),
(18,'Egipcia','Egipto'),
(19,'Española','España'),
(20,'Estadounidense','Estados Unidos'),
(21,'Filipina','Filipinas'),
(22,'Francesa','Francia'),
(23,'Guatemalteca','Guatemala'),
(24,'Hondureña','Honduras'),
(25,'India','India'),
(26,'Italiana','Italia'),
(27,'Japonesa','Japón'),
(28,'Mexicana','México'),
(29,'Panameña','Panamá'),
(30,'Paraguaya','Paraguay'),
(31,'Peruana','Perú'),
(32,'Portuguesa','Portugal'),
(33,'Salvadoreña','El Salvador'),
(34,'Suiza','Suiza'),
(35,'Uruguaya','Uruguay'),
(36,'Venezolana','Venezuela');

/*Table structure for table `nivelaccesos` */

DROP TABLE IF EXISTS `nivelaccesos`;

CREATE TABLE `nivelaccesos` (
  `idnivelacceso` int(11) NOT NULL AUTO_INCREMENT,
  `nivelacceso` varchar(30) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idnivelacceso`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `nivelaccesos` */

insert  into `nivelaccesos`(`idnivelacceso`,`nivelacceso`,`create_at`,`update_at`) values 
(1,'Vendedor','2025-04-16 00:31:03',NULL),
(2,'Vendedor Externo','2025-04-16 00:31:03',NULL),
(3,'Administrador','2025-04-16 00:31:03',NULL),
(4,'Gerente','2025-04-16 00:31:03',NULL),
(5,'Director','2025-04-16 00:31:03',NULL),
(6,'Artista','2025-04-16 00:31:03',NULL),
(7,'Asistente de Gerencia','2025-04-16 00:31:03',NULL),
(8,'Community Manager','2025-04-16 00:31:03',NULL),
(9,'Contabilidad','2025-04-16 00:31:03',NULL),
(10,'Edicion y Produccion','2025-04-16 00:31:03',NULL),
(11,'Filmmaker','2025-04-16 00:31:03',NULL);

/*Table structure for table `notificaciones` */

DROP TABLE IF EXISTS `notificaciones`;

CREATE TABLE `notificaciones` (
  `idnotificacion` int(11) NOT NULL AUTO_INCREMENT,
  `idusuariodest` int(11) NOT NULL,
  `idusuariorem` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `idreferencia` int(11) DEFAULT NULL,
  `mensaje` varchar(200) NOT NULL,
  `estado` int(11) DEFAULT 1,
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idnotificacion`),
  KEY `fk_usuario_notif` (`idusuariodest`),
  KEY `fk_usuario_rem` (`idusuariorem`),
  CONSTRAINT `fk_usuario_notif` FOREIGN KEY (`idusuariodest`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_usuario_rem` FOREIGN KEY (`idusuariorem`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `chk_estado_not` CHECK (`estado` in (1,2))
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `notificaciones` */

insert  into `notificaciones`(`idnotificacion`,`idusuariodest`,`idusuariorem`,`tipo`,`idreferencia`,`mensaje`,`estado`,`fecha`) values 
(1,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 08:05:04'),
(2,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 08:08:48'),
(3,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 20 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 08:10:28'),
(4,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 30 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 08:12:17'),
(5,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 08:15:23'),
(6,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 08:18:00'),
(7,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 31 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 08:32:26'),
(8,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 31 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 08:36:52'),
(9,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 26 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 08:48:42'),
(10,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 27 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 08:56:03'),
(11,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 08:57:41'),
(12,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 09:04:37'),
(13,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 3 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 12:30:10'),
(14,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 12:33:13'),
(15,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 12:38:28'),
(16,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 12:43:00'),
(17,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 12:45:19'),
(18,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 18 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-16 12:46:39'),
(19,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Octubre de 2025!, revisa tu agenda.',1,'2025-04-16 12:48:04'),
(22,6,1,4,16,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-04-16 14:57:32'),
(23,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 13 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 15:19:11'),
(24,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 15:21:45'),
(25,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 6 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 15:24:57'),
(26,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Abril de 2025!, revisa tu agenda.',1,'2025-04-16 15:31:46'),
(27,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 30 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 15:33:54'),
(28,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 23 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 15:36:16'),
(29,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 15:37:58'),
(30,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 15:39:15'),
(31,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 15:40:02'),
(32,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 15:40:52'),
(33,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 15:42:09'),
(34,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 15:43:20'),
(35,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 15:50:43'),
(36,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 15:52:22'),
(37,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 15:57:20'),
(38,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:00:42'),
(39,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:02:13'),
(40,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:04:42'),
(41,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:10:16'),
(42,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:12:37'),
(43,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:15:20'),
(44,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:18:24'),
(45,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:21:12'),
(46,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:24:05'),
(47,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:25:47'),
(48,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:28:10'),
(49,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:31:29'),
(50,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-16 16:34:20'),
(51,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 28 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:37:41'),
(52,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 26 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:38:48'),
(53,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 20 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:43:08'),
(54,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:44:10'),
(55,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:45:50'),
(56,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:47:16'),
(57,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 18 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:49:56'),
(58,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:50:55'),
(59,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 13 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:52:49'),
(60,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:54:08'),
(61,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:55:23'),
(62,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 16:59:10'),
(63,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 5 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 17:02:32'),
(64,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 17:11:26'),
(65,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 17:13:10'),
(66,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Enero de 2025!, revisa tu agenda.',1,'2025-04-16 17:14:30'),
(67,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-16 17:43:51'),
(68,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-21 10:51:24'),
(69,5,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-21 11:07:30'),
(70,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-21 11:09:25'),
(71,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-21 11:11:24'),
(72,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Marzo de 2025!, revisa tu agenda.',1,'2025-04-21 11:13:58'),
(73,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 23 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:15:21'),
(74,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 23 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:18:56'),
(75,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:21:42'),
(76,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 21 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:22:38'),
(77,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:23:54'),
(78,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:26:12'),
(79,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:27:02'),
(80,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:28:36'),
(81,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:30:01'),
(82,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:31:44'),
(83,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:33:11'),
(84,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:34:33'),
(85,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:37:11'),
(86,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:38:50'),
(87,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:41:02'),
(88,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Febrero de 2025!, revisa tu agenda.',1,'2025-04-21 11:42:41'),
(89,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Enero de 2025!, revisa tu agenda.',1,'2025-04-21 11:44:53'),
(90,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Enero de 2025!, revisa tu agenda.',1,'2025-04-21 11:46:06'),
(91,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Enero de 2025!, revisa tu agenda.',1,'2025-04-21 11:46:59'),
(92,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 18 de Enero de 2025!, revisa tu agenda.',1,'2025-04-21 11:48:50'),
(93,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Enero de 2025!, revisa tu agenda.',1,'2025-04-21 11:49:50'),
(94,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Enero de 2025!, revisa tu agenda.',1,'2025-04-21 11:51:33'),
(95,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Enero de 2025!, revisa tu agenda.',1,'2025-04-21 11:53:50'),
(96,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 5 de Enero de 2025!, revisa tu agenda.',1,'2025-04-21 11:54:44'),
(97,4,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Enero de 2025!, revisa tu agenda.',1,'2025-04-21 11:56:22'),
(98,3,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-25 17:21:11'),
(99,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.',1,'2025-04-25 17:42:47'),
(100,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 30 de Abril de 2025!, revisa tu agenda.',1,'2025-05-05 10:00:38'),
(101,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:05:53'),
(102,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:08:55'),
(103,6,1,4,99,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-05 10:09:44'),
(104,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:10:56'),
(105,1,1,5,99,'Se ha configurado precios para el evento de Nataly Ramirez - beta disco lounge 1 de Mayo de 2025',1,'2025-05-05 10:11:19'),
(106,6,1,5,99,'Se ha configurado precios para el evento de Nataly Ramirez - beta disco lounge 1 de Mayo de 2025',1,'2025-05-05 10:11:19'),
(107,6,1,4,100,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-05 10:11:55'),
(108,1,1,5,100,'Se ha configurado precios para el evento de Nataly Ramirez - discoteca la hacienda 2 de Mayo de 2025',1,'2025-05-05 10:12:03'),
(109,6,1,5,100,'Se ha configurado precios para el evento de Nataly Ramirez - discoteca la hacienda 2 de Mayo de 2025',1,'2025-05-05 10:12:03'),
(110,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 3 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:13:50'),
(111,6,1,4,101,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-05 10:14:27'),
(112,6,1,5,101,'Se ha configurado precios para el evento de Nataly Ramirez - Paramo Centro Recreacional 3 de Mayo de 2025',1,'2025-05-05 10:14:42'),
(113,1,1,5,101,'Se ha configurado precios para el evento de Nataly Ramirez - Paramo Centro Recreacional 3 de Mayo de 2025',1,'2025-05-05 10:14:42'),
(114,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:16:15'),
(115,6,1,4,102,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-05 10:16:31'),
(116,1,1,5,102,'Se ha configurado precios para el evento de Nataly Ramirez - La Choza CutervinaMedio Dia 4 de Mayo de 2025',1,'2025-05-05 10:16:37'),
(117,6,1,5,102,'Se ha configurado precios para el evento de Nataly Ramirez - La Choza CutervinaMedio Dia 4 de Mayo de 2025',1,'2025-05-05 10:16:37'),
(118,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:17:41'),
(119,6,1,4,103,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-05 10:17:57'),
(120,6,1,5,103,'Se ha configurado precios para el evento de Nataly Ramirez - Discoteca La Hacienda Noche 4 de Mayo de 2025',1,'2025-05-05 10:18:06'),
(121,1,1,5,103,'Se ha configurado precios para el evento de Nataly Ramirez - Discoteca La Hacienda Noche 4 de Mayo de 2025',1,'2025-05-05 10:18:06'),
(122,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:19:23'),
(123,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:20:13'),
(124,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:21:22'),
(125,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:22:01'),
(126,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:23:18'),
(127,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:24:58'),
(128,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:26:06'),
(129,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:27:01'),
(130,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:28:52'),
(131,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-05 10:30:01'),
(132,6,1,4,113,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-05 10:30:36'),
(133,6,1,4,112,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-05 10:31:01'),
(134,1,1,5,112,'Se ha configurado precios para el evento de Nataly Ramirez - la casa de la cumbia 12 de Mayo de 2025',1,'2025-05-05 10:31:10'),
(135,6,1,5,112,'Se ha configurado precios para el evento de Nataly Ramirez - la casa de la cumbia 12 de Mayo de 2025',1,'2025-05-05 10:31:10'),
(136,5,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-06 10:06:27'),
(137,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-06 10:11:56'),
(138,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 21 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-06 14:25:56'),
(139,2,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 21 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-06 14:33:25'),
(140,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 29 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-06 16:21:59'),
(141,6,1,4,120,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-06 16:22:15'),
(142,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 7 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-06 21:56:21'),
(143,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-07 00:12:24'),
(144,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 21 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-07 00:47:33'),
(145,1,1,4,123,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-07 00:49:10'),
(146,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-07 08:16:06'),
(147,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-07 08:18:51'),
(148,1,1,4,125,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-07 08:19:18'),
(149,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-07 08:33:48'),
(150,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-07 11:16:30'),
(151,6,1,4,104,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-07 16:19:19'),
(152,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-07 17:00:36'),
(153,1,1,4,1,'Una nueva propuesta ha llegado, haz click para revisarlo.',1,'2025-05-07 19:19:54'),
(154,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-08 15:36:12'),
(155,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-08 15:39:50'),
(156,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-08 23:02:07'),
(157,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-08 23:15:36'),
(158,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-09 00:33:22'),
(159,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-09 00:41:04'),
(160,8,1,2,NULL,'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.',1,'2025-05-09 00:47:52');

/*Table structure for table `notificaciones_viatico` */

DROP TABLE IF EXISTS `notificaciones_viatico`;

CREATE TABLE `notificaciones_viatico` (
  `idnotificacion_viatico` int(11) NOT NULL AUTO_INCREMENT,
  `idviatico` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `mensaje` varchar(200) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idnotificacion_viatico`),
  KEY `fk_idviatico_nt` (`idviatico`),
  KEY `fk_filmmamker_nt` (`idusuario`),
  CONSTRAINT `fk_filmmamker_nt` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_idviatico_nt` FOREIGN KEY (`idviatico`) REFERENCES `viaticos` (`idviatico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `notificaciones_viatico` */

/*Table structure for table `pagos_contrato` */

DROP TABLE IF EXISTS `pagos_contrato`;

CREATE TABLE `pagos_contrato` (
  `idpagocontrato` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tipo_pago` tinyint(4) NOT NULL,
  `noperacion` varchar(20) DEFAULT NULL,
  `fecha_pago` date NOT NULL,
  `hora_pago` time NOT NULL,
  `estado` int(11) NOT NULL,
  PRIMARY KEY (`idpagocontrato`),
  KEY `fk_idcontrato` (`idcontrato`),
  CONSTRAINT `fk_idcontrato` FOREIGN KEY (`idcontrato`) REFERENCES `contratos` (`idcontrato`),
  CONSTRAINT `ck_tipopago_pc` CHECK (`tipo_pago` in (1,2)),
  CONSTRAINT `ck_estado_pc` CHECK (`estado` in (1,3))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pagos_contrato` */

insert  into `pagos_contrato`(`idpagocontrato`,`idcontrato`,`monto`,`tipo_pago`,`noperacion`,`fecha_pago`,`hora_pago`,`estado`) values 
(1,2,10000.00,2,NULL,'2025-05-05','10:06:59',1),
(2,3,476.00,2,NULL,'2025-05-06','04:49:59',1),
(3,3,5000.00,2,NULL,'2025-05-06','05:15:57',1),
(4,3,600000.00,2,NULL,'2025-05-06','05:18:49',1),
(5,3,1.00,2,NULL,'2025-05-06','09:20:48',1),
(6,3,1.00,1,'1','2025-05-06','09:23:05',1),
(7,4,11500.00,2,NULL,'2025-05-06','10:05:19',1),
(8,4,100.00,2,NULL,'2025-05-06','10:21:51',1),
(9,4,25000.00,2,NULL,'2025-05-06','10:29:39',3),
(10,3,1.00,2,NULL,'2025-05-06','10:46:14',1),
(11,3,1.00,2,NULL,'2025-05-06','10:56:14',1),
(12,3,1.00,2,NULL,'2025-05-06','11:41:22',3),
(13,5,277.50,2,NULL,'2025-05-07','12:31:37',1),
(14,5,277.50,2,NULL,'2025-05-07','12:36:52',3),
(15,6,3000.00,2,NULL,'2025-05-07','08:17:54',3),
(16,7,500.00,2,NULL,'2025-05-07','08:34:06',1);

/*Table structure for table `pagos_cuota` */

DROP TABLE IF EXISTS `pagos_cuota`;

CREATE TABLE `pagos_cuota` (
  `idpagocuota` int(11) NOT NULL AUTO_INCREMENT,
  `idcuotacomprobante` int(11) NOT NULL,
  `fechapagado` date DEFAULT current_timestamp(),
  `horapagado` time DEFAULT current_timestamp(),
  `montopagado` decimal(10,2) NOT NULL,
  `tipo_pago` tinyint(4) NOT NULL,
  `noperacion` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idpagocuota`),
  KEY `fk_idcuotacomprobante_pago` (`idcuotacomprobante`),
  CONSTRAINT `fk_idcuotacomprobante_pago` FOREIGN KEY (`idcuotacomprobante`) REFERENCES `cuotas_comprobante` (`idcuotacomprobante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pagos_cuota` */

/*Table structure for table `permisos` */

DROP TABLE IF EXISTS `permisos`;

CREATE TABLE `permisos` (
  `idpermiso` int(11) NOT NULL AUTO_INCREMENT,
  `idnivelacceso` int(11) NOT NULL,
  `modulo` varchar(50) NOT NULL,
  `ruta` varchar(100) NOT NULL,
  `texto` varchar(100) DEFAULT NULL,
  `visibilidad` tinyint(1) NOT NULL,
  `icono` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idpermiso`),
  UNIQUE KEY `uk_idnivelacceso_p` (`idnivelacceso`,`ruta`),
  CONSTRAINT `fk_idnivelacceso_p` FOREIGN KEY (`idnivelacceso`) REFERENCES `nivelaccesos` (`idnivelacceso`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `permisos` */

insert  into `permisos`(`idpermiso`,`idnivelacceso`,`modulo`,`ruta`,`texto`,`visibilidad`,`icono`) values 
(1,3,'ventas','','Ventas',1,'fa-solid fa-arrow-trend-up'),
(2,3,'ventas','listar-atencion-cliente','Atención al cliente',0,'fa-solid fa-users'),
(3,3,'ventas','registrar-atencion-cliente','',0,NULL),
(4,3,'ventas','update-atencion-cliente',NULL,0,NULL);

/*Table structure for table `personas` */

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `idpersona` int(11) NOT NULL AUTO_INCREMENT,
  `num_doc` varchar(20) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `genero` char(1) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` char(15) DEFAULT NULL,
  `telefono2` char(15) DEFAULT NULL,
  `correo` char(150) DEFAULT NULL,
  `iddistrito` int(11) DEFAULT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idpersona`),
  UNIQUE KEY `uk_telefono` (`telefono`),
  UNIQUE KEY `uk_num_doc` (`num_doc`),
  UNIQUE KEY `uk_correo` (`correo`),
  KEY `fk_iddistrito` (`iddistrito`),
  CONSTRAINT `fk_iddistrito` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  CONSTRAINT `chk_genero` CHECK (`genero` in ('M','F'))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `personas` */

insert  into `personas`(`idpersona`,`num_doc`,`apellidos`,`nombres`,`genero`,`direccion`,`telefono`,`telefono2`,`correo`,`iddistrito`,`create_at`,`update_at`) values 
(1,'72754752','Avalos Romero','Royer Alexis','M','Asent. H. Fe y Alegria Mz D Lt 08','973189350',NULL,'royer.190818@email.com',959,'2025-04-16 00:31:03',NULL),
(2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-04-16 07:54:32',NULL),
(3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-04-16 07:58:13',NULL),
(4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-04-16 07:59:09',NULL),
(5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-04-16 08:00:31',NULL),
(6,'74812312',NULL,'Nayade',NULL,NULL,NULL,NULL,NULL,NULL,'2025-04-16 12:55:39','2025-05-06 15:38:04'),
(7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-04-16 18:11:43',NULL),
(8,NULL,'ramirez','nataly',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-05 09:55:35',NULL);

/*Table structure for table `precios_entrada_evento` */

DROP TABLE IF EXISTS `precios_entrada_evento`;

CREATE TABLE `precios_entrada_evento` (
  `idprecioentradaevento` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) NOT NULL,
  `entradas` text DEFAULT NULL,
  PRIMARY KEY (`idprecioentradaevento`),
  KEY `fk_iddp_entrada_convenio` (`iddetalle_presentacion`),
  CONSTRAINT `fk_iddp_entrada_convenio` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `precios_entrada_evento` */

insert  into `precios_entrada_evento`(`idprecioentradaevento`,`iddetalle_presentacion`,`entradas`) values 
(1,99,'PREVENTA: 20 Y 40 ALTOKETICKET'),
(2,100,'PREVENTA: 30 y 40 vip'),
(3,101,'PREVENTA: 30 y 40 vip'),
(4,102,'PREVENTA: 30 y 40 vip'),
(5,103,'PREVENTA: 30 y 40 vip'),
(6,112,'PREVENTA: 30 y 40 vip');

/*Table structure for table `provincias` */

DROP TABLE IF EXISTS `provincias`;

CREATE TABLE `provincias` (
  `idprovincia` int(11) NOT NULL AUTO_INCREMENT,
  `iddepartamento` int(11) NOT NULL,
  `provincia` varchar(80) NOT NULL,
  PRIMARY KEY (`idprovincia`),
  KEY `fk_iddepartamento` (`iddepartamento`),
  CONSTRAINT `fk_iddepartamento` FOREIGN KEY (`iddepartamento`) REFERENCES `departamentos` (`iddepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `provincias` */

insert  into `provincias`(`idprovincia`,`iddepartamento`,`provincia`) values 
(1,1,'Bagua'),
(2,1,'Bongará'),
(3,1,'Chachapoyas'),
(4,1,'Condorcanqui'),
(5,1,'Luya'),
(6,1,'Rodríguez de Mendoza'),
(7,1,'Utcubamba'),
(8,2,'Aija'),
(9,2,'Antonio Raymondi'),
(10,2,'Asunción'),
(11,2,'Bolognesi'),
(12,2,'Carhuaz'),
(13,2,'Carlos Fermín Fitzcarrald'),
(14,2,'Casma'),
(15,2,'Corongo'),
(16,2,'Huaraz'),
(17,2,'Huari'),
(18,2,'Huarmey'),
(19,2,'Mariscal Luzuriaga'),
(20,2,'Ocros'),
(21,2,'Pallasca'),
(22,2,'Pomabamba'),
(23,2,'Recuay'),
(24,2,'Santa'),
(25,2,'Sihuas'),
(26,2,'Yungay'),
(27,3,'Abancay'),
(28,3,'Andahuaylas'),
(29,3,'Antabamba'),
(30,3,'Aymaraes'),
(31,3,'Cotabambas'),
(32,3,'Chincheros'),
(33,3,'Grau'),
(34,4,'Arequipa'),
(35,4,'Camaná'),
(36,4,'Caravelí'),
(37,4,'Castilla'),
(38,4,'Caylloma'),
(39,4,'Condesuyos'),
(40,4,'Islay'),
(41,4,'La Unión'),
(42,5,'Cangallo'),
(43,5,'Huamanga'),
(44,5,'Huanca Sancos'),
(45,5,'Huanta'),
(46,5,'La Mar'),
(47,5,'Lucanas'),
(48,5,'Parinacochas'),
(49,5,'Páucar del Sara Sara'),
(50,5,'Sucre'),
(51,5,'Víctor Fajardo'),
(52,5,'Vilcas Huamán'),
(53,6,'Cajabamba'),
(54,6,'Cajamarca'),
(55,6,'Celendín'),
(56,6,'Chota'),
(57,6,'Contumazá'),
(58,6,'Cutervo'),
(59,6,'Hualgayoc'),
(60,6,'Jaén'),
(61,6,'San Ignacio'),
(62,6,'San Marcos'),
(63,6,'San Miguel'),
(64,6,'San Pablo'),
(65,6,'Santa Cruz'),
(66,7,'Callao'),
(67,8,'Acomayo'),
(68,8,'Anta'),
(69,8,'Calca'),
(70,8,'Canas'),
(71,8,'Canchis'),
(72,8,'Chumbivilcas'),
(73,8,'Cusco'),
(74,8,'Espinar'),
(75,8,'La Convención'),
(76,8,'Paruro'),
(77,8,'Paucartambo'),
(78,8,'Quispicanchi'),
(79,8,'Urubamba'),
(80,9,'Acobamba'),
(81,9,'Angaraes'),
(82,9,'Castrovirreyna'),
(83,9,'Churcampa'),
(84,9,'Huancavelica'),
(85,9,'Huaytará'),
(86,9,'Tayacaja'),
(87,10,'Ambo'),
(88,10,'Dos de Mayo'),
(89,10,'Huacaybamba'),
(90,10,'Huamalíes'),
(91,10,'Huánuco'),
(92,10,'Lauricocha'),
(93,10,'Leoncio Prado'),
(94,10,'Marañón'),
(95,10,'Pachitea'),
(96,10,'Puerto Inca'),
(97,10,'Yarowilca'),
(98,11,'Chincha'),
(99,11,'Ica'),
(100,11,'Nazca'),
(101,11,'Palpa'),
(102,11,'Pisco'),
(103,12,'Chanchamayo'),
(104,12,'Chupaca'),
(105,12,'Concepción'),
(106,12,'Huancayo'),
(107,12,'Jauja'),
(108,12,'Junín'),
(109,12,'Satipo'),
(110,12,'Tarma'),
(111,12,'Yauli'),
(112,13,'Ascope'),
(113,13,'Bolívar'),
(114,13,'Chepén'),
(115,13,'Gran Chimú'),
(116,13,'Julcán'),
(117,13,'Otuzco'),
(118,13,'Pacasmayo'),
(119,13,'Pataz'),
(120,13,'Sánchez Carrión'),
(121,13,'Santiago de Chuco'),
(122,13,'Trujillo'),
(123,13,'Virú'),
(124,14,'Chiclayo'),
(125,14,'Ferreñafe'),
(126,14,'Lambayeque'),
(127,15,'Barranca'),
(128,15,'Cajatambo'),
(129,15,'Canta'),
(130,15,'Cañete'),
(131,15,'Huaral'),
(132,15,'Huarochirí'),
(133,15,'Huaura'),
(134,15,'Lima'),
(135,15,'Oyón'),
(136,15,'Yauyos'),
(137,16,'Alto Amazonas'),
(138,16,'Datem del Marañón'),
(139,16,'Loreto'),
(140,16,'Mariscal Ramón Castilla'),
(141,16,'Maynas'),
(142,16,'Putumayo'),
(143,16,'Requena'),
(144,16,'Ucayali'),
(145,17,'Manu'),
(146,17,'Tahuamanu'),
(147,17,'Tambopata'),
(148,18,'General Sánchez Cerro'),
(149,18,'Ilo'),
(150,18,'Mariscal Nieto'),
(151,19,'Daniel Alcides Carrión'),
(152,19,'Oxapampa'),
(153,19,'Pasco'),
(154,20,'Ayabaca'),
(155,20,'Huancabamba'),
(156,20,'Morropón'),
(157,20,'Paita'),
(158,20,'Piura'),
(159,20,'Sechura'),
(160,20,'Sullana'),
(161,20,'Talara'),
(162,21,'Azángaro'),
(163,21,'Carabaya'),
(164,21,'Chucuito'),
(165,21,'El Collao'),
(166,21,'Huancané'),
(167,21,'Lampa'),
(168,21,'Melgar'),
(169,21,'Moho'),
(170,21,'Puno'),
(171,21,'San Antonio de Putina'),
(172,21,'San Román'),
(173,21,'Sandia'),
(174,21,'Yunguyo'),
(175,22,'Bellavista'),
(176,22,'El Dorado'),
(177,22,'Huallaga'),
(178,22,'Lamas'),
(179,22,'Mariscal Cáceres'),
(180,22,'Moyobamba'),
(181,22,'Picota'),
(182,22,'Rioja'),
(183,22,'San Martín'),
(184,22,'Tocache'),
(185,23,'Candarave'),
(186,23,'Jorge Basadre'),
(187,23,'Tacna'),
(188,23,'Tarata'),
(189,24,'Contralmirante Villar'),
(190,24,'Tumbes'),
(191,24,'Zarumilla'),
(192,25,'Atalaya'),
(193,25,'Coronel Portillo'),
(194,25,'Padre Abad'),
(195,25,'Purús');

/*Table structure for table `reparticion_ingresos` */

DROP TABLE IF EXISTS `reparticion_ingresos`;

CREATE TABLE `reparticion_ingresos` (
  `idreparticion` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) NOT NULL,
  `estado` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`idreparticion`),
  KEY `fk_rep_ing` (`iddetalle_presentacion`),
  CONSTRAINT `fk_rep_ing` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  CONSTRAINT `fk_estado_ing` CHECK (`estado` in (1,2))
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `reparticion_ingresos` */

insert  into `reparticion_ingresos`(`idreparticion`,`iddetalle_presentacion`,`estado`) values 
(1,1,1),
(2,2,1),
(3,3,1),
(4,4,1),
(5,5,1),
(6,6,1),
(7,7,1),
(8,8,1),
(9,16,1),
(10,20,1),
(11,21,1),
(12,22,1),
(13,23,1),
(14,24,1),
(15,25,1),
(16,26,1),
(17,27,1),
(18,28,1),
(19,29,1),
(20,30,1),
(21,31,1),
(22,32,1),
(23,33,1),
(24,34,1),
(25,35,1),
(26,36,1),
(27,37,1),
(28,38,1),
(29,39,1),
(30,40,1),
(31,41,1),
(32,42,1),
(33,43,1),
(34,44,1),
(35,45,1),
(36,46,1),
(37,47,1),
(38,48,1),
(39,49,1),
(40,50,1),
(41,51,1),
(42,52,1),
(43,53,1),
(44,54,1),
(45,55,1),
(46,56,1),
(47,57,1),
(48,58,1),
(49,59,1),
(50,60,1),
(51,61,1),
(52,62,1),
(53,63,1),
(55,96,1),
(56,133,1),
(57,134,1);

/*Table structure for table `reportes_artista_evento` */

DROP TABLE IF EXISTS `reportes_artista_evento`;

CREATE TABLE `reportes_artista_evento` (
  `idreporte` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `fecha` date DEFAULT current_timestamp(),
  `hora` time DEFAULT current_timestamp(),
  PRIMARY KEY (`idreporte`),
  KEY `fk_iddp_report_art_evento` (`iddetalle_presentacion`),
  CONSTRAINT `fk_iddp_report_art_evento` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `reportes_artista_evento` */

/*Table structure for table `reservas` */

DROP TABLE IF EXISTS `reservas`;

CREATE TABLE `reservas` (
  `idreserva` int(11) NOT NULL AUTO_INCREMENT,
  `idpagocontrato` int(11) NOT NULL,
  `vigencia` int(11) NOT NULL,
  `fechacreada` date NOT NULL,
  PRIMARY KEY (`idreserva`),
  KEY `fk_idpagocontrato_res` (`idpagocontrato`),
  CONSTRAINT `fk_idpagocontrato_res` FOREIGN KEY (`idpagocontrato`) REFERENCES `pagos_contrato` (`idpagocontrato`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `reservas` */

insert  into `reservas`(`idreserva`,`idpagocontrato`,`vigencia`,`fechacreada`) values 
(1,2,7,'2025-05-06'),
(2,13,7,'2025-05-07'),
(3,16,7,'2025-05-07');

/*Table structure for table `responsables_boleteria_contratoreservasreservas` */

DROP TABLE IF EXISTS `responsables_boleteria_contratoreservasreservas`;

CREATE TABLE `responsables_boleteria_contratoreservasreservas` (
  `idresponsablecontrato` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) NOT NULL,
  `idusuarioBoleteria` int(11) DEFAULT NULL,
  `idusuarioContrato` int(11) DEFAULT NULL,
  PRIMARY KEY (`idresponsablecontrato`),
  KEY `fk_idusuario_boleteria` (`idusuarioBoleteria`),
  KEY `fk_idusuario_contrato` (`idusuarioContrato`),
  CONSTRAINT `fk_idusuario_boleteria` FOREIGN KEY (`idusuarioBoleteria`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_idusuario_contrato` FOREIGN KEY (`idusuarioContrato`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `responsables_boleteria_contratoreservasreservas` */

/*Table structure for table `subidas_agenda_edicion` */

DROP TABLE IF EXISTS `subidas_agenda_edicion`;

CREATE TABLE `subidas_agenda_edicion` (
  `idsubida` int(11) NOT NULL AUTO_INCREMENT,
  `idagendaeditor` int(11) NOT NULL,
  `url` text NOT NULL,
  `observaciones` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idsubida`),
  KEY `fk_subidas_agenda_edi` (`idagendaeditor`),
  CONSTRAINT `fk_subidas_agenda_edi` FOREIGN KEY (`idagendaeditor`) REFERENCES `agenda_editores` (`idagendaeditor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `subidas_agenda_edicion` */

/*Table structure for table `sucursales` */

DROP TABLE IF EXISTS `sucursales`;

CREATE TABLE `sucursales` (
  `idsucursal` int(11) NOT NULL AUTO_INCREMENT,
  `idempresa` int(11) NOT NULL,
  `iddistrito` int(11) NOT NULL,
  `idresponsable` int(11) DEFAULT NULL,
  `nombre` varchar(120) DEFAULT NULL,
  `ruc` char(11) NOT NULL,
  `telefono` char(20) DEFAULT NULL,
  `direccion` varchar(120) NOT NULL,
  `email` varchar(120) DEFAULT NULL,
  `ubigeo` char(6) DEFAULT NULL,
  PRIMARY KEY (`idsucursal`),
  KEY `fk_iddistrito_sucu` (`iddistrito`),
  KEY `fk_idempresa_sucu` (`idempresa`),
  CONSTRAINT `fk_iddistrito_sucu` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  CONSTRAINT `fk_idempresa_sucu` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`idempresa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `sucursales` */

insert  into `sucursales`(`idsucursal`,`idempresa`,`iddistrito`,`idresponsable`,`nombre`,`ruc`,`telefono`,`direccion`,`email`,`ubigeo`) values 
(1,1,1,6,'Sucursal Central','20123456789','012345678','Av. Siempre Viva 742','contacto@sucursalcentral.com','150101');

/*Table structure for table `tareas_diaria_asignacion` */

DROP TABLE IF EXISTS `tareas_diaria_asignacion`;

CREATE TABLE `tareas_diaria_asignacion` (
  `idtaradiariaasig` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) NOT NULL,
  `idtareadiaria` int(11) NOT NULL,
  `fecha_entrega` date NOT NULL,
  `hora_entrega` time NOT NULL,
  `estado` smallint(6) DEFAULT 1,
  PRIMARY KEY (`idtaradiariaasig`),
  KEY `fk_idusuario` (`idusuario`),
  KEY `fk_idtareadiaria_asig` (`idtareadiaria`),
  CONSTRAINT `fk_idtareadiaria_asig` FOREIGN KEY (`idtareadiaria`) REFERENCES `tareas_diarias` (`idtareadiaria`),
  CONSTRAINT `fk_idusuario` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tareas_diaria_asignacion` */

insert  into `tareas_diaria_asignacion`(`idtaradiariaasig`,`idusuario`,`idtareadiaria`,`fecha_entrega`,`hora_entrega`,`estado`) values 
(1,7,1,'2025-05-07','21:31:00',1),
(2,7,1,'2025-05-07','23:33:00',1);

/*Table structure for table `tareas_diarias` */

DROP TABLE IF EXISTS `tareas_diarias`;

CREATE TABLE `tareas_diarias` (
  `idtareadiaria` int(11) NOT NULL AUTO_INCREMENT,
  `tarea` varchar(120) NOT NULL,
  PRIMARY KEY (`idtareadiaria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tareas_diarias` */

insert  into `tareas_diarias`(`idtareadiaria`,`tarea`) values 
(1,'Limpiar espacio'),
(2,'limpiar el baño'),
(3,'guardar videos');

/*Table structure for table `tarifario` */

DROP TABLE IF EXISTS `tarifario`;

CREATE TABLE `tarifario` (
  `idtarifario` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) NOT NULL,
  `idprovincia` int(11) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `tipo_evento` int(11) NOT NULL,
  `idnacionalidad` int(11) DEFAULT NULL,
  `precioExtranjero` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idtarifario`),
  KEY `fk_idartista_tar` (`idusuario`),
  KEY `fk_provincia_tarifario_art` (`idprovincia`),
  KEY `fk_idnacionalidad_tarifario` (`idnacionalidad`),
  CONSTRAINT `fk_idartista_tar` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_idnacionalidad_tarifario` FOREIGN KEY (`idnacionalidad`) REFERENCES `nacionalidades` (`idnacionalidad`),
  CONSTRAINT `fk_provincia_tarifario_art` FOREIGN KEY (`idprovincia`) REFERENCES `provincias` (`idprovincia`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tarifario` */

insert  into `tarifario`(`idtarifario`,`idusuario`,`idprovincia`,`precio`,`tipo_evento`,`idnacionalidad`,`precioExtranjero`) values 
(1,8,NULL,600.00,1,35,510.00),
(2,8,NULL,500.00,2,35,NULL),
(3,8,NULL,300.00,1,34,NULL),
(4,8,NULL,123.00,1,17,NULL),
(5,8,NULL,432.00,1,15,NULL),
(6,8,NULL,321.00,1,13,NULL),
(7,8,NULL,412.00,1,16,NULL),
(8,8,NULL,555.00,1,18,4212.00),
(9,5,98,344.00,1,NULL,NULL),
(10,2,NULL,999.00,1,10,889.00),
(11,8,98,45000.00,1,31,NULL),
(12,2,100,80000.00,1,NULL,NULL),
(13,2,87,10000.00,1,NULL,NULL),
(14,2,100,80000.00,1,NULL,15000.00),
(15,2,100,80000.00,1,NULL,344.00),
(16,2,100,667.00,1,NULL,776.00),
(17,8,122,80000.00,1,31,NULL);

/*Table structure for table `tipotarea` */

DROP TABLE IF EXISTS `tipotarea`;

CREATE TABLE `tipotarea` (
  `idtipotarea` int(11) NOT NULL AUTO_INCREMENT,
  `tipotarea` varchar(30) NOT NULL,
  PRIMARY KEY (`idtipotarea`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tipotarea` */

insert  into `tipotarea`(`idtipotarea`,`tipotarea`) values 
(1,'Flayer'),
(2,'Saludos'),
(3,'Reels'),
(4,'Fotos'),
(5,'Contenido');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `idsucursal` int(11) NOT NULL,
  `idnivelacceso` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL,
  `nom_usuario` varchar(120) NOT NULL,
  `claveacceso` varbinary(255) NOT NULL,
  `color` char(7) DEFAULT NULL,
  `porcentaje` int(11) DEFAULT NULL,
  `marcaagua` varchar(40) DEFAULT NULL,
  `firma` varchar(40) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_nom_usuario` (`nom_usuario`),
  KEY `fk_idpersona` (`idpersona`),
  KEY `fk_idnivelacceso` (`idnivelacceso`),
  KEY `fk_idsucursal` (`idsucursal`),
  CONSTRAINT `fk_idnivelacceso` FOREIGN KEY (`idnivelacceso`) REFERENCES `nivelaccesos` (`idnivelacceso`),
  CONSTRAINT `fk_idpersona` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`),
  CONSTRAINT `fk_idsucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursales` (`idsucursal`),
  CONSTRAINT `ck_estado_usuario` CHECK (`estado` in (1,2))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`idsucursal`,`idnivelacceso`,`idpersona`,`nom_usuario`,`claveacceso`,`color`,`porcentaje`,`marcaagua`,`firma`,`estado`,`create_at`,`update_at`) values 
(1,1,3,1,'royer','$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC',NULL,NULL,NULL,NULL,1,'2025-04-16 00:31:03',NULL),
(2,1,6,2,'Azucena Calvay','$2y$10$DV8s.WeO1qqp0vajRZV7Qu7vsuYg3RIxsMd5chWDNkqFfpqghtRcu','#ff0000',75,NULL,NULL,1,'2025-04-16 07:54:32',NULL),
(3,1,6,3,'Aracely y su alma rebelde','$2y$10$nLSullMR85bIlGqPat0i8.dt0QiEVcsWfBiekUZ8kHszaUzxz146u','#7300ff',30,NULL,NULL,1,'2025-04-16 07:58:13',NULL),
(4,1,6,4,'Oscar Manuel','$2y$10$rJpQf4Gfe5pim90tMKo3vODD0s94oRV6iqGUef3hkAWRVnskoYrwK','#4dff00',75,NULL,NULL,1,'2025-04-16 07:59:10',NULL),
(5,1,6,5,'Estefany Lozano y su pasion mo','$2y$10$16k3komtv2Xj9C7/x8VHluQBttewT08O5sd8hINvgbK6ZvQHK2eBm','#fff700',70,NULL,NULL,1,'2025-04-16 08:00:31',NULL),
(6,1,3,6,'Nayade Admin','$2y$10$mcm7C34YJZzVyAmCbosun.125FGAuD7V7ztQDolurUULedbi/8tDS','#000000',NULL,NULL,NULL,1,'2025-04-16 12:55:39',NULL),
(7,1,10,7,'andre','$2y$10$dQ3NfB7BZlOXod3O2vC4VenxnR5aUXkltYA16sV52wO4De2Gvj6sK','#000000',NULL,NULL,NULL,1,'2025-04-16 18:11:44',NULL),
(8,1,6,8,'Nataly Ramirez','$2y$10$aerfMPtTcMgare/akrlZ1OlcuDtJzX0QyPJcLjRIlmR51JMbZkbaa','#0091ff',50,NULL,NULL,1,'2025-05-05 09:55:44',NULL);

/*Table structure for table `viaticos` */

DROP TABLE IF EXISTS `viaticos`;

CREATE TABLE `viaticos` (
  `idviatico` int(11) NOT NULL AUTO_INCREMENT,
  `iddetalle_presentacion` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `pasaje` decimal(7,2) DEFAULT NULL,
  `hospedaje` decimal(7,2) DEFAULT NULL,
  `desayuno` tinyint(4) DEFAULT NULL,
  `almuerzo` tinyint(4) DEFAULT NULL,
  `cena` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idviatico`),
  KEY `fk_iddp_viatico` (`iddetalle_presentacion`),
  KEY `fk_idusuario_v` (`idusuario`),
  CONSTRAINT `fk_iddp_viatico` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  CONSTRAINT `fk_idusuario_v` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `viaticos` */

/* Procedure structure for procedure `obtenerContrato` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerContrato` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerContrato`(
    IN _idcontrato INT
)
BEGIN
    SELECT 		
        CO.idcontrato, 
        CLI.razonsocial, CLI.tipodoc ,CLI.ndocumento, CLI.direccion, CLI.representantelegal, CLI.correo, CLI.telefono,
        DISCLI.distrito, PROCLI.provincia, DECLI.departamento, 
        USU.nom_usuario,
        DP.iddetalle_presentacion,
        DP.fecha_presentacion,
        DP.horainicio,
        DP.horafinal,
        DP.establecimiento, 
        DP.referencia,
        DP.idusuario,
        DP.tipo_evento,
        DISDP.distrito AS distrito_evento, 
        PRODP.provincia AS provincia_evento, 
        PRODP.idprovincia AS idprovincia_evento,
        DEDP.departamento AS departamento_evento,
        DP.igv,
        CO.estado,
        USU.marcaagua,
		NAC.pais,
        NAC.idnacionalidad,
        DP.esExtranjero
    FROM contratos CO
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = CO.iddetalle_presentacion
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN distritos DISCLI ON DISCLI.iddistrito = CLI.iddistrito
    LEFT JOIN provincias PROCLI ON PROCLI.idprovincia = DISCLI.idprovincia
    LEFT JOIN departamentos DECLI ON DECLI.iddepartamento = PROCLI.iddepartamento
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = DP.idnacionalidad
    WHERE CO.idcontrato = _idcontrato;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerContratoConvenio` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerContratoConvenio` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerContratoConvenio`(
	IN _idconvenio	INT
)
BEGIN
	SELECT 		
		C.idconvenio, 
        CLI.razonsocial, CLI.tipodoc ,CLI.ndocumento, CLI.direccion, CLI.representantelegal,
        DISCLI.distrito, PROCLI.provincia, DECLI.departamento, 
        USU.nom_usuario,
        DP.fecha_presentacion,
        DP.horainicio,
        DP.horafinal,
        DP.establecimiento,
        DP.referencia,
        DISDP.distrito as distrito_evento, PRODP.provincia as provincia_evento, DEDP.departamento as departamento_evento,
        DP.igv,
		C.abono_garantia, C.abono_publicidad,
        C.porcentaje_vega, C.porcentaje_promotor,
        USU.marcaagua,
        NAC.pais,
        NAC.idnacionalidad,
        DP.esExtranjero
	FROM convenios C
	LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = C.iddetalle_presentacion
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN distritos DISCLI ON DISCLI.iddistrito = CLI.iddistrito
    LEFT JOIN provincias PROCLI ON PROCLI.idprovincia = DISCLI.idprovincia
    LEFT JOIN departamentos DECLI ON DECLI.iddepartamento = PROCLI.iddepartamento
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
	LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    LEFT JOIN usuarios	USU ON USU.idusuario = DP.idusuario
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = DP.idnacionalidad
    WHERE C.idconvenio = _idconvenio; -- me quede aca
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerConvenioPorIdDP` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerConvenioPorIdDP` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerConvenioPorIdDP`(
	IN _iddetalle_presentacion	INT
)
BEGIN
	SELECT 		
		C.idconvenio, USU.idusuario
	FROM convenios C
	LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = C.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    WHERE C.iddetalle_presentacion = _iddetalle_presentacion; -- me quede aca
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerSucursalPorId` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerSucursalPorId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerSucursalPorId`(
	IN _idsucursal INT
)
BEGIN
    SELECT 
*
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE SUC.idsucursal = _idsucursal;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerUsuarioAsignado` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerUsuarioAsignado` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerUsuarioAsignado`(
    IN p_idagendaedicion INT,
    IN p_idtipotarea INT
)
BEGIN
    SELECT 
        ae.idagendaeditor,
        ae.idusuario,
        u.nom_usuario,
        tt.tipotarea,
        tt.idtipotarea,
        ae.estado,
        ae.fecha_asignacion,
        ae.fecha_entrega,
        ae.hora_entrega
    FROM agenda_editores ae
    JOIN usuarios u ON ae.idusuario = u.idusuario
    JOIN tipotarea tt ON ae.idtipotarea = tt.idtipotarea
    WHERE ae.idagendaedicion = p_idagendaedicion
    AND ae.idtipotarea = p_idtipotarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_agenda_editor` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_agenda_editor` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_agenda_editor`(
	IN _idagendaeditor INT,
    IN _idusuario INT,
    IN _idtipotarea INT,
    IN _fecha_entrega DATE,
	IN _hora_entrega TIME
)
BEGIN
		UPDATE agenda_editores SET
    idusuario = _idusuario,
    idtipotarea = _idtipotarea,
    fecha_entrega = _fecha_entrega,
    hora_entrega = _hora_entrega
    WHERE idagendaeditor = _idagendaeditor; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_caja_dp` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_caja_dp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_caja_dp`(
	IN _iddetalle_presentacion INT,
    IN _tienecaja TINYINT
)
BEGIN
		UPDATE detalles_presentacion SET
    tienecaja = _tienecaja
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_ccfinal` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_ccfinal` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_ccfinal`(
	IN _idcajachica			INT,
    IN _ccfinal			double (10,2)
)
BEGIN 
	UPDATE cajachica SET
    ccfinal = _ccfinal
    WHERE idcajachica = _idcajachica;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_cliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_cliente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_cliente`(
	IN _idcliente			INT,
    IN _tipodoc				INT,
    IN _iddistrito			INT,
    IN _ndocumento			CHAR(20),
    IN _razonsocial			VARCHAR(130),
    IN _representantelegal			VARCHAR(130),
    IN _telefono			 char(15),
    IN _correo			VARCHAR(130),
    IN _direccion			VARCHAR(130)
)
BEGIN 
	UPDATE clientes SET
    tipodoc = _tipodoc,
    iddistrito = _iddistrito,
    ndocumento = nullif(_ndocumento, ''),
    razonsocial = _razonsocial,
    representantelegal = nullif(_representantelegal, ''),
    telefono = nullif(_telefono, ''),
    correo = nullif(_correo, ''),
    direccion = _direccion
    WHERE idcliente = _idcliente;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_convenio` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_convenio` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_convenio`(
	IN _idconvenio			INT,
    IN _abono_garantia		decimal(10,2) ,
    IN _abono_publicidad 	decimal(10,2) ,
    IN _porcentaje_vega int,
    IN _porcentaje_promotor int,
    IN _propuesta_cliente 	TEXT,
    IN _estado				INT
)
BEGIN 
	UPDATE convenios SET
    abono_garantia = _abono_garantia,
    abono_publicidad = _abono_publicidad,
    porcentaje_vega = _porcentaje_vega,
    porcentaje_promotor = _porcentaje_promotor,
    propuesta_cliente = _propuesta_cliente,
    estado = _estado,
    updated_at = now()
    WHERE idconvenio = _idconvenio;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_copy_contenido` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_copy_contenido` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_copy_contenido`(
	IN _idagendacommanager INT,
    IN _copy text
)
BEGIN
		UPDATE agenda_commanager SET
    copy = _copy    
    WHERE idagendacommanager = _idagendacommanager; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_decremento` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_decremento` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_decremento`(
	IN _idcajachica			INT,
    IN _decremento			double (10,2)
)
BEGIN 
	UPDATE cajachica SET
    decremento = _decremento
    WHERE idcajachica = _idcajachica;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_detalle_presentacion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_detalle_presentacion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_detalle_presentacion`(
	IN _iddetalle_presentacion INT,
    IN _fechapresentacion date,
    IN _horainicio time,
    IN _horafinal time,
    IN _establecimiento VARCHAR(80),
    IN _referencia VARCHAR(200),
    IN _tipoevento int,
    IN _modotransporte	int,
	IN _validez int,
    IN _iddistrito int,
    IN _igv TINYINT
)
BEGIN
	UPDATE detalles_presentacion SET
	fecha_presentacion = _fechapresentacion,
	horainicio = _horainicio,
	horafinal = _horafinal,
	establecimiento = _establecimiento,
	referencia = nullif(_referencia, ''),
	tipo_evento = _tipoevento,
    modotransporte = nullif(_modotransporte, ''),
	validez = nullif(_validez, ''),
	iddistrito = _iddistrito,
	igv = _igv
	WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_empresa` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_empresa` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_empresa`(
	IN _idempresa INT,
    IN _ruc char(11),
    IN _logoempresa varchar(80),
    IN _razonsocial VARCHAR(120),
    IN _nombrecomercial varchar(120),
    IN _nombreapp varchar(120),
    IN _direccion varchar(120),
    IN _web VARCHAR(120),
    -- IN _usuariosol char(8),
    -- IN _clavesol char(12),
    -- IN _certificado text,
    IN _correo varchar(120),
    IN _contrasenagmailapp varchar(120),
    IN _ncuenta VARCHAR(30),
    IN _ncci VARCHAR(30),
    IN _banco VARCHAR(30),
    IN _moneda VARCHAR(30)
)
BEGIN
		UPDATE empresa SET
	ruc = _ruc,
    logoempresa = nullif(_logoempresa, ''),
    razonsocial = nullif(_razonsocial,''),
    nombrecomercial = nullif(_nombrecomercial, ''),
    nombreapp = nullif(_nombreapp, ''),
    direccion = nullif(_direccion, ''),
    web = nullif(_web, ''),
    -- usuariosol = nullif(_usuariosol, ''),
    -- clavesol = nullif(_clavesol, ''),
    -- certificado = nullif(_certificado , ''),
    correo = nullif(_correo , ''),
    contrasenagmailapp = nullif(_contrasenagmailapp , ''),
    ncuenta = nullif(_ncuenta , ''),
    ncci = nullif(_ncci , ''),
    banco = nullif(_banco , ''),
    moneda = nullif(_moneda , '')
    WHERE idempresa = _idempresa; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_caja` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_caja` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_caja`(
	IN _idcajachica			INT,
    IN _estado			tinyint
)
BEGIN 
	UPDATE cajachica SET
    estado = _estado,
    fecha_cierre = now()
    WHERE idcajachica = _idcajachica;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_contrato` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_contrato` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_contrato`(
	IN _idcontrato			INT,
    IN _estado			INT
)
BEGIN 
	UPDATE contratos SET
    estado = _estado,
    updated_at = now()
    WHERE idcontrato = _idcontrato;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_convenio` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_convenio` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_convenio`(
	IN _idconvenio			INT,
    IN _estado			INT
)
BEGIN 
	UPDATE convenios SET
    estado = _estado,
    updated_at = now()
    WHERE idconvenio = _idconvenio;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_cuota_comprobante` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_cuota_comprobante` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_cuota_comprobante`(
	IN _idcuotacomprobante INT,
    IN _estado TINYINT
)
BEGIN
    		UPDATE cuotas_comprobante SET
	estado = _estado
    WHERE idcuotacomprobante = _idcuotacomprobante; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_dp` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_dp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_dp`(
	IN _iddetalle_presentacion INT,
    IN _estado TINYINT
)
BEGIN
		UPDATE detalles_presentacion SET
    estado = _estado
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_publicar_contenido` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_publicar_contenido` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_publicar_contenido`(
	IN _idagendacommanager INT,
    IN _estado SMALLINT
)
BEGIN
		UPDATE agenda_commanager SET
    estado = _estado    ,
    fechapublicacion = now()
    WHERE idagendacommanager = _idagendacommanager; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_reserva_dp` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_reserva_dp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_reserva_dp`(
	IN _iddetalle_presentacion INT,
    IN _reserva TINYINT
)
BEGIN
		UPDATE detalles_presentacion SET
    reserva = _reserva
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_tarea_altoketicket` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_tarea_altoketicket` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_tarea_altoketicket`(
	IN _idagendaeditor INT,
    IN _altoketicket VARCHAR(250)
)
BEGIN
	UPDATE agenda_editores SET
    altoketicket = _altoketicket
    WHERE idagendaeditor = _idagendaeditor; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_tarea_diaria_asignacion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_tarea_diaria_asignacion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_tarea_diaria_asignacion`(
	IN _idtaradiariaasig INT,
    IN _estado SMALLINT
)
BEGIN
		UPDATE tareas_diaria_asignacion SET
    estado = _estado    
    WHERE idtaradiariaasig = _idtaradiariaasig; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_estado_tarea_edicion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_estado_tarea_edicion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_tarea_edicion`(
	IN _idagendaeditor INT,
    IN _estado VARCHAR(250)
)
BEGIN
	UPDATE agenda_editores SET
    estado = _estado
    WHERE idagendaeditor = _idagendaeditor; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_incremento` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_incremento` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_incremento`(
	IN _idcajachica			INT,
    IN _incremento			double (10,2)
)
BEGIN 
	UPDATE cajachica SET
    incremento = _incremento
    WHERE idcajachica = _idcajachica;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_monto_cajachica` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_monto_cajachica` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_monto_cajachica`(
	IN _idmonto			INT,
    IN _monto			 DECIMAL(10,2)
)
BEGIN 
	UPDATE montoCajaChica SET
    monto = _monto
    WHERE idmonto = _idmonto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_nombre_tipotarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_nombre_tipotarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_nombre_tipotarea`(
	IN _idtipotarea INT,
    IN _tipotarea varchar(30)
)
BEGIN
		UPDATE tipotarea SET
    tipotarea = _tipotarea    
    WHERE idtipotarea = _idtipotarea; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_observacion_subida` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_observacion_subida` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_observacion_subida`(
	IN _idsubida INT,
    IN _observaciones VARCHAR(250)
)
BEGIN
	UPDATE subidas_agenda_edicion SET
    observaciones = _observaciones
    WHERE idsubida = _idsubida; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_pagado50_dp` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_pagado50_dp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_pagado50_dp`(
	IN _iddetalle_presentacion INT,
    IN _pagado50 TINYINT
)
BEGIN
		UPDATE detalles_presentacion SET
    pagado50 = _pagado50
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_persona` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_persona` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_persona`(
	IN _idpersona INT,
    IN _num_doc VARCHAR(20),
    IN _apellidos varchar(100),
    IN _nombres	varchar(100),
    IN _genero char(1),
    IN _direccion varchar(150),
    IN _telefono char(15),
    IN _telefono2 char(15),
    IN _correo char(150),
    IN _iddistrito INT
)
BEGIN
		UPDATE personas SET
        num_doc = nullif(_num_doc,''),
        apellidos = nullif(_apellidos, ''),
        nombres = nullif(_nombres, ''),
        genero = nullif(_genero, ''),
        telefono = nullif(_telefono, ''),
        telefono2 = nullif(_telefono2, ''),
        correo = nullif(_correo, ''),
        iddistrito = nullif(_iddistrito, ''),
		update_at = now()
    WHERE idpersona = _idpersona; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_precios_entrada_evento` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_precios_entrada_evento` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_precios_entrada_evento`(
	IN _idprecioentradaevento INT,
    IN _entradas TEXT
)
BEGIN
		UPDATE precios_entrada_evento SET
    entradas = nullif(_entradas, '')
    WHERE idprecioentradaevento = _idprecioentradaevento; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_responsables_boleteria_contrato_evento` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_responsables_boleteria_contrato_evento` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_responsables_boleteria_contrato_evento`(
	IN _idresponsablecontrato INT,
    IN _idusuarioBoleteria INT,
    IN _idusuarioContrato INT
)
BEGIN
		UPDATE responsables_boleteria_contratoreservasreservas SET
    idusuarioBoleteria = nullif(_idusuarioBoleteria, ''),
    idusuarioContrato = nullif(_idusuarioContrato, '')
    WHERE idresponsablecontrato = _idresponsablecontrato; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_sucursal` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_sucursal` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_sucursal`(
	IN _idsucursal INT,
    IN _idempresa INT,
    IN _iddistrito INT,
    IN _idresponsable INT,
    IN _nombre VARCHAR(120),
    IN _ruc char(11),
    IN _telefono CHAR(20),
    IN _direccion VARCHAR(120),
    IN _email VARCHAR(120),
    IN _ubigeo CHAR(6)
)
BEGIN
		UPDATE sucursales SET
	idempresa = _idempresa,
    iddistrito = _iddistrito,
    idresponsable = _idresponsable,
    nombre = _nombre,
    ruc = _ruc,
    telefono = _telefono,
    direccion = _direccion,
    email = _email,
    ubigeo = _ubigeo
    WHERE idsucursal = _idsucursal; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_tarifa` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_tarifa` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_tarifa`(
	IN _idtarifario			INT,
    IN _precio			DECIMAL(10,2)
)
BEGIN 
	UPDATE tarifario SET
    precio = _precio
    WHERE idtarifario = _idtarifario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_tarifa_precio_extranjero` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_tarifa_precio_extranjero` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_tarifa_precio_extranjero`(
	IN _idtarifario			INT,
    IN _precioExtranjero DECIMAL(10,2)
)
BEGIN 
	UPDATE tarifario SET
    precioExtranjero = _precioExtranjero
    WHERE idtarifario = _idtarifario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_usuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_usuario`(
	IN _idsucursal INT,
	IN _idusuario INT,
    IN _nom_usuario VARCHAR(120),
    IN _claveacceso VARBINARY(255),
    IN _color	CHAR(7),
    IN _porcentaje INT,
    IN _marcaagua varchar(80),
    IN _firma	VARCHAR(80)
)
BEGIN
		UPDATE usuarios 
    SET 
		idsucursal = NULLIF(_idsucursal, ''),
        nom_usuario = NULLIF(_nom_usuario, ''),
        color = NULLIF(_color, ''),
        porcentaje = NULLIF(_porcentaje, ''),
        marcaagua = NULLIF(_marcaagua, ''),
        firma = NULLIF(_firma, ''),
        update_at = NOW()
    WHERE idusuario = _idusuario;
    -- Solo actualizar claveacceso si se proporciona un valor válido
    IF _claveacceso IS NOT NULL AND LENGTH(_claveacceso) > 0 THEN
        UPDATE usuarios 
        SET claveacceso = _claveacceso
        WHERE idusuario = _idusuario;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_viatico` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_viatico` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_viatico`(
	IN _idviatico			INT,
    IN _pasaje			INT
)
BEGIN 
	UPDATE viaticos SET
    pasaje = _pasaje
    WHERE idviatico = _idviatico;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_asignarfilmmaker_dp` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_asignarfilmmaker_dp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignarfilmmaker_dp`(
	IN _iddetalle_presentacion INT,
    IN _idusuario INT
)
BEGIN
		UPDATE detalles_presentacion_asignados SET
    idusuario = nullif(_idusuario, '')
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_asignar_agenda` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_asignar_agenda` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignar_agenda`(
    OUT _idasignacion INT,
	IN _iddetalle_presentacion int,
    IN _idusuario INT
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO agenda_asignaciones (iddetalle_presentacion, idusuario)
    VALUES (_iddetalle_presentacion, _idusuario);
    
    IF existe_error = 1 THEN
        SET _idasignacion = -1;
    ELSE
        SET _idasignacion = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_asignar_agenda_cmanager` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_asignar_agenda_cmanager` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignar_agenda_cmanager`(
	OUT _idagendacommanager INT,
    IN _idagendaeditor INT,
    IN _idusuarioCmanager INT
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO agenda_commanager (idagendaeditor,idusuarioCmanager) VALUES 
		(_idagendaeditor,_idusuarioCmanager);
        
	IF existe_error= 1 THEN
		SET _idagendacommanager = -1;
	ELSE
        SET _idagendacommanager = last_insert_id();
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_asignar_agenda_editor` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_asignar_agenda_editor` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignar_agenda_editor`(
    OUT _idagendaeditor INT,
	IN _idagendaedicion int,
	IN _idusuario int,
    IN _idtipotarea INT,
    IN _fecha_entrega date,
    IN _hora_entrega TIME
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO agenda_editores (idagendaedicion, idusuario , idtipotarea, fecha_entrega, hora_entrega)
    VALUES (_idagendaedicion, _idusuario, _idtipotarea, _fecha_entrega, _hora_entrega);
    
    IF existe_error = 1 THEN
        SET _idagendaeditor = -1;
    ELSE
        SET _idagendaeditor = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_asignar_portal_web_contenido` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_asignar_portal_web_contenido` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignar_portal_web_contenido`(
	IN _idagendacommanager INT,
    IN _portalpublicar VARCHAR(120)
)
BEGIN
		UPDATE agenda_commanager SET
    portalpublicar = _portalpublicar    
    WHERE idagendacommanager = _idagendacommanager; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_asignar_tarea_diaria` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_asignar_tarea_diaria` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignar_tarea_diaria`(
	OUT _idtaradiariaasig INT,
    IN _idusuario INT,
    IN _idtareadiaria int,
    IN _fecha_entrega DATE,
    IN _hora_entrega TIME
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tareas_diaria_asignacion (idusuario, idtareadiaria, fecha_entrega, hora_entrega)VALUES 
		(_idusuario, _idtareadiaria, _fecha_entrega, _hora_entrega);
        
	IF existe_error= 1 THEN
		SET _idtaradiariaasig = -1;
	ELSE
        SET _idtaradiariaasig = last_insert_id();
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deshabilitar_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deshabilitar_usuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deshabilitar_usuario`(
	IN _idusuario INT,
    IN _estado TINYINT
)
BEGIN
		UPDATE usuarios SET
        estado = _estado,
        update_at = now()
    WHERE idusuario = _idusuario; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_detalles_presentacion_por_modalidad` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_detalles_presentacion_por_modalidad` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalles_presentacion_por_modalidad`(
	IN _modalidad INT,
	IN _igv tinyint
)
BEGIN
    SELECT 
        DP.iddetalle_presentacion, 
        CLI.ndocumento,
        DP.ncotizacion,
        USU.idusuario,
        USU.nom_usuario, 
        CLI.razonsocial, 
        DP.tipo_evento, 
        DP.modalidad, 
        DP.fecha_presentacion, 
        DP.establecimiento,
        CO.idcontrato, 
        DP.validez,
        DP.reserva,
        DP.pagado50,
        DP.created_at,
        RE.vigencia as vigencia_reserva,
        RE.fechacreada as fechacreada_reserva,
        CO.idcontrato,
		DP.estado,
        CON.estado as estado_convenio,
        CO.estado as estado_contrato,
        DP.tienecaja,
        DEDP.departamento, PRODP.provincia, DISDP.distrito
    FROM detalles_presentacion DP
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN pagos_contrato PC ON PC.idcontrato = CO.idcontrato
    LEFT JOIN reservas RE ON RE.idpagocontrato = PC.idpagocontrato
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    WHERE DP.modalidad = _modalidad AND (_igv IS NULL OR DP.igv = _igv)
    GROUP BY DP.iddetalle_presentacion, CO.idcontrato;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_editar_acuerdo_evento` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_editar_acuerdo_evento` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_acuerdo_evento`(
	IN _iddetalle_presentacion INT,
    IN _acuerdo TEXT
)
BEGIN
		UPDATE detalles_presentacion SET
    acuerdo = nullif(_acuerdo, '')
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_filtrar_cajachica` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_filtrar_cajachica` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_filtrar_cajachica`(
    IN _fecha_apertura DATETIME,
    IN _fecha_cierre DATETIME,
    IN _mes INT,
    IN _año_semana INT,
    IN _busqueda_general VARCHAR(255)
)
BEGIN
    SELECT 
    CA.idcajachica, CA.idmonto, CA.ccinicial, CA.incremento, CA.decremento, CA.ccfinal, CA.estado, CA.fecha_cierre, CA.fecha_apertura,
    DP.iddetalle_presentacion, DP.fecha_presentacion, DP.establecimiento, DIS.distrito, PRO.provincia, DE.departamento,
	USU.nom_usuario
    FROM cajachica CA
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = CA.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
    WHERE 
        -- Filtrar por fecha de apertura
        (_fecha_apertura IS NULL OR CA.fecha_apertura >= _fecha_apertura)
        
        -- Filtrar por fecha de cierre (considerando NULL como abierto)
        AND (_fecha_cierre IS NULL OR CA.fecha_cierre <= _fecha_cierre OR CA.fecha_cierre IS NULL)
        
        -- Filtrar por mes (cuando _mes es diferente de NULL)
        AND (_mes IS NULL OR MONTH(CA.fecha_apertura) = _mes)
        
        -- Filtrar por semana del año (cuando _año_semana es diferente de NULL)
        AND (_año_semana IS NULL OR CONCAT(YEAR(CA.fecha_apertura), LPAD(WEEK(CA.fecha_apertura, 3), 2, '0')) = _año_semana)
        
        -- Filtrar por nombre de usuario y establecimiento unidos
        AND (_busqueda_general IS NULL 
            OR CONCAT(USU.nom_usuario, ' ', DP.establecimiento) LIKE CONCAT('%', _busqueda_general, '%'));
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_filtrar_reparticiones` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_filtrar_reparticiones` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_filtrar_reparticiones`(
    IN _nom_usuario VARCHAR(30),
    IN _establecimiento VARCHAR(80),
    IN _fecha_presentacion DATE
)
BEGIN
    SELECT 
       RI.idreparticion, RI.estado,
       USU.nom_usuario, USU.idusuario, USU.porcentaje,
       DP.establecimiento, DP.fecha_presentacion, DP.iddetalle_presentacion
    FROM reparticion_ingresos RI
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = RI.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    WHERE 
    (USU.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%') OR _nom_usuario IS NULL)
    AND (DP.establecimiento LIKE CONCAT('%', COALESCE(_establecimiento, ''), '%') OR _establecimiento IS NULL)
    AND (DP.fecha_presentacion LIKE CONCAT('%', COALESCE(_fecha_presentacion, ''), '%') OR _fecha_presentacion IS NULL);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_listar_sucursales` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_listar_sucursales` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_sucursales`(
	IN _nombre varchar(120),
    IN _iddepartamento int,
    IN _idprovincia int,
    IN _iddistrito	int
)
BEGIN
    SELECT 
	SUC.idsucursal, DEP.iddepartamento, DEP.departamento, PRO.idprovincia, PRO.provincia, DIS.iddistrito, DIS.distrito,SUC.nombre, SUC.ruc, SUC.telefono, SUC.direccion, PER.nombres, PER.apellidos
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    LEFT JOIN usuarios USU ON USU.idusuario = SUC.idresponsable
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE (SUC.nombre LIKE CONCAT('%', COALESCE(_nombre, ''), '%') OR _nombre IS NULL)
	AND (DIS.iddistrito LIKE CONCAT('%', COALESCE(_iddistrito, ''), '%') OR _iddistrito IS NULL)
	AND (PRO.idprovincia LIKE CONCAT('%', COALESCE(_idprovincia, ''), '%') OR _idprovincia IS NULL)
    AND (DEP.iddepartamento LIKE CONCAT('%', COALESCE(_iddepartamento, ''), '%') OR _iddepartamento IS NULL);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_mostrar_contenido_revisado_edicion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_mostrar_contenido_revisado_edicion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_contenido_revisado_edicion`(
    IN _iddetalle_presentacion INT
)
BEGIN	
	SELECT 
	*
		FROM agenda_edicion AGED		
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGED.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_iddetalle_presentacion IS NULL OR AGED.iddetalle_presentacion = _iddetalle_presentacion OR AGED.iddetalle_presentacion IS NULL);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_mostrar_contenido_revisado_filmmakers` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_mostrar_contenido_revisado_filmmakers` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_contenido_revisado_filmmakers`(
    IN _iddetalle_presentacion INT
)
BEGIN	
	SELECT 
	*
		FROM agenda_asignaciones AGENA		
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGENA.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_iddetalle_presentacion IS NULL OR AGENA.iddetalle_presentacion = _iddetalle_presentacion OR AGENA.iddetalle_presentacion IS NULL);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtenerCotizacion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtenerCotizacion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtenerCotizacion`(
    IN _iddetalle_presentacion INT
)
BEGIN
    SELECT 		
        DP.iddetalle_presentacion, DP.ncotizacion,
        CLI.razonsocial, CLI.tipodoc, CLI.ndocumento, CLI.direccion, CLI.representantelegal, CLI.correo, CLI.telefono,
        DISCLI.distrito, PROCLI.provincia, DECLI.departamento, 
        USU.nom_usuario,
        DP.fecha_presentacion,
        DP.horainicio,
        DP.horafinal,
        DP.establecimiento,
        DP.referencia,
        DP.idusuario,
        DISDP.distrito AS distrito_evento, 
        PRODP.provincia AS provincia_evento, 
        PRODP.idprovincia AS idprovincia_evento,
        DEDP.departamento AS departamento_evento,
        DP.igv,
        DP.validez,
        USU.marcaagua,
        NAC.pais,
        NAC.idnacionalidad,
        DP.esExtranjero
    FROM detalles_presentacion DP
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN distritos DISCLI ON DISCLI.iddistrito = CLI.iddistrito
    LEFT JOIN provincias PROCLI ON PROCLI.idprovincia = DISCLI.idprovincia
    LEFT JOIN departamentos DECLI ON DECLI.iddepartamento = PROCLI.iddepartamento
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = DP.idnacionalidad
    WHERE DP.iddetalle_presentacion = _iddetalle_presentacion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_agenda` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_agenda` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_agenda`(
    IN _idusuario INT, 
    IN _iddetalle_presentacion INT,
    IN _idnivelacceso INT
)
BEGIN
    SELECT 
        DP.iddetalle_presentacion, 
        CLI.ndocumento,
        DP.ncotizacion,
        USU.nom_usuario, 
        USU.idusuario,
        USU.color,
        CLI.razonsocial, 
        DP.tipo_evento, 
        DP.modalidad, 
        DP.fecha_presentacion, 
        DP.horainicio, DP.horafinal,
        CO.idcontrato, 
        CON.idconvenio,
        DP.validez,
        DP.reserva,
        DP.pagado50,
        DP.establecimiento,
        DP.referencia,
        CO.estado AS estadoContrato,
        DP.created_at,
        DP.acuerdo,
        DP.estado,
        ASIG.idusuario as idusuarioAgenda,
        ASIG.iddetalle_presentacion as idpagenda,
        NIVEL.idnivelacceso, NIVEL.nivelacceso,
        VIA.idviatico,
        GROUP_CONCAT(DISTINCT ASIG.idusuario ORDER BY ASIG.idusuario SEPARATOR ', ') AS idusuarioAgenda,
        (SELECT RE.vigencia 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS vigencia_reserva,
        (SELECT RE.fechacreada 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS fechacreada_reserva,
        DP.estado,
        CON.estado AS estado_convenio,
        DISDP.distrito, 
        PRODP.provincia, 
        DEDP.departamento,
        DEDP.iddepartamento
    FROM detalles_presentacion DP
    LEFT JOIN viaticos VIA ON VIA.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN agenda_asignaciones ASIG ON ASIG.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN usuarios USUASIG ON USUASIG.idusuario = ASIG.idusuario
	LEFT JOIN nivelaccesos NIVEL ON NIVEL.idnivelacceso IN (USU.idnivelacceso, USUASIG.idnivelacceso)
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    WHERE 
        (_idusuario IS NULL OR ASIG.idusuario = _idusuario OR USU.idusuario = _idusuario) AND
        (_iddetalle_presentacion IS NULL OR ASIG.iddetalle_presentacion = _iddetalle_presentacion) AND
        (_idnivelacceso IS NULL OR NIVEL.idnivelacceso = _idnivelacceso)
        GROUP BY DP.iddetalle_presentacion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_agenda_artista` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_agenda_artista` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_agenda_artista`(
    IN _idusuario INT, 
    IN _iddetalle_presentacion INT
)
BEGIN
    SELECT 
        DP.iddetalle_presentacion, 
        CLI.ndocumento,
        DP.ncotizacion,
        USU.nom_usuario, 
        USU.idusuario,
        USU.color,
        CLI.razonsocial, 
        DP.tipo_evento, 
        DP.modalidad, 
        DP.fecha_presentacion, 
        DP.horainicio, DP.horafinal,
        CO.idcontrato, 
        CON.idconvenio,
        DP.validez,
        DP.reserva,
        DP.pagado50,
        DP.establecimiento,
        DP.referencia,
        CO.estado AS estadoContrato,
        DP.created_at,
        DP.acuerdo,
        DP.estado,
        (SELECT RE.vigencia 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS vigencia_reserva,
        (SELECT RE.fechacreada 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS fechacreada_reserva,
        DP.estado,
        CON.estado AS estado_convenio,
        DISDP.distrito, 
        PRODP.provincia, 
        DEDP.departamento,
        DEDP.iddepartamento
    FROM detalles_presentacion DP
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    WHERE 
        (_idusuario IS NULL OR USU.idusuario = _idusuario) AND
        (_iddetalle_presentacion IS NULL OR DP.iddetalle_presentacion = _iddetalle_presentacion);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_agenda_cmmanager` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_agenda_cmmanager` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_agenda_cmmanager`(
    IN _idagendaeditor INT
)
BEGIN
	SELECT 
    * 
    FROM agenda_commanager  AGENC
    LEFT JOIN agenda_editores AGENE ON AGENE.idagendaeditor = AGENC.idagendaeditor
    LEFT JOIN agenda_edicion AGENED ON AGENED.idagendaedicion = AGENE.idagendaedicion
    LEFT JOIN detalles_presentacion DEP ON DEP.iddetalle_presentacion = AGENED.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DEP.idusuario
    LEFT JOIN tipotarea TIPO ON TIPO.idtipotarea = AGENE.idtipotarea
    WHERE AGENE.idagendaeditor = _idagendaeditor;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_agenda_edicion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_agenda_edicion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_agenda_edicion`(
)
BEGIN
    SELECT 
        DP.iddetalle_presentacion, 
        CLI.ndocumento,
        DP.ncotizacion,
        USU.nom_usuario, 
        USU.idusuario,
        USU.color,
        CLI.razonsocial, 
        DP.tipo_evento, 
        DP.modalidad, 
        DP.fecha_presentacion, 
        DP.horainicio, DP.horafinal,
        CO.idcontrato, 
        CON.idconvenio,
        DP.validez,
        DP.reserva,
        DP.pagado50,
        DP.establecimiento,
        DP.referencia,
        CO.estado AS estadoContrato,
        DP.created_at,
        DP.acuerdo,
        DP.estado,
        AGE.idagendaedicion,
        (SELECT RE.vigencia 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS vigencia_reserva,
        (SELECT RE.fechacreada 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS fechacreada_reserva,
        DP.estado,
        CON.estado AS estado_convenio,
        DISDP.distrito, 
        PRODP.provincia, 
        DEDP.departamento,
        DEDP.iddepartamento
	FROM agenda_edicion AGE 
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGE.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_agenda_edicion_por_editor_y_general` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_agenda_edicion_por_editor_y_general` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_agenda_edicion_por_editor_y_general`(
	IN _idusuario INT
)
BEGIN
    SELECT 
        DP.iddetalle_presentacion, 
        CLI.ndocumento,
        DP.ncotizacion,
        USU.nom_usuario, 
        USU.idusuario,
        USU.color,
        CLI.razonsocial, 
        DP.tipo_evento, 
        DP.modalidad, 
        DP.fecha_presentacion, 
        DP.horainicio, DP.horafinal,
        CO.idcontrato, 
        CON.idconvenio,
        DP.validez,
        DP.reserva,
        DP.pagado50,
        DP.establecimiento,
        DP.referencia,
        CO.estado AS estadoContrato,
        DP.created_at,
        DP.acuerdo,
        DP.estado,
        ASIG.idusuario as idusuarioAgenda,
        ASIG.iddetalle_presentacion as idpagenda,
        NIVEL.idnivelacceso, NIVEL.nivelacceso,
        AGEDIT.tipotarea,
        PERAGE.nombres,
        (SELECT RE.vigencia 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS vigencia_reserva,
        (SELECT RE.fechacreada 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS fechacreada_reserva,
        DP.estado,
        CON.estado AS estado_convenio,
        DISDP.distrito, 
        PRODP.provincia, 
        DEDP.departamento,
        DEDP.iddepartamento
	FROM agenda_editores AGEDIT
	LEFT JOIN agenda_edicion AGE on AGE.idagendaedicion = AGEDIT.idagendaedicion 
    LEFT JOIN usuarios USUAGE ON USUAGE.idusuario = AGEDIT.idusuario
    LEFT JOIN personas PERAGE ON PERAGE.idpersona = USUAGE.idpersona
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGE.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN agenda_asignaciones ASIG ON ASIG.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN usuarios USUASIG ON USUASIG.idusuario = ASIG.idusuario
	LEFT JOIN nivelaccesos NIVEL ON NIVEL.idnivelacceso IN (USU.idnivelacceso, USUASIG.idnivelacceso)
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
	    WHERE 
        (_idusuario IS NULL OR AGEDIT.idusuario = _idusuario OR USU.idusuario = _idusuario);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_agenda_editores` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_agenda_editores` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_agenda_editores`(
    IN _idagendaedicion INT
)
BEGIN
	SELECT 
	AGE.idagendaeditor, TIPO.idtipotarea, TIPO.tipotarea, PER.nombres, USU.idusuario, AGE.fecha_entrega, AGE.hora_entrega, AGE.estado, AGE.altoketicket
    FROM agenda_editores AGE
    LEFT JOIN tipotarea TIPO ON TIPO.idtipotarea = AGE.idtipotarea
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.idagendaedicion = _idagendaedicion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_agenda_filmmakers` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_agenda_filmmakers` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_agenda_filmmakers`(
    IN _idusuario INT, 
    IN _iddetalle_presentacion INT,
    IN _idnivelacceso INT
)
BEGIN
    SELECT 
        DP.iddetalle_presentacion, 
        CLI.ndocumento,
        DP.ncotizacion,
        USU.nom_usuario, 
        USU.idusuario,
        USU.color,
        CLI.razonsocial, 
        DP.tipo_evento, 
        DP.modalidad, 
        DP.fecha_presentacion, 
        DP.horainicio, 
        DP.horafinal,
        CO.idcontrato, 
        CON.idconvenio,
        DP.validez,
        DP.reserva,
        DP.pagado50,
        DP.establecimiento,
        DP.referencia,
        CO.estado AS estadoContrato,
        DP.created_at,
        DP.acuerdo,
        DP.estado,
        -- ? Filmmaker individual por fila
        PERASIG.nombres AS filmmaker,
        ASIG.idusuario AS idusuarioAgenda,
        NIVEL.idnivelacceso, 
        NIVEL.nivelacceso,
        (SELECT RE.vigencia 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS vigencia_reserva,
        (SELECT RE.fechacreada 
         FROM reservas RE 
         WHERE RE.idpagocontrato = (SELECT PC.idpagocontrato 
                                    FROM pagos_contrato PC 
                                    WHERE PC.idcontrato = CO.idcontrato 
                                    ORDER BY PC.fecha_pago DESC LIMIT 1) 
         ORDER BY RE.fechacreada DESC LIMIT 1) AS fechacreada_reserva,
        CON.estado AS estado_convenio,
        DISDP.distrito, 
        PRODP.provincia, 
        DEDP.departamento,
        DEDP.iddepartamento
    FROM detalles_presentacion DP
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN agenda_asignaciones ASIG ON ASIG.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN usuarios USUASIG ON USUASIG.idusuario = ASIG.idusuario
    LEFT JOIN personas PERASIG ON PERASIG.idpersona = USUASIG.idpersona
    LEFT JOIN nivelaccesos NIVEL ON NIVEL.idnivelacceso = USUASIG.idnivelacceso
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    WHERE 
        (_idusuario IS NULL OR ASIG.idusuario = _idusuario OR USU.idusuario = _idusuario) AND
        (_iddetalle_presentacion IS NULL OR DP.iddetalle_presentacion = _iddetalle_presentacion) AND
        (_idnivelacceso IS NULL OR NIVEL.idnivelacceso = _idnivelacceso);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_comprobante_por_tipodoc` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_comprobante_por_tipodoc` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_comprobante_por_tipodoc`(
    IN _idcomprobante INT,
    IN _idtipodoc	CHAR(2)
)
BEGIN
	SELECT 
    COMP.iddetallepresentacion,
		COMP.idcomprobante,
        COMP.monto,
		COMP.idcomprobante,
        COMP.nserie,
        COMP.correlativo,
        CLI.razonsocial,
        COMP.fechaemision,
        COMP.horaemision,
        COMP.tipomoneda,
        COMP.tipopago,
        COMP.noperacion,
        CLI.ndocumento,
        CLI.direccion,
        DIS.distrito,
        PRO.provincia,
        DEP.departamento,
        COMP.tieneigv,
		SUC.telefono as telefono_sucursal
    FROM comprobantes COMP
	LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
    LEFT JOIN sucursales SUC ON SUC.idsucursal = COMP.idsucursal
	LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE COMP.idcomprobante = _idcomprobante
    AND COMP.idtipodoc = _idtipodoc;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_contenido_historial_edicion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_contenido_historial_edicion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_contenido_historial_edicion`(
    IN _idagendaeditor INT
)
BEGIN
	SELECT 
	*
    FROM subidas_agenda_edicion SUBI
    LEFT JOIN agenda_editores AGE ON AGE.idagendaeditor = SUBI.idagendaeditor
    WHERE SUBI.idagendaeditor = _idagendaeditor;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_cuotas` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_cuotas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_cuotas`(
    IN _fecha DATE,
    IN _numero_comprobante VARCHAR(20),
    IN _idcliente INT
)
BEGIN
    SELECT 
        CCMP.idcuotacomprobante, 
        CLI.idcliente,
        CLI.razonsocial,
        CLI.ndocumento,
        CCMP.idcomprobante, 
        COMP.nserie, 
        COMP.correlativo, 
        CONCAT(COMP.nserie, '-', COMP.correlativo) AS numero_comprobante,
        CCMP.fecha, 
        CCMP.monto AS monto_a_pagar, 
        CCMP.estado,
        IFNULL(SUM(PC.montopagado), 0) AS total_pagado
    FROM cuotas_comprobante CCMP
    LEFT JOIN comprobantes COMP ON COMP.idcomprobante = CCMP.idcomprobante
    LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
    LEFT JOIN pagos_cuota PC ON PC.idcuotacomprobante = CCMP.idcuotacomprobante
    WHERE 
        (_fecha IS NULL OR CCMP.fecha = _fecha OR CCMP.fecha IS NULL)
        AND (_numero_comprobante IS NULL 
             OR CONCAT(COMP.nserie, '-', COMP.correlativo) LIKE CONCAT('%', COALESCE(_numero_comprobante, ''), '%'))
        AND (_idcliente IS NULL OR COMP.idcliente = _idcliente OR COMP.idcliente IS NULL)
    GROUP BY CCMP.idcuotacomprobante;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_detalles_evento` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_detalles_evento` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_detalles_evento`(
    IN _ncotizacion CHAR(9),
    IN _ndocumento CHAR(9),
    IN _nom_usuario CHAR(30),
    IN _establecimiento VARCHAR(80),
    IN _fecha_presentacion DATE
)
BEGIN
    SELECT 
        DP.iddetalle_presentacion, 
        CLI.ndocumento,
        DP.ncotizacion,
        USU.idusuario,
        USU.nom_usuario, 
        CLI.razonsocial, 
        DP.tipo_evento, 
        DP.modalidad, 
        DP.fecha_presentacion, 
        DP.establecimiento,
        CO.idcontrato, 
        DP.validez,
        DP.reserva,
        DP.pagado50,
        DP.created_at,
        RE.vigencia as vigencia_reserva,
        RE.fechacreada as fechacreada_reserva,
        CO.idcontrato,
		DP.estado,
        CON.estado as estado_convenio,
        CO.estado as estado_contrato,
        DP.tienecaja,
        DEDP.departamento, PRODP.provincia, DISDP.distrito,
        NAC.pais,
        NAC.idnacionalidad,
        DP.esExtranjero
    FROM detalles_presentacion DP
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN pagos_contrato PC ON PC.idcontrato = CO.idcontrato
    LEFT JOIN reservas RE ON RE.idpagocontrato = PC.idpagocontrato
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = DP.idnacionalidad
    WHERE 
    (DP.ncotizacion IS NULL OR DP.ncotizacion LIKE CONCAT('%', COALESCE(_ncotizacion, ''), '%'))
    AND (CLI.ndocumento LIKE CONCAT('%', COALESCE(_ndocumento, ''), '%') OR _ndocumento IS NULL)
    AND (USU.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%') OR _nom_usuario IS NULL)
    AND (DP.establecimiento LIKE CONCAT('%', COALESCE(_establecimiento, ''), '%') OR _establecimiento IS NULL)
    AND (DP.fecha_presentacion LIKE CONCAT('%', COALESCE(_fecha_presentacion, ''), '%') OR _fecha_presentacion IS NULL)
    GROUP BY DP.iddetalle_presentacion, CO.idcontrato
    ORDER BY iddetalle_presentacion DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_dps` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_dps` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_dps`(
)
BEGIN
	SELECT 		
		DP.iddetalle_presentacion, DE.departamento, PRO.provincia, DIS.distrito, PRO.idprovincia, USU.idusuario, USU.idusuario, USU.nom_usuario
	FROM detalles_presentacion DP
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
    WHERE DP.iddetalle_presentacion = _iddetalle_presentacion; -- me quede aca
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_dp_porid` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_dp_porid` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_dp_porid`(
	IN _iddetalle_presentacion	INT
)
BEGIN
	SELECT 		
		DP.iddetalle_presentacion, USU.nom_usuario,DE.departamento, PRO.provincia, DIS.distrito, PRO.idprovincia, USU.idusuario, CLI.idcliente, DP.igv, DP.reserva, DP.pagado50, DP.establecimiento, DP.fecha_presentacion, DP.horainicio, DP.horafinal, DP.tipo_evento, DP.idnacionalidad
	FROM detalles_presentacion DP
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
    WHERE DP.iddetalle_presentacion = _iddetalle_presentacion; -- me quede aca
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_dp_por_fecha` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_dp_por_fecha` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_dp_por_fecha`(
	IN _idusuario	INT,
	IN _fecha_presentacion	DATE
)
BEGIN
	SELECT *
    FROM
    detalles_presentacion 
    WHERE fecha_presentacion = _fecha_presentacion AND idusuario = _idusuario; -- me quede aca
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_empresa` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_empresa` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_empresa`(
)
BEGIN
    SELECT 
	*
    FROM empresa EMP
    LEFT JOIN distritos DIS ON DIS.iddistrito = EMP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_facturas` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_facturas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_facturas`(
     IN _fechaemision DATE,
     IN _horaemision TIME,
     IN _numero_comprobante VARCHAR(20) -- Por ejemplo: 'F001-00000001'
 )
BEGIN
 	SELECT 
		DP.iddetalle_presentacion,
         COMP.idcomprobante,
         COMP.idsucursal,
         COMP.idcliente,
         COMP.idtipodoc,
         COMP.fechaemision,
         COMP.horaemision,
         COMP.nserie,
         COMP.correlativo,
         COMP.tipomoneda,
         COMP.monto,
         CONCAT(COMP.nserie, '-', COMP.correlativo) AS numero_comprobante,
         SUM(ITEM.valortotal) AS total_valortotal,
         CLI.razonsocial,
         CLI.ndocumento
     FROM comprobantes COMP
     LEFT JOIN items_comprobante ITEM ON ITEM.idcomprobante = COMP.idcomprobante
     LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
     LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = iddetallepresentacion
     WHERE CONCAT(COMP.nserie, '-', COMP.correlativo) LIKE CONCAT('%', COALESCE(_numero_comprobante, ''), '%')
     AND (_fechaemision IS NULL OR COMP.fechaemision = _fechaemision OR COMP.fechaemision IS NULL)
     AND (_horaemision IS NULL OR COMP.horaemision = _horaemision OR COMP.horaemision IS NULL)
      GROUP BY 
         COMP.idcomprobante,
         COMP.idsucursal,
         COMP.idcliente,
         COMP.idtipodoc,
         COMP.fechaemision,
         COMP.horaemision,
         COMP.nserie,
         COMP.correlativo,
         COMP.tipomoneda,
         COMP.monto;
 END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_filmmakers_dp` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_filmmakers_dp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_filmmakers_dp`(
	IN _iddetalle_presentacion	INT
)
BEGIN
	SELECT *
    FROM
     agenda_asignaciones AGEN 
    LEFT JOIN detalles_presentacion  DP ON AGEN.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = AGEN.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona 
    WHERE DP.iddetalle_presentacion = _iddetalle_presentacion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_filmmaker_asignado` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_filmmaker_asignado` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_filmmaker_asignado`(
    IN _iddetalle_presentacion INT
)
BEGIN
	SELECT 
		AGE.idasignacion, AGE.iddetalle_presentacion, AGE.idusuario, PER.nombres, PER.apellidos
    FROM agenda_asignaciones AGE
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.iddetalle_presentacion = _iddetalle_presentacion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_filmmaker_asociado_evento` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_filmmaker_asociado_evento` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_filmmaker_asociado_evento`(
	IN _idusuario	INT
)
BEGIN
	SELECT 		
		DP.iddetalle_presentacion, AGEN.idusuario 
	FROM detalles_presentacion DP
    LEFT JOIN agenda_asignaciones AGEN ON AGEN.iddetalle_presentacion = DP.iddetalle_presentacion
	WHERE AGEN.idusuario = _idusuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_info_viatico` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_info_viatico` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_info_viatico`(
	IN _iddetallepresentacion INT,
    IN _idusuario INT
)
BEGIN
	SELECT 
		VIA.idviatico,
        VIA.pasaje, VIA.hospedaje, VIA.desayuno, VIA.almuerzo, VIA.cena,
        USU.nom_usuario,
        DP.fecha_presentacion, DP.horainicio, DP.horafinal, DP.establecimiento,
        DE.departamento, PRO.provincia, DIS.distrito,
        DE.iddepartamento
    FROM viaticos VIA
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = VIA.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
    WHERE
    (_iddetallepresentacion IS NULL OR VIA.iddetalle_presentacion = _iddetallepresentacion) AND
    (_idusuario IS NULL OR VIA.idusuario = _idusuario);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_info_viatico_notificacion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_info_viatico_notificacion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_info_viatico_notificacion`(
	IN _idusuario INT,
    IN _idviatico INT
)
BEGIN
	SELECT 
		VIA.idviatico,
        VIA.pasaje, VIA.hospedaje, VIA.desayuno, VIA.almuerzo, VIA.cena,
        USU.nom_usuario,
        DP.fecha_presentacion, DP.horainicio, DP.horafinal, DP.establecimiento,
        DE.departamento, PRO.provincia, DIS.distrito,
        DE.iddepartamento
    FROM viaticos VIA
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = VIA.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
    WHERE
    (_idusuario IS NULL OR VIA.idusuario = _idusuario) AND
    (_idviatico IS NULL OR VIA.idviatico = _idviatico);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_notas_de_venta` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_notas_de_venta` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_notas_de_venta`(
     IN _fechaemision DATE,
     IN _horaemision TIME,
     IN _numero_comprobante VARCHAR(20) -- Por ejemplo: 'F001-00000001'
 )
BEGIN
 	SELECT 
		DP.iddetalle_presentacion,
         COMP.idcomprobante,
         COMP.idsucursal,
         COMP.idcliente,
         COMP.idtipodoc,
         COMP.fechaemision,
         COMP.horaemision,
         COMP.nserie,
         COMP.correlativo,
         COMP.tipomoneda,
         COMP.monto,
         CONCAT(COMP.nserie, '-', COMP.correlativo) AS numero_comprobante,
         SUM(ITEM.valortotal) AS total_valortotal,
         CLI.razonsocial,
         CLI.ndocumento
     FROM comprobantes COMP
     LEFT JOIN items_comprobante ITEM ON ITEM.idcomprobante = COMP.idcomprobante
     LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
     LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = iddetallepresentacion
     WHERE CONCAT(COMP.nserie, '-', COMP.correlativo) LIKE CONCAT('%', COALESCE(_numero_comprobante, ''), '%')
     AND (_fechaemision IS NULL OR COMP.fechaemision = _fechaemision OR COMP.fechaemision IS NULL)
     AND (_horaemision IS NULL OR COMP.horaemision = _horaemision OR COMP.horaemision IS NULL)
     AND COMP.idtipodoc = '02'
      GROUP BY 
         COMP.idcomprobante,
         COMP.idsucursal,
         COMP.idcliente,
         COMP.idtipodoc,
         COMP.fechaemision,
         COMP.horaemision,
         COMP.nserie,
         COMP.correlativo,
         COMP.tipomoneda,
         COMP.monto;
 END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_notificaciones` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_notificaciones` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_notificaciones`(
	IN _iddepartamento INT,
    IN _idusuario INT
)
BEGIN
	SELECT 
		*
    FROM notificaciones NOTIF
    WHERE NOTIF.idusuario = _idusuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_notificaciones_por_nivel` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_notificaciones_por_nivel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_notificaciones_por_nivel`(
	IN _idnivelacceso INT,
    IN _idusuario INT
)
BEGIN
	SELECT 
		NOTIF.idnotificacion, NOTIF.idreferencia, NOTIF.mensaje
    FROM notificaciones NOTIF
    LEFT JOIN usuarios USU ON USU.idusuario = NOTIF.idusuariodest
    LEFT JOIN nivelaccesos NIVEL ON NIVEL.idnivelacceso = USU.idnivelacceso
    WHERE USU.idnivelacceso = _idnivelacceso AND USU.idusuario = _idusuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_notificacion_dp` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_notificacion_dp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_notificacion_dp`(
    IN _idreferencia INT
)
BEGIN
	SELECT 
		NOTIF.idnotificacion, RAE.tipo, RAE.fecha, RAE.hora, DP.iddetalle_presentacion, DP.fecha_presentacion, USU.nom_usuario, DP.horainicio, DP.horafinal, DP.establecimiento, DP.modalidad, DP.tipo_evento, DIS.distrito, PRO.provincia, DEP.departamento
    FROM notificaciones NOTIF
    LEFT JOIN reportes_artista_evento RAE ON RAE.idreporte = NOTIF.idreferencia
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = RAE.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE NOTIF.idreferencia = _idreferencia AND NOTIF.tipo = 2;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_notificacion_propuesta` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_notificacion_propuesta` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_notificacion_propuesta`(
    IN _idreferencia INT
)
BEGIN
	SELECT 
	    NOTIF.idnotificacion, CLI.razonsocial, CLI.telefono,DP.iddetalle_presentacion, USU.nom_usuario, DP.establecimiento, DP.fecha_presentacion, DP.horainicio, DP.horafinal, DIS.distrito, PRO.provincia, DEP.departamento, CON.idconvenio,CON.abono_garantia, CON.abono_publicidad, CON.porcentaje_vega, CON.porcentaje_promotor, CON.propuesta_cliente, CON.estado,NOTIF.fecha
    FROM notificaciones NOTIF
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = NOTIF.idreferencia
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = CON.iddetalle_presentacion
	LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE NOTIF.idreferencia = _idreferencia AND NOTIF.tipo = 4;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_pagos_contrato` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_pagos_contrato` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_pagos_contrato`(
    IN _idcliente INT
)
BEGIN
    SELECT 		
		PC.idpagocontrato, 
        DP.establecimiento, 
        USU.nom_usuario, 
        DP.fecha_presentacion, 
        DEDP.departamento, 
        PRODP.provincia, 
        DISDP.distrito, 
        CLI.idcliente,
        CLI.razonsocial, 
        CLI.ndocumento, 
        PC.monto, 
        PC.tipo_pago, 
        PC.noperacion, 
        PC.fecha_pago, 
        PC.hora_pago
    FROM pagos_contrato PC
    LEFT JOIN contratos CON ON CON.idcontrato = PC.idcontrato
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = CON.iddetalle_presentacion
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN distritos DISCLI ON DISCLI.iddistrito = CLI.iddistrito
    LEFT JOIN provincias PROCLI ON PROCLI.idprovincia = DISCLI.idprovincia
    LEFT JOIN departamentos DECLI ON DECLI.iddepartamento = PROCLI.iddepartamento
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	WHERE CLI.idcliente LIKE CONCAT('%', COALESCE(_idcliente, ''), '%');
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_permisos` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_permisos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_permisos`(IN p_idnivelacceso INT)
BEGIN
    SELECT 
        modulo, ruta, texto, visibilidad, icono
    FROM permisos
    WHERE idnivelacceso = p_idnivelacceso;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_representante` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_representante` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_representante`(
	IN _idsucursal INT
)
BEGIN
    SELECT 
	SUC.idsucursal, DEP.departamento, PRO.provincia, DIS.distrito, SUC.nombre, SUC.ruc, SUC.telefono, SUC.direccion, PER.nombres, PER.apellidos, USU.firma, PER.num_doc 
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    LEFT JOIN usuarios USU ON USU.idusuario = SUC.idresponsable
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE SUC.idsucursal = _idsucursal;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_reserva_por_pagocontrato` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_reserva_por_pagocontrato` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_reserva_por_pagocontrato`(
	IN _idpagocontrato INT
)
BEGIN
	SELECT 
	R.idreserva, PC.monto, R.vigencia, R.fechacreada
    FROM reservas R
    LEFT JOIN pagos_contrato PC ON PC.idpagocontrato = R.idpagocontrato
    WHERE PC.idpagocontrato = _idpagocontrato;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_sucursales_por_empresa` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_sucursales_por_empresa` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_sucursales_por_empresa`(
	IN _idempresa INT
)
BEGIN
    SELECT 
    SUC.idsucursal, SUC.nombre ,DIS.distrito, PRO.provincia, DEP.departamento
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE SUC.idempresa = _idempresa;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_tareas_diarias_por_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_tareas_diarias_por_usuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_tareas_diarias_por_usuario`(
    IN _idusuario INT
)
BEGIN
	SELECT 
		TDA.idtaradiariaasig, PER.nombres, PER.apellidos, TDA.fecha_entrega, TDA.hora_entrega, TDA.estado, TD.tarea, TD.idtareadiaria
    FROM tareas_diaria_asignacion TDA
    LEFT JOIN tareas_diarias TD ON TD.idtareadiaria  = TDA.idtareadiaria
    LEFT JOIN usuarios USU ON USU.idusuario = TDA.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE TDA.idusuario = _idusuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_tareas_editor` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_tareas_editor` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_tareas_editor`(
    IN _idusuario INT
)
BEGIN	
	SELECT 
		AGED.idagendaeditor, AGEN.idagendaedicion, AGED.idusuario as idusuarioEdicion, AGED.fecha_asignacion, DP.fecha_presentacion, DP.horainicio, DP.horafinal, DP.establecimiento, DP.estado, USU.nom_usuario, USUDP.color
		FROM agenda_editores AGED
		LEFT JOIN agenda_edicion AGEN ON AGEN.idagendaedicion = AGED.idagendaedicion
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGEN.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_idusuario IS NULL OR AGED.idusuario = _idusuario OR AGED.idusuario IS NULL);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_tareas_para_publicar` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_tareas_para_publicar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_tareas_para_publicar`(
    IN _establecimiento varchar(80),
    IN _fecha_presentacion DATE,
    IN _idusuario	INT,
    IN _idusuarioEditor int
    )
BEGIN
	SELECT 
		AGENC.idagendacommanager, AGENC.fechapublicacion ,AGENE.estado as estadoProgreso, DEP.establecimiento, DEP.fecha_presentacion, USU.idusuario, USU.nom_usuario, AGENC.idusuarioCmanager, PERAGEN.nombres, TIPO.tipotarea, AGENC.copy, AGENC.portalpublicar, AGENC.estado, AGENC.idusuarioCmanager 
    FROM agenda_commanager  AGENC
    LEFT JOIN agenda_editores AGENE ON AGENE.idagendaeditor = AGENC.idagendaeditor
    LEFT JOIN agenda_edicion AGENED ON AGENED.idagendaedicion = AGENE.idagendaedicion
    LEFT JOIN detalles_presentacion DEP ON DEP.iddetalle_presentacion = AGENED.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DEP.idusuario
    LEFT JOIN usuarios USUAGEN ON USUAGEN.idusuario = AGENE.idusuario
    LEFT JOIN personas PERAGEN ON PERAGEN.idpersona = USUAGEN.idpersona
    LEFT JOIN tipotarea TIPO ON TIPO.idtipotarea = AGENE.idtipotarea
    WHERE 
    (DEP.establecimiento IS NULL OR DEP.establecimiento LIKE CONCAT('%', COALESCE(_establecimiento, ''), '%'))
    AND (DEP.fecha_presentacion LIKE CONCAT('%', COALESCE(_fecha_presentacion, ''), '%') OR _fecha_presentacion IS NULL)
    AND (DEP.idusuario LIKE CONCAT('%', COALESCE(_idusuario, ''), '%') OR _idusuario IS NULL)
    AND (AGENC.idusuarioCmanager LIKE CONCAT('%', COALESCE(_idusuarioEditor, ''), '%') OR _idusuarioEditor IS NULL) AND
    AGENE.estado = 2 OR AGENE.estado = 4;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_tarea_vinculada_cmanager` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_tarea_vinculada_cmanager` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_tarea_vinculada_cmanager`(
    IN _idagendaeditor int
    )
BEGIN
	SELECT 
	AGENC.estado, AGENC.idagendacommanager, AGENC.idagendaeditor
	FROM agenda_commanager  AGENC
    LEFT JOIN agenda_editores AGENE ON AGENE.idagendaeditor = AGENC.idagendaeditor
    WHERE AGENC.idagendaeditor = _idagendaeditor;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_tarifario_artista_pais` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_tarifario_artista_pais` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_tarifario_artista_pais`(
    IN _idusuario INT,
    IN _idnacionalidad INT,
	IN _tipo_evento INT
)
BEGIN
	SELECT 
	T.idtarifario, T.precio, T.tipo_evento, NAC.idnacionalidad, NAC.pais, T.precioExtranjero
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE USU.idusuario = _idusuario AND NAC.idnacionalidad = _idnacionalidad AND T.tipo_evento = _tipo_evento;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_tarifario_por_provincia` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_tarifario_por_provincia` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_tarifario_por_provincia`(
	IN _iddepartamento INT,
    IN _idusuario INT,
    IN _tipo_evento INT
)
BEGIN
	SELECT 
	T.idtarifario, T.precio, T.tipo_evento, NAC.idnacionalidad, NAC.pais,PR.idprovincia, D.iddepartamento, USU.idusuario
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE PR.iddepartamento = _iddepartamento AND USU.idusuario = _idusuario AND T.tipo_evento = _tipo_evento;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_usuarios` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_usuarios` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_usuarios`(
	IN _nivelacceso VARCHAR(30),
	IN _num_doc	VARCHAR(20),
	IN _nombres VARCHAR(100),
    IN _apellidos VARCHAR(100),
    IN _telefono CHAR(15),
    IN _nom_usuario VARCHAR(30),
    IN _idsucursal INT
)
BEGIN
	SELECT
		US.idusuario, NA.nivelacceso, PE.num_doc, PE.nombres, PE.apellidos, US.nom_usuario, PE.telefono, US.estado
	FROM usuarios US
	left JOIN personas PE ON PE.idpersona = US.idpersona
    left JOIN nivelaccesos NA ON NA.idnivelacceso = US.idnivelacceso
	WHERE (NA.nivelacceso LIKE CONCAT('%', COALESCE(_nivelacceso, ''), '%') OR NA.nivelacceso IS NULL)
  AND (PE.num_doc LIKE CONCAT('%', COALESCE(_num_doc, ''), '%') OR PE.num_doc IS NULL)
  AND (PE.nombres LIKE CONCAT('%', COALESCE(_nombres, ''), '%') OR PE.nombres IS NULL)
  AND (PE.apellidos LIKE CONCAT('%', COALESCE(_apellidos, ''), '%') OR PE.apellidos IS NULL)
  AND (PE.telefono LIKE CONCAT('%', COALESCE(_telefono, ''), '%') OR PE.telefono IS NULL)
  AND (US.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%') OR US.nom_usuario IS NULL)
  AND (US.idsucursal LIKE CONCAT('%', COALESCE(_idsucursal, ''), '%') OR US.idsucursal IS NULL);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_usuario_asignado_tarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_usuario_asignado_tarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_usuario_asignado_tarea`(
    IN _idusuario INT,
    IN _idagendaedicion INT
)
BEGIN
	SELECT 
	AGE.idagendaedicion, AGE.idagendaeditor, AGE.idtipotarea, PER.nombres, USU.idusuario, AGE.fecha_entrega, AGE.estado
    FROM agenda_editores AGE
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.idusuario = _idusuario AND AGE.idagendaedicion = _idagendaedicion;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_usuario_por_id` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_usuario_por_id` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_usuario_por_id`(
	IN _idusuario INT
)
BEGIN
	SELECT
		P.apellidos,P.nombres AS dato, P.num_doc, P.genero, P.telefono, P.idpersona, P.direccion, P.correo, U.porcentaje,
        U.idusuario,U.nom_usuario, U.estado,
        NA.nivelacceso
		FROM usuarios U
        INNER JOIN nivelaccesos NA ON U.idnivelacceso = NA.idnivelacceso
        INNER JOIN personas P ON U.idpersona = P.idpersona
        WHERE idusuario = _idusuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_obtener_usuario_por_nivel` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_obtener_usuario_por_nivel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_usuario_por_nivel`(
	IN _idnivelacceso INT
)
BEGIN
	SELECT
		US.idusuario,
        US.nom_usuario,
        US.estado,
        NA.nivelacceso,
        NA.idnivelacceso,
        PER.nombres
		FROM usuarios US
        INNER JOIN nivelaccesos NA ON US.idnivelacceso = NA.idnivelacceso
        LEFT JOIN personas PER ON PER.idpersona = US.idpersona
        WHERE NA.idnivelacceso = _idnivelacceso;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_quitar_responsable_posteo` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_quitar_responsable_posteo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quitar_responsable_posteo`(
    IN _idagendaeditor INT
)
BEGIN	
	DELETE FROM agenda_commanager WHERE idagendaeditor = _idagendaeditor;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_quitar_tarea_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_quitar_tarea_usuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quitar_tarea_usuario`(
    IN _idagendaeditor INT
)
BEGIN	
	DELETE FROM agenda_editores WHERE idagendaeditor = _idagendaeditor;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_cajachica` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_cajachica` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_cajachica`(
    OUT _idcajachica INT,
    IN _iddetalle_presentacion INT,
    IN _idmonto INT,
    IN _ccinicial DOUBLE(10,2),
    IN _incremento DOUBLE(10,2),
    IN _decremento DOUBLE(10,2),
    IN _ccfinal DOUBLE(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    -- Insertar nueva caja chica
    INSERT INTO cajachica (iddetalle_presentacion, idmonto ,ccinicial, incremento, decremento ,ccfinal, estado, fecha_cierre, fecha_apertura)
    VALUES (nullif(_iddetalle_presentacion, ''), _idmonto ,_ccinicial, _incremento, _decremento, _ccfinal, 1, NULL, NOW());
    -- Obtener el ID generado
    IF existe_error = 1 THEN
        SET _idcajachica = -1;
    ELSE
        SET _idcajachica = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_cliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_cliente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_cliente`(
    OUT _idcliente INT,
    IN _tipodoc	INT,
	IN _iddistrito INT,
    IN _ndocumento CHAR(20),
    IN _razonsocial VARCHAR(130),
    IN _representantelegal VARCHAR(130),
    IN _telefono char(15),
    IN _correo VARCHAR(130),
    IN _direccion VARCHAR(130)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO clientes (tipodoc, iddistrito, ndocumento, razonsocial, representantelegal, telefono, correo, direccion)
    VALUES (NULLIF(_tipodoc, '') , NULLIF(_iddistrito, '') , NULLIF(_ndocumento, ''), NULLIF(_razonsocial, ''), NULLIF(_representantelegal, ''), NULLIF(_telefono, ''), NULLIF(_correo, ''), NULLIF(_direccion, ''));
    
    IF existe_error = 1 THEN
        SET _idcliente = -1;
    ELSE
        SET _idcliente = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_comprobante` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_comprobante` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_comprobante`(
    OUT _idcomprobante	INT ,
    IN _iddetallepresentacion INT,
    IN _idsucursal int,
    IN _idcliente INT, 
    IN _idtipodoc char(2),
	IN _tipopago  INT,
    IN _nserie char(4),
    IN _correlativo char(8),
    IN _tipomoneda varchar(40),
    IN _monto 	decimal(10,2),
    IN _tieneigv	tinyint,
    IN _noperacion varchar(15)
)
BEGIN
	    DECLARE existe_error INT DEFAULT 0;
    
    -- Insertar la notificación
    INSERT INTO comprobantes (iddetallepresentacion, idsucursal, idcliente, idtipodoc, tipopago, nserie, correlativo, tipomoneda , monto, tieneigv, noperacion)
    VALUES (_iddetallepresentacion, _idsucursal, _idcliente, _idtipodoc, _tipopago, _nserie, _correlativo, _tipomoneda, _monto, _tieneigv, nullif(_noperacion,''));

    IF existe_error = 1 THEN
        SET _idcomprobante = -1;
    ELSE
        SET _idcomprobante = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_contrato` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_contrato` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_contrato`(
    OUT _idcontrato INT,
	IN _iddetalle_presentacion INT,
    IN _estado int
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO contratos (iddetalle_presentacion, estado)
    VALUES (_iddetalle_presentacion, _estado);
    
    IF existe_error = 1 THEN
        SET _idcontrato = -1;
    ELSE
        SET _idcontrato = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_convenio` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_convenio` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_convenio`(
    OUT _idconvenio INT,
	IN _iddetalle_presentacion INT,
    IN _abono_garantia DOUBLE,
    IN _abono_publicidad DOUBLE,
    IN _porcentaje_vega int,
    IN _porcentaje_promotor int,
    IN _propuesta_cliente text,
    IN _estado int
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO convenios (iddetalle_presentacion, abono_garantia, abono_publicidad, porcentaje_vega, porcentaje_promotor, propuesta_cliente, estado)
    VALUES (_iddetalle_presentacion, _abono_garantia, _abono_publicidad, _porcentaje_vega, _porcentaje_promotor, _propuesta_cliente, _estado);
    
    IF existe_error = 1 THEN
        SET _idconvenio = -1;
    ELSE
        SET _idconvenio = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_cuota_factura` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_cuota_factura` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_cuota_factura`(
	IN _idcomprobante INT,
    IN _fecha	date ,
    IN _monto decimal(10,2)
)
BEGIN
    INSERT INTO cuotas_comprobante (idcomprobante, fecha, monto)
    VALUES (_idcomprobante, _fecha, _monto);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_detalle_comprobante` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_detalle_comprobante` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_detalle_comprobante`(
	IN _idcomprobante INT,
    IN _estado	varchar(10),
    IN _info varchar(60)
)
BEGIN
    INSERT INTO detalles_comprobante (idcomprobante, estado, info)
    VALUES (_idcomprobante, _estado, _info);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_detalle_presentacion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_detalle_presentacion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_detalle_presentacion`(
    OUT _iddetalle_presentacion INT,
	IN _idusuario int,
    IN _idcliente int,
	IN _iddistrito int,
    IN _ncotizacion	char(9),
    IN _fechapresentacion date,
    IN _horainicio time,
    IN _horafinal time,
    IN _establecimiento VARCHAR(80),
    IN _referencia VARCHAR(200),
    IN _acuerdo TEXT,
    IN _tipoevento int,
	IN _modotransporte	int,
    IN _modalidad int,
    IN _validez int,
    IN _igv tinyint,
    IN _esExtranjero TINYINT,
	IN _idnacionalidad INT
)
BEGIN
    -- Si _horainicio es NULL, asignamos '00:00:01'
    IF _horainicio IS NULL THEN 
        SET _horainicio = '00:00:01'; 
    END IF;
    -- Si _horafinal es NULL, asignamos '00:00:01'
    IF _horafinal IS NULL THEN 
        SET _horafinal = '00:00:01'; 
    END IF;
    INSERT INTO detalles_presentacion (
        idusuario, idcliente, iddistrito, ncotizacion, 
        fecha_presentacion, horainicio, horafinal, establecimiento, 
        referencia, acuerdo, tipo_evento, modotransporte,modalidad, validez, igv, esExtranjero, idnacionalidad
    ) VALUES (
        _idusuario, _idcliente, NULLIF(_iddistrito, ''), NULLIF(_ncotizacion, ''), 
        _fechapresentacion, _horainicio, _horafinal, NULLIF(_establecimiento, ''), 
        NULLIF(_referencia, ''), NULLIF(_acuerdo, ''), nullif(_tipoevento,''), nullif(_modotransporte,''), nullif(_modalidad,''), _validez, _igv, _esExtranjero, nullif(_idnacionalidad,'')
    );
    SET _iddetalle_presentacion = LAST_INSERT_ID();
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_egresos` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_egresos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_egresos`(
    OUT _idegreso INT,
    IN _idreparticion INT,
    IN _descripcion varchar(80),
    IN _monto  DECIMAL(10,2),
    IN _tipopago tinyint,
    IN _noperacion varchar(15)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    -- Insertar nueva caja chica
    INSERT INTO egresos_evento (idreparticion, descripcion ,monto, tipopago, noperacion)
    VALUES (_idreparticion, _descripcion, _monto, _tipopago, nullif(_noperacion, ''));
    -- Obtener el ID generado
    IF existe_error = 1 THEN
        SET _idegreso = -1;
    ELSE
        SET _idegreso = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_gasto` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_gasto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_gasto`(
    OUT _idgasto INT,
    IN _idcajachica INT,
    IN _concepto VARCHAR(250),
    IN _monto DOUBLE(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    -- Insertar nuevo gasto con fecha automática
    INSERT INTO gastos_cajachica (idcajachica, fecha_gasto, concepto, monto)
    VALUES (_idcajachica, NOW(), _concepto, _monto);
    -- Obtener el ID generado
    IF existe_error = 1 THEN
        SET _idgasto = -1;
    ELSE
        SET _idgasto = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_ingreso` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_ingreso` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_ingreso`(
    OUT _idingreso INT,
    IN _idreparticion INT,
    IN _descripcion varchar(80),
    IN _monto  DECIMAL(10,2),
    IN _tipopago tinyint,
    IN _noperacion varchar(15),
    IN _medio VARCHAR(30)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    -- Insertar nueva caja chica
    INSERT INTO ingresos_evento (idreparticion, descripcion ,monto, tipopago, noperacion, medio)
    VALUES (_idreparticion, _descripcion, _monto, _tipopago, nullif(_noperacion, ''), nullif(_medio, ''));
    -- Obtener el ID generado
    IF existe_error = 1 THEN
        SET _idingreso = -1;
    ELSE
        SET _idingreso = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_item_comprobante` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_item_comprobante` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_item_comprobante`(
	IN _idcomprobante INT,
    IN _cantidad	INT ,
    IN _descripcion text,
    IN _valorunitario decimal(10,2) ,
    IN _valortotal decimal(10,2) 
)
BEGIN
    INSERT INTO items_comprobante (idcomprobante, cantidad, descripcion, valorunitario, valortotal)
    VALUES (_idcomprobante, _cantidad, _descripcion, _valorunitario, _valortotal);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_notificacion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_notificacion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_notificacion`(
    OUT _idnotificacion INT,
    IN _idusuariodest INT,
    IN _idusuariorem INT,
    IN _tipo INT,
    IN _idreferencia INT,
    IN _mensaje VARCHAR(200)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO notificaciones (idusuariodest, idusuariorem, tipo, idreferencia, mensaje)
    VALUES (_idusuariodest, _idusuariorem , _tipo, nullif(_idreferencia,''), _mensaje);
    IF existe_error = 1 THEN
        SET _idnotificacion = -1;
    ELSE
        SET _idnotificacion = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_nuevo_tipotarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_nuevo_tipotarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_nuevo_tipotarea`(
	OUT _idtipotarea INT,
    IN _tipotarea VARCHAR(30)
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tipotarea (tipotarea) VALUES 
		(_tipotarea);
        
	IF existe_error= 1 THEN
		SET _idtipotarea = -1;
	ELSE
        SET _idtipotarea = last_insert_id();
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_pago_contrato` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_pago_contrato` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_pago_contrato`(
    OUT _idpagocontrato INT,
	IN _idcontrato INT,
    IN _monto decimal(10,2),
    IN _tipo_pago 	TINYINT, 
    IN _noperacion	VARCHAR(20),
    IN _fecha_pago DATE,
    IN _hora_pago	TIME,
    IN _estado	INT
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO pagos_contrato (idcontrato, monto, tipo_pago, noperacion, fecha_pago, hora_pago, estado)
    VALUES (_idcontrato, _monto, _tipo_pago, NULLIF(_noperacion, ''), _fecha_pago, _hora_pago, _estado);
    
    IF existe_error = 1 THEN
        SET _idpagocontrato = -1;
    ELSE
        SET _idpagocontrato = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_pago_cuota` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_pago_cuota` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_pago_cuota`(
	IN _idcuotacomprobante INT,
    IN _montopagado decimal(10,2),
    IN _tipo_pago 	TINYINT, 
    IN _noperacion	VARCHAR(20)
)
BEGIN
    
    INSERT INTO pagos_cuota (idcuotacomprobante, montopagado, tipo_pago, noperacion)
    VALUES (_idcuotacomprobante, _montopagado, _tipo_pago, NULLIF(_noperacion, ''));
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_persona` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_persona` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_persona`(
    OUT _idpersona INT,
    IN _num_doc VARCHAR(20),
    IN _apellidos VARCHAR(100),
    IN _nombres VARCHAR(100),
    IN _genero CHAR(1),
    IN _direccion VARCHAR(150),
    IN _telefono CHAR(15),
    IN _telefono2 CHAR(15),
    IN _correo VARCHAR(150),
    IN _iddistrito INT
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO personas (num_doc, apellidos, nombres, genero, direccion, telefono, telefono2, correo, iddistrito)
    VALUES (nullif(_num_doc, ''), nullif(_apellidos,''), nullif(_nombres,''),nullif(_genero, ''), nullif(_direccion,''), nullif(_telefono,''), nullif(_telefono2,''), NULLIF(_correo, ''), nullif(_iddistrito,''));
    
    IF existe_error = 1 THEN
        SET _idpersona = -1;
    ELSE
        SET _idpersona = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_reparticion` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_reparticion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_reparticion`(
    OUT _idreparticion INT,
    IN _iddetalle_presentacion INT
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    -- Insertar nueva caja chica
    INSERT INTO reparticion_ingresos (iddetalle_presentacion)
    VALUES (nullif(_iddetalle_presentacion, ''));
    -- Obtener el ID generado
    IF existe_error = 1 THEN
        SET _idreparticion = -1;
    ELSE
        SET _idreparticion = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_sucursal` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_sucursal` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_sucursal`(
    IN _idempresa INT,
	IN _iddistrito INT,
    IN _idresponsable	INT ,
    IN _nombre varchar(120),
    IN _ruc char(11),
    IN _telefono char(20),
    IN _direccion varchar(120),
    IN _email varchar(120),
	IN _ubigeo CHAR(6)
)
BEGIN
    INSERT INTO sucursales (idempresa, iddistrito, idresponsable, nombre, ruc, telefono, direccion, email, ubigeo)
    VALUES (_idempresa, _iddistrito, nullif(_idresponsable, ''), nullif(_nombre, ''), _ruc, nullif(_telefono, ''), _direccion, nullif(_email, ''), nullif(_ubigeo, ''));
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_tarea_diaria` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_tarea_diaria` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_tarea_diaria`(
	OUT _idtareadiaria INT,
    IN _tarea varchar(120)
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tareas_diarias (tarea)VALUES 
		(_tarea);
        
	IF existe_error= 1 THEN
		SET _idtareadiaria = -1;
	ELSE
        SET _idtareadiaria = last_insert_id();
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_tarifa` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_tarifa` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_tarifa`(
	OUT _idtarifario INT,
    IN _idusuario INT,
    IN _idprovincia int,
    IN _precio decimal(10,2),
    IN _tipo_evento INT,
    IN _idnacionalidad INT,
    IN _precioExtranjero decimal(10,2)
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tarifario (idusuario, idprovincia, precio, tipo_evento, idnacionalidad, precioExtranjero)VALUES 
		(_idusuario, nullif(_idprovincia, ''), _precio, _tipo_evento, nullif(_idnacionalidad , ''), nullif(_precioExtranjero,''));
        
	IF existe_error= 1 THEN
		SET _idtarifario = -1;
	ELSE
        SET _idtarifario = last_insert_id();
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_tipotarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_tipotarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_tipotarea`(
    OUT _idtipotarea INT,
	IN _tipotarea varchar(30)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO tipotarea (tipotarea)
    VALUES (_tipotarea);
    
    IF existe_error = 1 THEN
        SET _idtipotarea = -1;
    ELSE
        SET _idtipotarea = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_usuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_usuario`(
	OUT _idusuario INT,
    IN _idsucursal INT,
    IN _idpersona INT,
    IN _nom_usuario VARCHAR(120),
    IN _claveacceso VARBINARY(255),
    IN _color CHAR(7),
    IN _porcentaje INT,
    IN _marcaagua VARCHAR(40),
    IN _firma	VARCHAR(40),
    IN _idnivelacceso INT
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO usuarios (idsucursal, idpersona, nom_usuario, claveacceso, color, porcentaje, marcaagua ,firma, idnivelacceso)VALUES 
		(_idsucursal, _idpersona, _nom_usuario, _claveacceso, nullif(_color, ''), nullif(_porcentaje, ''), nullif(_marcaagua, ''), nullif(_firma, ''),_idnivelacceso);
        
	IF existe_error= 1 THEN
		SET _idusuario = -1;
	ELSE
        SET _idusuario = last_insert_id();
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registrar_viatico` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registrar_viatico` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_viatico`(
    OUT _idviatico INT,
	IN _iddetalle_presentacion INT,
    IN _idusuario	INT ,
    IN _pasaje decimal(10,2),
    IN _hospedaje decimal(10,2),
    IN _desayuno tinyint,
    IN _almuerzo tinyint,
    IN _cena tinyint
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO viaticos (iddetalle_presentacion, idusuario, pasaje, hospedaje, desayuno, almuerzo, cena)
    VALUES (_iddetalle_presentacion, _idusuario, nullif(_pasaje,''), _hospedaje,nullif(_desayuno, ''), nullif(_almuerzo,''), nullif(_cena,''));
    
    IF existe_error = 1 THEN
        SET _idviatico = -1;
    ELSE
        SET _idviatico = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_remover_tipotarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_remover_tipotarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_remover_tipotarea`(
    IN _idtipotarea INT
)
BEGIN	
	DELETE FROM tipotarea WHERE idtipotarea = _idtipotarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_reportar_artista_evento` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_reportar_artista_evento` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reportar_artista_evento`(
    OUT _idreporte INT,
	IN _iddetalle_presentacion int,
	IN _tipo int,
    IN _fecha date,
    IN _hora time
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO reportes_artista_evento (iddetalle_presentacion, tipo, fecha, hora)
    VALUES (_iddetalle_presentacion, _tipo, _fecha, _hora);
    
    IF existe_error = 1 THEN
        SET _idreporte = -1;
    ELSE
        SET _idreporte = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_search_cliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_search_cliente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_cliente`(
    IN _ndocumento CHAR(20),
    IN _telefono VARCHAR(15), 
    IN _razonsocial VARCHAR(255)
)
BEGIN
    SELECT 
        C.idcliente, C.tipodoc, C.ndocumento, C.razonsocial, C.representantelegal, 
        C.telefono, C.correo, C.direccion, 
        NA.idnacionalidad, D.iddepartamento, PR.idprovincia, DI.iddistrito,
        D.departamento, PR.provincia, DI.distrito
    FROM clientes C
    LEFT JOIN distritos DI ON DI.iddistrito = C.iddistrito
    LEFT JOIN provincias PR ON PR.idprovincia = DI.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NA ON NA.idnacionalidad = D.idnacionalidad
    WHERE 
        (C.ndocumento = _ndocumento OR _ndocumento IS NULL OR _ndocumento = '') 
        AND (C.telefono = _telefono OR _telefono IS NULL OR _telefono = '') 
        AND (C.razonsocial LIKE CONCAT('%', _razonsocial, '%') OR _razonsocial IS NULL OR _razonsocial = '');
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_search_cliente_numdoc` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_search_cliente_numdoc` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_cliente_numdoc`(
	IN _ndocumento char(20)
)
BEGIN
	SELECT 
    C.idcliente, C.tipodoc, C.ndocumento, C.razonsocial, C.representantelegal, C.telefono, C.correo, C.direccion, 
    NA.idnacionalidad,  D.iddepartamento, PR.idprovincia, DI.iddistrito
    FROM clientes C
    LEFT JOIN distritos DI ON DI.iddistrito = C.iddistrito
    LEFT JOIN provincias PR ON PR.idprovincia = DI.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NA ON NA.idnacionalidad = D.idnacionalidad
    WHERE C.ndocumento = _ndocumento;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_search_persona_numdoc` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_search_persona_numdoc` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_persona_numdoc`(
	IN _num_doc VARCHAR(20)
)
BEGIN
	SELECT 
    P.idpersona, P.apellidos, P.nombres, P.genero, P.direccion,P.telefono, P.telefono2, P.correo, 
    NA.idnacionalidad,  D.iddepartamento, PR.idprovincia, DI.iddistrito,
    U.nom_usuario, U.idnivelacceso, U.idsucursal
    FROM usuarios U
    LEFT JOIN personas P ON U.idpersona = P.idpersona
    LEFT JOIN distritos DI ON DI.iddistrito = P.iddistrito
    LEFT JOIN provincias PR ON PR.idprovincia = DI.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NA ON NA.idnacionalidad = D.idnacionalidad
    WHERE P.num_doc = _num_doc;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_search_tarifa_artista` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_search_tarifa_artista` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tarifa_artista`(
	IN _nom_usuario varchar(30)
)
BEGIN
	SELECT 
    T.idtarifario, USU.nom_usuario, D.departamento, PR.provincia, T.precio, NAC.pais, T.tipo_evento
    FROM tarifario T
    LEFT JOIN usuarios USU ON USU.idusuario = T.idusuario 
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE USU.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%');
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_search_tarifa_artista_por_provincia` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_search_tarifa_artista_por_provincia` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tarifa_artista_por_provincia`(
	IN _idprovincia INT,
    IN _idusuario INT,
	IN _tipo_evento INT
)
BEGIN
	SELECT 
	T.idtarifario, T.precio, T.tipo_evento, NAC.idnacionalidad, NAC.pais, PR.idprovincia, D.iddepartamento
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE PR.idprovincia = _idprovincia AND USU.idusuario = _idusuario AND T.tipo_evento = _tipo_evento;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_subir_contenido_editor` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_subir_contenido_editor` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_subir_contenido_editor`(
	OUT _idsubida INT,
    IN _idagendaeditor INT,
	IN _url TEXT
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO subidas_agenda_edicion (idagendaeditor, url)
    VALUES (_idagendaeditor, _url);
    
    IF existe_error = 1 THEN
        SET _idsubida = -1;
    ELSE
        SET _idsubida = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_user_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_user_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_login`(
	IN _usuario VARCHAR(30)
)
BEGIN
	SELECT
		US.idusuario,
        PE.apellidos, PE.nombres,
        US.nom_usuario,
        US.claveacceso, US.estado,
        NA.nivelacceso,
        NA.idnivelacceso,
        US.estado
		FROM usuarios US
        INNER JOIN nivelaccesos NA ON US.idnivelacceso = NA.idnivelacceso
        INNER JOIN personas PE ON PE.idpersona = US.idpersona
        WHERE US.nom_usuario = _usuario;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
