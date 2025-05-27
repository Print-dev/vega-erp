-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 26-05-2025 a las 21:31:14
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

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `obtenerContrato` (IN `_idcontrato` INT)   BEGIN
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

END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `obtenerContratoConvenio` (IN `_idconvenio` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `obtenerConvenioPorIdDP` (IN `_iddetalle_presentacion` INT)   BEGIN
	SELECT 		
		C.idconvenio, USU.idusuario
	FROM convenios C
	LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = C.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    WHERE C.iddetalle_presentacion = _iddetalle_presentacion; -- me quede aca
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `obtenerSucursalPorId` (IN `_idsucursal` INT)   BEGIN
    SELECT 
*
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE SUC.idsucursal = _idsucursal;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `obtenerUsuarioAsignado` (IN `p_idagendaedicion` INT, IN `p_idtipotarea` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_agenda_editor` (IN `_idagendaeditor` INT, IN `_idusuario` INT, IN `_idtipotarea` INT, IN `_fecha_entrega` DATE, IN `_hora_entrega` TIME)   BEGIN
		UPDATE agenda_editores SET
    idusuario = _idusuario,
    idtipotarea = _idtipotarea,
    fecha_entrega = _fecha_entrega,
    hora_entrega = _hora_entrega
    WHERE idagendaeditor = _idagendaeditor; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_caja_dp` (IN `_iddetalle_presentacion` INT, IN `_tienecaja` TINYINT)   BEGIN
		UPDATE detalles_presentacion SET
    tienecaja = _tienecaja
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_ccfinal` (IN `_idcajachica` INT, IN `_ccfinal` DOUBLE(10,2))   BEGIN 
	UPDATE cajachica SET
    ccfinal = _ccfinal
    WHERE idcajachica = _idcajachica;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_cliente` (IN `_idcliente` INT, IN `_tipodoc` INT, IN `_iddistrito` INT, IN `_ndocumento` CHAR(20), IN `_razonsocial` VARCHAR(130), IN `_representantelegal` VARCHAR(130), IN `_telefono` CHAR(15), IN `_correo` VARCHAR(130), IN `_direccion` VARCHAR(130))   BEGIN 
	UPDATE clientes SET
    tipodoc = nullif(_tipodoc,''),
    iddistrito = nullif(_iddistrito,''),
    ndocumento = nullif(_ndocumento, ''),
    razonsocial = nullif(_razonsocial,''),
    representantelegal = nullif(_representantelegal, ''),
    telefono = nullif(_telefono, ''),
    correo = nullif(_correo, ''),
    direccion = nullif(_direccion,'')
    WHERE idcliente = _idcliente;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_colaborador` (IN `_idcolaborador` INT, IN `_idsucursal` INT, IN `_fechaingreso` DATE, IN `_idarea` INT, IN `_idresponsable` INT, IN `_banco` INT, IN `_ncuenta` CHAR(20))   BEGIN
		UPDATE colaboradores 
    SET 
		idsucursal = NULLIF(_idsucursal, ''),
        fechaingreso = NULLIF(_fechaingreso, ''),
        idarea = NULLIF(_idarea, ''),
        idresponsable = NULLIF(_idresponsable, ''),
        banco = NULLIF(_banco, ''),
        ncuenta = nullif(_ncuenta ,'')
    WHERE idcolaborador = _idcolaborador;

END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_convenio` (IN `_idconvenio` INT, IN `_abono_garantia` DECIMAL(10,2), IN `_abono_publicidad` DECIMAL(10,2), IN `_porcentaje_vega` INT, IN `_porcentaje_promotor` INT, IN `_propuesta_cliente` TEXT, IN `_estado` INT)   BEGIN 
	UPDATE convenios SET
    abono_garantia = _abono_garantia,
    abono_publicidad = _abono_publicidad,
    porcentaje_vega = _porcentaje_vega,
    porcentaje_promotor = _porcentaje_promotor,
    propuesta_cliente = _propuesta_cliente,
    estado = _estado,
    updated_at = now()
    WHERE idconvenio = _idconvenio;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_copy_contenido` (IN `_idagendacommanager` INT, IN `_copy` TEXT)   BEGIN
		UPDATE agenda_commanager SET
    copy = _copy    
    WHERE idagendacommanager = _idagendacommanager; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_decremento` (IN `_idcajachica` INT, IN `_decremento` DOUBLE(10,2))   BEGIN 
	UPDATE cajachica SET
    decremento = _decremento
    WHERE idcajachica = _idcajachica;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_detalle_presentacion` (IN `_iddetalle_presentacion` INT, IN `_fechapresentacion` DATE, IN `_horainicio` TIME, IN `_horafinal` TIME, IN `_establecimiento` VARCHAR(80), IN `_referencia` VARCHAR(200), IN `_tipoevento` INT, IN `_modotransporte` INT, IN `_validez` INT, IN `_iddistrito` INT, IN `_igv` TINYINT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_empresa` (IN `_idempresa` INT, IN `_ruc` CHAR(11), IN `_logoempresa` VARCHAR(80), IN `_razonsocial` VARCHAR(120), IN `_nombrecomercial` VARCHAR(120), IN `_nombreapp` VARCHAR(120), IN `_direccion` VARCHAR(120), IN `_web` VARCHAR(120), IN `_correo` VARCHAR(120), IN `_contrasenagmailapp` VARCHAR(120), IN `_ncuenta` VARCHAR(30), IN `_ncci` VARCHAR(30), IN `_banco` VARCHAR(30), IN `_moneda` VARCHAR(30))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estadoCordinacionPublicidad` (IN `_iddetalle_presentacion` INT, IN `_estadoCordinacionPublicidad` BOOLEAN)   BEGIN
	UPDATE detalles_presentacion SET
    estadoCordinacionPublicidad = _estadoCordinacionPublicidad
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estadoCordinacionTecnica` (IN `_iddetalle_presentacion` INT, IN `_estadoCordinacionTecnica` BOOLEAN)   BEGIN
	UPDATE detalles_presentacion SET
    estadoCordinacionTecnica = _estadoCordinacionTecnica
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_caja` (IN `_idcajachica` INT, IN `_estado` TINYINT)   BEGIN 
	UPDATE cajachica SET
    estado = _estado,
    fecha_cierre = now()
    WHERE idcajachica = _idcajachica;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_contrato` (IN `_idcontrato` INT, IN `_estado` INT)   BEGIN 
	UPDATE contratos SET
    estado = _estado,
    updated_at = now()
    WHERE idcontrato = _idcontrato;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_convenio` (IN `_idconvenio` INT, IN `_estado` INT)   BEGIN 
	UPDATE convenios SET
    estado = _estado,
    updated_at = now()
    WHERE idconvenio = _idconvenio;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_cuota_comprobante` (IN `_idcuotacomprobante` INT, IN `_estado` TINYINT)   BEGIN
    		UPDATE cuotas_comprobante SET
	estado = _estado
    WHERE idcuotacomprobante = _idcuotacomprobante; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_dp` (IN `_iddetalle_presentacion` INT, IN `_estado` TINYINT)   BEGIN
		UPDATE detalles_presentacion SET
    estado = _estado
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_publicar_contenido` (IN `_idagendacommanager` INT, IN `_estado` SMALLINT)   BEGIN
		UPDATE agenda_commanager SET
    estado = _estado    ,
    fechapublicacion = now()
    WHERE idagendacommanager = _idagendacommanager; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_reserva_dp` (IN `_iddetalle_presentacion` INT, IN `_reserva` TINYINT)   BEGIN
		UPDATE detalles_presentacion SET
    reserva = _reserva
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_tarea_altoketicket` (IN `_idagendaeditor` INT, IN `_altoketicket` VARCHAR(250))   BEGIN
	UPDATE agenda_editores SET
    altoketicket = _altoketicket
    WHERE idagendaeditor = _idagendaeditor; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_tarea_diaria_asignacion` (IN `_idtaradiariaasig` INT, IN `_estado` SMALLINT)   BEGIN
		UPDATE tareas_diaria_asignacion SET
    estado = _estado    
    WHERE idtaradiariaasig = _idtaradiariaasig; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_estado_tarea_edicion` (IN `_idagendaeditor` INT, IN `_estado` VARCHAR(250))   BEGIN
	UPDATE agenda_editores SET
    estado = _estado
    WHERE idagendaeditor = _idagendaeditor; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_gastoentrada` (IN `_idgastoentrada` INT, IN `_concepto` VARCHAR(200), IN `_fecha_gasto` DATE, IN `_monto` DECIMAL(10,2), IN `_mediopago` INT, IN `_detalles` VARCHAR(200), IN `_comprobante_url` VARCHAR(200), IN `_comprobante_fac_bol` VARCHAR(200))   BEGIN
		UPDATE gastosyentradas 
    SET 
		concepto = NULLIF(_concepto, ''),
		fecha_gasto = NULLIF(_fecha_gasto, ''),
        monto = NULLIF(_monto, ''),
        mediopago = NULLIF(_mediopago, ''),
        detalles = NULLIF(_detalles, ''),
        comprobante_url = NULLIF(_comprobante_url, ''),
        comprobante_fac_bol = NULLIF(_comprobante_fac_bol, '')
    WHERE idgastoentrada = _idgastoentrada;
    
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_incremento` (IN `_idcajachica` INT, IN `_incremento` DOUBLE(10,2))   BEGIN 
	UPDATE cajachica SET
    incremento = _incremento
    WHERE idcajachica = _idcajachica;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_monto_cajachica` (IN `_idmonto` INT, IN `_monto` DECIMAL(10,2))   BEGIN 
	UPDATE montoCajaChica SET
    monto = _monto
    WHERE idmonto = _idmonto;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_nombre_tipotarea` (IN `_idtipotarea` INT, IN `_tipotarea` VARCHAR(30))   BEGIN
		UPDATE tipotarea SET
    tipotarea = _tipotarea    
    WHERE idtipotarea = _idtipotarea; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_observacion_subida` (IN `_idsubida` INT, IN `_observaciones` VARCHAR(250))   BEGIN
	UPDATE subidas_agenda_edicion SET
    observaciones = _observaciones
    WHERE idsubida = _idsubida; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_pagado50_dp` (IN `_iddetalle_presentacion` INT, IN `_pagado50` TINYINT)   BEGIN
		UPDATE detalles_presentacion SET
    pagado50 = _pagado50
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_persona` (IN `_idpersona` INT, IN `_num_doc` VARCHAR(20), IN `_apellidos` VARCHAR(100), IN `_nombres` VARCHAR(100), IN `_genero` CHAR(1), IN `_direccion` VARCHAR(150), IN `_telefono` CHAR(15), IN `_telefono2` CHAR(15), IN `_correo` CHAR(150), IN `_iddistrito` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_precios_entrada_evento` (IN `_idprecioentradaevento` INT, IN `_entradas` TEXT)   BEGIN
		UPDATE precios_entrada_evento SET
    entradas = nullif(_entradas, '')
    WHERE idprecioentradaevento = _idprecioentradaevento; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_prodserv` (IN `_idprodserv` INT, IN `_nombre` VARCHAR(80), IN `_tipo` INT, IN `_codigo` VARCHAR(10), IN `_idproveedor` INT, IN `_precio` DECIMAL(10,2))   BEGIN
		UPDATE prodserv 
    SET 
		nombre = NULLIF(_nombre, ''),
		tipo = NULLIF(_tipo, ''),
        codigo = NULLIF(_codigo, ''),
        idproveedor = NULLIF(_idproveedor, ''),
        precio = NULLIF(_precio, '')
    WHERE idprodserv = _idprodserv;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_proveedor` (IN `_idproveedor` INT, IN `_empresa` VARCHAR(120), IN `_nombre` VARCHAR(120), IN `_contacto` INT, IN `_correo` VARCHAR(120), IN `_dni` CHAR(15), IN `_banco` VARCHAR(120), IN `_ctabancaria` INT, IN `_servicio` VARCHAR(120), IN `_nproveedor` VARCHAR(40))   BEGIN 
	UPDATE proveedores SET
    empresa = nullif(_empresa,''),
    nombre = nullif(_nombre,''),
    contacto = nullif(_contacto,''),
    correo = nullif(_correo,''),
    dni = nullif(_dni,''),
    banco = nullif(_banco,''),
    ctabancaria = nullif(_ctabancaria,''),
    servicio = nullif(_servicio,''),
    nproveedor = nullif(_nproveedor,'')
    WHERE idproveedor = _idproveedor;
    
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_responsables_boleteria_contrato_evento` (IN `_idresponsablecontrato` INT, IN `_idusuarioBoleteria` INT, IN `_idusuarioContrato` INT)   BEGIN
		UPDATE responsables_boleteria_contratoreservasreservas SET
    idusuarioBoleteria = nullif(_idusuarioBoleteria, ''),
    idusuarioContrato = nullif(_idusuarioContrato, '')
    WHERE idresponsablecontrato = _idresponsablecontrato; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_salario` (IN `_idsalario` INT, IN `_salario` DECIMAL(10,2), IN `_periodo` INT, IN `_horas` DECIMAL(10,2), IN `_costohora` DECIMAL(10,2), IN `_fechainicio` DATE)   BEGIN
		UPDATE salarios SET
        salario = nullif(_salario,''),
		periodo = nullif(_periodo, ''),
        horas = nullif(_horas, ''),
        costohora = nullif(_costohora, ''),
        fechainicio = nullif(_fechainicio, '')
    WHERE idsalario = _idsalario; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_sucursal` (IN `_idsucursal` INT, IN `_idempresa` INT, IN `_iddistrito` INT, IN `_idresponsable` INT, IN `_nombre` VARCHAR(120), IN `_ruc` CHAR(11), IN `_telefono` CHAR(20), IN `_direccion` VARCHAR(120), IN `_email` VARCHAR(120), IN `_ubigeo` CHAR(6))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_tarifa` (IN `_idtarifario` INT, IN `_precio` DECIMAL(10,2))   BEGIN 
	UPDATE tarifario SET
    precio = _precio
    WHERE idtarifario = _idtarifario;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_tarifa_precio_extranjero` (IN `_idtarifario` INT, IN `_precioExtranjero` DECIMAL(10,2))   BEGIN 
	UPDATE tarifario SET
    precioExtranjero = _precioExtranjero
    WHERE idtarifario = _idtarifario;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_usuario` (IN `_idsucursal` INT, IN `_idusuario` INT, IN `_nom_usuario` VARCHAR(120), IN `_claveacceso` VARBINARY(255), IN `_color` CHAR(7), IN `_porcentaje` INT, IN `_marcaagua` VARCHAR(80), IN `_firma` VARCHAR(80))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_actualizar_viatico` (IN `_idviatico` INT, IN `_pasaje` INT)   BEGIN 
	UPDATE viaticos SET
    pasaje = _pasaje
    WHERE idviatico = _idviatico;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_asignarfilmmaker_dp` (IN `_iddetalle_presentacion` INT, IN `_idusuario` INT)   BEGIN
		UPDATE detalles_presentacion_asignados SET
    idusuario = nullif(_idusuario, '')
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_asignar_agenda` (OUT `_idasignacion` INT, IN `_iddetalle_presentacion` INT, IN `_idusuario` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_asignar_agenda_cmanager` (OUT `_idagendacommanager` INT, IN `_idagendaeditor` INT, IN `_idusuarioCmanager` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_asignar_agenda_editor` (OUT `_idagendaeditor` INT, IN `_idagendaedicion` INT, IN `_idusuario` INT, IN `_idtipotarea` INT, IN `_fecha_entrega` DATE, IN `_hora_entrega` TIME)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_asignar_portal_web_contenido` (IN `_idagendacommanager` INT, IN `_portalpublicar` VARCHAR(120))   BEGIN
		UPDATE agenda_commanager SET
    portalpublicar = _portalpublicar    
    WHERE idagendacommanager = _idagendacommanager; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_asignar_tarea_diaria` (OUT `_idtaradiariaasig` INT, IN `_idusuario` INT, IN `_idtareadiaria` INT, IN `_fecha_entrega` DATE, IN `_hora_entrega` TIME)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_deshabilitar_usuario` (IN `_idusuario` INT, IN `_estado` TINYINT)   BEGIN
		UPDATE usuarios SET
        estado = _estado,
        update_at = now()
    WHERE idusuario = _idusuario; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_detalles_presentacion_por_modalidad` (IN `_modalidad` INT, IN `_igv` TINYINT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_editar_acuerdo_evento` (IN `_iddetalle_presentacion` INT, IN `_acuerdo` TEXT)   BEGIN
		UPDATE detalles_presentacion SET
    acuerdo = nullif(_acuerdo, '')
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_filtrar_cajachica` (IN `_fecha_apertura` DATETIME, IN `_fecha_cierre` DATETIME, IN `_mes` INT, IN `_año_semana` INT, IN `_busqueda_general` VARCHAR(255), IN `_creadopor` INT)   BEGIN
    SELECT 
    CA.idcajachica, CA.idmonto, CA.ccinicial, CA.incremento, CA.decremento, CA.ccfinal, CA.estado, CA.fecha_cierre, CA.fecha_apertura,
    DP.iddetalle_presentacion, DP.fecha_presentacion, DP.establecimiento, DIS.distrito, PRO.provincia, DE.departamento,
	USU.nom_usuario, USUCAJA.nom_usuario as creadopor, USUCAJA.idusuario as idusuariocaja
    FROM cajachica CA
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = CA.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	LEFT JOIN usuarios USUCAJA ON USUCAJA.idusuario = CA.creadopor
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
            OR CONCAT(USU.nom_usuario, ' ', DP.establecimiento) LIKE CONCAT('%', _busqueda_general, '%'))
            
            -- Filtrar por fecha de cierre (considerando NULL como abierto)
        AND (_creadopor IS NULL OR CA.creadopor = _creadopor);
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_filtrar_colaboradores` (IN `_num_doc` VARCHAR(20), IN `_idarea` INT)   BEGIN
    SELECT * FROM colaboradores	COL
	left JOIN personas PE ON PE.idpersona = COL.idpersona
    LEFT JOIN areas AR ON AR.idarea = COL.idarea
    WHERE (PE.num_doc LIKE CONCAT('%', COALESCE(_num_doc, ''), '%') OR PE.num_doc IS NULL)
	AND (_idarea IS NULL OR AR.idarea = _idarea)
    ORDER BY idcolaborador DESC;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_filtrar_gastos` (IN `_idproveedor` INT, IN `_fgasto` DATE)   BEGIN
    SELECT 
        *
    FROM 
        gastosentradas GASTOS
        LEFT JOIN colaboradores COL ON COL.idcolaborador = GASTOS.idcolaborador
        LEFT JOIN proveedores PRO ON PRO.idproveedor = GASTOS.idproveedor
		LEFT JOIN subtipos SUB ON SUB.idsubtipo = GASTOS.subtipo
        LEFT JOIN conceptos CON ON CON.idconcepto = SUB.idconcepto
    WHERE 
        (_idproveedor IS NULL OR GASTOS.idproveedor = _idproveedor)
        AND (_fgasto IS NULL OR GASTOS.fgasto = _fgasto)
    ORDER BY 
        GASTOS.idgastoentrada DESC;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_filtrar_gastosyentradas` (IN `_idusuario` INT, IN `_iddetallepresentacion` INT, IN `_fecha_gasto` DATE, IN `_estado` INT)   BEGIN
    SELECT 
        *
    FROM 
        gastosyentradas GASTOS
        LEFT JOIN usuarios USU ON USU.idusuario = GASTOS.idusuario
        LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = GASTOS.iddetallepresentacion		
    WHERE 
		(_idusuario IS NULL OR USU.idusuario = _idusuario)
        AND (_iddetallepresentacion IS NULL OR DP.iddetalle_presentacion = _iddetallepresentacion)
        AND (_fecha_gasto IS NULL OR GASTOS.fecha_gasto = _fecha_gasto)
        AND (_estado IS NULL OR GASTOS.estado = _estado)
    ORDER BY 
        GASTOS.idgastoentrada DESC;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_filtrar_nominas` ()   BEGIN
	SELECT 
	NOM.idnomina, 
    COL.idcolaborador, 
    PE.nombres, 
    PE.apellidos, 
    COL.fechaingreso, 
    NOM.salario_usado,
    NOM.periodo,
    NOM.horas,
    AR.area,
    AR.idarea, 
    NOM.tiempo, 
    NOM.rendimiento,
    NOM.proporcion, 
    NOM.acumulado
    FROM nomina NOM
	LEFT JOIN colaboradores	COL ON COL.idcolaborador = NOM.idcolaborador
	left JOIN personas PE ON PE.idpersona = COL.idpersona
    LEFT JOIN areas AR ON AR.idarea = NOM.idarea
    ORDER BY NOM.idcolaborador DESC;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_filtrar_prodserv` ()   BEGIN
	SELECT 
	PROD.idprodserv,
    PROD.nombre as nombre_prodserv,
    PROD.tipo,
    PROD.codigo,
    PRO.nombre as nombre_proveedor,
    PROD.precio
	from prodserv PROD
    LEFT JOIN proveedores PRO ON PRO.idproveedor = PROD.idproveedor
    ORDER BY idprodserv DESC;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_filtrar_proveedores` (IN `_nombre` VARCHAR(120), IN `_dni` CHAR(15))   BEGIN
    SELECT *
    FROM proveedores PRO
    WHERE 
        (_nombre IS NULL OR PRO.nombre LIKE CONCAT('%', _nombre, '%')) AND
        (_dni IS NULL OR PRO.dni LIKE CONCAT('%', _dni, '%'))
        ORDER BY idproveedor DESC;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_filtrar_reparticiones` (IN `_nom_usuario` VARCHAR(30), IN `_establecimiento` VARCHAR(80), IN `_fecha_presentacion` DATE)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_filtrar_salarios` (IN `_idcolaborador` INT)   BEGIN
	SELECT 
	*
    FROM salarios NOM
	LEFT JOIN colaboradores	COL ON COL.idcolaborador = NOM.idcolaborador
    WHERE (_idcolaborador IS NULL OR COL.idcolaborador = _idcolaborador)
    ORDER BY idsalario DESC;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_listar_sucursales` (IN `_nombre` VARCHAR(120), IN `_iddepartamento` INT, IN `_idprovincia` INT, IN `_iddistrito` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_mostrar_contenido_revisado_edicion` (IN `_iddetalle_presentacion` INT)   BEGIN	
	SELECT 
	*
		FROM agenda_edicion AGED		
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGED.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_iddetalle_presentacion IS NULL OR AGED.iddetalle_presentacion = _iddetalle_presentacion OR AGED.iddetalle_presentacion IS NULL);
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_mostrar_contenido_revisado_filmmakers` (IN `_iddetalle_presentacion` INT)   BEGIN	
	SELECT 
	*
		FROM agenda_asignaciones AGENA		
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGENA.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_iddetalle_presentacion IS NULL OR AGENA.iddetalle_presentacion = _iddetalle_presentacion OR AGENA.iddetalle_presentacion IS NULL);
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtenerCotizacion` (IN `_iddetalle_presentacion` INT)   BEGIN
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

END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_acumulados_nomina` (IN `_idnomina` INT)   BEGIN
	SELECT * 
	FROM gastos_nomina GAS
	INNER JOIN nomina NOM ON NOM.idnomina = GAS.idnomina
	WHERE NOM.idnomina = _idnomina
	ORDER BY NOM.idnomina DESC;
    
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_agenda` (IN `_idusuario` INT, IN `_iddetalle_presentacion` INT, IN `_idnivelacceso` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_agenda_artista` (IN `_idusuario` INT, IN `_iddetalle_presentacion` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_agenda_cmmanager` (IN `_idagendaeditor` INT)   BEGIN
	SELECT 
    * 
    FROM agenda_commanager  AGENC
    LEFT JOIN agenda_editores AGENE ON AGENE.idagendaeditor = AGENC.idagendaeditor
    LEFT JOIN agenda_edicion AGENED ON AGENED.idagendaedicion = AGENE.idagendaedicion
    LEFT JOIN detalles_presentacion DEP ON DEP.iddetalle_presentacion = AGENED.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DEP.idusuario
    LEFT JOIN tipotarea TIPO ON TIPO.idtipotarea = AGENE.idtipotarea
    WHERE AGENE.idagendaeditor = _idagendaeditor;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_agenda_edicion` ()   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_agenda_edicion_por_editor_y_general` (IN `_idusuario` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_agenda_editores` (IN `_idagendaedicion` INT)   BEGIN
	SELECT 
	AGE.idagendaeditor, TIPO.idtipotarea, TIPO.tipotarea, PER.nombres, USU.idusuario, AGE.fecha_entrega, AGE.hora_entrega, AGE.estado, AGE.altoketicket
    FROM agenda_editores AGE
    LEFT JOIN tipotarea TIPO ON TIPO.idtipotarea = AGE.idtipotarea
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.idagendaedicion = _idagendaedicion;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_agenda_filmmakers` (IN `_idusuario` INT, IN `_iddetalle_presentacion` INT, IN `_idnivelacceso` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_colaborador_por_id` (IN `_idcolaborador` INT)   BEGIN
	SELECT 
		*
	FROM colaboradores COL
	INNER JOIN areas AR ON COL.idarea = AR.idarea
    
    WHERE COL.idcolaborador = _idcolaborador
	LIMIT 1;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_comprobante_por_tipodoc` (IN `_idcomprobante` INT, IN `_idtipodoc` CHAR(2))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_contenido_historial_edicion` (IN `_idagendaeditor` INT)   BEGIN
	SELECT 
	*
    FROM subidas_agenda_edicion SUBI
    LEFT JOIN agenda_editores AGE ON AGE.idagendaeditor = SUBI.idagendaeditor
    WHERE SUBI.idagendaeditor = _idagendaeditor;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_cuotas` (IN `_fecha` DATE, IN `_numero_comprobante` VARCHAR(20), IN `_idcliente` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_detalles_evento` (IN `_ncotizacion` CHAR(9), IN `_ndocumento` CHAR(9), IN `_nom_usuario` CHAR(30), IN `_establecimiento` VARCHAR(80), IN `_fecha_presentacion` DATE)   BEGIN
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

END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_dps` ()   BEGIN
	SELECT 		
		DP.iddetalle_presentacion, DE.departamento, PRO.provincia, DIS.distrito, PRO.idprovincia, USU.idusuario, USU.idusuario, USU.nom_usuario
	FROM detalles_presentacion DP
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
    WHERE DP.iddetalle_presentacion = _iddetalle_presentacion; -- me quede aca
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_dp_porid` (IN `_iddetalle_presentacion` INT)   BEGIN
	SELECT 		
		DP.iddetalle_presentacion, USU.nom_usuario,DE.departamento, PRO.provincia, DIS.distrito, PRO.idprovincia, USU.idusuario, CLI.idcliente, DP.igv, DP.reserva, DP.pagado50, DP.establecimiento, DP.fecha_presentacion, DP.horainicio, DP.horafinal, DP.tipo_evento, DP.idnacionalidad, NAC.pais, NAC.idnacionalidad, CLI.telefono , CLI.razonsocial, DP.esExtranjero, estadoCordinacionTecnica, estadoCordinacionPublicidad
	FROM detalles_presentacion DP
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = DP.idnacionalidad
    WHERE DP.iddetalle_presentacion = _iddetalle_presentacion; -- me quede aca
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_dp_por_fecha` (IN `_idusuario` INT, IN `_fecha_presentacion` DATE)   BEGIN
	SELECT *
    FROM
    detalles_presentacion 
    WHERE fecha_presentacion = _fecha_presentacion AND idusuario = _idusuario; -- me quede aca
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_empresa` ()   BEGIN
    SELECT 
	*
    FROM empresa EMP
    LEFT JOIN distritos DIS ON DIS.iddistrito = EMP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_facturas` (IN `_fechaemision` DATE, IN `_horaemision` TIME, IN `_numero_comprobante` VARCHAR(20))   BEGIN
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
 END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_fecha_ocupada_artista` (IN `_idusuario` INT, IN `_fecha_presentacion` DATE)   BEGIN
    SELECT 
        *
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
        (_fecha_presentacion IS NULL OR DP.fecha_presentacion = _fecha_presentacion);
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_filmmakers_dp` (IN `_iddetalle_presentacion` INT)   BEGIN
	SELECT *
    FROM
     agenda_asignaciones AGEN 
    LEFT JOIN detalles_presentacion  DP ON AGEN.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = AGEN.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona 
    WHERE DP.iddetalle_presentacion = _iddetalle_presentacion;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_filmmaker_asignado` (IN `_iddetalle_presentacion` INT)   BEGIN
	SELECT 
		AGE.idasignacion, AGE.iddetalle_presentacion, AGE.idusuario, PER.nombres, PER.apellidos
    FROM agenda_asignaciones AGE
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.iddetalle_presentacion = _iddetalle_presentacion;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_filmmaker_asociado_evento` (IN `_idusuario` INT)   BEGIN
	SELECT 		
		DP.iddetalle_presentacion, AGEN.idusuario 
	FROM detalles_presentacion DP
    LEFT JOIN agenda_asignaciones AGEN ON AGEN.iddetalle_presentacion = DP.iddetalle_presentacion
	WHERE AGEN.idusuario = _idusuario;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_info_viatico` (IN `_iddetallepresentacion` INT, IN `_idusuario` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_info_viatico_notificacion` (IN `_idusuario` INT, IN `_idviatico` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_notas_de_venta` (IN `_fechaemision` DATE, IN `_horaemision` TIME, IN `_numero_comprobante` VARCHAR(20))   BEGIN
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
 END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_notificaciones` (IN `_iddepartamento` INT, IN `_idusuario` INT)   BEGIN
	SELECT 
		*
    FROM notificaciones NOTIF
    WHERE NOTIF.idusuario = _idusuario;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_notificaciones_por_nivel` (IN `_idnivelacceso` INT, IN `_idusuario` INT)   BEGIN
	SELECT 
		NOTIF.idnotificacion, NOTIF.idreferencia, NOTIF.mensaje
    FROM notificaciones NOTIF
    LEFT JOIN usuarios USU ON USU.idusuario = NOTIF.idusuariodest
    LEFT JOIN nivelaccesos NIVEL ON NIVEL.idnivelacceso = USU.idnivelacceso
    WHERE USU.idnivelacceso = _idnivelacceso AND USU.idusuario = _idusuario;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_notificacion_dp` (IN `_idreferencia` INT)   BEGIN
	SELECT 
		NOTIF.idnotificacion, RAE.tipo, RAE.fecha, RAE.hora, DP.iddetalle_presentacion, DP.fecha_presentacion, USU.nom_usuario, DP.horainicio, DP.horafinal, DP.establecimiento, DP.modalidad, DP.tipo_evento, DIS.distrito, PRO.provincia, DEP.departamento
    FROM notificaciones NOTIF
    LEFT JOIN reportes_artista_evento RAE ON RAE.idreporte = NOTIF.idreferencia
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = RAE.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE NOTIF.idreferencia = _idreferencia AND NOTIF.tipo = 6;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_notificacion_dp_individual` (IN `_idreferencia` INT)   BEGIN
	SELECT 
		NOTIF.idnotificacion, DP.iddetalle_presentacion, DP.fecha_presentacion, USU.nom_usuario, DP.horainicio, DP.horafinal, DP.establecimiento, DP.modalidad, DP.tipo_evento, DIS.distrito, PRO.provincia, DEP.departamento, DP.esExtranjero,NAC.pais, NAC.idnacionalidad
    FROM notificaciones NOTIF
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = NOTIF.idreferencia
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = DP.idnacionalidad
    WHERE NOTIF.idreferencia = _idreferencia AND NOTIF.tipo = 2;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_notificacion_propuesta` (IN `_idreferencia` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_pagos_contrato` (IN `_idcliente` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_permisos` (IN `p_idnivelacceso` INT)   BEGIN
    SELECT 
        modulo, ruta, texto, visibilidad, icono
    FROM permisos
    WHERE idnivelacceso = p_idnivelacceso;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_representante` (IN `_idsucursal` INT)   BEGIN
    SELECT 
	SUC.idsucursal, DEP.departamento, PRO.provincia, DIS.distrito, SUC.nombre, SUC.ruc, SUC.telefono, SUC.direccion, PER.nombres, PER.apellidos, USU.firma, PER.num_doc 
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    LEFT JOIN usuarios USU ON USU.idusuario = SUC.idresponsable
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE SUC.idsucursal = _idsucursal;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_reserva_por_pagocontrato` (IN `_idpagocontrato` INT)   BEGIN
	SELECT 
	R.idreserva, PC.monto, R.vigencia, R.fechacreada
    FROM reservas R
    LEFT JOIN pagos_contrato PC ON PC.idpagocontrato = R.idpagocontrato
    WHERE PC.idpagocontrato = _idpagocontrato;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_salario_por_colaborador` (IN `_idcolaborador` INT)   BEGIN
	SELECT 
		NOM.*,
        COL.idpersona,
        COL.fechaingreso
	FROM salarios NOM
	INNER JOIN colaboradores COL ON COL.idcolaborador = NOM.idcolaborador
	WHERE 
		(_idcolaborador IS NULL OR COL.idcolaborador = _idcolaborador)
	ORDER BY NOM.idsalario DESC
	LIMIT 1;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_sucursales_por_empresa` (IN `_idempresa` INT)   BEGIN
    SELECT 
    SUC.idsucursal, SUC.nombre ,DIS.distrito, PRO.provincia, DEP.departamento
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE SUC.idempresa = _idempresa;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_tareas_diarias_por_usuario` (IN `_idusuario` INT)   BEGIN
	SELECT 
		TDA.idtaradiariaasig, PER.nombres, PER.apellidos, TDA.fecha_entrega, TDA.hora_entrega, TDA.estado, TD.tarea, TD.idtareadiaria
    FROM tareas_diaria_asignacion TDA
    LEFT JOIN tareas_diarias TD ON TD.idtareadiaria  = TDA.idtareadiaria
    LEFT JOIN usuarios USU ON USU.idusuario = TDA.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE TDA.idusuario = _idusuario;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_tareas_editor` (IN `_idusuario` INT)   BEGIN	
	SELECT 
		AGED.idagendaeditor, AGEN.idagendaedicion, AGED.idusuario as idusuarioEdicion, AGED.fecha_asignacion, DP.fecha_presentacion, DP.horainicio, DP.horafinal, DP.establecimiento, DP.estado, USU.nom_usuario, USUDP.color
		FROM agenda_editores AGED
		LEFT JOIN agenda_edicion AGEN ON AGEN.idagendaedicion = AGED.idagendaedicion
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGEN.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_idusuario IS NULL OR AGED.idusuario = _idusuario OR AGED.idusuario IS NULL);
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_tareas_para_publicar` (IN `_establecimiento` VARCHAR(80), IN `_fecha_presentacion` DATE, IN `_idusuario` INT, IN `_idusuarioEditor` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_tarea_vinculada_cmanager` (IN `_idagendaeditor` INT)   BEGIN
	SELECT 
	AGENC.estado, AGENC.idagendacommanager, AGENC.idagendaeditor
	FROM agenda_commanager  AGENC
    LEFT JOIN agenda_editores AGENE ON AGENE.idagendaeditor = AGENC.idagendaeditor
    WHERE AGENC.idagendaeditor = _idagendaeditor;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_tarifario_artista_pais` (IN `_idusuario` INT, IN `_idnacionalidad` INT, IN `_tipo_evento` INT)   BEGIN
	SELECT 
	T.idtarifario, T.precio, T.tipo_evento, NAC.idnacionalidad, NAC.pais, T.precioExtranjero
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE USU.idusuario = _idusuario AND NAC.idnacionalidad = _idnacionalidad AND T.tipo_evento = _tipo_evento;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_tarifario_por_provincia` (IN `_iddepartamento` INT, IN `_idusuario` INT, IN `_tipo_evento` INT)   BEGIN
	SELECT 
	T.idtarifario, T.precio, T.tipo_evento, NAC.idnacionalidad, NAC.pais,PR.idprovincia, D.iddepartamento, USU.idusuario
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE PR.iddepartamento = _iddepartamento AND USU.idusuario = _idusuario AND T.tipo_evento = _tipo_evento;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_ultimanomina_por_colaborador` (IN `_idcolaborador` INT)   BEGIN
	SELECT * 
	FROM colaboradores COL
	INNER JOIN nomina NOM ON NOM.idcolaborador = COL.idcolaborador
	WHERE COL.idcolaborador = _idcolaborador
	ORDER BY NOM.idnomina DESC
	LIMIT 1;

END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_usuarios` (IN `_nivelacceso` VARCHAR(30), IN `_num_doc` VARCHAR(20), IN `_nombres` VARCHAR(100), IN `_apellidos` VARCHAR(100), IN `_telefono` CHAR(15), IN `_nom_usuario` VARCHAR(30), IN `_idsucursal` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_usuario_asignado_tarea` (IN `_idusuario` INT, IN `_idagendaedicion` INT)   BEGIN
	SELECT 
	AGE.idagendaedicion, AGE.idagendaeditor, AGE.idtipotarea, PER.nombres, USU.idusuario, AGE.fecha_entrega, AGE.estado
    FROM agenda_editores AGE
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.idusuario = _idusuario AND AGE.idagendaedicion = _idagendaedicion;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_usuario_por_id` (IN `_idusuario` INT)   BEGIN
	SELECT
		P.apellidos,P.nombres AS dato, P.num_doc, P.genero, P.telefono, P.idpersona, P.direccion, P.correo, U.porcentaje,
        U.idusuario,U.nom_usuario, U.estado,
        NA.nivelacceso
		FROM usuarios U
        INNER JOIN nivelaccesos NA ON U.idnivelacceso = NA.idnivelacceso
        INNER JOIN personas P ON U.idpersona = P.idpersona
        WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_obtener_usuario_por_nivel` (IN `_idnivelacceso` INT)   BEGIN
	SELECT
		US.idusuario,
        US.nom_usuario,
        US.estado,
        NA.nivelacceso,
        NA.idnivelacceso,
        PER.nombres,
        PER.apellidos
		FROM usuarios US
        INNER JOIN nivelaccesos NA ON US.idnivelacceso = NA.idnivelacceso
        LEFT JOIN personas PER ON PER.idpersona = US.idpersona
        WHERE NA.idnivelacceso = _idnivelacceso;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_pagar_gastoyentrada` (IN `_idgastoentrada` INT, IN `_estado` INT, IN `_mediopago` INT, IN `_detalles` VARCHAR(200), IN `_comprobante_url` VARCHAR(200), IN `_comprobante_fac_bol` VARCHAR(200))   BEGIN
		UPDATE gastosyentradas 
    SET 
		estado = NULLIF(_estado, ''),
		mediopago = NULLIF(_mediopago, ''),
        detalles = NULLIF(_detalles, ''),
        comprobante_url = NULLIF(_comprobante_url, ''),
        comprobante_fac_bol = NULLIF(_comprobante_fac_bol, '')
    WHERE idgastoentrada = _idgastoentrada;
    
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_quitar_responsable_posteo` (IN `_idagendaeditor` INT)   BEGIN	
	DELETE FROM agenda_commanager WHERE idagendaeditor = _idagendaeditor;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_quitar_tarea_usuario` (IN `_idagendaeditor` INT)   BEGIN	
	DELETE FROM agenda_editores WHERE idagendaeditor = _idagendaeditor;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_cajachica` (OUT `_idcajachica` INT, IN `_iddetalle_presentacion` INT, IN `_idmonto` INT, IN `_ccinicial` DOUBLE(10,2), IN `_incremento` DOUBLE(10,2), IN `_decremento` DOUBLE(10,2), IN `_ccfinal` DOUBLE(10,2), IN `_creadopor` INT)   BEGIN
    DECLARE existe_error INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;

    -- Insertar nueva caja chica
    INSERT INTO cajachica (iddetalle_presentacion, idmonto ,ccinicial, incremento, decremento ,ccfinal, estado, fecha_cierre, fecha_apertura, creadopor)
    VALUES (nullif(_iddetalle_presentacion, ''), _idmonto ,_ccinicial, _incremento, _decremento, _ccfinal, 1, NULL, NOW(), _creadopor);

    -- Obtener el ID generado
    IF existe_error = 1 THEN
        SET _idcajachica = -1;
    ELSE
        SET _idcajachica = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_cliente` (OUT `_idcliente` INT, IN `_tipodoc` INT, IN `_iddistrito` INT, IN `_ndocumento` CHAR(20), IN `_razonsocial` VARCHAR(130), IN `_representantelegal` VARCHAR(130), IN `_telefono` CHAR(15), IN `_correo` VARCHAR(130), IN `_direccion` VARCHAR(130))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_colaborador` (OUT `_idcolaborador` INT, IN `_idpersona` INT, IN `_idsucursal` INT, IN `_fechaingreso` DATE, IN `_idarea` INT, IN `_idresponsable` INT, IN `_banco` INT, IN `_ncuenta` CHAR(20))   BEGIN
    DECLARE existe_error INT DEFAULT 0;

    
    -- Insertar la notificación
    INSERT INTO colaboradores (idpersona, idsucursal, fechaingreso, idarea, idresponsable, banco, ncuenta)
    VALUES (_idpersona, _idsucursal, _fechaingreso , _idarea, _idresponsable, nullif(_banco, ''), nullif(_ncuenta, ''));

    IF existe_error = 1 THEN
        SET _idcolaborador = -1;
    ELSE
        SET _idcolaborador = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_comprobante` (OUT `_idcomprobante` INT, IN `_iddetallepresentacion` INT, IN `_idsucursal` INT, IN `_idcliente` INT, IN `_idtipodoc` CHAR(2), IN `_tipopago` INT, IN `_nserie` CHAR(4), IN `_correlativo` CHAR(8), IN `_tipomoneda` VARCHAR(40), IN `_monto` DECIMAL(10,2), IN `_tieneigv` TINYINT, IN `_noperacion` VARCHAR(15))   BEGIN
	    DECLARE existe_error INT DEFAULT 0;
    
    -- Insertar la notificación
    INSERT INTO comprobantes (iddetallepresentacion, idsucursal, idcliente, idtipodoc, tipopago, nserie, correlativo, tipomoneda , monto, tieneigv, noperacion)
    VALUES (_iddetallepresentacion, _idsucursal, _idcliente, _idtipodoc, _tipopago, _nserie, _correlativo, _tipomoneda, _monto, _tieneigv, nullif(_noperacion,''));

    IF existe_error = 1 THEN
        SET _idcomprobante = -1;
    ELSE
        SET _idcomprobante = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_contrato` (OUT `_idcontrato` INT, IN `_iddetalle_presentacion` INT, IN `_estado` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_convenio` (OUT `_idconvenio` INT, IN `_iddetalle_presentacion` INT, IN `_abono_garantia` DOUBLE, IN `_abono_publicidad` DOUBLE, IN `_porcentaje_vega` INT, IN `_porcentaje_promotor` INT, IN `_propuesta_cliente` TEXT, IN `_estado` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_cuota_factura` (IN `_idcomprobante` INT, IN `_fecha` DATE, IN `_monto` DECIMAL(10,2))   BEGIN
    INSERT INTO cuotas_comprobante (idcomprobante, fecha, monto)
    VALUES (_idcomprobante, _fecha, _monto);
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_detalle_comprobante` (IN `_idcomprobante` INT, IN `_estado` VARCHAR(10), IN `_info` VARCHAR(60))   BEGIN
    INSERT INTO detalles_comprobante (idcomprobante, estado, info)
    VALUES (_idcomprobante, _estado, _info);
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_detalle_presentacion` (OUT `_iddetalle_presentacion` INT, IN `_idusuario` INT, IN `_idcliente` INT, IN `_iddistrito` INT, IN `_ncotizacion` CHAR(9), IN `_fechapresentacion` DATE, IN `_horainicio` TIME, IN `_horafinal` TIME, IN `_establecimiento` VARCHAR(80), IN `_referencia` VARCHAR(200), IN `_acuerdo` TEXT, IN `_tipoevento` INT, IN `_modotransporte` INT, IN `_modalidad` INT, IN `_validez` INT, IN `_igv` TINYINT, IN `_esExtranjero` TINYINT, IN `_idnacionalidad` INT)   BEGIN


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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_egresos` (OUT `_idegreso` INT, IN `_idreparticion` INT, IN `_descripcion` VARCHAR(80), IN `_monto` DECIMAL(10,2), IN `_tipopago` TINYINT, IN `_noperacion` VARCHAR(15))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_gasto` (OUT `_idgastonomina` INT, IN `_idnomina` INT, IN `_tipo` INT, IN `_subtipo` INT, IN `_descripcion` TEXT, IN `_monto` DECIMAL(10,2))   BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO nomina (idcolaborador, salario_usado, periodo, horas, tiempo, rendimiento, proporcion,acumulado)
    VALUES (_idcolaborador , _salario_usado, _periodo, _horas,nullif(_tiempo, '') , nullif(_rendimiento, ''), nullif(_proporcion,''), nullif(_acumulado,''));

    IF existe_error = 1 THEN
        SET _idnomina = -1;
    ELSE
        SET _idnomina = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_gasto_entrada` (OUT `_idgastoentrada` INT, IN `_estado` INT, IN `_concepto` VARCHAR(200), IN `_fecha_gasto` DATE, IN `_monto` DECIMAL(10,2), IN `_iddetallepresentacion` INT, IN `_idusuario` INT, IN `_mediopago` INT, IN `_detalles` VARCHAR(200), IN `_comprobante_url` VARCHAR(200), IN `_comprobante_fac_bol` VARCHAR(200))   BEGIN
    DECLARE existe_error INT DEFAULT 0;
    

    -- Insertar la notificación
    INSERT INTO gastosyentradas (estado, concepto, fecha_gasto, monto, iddetallepresentacion, idusuario, mediopago, detalles, comprobante_url, comprobante_fac_bol)
    VALUES (_estado, nullif(_concepto,''), _fecha_gasto , _monto, _iddetallepresentacion, _idusuario,nullif(_mediopago,''),_detalles,_comprobante_url,_comprobante_fac_bol );

    IF existe_error = 1 THEN
        SET _idgastoentrada = -1;
    ELSE
        SET _idgastoentrada = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_gasto_nomina` (OUT `_idgastonomina` INT, IN `_idnomina` INT, IN `_descripcion` TEXT, IN `_monto` DECIMAL(10,2))   BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO gastos_nomina (idnomina, descripcion, monto)
    VALUES (_idnomina , _descripcion, _monto);


    IF existe_error = 1 THEN
        SET _idgastonomina = -1;
    ELSE
        SET _idgastonomina = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_ingreso` (OUT `_idingreso` INT, IN `_idreparticion` INT, IN `_descripcion` VARCHAR(80), IN `_monto` DECIMAL(10,2), IN `_tipopago` TINYINT, IN `_noperacion` VARCHAR(15), IN `_medio` VARCHAR(30))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_item_comprobante` (IN `_idcomprobante` INT, IN `_cantidad` INT, IN `_descripcion` TEXT, IN `_valorunitario` DECIMAL(10,2), IN `_valortotal` DECIMAL(10,2))   BEGIN
    INSERT INTO items_comprobante (idcomprobante, cantidad, descripcion, valorunitario, valortotal)
    VALUES (_idcomprobante, _cantidad, _descripcion, _valorunitario, _valortotal);
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_nomina` (OUT `_idnomina` INT, IN `_idcolaborador` INT, IN `_salario_usado` DECIMAL(10,2), IN `_periodo` INT, IN `_idarea` INT, IN `_horas` DECIMAL(10,2), IN `_tiempo` DECIMAL(10,2), IN `_rendimiento` DECIMAL(10,2), IN `_proporcion` DECIMAL(10,2), IN `_acumulado` DECIMAL(10,2))   BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO nomina (idcolaborador, salario_usado, periodo, idarea ,horas, tiempo, rendimiento, proporcion,acumulado)
    VALUES (_idcolaborador , _salario_usado, _periodo, _idarea,_horas,nullif(_tiempo, '') , nullif(_rendimiento, ''), nullif(_proporcion,''), nullif(_acumulado,''));

    IF existe_error = 1 THEN
        SET _idnomina = -1;
    ELSE
        SET _idnomina = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_notificacion` (OUT `_idnotificacion` INT, IN `_idusuariodest` INT, IN `_idusuariorem` INT, IN `_tipo` INT, IN `_idreferencia` INT, IN `_mensaje` VARCHAR(200))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_nuevo_tipotarea` (OUT `_idtipotarea` INT, IN `_tipotarea` VARCHAR(30))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_pago_contrato` (OUT `_idpagocontrato` INT, IN `_idcontrato` INT, IN `_monto` DECIMAL(10,2), IN `_tipo_pago` TINYINT, IN `_noperacion` VARCHAR(20), IN `_fecha_pago` DATE, IN `_hora_pago` TIME, IN `_estado` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_pago_cuota` (IN `_idcuotacomprobante` INT, IN `_montopagado` DECIMAL(10,2), IN `_tipo_pago` TINYINT, IN `_noperacion` VARCHAR(20))   BEGIN
    
    INSERT INTO pagos_cuota (idcuotacomprobante, montopagado, tipo_pago, noperacion)
    VALUES (_idcuotacomprobante, _montopagado, _tipo_pago, NULLIF(_noperacion, ''));
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_persona` (OUT `_idpersona` INT, IN `_num_doc` VARCHAR(20), IN `_apellidos` VARCHAR(100), IN `_nombres` VARCHAR(100), IN `_genero` CHAR(1), IN `_direccion` VARCHAR(150), IN `_telefono` CHAR(15), IN `_telefono2` CHAR(15), IN `_correo` VARCHAR(150), IN `_iddistrito` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_prodserv` (OUT `_idprodserv` INT, IN `_nombre` VARCHAR(80), IN `_tipo` INT, IN `_codigo` VARCHAR(10), IN `_idproveedor` INT, IN `_precio` DECIMAL(10,2))   BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    
    -- Insertar la notificación
    INSERT INTO prodserv (nombre, tipo, codigo, idproveedor, precio)
    VALUES (_nombre , _tipo, _codigo, nullif(_idproveedor, ''), _precio);

    IF existe_error = 1 THEN
        SET _idprodserv = -1;
    ELSE
        SET _idprodserv = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_proveedor` (OUT `_idproveedor` INT, IN `_empresa` VARCHAR(120), IN `_nombre` VARCHAR(120), IN `_contacto` INT, IN `_correo` VARCHAR(120), IN `_dni` INT, IN `_banco` VARCHAR(200), IN `_ctabancaria` INT, IN `_servicio` VARCHAR(120), IN `_nproveedor` VARCHAR(40))   BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO proveedores (empresa,nombre, contacto, correo, dni, banco, ctabancaria, servicio, nproveedor)
    VALUES (nullif(_empresa,''), nullif(_nombre,''), nullif(_contacto, '') , nullif(_correo,''), nullif(_dni,''), nullif(_banco,''), nullif(_ctabancaria,''), nullif(_servicio,''), nullif(_nproveedor,''));

    IF existe_error = 1 THEN
        SET _idproveedor = -1;
    ELSE
        SET _idproveedor = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_reparticion` (OUT `_idreparticion` INT, IN `_iddetalle_presentacion` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_salario` (OUT `_idsalario` INT, IN `_idcolaborador` INT, IN `_salario` DECIMAL(10,2), IN `_periodo` INT, IN `_horas` DECIMAL(10,2), IN `_costohora` DECIMAL(10,2))   BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    -- Insertar la notificación
    INSERT INTO salarios (idcolaborador, salario, periodo, horas, costohora)
    VALUES (_idcolaborador, _salario , _periodo ,_horas, _costohora);

    IF existe_error = 1 THEN
        SET _idsalario = -1;
    ELSE
        SET _idsalario = LAST_INSERT_ID();
    END IF;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_sucursal` (IN `_idempresa` INT, IN `_iddistrito` INT, IN `_idresponsable` INT, IN `_nombre` VARCHAR(120), IN `_ruc` CHAR(11), IN `_telefono` CHAR(20), IN `_direccion` VARCHAR(120), IN `_email` VARCHAR(120), IN `_ubigeo` CHAR(6))   BEGIN
    INSERT INTO sucursales (idempresa, iddistrito, idresponsable, nombre, ruc, telefono, direccion, email, ubigeo)
    VALUES (_idempresa, _iddistrito, nullif(_idresponsable, ''), nullif(_nombre, ''), _ruc, nullif(_telefono, ''), _direccion, nullif(_email, ''), nullif(_ubigeo, ''));
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_tarea_diaria` (OUT `_idtareadiaria` INT, IN `_tarea` VARCHAR(120))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_tarifa` (OUT `_idtarifario` INT, IN `_idusuario` INT, IN `_idprovincia` INT, IN `_precio` DECIMAL(10,2), IN `_tipo_evento` INT, IN `_idnacionalidad` INT, IN `_precioExtranjero` DECIMAL(10,2))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_tipotarea` (OUT `_idtipotarea` INT, IN `_tipotarea` VARCHAR(30))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_usuario` (OUT `_idusuario` INT, IN `_idsucursal` INT, IN `_idpersona` INT, IN `_nom_usuario` VARCHAR(120), IN `_claveacceso` VARBINARY(255), IN `_color` CHAR(7), IN `_porcentaje` INT, IN `_marcaagua` VARCHAR(80), IN `_firma` VARCHAR(80), IN `_idnivelacceso` INT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_registrar_viatico` (OUT `_idviatico` INT, IN `_iddetalle_presentacion` INT, IN `_idusuario` INT, IN `_pasaje` DECIMAL(10,2), IN `_hospedaje` DECIMAL(10,2), IN `_desayuno` TINYINT, IN `_almuerzo` TINYINT, IN `_cena` TINYINT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_remover_tipotarea` (IN `_idtipotarea` INT)   BEGIN	
	DELETE FROM tipotarea WHERE idtipotarea = _idtipotarea;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_reportar_artista_evento` (OUT `_idreporte` INT, IN `_iddetalle_presentacion` INT, IN `_tipo` INT, IN `_fecha` DATE, IN `_hora` TIME)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_search_cliente` (IN `_ndocumento` CHAR(20), IN `_telefono` VARCHAR(15), IN `_razonsocial` VARCHAR(255))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_search_cliente_numdoc` (IN `_ndocumento` CHAR(20))   BEGIN
	SELECT 
    C.idcliente, C.tipodoc, C.ndocumento, C.razonsocial, C.representantelegal, C.telefono, C.correo, C.direccion, 
    NA.idnacionalidad,  D.iddepartamento, PR.idprovincia, DI.iddistrito
    FROM clientes C
    LEFT JOIN distritos DI ON DI.iddistrito = C.iddistrito
    LEFT JOIN provincias PR ON PR.idprovincia = DI.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NA ON NA.idnacionalidad = D.idnacionalidad
    WHERE C.ndocumento = _ndocumento;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_search_persona_numdoc` (IN `_num_doc` VARCHAR(20))   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_search_tarifa_artista` (IN `_nom_usuario` VARCHAR(30))   BEGIN
	SELECT 
    T.idtarifario, USU.nom_usuario, D.departamento, PR.provincia, T.precio, NAC.pais, T.tipo_evento
    FROM tarifario T
    LEFT JOIN usuarios USU ON USU.idusuario = T.idusuario 
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE USU.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%');
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_search_tarifa_artista_por_provincia` (IN `_idprovincia` INT, IN `_idusuario` INT, IN `_tipo_evento` INT)   BEGIN
	SELECT 
	T.idtarifario, T.precio, T.tipo_evento, NAC.idnacionalidad, NAC.pais, PR.idprovincia, D.iddepartamento
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE PR.idprovincia = _idprovincia AND USU.idusuario = _idusuario AND T.tipo_evento = _tipo_evento;
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_subir_contenido_editor` (OUT `_idsubida` INT, IN `_idagendaeditor` INT, IN `_url` TEXT)   BEGIN
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
END$$

CREATE DEFINER=`u321513493_vegaerp`@`127.0.0.1` PROCEDURE `sp_user_login` (IN `_usuario` VARCHAR(30))   BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda_asignaciones`
--

CREATE TABLE `agenda_asignaciones` (
  `idasignacion` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda_commanager`
--

CREATE TABLE `agenda_commanager` (
  `idagendacommanager` int(11) NOT NULL,
  `idagendaeditor` int(11) NOT NULL,
  `idusuarioCmanager` int(11) NOT NULL,
  `portalpublicar` varchar(120) DEFAULT NULL,
  `fechapublicacion` datetime DEFAULT NULL,
  `copy` text DEFAULT NULL,
  `estado` smallint(6) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda_edicion`
--

CREATE TABLE `agenda_edicion` (
  `idagendaedicion` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `agenda_edicion`
--

INSERT INTO `agenda_edicion` (`idagendaedicion`, `iddetalle_presentacion`) VALUES
(13, 1),
(14, 2),
(15, 3),
(16, 4),
(17, 5),
(18, 6),
(19, 7),
(20, 8),
(21, 9),
(22, 10),
(23, 11),
(339, 11),
(24, 12),
(25, 13),
(26, 14),
(27, 15),
(345, 15),
(28, 16),
(347, 16),
(29, 17),
(353, 17),
(30, 18),
(360, 18),
(31, 19),
(32, 20),
(33, 21),
(34, 22),
(35, 23),
(36, 24),
(37, 25),
(38, 26),
(39, 27),
(40, 28),
(41, 29),
(42, 30),
(43, 31),
(44, 32),
(45, 33),
(46, 34),
(47, 35),
(48, 36),
(49, 37),
(50, 38),
(51, 39),
(52, 40),
(53, 41),
(54, 42),
(55, 43),
(56, 44),
(57, 45),
(58, 46),
(59, 47),
(60, 48),
(61, 49),
(62, 50),
(63, 51),
(64, 52),
(65, 53),
(66, 54),
(67, 55),
(68, 56),
(69, 57),
(70, 58),
(71, 59),
(72, 60),
(73, 61),
(74, 62),
(75, 63),
(76, 65),
(77, 66),
(78, 67),
(79, 68),
(80, 69),
(81, 70),
(82, 71),
(83, 72),
(84, 73),
(85, 74),
(86, 75),
(87, 76),
(88, 77),
(89, 78),
(90, 79),
(91, 80),
(92, 81),
(93, 82),
(94, 83),
(95, 84),
(96, 85),
(97, 86),
(98, 87),
(99, 88),
(100, 89),
(101, 90),
(102, 91),
(103, 92),
(104, 93),
(105, 94),
(106, 95),
(216, 96),
(108, 97),
(109, 98),
(110, 99),
(111, 100),
(112, 101),
(113, 102),
(114, 103),
(115, 104),
(335, 112),
(336, 113),
(337, 117),
(338, 118),
(340, 119),
(342, 121),
(344, 123),
(346, 124),
(348, 125),
(349, 126),
(350, 127),
(351, 128),
(352, 129),
(354, 130),
(355, 131),
(356, 132),
(357, 133),
(358, 134),
(359, 135),
(361, 136),
(362, 137),
(363, 138),
(364, 139),
(365, 140),
(366, 141),
(367, 142),
(368, 143),
(369, 144),
(370, 144),
(371, 145),
(372, 146),
(373, 147),
(374, 148),
(375, 149),
(376, 150),
(377, 151),
(378, 152);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda_editores`
--

CREATE TABLE `agenda_editores` (
  `idagendaeditor` int(11) NOT NULL,
  `idagendaedicion` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idtipotarea` int(11) NOT NULL,
  `estado` int(11) DEFAULT 1,
  `altoketicket` int(11) DEFAULT 1,
  `fecha_asignacion` datetime DEFAULT current_timestamp(),
  `fecha_entrega` date NOT NULL,
  `hora_entrega` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `agenda_editores`
--

INSERT INTO `agenda_editores` (`idagendaeditor`, `idagendaedicion`, `idusuario`, `idtipotarea`, `estado`, `altoketicket`, `fecha_asignacion`, `fecha_entrega`, `hora_entrega`) VALUES
(2, 16, 7, 1, 1, 1, '2025-05-12 15:20:09', '2025-05-12', '10:24:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `idarea` int(11) NOT NULL,
  `area` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idcliente` int(11) NOT NULL,
  `tipodoc` int(11) DEFAULT NULL,
  `iddistrito` int(11) DEFAULT NULL,
  `ndocumento` char(20) DEFAULT NULL,
  `razonsocial` varchar(130) DEFAULT NULL,
  `representantelegal` varchar(130) DEFAULT NULL,
  `telefono` char(15) DEFAULT NULL,
  `correo` varchar(130) DEFAULT NULL,
  `direccion` varchar(130) DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idcliente`, `tipodoc`, `iddistrito`, `ndocumento`, `razonsocial`, `representantelegal`, `telefono`, `correo`, `direccion`) VALUES
(1, NULL, 1335, NULL, 'DISCOTECA KENKO Carlos', NULL, '992440558', NULL, 'Avenida 28 de Julio, Santa Clara'),
(2, NULL, NULL, NULL, 'sol del norte isaias', NULL, '949025169', NULL, NULL),
(3, NULL, NULL, NULL, 'diestra', NULL, '936733514', NULL, NULL),
(4, NULL, NULL, NULL, 'shugar', NULL, NULL, NULL, NULL),
(5, NULL, 1333, NULL, 'Nilton Cruz', 'junior', '924766574', NULL, NULL),
(6, NULL, NULL, NULL, 'Emerson Erasmo Torres Enma', NULL, '953462029', NULL, NULL),
(7, NULL, NULL, NULL, 'lucho la rosa producciones', NULL, '932060008', NULL, NULL),
(8, NULL, NULL, NULL, 'Marcelino Elvis Navarro', NULL, '964195652', NULL, NULL),
(9, NULL, NULL, NULL, 'empresario', NULL, '986005795', NULL, NULL),
(10, NULL, NULL, NULL, 'carlos rupay', NULL, '916936955', NULL, NULL),
(11, NULL, NULL, NULL, 'Ruben Wilder Bocanegra', NULL, '947715974', NULL, NULL),
(12, NULL, NULL, NULL, 'chicho', NULL, '956642591', NULL, NULL),
(13, NULL, NULL, NULL, 'eduardo cardenas', NULL, '930275735', NULL, NULL),
(14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, NULL, NULL, NULL, 'Arturo Massa Ica', NULL, '975724742', NULL, NULL),
(16, NULL, NULL, NULL, 'dani gutierrez', NULL, '983156846', NULL, NULL),
(17, NULL, NULL, NULL, 'sr koki', NULL, '981042313', NULL, NULL),
(18, NULL, NULL, NULL, 'gilton', NULL, NULL, NULL, NULL),
(19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, NULL, NULL, NULL, 'sr orlando', NULL, '965604671', NULL, NULL),
(21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, NULL, NULL, NULL, 'piti', NULL, '901255993', NULL, NULL),
(25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, NULL, NULL, NULL, 'antoni calderon', NULL, NULL, NULL, NULL),
(27, NULL, NULL, NULL, 'sr arquimedes', NULL, NULL, NULL, NULL),
(28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, NULL, NULL, NULL, 'orquesta la unica', NULL, NULL, NULL, NULL),
(30, NULL, NULL, NULL, 'radio satelite', NULL, NULL, NULL, NULL),
(31, NULL, NULL, NULL, 'sr gema', NULL, NULL, NULL, NULL),
(32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, NULL, NULL, NULL, 'correa', NULL, NULL, NULL, NULL),
(34, NULL, NULL, NULL, 'gema hugo', NULL, NULL, NULL, NULL),
(35, NULL, NULL, NULL, 'pablo yaipen', NULL, NULL, NULL, NULL),
(36, NULL, NULL, NULL, 'pizarro', NULL, NULL, NULL, NULL),
(37, NULL, NULL, NULL, 'juan carlos', NULL, NULL, NULL, NULL),
(38, NULL, NULL, NULL, 'rolando', NULL, NULL, NULL, NULL),
(39, NULL, NULL, NULL, 'sonido genesis star', NULL, NULL, NULL, NULL),
(40, NULL, NULL, NULL, 'cesar', NULL, NULL, NULL, NULL),
(41, NULL, NULL, NULL, 'gerber huaman', NULL, NULL, NULL, NULL),
(42, NULL, NULL, NULL, 'palmus eventos - luis palomino', NULL, '959392731', NULL, NULL),
(43, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, NULL, NULL, NULL, 'flor santamaria', NULL, NULL, NULL, NULL),
(45, NULL, NULL, NULL, 'margiory acosta', NULL, NULL, NULL, NULL),
(46, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(48, NULL, NULL, NULL, 'yaqueline piña', NULL, NULL, NULL, NULL),
(49, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, NULL, NULL, NULL, 'jaime huaman perez', NULL, '990763910', NULL, NULL),
(51, NULL, NULL, NULL, 'pamela serrano', NULL, '943284983', NULL, NULL),
(52, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(53, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(54, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(55, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(56, NULL, NULL, NULL, 'Ever Rashuaman', NULL, '995479587', NULL, NULL),
(57, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(58, NULL, NULL, NULL, 'oscar', NULL, NULL, NULL, NULL),
(59, NULL, NULL, NULL, 'oscar flores', NULL, NULL, NULL, NULL),
(60, NULL, NULL, NULL, 'hugo moreno', NULL, NULL, NULL, NULL),
(61, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(62, NULL, NULL, NULL, 'chino estiven', NULL, NULL, NULL, NULL),
(63, NULL, NULL, NULL, 'liliana pobes', NULL, NULL, NULL, NULL),
(64, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(65, NULL, NULL, NULL, 'julian', NULL, NULL, NULL, NULL),
(66, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(67, NULL, NULL, NULL, 'diego', NULL, NULL, NULL, NULL),
(68, NULL, NULL, NULL, 'mirian', NULL, NULL, NULL, NULL),
(69, NULL, NULL, NULL, 'carlos vilches', NULL, NULL, NULL, NULL),
(70, NULL, NULL, NULL, 'Hermandad Santísima Cruz del Cerro Saltur', NULL, NULL, NULL, NULL),
(71, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(72, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(73, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(74, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(75, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(76, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(77, 1, 1335, '70000000', 'cerro naty', NULL, '999000111', 'prueba8@gmail.com', 'AV. abc 123'),
(78, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(79, NULL, NULL, NULL, 'adadasdsad', NULL, NULL, NULL, NULL),
(80, NULL, NULL, NULL, 'adadasdsad', NULL, NULL, NULL, NULL),
(81, NULL, NULL, NULL, 'adadasdsad', NULL, NULL, NULL, NULL),
(82, NULL, NULL, NULL, 'adadasdsad', NULL, NULL, NULL, NULL),
(83, NULL, NULL, NULL, 'adadasdsad', NULL, NULL, NULL, NULL),
(84, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(85, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(86, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(87, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(88, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(89, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(90, NULL, NULL, NULL, 'Arturo Massa Ica', NULL, NULL, NULL, NULL),
(91, NULL, NULL, NULL, 'roberto', NULL, '972921902', NULL, NULL),
(92, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(93, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(94, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(95, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(96, NULL, NULL, NULL, 'prom palmos', NULL, NULL, NULL, NULL),
(97, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(98, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(101, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(102, NULL, NULL, NULL, 'joel cristobal', NULL, '996966037', NULL, NULL),
(103, NULL, NULL, NULL, 'vega', NULL, '980571585', NULL, NULL),
(104, NULL, NULL, NULL, 'tatiana', NULL, '962362986', NULL, NULL),
(105, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(106, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(107, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(108, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(109, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(110, NULL, NULL, NULL, 'wiliam sanchez', NULL, '922998012', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colaboradores`
--

CREATE TABLE `colaboradores` (
  `idcolaborador` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `fechaingreso` date NOT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idresponsable` int(11) DEFAULT NULL,
  `banco` int(11) DEFAULT NULL,
  `ncuenta` char(20) DEFAULT NULL,
  `activo` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobantes`
--

CREATE TABLE `comprobantes` (
  `idcomprobante` int(11) NOT NULL,
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
  `noperacion` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratos`
--

CREATE TABLE `contratos` (
  `idcontrato` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) NOT NULL,
  `estado` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `contratos`
--

INSERT INTO `contratos` (`idcontrato`, `iddetalle_presentacion`, `estado`, `created_at`, `updated_at`) VALUES
(1, 13, 1, '2025-04-16 17:31:22', NULL),
(2, 85, 1, '2025-05-05 10:06:41', NULL),
(3, 17, 2, '2025-05-05 19:53:29', '2025-05-19 17:28:56'),
(4, 18, 2, '2025-05-05 19:56:38', '2025-05-19 17:51:21'),
(5, 11, 2, '2025-05-08 18:57:59', '2025-05-13 17:17:00'),
(6, 9, 1, '2025-05-12 18:02:30', NULL),
(7, 123, 1, '2025-05-19 16:58:58', NULL),
(8, 15, 2, '2025-05-19 16:59:55', '2025-05-19 17:00:44'),
(9, 16, 2, '2025-05-19 17:05:58', '2025-05-19 17:06:10'),
(10, 127, 1, '2025-05-19 17:15:49', NULL),
(11, 128, 1, '2025-05-19 17:17:49', NULL),
(12, 137, 1, '2025-05-19 17:57:55', NULL),
(13, 144, 2, '2025-05-19 18:18:03', '2025-05-19 18:18:24'),
(14, 118, 1, '2025-05-23 00:20:06', NULL),
(15, 138, 1, '2025-05-26 21:23:37', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `convenios`
--

CREATE TABLE `convenios` (
  `idconvenio` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) NOT NULL,
  `abono_garantia` decimal(10,2) DEFAULT NULL,
  `abono_publicidad` decimal(10,2) DEFAULT NULL,
  `porcentaje_vega` int(11) NOT NULL,
  `porcentaje_promotor` int(11) NOT NULL,
  `propuesta_cliente` text NOT NULL,
  `estado` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `convenios`
--

INSERT INTO `convenios` (`idconvenio`, `iddetalle_presentacion`, `abono_garantia`, `abono_publicidad`, `porcentaje_vega`, `porcentaje_promotor`, `propuesta_cliente`, `estado`, `created_at`, `updated_at`) VALUES
(3, 16, 500.00, 800.00, 60, 40, '', 2, '2025-04-16 14:57:32', '2025-04-16 15:13:54'),
(4, 99, 500.00, 500.00, 50, 50, '', 1, '2025-05-05 10:09:44', NULL),
(5, 100, 500.00, 500.00, 60, 40, '', 1, '2025-05-05 10:11:55', NULL),
(6, 101, 500.00, 500.00, 60, 40, '', 1, '2025-05-05 10:14:27', NULL),
(7, 102, 500.00, 500.00, 60, 40, '', 1, '2025-05-05 10:16:30', NULL),
(8, 103, 500.00, 500.00, 60, 40, '', 1, '2025-05-05 10:17:57', NULL),
(9, 113, 500.00, 500.00, 60, 40, '', 1, '2025-05-05 10:30:36', NULL),
(10, 112, 500.00, 500.00, 60, 40, '', 1, '2025-05-05 10:31:01', NULL),
(11, 104, 0.00, 0.00, 50, 50, '', 2, '2025-05-07 16:24:10', '2025-05-07 16:25:02'),
(12, 8, 0.00, 0.00, 60, 40, '', 2, '2025-05-07 17:52:46', '2025-05-07 17:52:59'),
(13, 1, 0.00, 0.00, 60, 40, '', 2, '2025-05-08 14:25:31', '2025-05-08 14:26:01'),
(14, 2, 0.00, 0.00, 60, 40, '', 2, '2025-05-08 14:29:11', '2025-05-08 14:29:24'),
(15, 3, 0.00, 0.00, 60, 40, '', 2, '2025-05-08 14:29:57', '2025-05-08 14:30:01'),
(16, 4, 0.00, 0.00, 60, 40, '', 2, '2025-05-08 14:30:45', '2025-05-08 14:31:07'),
(17, 5, 0.00, 0.00, 60, 40, '', 2, '2025-05-08 14:31:51', '2025-05-08 14:32:05'),
(18, 6, 0.00, 0.00, 60, 40, '', 2, '2025-05-08 14:32:23', '2025-05-08 14:32:27'),
(19, 7, 0.00, 0.00, 60, 40, '', 2, '2025-05-08 14:32:40', '2025-05-08 14:32:45'),
(20, 119, 0.00, 0.00, 60, 40, '', 1, '2025-05-13 17:45:40', NULL),
(21, 23, 0.00, 0.00, 60, 40, '', 1, '2025-05-13 17:45:53', NULL),
(22, 25, 0.00, 0.00, 50, 50, '', 1, '2025-05-13 17:47:56', NULL),
(23, 26, 0.00, 0.00, 50, 50, 'GARANTIA: 7 mil', 1, '2025-05-13 17:50:20', NULL),
(24, 27, 0.00, 0.00, 50, 50, '', 1, '2025-05-13 17:51:19', NULL),
(25, 28, 0.00, 0.00, 50, 50, '', 1, '2025-05-13 17:52:05', NULL),
(26, 31, 0.00, 0.00, 40, 60, '', 1, '2025-05-13 17:57:33', NULL),
(27, 129, 0.00, 0.00, 50, 50, '', 1, '2025-05-19 17:22:34', NULL),
(28, 130, 0.00, 0.00, 60, 40, '', 1, '2025-05-19 17:37:23', NULL),
(29, 131, 0.00, 0.00, 60, 40, '', 1, '2025-05-19 17:37:36', NULL),
(30, 132, 0.00, 0.00, 60, 40, '', 1, '2025-05-19 17:38:02', NULL),
(31, 121, 0.00, 0.00, 55, 45, '', 1, '2025-05-19 17:49:57', NULL),
(32, 136, 0.00, 0.00, 60, 40, '', 1, '2025-05-19 17:54:10', NULL),
(33, 146, 0.00, 0.00, 60, 40, '', 1, '2025-05-21 22:41:58', NULL),
(34, 145, 0.00, 0.00, 60, 40, '', 1, '2025-05-21 22:45:13', NULL),
(35, 152, 0.00, 0.00, 55, 45, '', 1, '2025-05-26 21:16:51', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotas_comprobante`
--

CREATE TABLE `cuotas_comprobante` (
  `idcuotacomprobante` int(11) NOT NULL,
  `idcomprobante` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fechapagado` date DEFAULT NULL,
  `horapagado` time DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `iddepartamento` int(11) NOT NULL,
  `idnacionalidad` int(11) NOT NULL,
  `departamento` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`iddepartamento`, `idnacionalidad`, `departamento`) VALUES
(1, 31, 'Amazonas'),
(2, 31, 'Áncash'),
(3, 31, 'Apurímac'),
(4, 31, 'Arequipa'),
(5, 31, 'Ayacucho'),
(6, 31, 'Cajamarca'),
(7, 31, 'Callao'),
(8, 31, 'Cusco'),
(9, 31, 'Huancavelica'),
(10, 31, 'Huánuco'),
(11, 31, 'Ica'),
(12, 31, 'Junín'),
(13, 31, 'La Libertad'),
(14, 31, 'Lambayeque'),
(15, 31, 'Lima'),
(16, 31, 'Loreto'),
(17, 31, 'Madre de Dios'),
(18, 31, 'Moquegua'),
(19, 31, 'Pasco'),
(20, 31, 'Piura'),
(21, 31, 'Puno'),
(22, 31, 'San Martín'),
(23, 31, 'Tacna'),
(24, 31, 'Tumbes'),
(25, 31, 'Ucayali');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_comprobante`
--

CREATE TABLE `detalles_comprobante` (
  `iddetallecomprobante` int(11) NOT NULL,
  `idcomprobante` int(11) NOT NULL,
  `estado` varchar(10) NOT NULL,
  `info` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_presentacion`
--

CREATE TABLE `detalles_presentacion` (
  `iddetalle_presentacion` int(11) NOT NULL,
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
  `estadoCordinacionTecnica` tinyint(1) DEFAULT 0,
  `estadoCordinacionPublicidad` tinyint(1) DEFAULT 0
) ;

--
-- Volcado de datos para la tabla `detalles_presentacion`
--

INSERT INTO `detalles_presentacion` (`iddetalle_presentacion`, `idusuario`, `idcliente`, `iddistrito`, `ncotizacion`, `fecha_presentacion`, `horainicio`, `horafinal`, `establecimiento`, `referencia`, `acuerdo`, `tipo_evento`, `modalidad`, `modotransporte`, `validez`, `igv`, `reserva`, `pagado50`, `tienecaja`, `estado`, `created_at`, `esExtranjero`, `idnacionalidad`, `estadoCordinacionTecnica`, `estadoCordinacionPublicidad`) VALUES
(1, 2, 1, 1269, NULL, '2025-04-19', '00:00:00', '00:00:00', 'Local praxigas ex finca Nario', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(2, 3, 1, 1269, NULL, '2025-04-19', '00:00:00', '00:00:00', 'Local praxigas ex finca Nario', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(3, 3, 2, 221, NULL, '2025-04-20', '18:00:00', '21:30:00', 'Aniversario de azucena /pisina', NULL, NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(4, 2, 3, 1183, NULL, '2025-04-30', '21:00:00', '02:00:00', 'Casa grande Club Gema de Casa grande', NULL, 'OBSERVACIONES O ANOTACIONES', 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(5, 2, 4, 613, NULL, '2025-05-04', '00:00:00', '00:00:00', NULL, NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(6, 2, 4, 1, NULL, '2025-05-04', '00:00:00', '00:00:00', NULL, NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(7, 2, 5, 1550, NULL, '2025-05-31', '12:30:00', '03:00:00', 'Discoteca Blum', NULL, NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(8, 3, 5, 1577, NULL, '2025-05-31', '22:00:00', '00:00:00', '', NULL, NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(9, 2, 6, 979, '0001-2025', '2025-04-26', '00:00:00', '04:00:00', 'Sindicato de obreros', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(10, 2, 7, 1183, '0002-2025', '2025-04-27', '01:30:00', '04:00:00', 'Tabaco marino', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(11, 2, 8, 1104, '0003-2025', '2025-05-01', '23:00:00', '02:00:00', 'Recepciones Marcelita muruhuay', NULL, NULL, 1, 2, 1, 7, 0, 0, 1, 0, 3, '2025-04-16', 0, 31, 0, 0),
(12, 3, 9, 495, '0004-2025', '2025-05-01', '23:00:00', '03:00:00', 'Centro poblado Santa filomena', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(13, 2, 9, 1328, '0005-2025', '2025-05-03', '16:00:00', '20:00:00', 'Casa salsedo eventos', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(14, 2, 10, 672, '0006-2025', '2025-05-09', '20:00:00', '22:00:00', 'Ventanilla Municipalidad', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(15, 2, 11, 1154, '0007-2025', '2025-05-10', '23:00:00', '01:00:00', 'retamaz', 'fiesta patronal honor a la santisima virgen de la puerta y dia de la madre', '42mil', 1, 2, 1, 7, 0, 0, 1, 0, 1, '2025-04-16', 0, 31, 0, 0),
(16, 2, 12, 323, '0043-2025', '2025-05-11', '22:00:00', '02:00:00', 'cerro colorado', 'POSTERGADO PASA PARA EL DIA DEL PADRE 15.06.25', NULL, 1, 2, 1, 7, 0, 0, 1, 0, 1, '2025-04-16', 0, 31, 0, 0),
(17, 2, 13, 323, '0008-2025', '2025-05-17', '21:00:00', '01:00:00', 'rio grande iquipi', NULL, NULL, 1, 2, 1, 7, 0, 1, 1, 0, 1, '2025-04-16', 0, 31, 0, 0),
(18, 2, 13, 333, '0009-2025', '2025-05-18', '21:00:00', '01:00:00', 'estadio municipal', NULL, NULL, 2, 2, 1, 7, 0, 1, 1, 0, 1, '2025-04-16', 0, 31, 0, 0),
(19, 4, 14, 1034, '0010-2025', '2025-10-25', '00:00:00', '00:00:00', 'huancayo, aun no hay locacion', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(20, 2, 15, 964, NULL, '2025-04-13', '22:00:00', '02:00:00', 'discoteca 10 lukas', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(21, 2, 16, 1338, NULL, '2025-04-12', '23:00:00', '03:00:00', 'discoteca tropical', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(22, 2, 17, 1225, NULL, '2025-04-06', '18:00:00', '22:00:00', 'aventura  park 7 aniversario', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(23, 2, 18, 1337, NULL, '2025-04-04', '22:00:00', '00:30:00', 'yacumama', NULL, NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(24, 2, 19, 1293, NULL, '2025-03-30', '18:00:00', '22:30:00', 'piscina las palmeras', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(25, 2, 20, 1153, NULL, '2025-03-23', '20:00:00', '00:00:00', 'recreo municipal', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(26, 2, 21, 1270, NULL, '2025-03-22', '21:00:00', '01:00:00', 'coco bongo', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(27, 2, 22, 1345, NULL, '2025-03-15', '23:00:00', '03:00:00', 'el aguaje', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(28, 2, 23, 1352, NULL, '2025-03-14', '22:00:00', '01:00:00', 'discoteca anubis boulevard la hacienda', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(29, 2, 24, 1225, NULL, '2025-03-09', '20:00:00', '04:00:00', '8 de marzo dia de la mujer', 'El día 8 de Marzo día de la Mujer desde las 8 pm hasta las 4 am', NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(30, 2, 25, 667, NULL, '2025-03-08', '23:00:00', '03:00:00', 'bailodromo', 'BAILODROMO de la Av. Tomas Valle #Mz E Lt 2 Urb El condor Callao..Callao', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(31, 2, 3, 546, NULL, '2025-03-02', '00:00:00', '00:00:00', 'punta sal', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(32, 2, 17, 1118, NULL, '2025-03-01', '00:00:00', '00:00:00', 'discoteca', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(33, 2, 2, 1568, NULL, '2025-02-16', '22:00:00', '02:00:00', 'coliseo cerrado huadalupe ruiz', NULL, NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(34, 3, 2, 1568, NULL, '2025-02-16', '18:00:00', '21:00:00', 'coliseo cerrado huadalupe', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(35, 2, 2, 1546, NULL, '2025-02-15', '18:00:00', '21:00:00', 'Calle Bolognesi', 'Calle Bolognesi', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(36, 3, 2, 1546, NULL, '2025-02-15', '21:00:00', '00:00:00', 'calle bolognesi', 'calle bolognesi', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(37, 2, 26, 1547, NULL, '2025-02-15', '00:00:00', '03:00:00', 'yunce rosado \"el progreso\"', 'san martin occidente', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(38, 4, 27, 1293, NULL, '2025-02-09', '17:00:00', '19:30:00', 'piscina las palmeras', 'el valle de anexo 22', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(39, 2, 28, 1338, NULL, '2025-02-09', '16:00:00', '19:00:00', 'piscina el paraiso', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(40, 2, 27, 1293, NULL, '2025-02-09', '20:00:00', '23:00:00', 'piscina las palmeras', 'el valle de anexo 22', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(41, 3, 29, 672, NULL, '2025-02-09', '19:00:00', '21:00:00', 'parasol', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(42, 2, 30, 672, NULL, '2025-02-08', '01:00:00', '04:00:00', 'arius disco', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(43, 2, 31, 1359, NULL, '2025-02-08', '21:00:00', '00:00:00', 'frontis municipalidad', 'feliz 63 aniversario, distrito lugar frontis municipalidad', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(44, 3, 31, 1359, NULL, '2025-02-08', '21:00:00', '00:00:00', 'frontis municipalidad', 'feliz 63 aniversario distrito lugar frontis municipalidad', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(45, 2, 32, 601, NULL, '2025-02-04', '21:00:00', '01:00:00', 'coliseo municipal', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(46, 2, 3, 1115, NULL, '2025-02-02', '15:00:00', '19:00:00', 'playa mal abrigo', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(47, 2, 33, 1563, NULL, '2025-02-01', '22:00:00', '02:00:00', 'calle cristobal', 'calle cristobal colon sin numero a la espalda del mercadillo', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(48, 2, 34, 1183, NULL, '2025-01-28', '00:00:00', '00:00:00', 'coliseo municipal de simbal', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(49, 2, 35, 672, NULL, '2025-01-26', '15:00:00', '19:00:00', 'centro recreacional parasol piscina', 'piscina', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(50, 3, 36, 1804, NULL, '2025-01-20', '21:00:00', '01:00:00', 'club libertad', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(51, 2, 2, 1535, NULL, '2025-01-19', '20:00:00', '00:00:00', 'club deportivo el caysa', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(52, 2, 2, 1537, NULL, '2025-01-19', '15:00:00', '19:00:00', 'calle 2 de mayo', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(53, 4, 37, 1345, NULL, '2025-01-19', '20:00:00', '02:00:00', 'aguaje', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(54, 2, 36, 1578, NULL, '2025-01-18', '21:00:00', '01:00:00', 'mz d1 el san sebastian', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(55, 2, 38, 1128, NULL, '2025-01-17', '23:00:00', '03:00:00', 'local casa vieja', '32 aniversario identica de chepen', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(56, 2, 39, 1570, NULL, '2025-01-13', '22:30:00', '02:30:00', 'fiesta patronal', 'gran fiesta patronal san francisco', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(57, 2, 17, 1203, NULL, '2025-01-12', '15:00:00', '19:00:00', 'playa lagunas mocupe', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(58, 2, 17, 1206, NULL, '2025-01-12', '21:00:00', '00:00:00', NULL, 'feliz aniversario santa rosa', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(59, 2, 40, 1263, NULL, '2025-01-10', '23:00:00', '03:00:00', 'estadio san luis', 'feliz 154 aniversario distrito san luis cañete', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(60, 2, 41, 1355, NULL, '2025-01-05', '21:00:00', '01:00:00', 'el mueble internacional', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(61, 2, 3, 1115, NULL, '2025-01-02', '20:00:00', '01:00:00', 'estadio municipal de chicama', 'Distrito de chicama celebrar 168 años de creación política Local Estadío Municipal de Chicama', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(62, 2, 42, 971, NULL, '2025-01-01', '22:00:00', '01:00:00', 'piscinazo bailable', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(63, 2, 43, 964, NULL, '2025-01-01', '18:30:00', '21:30:00', 'piscina club el tumi', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-04-16', 0, 31, 0, 0),
(65, 2, 44, 1327, '0011-2025', '2025-03-22', '23:00:00', '01:00:00', 'garden palace', NULL, NULL, 2, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(66, 5, 45, 1188, '0012-2025', '2025-03-22', '22:00:00', '00:00:00', NULL, 'cumpleaños sorpresa', NULL, 2, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(67, 2, 46, 672, '0013-2025', '2025-03-16', '16:00:00', '18:00:00', 'aquapark', 'aquapark/ventanilla', NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(68, 4, 47, 1104, '0014-2025', '2025-03-11', '00:00:00', '00:00:00', NULL, NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(69, 4, 48, 1707, '0015-2025', '2025-03-01', '21:00:00', '03:00:00', 'San martin de alao - C.P: Sinami', 'San martin de alao - C.P: Sinami', NULL, 2, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(70, 3, 49, 1345, '0016-2025', '2025-02-23', '00:00:00', '00:00:00', 'piscinazo el anden', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(71, 2, 50, 722, '0017-2025', '2025-02-23', '20:00:00', '23:00:00', 'oropeza cusco', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(72, 2, 51, 1793, '0018-2025', '2025-02-22', '22:00:00', '01:00:00', 'el local chololo - pocollay', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(73, 4, 52, 138, '0019-2025', '2025-02-21', '00:00:00', '00:00:00', NULL, NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(74, 4, 53, 1352, '0020-2025', '2025-02-16', '20:00:00', '22:00:00', 'villa de armas - zarate', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(75, 4, 54, 1293, '0021-2025', '2025-02-16', '00:00:00', '00:00:00', 'club el padrino', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(76, 4, 55, 1015, '0022-2025', '2025-02-15', '00:00:00', '00:00:00', NULL, NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(77, 4, 56, 1034, '0023-2025', '2025-02-15', '00:00:00', '00:00:00', 'local mil maravillas', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(78, 2, 57, 1167, '0024-2025', '2025-02-14', '22:00:00', '01:00:00', 'pedregal disco lounge', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(79, 4, 58, 1322, '0025-2025', '2025-02-14', '04:00:00', '06:00:00', 'local angaraes', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(80, 4, 58, 1355, '0026-2025', '2025-02-14', '23:00:00', '01:00:00', 'unicachi', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(81, 4, 58, 1352, '0027-2025', '2025-02-14', '20:00:00', '22:00:00', 'crucero del amor', 'estacion san carlos', NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(82, 4, 59, 910, '0028-2025', '2025-02-11', '22:00:00', '00:00:00', 'llata', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(83, 2, 60, 546, '0029-2025', '2025-02-10', '22:00:00', '01:00:00', 'cajabamba', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(84, 4, 61, 1331, '0030-2025', '2025-02-08', '01:00:00', '03:00:00', 'larcay', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(85, 2, 62, 214, '0031-2025', '2025-02-02', '00:30:00', '03:30:00', 'discoteca explanada beta disco', NULL, NULL, 2, 2, 1, 7, 0, 1, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(86, 4, 58, 1352, '0032-2025', '2025-01-25', '00:00:00', '00:00:00', 'crucero del amor', 'estacion san carlos', NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(87, 2, 37, 1338, '0033-2025', '2025-01-25', '03:00:00', '04:00:00', 'local mia club', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(88, 4, 63, 1062, '0034-2025', '2025-01-22', '01:00:00', '03:00:00', 'local cour de basket', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(89, 4, 64, 1331, '0035-2025', '2025-01-18', '23:30:00', '00:00:00', 'local ilarcay', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(90, 4, 65, 824, '0036-2025', '2025-01-14', '23:00:00', '02:00:00', 'local plaza principal de paucara', 'plaza principal de paucara', NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(91, 4, 66, 1034, '0037-2025', '2025-01-12', '00:30:00', '03:00:00', 'aniversario artista sunqucha', 'aniversario artista sunqucha', NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(92, 4, 1, 1490, '0038-2025', '2025-01-11', '21:00:00', '23:00:00', '69 aniversario santa ana de tusi', '69 aniversario santa ana de tusi', NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(93, 2, 67, 1345, '0039-2025', '2025-01-05', '03:40:00', '05:40:00', 'piscina chepita royer', 'changrila', NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(94, 4, 68, 824, '0040-2025', '2025-01-02', '21:30:00', '00:30:00', 'villa san francisco', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-21', 0, 31, 0, 0),
(95, 3, 9, 1104, '0041-2025', '2025-05-01', '23:00:00', '03:00:00', 'Centro poblado Santa filomena', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-04-25', 0, 31, 0, 0),
(96, 2, 69, 1557, NULL, '2025-05-04', '23:00:00', '03:00:00', 'salsa de la cumbia', NULL, NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-04-25', 0, 31, 0, 0),
(97, 8, 70, 1214, NULL, '2025-04-30', '22:00:00', '03:00:00', 'Local de la Institución Educativa Antoni Raimondi de Saltur', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(98, 8, 71, 1183, '0042-2025', '2025-05-01', '18:00:00', '21:00:00', 'Explanada de Huanchaco', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(99, 8, 72, 214, NULL, '2025-05-01', '00:00:00', '04:00:00', 'beta disco lounge', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(100, 8, 73, 1, NULL, '2025-05-02', '22:00:00', '02:00:00', 'discoteca la hacienda', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(101, 8, 74, 625, NULL, '2025-05-03', '22:00:00', '02:00:00', 'Paramo Centro Recreacional', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(102, 8, 75, 1701, NULL, '2025-05-04', '15:00:00', '18:00:00', 'La Choza CutervinaMedio Dia', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(103, 8, 76, 78, NULL, '2025-05-04', '20:00:00', '00:00:00', 'Discoteca La Hacienda Noche', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(104, 8, 77, 1183, NULL, '2025-05-09', '21:00:00', '01:00:00', 'el barco primer turno', NULL, NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(112, 8, 85, 1557, NULL, '2025-05-12', '22:00:00', '02:00:00', 'la casa de la cumbia', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(113, 2, 86, 1335, NULL, '2025-05-17', '19:00:00', '03:00:00', 'Estadio Municipal Mi Perú', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(117, 8, 88, 1183, '0044-2025', '2025-05-21', '19:00:00', '03:00:00', 'oceania (segundo turno)', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-05', 0, 31, 0, 0),
(118, 8, 89, NULL, '0045-2025', '2025-05-16', '19:00:00', '03:00:00', 'montevideo', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-07', 1, 35, 0, 0),
(119, 3, 18, 1337, NULL, '2025-04-04', '00:30:00', '04:30:00', 'Yacumama', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-13', 0, 31, 0, 0),
(121, 8, 15, 964, NULL, '2025-05-18', '22:00:00', '02:00:00', 'discoteca 10 lukas', NULL, NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-05-13', 0, 31, 0, 0),
(123, 8, 91, 1183, '0046-2025', '2025-05-09', '02:00:00', '05:00:00', 'tabaco marino segundo turno', NULL, NULL, 1, 2, 1, 7, 0, 1, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(124, 23, 92, 1034, '0047-2025', '2025-05-10', '21:00:00', '03:00:00', 'san juan de jarpa', 'matrimonio', NULL, 2, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(125, 3, 93, 1775, '0048-2025', '2025-05-11', '17:00:00', '19:00:00', 'safari peña', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(126, 8, 94, 1183, '0049-2025', '2025-05-11', '23:30:00', '00:45:00', 'discoteca dali', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(127, 8, 91, 1184, '0050-2025', '2025-05-11', '01:00:00', '04:00:00', 'ramada de el meche', NULL, NULL, 1, 2, 1, 7, 0, 1, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(128, 23, 95, 1034, '0051-2025', '2025-05-11', '23:00:00', '03:00:00', 'centro de convenciones \"el chulcas\"', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(129, 2, 96, 359, NULL, '2025-05-15', '20:00:00', '01:00:00', 'complejos municipal', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(130, 5, 97, 673, NULL, '2025-05-17', '17:30:00', '19:00:00', 'estadio municipal de mi peru', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(131, 23, 98, 673, NULL, '2025-05-17', '19:15:00', '20:30:00', 'estadio municipal de mi peru', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(132, 8, 99, 673, NULL, '2025-05-17', '00:30:00', '02:30:00', 'estadio municipal de mi peru', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(133, 8, 100, 1331, NULL, '2025-05-17', '00:00:00', '00:00:00', 'huaira', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(134, 23, 91, 1355, NULL, '2025-05-17', '19:00:00', '08:30:00', 'la jarana vip - ex banana fish', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(135, 3, 101, 1355, NULL, '2025-05-17', '07:00:00', '09:00:00', 'la jarana vip - ex banana fish', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(136, 8, 3, 1118, NULL, '2025-05-24', '21:00:00', '00:00:00', 'DISCOTECA RUMVA', NULL, NULL, 1, 1, 1, NULL, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(137, 8, 91, 1183, '0052-2025', '2025-05-24', '01:00:00', '04:00:00', 'tabaco marino', NULL, NULL, 1, 2, 1, 7, 0, 1, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(138, 23, 102, 1104, '0053-2025', '2025-05-25', '23:00:00', '03:00:00', 'recepciones marcelita muruhuay', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(139, 3, 103, 1197, NULL, '2025-05-25', '20:15:00', '22:15:00', 'aventura disco', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 3, '2025-05-19', 0, 31, 0, 0),
(140, 8, 103, 1197, NULL, '2025-05-25', '22:30:00', '00:20:00', 'aventura disco', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 3, '2025-05-19', 0, 31, 0, 0),
(141, 2, 103, 1197, NULL, '2025-05-25', '00:30:00', '03:30:00', 'aventura disco', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 3, '2025-05-19', 0, 31, 0, 0),
(142, 8, 91, 1314, '0054-2025', '2025-05-30', '00:00:00', '00:00:00', 'discoteca mambo', NULL, NULL, 1, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(143, 8, 2, 127, NULL, '2025-05-31', '00:00:00', '03:00:00', 'Palacio de la Cultura Lanzamiento Oficial en Casma', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-19', 0, 31, 0, 0),
(144, 8, 104, 1338, '0055-2025', '2025-05-31', '15:30:00', '17:30:00', 'evento privado', NULL, NULL, 2, 2, 1, 7, 0, 0, 1, 0, 1, '2025-05-19', 0, 31, 0, 0),
(145, 8, 1, 1322, NULL, '2025-05-25', '23:00:00', '01:00:00', 'DISCOTECA KENKO  STA CLARA', 'Real Plaza Santa Clara', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-21', 0, 31, 0, 0),
(146, 8, 1, 1335, NULL, '2025-05-26', '03:00:00', '05:00:00', 'Babylon Disco', 'Hospital Loayza', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-21', 0, 31, 0, 0),
(147, 3, 105, 673, NULL, '2025-05-07', '19:00:00', '03:00:00', 'Mi Peru Ventanilla', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-22', 0, 31, 0, 0),
(148, 3, 106, 1335, NULL, '2025-05-13', '19:00:00', '03:00:00', 'gira san martin', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-22', 0, 31, 0, 0),
(149, 3, 107, 1355, NULL, '2025-05-14', '19:00:00', '03:00:00', 'gira san martin', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-22', 0, 31, 0, 0),
(150, 3, 108, 1355, NULL, '2025-05-15', '19:00:00', '03:00:00', 'gira san martin', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-22', 0, 31, 0, 0),
(151, 8, 109, 1577, '0056-2025', '2025-06-06', '19:00:00', '22:00:00', 'talara', NULL, NULL, 2, 2, 1, 7, 0, 0, 0, 0, 1, '2025-05-22', 0, 31, 0, 0),
(152, 2, 110, 1338, NULL, '2025-05-24', '19:00:00', '03:00:00', 'la cascada', NULL, NULL, 1, 1, 1, 0, 0, 0, 0, 0, 1, '2025-05-26', 0, 31, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distritos`
--

CREATE TABLE `distritos` (
  `iddistrito` int(11) NOT NULL,
  `idprovincia` int(11) NOT NULL,
  `distrito` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `distritos`
--

INSERT INTO `distritos` (`iddistrito`, `idprovincia`, `distrito`) VALUES
(1, 1, 'Bagua'),
(2, 1, 'Aramango'),
(3, 1, 'Copallín'),
(4, 1, 'El Parco'),
(5, 1, 'Imaza'),
(6, 1, 'La Peca'),
(7, 2, 'Jumbilla'),
(8, 2, 'Chisquilla'),
(9, 2, 'Churuja'),
(10, 2, 'Corosha'),
(11, 2, 'Cuispes'),
(12, 2, 'Florida'),
(13, 2, 'Jazán'),
(14, 2, 'Recta'),
(15, 2, 'San Carlos'),
(16, 2, 'Shipasbamba'),
(17, 2, 'Valera'),
(18, 2, 'Yambrasbamba'),
(19, 3, 'Chachapoyas'),
(20, 3, 'Asunción'),
(21, 3, 'Balsas'),
(22, 3, 'Cheto'),
(23, 3, 'Chiliquin'),
(24, 3, 'Chuquibamba'),
(25, 3, 'Granada'),
(26, 3, 'Huancas'),
(27, 3, 'La Jalca'),
(28, 3, 'Leimebamba'),
(29, 3, 'Levanto'),
(30, 3, 'Magdalena'),
(31, 3, 'Mariscal Castilla'),
(32, 3, 'Molinopampa'),
(33, 3, 'Montevideo'),
(34, 3, 'Olleros'),
(35, 3, 'Quinjalca'),
(36, 3, 'San Francisco de Daguas'),
(37, 3, 'San Isidro de Maino'),
(38, 3, 'Soloco'),
(39, 3, 'Sonche'),
(40, 4, 'Santa María de Nieva'),
(41, 4, 'El Cenepa'),
(42, 4, 'Río Santiago'),
(43, 5, 'Lamud'),
(44, 5, 'Camporredondo'),
(45, 5, 'Cocabamba'),
(46, 5, 'Colcamar'),
(47, 5, 'Conila'),
(48, 5, 'Inguilpata'),
(49, 5, 'Longuita'),
(50, 5, 'Lonya Chico'),
(51, 5, 'Luya'),
(52, 5, 'Luya Viejo'),
(53, 5, 'María'),
(54, 5, 'Ocalli'),
(55, 5, 'Ocumal'),
(56, 5, 'Pisuquía'),
(57, 5, 'Providencia'),
(58, 5, 'San Cristóbal'),
(59, 5, 'San Francisco del Yeso'),
(60, 5, 'San Jerónimo'),
(61, 5, 'San Juan de Lopecancha'),
(62, 5, 'Santa Catalina'),
(63, 5, 'Santo Tomás'),
(64, 5, 'Tingo'),
(65, 5, 'Trita'),
(66, 6, 'San Nicolás'),
(67, 6, 'Chirimoto'),
(68, 6, 'Cochamal'),
(69, 6, 'Huambo'),
(70, 6, 'Limabamba'),
(71, 6, 'Longar'),
(72, 6, 'Mariscal Benavides'),
(73, 6, 'Milpuc'),
(74, 6, 'Omia'),
(75, 6, 'Santa Rosa'),
(76, 6, 'Totora'),
(77, 6, 'Vista Alegre'),
(78, 7, 'Bagua Grande'),
(79, 7, 'Cajaruro'),
(80, 7, 'Cumba'),
(81, 7, 'El Milagro'),
(82, 7, 'Jamalca'),
(83, 7, 'Lonya Grande'),
(84, 7, 'Yamón'),
(85, 8, 'Aija'),
(86, 8, 'Coris'),
(87, 8, 'Huacllan'),
(88, 8, 'La Merced'),
(89, 8, 'Succha'),
(90, 9, 'Llamellín'),
(91, 9, 'Aczo'),
(92, 9, 'Chaccho'),
(93, 9, 'Chingas'),
(94, 9, 'Mirgas'),
(95, 9, 'San Juan de Rontoy'),
(96, 10, 'Chacas'),
(97, 10, 'Acochaca'),
(98, 11, 'Chiquián'),
(99, 11, 'Abelardo Pardo Lezameta'),
(100, 11, 'Antonio Raymondi'),
(101, 11, 'Aquia'),
(102, 11, 'Cajacay'),
(103, 11, 'Canis'),
(104, 11, 'Colquioc'),
(105, 11, 'Huallanca'),
(106, 11, 'Huasta'),
(107, 11, 'Huayllacayan'),
(108, 11, 'La Primavera'),
(109, 11, 'Mangas'),
(110, 11, 'Pacllon'),
(111, 11, 'San Miguel de Corpanqui'),
(112, 11, 'Ticllos'),
(113, 12, 'Carhuaz'),
(114, 12, 'Acopampa'),
(115, 12, 'Amashca'),
(116, 12, 'Anta'),
(117, 12, 'Ataquero'),
(118, 12, 'Marcara'),
(119, 12, 'Pariahuanca'),
(120, 12, 'San Miguel de Aco'),
(121, 12, 'Shilla'),
(122, 12, 'Tinco'),
(123, 12, 'Yungar'),
(124, 13, 'San Luis'),
(125, 13, 'San Nicolás'),
(126, 13, 'Yauya'),
(127, 14, 'Casma'),
(128, 14, 'Buena Vista Alta'),
(129, 14, 'Comandante Noel'),
(130, 14, 'Yautan'),
(131, 15, 'Corongo'),
(132, 15, 'Aco'),
(133, 15, 'Bambas'),
(134, 15, 'Cusca'),
(135, 15, 'La Pampa'),
(136, 15, 'Yanac'),
(137, 15, 'Yupan'),
(138, 16, 'Huaraz'),
(139, 16, 'Cochabamba'),
(140, 16, 'Colcabamba'),
(141, 16, 'Huanchay'),
(142, 16, 'Independencia'),
(143, 16, 'Jangas'),
(144, 16, 'La Libertad'),
(145, 16, 'Olleros'),
(146, 16, 'Pampas'),
(147, 16, 'Pariacoto'),
(148, 16, 'Pira'),
(149, 16, 'Tarica'),
(150, 17, 'Huari'),
(151, 17, 'Anra'),
(152, 17, 'Cajay'),
(153, 17, 'Chavin de Huantar'),
(154, 17, 'Huacachi'),
(155, 17, 'Huacchis'),
(156, 17, 'Huachis'),
(157, 17, 'Huantar'),
(158, 17, 'Masin'),
(159, 17, 'Paucas'),
(160, 17, 'Ponto'),
(161, 17, 'Rahuapampa'),
(162, 17, 'Rapayan'),
(163, 17, 'San Marcos'),
(164, 17, 'San Pedro de Chana'),
(165, 17, 'Uco'),
(166, 18, 'Huarmey'),
(167, 18, 'Cochapeti'),
(168, 18, 'Culebras'),
(169, 18, 'Huayan'),
(170, 18, 'Malvas'),
(171, 19, 'Piscobamba'),
(172, 19, 'Casca'),
(173, 19, 'Eleazar Guzmán Barrón'),
(174, 19, 'Fidel Olivas Escudero'),
(175, 19, 'Llama'),
(176, 19, 'Llumpa'),
(177, 19, 'Lucma'),
(178, 19, 'Musga'),
(179, 20, 'Ocros'),
(180, 20, 'Acas'),
(181, 20, 'Cajamarquilla'),
(182, 20, 'Carhuapampa'),
(183, 20, 'Cochas'),
(184, 20, 'Congas'),
(185, 20, 'Llipa'),
(186, 20, 'San Cristóbal de Rajan'),
(187, 20, 'San Pedro'),
(188, 20, 'Santiago de Chilcas'),
(189, 21, 'Cabana'),
(190, 21, 'Bolognesi'),
(191, 21, 'Conchucos'),
(192, 21, 'Huacaschuque'),
(193, 21, 'Huandoval'),
(194, 21, 'Lacabamba'),
(195, 21, 'Llapo'),
(196, 21, 'Pallasca'),
(197, 21, 'Pampas'),
(198, 21, 'Santa Rosa'),
(199, 21, 'Tauca'),
(200, 22, 'Pomabamba'),
(201, 22, 'Huayllan'),
(202, 22, 'Parobamba'),
(203, 22, 'Quinuabamba'),
(204, 23, 'Recuay'),
(205, 23, 'Catac'),
(206, 23, 'Cotaparaco'),
(207, 23, 'Huayllapampa'),
(208, 23, 'Llacllin'),
(209, 23, 'Marca'),
(210, 23, 'Pampas Chico'),
(211, 23, 'Pararin'),
(212, 23, 'Tapacocha'),
(213, 23, 'Ticapampa'),
(214, 24, 'Chimbote'),
(215, 24, 'Cáceres del Perú'),
(216, 24, 'Coishco'),
(217, 24, 'Macate'),
(218, 24, 'Moro'),
(219, 24, 'Nepeña'),
(220, 24, 'Samanco'),
(221, 24, 'Santa'),
(222, 24, 'Nuevo Chimbote'),
(223, 25, 'Sihuas'),
(224, 25, 'Acobamba'),
(225, 25, 'Alfonso Ugarte'),
(226, 25, 'Cashapampa'),
(227, 25, 'Chingalpo'),
(228, 25, 'Huayllabamba'),
(229, 25, 'Quiches'),
(230, 25, 'Ragash'),
(231, 25, 'San Juan'),
(232, 25, 'Sicsibamba'),
(233, 26, 'Yungay'),
(234, 26, 'Cascapara'),
(235, 26, 'Mancos'),
(236, 26, 'Matacoto'),
(237, 26, 'Quillo'),
(238, 26, 'Ranrahirca'),
(239, 26, 'Shupluy'),
(240, 26, 'Yanama'),
(241, 27, 'Abancay'),
(242, 27, 'Chacoche'),
(243, 27, 'Circa'),
(244, 27, 'Curahuasi'),
(245, 27, 'Huanipaca'),
(246, 27, 'Lambrama'),
(247, 27, 'Pichirhua'),
(248, 27, 'San Pedro de Cachora'),
(249, 27, 'Tamburco'),
(250, 28, 'Andahuaylas'),
(251, 28, 'Andarapa'),
(252, 28, 'Chiara'),
(253, 28, 'Huancarama'),
(254, 28, 'Huancaray'),
(255, 28, 'Huayana'),
(256, 28, 'José María Arguedas'),
(257, 28, 'Kaquiabamba'),
(258, 28, 'Kishuara'),
(259, 28, 'Pacobamba'),
(260, 28, 'Pacucha'),
(261, 28, 'Pampachiri'),
(262, 28, 'Pomacocha'),
(263, 28, 'San Antonio de Cachi'),
(264, 28, 'San Jerónimo'),
(265, 28, 'San Miguel de Chaccrampa'),
(266, 28, 'Santa María de Chicmo'),
(267, 28, 'Talavera'),
(268, 28, 'Tumay Huaraca'),
(269, 28, 'Turpo'),
(270, 29, 'Antabamba'),
(271, 29, 'El Oro'),
(272, 29, 'Huaquirca'),
(273, 29, 'Juan Espinoza Medrano'),
(274, 29, 'Oropesa'),
(275, 29, 'Pachaconas'),
(276, 29, 'Sabaino'),
(277, 30, 'Chalhuanca'),
(278, 30, 'Capaya'),
(279, 30, 'Caraybamba'),
(280, 30, 'Chapimarca'),
(281, 30, 'Colcabamba'),
(282, 30, 'Cotaruse'),
(283, 30, 'Ihuayllo'),
(284, 30, 'Justo Apu Sahuaraura'),
(285, 30, 'Lucre'),
(286, 30, 'Pocohuanca'),
(287, 30, 'San Juan de Chacña'),
(288, 30, 'Sañayca'),
(289, 30, 'Soraya'),
(290, 30, 'Tapairihua'),
(291, 30, 'Tintay'),
(292, 30, 'Toraya'),
(293, 30, 'Yanaca'),
(294, 31, 'Tambobamba'),
(295, 31, 'Cotabambas'),
(296, 31, 'Coyllurqui'),
(297, 31, 'Haquira'),
(298, 31, 'Mara'),
(299, 31, 'Challhuahuacho'),
(300, 32, 'Chincheros'),
(301, 32, 'Anco-Huallo'),
(302, 32, 'Cocharcas'),
(303, 32, 'Huaccana'),
(304, 32, 'Ocobamba'),
(305, 32, 'Ongoy'),
(306, 32, 'Uranmarca'),
(307, 32, 'Ranracancha'),
(308, 32, 'Rocchacc'),
(309, 33, 'Chuquibambilla'),
(310, 33, 'Curpahuasi'),
(311, 33, 'Gamarra'),
(312, 33, 'Huayllati'),
(313, 33, 'Mamara'),
(314, 33, 'Micaela Bastidas'),
(315, 33, 'Pataypampa'),
(316, 33, 'Progreso'),
(317, 33, 'San Antonio'),
(318, 33, 'Santa Rosa'),
(319, 33, 'Turpay'),
(320, 33, 'Vilcabamba'),
(321, 33, 'Virundo'),
(322, 33, 'Curasco'),
(323, 34, 'Arequipa'),
(324, 34, 'Alto Selva Alegre'),
(325, 34, 'Cayma'),
(326, 34, 'Cerro Colorado'),
(327, 34, 'Characato'),
(328, 34, 'Chiguata'),
(329, 34, 'Jacobo Hunter'),
(330, 34, 'La Joya'),
(331, 34, 'Mariano Melgar'),
(332, 34, 'Miraflores'),
(333, 34, 'Mollebaya'),
(334, 34, 'Paucarpata'),
(335, 34, 'Pocsi'),
(336, 34, 'Polobaya'),
(337, 34, 'Quequeña'),
(338, 34, 'Sabandía'),
(339, 34, 'Sachaca'),
(340, 34, 'San Juan de Siguas'),
(341, 34, 'San Juan de Tarucani'),
(342, 34, 'Santa Isabel de Siguas'),
(343, 34, 'Santa Rita de Siguas'),
(344, 34, 'Socabaya'),
(345, 34, 'Tiabaya'),
(346, 34, 'Uchumayo'),
(347, 34, 'Vitor'),
(348, 34, 'Yanahuara'),
(349, 34, 'Yarabamba'),
(350, 34, 'Yura'),
(351, 35, 'Camaná'),
(352, 35, 'José María Quimper'),
(353, 35, 'Mariano Nicolás Valcárcel'),
(354, 35, 'Mariscal Cáceres'),
(355, 35, 'Nicolás de Piérola'),
(356, 35, 'Ocoña'),
(357, 35, 'Quilca'),
(358, 35, 'Samuel Pastor'),
(359, 36, 'Caravelí'),
(360, 36, 'Acarí'),
(361, 36, 'Atico'),
(362, 36, 'Atiquipa'),
(363, 36, 'Bella Unión'),
(364, 36, 'Cahuacho'),
(365, 36, 'Chala'),
(366, 36, 'Chaparra'),
(367, 36, 'Huanuhuanu'),
(368, 36, 'Jaqui'),
(369, 36, 'Lomas'),
(370, 36, 'Quicacha'),
(371, 36, 'Yauca'),
(372, 37, 'Aplao'),
(373, 37, 'Andagua'),
(374, 37, 'Ayo'),
(375, 37, 'Chachas'),
(376, 37, 'Chilcaymarca'),
(377, 37, 'Choco'),
(378, 37, 'Huancarqui'),
(379, 37, 'Machaguay'),
(380, 37, 'Orcopampa'),
(381, 37, 'Pampacolca'),
(382, 37, 'Tipán'),
(383, 37, 'Uñón'),
(384, 37, 'Uraca'),
(385, 37, 'Viraco'),
(386, 38, 'Chivay'),
(387, 38, 'Achoma'),
(388, 38, 'Cabanaconde'),
(389, 38, 'Callalli'),
(390, 38, 'Caylloma'),
(391, 38, 'Coporaque'),
(392, 38, 'Huambo'),
(393, 38, 'Huanca'),
(394, 38, 'Ichupampa'),
(395, 38, 'Lari'),
(396, 38, 'Lluta'),
(397, 38, 'Maca'),
(398, 38, 'Madrigal'),
(399, 38, 'San Antonio de Chuca'),
(400, 38, 'Sibayo'),
(401, 38, 'Tapay'),
(402, 38, 'Tisco'),
(403, 38, 'Tuti'),
(404, 38, 'Yanque'),
(405, 39, 'Chuquibamba'),
(406, 39, 'Andaray'),
(407, 39, 'Cayarani'),
(408, 39, 'Chichas'),
(409, 39, 'Iray'),
(410, 39, 'Río Grande'),
(411, 39, 'Salamanca'),
(412, 39, 'Yanaquihua'),
(413, 40, 'Mollendo'),
(414, 40, 'Cocachacra'),
(415, 40, 'Dean Valdivia'),
(416, 40, 'Islay'),
(417, 40, 'Mejía'),
(418, 40, 'Punta de Bombón'),
(419, 41, 'Cotahuasi'),
(420, 41, 'Alca'),
(421, 41, 'Charcana'),
(422, 41, 'Huaynacotas'),
(423, 41, 'Pampamarca'),
(424, 41, 'Puyca'),
(425, 41, 'Quechualla'),
(426, 41, 'Sayla'),
(427, 41, 'Tauría'),
(428, 41, 'Tomepampa'),
(429, 41, 'Toro'),
(430, 42, 'Cangallo'),
(431, 42, 'Chuschi'),
(432, 42, 'Los Morochucos'),
(433, 42, 'María Parado de Bellido'),
(434, 42, 'Paras'),
(435, 42, 'Totos'),
(436, 43, 'Ayacucho'),
(437, 43, 'Acocro'),
(438, 43, 'Acos Vinchos'),
(439, 43, 'Carmen Alto'),
(440, 43, 'Chiara'),
(441, 43, 'Jesús Nazareno'),
(442, 43, 'Ocros'),
(443, 43, 'Pacaycasa'),
(444, 43, 'Quinua'),
(445, 43, 'San José de Ticllas'),
(446, 43, 'San Juan Bautista'),
(447, 43, 'Santiago de Pischa'),
(448, 43, 'Socos'),
(449, 43, 'Tambillo'),
(450, 43, 'Vinchos'),
(451, 43, 'Andrés Avelino Cáceres Dorregaray'),
(452, 44, 'Sancos'),
(453, 44, 'Carapo'),
(454, 44, 'Sacsamarca'),
(455, 44, 'Santiago de Lucanamarca'),
(456, 45, 'Huanta'),
(457, 45, 'Ayahuanco'),
(458, 45, 'Huamanguilla'),
(459, 45, 'Iguain'),
(460, 45, 'Luricocha'),
(461, 45, 'Santillana'),
(462, 45, 'Sivia'),
(463, 45, 'Llochegua'),
(464, 45, 'Canayre'),
(465, 45, 'Uchuraccay'),
(466, 45, 'Pucacolpa'),
(467, 46, 'San Miguel'),
(468, 46, 'Anco'),
(469, 46, 'Ayna'),
(470, 46, 'Chilcas'),
(471, 46, 'Chungui'),
(472, 46, 'Luis Carranza'),
(473, 46, 'Santa Rosa'),
(474, 46, 'Tambo'),
(475, 46, 'Samugari'),
(476, 46, 'Anchihuay'),
(477, 47, 'Puquio'),
(478, 47, 'Aucara'),
(479, 47, 'Cabana'),
(480, 47, 'Carmen Salcedo'),
(481, 47, 'Chaviña'),
(482, 47, 'Chipao'),
(483, 47, 'Huac-Huas'),
(484, 47, 'Laramate'),
(485, 47, 'Leoncio Prado'),
(486, 47, 'Llauta'),
(487, 47, 'Lucanas'),
(488, 47, 'Ocaña'),
(489, 47, 'Otoca'),
(490, 47, 'Saisa'),
(491, 47, 'San Cristóbal'),
(492, 47, 'San Juan'),
(493, 47, 'San Pedro'),
(494, 47, 'San Pedro de Palco'),
(495, 47, 'Sancos'),
(496, 47, 'Santa Ana de Huaycahuacho'),
(497, 48, 'Coracora'),
(498, 48, 'Chumpi'),
(499, 48, 'Coronel Castañeda'),
(500, 48, 'Pacapausa'),
(501, 48, 'Pullo'),
(502, 48, 'Puyusca'),
(503, 48, 'San Francisco de Ravacayco'),
(504, 48, 'Upahuacho'),
(505, 49, 'Pausa'),
(506, 49, 'Colta'),
(507, 49, 'Corculla'),
(508, 49, 'Lampa'),
(509, 49, 'Marcabamba'),
(510, 49, 'Oyolo'),
(511, 49, 'Pararca'),
(512, 49, 'San Javier de Alpabamba'),
(513, 49, 'San José de Ushua'),
(514, 49, 'Sara Sara'),
(515, 50, 'Querobamba'),
(516, 50, 'Belén'),
(517, 50, 'Chalcos'),
(518, 50, 'San Pedro de Larcay'),
(519, 50, 'San Salvador de Quije'),
(520, 50, 'Santiago de Paucaray'),
(521, 50, 'Soras'),
(522, 51, 'Huancapi'),
(523, 51, 'Alcamenca'),
(524, 51, 'Apongo'),
(525, 51, 'Asquipata'),
(526, 51, 'Canaria'),
(527, 51, 'Cayara'),
(528, 51, 'Colca'),
(529, 51, 'Huamanquiquia'),
(530, 51, 'Huancaraylla'),
(531, 51, 'Huaya'),
(532, 51, 'Sarhua'),
(533, 51, 'Vilcanchos'),
(534, 52, 'Vilcas Huamán'),
(535, 52, 'Accomarca'),
(536, 52, 'Carhuanca'),
(537, 52, 'Concepción'),
(538, 52, 'Huambalpa'),
(539, 52, 'Independencia'),
(540, 52, 'Saurama'),
(541, 52, 'Vischongo'),
(542, 53, 'Cajabamba'),
(543, 53, 'Cachachi'),
(544, 53, 'Condebamba'),
(545, 53, 'Sitacocha'),
(546, 54, 'Cajamarca'),
(547, 54, 'Asunción'),
(548, 54, 'Chetilla'),
(549, 54, 'Cospán'),
(550, 54, 'Jesús'),
(551, 54, 'Los Baños del Inca'),
(552, 54, 'Magdalena'),
(553, 54, 'Matara'),
(554, 54, 'Namora'),
(555, 54, 'San Juan'),
(556, 55, 'Celendín'),
(557, 55, 'Chumuch'),
(558, 55, 'Cortegana'),
(559, 55, 'Huasmin'),
(560, 55, 'Jorge Chávez'),
(561, 55, 'José Gálvez'),
(562, 55, 'Miguel Iglesias'),
(563, 55, 'Oxamarca'),
(564, 55, 'Sorochuco'),
(565, 55, 'Sucre'),
(566, 55, 'Utco'),
(567, 55, 'La Libertad de Pallán'),
(568, 56, 'Chota'),
(569, 56, 'Anguía'),
(570, 56, 'Chadin'),
(571, 56, 'Chiguirip'),
(572, 56, 'Chimban'),
(573, 56, 'Choropampa'),
(574, 56, 'Cochabamba'),
(575, 56, 'Conchán'),
(576, 56, 'Huambos'),
(577, 56, 'Lajas'),
(578, 56, 'Llama'),
(579, 56, 'Miracosta'),
(580, 56, 'Paccha'),
(581, 56, 'Pion'),
(582, 56, 'Querocoto'),
(583, 56, 'San Juan de Licupis'),
(584, 56, 'Tacabamba'),
(585, 56, 'Tocmoche'),
(586, 56, 'Chalamarca'),
(587, 57, 'Contumazá'),
(588, 57, 'Chilete'),
(589, 57, 'Cupisnique'),
(590, 57, 'Guzmango'),
(591, 57, 'San Benito'),
(592, 57, 'Santa Cruz de Toledo'),
(593, 57, 'Tantarica'),
(594, 57, 'Yonan'),
(595, 58, 'Cutervo'),
(596, 58, 'Callayuc'),
(597, 58, 'Choros'),
(598, 58, 'Cujillo'),
(599, 58, 'La Ramada'),
(600, 58, 'Pimpingos'),
(601, 58, 'Querocotillo'),
(602, 58, 'San Andrés de Cutervo'),
(603, 58, 'San Juan de Cutervo'),
(604, 58, 'San Luis de Lucma'),
(605, 58, 'Santa Cruz'),
(606, 58, 'Santo Domingo de la Capilla'),
(607, 58, 'Santo Tomás'),
(608, 58, 'Socota'),
(609, 58, 'Toribio Casanova'),
(610, 59, 'Bambamarca'),
(611, 59, 'Chugur'),
(612, 59, 'Hualgayoc'),
(613, 60, 'Jaén'),
(614, 60, 'Bellavista'),
(615, 60, 'Chontali'),
(616, 60, 'Colasay'),
(617, 60, 'Huabal'),
(618, 60, 'Las Pirias'),
(619, 60, 'Pomahuaca'),
(620, 60, 'Pucará'),
(621, 60, 'Sallique'),
(622, 60, 'San Felipe'),
(623, 60, 'San José del Alto'),
(624, 60, 'Santa Rosa'),
(625, 61, 'San Ignacio'),
(626, 61, 'Chirinos'),
(627, 61, 'Huarango'),
(628, 61, 'La Coipa'),
(629, 61, 'Namballe'),
(630, 61, 'San José de Lourdes'),
(631, 61, 'Tabaconas'),
(632, 62, 'Pedro Gálvez'),
(633, 62, 'Chancay'),
(634, 62, 'Eduardo Villanueva'),
(635, 62, 'Gregorio Pita'),
(636, 62, 'Ichocán'),
(637, 62, 'José Manuel Quiroz'),
(638, 62, 'José Sabogal'),
(639, 63, 'San Miguel'),
(640, 63, 'Bolívar'),
(641, 63, 'Calquis'),
(642, 63, 'Catilluc'),
(643, 63, 'El Prado'),
(644, 63, 'La Florida'),
(645, 63, 'Llapa'),
(646, 63, 'Nanchoc'),
(647, 63, 'Niepos'),
(648, 63, 'San Gregorio'),
(649, 63, 'San Silvestre de Cochan'),
(650, 63, 'Tongod'),
(651, 63, 'Unión Agua Blanca'),
(652, 64, 'San Pablo'),
(653, 64, 'San Bernardino'),
(654, 64, 'San Luis'),
(655, 64, 'Tumbadén'),
(656, 65, 'Santa Cruz'),
(657, 65, 'Andabamba'),
(658, 65, 'Catache'),
(659, 65, 'Chancaybaños'),
(660, 65, 'La Esperanza'),
(661, 65, 'Ninabamba'),
(662, 65, 'Pulán'),
(663, 65, 'Saucepampa'),
(664, 65, 'Sexi'),
(665, 65, 'Uticyacu'),
(666, 65, 'Yauyucan'),
(667, 66, 'Callao'),
(668, 66, 'Bellavista'),
(669, 66, 'Carmen de la Legua Reynoso'),
(670, 66, 'La Perla'),
(671, 66, 'La Punta'),
(672, 66, 'Ventanilla'),
(673, 66, 'Mi Perú'),
(674, 67, 'Acomayo'),
(675, 67, 'Acopia'),
(676, 67, 'Acos'),
(677, 67, 'Mosoc Llacta'),
(678, 67, 'Pomacanchi'),
(679, 67, 'Rondocan'),
(680, 67, 'Sangarará'),
(681, 68, 'Anta'),
(682, 68, 'Ancahuasi'),
(683, 68, 'Cachimayo'),
(684, 68, 'Chinchaypujio'),
(685, 68, 'Huarocondo'),
(686, 68, 'Limatambo'),
(687, 68, 'Mollepata'),
(688, 68, 'Pucyura'),
(689, 68, 'Zurite'),
(690, 69, 'Calca'),
(691, 69, 'Coya'),
(692, 69, 'Lamay'),
(693, 69, 'Lares'),
(694, 69, 'Pisac'),
(695, 69, 'San Salvador'),
(696, 69, 'Taray'),
(697, 69, 'Yanatile'),
(698, 70, 'Yanaoca'),
(699, 70, 'Checca'),
(700, 70, 'Kunturkanki'),
(701, 70, 'Langui'),
(702, 70, 'Layo'),
(703, 70, 'Pampamarca'),
(704, 70, 'Quehue'),
(705, 70, 'Tupac Amaru'),
(706, 71, 'Sicuani'),
(707, 71, 'Checacupe'),
(708, 71, 'Combapata'),
(709, 71, 'Marangani'),
(710, 71, 'Pitumarca'),
(711, 71, 'San Pablo'),
(712, 71, 'San Pedro'),
(713, 71, 'Tinta'),
(714, 72, 'Santo Tomás'),
(715, 72, 'Capacmarca'),
(716, 72, 'Chamaca'),
(717, 72, 'Colquemarca'),
(718, 72, 'Livitaca'),
(719, 72, 'Llusco'),
(720, 72, 'Quiñota'),
(721, 72, 'Velille'),
(722, 73, 'Cusco'),
(723, 73, 'Ccorca'),
(724, 73, 'Poroy'),
(725, 73, 'San Jerónimo'),
(726, 73, 'San Sebastián'),
(727, 73, 'Santiago'),
(728, 73, 'Saylla'),
(729, 73, 'Wanchaq'),
(730, 74, 'Espinar'),
(731, 74, 'Condoroma'),
(732, 74, 'Coporaque'),
(733, 74, 'Ocoruro'),
(734, 74, 'Pallpata'),
(735, 74, 'Pichigua'),
(736, 74, 'Suyckutambo'),
(737, 74, 'Alto Pichigua'),
(738, 75, 'Quillabamba'),
(739, 75, 'Echarati'),
(740, 75, 'Huayopata'),
(741, 75, 'Maranura'),
(742, 75, 'Ocobamba'),
(743, 75, 'Santa Ana'),
(744, 75, 'Santa Teresa'),
(745, 75, 'Vilcabamba'),
(746, 76, 'Paruro'),
(747, 76, 'Accha'),
(748, 76, 'Ccapi'),
(749, 76, 'Colcha'),
(750, 76, 'Huanoquite'),
(751, 76, 'Omacha'),
(752, 76, 'Paccaritambo'),
(753, 76, 'Pillpinto'),
(754, 76, 'Yaurisque'),
(755, 77, 'Paucartambo'),
(756, 77, 'Caicay'),
(757, 77, 'Challabamba'),
(758, 77, 'Colquepata'),
(759, 77, 'Huancarani'),
(760, 77, 'Kosñipata'),
(761, 78, 'Urcos'),
(762, 78, 'Andahuaylillas'),
(763, 78, 'Camanti'),
(764, 78, 'Ccarhuayo'),
(765, 78, 'Ccatca'),
(766, 78, 'Cusipata'),
(767, 78, 'Huaro'),
(768, 78, 'Lucre'),
(769, 78, 'Marcapata'),
(770, 78, 'Ocongate'),
(771, 78, 'Oropesa'),
(772, 78, 'Quiquijana'),
(773, 79, 'Urubamba'),
(774, 79, 'Chinchero'),
(775, 79, 'Huayllabamba'),
(776, 79, 'Machupicchu'),
(777, 79, 'Maras'),
(778, 79, 'Ollantaytambo'),
(779, 79, 'Yucay'),
(780, 80, 'Acobamba'),
(781, 80, 'Andabamba'),
(782, 80, 'Anta'),
(783, 80, 'Caja'),
(784, 80, 'Marcas'),
(785, 80, 'Paucara'),
(786, 80, 'Pomacocha'),
(787, 80, 'Rosario'),
(788, 81, 'Lircay'),
(789, 81, 'Anchonga'),
(790, 81, 'Callanmarca'),
(791, 81, 'Ccochaccasa'),
(792, 81, 'Chincho'),
(793, 81, 'Congalla'),
(794, 81, 'Huanca-Huanca'),
(795, 81, 'Huayllay Grande'),
(796, 81, 'Julcamarca'),
(797, 81, 'San Antonio de Antaparco'),
(798, 81, 'Santo Tomas de Pata'),
(799, 81, 'Secclla'),
(800, 82, 'Castrovirreyna'),
(801, 82, 'Arma'),
(802, 82, 'Aurahua'),
(803, 82, 'Capillas'),
(804, 82, 'Chupamarca'),
(805, 82, 'Cocas'),
(806, 82, 'Huachos'),
(807, 82, 'Huamatambo'),
(808, 82, 'Mollepampa'),
(809, 82, 'San Juan'),
(810, 82, 'Santa Ana'),
(811, 82, 'Tantara'),
(812, 82, 'Ticrapo'),
(813, 83, 'Churcampa'),
(814, 83, 'Anco'),
(815, 83, 'Chinchihuasi'),
(816, 83, 'El Carmen'),
(817, 83, 'La Merced'),
(818, 83, 'Locroja'),
(819, 83, 'Paucarbamba'),
(820, 83, 'San Miguel de Mayocc'),
(821, 83, 'San Pedro de Coris'),
(822, 83, 'Pachamarca'),
(823, 83, 'Cosme'),
(824, 84, 'Huancavelica'),
(825, 84, 'Acobambilla'),
(826, 84, 'Acoria'),
(827, 84, 'Conayca'),
(828, 84, 'Cuenca'),
(829, 84, 'Huachocolpa'),
(830, 84, 'Huayllahuara'),
(831, 84, 'Izcuchaca'),
(832, 84, 'Laria'),
(833, 84, 'Manta'),
(834, 84, 'Mariscal Cáceres'),
(835, 84, 'Moya'),
(836, 84, 'Nuevo Occoro'),
(837, 84, 'Palca'),
(838, 84, 'Pilchaca'),
(839, 84, 'Vilca'),
(840, 84, 'Yauli'),
(841, 84, 'Ascensión'),
(842, 85, 'Huaytará'),
(843, 85, 'Ayaví'),
(844, 85, 'Córdova'),
(845, 85, 'Huayacundo Arma'),
(846, 85, 'Laramarca'),
(847, 85, 'Ocoyo'),
(848, 85, 'Pilpichaca'),
(849, 85, 'Querco'),
(850, 85, 'Quito-Arma'),
(851, 85, 'San Antonio de Cusicancha'),
(852, 85, 'San Francisco de Sangayaico'),
(853, 85, 'San Isidro'),
(854, 85, 'Santiago de Chocorvos'),
(855, 85, 'Santiago de Quirahuara'),
(856, 85, 'Santo Domingo de Capillas'),
(857, 85, 'Tambo'),
(858, 86, 'Pampas'),
(859, 86, 'Acostambo'),
(860, 86, 'Acraquia'),
(861, 86, 'Ahuaycha'),
(862, 86, 'Colcabamba'),
(863, 86, 'Daniel Hernández'),
(864, 86, 'Huachocolpa'),
(865, 86, 'Huaribamba'),
(866, 86, 'Ñahuimpuquio'),
(867, 86, 'Pazos'),
(868, 86, 'Quishuar'),
(869, 86, 'Salcabamba'),
(870, 86, 'Salcahuasi'),
(871, 86, 'San Marcos de Rocchac'),
(872, 86, 'Surcubamba'),
(873, 86, 'Tintay Puncu'),
(874, 86, 'Quichuas'),
(875, 86, 'Andaymarca'),
(876, 86, 'Roble'),
(877, 86, 'Santiago de Tucuma'),
(878, 87, 'Ambo'),
(879, 87, 'Cayna'),
(880, 87, 'Colpas'),
(881, 87, 'Conchamarca'),
(882, 87, 'Huacar'),
(883, 87, 'San Francisco'),
(884, 87, 'San Rafael'),
(885, 87, 'Tomay Kichwa'),
(886, 88, 'La Unión'),
(887, 88, 'Chuquis'),
(888, 88, 'Marías'),
(889, 88, 'Pachas'),
(890, 88, 'Quivilla'),
(891, 88, 'Ripan'),
(892, 88, 'Shunqui'),
(893, 88, 'Sillapata'),
(894, 88, 'Yanas'),
(895, 89, 'Huacaybamba'),
(896, 89, 'Canchabamba'),
(897, 89, 'Cochabamba'),
(898, 89, 'Pinra'),
(899, 90, 'Llata'),
(900, 90, 'Arancay'),
(901, 90, 'Chavín de Pariarca'),
(902, 90, 'Jacas Grande'),
(903, 90, 'Jircan'),
(904, 90, 'Miraflores'),
(905, 90, 'Monzón'),
(906, 90, 'Punchao'),
(907, 90, 'Puños'),
(908, 90, 'Singa'),
(909, 90, 'Tantamayo'),
(910, 91, 'Huánuco'),
(911, 91, 'Amarilis'),
(912, 91, 'Chinchao'),
(913, 91, 'Churubamba'),
(914, 91, 'Margos'),
(915, 91, 'Quisqui (Kichki)'),
(916, 91, 'San Francisco de Cayrán'),
(917, 91, 'San Pedro de Chaulán'),
(918, 91, 'Santa María del Valle'),
(919, 91, 'Yarumayo'),
(920, 91, 'Pillco Marca'),
(921, 92, 'Jesús'),
(922, 92, 'Baños'),
(923, 92, 'Jivia'),
(924, 92, 'Queropalca'),
(925, 92, 'Rondos'),
(926, 92, 'San Francisco de Asís'),
(927, 92, 'San Miguel de Cauri'),
(928, 93, 'Rupa Rupa'),
(929, 93, 'Daniel Alomía Robles'),
(930, 93, 'Hermílio Valdizán'),
(931, 93, 'José Crespo y Castillo'),
(932, 93, 'Luyando'),
(933, 93, 'Mariano Dámaso Beraún'),
(934, 94, 'Huacrachuco'),
(935, 94, 'Cholon'),
(936, 94, 'San Buenaventura'),
(937, 95, 'Panao'),
(938, 95, 'Chaglla'),
(939, 95, 'Molino'),
(940, 95, 'Umari'),
(941, 96, 'Puerto Inca'),
(942, 96, 'Codo del Pozuzo'),
(943, 96, 'Honoria'),
(944, 96, 'Tournavista'),
(945, 96, 'Yuyapichis'),
(946, 97, 'Chavinillo'),
(947, 97, 'Cahuac'),
(948, 97, 'Chacabamba'),
(949, 97, 'Aparicio Pomares'),
(950, 97, 'Jacas Chico'),
(951, 97, 'Obas'),
(952, 97, 'Pampamarca'),
(953, 97, 'Choras'),
(954, 98, 'Alto Larán'),
(955, 98, 'Chincha Alta'),
(956, 98, 'Chincha Baja'),
(957, 98, 'El Carmen'),
(958, 98, 'Grocio Prado'),
(959, 98, 'Pueblo Nuevo'),
(960, 98, 'San Juan de Yanac'),
(961, 98, 'San Pedro de Huacarpana'),
(962, 98, 'Sunampe'),
(963, 98, 'Tambo de Mora'),
(964, 99, 'Ica'),
(965, 99, 'La Tinguiña'),
(966, 99, 'Los Aquijes'),
(967, 99, 'Ocucaje'),
(968, 99, 'Pachacútec'),
(969, 99, 'Parcona'),
(970, 99, 'Pueblo Nuevo'),
(971, 99, 'Salas'),
(972, 99, 'San José de los Molinos'),
(973, 99, 'San Juan Bautista'),
(974, 99, 'Santiago'),
(975, 99, 'Tate'),
(976, 99, 'Yauca del Rosario'),
(977, 100, 'Changuillo'),
(978, 100, 'El Ingenio'),
(979, 100, 'Marcona'),
(980, 100, 'Nazca'),
(981, 100, 'Vista Alegre'),
(982, 101, 'Llipata'),
(983, 101, 'Palpa'),
(984, 101, 'Río Grande'),
(985, 101, 'Santa Cruz'),
(986, 101, 'Tibillo'),
(987, 102, 'Huancano'),
(988, 102, 'Humay'),
(989, 102, 'Independencia'),
(990, 102, 'Paracas'),
(991, 102, 'Pisco'),
(992, 102, 'San Andrés'),
(993, 102, 'San Clemente'),
(994, 102, 'Túpac Amaru Inca'),
(995, 103, 'Chanchamayo'),
(996, 103, 'Perene'),
(997, 103, 'Pichanaqui'),
(998, 103, 'San Luis de Shuaro'),
(999, 103, 'San Ramón'),
(1000, 103, 'Vitoc'),
(1001, 104, 'Ahuac'),
(1002, 104, 'Chongos Bajo'),
(1003, 104, 'Chupaca'),
(1004, 104, 'Huachac'),
(1005, 104, 'Huamancaca Chico'),
(1006, 104, 'San Juan de Iscos'),
(1007, 104, 'San Juan de Jarpa'),
(1008, 104, 'Tres de Diciembre'),
(1009, 104, 'Yanacancha'),
(1010, 105, 'Aco'),
(1011, 105, 'Andamarca'),
(1012, 105, 'Chambara'),
(1013, 105, 'Cochas'),
(1014, 105, 'Comas'),
(1015, 105, 'Concepción'),
(1016, 105, 'Heroínas Toledo'),
(1017, 105, 'Manzanares'),
(1018, 105, 'Mariscal Castilla'),
(1019, 105, 'Matahuasi'),
(1020, 105, 'Mito'),
(1021, 105, 'Nueve de Julio'),
(1022, 105, 'Orcotuna'),
(1023, 105, 'San José de Quero'),
(1024, 105, 'Santa Rosa de Ocopa'),
(1025, 106, 'Carhuacallanga'),
(1026, 106, 'Chacapampa'),
(1027, 106, 'Chicche'),
(1028, 106, 'Chilca'),
(1029, 106, 'Chongos Alto'),
(1030, 106, 'Chupuro'),
(1031, 106, 'Colca'),
(1032, 106, 'Cullhuas'),
(1033, 106, 'El Tambo'),
(1034, 106, 'Huancayo'),
(1035, 106, 'Huacrapuquio'),
(1036, 106, 'Hualhuas'),
(1037, 106, 'Huancan'),
(1038, 106, 'Huasicancha'),
(1039, 106, 'Huayucachi'),
(1040, 106, 'Ingenio'),
(1041, 106, 'Pariahuanca'),
(1042, 106, 'Pilcomayo'),
(1043, 106, 'Pucara'),
(1044, 106, 'Quichuay'),
(1045, 106, 'Quilcas'),
(1046, 106, 'San Agustín'),
(1047, 106, 'San Jerónimo de Tunán'),
(1048, 106, 'Santo Domingo de Acobamba'),
(1049, 106, 'Sapallanga'),
(1050, 106, 'Sicaya'),
(1051, 106, 'Viques'),
(1052, 107, 'Acolla'),
(1053, 107, 'Apata'),
(1054, 107, 'Ataura'),
(1055, 107, 'Canchayllo'),
(1056, 107, 'Curicaca'),
(1057, 107, 'El Mantaro'),
(1058, 107, 'Huamali'),
(1059, 107, 'Huaripampa'),
(1060, 107, 'Huertas'),
(1061, 107, 'Janjaillo'),
(1062, 107, 'Jauja'),
(1063, 107, 'Julcán'),
(1064, 107, 'Leonor Ordóñez'),
(1065, 107, 'Llocllapampa'),
(1066, 107, 'Marco'),
(1067, 107, 'Masma'),
(1068, 107, 'Masma Chicche'),
(1069, 107, 'Molinos'),
(1070, 107, 'Monobamba'),
(1071, 107, 'Muqui'),
(1072, 107, 'Muquiyauyo'),
(1073, 107, 'Paca'),
(1074, 107, 'Paccha'),
(1075, 107, 'Pancan'),
(1076, 107, 'Parco'),
(1077, 107, 'Pomacancha'),
(1078, 107, 'Ricran'),
(1079, 107, 'San Lorenzo'),
(1080, 107, 'San Pedro de Chunan'),
(1081, 107, 'Sincos'),
(1082, 107, 'Tunanmarca'),
(1083, 107, 'Yauli'),
(1084, 107, 'Yauyos'),
(1085, 108, 'Carhuamayo'),
(1086, 108, 'Junín'),
(1087, 108, 'Ondores'),
(1088, 108, 'Ulcumayo'),
(1089, 109, 'Coviriali'),
(1090, 109, 'Llaylla'),
(1091, 109, 'Mazamari'),
(1092, 109, 'Pampa Hermosa'),
(1093, 109, 'Pangoa'),
(1094, 109, 'Río Negro'),
(1095, 109, 'Río Tambo'),
(1096, 109, 'Satipo'),
(1097, 110, 'Acobamba'),
(1098, 110, 'Huaricolca'),
(1099, 110, 'Huasahuasi'),
(1100, 110, 'La Unión'),
(1101, 110, 'Palca'),
(1102, 110, 'Palcamayo'),
(1103, 110, 'San Pedro de Cajas'),
(1104, 110, 'Tarma'),
(1105, 111, 'Huay-Huay'),
(1106, 111, 'La Oroya'),
(1107, 111, 'Marcapomacocha'),
(1108, 111, 'Morococha'),
(1109, 111, 'Paccha'),
(1110, 111, 'Santa Bárbara de Carhuacayan'),
(1111, 111, 'Santa Rosa de Sacco'),
(1112, 111, 'Suitucancha'),
(1113, 111, 'Yauli'),
(1114, 112, 'Ascope'),
(1115, 112, 'Chicama'),
(1116, 112, 'Chocope'),
(1117, 112, 'Magdalena de Cao'),
(1118, 112, 'Paiján'),
(1119, 112, 'Rázuri'),
(1120, 112, 'Santiago de Cao'),
(1121, 112, 'Casa Grande'),
(1122, 113, 'Bolívar'),
(1123, 113, 'Bambamarca'),
(1124, 113, 'Condormarca'),
(1125, 113, 'Longotea'),
(1126, 113, 'Uchumarca'),
(1127, 113, 'Ucuncha'),
(1128, 114, 'Chepén'),
(1129, 114, 'Pacanga'),
(1130, 114, 'Pueblo Nuevo'),
(1131, 115, 'Cascas'),
(1132, 115, 'Lucma'),
(1133, 115, 'Marmot'),
(1134, 115, 'Sayapullo'),
(1135, 116, 'Julcán'),
(1136, 116, 'Calamarca'),
(1137, 116, 'Carabamba'),
(1138, 116, 'Huaso'),
(1139, 117, 'Otuzco'),
(1140, 117, 'Agallpampa'),
(1141, 117, 'Charat'),
(1142, 117, 'Huaranchal'),
(1143, 117, 'La Cuesta'),
(1144, 117, 'Mache'),
(1145, 117, 'Paranday'),
(1146, 117, 'Salpo'),
(1147, 117, 'Sinsicap'),
(1148, 117, 'Usquil'),
(1149, 118, 'San Pedro de Lloc'),
(1150, 118, 'Guadalupe'),
(1151, 118, 'Jequetepeque'),
(1152, 118, 'Pacasmayo'),
(1153, 118, 'San José'),
(1154, 119, 'Tayabamba'),
(1155, 119, 'Buldibuyo'),
(1156, 119, 'Chillia'),
(1157, 119, 'Huancaspata'),
(1158, 119, 'Huaylillas'),
(1159, 119, 'Huayo'),
(1160, 119, 'Ongón'),
(1161, 119, 'Parcoy'),
(1162, 119, 'Pataz'),
(1163, 119, 'Pías'),
(1164, 119, 'Santiago de Challas'),
(1165, 119, 'Taurija'),
(1166, 119, 'Urpay'),
(1167, 120, 'Huamachuco'),
(1168, 120, 'Chugay'),
(1169, 120, 'Cochorco'),
(1170, 120, 'Curgos'),
(1171, 120, 'Marcabal'),
(1172, 120, 'Sanagorán'),
(1173, 120, 'Sarin'),
(1174, 120, 'Sartimbamba'),
(1175, 121, 'Santiago de Chuco'),
(1176, 121, 'Angasmarca'),
(1177, 121, 'Cachicadán'),
(1178, 121, 'Mollebamba'),
(1179, 121, 'Mollepata'),
(1180, 121, 'Quiruvilca'),
(1181, 121, 'Santa Cruz de Chuca'),
(1182, 121, 'Sitabamba'),
(1183, 122, 'Trujillo'),
(1184, 122, 'El Porvenir'),
(1185, 122, 'Florencia de Mora'),
(1186, 122, 'Huanchaco'),
(1187, 122, 'La Esperanza'),
(1188, 122, 'Laredo'),
(1189, 122, 'Moche'),
(1190, 122, 'Poroto'),
(1191, 122, 'Salaverry'),
(1192, 122, 'Simbal'),
(1193, 122, 'Víctor Larco Herrera'),
(1194, 123, 'Virú'),
(1195, 123, 'Chao'),
(1196, 123, 'Guadalupito'),
(1197, 124, 'Chiclayo'),
(1198, 124, 'Chongoyape'),
(1199, 124, 'Eten'),
(1200, 124, 'Eten Puerto'),
(1201, 124, 'José Leonardo Ortiz'),
(1202, 124, 'La Victoria'),
(1203, 124, 'Lagunas'),
(1204, 124, 'Monsefú'),
(1205, 124, 'Nueva Arica'),
(1206, 124, 'Oyotún'),
(1207, 124, 'Patapo'),
(1208, 124, 'Picsi'),
(1209, 124, 'Pimentel'),
(1210, 124, 'Pomalca'),
(1211, 124, 'Pucalá'),
(1212, 124, 'Reque'),
(1213, 124, 'Santa Rosa'),
(1214, 124, 'Saña'),
(1215, 124, 'Tuman'),
(1216, 125, 'Cañaris'),
(1217, 125, 'Ferreñafe'),
(1218, 125, 'Incahuasi'),
(1219, 125, 'Manuel Antonio Mesones Muro'),
(1220, 125, 'Pitipo'),
(1221, 125, 'Pueblo Nuevo'),
(1222, 126, 'Chochope'),
(1223, 126, 'Illimo'),
(1224, 126, 'Jayanca'),
(1225, 126, 'Lambayeque'),
(1226, 126, 'Mochumí'),
(1227, 126, 'Morrope'),
(1228, 126, 'Motupe'),
(1229, 126, 'Olmos'),
(1230, 126, 'Pacora'),
(1231, 126, 'Salas'),
(1232, 126, 'San José'),
(1233, 126, 'Túcume'),
(1234, 127, 'Barranca'),
(1235, 127, 'Paramonga'),
(1236, 127, 'Pativilca'),
(1237, 127, 'Supe'),
(1238, 127, 'Supe Puerto'),
(1239, 128, 'Cajatambo'),
(1240, 128, 'Copa'),
(1241, 128, 'Gorgor'),
(1242, 128, 'Huancapon'),
(1243, 128, 'Manas'),
(1244, 129, 'Arahuay'),
(1245, 129, 'Canta'),
(1246, 129, 'Huamantanga'),
(1247, 129, 'Huaros'),
(1248, 129, 'Lachaqui'),
(1249, 129, 'San Buenaventura'),
(1250, 129, 'Santa Rosa de Quives'),
(1251, 130, 'Asia'),
(1252, 130, 'Calango'),
(1253, 130, 'Cerro Azul'),
(1254, 130, 'Chilca'),
(1255, 130, 'Coayllo'),
(1256, 130, 'Imperial'),
(1257, 130, 'Lunahuana'),
(1258, 130, 'Mala'),
(1259, 130, 'Nuevo Imperial'),
(1260, 130, 'Pacaran'),
(1261, 130, 'Quilmana'),
(1262, 130, 'San Antonio'),
(1263, 130, 'San Luis'),
(1264, 130, 'Santa Cruz de Flores'),
(1265, 130, 'Zuniga'),
(1266, 131, 'Atavillos Alto'),
(1267, 131, 'Atavillos Bajo'),
(1268, 131, 'Aucallama'),
(1269, 131, 'Chancay'),
(1270, 131, 'Huaral'),
(1271, 131, 'Ihuari'),
(1272, 131, 'Lampian'),
(1273, 131, 'Pacaraos'),
(1274, 131, 'San Miguel de Acos'),
(1275, 131, 'Santa Cruz de Andamarca'),
(1276, 131, 'Sumbilca'),
(1277, 131, 'Veintisiete de Noviembre'),
(1278, 132, 'Antioquia'),
(1279, 132, 'Callahuanca'),
(1280, 132, 'Carampoma'),
(1281, 132, 'Chicla'),
(1282, 132, 'Cuenca'),
(1283, 132, 'Huachupampa'),
(1284, 132, 'Huanza'),
(1285, 132, 'Huarochiri'),
(1286, 132, 'Lahuaytambo'),
(1287, 132, 'Langa'),
(1288, 132, 'Laraos'),
(1289, 132, 'Mariatana'),
(1290, 132, 'Matucana'),
(1291, 132, 'Ricardo Palma'),
(1292, 132, 'San Andrés de Tupicocha'),
(1293, 132, 'San Antonio'),
(1294, 132, 'San Bartolome'),
(1295, 132, 'San Damian'),
(1296, 132, 'San Juan de Iris'),
(1297, 132, 'San Juan de Tantaranche'),
(1298, 132, 'San Lorenzo de Quinti'),
(1299, 132, 'San Mateo'),
(1300, 132, 'San Mateo de Otao'),
(1301, 132, 'San Pedro de Casta'),
(1302, 132, 'San Pedro de Huancayre'),
(1303, 132, 'Sangallaya'),
(1304, 132, 'Santa Cruz de Cocachacra'),
(1305, 132, 'Santa Eulalia'),
(1306, 132, 'Santiago de Anchucaya'),
(1307, 132, 'Santiago de Tuna'),
(1308, 132, 'Santo Domingo de los Olleros'),
(1309, 132, 'Surco'),
(1310, 133, 'Ambar'),
(1311, 133, 'Caleta de Carquin'),
(1312, 133, 'Checras'),
(1313, 133, 'Hualmay'),
(1314, 133, 'Huaura'),
(1315, 133, 'Leoncio Prado'),
(1316, 133, 'Paccho'),
(1317, 133, 'Santa Leonor'),
(1318, 133, 'Santa Maria'),
(1319, 133, 'Sayan'),
(1320, 133, 'Vegueta'),
(1321, 134, 'Ancón'),
(1322, 134, 'Ate'),
(1323, 134, 'Barranco'),
(1324, 134, 'Breña'),
(1325, 134, 'Carabayllo'),
(1326, 134, 'Chaclacayo'),
(1327, 134, 'Chorrillos'),
(1328, 134, 'Cieneguilla'),
(1329, 134, 'Comas'),
(1330, 134, 'El Agustino'),
(1331, 134, 'Independencia'),
(1332, 134, 'Jesús María'),
(1333, 134, 'La Molina'),
(1334, 134, 'La Victoria'),
(1335, 134, 'Lima'),
(1336, 134, 'Lince'),
(1337, 134, 'Los Olivos'),
(1338, 134, 'Lurigancho'),
(1339, 134, 'Lurín'),
(1340, 134, 'Magdalena del Mar'),
(1341, 134, 'Miraflores'),
(1342, 134, 'Pachacamac'),
(1343, 134, 'Pucusana'),
(1344, 134, 'Pueblo Libre'),
(1345, 134, 'Puente Piedra'),
(1346, 134, 'Punta Hermosa'),
(1347, 134, 'Punta Negra'),
(1348, 134, 'Rímac'),
(1349, 134, 'San Bartolo'),
(1350, 134, 'San Borja'),
(1351, 134, 'San Isidro'),
(1352, 134, 'San Juan de Lurigancho'),
(1353, 134, 'San Juan de Miraflores'),
(1354, 134, 'San Luis'),
(1355, 134, 'San Martín de Porres'),
(1356, 134, 'San Miguel'),
(1357, 134, 'Santa Anita'),
(1358, 134, 'Santa María del Mar'),
(1359, 134, 'Santa Rosa'),
(1360, 134, 'Santiago de Surco'),
(1361, 134, 'Surquillo'),
(1362, 134, 'Villa El Salvador'),
(1363, 134, 'Villa María del Triunfo'),
(1364, 135, 'Andajes'),
(1365, 135, 'Caujul'),
(1366, 135, 'Cochamarca'),
(1367, 135, 'Navan'),
(1368, 135, 'Oyón'),
(1369, 135, 'Pachangara'),
(1370, 136, 'Alis'),
(1371, 136, 'Allauca'),
(1372, 136, 'Ayaviri'),
(1373, 136, 'Azángaro'),
(1374, 136, 'Cacra'),
(1375, 136, 'Carania'),
(1376, 136, 'Catahuasi'),
(1377, 136, 'Chocos'),
(1378, 136, 'Cochas'),
(1379, 136, 'Colonia'),
(1380, 136, 'Hongos'),
(1381, 136, 'Huampara'),
(1382, 136, 'Huancaya'),
(1383, 136, 'Huangascar'),
(1384, 136, 'Huantán'),
(1385, 136, 'Huañec'),
(1386, 136, 'Laraos'),
(1387, 136, 'Lincha'),
(1388, 136, 'Madean'),
(1389, 136, 'Miraflores'),
(1390, 136, 'Omas'),
(1391, 136, 'Putinza'),
(1392, 136, 'Quinches'),
(1393, 136, 'Quinocay'),
(1394, 136, 'San Joaquín'),
(1395, 136, 'San Pedro de Pilas'),
(1396, 136, 'Tanta'),
(1397, 136, 'Tauripampa'),
(1398, 136, 'Tomas'),
(1399, 136, 'Tupe'),
(1400, 136, 'Viñac'),
(1401, 136, 'Vitis'),
(1402, 137, 'Balsapuerto'),
(1403, 137, 'Jeberos'),
(1404, 137, 'Lagunas'),
(1405, 137, 'Santa Cruz'),
(1406, 137, 'Teniente Cesar López Rojas'),
(1407, 137, 'Yurimaguas'),
(1408, 138, 'Andoas'),
(1409, 138, 'Barranca'),
(1410, 138, 'Cahuapanas'),
(1411, 138, 'Manseriche'),
(1412, 138, 'Morona'),
(1413, 138, 'Pastaza'),
(1414, 139, 'Nauta'),
(1415, 139, 'Parinari'),
(1416, 139, 'Tigre'),
(1417, 139, 'Trompeteros'),
(1418, 139, 'Urarinas'),
(1419, 140, 'Pebas'),
(1420, 140, 'Ramón Castilla'),
(1421, 140, 'San Pablo'),
(1422, 140, 'Yavarí'),
(1423, 141, 'Alto Nanay'),
(1424, 141, 'Fernando Lores'),
(1425, 141, 'Indiana'),
(1426, 141, 'Iquitos'),
(1427, 141, 'Las Amazonas'),
(1428, 141, 'Mazan'),
(1429, 141, 'Napo'),
(1430, 141, 'Punchana'),
(1431, 141, 'Torres Causana'),
(1432, 141, 'Belén'),
(1433, 141, 'San Juan Bautista'),
(1434, 142, 'Putumayo'),
(1435, 142, 'Rosa Panduro'),
(1436, 142, 'Teniente Manuel Clavero'),
(1437, 142, 'Yaguas'),
(1438, 143, 'Alto Tapiche'),
(1439, 143, 'Capelo'),
(1440, 143, 'Emilio San Martín'),
(1441, 143, 'Jenaro Herrera'),
(1442, 143, 'Maquia'),
(1443, 143, 'Puinahua'),
(1444, 143, 'Requena'),
(1445, 143, 'Saquena'),
(1446, 143, 'Soplin'),
(1447, 143, 'Tapiche'),
(1448, 143, 'Yaquerana'),
(1449, 144, 'Contamana'),
(1450, 144, 'Inahuaya'),
(1451, 144, 'Padre Márquez'),
(1452, 144, 'Pampa Hermosa'),
(1453, 144, 'Sarayacu'),
(1454, 144, 'Vargas Guerra'),
(1455, 145, 'Fitzcarrald'),
(1456, 145, 'Madre de Dios'),
(1457, 145, 'Manu'),
(1458, 145, 'Huepetuhe'),
(1459, 146, 'Iñapari'),
(1460, 146, 'Iberia'),
(1461, 146, 'Tahuamanu'),
(1462, 147, 'Inambari'),
(1463, 147, 'Las Piedras'),
(1464, 147, 'Laberinto'),
(1465, 147, 'Tambopata'),
(1466, 148, 'Chojata'),
(1467, 148, 'Coalaque'),
(1468, 148, 'Ichuña'),
(1469, 148, 'La Capilla'),
(1470, 148, 'Lloque'),
(1471, 148, 'Matalaque'),
(1472, 148, 'Omate'),
(1473, 148, 'Puquina'),
(1474, 148, 'Quinistaquillas'),
(1475, 148, 'Ubinas'),
(1476, 148, 'Yunga'),
(1477, 149, 'El Algarrobal'),
(1478, 149, 'Ilo'),
(1479, 149, 'Pacocha'),
(1480, 150, 'Carumas'),
(1481, 150, 'Cuchumbaya'),
(1482, 150, 'Moquegua'),
(1483, 150, 'Samegua'),
(1484, 150, 'San Cristóbal'),
(1485, 150, 'Torata'),
(1486, 151, 'Chacayan'),
(1487, 151, 'Goyllarisquizga'),
(1488, 151, 'Paucar'),
(1489, 151, 'San Pedro de Pillao'),
(1490, 151, 'Santa Ana de Tusi'),
(1491, 151, 'Tapuc'),
(1492, 151, 'Vilcabamba'),
(1493, 151, 'Yanahuanca'),
(1494, 152, 'Chontabamba'),
(1495, 152, 'Constitución'),
(1496, 152, 'Huancabamba'),
(1497, 152, 'Oxapampa'),
(1498, 152, 'Palcazu'),
(1499, 152, 'Pozuzo'),
(1500, 152, 'Puerto Bermúdez'),
(1501, 152, 'Villa Rica'),
(1502, 153, 'Chaupimarca'),
(1503, 153, 'Huachon'),
(1504, 153, 'Huariaca'),
(1505, 153, 'Huayllay'),
(1506, 153, 'Ninacaca'),
(1507, 153, 'Pallanchacra'),
(1508, 153, 'Paucartambo'),
(1509, 153, 'San Francisco de Asís de Yarusyacán'),
(1510, 153, 'Simón Bolívar'),
(1511, 153, 'Ticlacayán'),
(1512, 153, 'Tinyahuarco'),
(1513, 153, 'Vicco'),
(1514, 153, 'Yanacancha'),
(1515, 154, 'Ayabaca'),
(1516, 154, 'Frias'),
(1517, 154, 'Jilili'),
(1518, 154, 'Lagunas'),
(1519, 154, 'Montero'),
(1520, 154, 'Pacaipampa'),
(1521, 154, 'Paimas'),
(1522, 154, 'Sapillica'),
(1523, 154, 'Sicchez'),
(1524, 154, 'Suyo'),
(1525, 155, 'Canchaque'),
(1526, 155, 'El Carmen de la Frontera'),
(1527, 155, 'Huancabamba'),
(1528, 155, 'Huarmaca'),
(1529, 155, 'Lalaquiz'),
(1530, 155, 'San Miguel de El Faique'),
(1531, 155, 'Sondor'),
(1532, 155, 'Sondorillo'),
(1533, 156, 'Buenos Aires'),
(1534, 156, 'Chalaco'),
(1535, 156, 'Chulucanas'),
(1536, 156, 'La Matanza'),
(1537, 156, 'Morropon'),
(1538, 156, 'Salitral'),
(1539, 156, 'San Juan de Bigote'),
(1540, 156, 'Santa Catalina de Mossa'),
(1541, 156, 'Santo Domingo'),
(1542, 156, 'Yamango'),
(1543, 157, 'Amotape'),
(1544, 157, 'Arenal'),
(1545, 157, 'Colan'),
(1546, 157, 'La Huaca'),
(1547, 157, 'Paita'),
(1548, 157, 'Tamarindo'),
(1549, 157, 'Vichayal'),
(1550, 158, 'Castilla'),
(1551, 158, 'Catacaos'),
(1552, 158, 'Cura Mori'),
(1553, 158, 'El Tallan'),
(1554, 158, 'La Arena'),
(1555, 158, 'La Union'),
(1556, 158, 'Las Lomas'),
(1557, 158, 'Piura'),
(1558, 158, 'Tambo Grande'),
(1559, 159, 'Bellavista de la Union'),
(1560, 159, 'Bernal'),
(1561, 159, 'Cristo Nos Valga'),
(1562, 159, 'Rinconada Llicuar'),
(1563, 159, 'Sechura'),
(1564, 159, 'Vice'),
(1565, 160, 'Bellavista'),
(1566, 160, 'Ignacio Escudero'),
(1567, 160, 'Lancones'),
(1568, 160, 'Marcavelica'),
(1569, 160, 'Miguel Checa'),
(1570, 160, 'Querecotillo'),
(1571, 160, 'Salitral'),
(1572, 160, 'Sullana'),
(1573, 161, 'El Alto'),
(1574, 161, 'La Brea'),
(1575, 161, 'Lobitos'),
(1576, 161, 'Los Organos'),
(1577, 161, 'Mancora'),
(1578, 161, 'Parinas'),
(1579, 162, 'Azángaro'),
(1580, 162, 'Achaya'),
(1581, 162, 'Arapa'),
(1582, 162, 'Asillo'),
(1583, 162, 'Caminaca'),
(1584, 162, 'Chupa'),
(1585, 162, 'José Domingo Choquehuanca'),
(1586, 162, 'Muñani'),
(1587, 162, 'Potoni'),
(1588, 162, 'Samán'),
(1589, 162, 'San Antón'),
(1590, 162, 'San José'),
(1591, 162, 'San Juan de Salinas'),
(1592, 162, 'Santiago de Pupuja'),
(1593, 162, 'Tirapata'),
(1594, 163, 'Carabaya'),
(1595, 163, 'Ajoyani'),
(1596, 163, 'Ayapata'),
(1597, 163, 'Coasa'),
(1598, 163, 'Corani'),
(1599, 163, 'Crucero'),
(1600, 163, 'Ituata'),
(1601, 163, 'Macusani'),
(1602, 163, 'Ollachea'),
(1603, 163, 'San Gabán'),
(1604, 163, 'Usicayos'),
(1605, 164, 'Chucuito'),
(1606, 164, 'Desaguadero'),
(1607, 164, 'Huacullani'),
(1608, 164, 'Juli'),
(1609, 164, 'Kelluyo'),
(1610, 164, 'Pisacoma'),
(1611, 164, 'Pomata'),
(1612, 164, 'Zepita'),
(1613, 165, 'El Collao'),
(1614, 165, 'Capaso'),
(1615, 165, 'Conduriri'),
(1616, 165, 'Ilave'),
(1617, 165, 'Pilcuyo'),
(1618, 165, 'Santa Rosa'),
(1619, 166, 'Huancané'),
(1620, 166, 'Cojata'),
(1621, 166, 'Huancané'),
(1622, 166, 'Huatasani'),
(1623, 166, 'Inchupalla'),
(1624, 166, 'Pusi'),
(1625, 166, 'Rosaspata'),
(1626, 166, 'Taraco'),
(1627, 166, 'Vilque Chico'),
(1628, 167, 'Lampa'),
(1629, 167, 'Cabanilla'),
(1630, 167, 'Calapuja'),
(1631, 167, 'Lampa'),
(1632, 167, 'Nicasio'),
(1633, 167, 'Ocuviri'),
(1634, 167, 'Palca'),
(1635, 167, 'Paratía'),
(1636, 167, 'Pucará'),
(1637, 167, 'Santa Lucía'),
(1638, 167, 'Vilavila'),
(1639, 168, 'Melgar'),
(1640, 168, 'Antauta'),
(1641, 168, 'Ayaviri'),
(1642, 168, 'Cupi'),
(1643, 168, 'Llalli'),
(1644, 168, 'Macari'),
(1645, 168, 'Nuñoa'),
(1646, 168, 'Orurillo'),
(1647, 168, 'Santa Rosa'),
(1648, 168, 'Umachiri'),
(1649, 169, 'Moho'),
(1650, 169, 'Conima'),
(1651, 169, 'Huayrapata'),
(1652, 169, 'Moho'),
(1653, 169, 'Tilali'),
(1654, 170, 'Puno'),
(1655, 170, 'Acora'),
(1656, 170, 'Amantani'),
(1657, 170, 'Atuncolla'),
(1658, 170, 'Capachica'),
(1659, 170, 'Chucuito'),
(1660, 170, 'Coata'),
(1661, 170, 'Huata'),
(1662, 170, 'Mañazo'),
(1663, 170, 'Paucarcolla'),
(1664, 170, 'Pichacani'),
(1665, 170, 'Platería'),
(1666, 170, 'Puno'),
(1667, 170, 'San Antonio'),
(1668, 170, 'Tiquillaca'),
(1669, 170, 'Vilque'),
(1670, 171, 'San Antonio de Putina'),
(1671, 171, 'Ananea'),
(1672, 171, 'Pedro Vilca Apaza'),
(1673, 171, 'Putina'),
(1674, 171, 'Quilcapuncu'),
(1675, 171, 'Sina'),
(1676, 172, 'San Román'),
(1677, 172, 'Cabana'),
(1678, 172, 'Cabanillas'),
(1679, 172, 'Caracoto'),
(1680, 172, 'Juliaca'),
(1681, 173, 'Sandia'),
(1682, 173, 'Alto Inambari'),
(1683, 173, 'Cuyocuyo'),
(1684, 173, 'Limbani'),
(1685, 173, 'Patambuco'),
(1686, 173, 'Phara'),
(1687, 173, 'Quiaca'),
(1688, 173, 'San Juan del Oro'),
(1689, 173, 'San Pedro de Putina Punco'),
(1690, 173, 'Sandia'),
(1691, 173, 'Yanahuaya'),
(1692, 174, 'Yunguyo'),
(1693, 174, 'Anapia'),
(1694, 174, 'Copani'),
(1695, 174, 'Cuturapi'),
(1696, 174, 'Ollaraya'),
(1697, 174, 'Tinicachi'),
(1698, 174, 'Unicachi'),
(1699, 175, 'Alto Biavo'),
(1700, 175, 'Bajo Biavo'),
(1701, 175, 'Bellavista'),
(1702, 175, 'Huallaga'),
(1703, 175, 'San Pablo'),
(1704, 175, 'San Rafael'),
(1705, 176, 'Agua Blanca'),
(1706, 176, 'San José de Sisa'),
(1707, 176, 'San Martín'),
(1708, 176, 'Santa Rosa'),
(1709, 176, 'Shatoja'),
(1710, 177, 'Alto Saposoa'),
(1711, 177, 'El Eslabón'),
(1712, 177, 'Piscoyacu'),
(1713, 177, 'Sacanche'),
(1714, 177, 'Saposoa'),
(1715, 177, 'Tingo de Saposoa'),
(1716, 178, 'Alonso de Alvarado'),
(1717, 178, 'Barranquita'),
(1718, 178, 'Caynarachi'),
(1719, 178, 'Cuñumbuqui'),
(1720, 178, 'Lamas'),
(1721, 178, 'Pinto Recodo'),
(1722, 178, 'Rumisapa'),
(1723, 178, 'San Roque de Cumbaza'),
(1724, 178, 'Shanao'),
(1725, 178, 'Tabalosos'),
(1726, 178, 'Zapatero'),
(1727, 179, 'Campanilla'),
(1728, 179, 'Huicungo'),
(1729, 179, 'Juanjuí'),
(1730, 179, 'Pachiza'),
(1731, 179, 'Pajarillo'),
(1732, 180, 'Calzada'),
(1733, 180, 'Habana'),
(1734, 180, 'Jepelacio'),
(1735, 180, 'Moyobamba'),
(1736, 180, 'Soritor'),
(1737, 180, 'Yantalo'),
(1738, 181, 'Buenos Aires'),
(1739, 181, 'Caspisapa'),
(1740, 181, 'Picota'),
(1741, 181, 'Pilluana'),
(1742, 181, 'Pucacaca'),
(1743, 181, 'San Cristóbal'),
(1744, 181, 'San Hilarión'),
(1745, 181, 'Shamboyacu'),
(1746, 181, 'Tingo de Ponasa'),
(1747, 181, 'Tres Unidos'),
(1748, 182, 'Awajun'),
(1749, 182, 'Elias Soplin Vargas'),
(1750, 182, 'Nueva Cajamarca'),
(1751, 182, 'Pardo Miguel'),
(1752, 182, 'Posic'),
(1753, 182, 'Rioja'),
(1754, 182, 'San Fernando'),
(1755, 182, 'Yorongos'),
(1756, 182, 'Yuracyacu'),
(1757, 183, 'Alberto Leveau'),
(1758, 183, 'Cacatachi'),
(1759, 183, 'Chazuta'),
(1760, 183, 'Chipurana'),
(1761, 183, 'El Porvenir'),
(1762, 183, 'Huimbayoc'),
(1763, 183, 'Juan Guerra'),
(1764, 183, 'La Banda de Shilcayo'),
(1765, 183, 'Morales'),
(1766, 183, 'Papaplaya'),
(1767, 183, 'San Antonio'),
(1768, 183, 'Sauce'),
(1769, 183, 'Shapaja'),
(1770, 183, 'Tarapoto'),
(1771, 184, 'Nuevo Progreso'),
(1772, 184, 'Polvora'),
(1773, 184, 'Shunte'),
(1774, 184, 'Tocache'),
(1775, 184, 'Uchiza'),
(1776, 185, 'Cairani'),
(1777, 185, 'Camilaca'),
(1778, 185, 'Candarave'),
(1779, 185, 'Curibaya'),
(1780, 185, 'Huanuara'),
(1781, 185, 'Quilahuani'),
(1782, 186, 'Ilabaya'),
(1783, 186, 'Ite'),
(1784, 186, 'Locumba'),
(1785, 187, 'Alto de la Alianza'),
(1786, 187, 'Calana'),
(1787, 187, 'Ciudad Nueva'),
(1788, 187, 'Inclán'),
(1789, 187, 'Pachía'),
(1790, 187, 'Palca'),
(1791, 187, 'Pocollay'),
(1792, 187, 'Sama'),
(1793, 187, 'Tacna'),
(1794, 187, 'Coronel Gregorio Albarracín Lanchipa'),
(1795, 188, 'Estique'),
(1796, 188, 'Estique-Pampa'),
(1797, 188, 'Sitajara'),
(1798, 188, 'Susapaya'),
(1799, 188, 'Tarata'),
(1800, 188, 'Tarucachi'),
(1801, 188, 'Ticaco'),
(1802, 189, 'Canoas de Punta Sal'),
(1803, 189, 'Casitas'),
(1804, 189, 'Zorritos'),
(1805, 190, 'Corrales'),
(1806, 190, 'La Cruz'),
(1807, 190, 'Pampas de Hospital'),
(1808, 190, 'San Jacinto'),
(1809, 190, 'San Juan de la Virgen'),
(1810, 190, 'Tumbes'),
(1811, 191, 'Aguas Verdes'),
(1812, 191, 'Matapalo'),
(1813, 191, 'Papayal'),
(1814, 191, 'Zarumilla'),
(1815, 192, 'Raymondi'),
(1816, 192, 'Sepahua'),
(1817, 192, 'Tahuanía'),
(1818, 192, 'Yurúa'),
(1819, 193, 'Callería'),
(1820, 193, 'Campoverde'),
(1821, 193, 'Iparía'),
(1822, 193, 'Masisea'),
(1823, 193, 'Yarinacocha'),
(1824, 193, 'Nueva Requena'),
(1825, 193, 'Manantay'),
(1826, 194, 'Padre Abad'),
(1827, 194, 'Irazola'),
(1828, 194, 'Curimaná'),
(1829, 195, 'Purús');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `egresos_evento`
--

CREATE TABLE `egresos_evento` (
  `idegreso` int(11) NOT NULL,
  `idreparticion` int(11) NOT NULL,
  `descripcion` varchar(80) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tipopago` tinyint(4) NOT NULL,
  `noperacion` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `egresos_evento`
--

INSERT INTO `egresos_evento` (`idegreso`, `idreparticion`, `descripcion`, `monto`, `tipopago`, `noperacion`) VALUES
(1, 2, 'BRAZALETES MODELO EJEM', 400.00, 2, NULL),
(2, 2, 'PASAJES MUSICOS EJEM', 500.00, 1, '4534344');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `idempresa` int(11) NOT NULL,
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
  `moneda` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`idempresa`, `ruc`, `logoempresa`, `razonsocial`, `nombrecomercial`, `nombreapp`, `direccion`, `web`, `correo`, `contrasenagmailapp`, `ncuenta`, `ncci`, `banco`, `moneda`) VALUES
(1, '20608627422', 'vegaimagenes/cyh8cnkpolkljrj2bdyr', 'NEGOCIACIONES Y PRODUCCIONES VEGA S.A.C.', NULL, 'Vega Producciones', 'Av. Ejemplo 123', 'https://vegadistribution.org/', NULL, NULL, '1929842849014', '00219200984284901432', 'BCP', 'soles');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gastosyentradas`
--

CREATE TABLE `gastosyentradas` (
  `idgastoentrada` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  `concepto` varchar(200) DEFAULT NULL,
  `fecha_gasto` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `iddetallepresentacion` int(11) DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `mediopago` int(11) DEFAULT NULL,
  `detalles` varchar(200) DEFAULT NULL,
  `comprobante_url` varchar(200) DEFAULT NULL,
  `comprobante_fac_bol` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `gastosyentradas`
--

INSERT INTO `gastosyentradas` (`idgastoentrada`, `estado`, `concepto`, `fecha_gasto`, `monto`, `iddetallepresentacion`, `idusuario`, `mediopago`, `detalles`, `comprobante_url`, `comprobante_fac_bol`) VALUES
(1, 2, 'TV NATALY Y BUS COMBUSTIBLE, LAVADO DEL CARRO, PEAJES Y CHOFER', '2025-05-07', 622.00, NULL, 8, 1, NULL, 'comprobantes_vegaproducciones/hz1kd8tijlhgsknufqi0', 'comprobantes_vegaproducciones/srphn14wl6sdav1ejnld'),
(3, 2, 'ESTRADA 17.05 MI PERU', '2025-05-07', 4000.00, 130, NULL, 1, NULL, 'comprobantes_vegaproducciones/bundivv25hotbydmyzba', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gastos_cajachica`
--

CREATE TABLE `gastos_cajachica` (
  `idgasto` int(11) NOT NULL,
  `idcajachica` int(11) NOT NULL,
  `fecha_gasto` datetime DEFAULT current_timestamp(),
  `concepto` varchar(250) NOT NULL,
  `monto` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresos_evento`
--

CREATE TABLE `ingresos_evento` (
  `idingreso` int(11) NOT NULL,
  `idreparticion` int(11) NOT NULL,
  `descripcion` varchar(80) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tipopago` tinyint(4) NOT NULL,
  `noperacion` varchar(15) DEFAULT NULL,
  `medio` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ingresos_evento`
--

INSERT INTO `ingresos_evento` (`idingreso`, `idreparticion`, `descripcion`, `monto`, `tipopago`, `noperacion`, `medio`) VALUES
(1, 2, 'ADELANT/ GARANTIA MODELOEJEM', 1000.00, 1, '34323423', 'BCP');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items_comprobante`
--

CREATE TABLE `items_comprobante` (
  `iditemcomprobante` int(11) NOT NULL,
  `idcomprobante` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `valorunitario` decimal(10,2) NOT NULL,
  `valortotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `montoCajaChica`
--

CREATE TABLE `montoCajaChica` (
  `idmonto` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `montoCajaChica`
--

INSERT INTO `montoCajaChica` (`idmonto`, `monto`) VALUES
(1, -299.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `montocajachica`
--

CREATE TABLE `montocajachica` (
  `idmonto` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `montocajachica`
--

INSERT INTO `montocajachica` (`idmonto`, `monto`) VALUES
(1, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nacionalidades`
--

CREATE TABLE `nacionalidades` (
  `idnacionalidad` int(11) NOT NULL,
  `nacionalidad` varchar(100) NOT NULL,
  `pais` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `nacionalidades`
--

INSERT INTO `nacionalidades` (`idnacionalidad`, `nacionalidad`, `pais`) VALUES
(1, 'Afgana', 'Afganistán'),
(2, 'Albanesa', 'Albania'),
(3, 'Alemana', 'Alemania'),
(4, 'Andorrana', 'Andorra'),
(5, 'Angoleña', 'Angola'),
(6, 'Argentina', 'Argentina'),
(7, 'Australiana', 'Australia'),
(8, 'Belga', 'Bélgica'),
(9, 'Boliviana', 'Bolivia'),
(10, 'Brasileña', 'Brasil'),
(11, 'Canadiense', 'Canadá'),
(12, 'Chilena', 'Chile'),
(13, 'China', 'China'),
(14, 'Colombiana', 'Colombia'),
(15, 'Costarricense', 'Costa Rica'),
(16, 'Cubana', 'Cuba'),
(17, 'Ecuatoriana', 'Ecuador'),
(18, 'Egipcia', 'Egipto'),
(19, 'Española', 'España'),
(20, 'Estadounidense', 'Estados Unidos'),
(21, 'Filipina', 'Filipinas'),
(22, 'Francesa', 'Francia'),
(23, 'Guatemalteca', 'Guatemala'),
(24, 'Hondureña', 'Honduras'),
(25, 'India', 'India'),
(26, 'Italiana', 'Italia'),
(27, 'Japonesa', 'Japón'),
(28, 'Mexicana', 'México'),
(29, 'Panameña', 'Panamá'),
(30, 'Paraguaya', 'Paraguay'),
(31, 'Peruana', 'Perú'),
(32, 'Portuguesa', 'Portugal'),
(33, 'Salvadoreña', 'El Salvador'),
(34, 'Suiza', 'Suiza'),
(35, 'Uruguaya', 'Uruguay'),
(36, 'Venezolana', 'Venezuela');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivelaccesos`
--

CREATE TABLE `nivelaccesos` (
  `idnivelacceso` int(11) NOT NULL,
  `nivelacceso` varchar(30) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `nivelaccesos`
--

INSERT INTO `nivelaccesos` (`idnivelacceso`, `nivelacceso`, `create_at`, `update_at`) VALUES
(1, 'Vendedor', '2025-04-16 00:31:03', NULL),
(2, 'Vendedor Externo', '2025-04-16 00:31:03', NULL),
(3, 'Administrador', '2025-04-16 00:31:03', NULL),
(4, 'Gerente', '2025-04-16 00:31:03', NULL),
(5, 'Director', '2025-04-16 00:31:03', NULL),
(6, 'Artista', '2025-04-16 00:31:03', NULL),
(7, 'Asistente de Gerencia', '2025-04-16 00:31:03', NULL),
(8, 'Community Manager', '2025-04-16 00:31:03', NULL),
(9, 'Contabilidad', '2025-04-16 00:31:03', NULL),
(10, 'Edicion y Produccion', '2025-04-16 00:31:03', NULL),
(11, 'Filmmaker', '2025-04-16 00:31:03', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `idnotificacion` int(11) NOT NULL,
  `idusuariodest` int(11) NOT NULL,
  `idusuariorem` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `idreferencia` int(11) DEFAULT NULL,
  `mensaje` varchar(200) NOT NULL,
  `estado` int(11) DEFAULT 1,
  `fecha` datetime DEFAULT current_timestamp()
) ;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`idnotificacion`, `idusuariodest`, `idusuariorem`, `tipo`, `idreferencia`, `mensaje`, `estado`, `fecha`) VALUES
(1, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 08:05:04'),
(2, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 08:08:48'),
(3, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 20 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 08:10:28'),
(4, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 30 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 08:12:17'),
(5, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 08:15:23'),
(6, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 08:18:00'),
(7, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 31 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 08:32:26'),
(8, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 31 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 08:36:52'),
(9, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 26 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 08:48:42'),
(10, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 27 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 08:56:03'),
(11, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 08:57:41'),
(12, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 09:04:37'),
(13, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 3 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 12:30:10'),
(14, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 12:33:13'),
(15, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 12:38:28'),
(16, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 12:43:00'),
(17, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 12:45:19'),
(18, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 18 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-16 12:46:39'),
(19, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Octubre de 2025!, revisa tu agenda.', 1, '2025-04-16 12:48:04'),
(22, 6, 1, 4, 16, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-04-16 14:57:32'),
(23, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 13 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 15:19:11'),
(24, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 15:21:45'),
(25, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 6 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 15:24:57'),
(26, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Abril de 2025!, revisa tu agenda.', 1, '2025-04-16 15:31:46'),
(27, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 30 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 15:33:54'),
(28, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 23 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 15:36:16'),
(29, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 15:37:58'),
(30, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 15:39:15'),
(31, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 15:40:02'),
(32, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 15:40:52'),
(33, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 15:42:09'),
(34, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 15:43:20'),
(35, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 15:50:43'),
(36, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 15:52:22'),
(37, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 15:57:20'),
(38, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:00:42'),
(39, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:02:13'),
(40, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:04:42'),
(41, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:10:16'),
(42, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:12:37'),
(43, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:15:20'),
(44, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:18:24'),
(45, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:21:12'),
(46, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:24:05'),
(47, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:25:47'),
(48, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:28:10'),
(49, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:31:29'),
(50, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:34:20'),
(51, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 28 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:37:41'),
(52, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 26 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:38:48'),
(53, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 20 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:43:08'),
(54, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:44:10'),
(55, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:45:50'),
(56, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 19 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:47:16'),
(57, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 18 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:49:56'),
(58, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:50:55'),
(59, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 13 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:52:49'),
(60, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:54:08'),
(61, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:55:23'),
(62, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 16:59:10'),
(63, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 5 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 17:02:32'),
(64, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 17:11:26'),
(65, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 17:13:10'),
(66, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-16 17:14:30'),
(67, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-16 17:43:51'),
(68, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-21 10:51:24'),
(69, 5, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-21 11:07:30'),
(70, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-21 11:09:25'),
(71, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-21 11:11:24'),
(72, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Marzo de 2025!, revisa tu agenda.', 1, '2025-04-21 11:13:58'),
(73, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 23 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:15:21'),
(74, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 23 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:18:56'),
(75, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:21:42'),
(76, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 21 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:22:38'),
(77, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:23:54'),
(78, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:26:12'),
(79, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:27:02'),
(80, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:28:36'),
(81, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:30:01'),
(82, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:31:44'),
(83, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:33:11'),
(84, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:34:33'),
(85, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:37:11'),
(86, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:38:50'),
(87, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 8 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:41:02'),
(88, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Febrero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:42:41'),
(89, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:44:53'),
(90, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:46:06'),
(91, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 22 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:46:59'),
(92, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 18 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:48:50'),
(93, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:49:50'),
(94, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:51:33'),
(95, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:53:50'),
(96, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 5 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:54:44'),
(97, 4, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Enero de 2025!, revisa tu agenda.', 1, '2025-04-21 11:56:22'),
(98, 3, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-25 17:21:11'),
(99, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.', 1, '2025-04-25 17:42:47'),
(100, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 30 de Abril de 2025!, revisa tu agenda.', 1, '2025-05-05 10:00:38'),
(101, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:05:53'),
(102, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 1 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:08:55'),
(103, 6, 1, 4, 99, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-05 10:09:44'),
(104, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 2 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:10:56'),
(105, 1, 1, 5, 99, 'Se ha configurado precios para el evento de Nataly Ramirez - beta disco lounge 1 de Mayo de 2025', 1, '2025-05-05 10:11:19'),
(106, 6, 1, 5, 99, 'Se ha configurado precios para el evento de Nataly Ramirez - beta disco lounge 1 de Mayo de 2025', 1, '2025-05-05 10:11:19'),
(107, 6, 1, 4, 100, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-05 10:11:55'),
(108, 1, 1, 5, 100, 'Se ha configurado precios para el evento de Nataly Ramirez - discoteca la hacienda 2 de Mayo de 2025', 1, '2025-05-05 10:12:03'),
(109, 6, 1, 5, 100, 'Se ha configurado precios para el evento de Nataly Ramirez - discoteca la hacienda 2 de Mayo de 2025', 1, '2025-05-05 10:12:03'),
(110, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 3 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:13:50'),
(111, 6, 1, 4, 101, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-05 10:14:27'),
(112, 6, 1, 5, 101, 'Se ha configurado precios para el evento de Nataly Ramirez - Paramo Centro Recreacional 3 de Mayo de 2025', 1, '2025-05-05 10:14:42'),
(113, 1, 1, 5, 101, 'Se ha configurado precios para el evento de Nataly Ramirez - Paramo Centro Recreacional 3 de Mayo de 2025', 1, '2025-05-05 10:14:42'),
(114, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:16:15'),
(115, 6, 1, 4, 102, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-05 10:16:31'),
(116, 1, 1, 5, 102, 'Se ha configurado precios para el evento de Nataly Ramirez - La Choza CutervinaMedio Dia 4 de Mayo de 2025', 1, '2025-05-05 10:16:37'),
(117, 6, 1, 5, 102, 'Se ha configurado precios para el evento de Nataly Ramirez - La Choza CutervinaMedio Dia 4 de Mayo de 2025', 1, '2025-05-05 10:16:37'),
(118, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:17:41'),
(119, 6, 1, 4, 103, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-05 10:17:57'),
(120, 6, 1, 5, 103, 'Se ha configurado precios para el evento de Nataly Ramirez - Discoteca La Hacienda Noche 4 de Mayo de 2025', 1, '2025-05-05 10:18:06'),
(121, 1, 1, 5, 103, 'Se ha configurado precios para el evento de Nataly Ramirez - Discoteca La Hacienda Noche 4 de Mayo de 2025', 1, '2025-05-05 10:18:06'),
(122, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:19:23'),
(123, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:20:13'),
(124, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:21:22'),
(125, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:22:01'),
(126, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:23:18'),
(127, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:24:58'),
(128, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:26:06'),
(129, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:27:01'),
(130, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 12 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:28:52'),
(131, 2, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 10:30:01'),
(132, 6, 1, 4, 113, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-05 10:30:36'),
(133, 6, 1, 4, 112, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-05 10:31:01'),
(134, 1, 1, 5, 112, 'Se ha configurado precios para el evento de Nataly Ramirez - la casa de la cumbia 12 de Mayo de 2025', 1, '2025-05-05 10:31:10'),
(135, 6, 1, 5, 112, 'Se ha configurado precios para el evento de Nataly Ramirez - la casa de la cumbia 12 de Mayo de 2025', 1, '2025-05-05 10:31:10'),
(136, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 17:33:48'),
(137, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-05 19:45:07'),
(138, 8, 1, 2, NULL, 'Royer Alexis Te ha asignado a un nuevo evento para el 16 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-07 16:17:15'),
(139, 16, 1, 4, 104, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-07 16:24:11'),
(140, 1, 9, 4, 8, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-07 17:52:46'),
(141, 16, 1, 4, 1, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-08 14:25:31'),
(142, 16, 1, 4, 2, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-08 14:29:11'),
(143, 16, 1, 4, 3, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-08 14:29:57'),
(144, 16, 1, 4, 4, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-08 14:30:45'),
(145, 16, 1, 4, 5, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-08 14:31:51'),
(146, 16, 1, 4, 6, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-08 14:32:23'),
(147, 16, 1, 4, 7, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-08 14:32:40'),
(148, 1, 8, 2, 1, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:16'),
(149, 6, 8, 2, 1, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:16'),
(150, 9, 8, 2, 1, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:16'),
(151, 16, 8, 2, 1, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:16'),
(152, 17, 8, 2, 1, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:16'),
(153, 18, 8, 2, 1, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:16'),
(154, 19, 8, 2, 1, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:16'),
(155, 21, 8, 2, 1, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:17'),
(156, 22, 8, 2, 1, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:17'),
(157, 1, 8, 2, 2, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:31'),
(158, 6, 8, 2, 2, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:31'),
(159, 9, 8, 2, 2, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:31'),
(160, 16, 8, 2, 2, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:31'),
(161, 17, 8, 2, 2, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:31'),
(162, 18, 8, 2, 2, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:32'),
(163, 19, 8, 2, 2, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:32'),
(164, 21, 8, 2, 2, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:32'),
(165, 22, 8, 2, 2, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:43 PM, click para mas detalles', 1, '2025-05-10 20:43:32'),
(166, 1, 8, 6, 3, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:46 PM, click para mas detalles', 1, '2025-05-10 20:46:54'),
(167, 6, 8, 6, 3, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:46 PM, click para mas detalles', 1, '2025-05-10 20:46:54'),
(168, 9, 8, 6, 3, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:46 PM, click para mas detalles', 1, '2025-05-10 20:46:55'),
(169, 16, 8, 6, 3, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:46 PM, click para mas detalles', 1, '2025-05-10 20:46:55'),
(170, 17, 8, 6, 3, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:46 PM, click para mas detalles', 1, '2025-05-10 20:46:55'),
(171, 18, 8, 6, 3, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:46 PM, click para mas detalles', 1, '2025-05-10 20:46:55'),
(172, 19, 8, 6, 3, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:46 PM, click para mas detalles', 1, '2025-05-10 20:46:55'),
(173, 21, 8, 6, 3, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:46 PM, click para mas detalles', 1, '2025-05-10 20:46:55'),
(174, 22, 8, 6, 3, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:46 PM, click para mas detalles', 1, '2025-05-10 20:46:55'),
(175, 1, 8, 6, 4, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:47 PM, click para mas detalles', 1, '2025-05-10 20:47:34'),
(176, 6, 8, 6, 4, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:47 PM, click para mas detalles', 1, '2025-05-10 20:47:34'),
(177, 9, 8, 6, 4, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:47 PM, click para mas detalles', 1, '2025-05-10 20:47:34'),
(178, 16, 8, 6, 4, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:47 PM, click para mas detalles', 1, '2025-05-10 20:47:34'),
(179, 17, 8, 6, 4, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:47 PM, click para mas detalles', 1, '2025-05-10 20:47:35'),
(180, 18, 8, 6, 4, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:47 PM, click para mas detalles', 1, '2025-05-10 20:47:35'),
(181, 19, 8, 6, 4, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:47 PM, click para mas detalles', 1, '2025-05-10 20:47:35'),
(182, 21, 8, 6, 4, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:47 PM, click para mas detalles', 1, '2025-05-10 20:47:35'),
(183, 22, 8, 6, 4, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:47 PM, click para mas detalles', 1, '2025-05-10 20:47:35'),
(184, 1, 8, 6, 5, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:49 PM, click para mas detalles', 1, '2025-05-10 20:49:57'),
(185, 6, 8, 6, 5, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:49 PM, click para mas detalles', 1, '2025-05-10 20:49:58'),
(186, 9, 8, 6, 5, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:49 PM, click para mas detalles', 1, '2025-05-10 20:49:58'),
(187, 16, 8, 6, 5, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:49 PM, click para mas detalles', 1, '2025-05-10 20:49:58'),
(188, 17, 8, 6, 5, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:49 PM, click para mas detalles', 1, '2025-05-10 20:49:58'),
(189, 18, 8, 6, 5, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:49 PM, click para mas detalles', 1, '2025-05-10 20:49:58'),
(190, 19, 8, 6, 5, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:49 PM, click para mas detalles', 1, '2025-05-10 20:49:58'),
(191, 21, 8, 6, 5, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:49 PM, click para mas detalles', 1, '2025-05-10 20:49:58'),
(192, 22, 8, 6, 5, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 3:49 PM, click para mas detalles', 1, '2025-05-10 20:49:58'),
(193, 1, 8, 6, 6, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:54 PM, click para mas detalles', 1, '2025-05-10 20:55:07'),
(194, 6, 8, 6, 6, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:54 PM, click para mas detalles', 1, '2025-05-10 20:55:07'),
(195, 9, 8, 6, 6, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:54 PM, click para mas detalles', 1, '2025-05-10 20:55:07'),
(196, 16, 8, 6, 6, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:54 PM, click para mas detalles', 1, '2025-05-10 20:55:07'),
(197, 17, 8, 6, 6, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:54 PM, click para mas detalles', 1, '2025-05-10 20:55:08'),
(198, 18, 8, 6, 6, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:54 PM, click para mas detalles', 1, '2025-05-10 20:55:08'),
(199, 19, 8, 6, 6, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:54 PM, click para mas detalles', 1, '2025-05-10 20:55:08'),
(200, 21, 8, 6, 6, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:54 PM, click para mas detalles', 1, '2025-05-10 20:55:08'),
(201, 22, 8, 6, 6, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 3:54 PM, click para mas detalles', 1, '2025-05-10 20:55:08'),
(202, 1, 8, 6, 7, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:00 PM, click para mas detalles', 1, '2025-05-10 21:00:10'),
(203, 6, 8, 6, 7, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:00 PM, click para mas detalles', 1, '2025-05-10 21:00:10'),
(204, 9, 8, 6, 7, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:00 PM, click para mas detalles', 1, '2025-05-10 21:00:10'),
(205, 16, 8, 6, 7, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:00 PM, click para mas detalles', 1, '2025-05-10 21:00:10'),
(206, 17, 8, 6, 7, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:00 PM, click para mas detalles', 1, '2025-05-10 21:00:10'),
(207, 18, 8, 6, 7, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:00 PM, click para mas detalles', 1, '2025-05-10 21:00:11'),
(208, 19, 8, 6, 7, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:00 PM, click para mas detalles', 1, '2025-05-10 21:00:11'),
(209, 21, 8, 6, 7, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:00 PM, click para mas detalles', 1, '2025-05-10 21:00:11'),
(210, 22, 8, 6, 7, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:00 PM, click para mas detalles', 1, '2025-05-10 21:00:11'),
(211, 1, 8, 6, 8, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:01 PM, click para mas detalles', 1, '2025-05-10 21:01:20'),
(212, 6, 8, 6, 8, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:01 PM, click para mas detalles', 1, '2025-05-10 21:01:20'),
(213, 9, 8, 6, 8, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:01 PM, click para mas detalles', 1, '2025-05-10 21:01:20'),
(214, 16, 8, 6, 8, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:01 PM, click para mas detalles', 1, '2025-05-10 21:01:20'),
(215, 17, 8, 6, 8, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:01 PM, click para mas detalles', 1, '2025-05-10 21:01:20'),
(216, 18, 8, 6, 8, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:01 PM, click para mas detalles', 1, '2025-05-10 21:01:21'),
(217, 19, 8, 6, 8, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:01 PM, click para mas detalles', 1, '2025-05-10 21:01:21'),
(218, 21, 8, 6, 8, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:01 PM, click para mas detalles', 1, '2025-05-10 21:01:21'),
(219, 22, 8, 6, 8, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:01 PM, click para mas detalles', 1, '2025-05-10 21:01:21'),
(220, 1, 8, 6, 9, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:02 PM, click para mas detalles', 1, '2025-05-10 21:03:07'),
(221, 6, 8, 6, 9, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:02 PM, click para mas detalles', 1, '2025-05-10 21:03:07'),
(222, 9, 8, 6, 9, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:02 PM, click para mas detalles', 1, '2025-05-10 21:03:07'),
(223, 16, 8, 6, 9, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:02 PM, click para mas detalles', 1, '2025-05-10 21:03:07'),
(224, 17, 8, 6, 9, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:02 PM, click para mas detalles', 1, '2025-05-10 21:03:08'),
(225, 18, 8, 6, 9, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:02 PM, click para mas detalles', 1, '2025-05-10 21:03:08'),
(226, 19, 8, 6, 9, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:02 PM, click para mas detalles', 1, '2025-05-10 21:03:08'),
(227, 21, 8, 6, 9, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:02 PM, click para mas detalles', 1, '2025-05-10 21:03:08'),
(228, 22, 8, 6, 9, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:02 PM, click para mas detalles', 1, '2025-05-10 21:03:08'),
(229, 1, 8, 6, 10, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:07 PM, click para mas detalles', 1, '2025-05-10 21:07:45'),
(230, 6, 8, 6, 10, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:07 PM, click para mas detalles', 1, '2025-05-10 21:07:45'),
(231, 9, 8, 6, 10, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:07 PM, click para mas detalles', 1, '2025-05-10 21:07:45'),
(232, 16, 8, 6, 10, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:07 PM, click para mas detalles', 1, '2025-05-10 21:07:45'),
(233, 17, 8, 6, 10, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:07 PM, click para mas detalles', 1, '2025-05-10 21:07:45'),
(234, 18, 8, 6, 10, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:07 PM, click para mas detalles', 1, '2025-05-10 21:07:46'),
(235, 19, 8, 6, 10, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:07 PM, click para mas detalles', 1, '2025-05-10 21:07:46'),
(236, 21, 8, 6, 10, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:07 PM, click para mas detalles', 1, '2025-05-10 21:07:46'),
(237, 22, 8, 6, 10, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:07 PM, click para mas detalles', 1, '2025-05-10 21:07:46'),
(238, 1, 8, 6, 11, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:09 PM, click para mas detalles', 1, '2025-05-10 21:09:15'),
(239, 6, 8, 6, 11, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:09 PM, click para mas detalles', 1, '2025-05-10 21:09:15'),
(240, 9, 8, 6, 11, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:09 PM, click para mas detalles', 1, '2025-05-10 21:09:15'),
(241, 16, 8, 6, 11, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:09 PM, click para mas detalles', 1, '2025-05-10 21:09:15'),
(242, 17, 8, 6, 11, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:09 PM, click para mas detalles', 1, '2025-05-10 21:09:15'),
(243, 18, 8, 6, 11, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:09 PM, click para mas detalles', 1, '2025-05-10 21:09:15'),
(244, 19, 8, 6, 11, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:09 PM, click para mas detalles', 1, '2025-05-10 21:09:15'),
(245, 21, 8, 6, 11, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:09 PM, click para mas detalles', 1, '2025-05-10 21:09:16'),
(246, 22, 8, 6, 11, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:09 PM, click para mas detalles', 1, '2025-05-10 21:09:16'),
(247, 1, 8, 6, 12, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:13 PM, click para mas detalles', 1, '2025-05-10 21:14:08'),
(248, 6, 8, 6, 12, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:13 PM, click para mas detalles', 1, '2025-05-10 21:14:08'),
(249, 9, 8, 6, 12, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:13 PM, click para mas detalles', 1, '2025-05-10 21:14:08'),
(250, 16, 8, 6, 12, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:13 PM, click para mas detalles', 1, '2025-05-10 21:14:08'),
(251, 17, 8, 6, 12, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:13 PM, click para mas detalles', 1, '2025-05-10 21:14:08'),
(252, 18, 8, 6, 12, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:13 PM, click para mas detalles', 1, '2025-05-10 21:14:09'),
(253, 19, 8, 6, 12, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:13 PM, click para mas detalles', 1, '2025-05-10 21:14:09'),
(254, 21, 8, 6, 12, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:13 PM, click para mas detalles', 1, '2025-05-10 21:14:09'),
(255, 22, 8, 6, 12, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:13 PM, click para mas detalles', 1, '2025-05-10 21:14:09'),
(256, 1, 8, 6, 13, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:17 PM, click para mas detalles', 1, '2025-05-10 21:17:31'),
(257, 6, 8, 6, 13, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:17 PM, click para mas detalles', 1, '2025-05-10 21:17:31'),
(258, 9, 8, 6, 13, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:17 PM, click para mas detalles', 1, '2025-05-10 21:17:31'),
(259, 16, 8, 6, 13, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:17 PM, click para mas detalles', 1, '2025-05-10 21:17:31'),
(260, 17, 8, 6, 13, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:17 PM, click para mas detalles', 1, '2025-05-10 21:17:32'),
(261, 18, 8, 6, 13, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:17 PM, click para mas detalles', 1, '2025-05-10 21:17:32'),
(262, 19, 8, 6, 13, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:17 PM, click para mas detalles', 1, '2025-05-10 21:17:32'),
(263, 21, 8, 6, 13, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:17 PM, click para mas detalles', 1, '2025-05-10 21:17:32'),
(264, 22, 8, 6, 13, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 4:17 PM, click para mas detalles', 1, '2025-05-10 21:17:32'),
(265, 1, 8, 6, 14, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:23 PM, click para mas detalles', 1, '2025-05-10 21:23:25'),
(266, 6, 8, 6, 14, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:23 PM, click para mas detalles', 1, '2025-05-10 21:23:25'),
(267, 9, 8, 6, 14, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:23 PM, click para mas detalles', 1, '2025-05-10 21:23:25'),
(268, 16, 8, 6, 14, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:23 PM, click para mas detalles', 1, '2025-05-10 21:23:25'),
(269, 17, 8, 6, 14, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:23 PM, click para mas detalles', 1, '2025-05-10 21:23:26'),
(270, 18, 8, 6, 14, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:23 PM, click para mas detalles', 1, '2025-05-10 21:23:26'),
(271, 19, 8, 6, 14, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:23 PM, click para mas detalles', 1, '2025-05-10 21:23:26'),
(272, 21, 8, 6, 14, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:23 PM, click para mas detalles', 1, '2025-05-10 21:23:26'),
(273, 22, 8, 6, 14, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:23 PM, click para mas detalles', 1, '2025-05-10 21:23:26'),
(274, 1, 8, 6, 15, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:25 PM, click para mas detalles', 1, '2025-05-10 21:25:53'),
(275, 6, 8, 6, 15, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:25 PM, click para mas detalles', 1, '2025-05-10 21:25:53'),
(276, 9, 8, 6, 15, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:25 PM, click para mas detalles', 1, '2025-05-10 21:25:53'),
(277, 16, 8, 6, 15, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:25 PM, click para mas detalles', 1, '2025-05-10 21:25:53'),
(278, 17, 8, 6, 15, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:25 PM, click para mas detalles', 1, '2025-05-10 21:25:54'),
(279, 18, 8, 6, 15, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:25 PM, click para mas detalles', 1, '2025-05-10 21:25:54'),
(280, 19, 8, 6, 15, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:25 PM, click para mas detalles', 1, '2025-05-10 21:25:54'),
(281, 21, 8, 6, 15, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:25 PM, click para mas detalles', 1, '2025-05-10 21:25:54'),
(282, 22, 8, 6, 15, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:25 PM, click para mas detalles', 1, '2025-05-10 21:25:54'),
(283, 1, 8, 6, 16, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:32 PM, click para mas detalles', 1, '2025-05-10 21:32:29'),
(284, 6, 8, 6, 16, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:32 PM, click para mas detalles', 1, '2025-05-10 21:32:29'),
(285, 9, 8, 6, 16, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:32 PM, click para mas detalles', 1, '2025-05-10 21:32:29'),
(286, 16, 8, 6, 16, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:32 PM, click para mas detalles', 1, '2025-05-10 21:32:29'),
(287, 17, 8, 6, 16, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:32 PM, click para mas detalles', 1, '2025-05-10 21:32:29'),
(288, 18, 8, 6, 16, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:32 PM, click para mas detalles', 1, '2025-05-10 21:32:29'),
(289, 19, 8, 6, 16, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:32 PM, click para mas detalles', 1, '2025-05-10 21:32:29'),
(290, 21, 8, 6, 16, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:32 PM, click para mas detalles', 1, '2025-05-10 21:32:29'),
(291, 22, 8, 6, 16, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:32 PM, click para mas detalles', 1, '2025-05-10 21:32:29'),
(292, 1, 8, 6, 17, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:35 PM, click para mas detalles', 1, '2025-05-10 21:36:02'),
(293, 6, 8, 6, 17, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:35 PM, click para mas detalles', 1, '2025-05-10 21:36:02'),
(294, 9, 8, 6, 17, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:35 PM, click para mas detalles', 1, '2025-05-10 21:36:02'),
(295, 16, 8, 6, 17, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:35 PM, click para mas detalles', 1, '2025-05-10 21:36:02'),
(296, 17, 8, 6, 17, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:35 PM, click para mas detalles', 1, '2025-05-10 21:36:02'),
(297, 18, 8, 6, 17, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:35 PM, click para mas detalles', 1, '2025-05-10 21:36:03'),
(298, 19, 8, 6, 17, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:35 PM, click para mas detalles', 1, '2025-05-10 21:36:03'),
(299, 21, 8, 6, 17, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:35 PM, click para mas detalles', 1, '2025-05-10 21:36:03'),
(300, 22, 8, 6, 17, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:35 PM, click para mas detalles', 1, '2025-05-10 21:36:03'),
(301, 1, 8, 6, 18, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:45 PM, click para mas detalles', 1, '2025-05-10 21:45:19'),
(302, 6, 8, 6, 18, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:45 PM, click para mas detalles', 1, '2025-05-10 21:45:19'),
(303, 9, 8, 6, 18, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:45 PM, click para mas detalles', 1, '2025-05-10 21:45:19'),
(304, 16, 8, 6, 18, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:45 PM, click para mas detalles', 1, '2025-05-10 21:45:19'),
(305, 17, 8, 6, 18, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:45 PM, click para mas detalles', 1, '2025-05-10 21:45:19'),
(306, 18, 8, 6, 18, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:45 PM, click para mas detalles', 1, '2025-05-10 21:45:19'),
(307, 19, 8, 6, 18, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:45 PM, click para mas detalles', 1, '2025-05-10 21:45:19'),
(308, 21, 8, 6, 18, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:45 PM, click para mas detalles', 1, '2025-05-10 21:45:19'),
(309, 22, 8, 6, 18, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:45 PM, click para mas detalles', 1, '2025-05-10 21:45:19'),
(310, 1, 8, 6, 19, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:51 PM, click para mas detalles', 1, '2025-05-10 21:51:12'),
(311, 6, 8, 6, 19, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:51 PM, click para mas detalles', 1, '2025-05-10 21:51:12'),
(312, 9, 8, 6, 19, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:51 PM, click para mas detalles', 1, '2025-05-10 21:51:12'),
(313, 16, 8, 6, 19, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:51 PM, click para mas detalles', 1, '2025-05-10 21:51:12'),
(314, 17, 8, 6, 19, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:51 PM, click para mas detalles', 1, '2025-05-10 21:51:12'),
(315, 18, 8, 6, 19, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:51 PM, click para mas detalles', 1, '2025-05-10 21:51:12'),
(316, 19, 8, 6, 19, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:51 PM, click para mas detalles', 1, '2025-05-10 21:51:12'),
(317, 21, 8, 6, 19, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:51 PM, click para mas detalles', 1, '2025-05-10 21:51:13'),
(318, 22, 8, 6, 19, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:51 PM, click para mas detalles', 1, '2025-05-10 21:51:13'),
(319, 1, 8, 6, 20, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:25'),
(320, 6, 8, 6, 20, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:25'),
(321, 9, 8, 6, 20, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:26'),
(322, 16, 8, 6, 20, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:26'),
(323, 17, 8, 6, 20, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:26'),
(324, 18, 8, 6, 20, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:26'),
(325, 19, 8, 6, 20, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:26'),
(326, 21, 8, 6, 20, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:26'),
(327, 22, 8, 6, 20, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:26'),
(328, 1, 8, 6, 21, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:56'),
(329, 6, 8, 6, 21, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:56'),
(330, 9, 8, 6, 21, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:56'),
(331, 16, 8, 6, 21, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:57'),
(332, 17, 8, 6, 21, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:57'),
(333, 18, 8, 6, 21, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:57'),
(334, 19, 8, 6, 21, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:57'),
(335, 21, 8, 6, 21, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:57'),
(336, 22, 8, 6, 21, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:54 PM, click para mas detalles', 1, '2025-05-10 21:54:57'),
(337, 1, 8, 6, 22, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:55 PM, click para mas detalles', 1, '2025-05-10 21:55:19'),
(338, 6, 8, 6, 22, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:55 PM, click para mas detalles', 1, '2025-05-10 21:55:19'),
(339, 9, 8, 6, 22, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:55 PM, click para mas detalles', 1, '2025-05-10 21:55:20'),
(340, 16, 8, 6, 22, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:55 PM, click para mas detalles', 1, '2025-05-10 21:55:20'),
(341, 17, 8, 6, 22, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:55 PM, click para mas detalles', 1, '2025-05-10 21:55:20');
INSERT INTO `notificaciones` (`idnotificacion`, `idusuariodest`, `idusuariorem`, `tipo`, `idreferencia`, `mensaje`, `estado`, `fecha`) VALUES
(342, 18, 8, 6, 22, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:55 PM, click para mas detalles', 1, '2025-05-10 21:55:20'),
(343, 19, 8, 6, 22, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:55 PM, click para mas detalles', 1, '2025-05-10 21:55:20'),
(344, 21, 8, 6, 22, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:55 PM, click para mas detalles', 1, '2025-05-10 21:55:20'),
(345, 22, 8, 6, 22, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:55 PM, click para mas detalles', 1, '2025-05-10 21:55:20'),
(346, 1, 8, 6, 23, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:56 PM, click para mas detalles', 1, '2025-05-10 21:56:47'),
(347, 6, 8, 6, 23, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:56 PM, click para mas detalles', 1, '2025-05-10 21:56:47'),
(348, 9, 8, 6, 23, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:56 PM, click para mas detalles', 1, '2025-05-10 21:56:47'),
(349, 16, 8, 6, 23, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:56 PM, click para mas detalles', 1, '2025-05-10 21:56:47'),
(350, 17, 8, 6, 23, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:56 PM, click para mas detalles', 1, '2025-05-10 21:56:48'),
(351, 18, 8, 6, 23, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:56 PM, click para mas detalles', 1, '2025-05-10 21:56:48'),
(352, 19, 8, 6, 23, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:56 PM, click para mas detalles', 1, '2025-05-10 21:56:48'),
(353, 21, 8, 6, 23, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:56 PM, click para mas detalles', 1, '2025-05-10 21:56:48'),
(354, 22, 8, 6, 23, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:56 PM, click para mas detalles', 1, '2025-05-10 21:56:48'),
(355, 1, 8, 6, 24, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:59 PM, click para mas detalles', 1, '2025-05-10 21:59:37'),
(356, 6, 8, 6, 24, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:59 PM, click para mas detalles', 1, '2025-05-10 21:59:37'),
(357, 9, 8, 6, 24, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:59 PM, click para mas detalles', 1, '2025-05-10 21:59:37'),
(358, 16, 8, 6, 24, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:59 PM, click para mas detalles', 1, '2025-05-10 21:59:37'),
(359, 17, 8, 6, 24, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:59 PM, click para mas detalles', 1, '2025-05-10 21:59:37'),
(360, 18, 8, 6, 24, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:59 PM, click para mas detalles', 1, '2025-05-10 21:59:38'),
(361, 19, 8, 6, 24, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:59 PM, click para mas detalles', 1, '2025-05-10 21:59:38'),
(362, 21, 8, 6, 24, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:59 PM, click para mas detalles', 1, '2025-05-10 21:59:38'),
(363, 22, 8, 6, 24, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 4:59 PM, click para mas detalles', 1, '2025-05-10 21:59:38'),
(364, 1, 8, 6, 25, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:00 PM, click para mas detalles', 1, '2025-05-10 22:00:17'),
(365, 6, 8, 6, 25, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:00 PM, click para mas detalles', 1, '2025-05-10 22:00:17'),
(366, 9, 8, 6, 25, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:00 PM, click para mas detalles', 1, '2025-05-10 22:00:18'),
(367, 16, 8, 6, 25, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:00 PM, click para mas detalles', 1, '2025-05-10 22:00:18'),
(368, 17, 8, 6, 25, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:00 PM, click para mas detalles', 1, '2025-05-10 22:00:18'),
(369, 18, 8, 6, 25, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:00 PM, click para mas detalles', 1, '2025-05-10 22:00:18'),
(370, 19, 8, 6, 25, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:00 PM, click para mas detalles', 1, '2025-05-10 22:00:18'),
(371, 21, 8, 6, 25, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:00 PM, click para mas detalles', 1, '2025-05-10 22:00:18'),
(372, 22, 8, 6, 25, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:00 PM, click para mas detalles', 1, '2025-05-10 22:00:18'),
(373, 1, 8, 6, 26, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:03:22'),
(374, 6, 8, 6, 26, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:03:22'),
(375, 9, 8, 6, 26, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:03:22'),
(376, 16, 8, 6, 26, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:03:22'),
(377, 17, 8, 6, 26, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:03:22'),
(378, 18, 8, 6, 26, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:03:22'),
(379, 19, 8, 6, 26, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:03:23'),
(380, 21, 8, 6, 26, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:03:23'),
(381, 22, 8, 6, 26, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:03:23'),
(382, 1, 8, 6, 27, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:04:07'),
(383, 6, 8, 6, 27, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:04:07'),
(384, 9, 8, 6, 27, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:04:07'),
(385, 16, 8, 6, 27, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:04:07'),
(386, 17, 8, 6, 27, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:04:07'),
(387, 18, 8, 6, 27, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:04:07'),
(388, 19, 8, 6, 27, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:04:07'),
(389, 21, 8, 6, 27, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:04:07'),
(390, 22, 8, 6, 27, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:03 PM, click para mas detalles', 1, '2025-05-10 22:04:08'),
(391, 1, 8, 6, 28, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:02'),
(392, 6, 8, 6, 28, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:02'),
(393, 9, 8, 6, 28, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:02'),
(394, 16, 8, 6, 28, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:02'),
(395, 17, 8, 6, 28, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:02'),
(396, 18, 8, 6, 28, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:02'),
(397, 19, 8, 6, 28, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:02'),
(398, 21, 8, 6, 28, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:02'),
(399, 22, 8, 6, 28, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:03'),
(400, 1, 8, 6, 29, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:07'),
(401, 6, 8, 6, 29, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:07'),
(402, 9, 8, 6, 29, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:07'),
(403, 16, 8, 6, 29, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:08'),
(404, 17, 8, 6, 29, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:08'),
(405, 18, 8, 6, 29, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:08'),
(406, 19, 8, 6, 29, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:08'),
(407, 21, 8, 6, 29, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:08'),
(408, 22, 8, 6, 29, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:04 PM, click para mas detalles', 1, '2025-05-10 22:05:08'),
(409, 1, 8, 6, 30, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:05 PM, click para mas detalles', 1, '2025-05-10 22:05:24'),
(410, 6, 8, 6, 30, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:05 PM, click para mas detalles', 1, '2025-05-10 22:05:24'),
(411, 9, 8, 6, 30, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:05 PM, click para mas detalles', 1, '2025-05-10 22:05:24'),
(412, 16, 8, 6, 30, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:05 PM, click para mas detalles', 1, '2025-05-10 22:05:25'),
(413, 17, 8, 6, 30, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:05 PM, click para mas detalles', 1, '2025-05-10 22:05:25'),
(414, 18, 8, 6, 30, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:05 PM, click para mas detalles', 1, '2025-05-10 22:05:25'),
(415, 19, 8, 6, 30, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:05 PM, click para mas detalles', 1, '2025-05-10 22:05:25'),
(416, 21, 8, 6, 30, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:05 PM, click para mas detalles', 1, '2025-05-10 22:05:25'),
(417, 22, 8, 6, 30, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:05 PM, click para mas detalles', 1, '2025-05-10 22:05:25'),
(418, 1, 8, 6, 31, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:18'),
(419, 6, 8, 6, 31, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:19'),
(420, 9, 8, 6, 31, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:19'),
(421, 16, 8, 6, 31, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:19'),
(422, 17, 8, 6, 31, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:19'),
(423, 18, 8, 6, 31, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:19'),
(424, 19, 8, 6, 31, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:19'),
(425, 21, 8, 6, 31, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:19'),
(426, 22, 8, 6, 31, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:19'),
(427, 1, 8, 6, 32, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:51'),
(428, 6, 8, 6, 32, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:51'),
(429, 9, 8, 6, 32, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:51'),
(430, 16, 8, 6, 32, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:51'),
(431, 17, 8, 6, 32, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:52'),
(432, 18, 8, 6, 32, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:52'),
(433, 19, 8, 6, 32, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:52'),
(434, 21, 8, 6, 32, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:52'),
(435, 22, 8, 6, 32, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 10 de Mayo de 2025 a las 5:06 PM, click para mas detalles', 1, '2025-05-10 22:06:52'),
(436, 1, 8, 6, 33, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:07 PM, click para mas detalles', 1, '2025-05-10 22:07:54'),
(437, 6, 8, 6, 33, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:07 PM, click para mas detalles', 1, '2025-05-10 22:07:54'),
(438, 9, 8, 6, 33, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:07 PM, click para mas detalles', 1, '2025-05-10 22:07:54'),
(439, 16, 8, 6, 33, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:07 PM, click para mas detalles', 1, '2025-05-10 22:07:54'),
(440, 17, 8, 6, 33, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:07 PM, click para mas detalles', 1, '2025-05-10 22:07:54'),
(441, 18, 8, 6, 33, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:07 PM, click para mas detalles', 1, '2025-05-10 22:07:54'),
(442, 19, 8, 6, 33, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:07 PM, click para mas detalles', 1, '2025-05-10 22:07:54'),
(443, 21, 8, 6, 33, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:07 PM, click para mas detalles', 1, '2025-05-10 22:07:55'),
(444, 22, 8, 6, 33, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:07 PM, click para mas detalles', 1, '2025-05-10 22:07:55'),
(445, 1, 8, 6, 34, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:35'),
(446, 6, 8, 6, 34, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:35'),
(447, 9, 8, 6, 34, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:35'),
(448, 16, 8, 6, 34, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:35'),
(449, 17, 8, 6, 34, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:35'),
(450, 18, 8, 6, 34, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:35'),
(451, 19, 8, 6, 34, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:35'),
(452, 21, 8, 6, 34, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:35'),
(453, 22, 8, 6, 34, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:36'),
(454, 1, 8, 6, 35, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:55'),
(455, 6, 8, 6, 35, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:55'),
(456, 9, 8, 6, 35, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:55'),
(457, 16, 8, 6, 35, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:55'),
(458, 17, 8, 6, 35, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:55'),
(459, 18, 8, 6, 35, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:56'),
(460, 19, 8, 6, 35, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:56'),
(461, 21, 8, 6, 35, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:56'),
(462, 22, 8, 6, 35, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:08 PM, click para mas detalles', 1, '2025-05-10 22:08:56'),
(463, 1, 8, 6, 36, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:16'),
(464, 6, 8, 6, 36, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:16'),
(465, 9, 8, 6, 36, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:16'),
(466, 16, 8, 6, 36, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:16'),
(467, 17, 8, 6, 36, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:16'),
(468, 18, 8, 6, 36, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:16'),
(469, 19, 8, 6, 36, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:16'),
(470, 21, 8, 6, 36, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:16'),
(471, 22, 8, 6, 36, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:16'),
(472, 1, 8, 6, 37, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:50'),
(473, 6, 8, 6, 37, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:50'),
(474, 9, 8, 6, 37, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:50'),
(475, 16, 8, 6, 37, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:50'),
(476, 17, 8, 6, 37, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:50'),
(477, 18, 8, 6, 37, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:51'),
(478, 19, 8, 6, 37, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:51'),
(479, 21, 8, 6, 37, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:51'),
(480, 22, 8, 6, 37, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:10 PM, click para mas detalles', 1, '2025-05-10 22:10:51'),
(481, 1, 8, 6, 38, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:16 PM, click para mas detalles', 1, '2025-05-10 22:16:28'),
(482, 6, 8, 6, 38, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:16 PM, click para mas detalles', 1, '2025-05-10 22:16:28'),
(483, 9, 8, 6, 38, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:16 PM, click para mas detalles', 1, '2025-05-10 22:16:29'),
(484, 16, 8, 6, 38, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:16 PM, click para mas detalles', 1, '2025-05-10 22:16:29'),
(485, 17, 8, 6, 38, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:16 PM, click para mas detalles', 1, '2025-05-10 22:16:29'),
(486, 18, 8, 6, 38, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:16 PM, click para mas detalles', 1, '2025-05-10 22:16:29'),
(487, 19, 8, 6, 38, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:16 PM, click para mas detalles', 1, '2025-05-10 22:16:29'),
(488, 21, 8, 6, 38, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:16 PM, click para mas detalles', 1, '2025-05-10 22:16:29'),
(489, 22, 8, 6, 38, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 10 de Mayo de 2025 a las 5:16 PM, click para mas detalles', 1, '2025-05-10 22:16:29'),
(490, 1, 8, 6, 39, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 11 de Mayo de 2025 a las 10:22 AM, click para mas detalles', 1, '2025-05-11 15:22:43'),
(491, 6, 8, 6, 39, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 11 de Mayo de 2025 a las 10:22 AM, click para mas detalles', 1, '2025-05-11 15:22:43'),
(492, 9, 8, 6, 39, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 11 de Mayo de 2025 a las 10:22 AM, click para mas detalles', 1, '2025-05-11 15:22:43'),
(493, 16, 8, 6, 39, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 11 de Mayo de 2025 a las 10:22 AM, click para mas detalles', 1, '2025-05-11 15:22:43'),
(494, 17, 8, 6, 39, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 11 de Mayo de 2025 a las 10:22 AM, click para mas detalles', 1, '2025-05-11 15:22:43'),
(495, 18, 8, 6, 39, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 11 de Mayo de 2025 a las 10:22 AM, click para mas detalles', 1, '2025-05-11 15:22:43'),
(496, 19, 8, 6, 39, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 11 de Mayo de 2025 a las 10:22 AM, click para mas detalles', 1, '2025-05-11 15:22:43'),
(497, 21, 8, 6, 39, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 11 de Mayo de 2025 a las 10:22 AM, click para mas detalles', 1, '2025-05-11 15:22:43'),
(498, 22, 8, 6, 39, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 11 de Mayo de 2025 a las 10:22 AM, click para mas detalles', 1, '2025-05-11 15:22:44'),
(499, 1, 8, 6, 40, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:15 AM, click para mas detalles', 1, '2025-05-12 15:16:06'),
(500, 6, 8, 6, 40, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:15 AM, click para mas detalles', 1, '2025-05-12 15:16:06'),
(501, 9, 8, 6, 40, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:15 AM, click para mas detalles', 1, '2025-05-12 15:16:07'),
(502, 16, 8, 6, 40, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:15 AM, click para mas detalles', 1, '2025-05-12 15:16:07'),
(503, 17, 8, 6, 40, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:15 AM, click para mas detalles', 1, '2025-05-12 15:16:07'),
(504, 18, 8, 6, 40, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:15 AM, click para mas detalles', 1, '2025-05-12 15:16:07'),
(505, 19, 8, 6, 40, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:15 AM, click para mas detalles', 1, '2025-05-12 15:16:07'),
(506, 21, 8, 6, 40, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:15 AM, click para mas detalles', 1, '2025-05-12 15:16:07'),
(507, 22, 8, 6, 40, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:15 AM, click para mas detalles', 1, '2025-05-12 15:16:07'),
(508, 1, 8, 6, 41, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:16 AM, click para mas detalles', 1, '2025-05-12 15:16:27'),
(509, 6, 8, 6, 41, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:16 AM, click para mas detalles', 1, '2025-05-12 15:16:27'),
(510, 9, 8, 6, 41, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:16 AM, click para mas detalles', 1, '2025-05-12 15:16:27'),
(511, 16, 8, 6, 41, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:16 AM, click para mas detalles', 1, '2025-05-12 15:16:27'),
(512, 17, 8, 6, 41, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:16 AM, click para mas detalles', 1, '2025-05-12 15:16:27'),
(513, 18, 8, 6, 41, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:16 AM, click para mas detalles', 1, '2025-05-12 15:16:27'),
(514, 19, 8, 6, 41, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:16 AM, click para mas detalles', 1, '2025-05-12 15:16:27'),
(515, 21, 8, 6, 41, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:16 AM, click para mas detalles', 1, '2025-05-12 15:16:27'),
(516, 22, 8, 6, 41, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:16 AM, click para mas detalles', 1, '2025-05-12 15:16:28'),
(517, 1, 8, 6, 42, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:33 AM, click para mas detalles', 1, '2025-05-12 15:33:14'),
(518, 6, 8, 6, 42, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:33 AM, click para mas detalles', 1, '2025-05-12 15:33:14'),
(519, 9, 8, 6, 42, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:33 AM, click para mas detalles', 1, '2025-05-12 15:33:14'),
(520, 16, 8, 6, 42, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:33 AM, click para mas detalles', 1, '2025-05-12 15:33:14'),
(521, 17, 8, 6, 42, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:33 AM, click para mas detalles', 1, '2025-05-12 15:33:15'),
(522, 18, 8, 6, 42, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:33 AM, click para mas detalles', 1, '2025-05-12 15:33:15'),
(523, 19, 8, 6, 42, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:33 AM, click para mas detalles', 1, '2025-05-12 15:33:15'),
(524, 21, 8, 6, 42, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:33 AM, click para mas detalles', 1, '2025-05-12 15:33:15'),
(525, 22, 8, 6, 42, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:33 AM, click para mas detalles', 1, '2025-05-12 15:33:15'),
(526, 1, 8, 6, 43, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:34 AM, click para mas detalles', 1, '2025-05-12 15:34:35'),
(527, 6, 8, 6, 43, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:34 AM, click para mas detalles', 1, '2025-05-12 15:34:35'),
(528, 9, 8, 6, 43, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:34 AM, click para mas detalles', 1, '2025-05-12 15:34:35'),
(529, 16, 8, 6, 43, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:34 AM, click para mas detalles', 1, '2025-05-12 15:34:35'),
(530, 17, 8, 6, 43, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:34 AM, click para mas detalles', 1, '2025-05-12 15:34:35'),
(531, 18, 8, 6, 43, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:34 AM, click para mas detalles', 1, '2025-05-12 15:34:35'),
(532, 19, 8, 6, 43, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:34 AM, click para mas detalles', 1, '2025-05-12 15:34:36'),
(533, 21, 8, 6, 43, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:34 AM, click para mas detalles', 1, '2025-05-12 15:34:36'),
(534, 22, 8, 6, 43, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:34 AM, click para mas detalles', 1, '2025-05-12 15:34:36'),
(535, 1, 8, 6, 44, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:39 AM, click para mas detalles', 1, '2025-05-12 15:40:04'),
(536, 6, 8, 6, 44, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:39 AM, click para mas detalles', 1, '2025-05-12 15:40:04'),
(537, 9, 8, 6, 44, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:39 AM, click para mas detalles', 1, '2025-05-12 15:40:04'),
(538, 16, 8, 6, 44, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:39 AM, click para mas detalles', 1, '2025-05-12 15:40:05'),
(539, 17, 8, 6, 44, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:39 AM, click para mas detalles', 1, '2025-05-12 15:40:05'),
(540, 18, 8, 6, 44, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:39 AM, click para mas detalles', 1, '2025-05-12 15:40:05'),
(541, 19, 8, 6, 44, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:39 AM, click para mas detalles', 1, '2025-05-12 15:40:05'),
(542, 21, 8, 6, 44, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:39 AM, click para mas detalles', 1, '2025-05-12 15:40:05'),
(543, 22, 8, 6, 44, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:39 AM, click para mas detalles', 1, '2025-05-12 15:40:05'),
(544, 1, 8, 6, 45, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:50 AM, click para mas detalles', 1, '2025-05-12 15:50:45'),
(545, 6, 8, 6, 45, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:50 AM, click para mas detalles', 1, '2025-05-12 15:50:45'),
(546, 9, 8, 6, 45, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:50 AM, click para mas detalles', 1, '2025-05-12 15:50:46'),
(547, 16, 8, 6, 45, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:50 AM, click para mas detalles', 1, '2025-05-12 15:50:46'),
(548, 17, 8, 6, 45, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:50 AM, click para mas detalles', 1, '2025-05-12 15:50:46'),
(549, 18, 8, 6, 45, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:50 AM, click para mas detalles', 1, '2025-05-12 15:50:46'),
(550, 19, 8, 6, 45, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:50 AM, click para mas detalles', 1, '2025-05-12 15:50:46'),
(551, 21, 8, 6, 45, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:50 AM, click para mas detalles', 1, '2025-05-12 15:50:46'),
(552, 22, 8, 6, 45, 'NATALY RAMIREZ Y ORQUESTA ha acaba de retornar el 12 de Mayo de 2025 a las 10:50 AM, click para mas detalles', 1, '2025-05-12 15:50:46'),
(553, 1, 8, 6, 46, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:55 AM, click para mas detalles', 1, '2025-05-12 15:55:32'),
(554, 6, 8, 6, 46, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:55 AM, click para mas detalles', 1, '2025-05-12 15:55:33'),
(555, 9, 8, 6, 46, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:55 AM, click para mas detalles', 1, '2025-05-12 15:55:33'),
(556, 16, 8, 6, 46, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:55 AM, click para mas detalles', 1, '2025-05-12 15:55:33'),
(557, 17, 8, 6, 46, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:55 AM, click para mas detalles', 1, '2025-05-12 15:55:33'),
(558, 18, 8, 6, 46, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:55 AM, click para mas detalles', 1, '2025-05-12 15:55:33'),
(559, 19, 8, 6, 46, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:55 AM, click para mas detalles', 1, '2025-05-12 15:55:33'),
(560, 21, 8, 6, 46, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:55 AM, click para mas detalles', 1, '2025-05-12 15:55:33'),
(561, 22, 8, 6, 46, 'NATALY RAMIREZ Y ORQUESTA ha acaba de salir el 12 de Mayo de 2025 a las 10:55 AM, click para mas detalles', 1, '2025-05-12 15:55:34'),
(562, 3, 1, 2, 119, 'Royer Alexis Te ha asignado a un nuevo evento para el 4 de Abril de 2025!, revisa tu agenda.', 1, '2025-05-13 17:44:53'),
(563, 16, 1, 4, 119, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-13 17:45:41'),
(564, 16, 1, 4, 23, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-13 17:45:54'),
(565, 16, 1, 4, 25, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-13 17:47:56'),
(566, 16, 1, 4, 26, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-13 17:50:20'),
(567, 16, 1, 4, 27, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-13 17:51:19'),
(568, 16, 1, 4, 28, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-13 17:52:05'),
(569, 16, 1, 4, 31, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-13 17:57:33'),
(570, 8, 22, 2, 120, 'Alex Humberto Te ha asignado a un nuevo evento para el 18 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-13 22:33:31'),
(571, 6, 22, 5, 120, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - Discoteca 10 lukas 18 de Mayo de 2025', 1, '2025-05-13 22:33:45'),
(572, 1, 22, 5, 120, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - Discoteca 10 lukas 18 de Mayo de 2025', 1, '2025-05-13 22:33:45'),
(573, 9, 22, 5, 120, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - Discoteca 10 lukas 18 de Mayo de 2025', 1, '2025-05-13 22:33:45'),
(574, 16, 22, 5, 120, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - Discoteca 10 lukas 18 de Mayo de 2025', 1, '2025-05-13 22:33:45'),
(575, 22, 22, 5, 120, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - Discoteca 10 lukas 18 de Mayo de 2025', 1, '2025-05-13 22:33:45'),
(576, 21, 22, 5, 120, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - Discoteca 10 lukas 18 de Mayo de 2025', 1, '2025-05-13 22:33:45'),
(577, 19, 22, 5, 120, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - Discoteca 10 lukas 18 de Mayo de 2025', 1, '2025-05-13 22:33:45'),
(578, 18, 22, 5, 120, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - Discoteca 10 lukas 18 de Mayo de 2025', 1, '2025-05-13 22:33:45'),
(579, 17, 22, 5, 120, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - Discoteca 10 lukas 18 de Mayo de 2025', 1, '2025-05-13 22:33:45'),
(580, 8, 22, 2, 121, 'Alex Humberto Te ha asignado a un nuevo evento para el 18 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-13 23:02:47'),
(581, 8, 1, 2, 122, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 16:51:09'),
(582, 8, 1, 2, 123, 'Royer Alexis Te ha asignado a un nuevo evento para el 9 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 16:57:59'),
(583, 23, 1, 2, 124, 'Royer Alexis Te ha asignado a un nuevo evento para el 10 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:04:09'),
(584, 3, 1, 2, 125, 'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:09:42'),
(585, 8, 1, 2, 126, 'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:11:20'),
(586, 8, 1, 2, 127, 'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:15:11'),
(587, 23, 1, 2, 128, 'Royer Alexis Te ha asignado a un nuevo evento para el 11 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:17:39'),
(588, 2, 1, 2, 129, 'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:20:23'),
(589, 16, 1, 4, 129, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-19 17:22:34'),
(590, 5, 1, 2, 130, 'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:32:24'),
(591, 23, 1, 2, 131, 'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:34:02'),
(592, 8, 1, 2, 132, 'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:35:43'),
(593, 9, 1, 5, 130, 'Se ha configurado precios para el evento de ESTEFANY LOZANO Y SU PASION MORENA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:36:59'),
(594, 6, 1, 5, 130, 'Se ha configurado precios para el evento de ESTEFANY LOZANO Y SU PASION MORENA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:36:59'),
(595, 1, 1, 5, 130, 'Se ha configurado precios para el evento de ESTEFANY LOZANO Y SU PASION MORENA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:36:59'),
(596, 16, 1, 5, 130, 'Se ha configurado precios para el evento de ESTEFANY LOZANO Y SU PASION MORENA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:36:59'),
(597, 17, 1, 5, 130, 'Se ha configurado precios para el evento de ESTEFANY LOZANO Y SU PASION MORENA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:36:59'),
(598, 22, 1, 5, 130, 'Se ha configurado precios para el evento de ESTEFANY LOZANO Y SU PASION MORENA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:36:59'),
(599, 19, 1, 5, 130, 'Se ha configurado precios para el evento de ESTEFANY LOZANO Y SU PASION MORENA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:36:59'),
(600, 21, 1, 5, 130, 'Se ha configurado precios para el evento de ESTEFANY LOZANO Y SU PASION MORENA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:36:59'),
(601, 18, 1, 5, 130, 'Se ha configurado precios para el evento de ESTEFANY LOZANO Y SU PASION MORENA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:36:59'),
(602, 9, 1, 5, 131, 'Se ha configurado precios para el evento de FRAGANCIA TROPICAL - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:03'),
(603, 1, 1, 5, 131, 'Se ha configurado precios para el evento de FRAGANCIA TROPICAL - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:03'),
(604, 6, 1, 5, 131, 'Se ha configurado precios para el evento de FRAGANCIA TROPICAL - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:03'),
(605, 18, 1, 5, 131, 'Se ha configurado precios para el evento de FRAGANCIA TROPICAL - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:03'),
(606, 19, 1, 5, 131, 'Se ha configurado precios para el evento de FRAGANCIA TROPICAL - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:03'),
(607, 21, 1, 5, 131, 'Se ha configurado precios para el evento de FRAGANCIA TROPICAL - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:03'),
(608, 17, 1, 5, 131, 'Se ha configurado precios para el evento de FRAGANCIA TROPICAL - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:03'),
(609, 22, 1, 5, 131, 'Se ha configurado precios para el evento de FRAGANCIA TROPICAL - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:03'),
(610, 16, 1, 5, 131, 'Se ha configurado precios para el evento de FRAGANCIA TROPICAL - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:03'),
(611, 6, 1, 5, 132, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:05'),
(612, 1, 1, 5, 132, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:05'),
(613, 19, 1, 5, 132, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:05'),
(614, 18, 1, 5, 132, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:05'),
(615, 22, 1, 5, 132, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:05'),
(616, 17, 1, 5, 132, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:05'),
(617, 21, 1, 5, 132, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:05'),
(618, 16, 1, 5, 132, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:05'),
(619, 9, 1, 5, 132, 'Se ha configurado precios para el evento de NATALY RAMIREZ Y ORQUESTA - estadio municipal de mi peru 17 de Mayo de 2025', 1, '2025-05-19 17:37:05'),
(620, 16, 1, 4, 130, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-19 17:37:23'),
(621, 16, 1, 4, 131, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-19 17:37:36'),
(622, 16, 1, 4, 132, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-19 17:38:02'),
(623, 8, 1, 2, 133, 'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:40:41'),
(624, 23, 1, 2, 134, 'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:45:58'),
(625, 3, 1, 2, 135, 'Royer Alexis Te ha asignado a un nuevo evento para el 17 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:47:36'),
(626, 16, 1, 4, 121, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-19 17:49:57'),
(627, 8, 1, 2, 136, 'Royer Alexis Te ha asignado a un nuevo evento para el 24 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:53:32'),
(628, 16, 1, 4, 136, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-19 17:54:10'),
(629, 8, 1, 2, 137, 'Royer Alexis Te ha asignado a un nuevo evento para el 24 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 17:57:02'),
(630, 23, 1, 2, 138, 'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 18:00:22'),
(631, 3, 1, 2, 139, 'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 18:04:38'),
(632, 8, 1, 2, 140, 'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 18:08:14'),
(633, 2, 1, 2, 141, 'Royer Alexis Te ha asignado a un nuevo evento para el 25 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 18:09:19'),
(634, 8, 1, 2, 142, 'Royer Alexis Te ha asignado a un nuevo evento para el 30 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 18:12:51'),
(635, 8, 1, 2, 143, 'Royer Alexis Te ha asignado a un nuevo evento para el 31 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 18:15:13'),
(636, 8, 1, 2, 144, 'Royer Alexis Te ha asignado a un nuevo evento para el 31 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-19 18:17:28'),
(637, 8, 9, 2, 145, 'Wendy Te ha asignado a un nuevo evento para el 25 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-21 22:38:47'),
(638, 8, 9, 2, 146, 'Wendy Te ha asignado a un nuevo evento para el 26 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-21 22:41:11'),
(639, 9, 9, 4, 146, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-21 22:41:58'),
(640, 9, 9, 4, 145, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-21 22:45:13'),
(641, 3, 1, 2, 147, 'Royer Alexis Te ha asignado a un nuevo evento para el 7 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-22 15:16:21'),
(642, 3, 1, 2, 148, 'Royer Alexis Te ha asignado a un nuevo evento para el 13 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-22 15:17:19'),
(643, 3, 1, 2, 149, 'Royer Alexis Te ha asignado a un nuevo evento para el 14 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-22 15:17:56'),
(644, 3, 1, 2, 150, 'Royer Alexis Te ha asignado a un nuevo evento para el 15 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-22 15:18:39'),
(645, 8, 1, 2, 151, 'Royer Alexis Te ha asignado a un nuevo evento para el 6 de Junio de 2025!, revisa tu agenda.', 1, '2025-05-22 23:08:58'),
(646, 2, 1, 2, 152, 'Royer Alexis Te ha asignado a un nuevo evento para el 24 de Mayo de 2025!, revisa tu agenda.', 1, '2025-05-26 21:01:33'),
(647, 16, 1, 4, 152, 'Una nueva propuesta ha llegado, haz click para revisarlo.', 1, '2025-05-26 21:16:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones_viatico`
--

CREATE TABLE `notificaciones_viatico` (
  `idnotificacion_viatico` int(11) NOT NULL,
  `idviatico` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `mensaje` varchar(200) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_contrato`
--

CREATE TABLE `pagos_contrato` (
  `idpagocontrato` int(11) NOT NULL,
  `idcontrato` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tipo_pago` tinyint(4) NOT NULL,
  `noperacion` varchar(20) DEFAULT NULL,
  `fecha_pago` date NOT NULL,
  `hora_pago` time NOT NULL,
  `estado` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `pagos_contrato`
--

INSERT INTO `pagos_contrato` (`idpagocontrato`, `idcontrato`, `monto`, `tipo_pago`, `noperacion`, `fecha_pago`, `hora_pago`, `estado`) VALUES
(4, 5, 13500.00, 2, NULL, '2025-05-13', '12:16:51', 3),
(5, 7, 10000.00, 2, NULL, '2025-05-19', '11:59:12', 1),
(6, 8, 26000.00, 2, NULL, '2025-05-19', '12:00:36', 3),
(7, 9, 25000.00, 2, NULL, '2025-05-19', '12:06:02', 3),
(8, 10, 10000.00, 2, NULL, '2025-05-19', '12:15:48', 1),
(9, 3, 15000.00, 2, NULL, '2025-05-19', '12:28:48', 3),
(10, 4, 15000.00, 2, NULL, '2025-05-19', '12:51:13', 3),
(11, 12, 10000.00, 2, NULL, '2025-05-19', '12:57:53', 1),
(12, 13, 7500.00, 2, NULL, '2025-05-19', '01:18:16', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_cuota`
--

CREATE TABLE `pagos_cuota` (
  `idpagocuota` int(11) NOT NULL,
  `idcuotacomprobante` int(11) NOT NULL,
  `fechapagado` date DEFAULT current_timestamp(),
  `horapagado` time DEFAULT current_timestamp(),
  `montopagado` decimal(10,2) NOT NULL,
  `tipo_pago` tinyint(4) NOT NULL,
  `noperacion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `idpermiso` int(11) NOT NULL,
  `idnivelacceso` int(11) NOT NULL,
  `modulo` varchar(50) NOT NULL,
  `ruta` varchar(100) NOT NULL,
  `texto` varchar(100) DEFAULT NULL,
  `visibilidad` tinyint(1) NOT NULL,
  `icono` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`idpermiso`, `idnivelacceso`, `modulo`, `ruta`, `texto`, `visibilidad`, `icono`) VALUES
(1, 3, 'ventas', '', 'Ventas', 1, 'fa-solid fa-arrow-trend-up'),
(2, 3, 'ventas', 'listar-atencion-cliente', 'Atención al cliente', 0, 'fa-solid fa-users'),
(3, 3, 'ventas', 'registrar-atencion-cliente', '', 0, NULL),
(4, 3, 'ventas', 'update-atencion-cliente', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `idpersona` int(11) NOT NULL,
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
  `update_at` datetime DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`idpersona`, `num_doc`, `apellidos`, `nombres`, `genero`, `direccion`, `telefono`, `telefono2`, `correo`, `iddistrito`, `create_at`, `update_at`) VALUES
(1, '72754752', 'Avalos Romero', 'Royer Alexis', 'M', 'Asent. H. Fe y Alegria Mz D Lt 08', '973189350', NULL, 'royer.190818@email.com', NULL, '2025-04-16 00:31:03', '2025-05-07 16:51:57'),
(2, NULL, 'Calvay', 'Azucena', NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-16 07:54:32', '2025-05-07 17:14:04'),
(3, NULL, NULL, 'Aracely', 'F', NULL, NULL, NULL, NULL, NULL, '2025-04-16 07:58:13', '2025-05-07 17:25:16'),
(4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-16 07:59:09', NULL),
(5, NULL, 'Lozano', 'Estefany', NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-16 08:00:31', '2025-05-07 17:18:59'),
(6, NULL, NULL, 'Nayade', NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-16 12:55:39', NULL),
(7, NULL, 'cornejo', 'andre', NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-16 18:11:43', '2025-05-05 19:29:35'),
(8, NULL, 'Ramirez', 'Nataly', 'F', NULL, NULL, NULL, NULL, NULL, '2025-05-05 09:55:35', '2025-05-07 17:05:02'),
(9, '76546341', 'Rios Tuya', 'Wendy', 'F', NULL, NULL, NULL, NULL, NULL, '2025-05-05 17:11:48', '2025-05-07 16:53:50'),
(10, '76154707', 'Cornejo', 'Andre', NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-05 17:27:31', NULL),
(11, '74556520', 'Miluska Alanya', 'Carolayne', NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-05 19:31:19', '2025-05-07 16:42:38'),
(12, '71408458', 'Cotera Ferrer', 'Jasmin Lizet', 'F', NULL, NULL, NULL, NULL, NULL, '2025-05-05 19:31:58', '2025-05-07 16:53:01'),
(13, '75399911', 'Isique Solorzano', 'Christian Giovanni', NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-05 19:32:51', '2025-05-07 16:37:15'),
(14, '72103695', 'Campos', 'Ray', NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-05 19:33:39', '2025-05-07 16:38:37'),
(15, '73633300', 'Baldeon Matamoros', 'Johan Ayrton', NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-05 19:34:14', '2025-05-07 16:47:27'),
(16, '71314687', 'Vega Pascual', 'Omar', 'F', NULL, NULL, NULL, NULL, NULL, '2025-05-07 01:54:38', '2025-05-07 16:59:32'),
(17, '48499979', 'Cayo', 'Lira', 'F', NULL, NULL, NULL, NULL, NULL, '2025-05-07 01:55:07', '2025-05-07 17:00:21'),
(18, '44885391', 'Vega Pascual', 'Lenin Alevin', 'M', NULL, NULL, NULL, NULL, NULL, '2025-05-07 01:55:52', '2025-05-07 16:55:17'),
(19, '44978297', 'Vega Pascual', 'Orquidea Belinda', NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-07 02:51:57', '2025-05-07 16:58:10'),
(20, '76291402', 'Allccahuaman Chavez', 'Angel David', NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-07 16:41:46', NULL),
(21, '44016935', 'Vega Pascual', 'Denis Edson', 'M', NULL, NULL, NULL, NULL, NULL, '2025-05-07 16:57:00', NULL),
(22, '46733187', 'Guevara Acuña', 'Alex Humberto', 'M', NULL, NULL, NULL, NULL, NULL, '2025-05-07 17:01:33', NULL),
(23, NULL, 'tropical', 'fragancia', 'F', NULL, NULL, NULL, NULL, NULL, '2025-05-07 17:17:09', NULL),
(24, NULL, 'tempestad', 'tempestad', 'M', NULL, NULL, NULL, NULL, NULL, '2025-05-07 17:17:49', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precios_entrada_evento`
--

CREATE TABLE `precios_entrada_evento` (
  `idprecioentradaevento` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) NOT NULL,
  `entradas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `precios_entrada_evento`
--

INSERT INTO `precios_entrada_evento` (`idprecioentradaevento`, `iddetalle_presentacion`, `entradas`) VALUES
(1, 99, 'PREVENTA: 20 Y 40 ALTOKETICKET'),
(2, 100, 'PREVENTA: 30 y 40 vip'),
(3, 101, 'PREVENTA: 30 y 40 vip'),
(4, 102, 'PREVENTA: 30 y 40 vip'),
(5, 103, 'PREVENTA: 30 y 40 vip'),
(6, 112, 'PREVENTA: 30 y 40 vip'),
(8, 130, 'GENERAL 15\r\nVIP 20'),
(9, 131, 'GENERAL 15\r\nVIP 20'),
(10, 132, 'GENERAL 15\r\nVIP 20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prodserv`
--

CREATE TABLE `prodserv` (
  `idprodserv` int(11) NOT NULL,
  `nombre` varchar(80) DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL,
  `codigo` varchar(10) DEFAULT NULL,
  `idproveedor` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `prodserv`
--

INSERT INTO `prodserv` (`idprodserv`, `nombre`, `tipo`, `codigo`, `idproveedor`, `precio`) VALUES
(1, 'producto 1 test', 1, 'PT-123', 1, 800.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `idproveedor` int(11) NOT NULL,
  `empresa` varchar(120) DEFAULT NULL,
  `nombre` varchar(120) DEFAULT NULL,
  `contacto` int(11) DEFAULT NULL,
  `correo` varchar(120) DEFAULT NULL,
  `dni` char(15) DEFAULT NULL,
  `banco` varchar(120) DEFAULT NULL,
  `ctabancaria` int(11) DEFAULT NULL,
  `servicio` varchar(120) DEFAULT NULL,
  `nproveedor` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idproveedor`, `empresa`, `nombre`, `contacto`, `correo`, `dni`, `banco`, `ctabancaria`, `servicio`, `nproveedor`) VALUES
(1, 'test empresa', 'test nombre', 999333222, 'test@gmail.com', '77883322', 'BCP', 123456789, 'venta de entradas', 'NO1234567899');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincias`
--

CREATE TABLE `provincias` (
  `idprovincia` int(11) NOT NULL,
  `iddepartamento` int(11) NOT NULL,
  `provincia` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `provincias`
--

INSERT INTO `provincias` (`idprovincia`, `iddepartamento`, `provincia`) VALUES
(1, 1, 'Bagua'),
(2, 1, 'Bongará'),
(3, 1, 'Chachapoyas'),
(4, 1, 'Condorcanqui'),
(5, 1, 'Luya'),
(6, 1, 'Rodríguez de Mendoza'),
(7, 1, 'Utcubamba'),
(8, 2, 'Aija'),
(9, 2, 'Antonio Raymondi'),
(10, 2, 'Asunción'),
(11, 2, 'Bolognesi'),
(12, 2, 'Carhuaz'),
(13, 2, 'Carlos Fermín Fitzcarrald'),
(14, 2, 'Casma'),
(15, 2, 'Corongo'),
(16, 2, 'Huaraz'),
(17, 2, 'Huari'),
(18, 2, 'Huarmey'),
(19, 2, 'Mariscal Luzuriaga'),
(20, 2, 'Ocros'),
(21, 2, 'Pallasca'),
(22, 2, 'Pomabamba'),
(23, 2, 'Recuay'),
(24, 2, 'Santa'),
(25, 2, 'Sihuas'),
(26, 2, 'Yungay'),
(27, 3, 'Abancay'),
(28, 3, 'Andahuaylas'),
(29, 3, 'Antabamba'),
(30, 3, 'Aymaraes'),
(31, 3, 'Cotabambas'),
(32, 3, 'Chincheros'),
(33, 3, 'Grau'),
(34, 4, 'Arequipa'),
(35, 4, 'Camaná'),
(36, 4, 'Caravelí'),
(37, 4, 'Castilla'),
(38, 4, 'Caylloma'),
(39, 4, 'Condesuyos'),
(40, 4, 'Islay'),
(41, 4, 'La Unión'),
(42, 5, 'Cangallo'),
(43, 5, 'Huamanga'),
(44, 5, 'Huanca Sancos'),
(45, 5, 'Huanta'),
(46, 5, 'La Mar'),
(47, 5, 'Lucanas'),
(48, 5, 'Parinacochas'),
(49, 5, 'Páucar del Sara Sara'),
(50, 5, 'Sucre'),
(51, 5, 'Víctor Fajardo'),
(52, 5, 'Vilcas Huamán'),
(53, 6, 'Cajabamba'),
(54, 6, 'Cajamarca'),
(55, 6, 'Celendín'),
(56, 6, 'Chota'),
(57, 6, 'Contumazá'),
(58, 6, 'Cutervo'),
(59, 6, 'Hualgayoc'),
(60, 6, 'Jaén'),
(61, 6, 'San Ignacio'),
(62, 6, 'San Marcos'),
(63, 6, 'San Miguel'),
(64, 6, 'San Pablo'),
(65, 6, 'Santa Cruz'),
(66, 7, 'Callao'),
(67, 8, 'Acomayo'),
(68, 8, 'Anta'),
(69, 8, 'Calca'),
(70, 8, 'Canas'),
(71, 8, 'Canchis'),
(72, 8, 'Chumbivilcas'),
(73, 8, 'Cusco'),
(74, 8, 'Espinar'),
(75, 8, 'La Convención'),
(76, 8, 'Paruro'),
(77, 8, 'Paucartambo'),
(78, 8, 'Quispicanchi'),
(79, 8, 'Urubamba'),
(80, 9, 'Acobamba'),
(81, 9, 'Angaraes'),
(82, 9, 'Castrovirreyna'),
(83, 9, 'Churcampa'),
(84, 9, 'Huancavelica'),
(85, 9, 'Huaytará'),
(86, 9, 'Tayacaja'),
(87, 10, 'Ambo'),
(88, 10, 'Dos de Mayo'),
(89, 10, 'Huacaybamba'),
(90, 10, 'Huamalíes'),
(91, 10, 'Huánuco'),
(92, 10, 'Lauricocha'),
(93, 10, 'Leoncio Prado'),
(94, 10, 'Marañón'),
(95, 10, 'Pachitea'),
(96, 10, 'Puerto Inca'),
(97, 10, 'Yarowilca'),
(98, 11, 'Chincha'),
(99, 11, 'Ica'),
(100, 11, 'Nazca'),
(101, 11, 'Palpa'),
(102, 11, 'Pisco'),
(103, 12, 'Chanchamayo'),
(104, 12, 'Chupaca'),
(105, 12, 'Concepción'),
(106, 12, 'Huancayo'),
(107, 12, 'Jauja'),
(108, 12, 'Junín'),
(109, 12, 'Satipo'),
(110, 12, 'Tarma'),
(111, 12, 'Yauli'),
(112, 13, 'Ascope'),
(113, 13, 'Bolívar'),
(114, 13, 'Chepén'),
(115, 13, 'Gran Chimú'),
(116, 13, 'Julcán'),
(117, 13, 'Otuzco'),
(118, 13, 'Pacasmayo'),
(119, 13, 'Pataz'),
(120, 13, 'Sánchez Carrión'),
(121, 13, 'Santiago de Chuco'),
(122, 13, 'Trujillo'),
(123, 13, 'Virú'),
(124, 14, 'Chiclayo'),
(125, 14, 'Ferreñafe'),
(126, 14, 'Lambayeque'),
(127, 15, 'Barranca'),
(128, 15, 'Cajatambo'),
(129, 15, 'Canta'),
(130, 15, 'Cañete'),
(131, 15, 'Huaral'),
(132, 15, 'Huarochirí'),
(133, 15, 'Huaura'),
(134, 15, 'Lima'),
(135, 15, 'Oyón'),
(136, 15, 'Yauyos'),
(137, 16, 'Alto Amazonas'),
(138, 16, 'Datem del Marañón'),
(139, 16, 'Loreto'),
(140, 16, 'Mariscal Ramón Castilla'),
(141, 16, 'Maynas'),
(142, 16, 'Putumayo'),
(143, 16, 'Requena'),
(144, 16, 'Ucayali'),
(145, 17, 'Manu'),
(146, 17, 'Tahuamanu'),
(147, 17, 'Tambopata'),
(148, 18, 'General Sánchez Cerro'),
(149, 18, 'Ilo'),
(150, 18, 'Mariscal Nieto'),
(151, 19, 'Daniel Alcides Carrión'),
(152, 19, 'Oxapampa'),
(153, 19, 'Pasco'),
(154, 20, 'Ayabaca'),
(155, 20, 'Huancabamba'),
(156, 20, 'Morropón'),
(157, 20, 'Paita'),
(158, 20, 'Piura'),
(159, 20, 'Sechura'),
(160, 20, 'Sullana'),
(161, 20, 'Talara'),
(162, 21, 'Azángaro'),
(163, 21, 'Carabaya'),
(164, 21, 'Chucuito'),
(165, 21, 'El Collao'),
(166, 21, 'Huancané'),
(167, 21, 'Lampa'),
(168, 21, 'Melgar'),
(169, 21, 'Moho'),
(170, 21, 'Puno'),
(171, 21, 'San Antonio de Putina'),
(172, 21, 'San Román'),
(173, 21, 'Sandia'),
(174, 21, 'Yunguyo'),
(175, 22, 'Bellavista'),
(176, 22, 'El Dorado'),
(177, 22, 'Huallaga'),
(178, 22, 'Lamas'),
(179, 22, 'Mariscal Cáceres'),
(180, 22, 'Moyobamba'),
(181, 22, 'Picota'),
(182, 22, 'Rioja'),
(183, 22, 'San Martín'),
(184, 22, 'Tocache'),
(185, 23, 'Candarave'),
(186, 23, 'Jorge Basadre'),
(187, 23, 'Tacna'),
(188, 23, 'Tarata'),
(189, 24, 'Contralmirante Villar'),
(190, 24, 'Tumbes'),
(191, 24, 'Zarumilla'),
(192, 25, 'Atalaya'),
(193, 25, 'Coronel Portillo'),
(194, 25, 'Padre Abad'),
(195, 25, 'Purús');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reparticion_ingresos`
--

CREATE TABLE `reparticion_ingresos` (
  `idreparticion` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) NOT NULL,
  `estado` tinyint(4) DEFAULT 1
) ;

--
-- Volcado de datos para la tabla `reparticion_ingresos`
--

INSERT INTO `reparticion_ingresos` (`idreparticion`, `iddetalle_presentacion`, `estado`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 16, 1),
(10, 20, 1),
(11, 21, 1),
(12, 22, 1),
(13, 23, 1),
(14, 24, 1),
(15, 25, 1),
(16, 26, 1),
(17, 27, 1),
(18, 28, 1),
(19, 29, 1),
(20, 30, 1),
(21, 31, 1),
(22, 32, 1),
(23, 33, 1),
(24, 34, 1),
(25, 35, 1),
(26, 36, 1),
(27, 37, 1),
(28, 38, 1),
(29, 39, 1),
(30, 40, 1),
(31, 41, 1),
(32, 42, 1),
(33, 43, 1),
(34, 44, 1),
(35, 45, 1),
(36, 46, 1),
(37, 47, 1),
(38, 48, 1),
(39, 49, 1),
(40, 50, 1),
(41, 51, 1),
(42, 52, 1),
(43, 53, 1),
(44, 54, 1),
(45, 55, 1),
(46, 56, 1),
(47, 57, 1),
(48, 58, 1),
(49, 59, 1),
(50, 60, 1),
(51, 61, 1),
(52, 62, 1),
(53, 63, 1),
(55, 96, 1),
(56, 119, 1),
(58, 121, 1),
(60, 129, 1),
(61, 130, 1),
(62, 131, 1),
(63, 132, 1),
(64, 133, 1),
(65, 134, 1),
(66, 135, 1),
(67, 136, 1),
(68, 139, 1),
(69, 140, 1),
(70, 141, 1),
(71, 143, 1),
(72, 145, 1),
(73, 146, 1),
(74, 147, 1),
(75, 148, 1),
(76, 149, 1),
(77, 150, 1),
(78, 152, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes_artista_evento`
--

CREATE TABLE `reportes_artista_evento` (
  `idreporte` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `fecha` date DEFAULT current_timestamp(),
  `hora` time DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reportes_artista_evento`
--

INSERT INTO `reportes_artista_evento` (`idreporte`, `iddetalle_presentacion`, `tipo`, `fecha`, `hora`) VALUES
(1, 98, 1, '2025-05-10', '15:43:07'),
(2, 98, 2, '2025-05-10', '15:43:22'),
(3, 97, 1, '2025-05-10', '15:46:45'),
(4, 97, 1, '2025-05-10', '15:47:25'),
(5, 98, 2, '2025-05-10', '15:49:49'),
(6, 101, 1, '2025-05-10', '15:54:58'),
(7, 97, 1, '2025-05-10', '16:00:01'),
(8, 97, 1, '2025-05-10', '16:01:11'),
(9, 102, 1, '2025-05-10', '16:02:58'),
(10, 104, 2, '2025-05-10', '16:07:36'),
(11, 104, 1, '2025-05-10', '16:09:06'),
(12, 104, 2, '2025-05-10', '16:13:59'),
(13, 104, 2, '2025-05-10', '16:17:22'),
(14, 118, 1, '2025-05-10', '16:23:16'),
(15, 117, 1, '2025-05-10', '16:25:45'),
(16, 112, 1, '2025-05-10', '16:32:20'),
(17, 104, 1, '2025-05-10', '16:35:53'),
(18, 102, 1, '2025-05-10', '16:45:10'),
(19, 98, 1, '2025-05-10', '16:51:03'),
(20, 104, 1, '2025-05-10', '16:54:17'),
(21, 104, 1, '2025-05-10', '16:54:47'),
(22, 104, 1, '2025-05-10', '16:55:11'),
(23, 100, 1, '2025-05-10', '16:56:38'),
(24, 101, 1, '2025-05-10', '16:59:28'),
(25, 100, 1, '2025-05-10', '17:00:09'),
(26, 104, 1, '2025-05-10', '17:03:13'),
(27, 101, 1, '2025-05-10', '17:03:58'),
(28, 98, 1, '2025-05-10', '17:04:53'),
(29, 97, 1, '2025-05-10', '17:04:59'),
(30, 97, 1, '2025-05-10', '17:05:16'),
(31, 97, 1, '2025-05-10', '17:06:10'),
(32, 97, 2, '2025-05-10', '17:06:42'),
(33, 97, 1, '2025-05-10', '17:07:45'),
(34, 97, 1, '2025-05-10', '17:08:26'),
(35, 97, 1, '2025-05-10', '17:08:46'),
(36, 97, 1, '2025-05-10', '17:10:07'),
(37, 97, 1, '2025-05-10', '17:10:41'),
(38, 97, 1, '2025-05-10', '17:16:20'),
(39, 97, 1, '2025-05-11', '10:22:34'),
(40, 97, 1, '2025-05-12', '10:15:57'),
(41, 97, 2, '2025-05-12', '10:16:18'),
(42, 97, 1, '2025-05-12', '10:33:05'),
(43, 98, 2, '2025-05-12', '10:34:26'),
(44, 97, 2, '2025-05-12', '10:39:51'),
(45, 97, 2, '2025-05-12', '10:50:36'),
(46, 97, 1, '2025-05-12', '10:55:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `idreserva` int(11) NOT NULL,
  `idpagocontrato` int(11) NOT NULL,
  `vigencia` int(11) NOT NULL,
  `fechacreada` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responsables_boleteria_contratoreservasreservas`
--

CREATE TABLE `responsables_boleteria_contratoreservasreservas` (
  `idresponsablecontrato` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) NOT NULL,
  `idusuarioBoleteria` int(11) DEFAULT NULL,
  `idusuarioContrato` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `responsables_boleteria_contratoreservasreservas`
--

INSERT INTO `responsables_boleteria_contratoreservasreservas` (`idresponsablecontrato`, `iddetalle_presentacion`, `idusuarioBoleteria`, `idusuarioContrato`) VALUES
(3, 30, 19, 19),
(4, 31, 19, 19),
(5, 129, 19, 19),
(6, 130, 19, 19),
(7, 131, 19, 19),
(8, 132, 19, 19),
(9, 133, 19, 16),
(10, 18, 16, 16),
(11, 136, 19, 16),
(12, 139, 19, 16),
(13, 140, 19, 16),
(14, 141, 19, 16),
(15, 7, 19, 16),
(16, 143, 19, 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salarios`
--

CREATE TABLE `salarios` (
  `idsalario` int(11) NOT NULL,
  `idcolaborador` int(11) NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `periodo` int(11) NOT NULL,
  `horas` decimal(10,2) NOT NULL,
  `costohora` decimal(10,2) NOT NULL,
  `fechainicio` date DEFAULT current_timestamp(),
  `fechafin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subidas_agenda_edicion`
--

CREATE TABLE `subidas_agenda_edicion` (
  `idsubida` int(11) NOT NULL,
  `idagendaeditor` int(11) NOT NULL,
  `url` text NOT NULL,
  `observaciones` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursales`
--

CREATE TABLE `sucursales` (
  `idsucursal` int(11) NOT NULL,
  `idempresa` int(11) NOT NULL,
  `iddistrito` int(11) NOT NULL,
  `idresponsable` int(11) DEFAULT NULL,
  `nombre` varchar(120) DEFAULT NULL,
  `ruc` char(11) NOT NULL,
  `telefono` char(20) DEFAULT NULL,
  `direccion` varchar(120) NOT NULL,
  `email` varchar(120) DEFAULT NULL,
  `ubigeo` char(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sucursales`
--

INSERT INTO `sucursales` (`idsucursal`, `idempresa`, `iddistrito`, `idresponsable`, `nombre`, `ruc`, `telefono`, `direccion`, `email`, `ubigeo`) VALUES
(1, 1, 1337, 19, 'NEGOCIACIONES Y PRODUCCIONES VEGA S.A.C.', '20123456789', '970666528', 'Jr. Los Jazmines 110, Los Olivos 15302', 'vegaproducciones.a@gmail.com', '150143');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas_diarias`
--

CREATE TABLE `tareas_diarias` (
  `idtareadiaria` int(11) NOT NULL,
  `tarea` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tareas_diarias`
--

INSERT INTO `tareas_diarias` (`idtareadiaria`, `tarea`) VALUES
(1, 'Grabacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas_diaria_asignacion`
--

CREATE TABLE `tareas_diaria_asignacion` (
  `idtaradiariaasig` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idtareadiaria` int(11) NOT NULL,
  `fecha_entrega` date NOT NULL,
  `hora_entrega` time NOT NULL,
  `estado` smallint(6) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tareas_diaria_asignacion`
--

INSERT INTO `tareas_diaria_asignacion` (`idtaradiariaasig`, `idusuario`, `idtareadiaria`, `fecha_entrega`, `hora_entrega`, `estado`) VALUES
(1, 7, 1, '2025-05-12', '10:22:00', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifario`
--

CREATE TABLE `tarifario` (
  `idtarifario` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idprovincia` int(11) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `tipo_evento` int(11) NOT NULL,
  `idnacionalidad` int(11) DEFAULT NULL,
  `precioExtranjero` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tarifario`
--

INSERT INTO `tarifario` (`idtarifario`, `idusuario`, `idprovincia`, `precio`, `tipo_evento`, `idnacionalidad`, `precioExtranjero`) VALUES
(1, 2, 100, 80000.00, 1, NULL, NULL),
(2, 8, 122, 30000.00, 1, 31, NULL),
(3, 8, 161, 30000.00, 2, 31, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipotarea`
--

CREATE TABLE `tipotarea` (
  `idtipotarea` int(11) NOT NULL,
  `tipotarea` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipotarea`
--

INSERT INTO `tipotarea` (`idtipotarea`, `tipotarea`) VALUES
(1, 'Flayer'),
(2, 'Saludos'),
(3, 'Reels'),
(4, 'Fotos'),
(5, 'Contenido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idnivelacceso` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL,
  `nom_usuario` varchar(120) NOT NULL,
  `claveacceso` varbinary(255) NOT NULL,
  `color` char(7) DEFAULT NULL,
  `porcentaje` int(11) DEFAULT NULL,
  `marcaagua` varchar(80) DEFAULT NULL,
  `firma` varchar(80) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuario`, `idsucursal`, `idnivelacceso`, `idpersona`, `nom_usuario`, `claveacceso`, `color`, `porcentaje`, `marcaagua`, `firma`, `estado`, `create_at`, `update_at`) VALUES
(1, 1, 3, 1, 'RA72754752', 0x243279243130244534745037666d4555496879307a43397838374d412e3338366d6e6e32563071724b4b2f7954715835414b43665a48594a64456765, '#000000', NULL, 'null', 'firmas_vegaproducciones/wkkxtnumsvg1bo5o5f2c', 1, '2025-04-16 00:31:03', '2025-05-17 03:07:53'),
(2, 1, 6, 2, 'AZUCENA CALVAY Y ORQUESTA', 0x24327924313024445638732e57654f317171703076616a525a5637517537767375596733524978734d6435636857444e6b7146667071676874526375, '#fbff00', 25, 'marcadeagua_vegaproducciones/f1vnhtxphdg5mponyt9a', 'null', 1, '2025-04-16 07:54:32', '2025-05-07 17:20:01'),
(3, 1, 6, 3, 'ARACELY Y SU ALMA REBELDE', 0x24327924313024574e45305649646431414d5177774d2f4277764569656b39736b334c417a7754434357767130476d7338374744454e4934667a442e, '#ca8bfe', 70, 'null', 'null', 1, '2025-04-16 07:58:13', '2025-05-07 17:25:14'),
(4, 1, 6, 4, 'Oscar Manuel', 0x24327924313024724a705166344766653570696d3930744d4b6f33764f4444307339346f52563669714755656633686b415752566e736b6f5972774b, '#4dff00', 75, NULL, NULL, 2, '2025-04-16 07:59:10', '2025-05-07 02:35:53'),
(5, 1, 6, 5, 'ESTEFANY LOZANO Y SU PASION MORENA', 0x2432792431302431366b336b6f6d747632586a3943372f783856486c755142747465775430384f3573643868494e7667624b365a7651484b3265426d, '#04ff00', 70, 'null', 'null', 1, '2025-04-16 08:00:31', '2025-05-07 17:25:49'),
(6, 1, 3, 6, 'Nayade Admin', 0x243279243130246d636d37433334594a5a7a5679416d43626f73756e2e31323546474175443756377a7451446f6c757255554c656462692f38744453, '#000000', NULL, NULL, NULL, 2, '2025-04-16 12:55:39', '2025-05-07 02:38:43'),
(7, 1, 10, 7, 'AC76154707', 0x24327924313024466679766e5a2e6d59306351454837336f4a5551324f675a51324e6d537752706c7056585249513361777836484948544e6e6e344b, '#000000', NULL, 'null', 'null', 1, '2025-04-16 18:11:44', '2025-05-07 16:48:25'),
(8, 1, 6, 8, 'NATALY RAMIREZ Y ORQUESTA', 0x24327924313024694b55703543674567477a3537614b43737a346871754171754a67614a413571704e3036796a564d7055394f594648704e327a3143, '#00fbff', 50, 'marcadeagua_vegaproducciones/tx0icnzqkqkcktk6ssyx', 'null', 1, '2025-05-05 09:55:44', '2025-05-07 17:34:53'),
(9, 1, 3, 9, 'WR76546341', 0x24327924313024446c55577044554e693662453637456f314f3553327551624a69524567444b704764684250566e724365494c304c636b3177756243, '#000000', NULL, 'null', 'null', 1, '2025-05-05 17:11:48', '2025-05-07 16:53:49'),
(11, 1, 11, 11, 'CA74556520', 0x24327924313024616a39703873504353552e36694e4a7a354f6665652e3474654a704765593451533854444a7937306837765257334d4278322f3971, '#000000', NULL, 'null', 'null', 1, '2025-05-05 19:31:19', '2025-05-07 16:33:48'),
(12, 1, 8, 12, 'JC71408458', 0x2432792431302436667649357775576e6f65556f457859516633754d6537533377734c666e5443634c70786841556352546f765a36564f776344794b, '#000000', NULL, 'null', 'null', 1, '2025-05-05 19:31:59', '2025-05-07 16:53:00'),
(13, 1, 11, 13, 'CI75399911', 0x24327924313024437432625438746939304e58366f756962364b4375655078324a4e55467a335174595a4441696b307a4b6d5551427a35556a4f6d2e, '#000000', NULL, 'null', 'null', 1, '2025-05-05 19:32:52', '2025-05-07 16:35:42'),
(14, 1, 11, 14, 'RC72103695', 0x24327924313024714d7452502e726a583353427574753754654f78684f6c5a496e67694f594b757459534a74726c6530653471377558564f454c7353, '#000000', NULL, 'null', 'null', 1, '2025-05-05 19:33:40', '2025-05-07 16:32:01'),
(15, 1, 11, 15, 'JB73633300', 0x243279243130242f7245314a692f654d496c524667357670344436394f32477a6e503859455776305856506e52324241685830353868363447635147, '#000000', NULL, 'null', 'null', 1, '2025-05-05 19:34:14', '2025-05-07 16:32:25'),
(16, 1, 3, 16, 'GERENTE', 0x243279243130246b5944494e704a624e37374e64572f394f7462544d2e6849497665524b4e585637676b5a577338327145686d527457312e7a757861, '#000000', NULL, 'null', 'null', 1, '2025-05-07 01:54:38', '2025-05-07 16:59:37'),
(17, 1, 3, 17, 'LC48499979', 0x243279243130246d4757386946364f594f546c694b756261385959796547306e6f7850534e4f71436138472e616f753754756b6368507a654b385065, '#000000', NULL, 'null', 'null', 1, '2025-05-07 01:55:07', '2025-05-07 17:00:19'),
(18, 1, 3, 18, 'LV44885391', 0x243279243130242f6d49696c756b34554477773437472f6f53756d7075376c6f6c4b56506d523464627436795a706f78587a54526473306964794c4b, '#000000', NULL, 'null', 'null', 1, '2025-05-07 01:55:52', '2025-05-07 16:55:19'),
(19, 1, 3, 19, 'OV44978297', 0x24327924313024766b39596e355034634b36657a7731342e4a6134766541343258715a514c6974747475347a61507a6e474a42566633507667437032, '#000000', NULL, 'null', 'null', 1, '2025-05-07 02:51:57', '2025-05-07 16:58:11'),
(20, 1, 10, 20, 'AA76291402', 0x243279243130244d444561414a4139584b364a673169316f507235422e35766571353169495276704142394c51324230374e796559396e313156426d, '#000000', NULL, NULL, NULL, 1, '2025-05-07 16:41:46', NULL),
(21, 1, 3, 21, 'DV44016935', 0x2432792431302441552e546f664d4653574c70314c7059324f744f3365676a7a6973743050467a583545316164484478626d5a7a69684e32716e5132, '#000000', NULL, NULL, NULL, 1, '2025-05-07 16:57:00', NULL),
(22, 1, 3, 22, 'AG46733187', 0x24327924313024454c2e4b7a35484d69497a5764636f515357374b657566574e70347263437a556b357363486e454a6b504875613363643058646a4b, '#000000', NULL, NULL, NULL, 1, '2025-05-07 17:01:33', NULL),
(23, 1, 6, 23, 'FRAGANCIA TROPICAL', 0x243279243130247842456d614d4d56426a4a6c656f4c774c52344a4e757a6249464e524d356c7368325a706373725a3862753679694763797a367371, '#fe7676', 70, 'null', 'null', 1, '2025-05-07 17:17:09', '2025-05-07 17:28:07'),
(24, 1, 6, 24, 'TEMPESTAD', 0x24327924313024677446753663456d3278344d6170722f6c666934482e774d574b565a4e6c75534158497179502e434849484275376b573755535436, '#901313', 10, NULL, NULL, 1, '2025-05-07 17:17:49', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viaticos`
--

CREATE TABLE `viaticos` (
  `idviatico` int(11) NOT NULL,
  `iddetalle_presentacion` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `pasaje` decimal(7,2) DEFAULT NULL,
  `hospedaje` decimal(7,2) DEFAULT NULL,
  `desayuno` tinyint(4) DEFAULT NULL,
  `almuerzo` tinyint(4) DEFAULT NULL,
  `cena` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agenda_asignaciones`
--
ALTER TABLE `agenda_asignaciones`
  ADD PRIMARY KEY (`idasignacion`),
  ADD KEY `iddetalle_presentacion` (`iddetalle_presentacion`),
  ADD KEY `idusuario` (`idusuario`);

--
-- Indices de la tabla `agenda_commanager`
--
ALTER TABLE `agenda_commanager`
  ADD PRIMARY KEY (`idagendacommanager`),
  ADD KEY `fk_idagendaeditor_cm` (`idagendaeditor`),
  ADD KEY `fk_idusuarioCmanaget` (`idusuarioCmanager`);

--
-- Indices de la tabla `agenda_edicion`
--
ALTER TABLE `agenda_edicion`
  ADD PRIMARY KEY (`idagendaedicion`),
  ADD KEY `fk_iddp_ag_edicion` (`iddetalle_presentacion`);

--
-- Indices de la tabla `agenda_editores`
--
ALTER TABLE `agenda_editores`
  ADD PRIMARY KEY (`idagendaeditor`),
  ADD KEY `fk_idagendaedicion` (`idagendaedicion`),
  ADD KEY `fk_idusuario_ag_edit` (`idusuario`),
  ADD KEY `fk_idtipotarea_agen` (`idtipotarea`);

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`idarea`);

--
-- Indices de la tabla `cajachica`
--
ALTER TABLE `cajachica`
  ADD PRIMARY KEY (`idcajachica`),
  ADD KEY `fk_iddp_cajachicaa` (`iddetalle_presentacion`),
  ADD KEY `fk_idmonto_caja` (`idmonto`),
  ADD KEY `fk_idusuario_abierto` (`creadopor`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idcliente`),
  ADD UNIQUE KEY `uk_telefono` (`telefono`),
  ADD UNIQUE KEY `uk_numdocumento_cli` (`ndocumento`),
  ADD KEY `fk_iddistrito_cli` (`iddistrito`);

--
-- Indices de la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  ADD PRIMARY KEY (`idcolaborador`),
  ADD KEY `fk_idpersona_colaborador` (`idpersona`),
  ADD KEY `fk_idarea_colaborador` (`idarea`),
  ADD KEY `fk_idsucursal_colaborador` (`idsucursal`),
  ADD KEY `fk_idresponsable_colaborador` (`idresponsable`);

--
-- Indices de la tabla `comprobantes`
--
ALTER TABLE `comprobantes`
  ADD PRIMARY KEY (`idcomprobante`),
  ADD KEY `fk_idcliente_comp` (`idcliente`),
  ADD KEY `fk_idsucursal_comp` (`idsucursal`),
  ADD KEY `fk_iddp_comp` (`iddetallepresentacion`);

--
-- Indices de la tabla `contratos`
--
ALTER TABLE `contratos`
  ADD PRIMARY KEY (`idcontrato`),
  ADD KEY `fk_dp_cs` (`iddetalle_presentacion`);

--
-- Indices de la tabla `convenios`
--
ALTER TABLE `convenios`
  ADD PRIMARY KEY (`idconvenio`),
  ADD KEY `fk_dp_cv` (`iddetalle_presentacion`);

--
-- Indices de la tabla `cuotas_comprobante`
--
ALTER TABLE `cuotas_comprobante`
  ADD PRIMARY KEY (`idcuotacomprobante`),
  ADD KEY `fk_idcuotacomprobante` (`idcomprobante`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`iddepartamento`),
  ADD KEY `fk_idnacionalidad` (`idnacionalidad`);

--
-- Indices de la tabla `detalles_comprobante`
--
ALTER TABLE `detalles_comprobante`
  ADD PRIMARY KEY (`iddetallecomprobante`),
  ADD KEY `fk_iddetallefactura` (`idcomprobante`);

--
-- Indices de la tabla `detalles_presentacion`
--
ALTER TABLE `detalles_presentacion`
  ADD PRIMARY KEY (`iddetalle_presentacion`),
  ADD UNIQUE KEY `uk_idp` (`iddetalle_presentacion`),
  ADD UNIQUE KEY `uk_ncotizacion` (`ncotizacion`),
  ADD KEY `fk_idusuario_dp` (`idusuario`),
  ADD KEY `fk_idcliente_dp` (`idcliente`),
  ADD KEY `fk_iddistrito_dp` (`iddistrito`),
  ADD KEY `fk_idnacionalidad_dp` (`idnacionalidad`);

--
-- Indices de la tabla `distritos`
--
ALTER TABLE `distritos`
  ADD PRIMARY KEY (`iddistrito`),
  ADD KEY `fk_idprovincia` (`idprovincia`);

--
-- Indices de la tabla `egresos_evento`
--
ALTER TABLE `egresos_evento`
  ADD PRIMARY KEY (`idegreso`),
  ADD KEY `fk_idreparticion_egre` (`idreparticion`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`idempresa`);

--
-- Indices de la tabla `gastosyentradas`
--
ALTER TABLE `gastosyentradas`
  ADD PRIMARY KEY (`idgastoentrada`),
  ADD KEY `fk_idusuario_gastoentrada` (`idusuario`),
  ADD KEY `fk_iddp_gastoentrada` (`iddetallepresentacion`);

--
-- Indices de la tabla `gastos_cajachica`
--
ALTER TABLE `gastos_cajachica`
  ADD PRIMARY KEY (`idgasto`),
  ADD KEY `fk_idcaja_gastos` (`idcajachica`);

--
-- Indices de la tabla `ingresos_evento`
--
ALTER TABLE `ingresos_evento`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_idreparticion_ing` (`idreparticion`);

--
-- Indices de la tabla `items_comprobante`
--
ALTER TABLE `items_comprobante`
  ADD PRIMARY KEY (`iditemcomprobante`),
  ADD KEY `fk_items_factura` (`idcomprobante`);

--
-- Indices de la tabla `montoCajaChica`
--
ALTER TABLE `montoCajaChica`
  ADD PRIMARY KEY (`idmonto`);

--
-- Indices de la tabla `montocajachica`
--
ALTER TABLE `montocajachica`
  ADD PRIMARY KEY (`idmonto`);

--
-- Indices de la tabla `nacionalidades`
--
ALTER TABLE `nacionalidades`
  ADD PRIMARY KEY (`idnacionalidad`);

--
-- Indices de la tabla `nivelaccesos`
--
ALTER TABLE `nivelaccesos`
  ADD PRIMARY KEY (`idnivelacceso`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`idnotificacion`),
  ADD KEY `fk_usuario_notif` (`idusuariodest`),
  ADD KEY `fk_usuario_rem` (`idusuariorem`);

--
-- Indices de la tabla `notificaciones_viatico`
--
ALTER TABLE `notificaciones_viatico`
  ADD PRIMARY KEY (`idnotificacion_viatico`),
  ADD KEY `fk_idviatico_nt` (`idviatico`),
  ADD KEY `fk_filmmamker_nt` (`idusuario`);

--
-- Indices de la tabla `pagos_contrato`
--
ALTER TABLE `pagos_contrato`
  ADD PRIMARY KEY (`idpagocontrato`),
  ADD KEY `fk_idcontrato` (`idcontrato`);

--
-- Indices de la tabla `pagos_cuota`
--
ALTER TABLE `pagos_cuota`
  ADD PRIMARY KEY (`idpagocuota`),
  ADD KEY `fk_idcuotacomprobante_pago` (`idcuotacomprobante`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`idpermiso`),
  ADD UNIQUE KEY `uk_idnivelacceso_p` (`idnivelacceso`,`ruta`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`idpersona`),
  ADD UNIQUE KEY `uk_telefono` (`telefono`),
  ADD UNIQUE KEY `uk_num_doc` (`num_doc`),
  ADD UNIQUE KEY `uk_correo` (`correo`),
  ADD KEY `fk_iddistrito` (`iddistrito`);

--
-- Indices de la tabla `precios_entrada_evento`
--
ALTER TABLE `precios_entrada_evento`
  ADD PRIMARY KEY (`idprecioentradaevento`),
  ADD KEY `fk_iddp_entrada_convenio` (`iddetalle_presentacion`);

--
-- Indices de la tabla `prodserv`
--
ALTER TABLE `prodserv`
  ADD PRIMARY KEY (`idprodserv`),
  ADD KEY `fk_idproveedor` (`idproveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`idproveedor`);

--
-- Indices de la tabla `provincias`
--
ALTER TABLE `provincias`
  ADD PRIMARY KEY (`idprovincia`),
  ADD KEY `fk_iddepartamento` (`iddepartamento`);

--
-- Indices de la tabla `reparticion_ingresos`
--
ALTER TABLE `reparticion_ingresos`
  ADD PRIMARY KEY (`idreparticion`),
  ADD KEY `fk_rep_ing` (`iddetalle_presentacion`);

--
-- Indices de la tabla `reportes_artista_evento`
--
ALTER TABLE `reportes_artista_evento`
  ADD PRIMARY KEY (`idreporte`),
  ADD KEY `fk_iddp_report_art_evento` (`iddetalle_presentacion`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`idreserva`),
  ADD KEY `fk_idpagocontrato_res` (`idpagocontrato`);

--
-- Indices de la tabla `responsables_boleteria_contratoreservasreservas`
--
ALTER TABLE `responsables_boleteria_contratoreservasreservas`
  ADD PRIMARY KEY (`idresponsablecontrato`),
  ADD KEY `fk_idusuario_boleteria` (`idusuarioBoleteria`),
  ADD KEY `fk_idusuario_contrato` (`idusuarioContrato`);

--
-- Indices de la tabla `salarios`
--
ALTER TABLE `salarios`
  ADD PRIMARY KEY (`idsalario`),
  ADD KEY `fk_idcolaborador_salario` (`idcolaborador`);

--
-- Indices de la tabla `subidas_agenda_edicion`
--
ALTER TABLE `subidas_agenda_edicion`
  ADD PRIMARY KEY (`idsubida`),
  ADD KEY `fk_subidas_agenda_edi` (`idagendaeditor`);

--
-- Indices de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  ADD PRIMARY KEY (`idsucursal`),
  ADD KEY `fk_iddistrito_sucu` (`iddistrito`),
  ADD KEY `fk_idempresa_sucu` (`idempresa`);

--
-- Indices de la tabla `tareas_diarias`
--
ALTER TABLE `tareas_diarias`
  ADD PRIMARY KEY (`idtareadiaria`);

--
-- Indices de la tabla `tareas_diaria_asignacion`
--
ALTER TABLE `tareas_diaria_asignacion`
  ADD PRIMARY KEY (`idtaradiariaasig`),
  ADD KEY `fk_idusuario` (`idusuario`),
  ADD KEY `fk_idtareadiaria_asig` (`idtareadiaria`);

--
-- Indices de la tabla `tarifario`
--
ALTER TABLE `tarifario`
  ADD PRIMARY KEY (`idtarifario`),
  ADD KEY `fk_idartista_tar` (`idusuario`),
  ADD KEY `fk_provincia_tarifario_art` (`idprovincia`),
  ADD KEY `fk_idnacionalidad_tarifario` (`idnacionalidad`);

--
-- Indices de la tabla `tipotarea`
--
ALTER TABLE `tipotarea`
  ADD PRIMARY KEY (`idtipotarea`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `uk_nom_usuario` (`nom_usuario`),
  ADD KEY `fk_idpersona` (`idpersona`),
  ADD KEY `fk_idnivelacceso` (`idnivelacceso`),
  ADD KEY `fk_idsucursal` (`idsucursal`);

--
-- Indices de la tabla `viaticos`
--
ALTER TABLE `viaticos`
  ADD PRIMARY KEY (`idviatico`),
  ADD KEY `fk_iddp_viatico` (`iddetalle_presentacion`),
  ADD KEY `fk_idusuario_v` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agenda_asignaciones`
--
ALTER TABLE `agenda_asignaciones`
  MODIFY `idasignacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `agenda_commanager`
--
ALTER TABLE `agenda_commanager`
  MODIFY `idagendacommanager` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `agenda_edicion`
--
ALTER TABLE `agenda_edicion`
  MODIFY `idagendaedicion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=379;

--
-- AUTO_INCREMENT de la tabla `agenda_editores`
--
ALTER TABLE `agenda_editores`
  MODIFY `idagendaeditor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `idarea` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cajachica`
--
ALTER TABLE `cajachica`
  MODIFY `idcajachica` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idcliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  MODIFY `idcolaborador` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comprobantes`
--
ALTER TABLE `comprobantes`
  MODIFY `idcomprobante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contratos`
--
ALTER TABLE `contratos`
  MODIFY `idcontrato` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `convenios`
--
ALTER TABLE `convenios`
  MODIFY `idconvenio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuotas_comprobante`
--
ALTER TABLE `cuotas_comprobante`
  MODIFY `idcuotacomprobante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `iddepartamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `detalles_comprobante`
--
ALTER TABLE `detalles_comprobante`
  MODIFY `iddetallecomprobante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalles_presentacion`
--
ALTER TABLE `detalles_presentacion`
  MODIFY `iddetalle_presentacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `distritos`
--
ALTER TABLE `distritos`
  MODIFY `iddistrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1830;

--
-- AUTO_INCREMENT de la tabla `egresos_evento`
--
ALTER TABLE `egresos_evento`
  MODIFY `idegreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `idempresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `gastosyentradas`
--
ALTER TABLE `gastosyentradas`
  MODIFY `idgastoentrada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `gastos_cajachica`
--
ALTER TABLE `gastos_cajachica`
  MODIFY `idgasto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ingresos_evento`
--
ALTER TABLE `ingresos_evento`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `items_comprobante`
--
ALTER TABLE `items_comprobante`
  MODIFY `iditemcomprobante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `montoCajaChica`
--
ALTER TABLE `montoCajaChica`
  MODIFY `idmonto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `montocajachica`
--
ALTER TABLE `montocajachica`
  MODIFY `idmonto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `nacionalidades`
--
ALTER TABLE `nacionalidades`
  MODIFY `idnacionalidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `nivelaccesos`
--
ALTER TABLE `nivelaccesos`
  MODIFY `idnivelacceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `idnotificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones_viatico`
--
ALTER TABLE `notificaciones_viatico`
  MODIFY `idnotificacion_viatico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos_contrato`
--
ALTER TABLE `pagos_contrato`
  MODIFY `idpagocontrato` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos_cuota`
--
ALTER TABLE `pagos_cuota`
  MODIFY `idpagocuota` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `precios_entrada_evento`
--
ALTER TABLE `precios_entrada_evento`
  MODIFY `idprecioentradaevento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `prodserv`
--
ALTER TABLE `prodserv`
  MODIFY `idprodserv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `idproveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `provincias`
--
ALTER TABLE `provincias`
  MODIFY `idprovincia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=196;

--
-- AUTO_INCREMENT de la tabla `reparticion_ingresos`
--
ALTER TABLE `reparticion_ingresos`
  MODIFY `idreparticion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reportes_artista_evento`
--
ALTER TABLE `reportes_artista_evento`
  MODIFY `idreporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `idreserva` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `responsables_boleteria_contratoreservasreservas`
--
ALTER TABLE `responsables_boleteria_contratoreservasreservas`
  MODIFY `idresponsablecontrato` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `salarios`
--
ALTER TABLE `salarios`
  MODIFY `idsalario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `subidas_agenda_edicion`
--
ALTER TABLE `subidas_agenda_edicion`
  MODIFY `idsubida` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  MODIFY `idsucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tareas_diarias`
--
ALTER TABLE `tareas_diarias`
  MODIFY `idtareadiaria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tareas_diaria_asignacion`
--
ALTER TABLE `tareas_diaria_asignacion`
  MODIFY `idtaradiariaasig` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tarifario`
--
ALTER TABLE `tarifario`
  MODIFY `idtarifario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipotarea`
--
ALTER TABLE `tipotarea`
  MODIFY `idtipotarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `viaticos`
--
ALTER TABLE `viaticos`
  MODIFY `idviatico` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agenda_asignaciones`
--
ALTER TABLE `agenda_asignaciones`
  ADD CONSTRAINT `agenda_asignaciones_ibfk_1` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`) ON DELETE CASCADE,
  ADD CONSTRAINT `agenda_asignaciones_ibfk_2` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `agenda_commanager`
--
ALTER TABLE `agenda_commanager`
  ADD CONSTRAINT `fk_idagendaeditor_cm` FOREIGN KEY (`idagendaeditor`) REFERENCES `agenda_editores` (`idagendaeditor`),
  ADD CONSTRAINT `fk_idusuarioCmanaget` FOREIGN KEY (`idusuarioCmanager`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `agenda_edicion`
--
ALTER TABLE `agenda_edicion`
  ADD CONSTRAINT `fk_iddp_ag_edicion` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`);

--
-- Filtros para la tabla `agenda_editores`
--
ALTER TABLE `agenda_editores`
  ADD CONSTRAINT `fk_idagendaedicion` FOREIGN KEY (`idagendaedicion`) REFERENCES `agenda_edicion` (`idagendaedicion`),
  ADD CONSTRAINT `fk_idtipotarea_agen` FOREIGN KEY (`idtipotarea`) REFERENCES `tipotarea` (`idtipotarea`),
  ADD CONSTRAINT `fk_idusuario_ag_edit` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `cajachica`
--
ALTER TABLE `cajachica`
  ADD CONSTRAINT `fk_iddp_cajachicaa` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  ADD CONSTRAINT `fk_idmonto_caja` FOREIGN KEY (`idmonto`) REFERENCES `montocajachica` (`idmonto`),
  ADD CONSTRAINT `fk_idusuario_abierto` FOREIGN KEY (`creadopor`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_iddistrito_cli` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`);

--
-- Filtros para la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  ADD CONSTRAINT `fk_idarea_colaborador` FOREIGN KEY (`idarea`) REFERENCES `areas` (`idarea`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_idpersona_colaborador` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_idresponsable_colaborador` FOREIGN KEY (`idresponsable`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_idsucursal_colaborador` FOREIGN KEY (`idsucursal`) REFERENCES `sucursales` (`idsucursal`) ON DELETE CASCADE;

--
-- Filtros para la tabla `comprobantes`
--
ALTER TABLE `comprobantes`
  ADD CONSTRAINT `fk_idcliente_comp` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`idcliente`),
  ADD CONSTRAINT `fk_iddp_comp` FOREIGN KEY (`iddetallepresentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  ADD CONSTRAINT `fk_idsucursal_comp` FOREIGN KEY (`idsucursal`) REFERENCES `sucursales` (`idsucursal`);

--
-- Filtros para la tabla `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `fk_dp_cs` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`);

--
-- Filtros para la tabla `convenios`
--
ALTER TABLE `convenios`
  ADD CONSTRAINT `fk_dp_cv` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`);

--
-- Filtros para la tabla `cuotas_comprobante`
--
ALTER TABLE `cuotas_comprobante`
  ADD CONSTRAINT `fk_idcuotacomprobante` FOREIGN KEY (`idcomprobante`) REFERENCES `comprobantes` (`idcomprobante`);

--
-- Filtros para la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD CONSTRAINT `fk_idnacionalidad` FOREIGN KEY (`idnacionalidad`) REFERENCES `nacionalidades` (`idnacionalidad`);

--
-- Filtros para la tabla `detalles_comprobante`
--
ALTER TABLE `detalles_comprobante`
  ADD CONSTRAINT `fk_iddetallefactura` FOREIGN KEY (`idcomprobante`) REFERENCES `comprobantes` (`idcomprobante`);

--
-- Filtros para la tabla `detalles_presentacion`
--
ALTER TABLE `detalles_presentacion`
  ADD CONSTRAINT `fk_idcliente_dp` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`idcliente`),
  ADD CONSTRAINT `fk_iddistrito_dp` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  ADD CONSTRAINT `fk_idnacionalidad_dp` FOREIGN KEY (`idnacionalidad`) REFERENCES `nacionalidades` (`idnacionalidad`),
  ADD CONSTRAINT `fk_idusuario_dp` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `distritos`
--
ALTER TABLE `distritos`
  ADD CONSTRAINT `fk_idprovincia` FOREIGN KEY (`idprovincia`) REFERENCES `provincias` (`idprovincia`);

--
-- Filtros para la tabla `egresos_evento`
--
ALTER TABLE `egresos_evento`
  ADD CONSTRAINT `fk_idreparticion_egre` FOREIGN KEY (`idreparticion`) REFERENCES `reparticion_ingresos` (`idreparticion`);

--
-- Filtros para la tabla `gastosyentradas`
--
ALTER TABLE `gastosyentradas`
  ADD CONSTRAINT `fk_iddp_gastoentrada` FOREIGN KEY (`iddetallepresentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_idusuario_gastoentrada` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `gastos_cajachica`
--
ALTER TABLE `gastos_cajachica`
  ADD CONSTRAINT `fk_idcaja_gastos` FOREIGN KEY (`idcajachica`) REFERENCES `cajachica` (`idcajachica`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ingresos_evento`
--
ALTER TABLE `ingresos_evento`
  ADD CONSTRAINT `fk_idreparticion_ing` FOREIGN KEY (`idreparticion`) REFERENCES `reparticion_ingresos` (`idreparticion`);

--
-- Filtros para la tabla `items_comprobante`
--
ALTER TABLE `items_comprobante`
  ADD CONSTRAINT `fk_items_factura` FOREIGN KEY (`idcomprobante`) REFERENCES `comprobantes` (`idcomprobante`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `fk_usuario_notif` FOREIGN KEY (`idusuariodest`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_usuario_rem` FOREIGN KEY (`idusuariorem`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `notificaciones_viatico`
--
ALTER TABLE `notificaciones_viatico`
  ADD CONSTRAINT `fk_filmmamker_nt` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idviatico_nt` FOREIGN KEY (`idviatico`) REFERENCES `viaticos` (`idviatico`);

--
-- Filtros para la tabla `pagos_contrato`
--
ALTER TABLE `pagos_contrato`
  ADD CONSTRAINT `fk_idcontrato` FOREIGN KEY (`idcontrato`) REFERENCES `contratos` (`idcontrato`);

--
-- Filtros para la tabla `pagos_cuota`
--
ALTER TABLE `pagos_cuota`
  ADD CONSTRAINT `fk_idcuotacomprobante_pago` FOREIGN KEY (`idcuotacomprobante`) REFERENCES `cuotas_comprobante` (`idcuotacomprobante`);

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `fk_idnivelacceso_p` FOREIGN KEY (`idnivelacceso`) REFERENCES `nivelaccesos` (`idnivelacceso`);

--
-- Filtros para la tabla `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `fk_iddistrito` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`);

--
-- Filtros para la tabla `precios_entrada_evento`
--
ALTER TABLE `precios_entrada_evento`
  ADD CONSTRAINT `fk_iddp_entrada_convenio` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`);

--
-- Filtros para la tabla `prodserv`
--
ALTER TABLE `prodserv`
  ADD CONSTRAINT `fk_idproveedor` FOREIGN KEY (`idproveedor`) REFERENCES `proveedores` (`idproveedor`) ON DELETE CASCADE;

--
-- Filtros para la tabla `provincias`
--
ALTER TABLE `provincias`
  ADD CONSTRAINT `fk_iddepartamento` FOREIGN KEY (`iddepartamento`) REFERENCES `departamentos` (`iddepartamento`);

--
-- Filtros para la tabla `reparticion_ingresos`
--
ALTER TABLE `reparticion_ingresos`
  ADD CONSTRAINT `fk_rep_ing` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`);

--
-- Filtros para la tabla `reportes_artista_evento`
--
ALTER TABLE `reportes_artista_evento`
  ADD CONSTRAINT `fk_iddp_report_art_evento` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `fk_idpagocontrato_res` FOREIGN KEY (`idpagocontrato`) REFERENCES `pagos_contrato` (`idpagocontrato`);

--
-- Filtros para la tabla `responsables_boleteria_contratoreservasreservas`
--
ALTER TABLE `responsables_boleteria_contratoreservasreservas`
  ADD CONSTRAINT `fk_idusuario_boleteria` FOREIGN KEY (`idusuarioBoleteria`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idusuario_contrato` FOREIGN KEY (`idusuarioContrato`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `salarios`
--
ALTER TABLE `salarios`
  ADD CONSTRAINT `fk_idcolaborador_salario` FOREIGN KEY (`idcolaborador`) REFERENCES `colaboradores` (`idcolaborador`) ON DELETE CASCADE;

--
-- Filtros para la tabla `subidas_agenda_edicion`
--
ALTER TABLE `subidas_agenda_edicion`
  ADD CONSTRAINT `fk_subidas_agenda_edi` FOREIGN KEY (`idagendaeditor`) REFERENCES `agenda_editores` (`idagendaeditor`);

--
-- Filtros para la tabla `sucursales`
--
ALTER TABLE `sucursales`
  ADD CONSTRAINT `fk_iddistrito_sucu` FOREIGN KEY (`iddistrito`) REFERENCES `distritos` (`iddistrito`),
  ADD CONSTRAINT `fk_idempresa_sucu` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`idempresa`);

--
-- Filtros para la tabla `tareas_diaria_asignacion`
--
ALTER TABLE `tareas_diaria_asignacion`
  ADD CONSTRAINT `fk_idtareadiaria_asig` FOREIGN KEY (`idtareadiaria`) REFERENCES `tareas_diarias` (`idtareadiaria`),
  ADD CONSTRAINT `fk_idusuario` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `tarifario`
--
ALTER TABLE `tarifario`
  ADD CONSTRAINT `fk_idartista_tar` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idnacionalidad_tarifario` FOREIGN KEY (`idnacionalidad`) REFERENCES `nacionalidades` (`idnacionalidad`),
  ADD CONSTRAINT `fk_provincia_tarifario_art` FOREIGN KEY (`idprovincia`) REFERENCES `provincias` (`idprovincia`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_idnivelacceso` FOREIGN KEY (`idnivelacceso`) REFERENCES `nivelaccesos` (`idnivelacceso`),
  ADD CONSTRAINT `fk_idpersona` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`),
  ADD CONSTRAINT `fk_idsucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursales` (`idsucursal`);

--
-- Filtros para la tabla `viaticos`
--
ALTER TABLE `viaticos`
  ADD CONSTRAINT `fk_iddp_viatico` FOREIGN KEY (`iddetalle_presentacion`) REFERENCES `detalles_presentacion` (`iddetalle_presentacion`),
  ADD CONSTRAINT `fk_idusuario_v` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
