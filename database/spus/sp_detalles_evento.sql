USE vega_producciones_erp;
drop procedure if exists sp_registrar_detalle_presentacion;

-- CALL sp_registrar_detalle_presentacion(@iddetalle_presentacion,2, null, 2, null, null, '2025-03-01', null,null,null,null,null,null,null,null,0)
DROP PROCEDURE IF EXISTS sp_actualizar_detalle_presentacion;
DELIMITER //
CREATE PROCEDURE sp_actualizar_detalle_presentacion (
	IN _iddetalle_presentacion INT,
    IN _fechapresentacion date,
    IN _horainicio time,
    IN _horafinal time,
    IN _establecimiento VARCHAR(80),
    IN _referencia VARCHAR(200),
    IN _tipoevento int,
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
	validez = nullif(_validez, ''),
	iddistrito = _iddistrito,
	igv = _igv
	WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END //

DROP PROCEDURE IF EXISTS sp_registrar_detalle_presentacion;
DELIMITER $$
CREATE PROCEDURE sp_registrar_detalle_presentacion (
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
    IN _modalidad int,
    IN _validez int,
    IN _igv tinyint
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO detalles_presentacion (idusuario, idcliente, iddistrito, ncotizacion, fecha_presentacion, horainicio, horafinal, establecimiento, referencia, acuerdo ,tipo_evento, modalidad, validez, igv)
    VALUES (_idusuario, _idcliente, nullif(_iddistrito, ''), NULLIF(_ncotizacion, ''), _fechapresentacion, nullif(_horainicio, ''), nullif(_horafinal, ''), nullif(_establecimiento,''), nullif(_referencia,''), nullif(_acuerdo, ''), nullif(_tipoevento,''), nullif(_modalidad,''), NULLIF(_validez, ''), _igv);
    
    IF existe_error = 1 THEN
        SET _iddetalle_presentacion = -1;
    ELSE
        SET _iddetalle_presentacion = LAST_INSERT_ID();
    END IF;
END $$

drop procedure if exists sp_obtener_dp_porid;
DELIMITER //
CREATE PROCEDURE `sp_obtener_dp_porid`(
	IN _iddetalle_presentacion	INT
)
BEGIN
	SELECT 		
		DP.iddetalle_presentacion, DE.departamento, PRO.provincia, DIS.distrito, PRO.idprovincia, USU.idusuario, CLI.idcliente, DP.igv, DP.reserva, DP.pagado50
	FROM detalles_presentacion DP
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
    WHERE DP.iddetalle_presentacion = _iddetalle_presentacion; -- me quede aca
END //

drop procedure if exists sp_obtener_detalles_evento;
DELIMITER //
CREATE PROCEDURE `sp_obtener_detalles_evento`(
    IN _ncotizacion CHAR(9),
    IN _ndocumento CHAR(9),
    IN _nom_usuario CHAR(30),
    IN _establecimiento VARCHAR(80)
)
BEGIN
    SELECT 
        DP.iddetalle_presentacion, 
        CLI.ndocumento,
        DP.ncotizacion,
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
        DP.tienecaja
    FROM detalles_presentacion DP
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN pagos_contrato PC ON PC.idcontrato = CO.idcontrato
    LEFT JOIN reservas RE ON RE.idpagocontrato = PC.idpagocontrato
    WHERE 
    (DP.ncotizacion IS NULL OR DP.ncotizacion LIKE CONCAT('%', COALESCE(_ncotizacion, ''), '%'))
    AND (CLI.ndocumento LIKE CONCAT('%', COALESCE(_ndocumento, ''), '%') OR _ndocumento IS NULL)
    AND (USU.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%') OR _nom_usuario IS NULL)
    AND (DP.establecimiento LIKE CONCAT('%', COALESCE(_establecimiento, ''), '%') OR _establecimiento IS NULL)
    GROUP BY DP.iddetalle_presentacion, CO.idcontrato;

END //

-- CALL sp_obtener_detalles_evento (null, null, "a", null)

DROP PROCEDURE IF EXISTS sp_obtener_agenda_artista;
DELIMITER //
CREATE PROCEDURE `sp_obtener_agenda_artista`(
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
END //
DELIMITER ;

-- SPU PARA LISTAR LA AGENDA DE LOS OTROS ROLES 
select * from nivelaccesos;
-- CALL sp_obtener_agenda (null, null, 10)
DROP PROCEDURE IF EXISTS sp_obtener_agenda;
DELIMITER //
CREATE PROCEDURE `sp_obtener_agenda`(
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
        (_idnivelacceso IS NULL OR NIVEL.idnivelacceso = _idnivelacceso);
END //
DELIMITER ;
-- AGENDA SOLO PARA EDITORES (MUESTRA TODAS LAS AGENDAS PARA EDICION DE LOS EVENTOS, NO LAS TAREAS DE LOS EDITORES)
DROP PROCEDURE IF EXISTS sp_obtener_agenda_edicion;
DELIMITER //
CREATE PROCEDURE `sp_obtener_agenda_edicion`(
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
    LEFT JOIN agenda_asignaciones ASIG ON ASIG.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN usuarios USUASIG ON USUASIG.idusuario = ASIG.idusuario
	LEFT JOIN nivelaccesos NIVEL ON NIVEL.idnivelacceso IN (USU.idnivelacceso, USUASIG.idnivelacceso)
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN convenios CON ON CON.iddetalle_presentacion = DP.iddetalle_presentacion
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento;
END //
DELIMITER ;

-- call sp_obtener_agenda_edicion_por_editor_y_general (null);
-- FILTRAR AGENDA POR EDITORES (TAREAS INDEPENDIENTES Y EN GENERAL PARA TODOS LOS EDITORES)
DROP PROCEDURE IF EXISTS sp_obtener_agenda_edicion_por_editor_y_general;
DELIMITER //
CREATE PROCEDURE `sp_obtener_agenda_edicion_por_editor_y_general`(
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
END //
DELIMITER ;


drop procedure if exists sp_obtener_dp_por_fecha;
DELIMITER //
CREATE PROCEDURE `sp_obtener_dp_por_fecha`(
	IN _idusuario	INT,
	IN _fecha_presentacion	DATE
)
BEGIN
	SELECT *
    FROM
    detalles_presentacion 
    WHERE fecha_presentacion = _fecha_presentacion AND idusuario = _idusuario; -- me quede aca
END //

DROP PROCEDURE if exists sp_actualizar_estado_dp;
DELIMITER //
CREATE PROCEDURE sp_actualizar_estado_dp (
	IN _iddetalle_presentacion INT,
    IN _estado TINYINT
)
BEGIN
		UPDATE detalles_presentacion SET
    estado = _estado
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END //

DROP PROCEDURE if exists sp_actualizar_pagado50_dp;
DELIMITER //
CREATE PROCEDURE sp_actualizar_pagado50_dp (
	IN _iddetalle_presentacion INT,
    IN _pagado50 TINYINT
)
BEGIN
		UPDATE detalles_presentacion SET
    pagado50 = _pagado50
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END //

DROP PROCEDURE if exists sp_actualizar_caja_dp;
DELIMITER //
CREATE PROCEDURE sp_actualizar_caja_dp (
	IN _iddetalle_presentacion INT,
    IN _tienecaja TINYINT
)
BEGIN
		UPDATE detalles_presentacion SET
    tienecaja = _tienecaja
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END //



DROP PROCEDURE if exists sp_actualizar_estado_reserva_dp;
DELIMITER //
CREATE PROCEDURE sp_actualizar_estado_reserva_dp (
	IN _iddetalle_presentacion INT,
    IN _reserva TINYINT
)
BEGIN
		UPDATE detalles_presentacion SET
    reserva = _reserva
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END //

DROP PROCEDURE if exists sp_editar_acuerdo_evento;
DELIMITER //
CREATE PROCEDURE sp_editar_acuerdo_evento (
	IN _iddetalle_presentacion INT,
    IN _acuerdo TEXT
)
BEGIN
		UPDATE detalles_presentacion SET
    acuerdo = nullif(_acuerdo, '')
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END //

-- quitar luego
DROP PROCEDURE if exists sp_asignarfilmmaker_dp;
DELIMITER //
CREATE PROCEDURE sp_asignarfilmmaker_dp (
	IN _iddetalle_presentacion INT,
    IN _idusuario INT
)
BEGIN
		UPDATE detalles_presentacion_asignados SET
    idusuario = nullif(_idusuario, '')
    WHERE iddetalle_presentacion = _iddetalle_presentacion; 
END //