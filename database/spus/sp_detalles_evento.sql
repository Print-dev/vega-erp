USE vega_producciones_erp;
drop procedure if exists sp_registrar_detalle_presentacion;

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
    
    INSERT INTO detalles_presentacion (idusuario, idcliente, iddistrito, ncotizacion, fecha_presentacion, horainicio, horafinal, establecimiento, referencia ,tipo_evento, modalidad, validez, igv)
    VALUES (_idusuario, _idcliente, _iddistrito, NULLIF(_ncotizacion, ''), _fechapresentacion, _horainicio, _horafinal, _establecimiento, _referencia, _tipoevento, _modalidad, NULLIF(_validez, ''), _igv);
    
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
    IN _ndocumento CHAR(9)
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
        CO.estado as estado_contrato
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
    GROUP BY DP.iddetalle_presentacion, CO.idcontrato;

END //

CALL sp_obtener_detalles_evento ('','');

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
        CLI.razonsocial, 
        DP.tipo_evento, 
        DP.modalidad, 
        DP.fecha_presentacion, 
        DP.horainicio, DP.horafinal,
        CO.idcontrato, 
        DP.validez,
        DP.reserva,
        DP.pagado50,
        DP.establecimiento,
        DP.referencia,
        CO.estado AS estadoContrato,
        DP.created_at,
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
        DEDP.departamento
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


CALL sp_obtener_agenda_artista (2, null);

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

CALL sp_obtener_dp_por_fecha (2, '2025-03-18')

CALL sp_obtener_detalles_evento ('','');

DROP PROCEDURE sp_actualizar_estado_dp;
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

DROP PROCEDURE sp_actualizar_pagado50_dp;
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


DROP PROCEDURE sp_actualizar_estado_reserva_dp;
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