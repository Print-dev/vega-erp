-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 12-05-2025 a las 23:58:08
-- Versión del servidor: 10.11.10-MariaDB-log
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `u321513493_vegaerp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajachica`
--

CREATE TABLE `cajachica` (
  `idcajachica` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) DEFAULT NULL,
  `idmonto` int(11) NOT NULL,
  `ccinicial` double(10,2) NOT NULL,
  `incremento` double(10,2) NOT NULL,
  `decremento` double(10,2) NOT NULL,
  `ccfinal` double(10,2) NOT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `fecha_cierre` datetime DEFAULT NULL,
  `fecha_apertura` datetime DEFAULT current_timestamp(),
  `creadopor` int(11) DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `cajachica`
--

INSERT INTO `cajachica` (`idcajachica`, `iddetalle_presentacion`, `idmonto`, `ccinicial`, `incremento`, `decremento`, `ccfinal`, `estado`, `fecha_cierre`, `fecha_apertura`, `creadopor`) VALUES
(1, NULL, 1, 1.00, 0.00, 0.00, 0.00, 1, NULL, '2025-05-07 15:43:55', 1),
(2, 9, 1, 1.00, 0.00, 0.00, 0.00, 1, NULL, '2025-05-07 17:48:16', 1),
(3, NULL, 1, 1.00, 0.00, 0.00, 0.00, 1, NULL, '2025-05-12 21:38:44', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cajachica`
--
ALTER TABLE `cajachica`
  ADD PRIMARY KEY (`idcajachica`),
  ADD KEY `fk_iddp_cajachicaa` (`iddetalle_presentacion`),
  ADD KEY `fk_idmonto_caja` (`idmonto`),
  ADD KEY `fk_idusuario_abierto` (`creadopor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cajachica`
--
ALTER TABLE `cajachica`
  MODIFY `idcajachica` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cajachica`
--
ALTER TABLE `cajachica`
  ADD CONSTRAINT `fk_iddp_cajachicaa` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  ADD CONSTRAINT `fk_idmonto_caja` FOREIGN KEY (`idmonto`) REFERENCES `montocajachica` (`idmonto`),
  ADD CONSTRAINT `fk_idusuario_abierto` FOREIGN KEY (`creadopor`) REFERENCES `usuarios` (`idusuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
