-- USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `obtenerContrato`;
DELIMITER //

CREATE PROCEDURE `obtenerContrato`(
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

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `sp_obtenerCotizacion`;
DELIMITER //
CREATE PROCEDURE `sp_obtenerCotizacion`(
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

END //

DELIMITER ;

DROP PROCEDURE IF EXISTS `sp_registrar_contrato`;
DELIMITER //
CREATE PROCEDURE sp_registrar_contrato(
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
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `sp_registrar_pago_contrato`;
DELIMITER //
CREATE PROCEDURE sp_registrar_pago_contrato(
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
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_actualizar_estado_contrato;
DELIMITER //
CREATE PROCEDURE sp_actualizar_estado_contrato
(
	IN _idcontrato			INT,
    IN _estado			INT
)
BEGIN 
	UPDATE contratos SET
    estado = _estado,
    updated_at = now()
    WHERE idcontrato = _idcontrato;
END // 
DELIMITER ;


DROP PROCEDURE IF EXISTS `sp_obtener_pagos_contrato`;
DELIMITER //

CREATE PROCEDURE `sp_obtener_pagos_contrato`(
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
END //
DELIMITER ;
