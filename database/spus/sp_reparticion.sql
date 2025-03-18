USE vega_producciones_erp;

drop procedure if exists sp_filtrar_reparticiones;
DELIMITER //
CREATE PROCEDURE `sp_filtrar_reparticiones`(
    IN _evento VARCHAR(120)
)
BEGIN
    SELECT 
       RI.idreparticion, RI.montototal, RI.montorepresentante, RI.montopromotor, RI.ingresototal, RI.montoartista, RI.montofinal, RI.estado,
       USU.nom_usuario, USU.idusuario, DP.establecimiento, DP.iddetalle_presentacion
    FROM reparticion_ingresos RI
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = RI.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    WHERE 
     (_evento IS NULL 
            OR CONCAT(USU.nom_usuario, ' ', DP.establecimiento) LIKE CONCAT('%', _evento, '%'));
END //

-- CALL sp_registrar_reparticion (@idreparticion,1, 0,0,0,0,0,0);

DROP PROCEDURE IF EXISTS sp_registrar_reparticion;
DELIMITER $$

CREATE PROCEDURE sp_registrar_reparticion (
    OUT _idreparticion INT,
    IN _iddetalle_presentacion INT,
    IN _montototal DECIMAL(10,2),
    IN _montorepresentante  DECIMAL(10,2),
    IN _montopromotor DECIMAL(10,2),
    IN _ingresototal DECIMAL(10,2),
    IN _montoartista DECIMAL(10,2),
    IN _montofinal DECIMAL(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;

    -- Insertar nueva caja chica
    INSERT INTO reparticion_ingresos (iddetalle_presentacion, montototal ,montorepresentante, montopromotor, ingresototal ,montoartista, montofinal)
    VALUES (nullif(_iddetalle_presentacion, ''), nullif(_montototal, '') , nullif(_montorepresentante , ''), nullif(_montopromotor ,''), nullif(_ingresototal ,''), nullif(_montoartista , ''), nullif(_montofinal , ''));

    -- Obtener el ID generado
    IF existe_error = 1 THEN
        SET _idreparticion = -1;
    ELSE
        SET _idreparticion = LAST_INSERT_ID();
    END IF;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS sp_registrar_ingreso;
DELIMITER $$
CREATE PROCEDURE sp_registrar_ingreso (
    OUT _idingreso INT,
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
    INSERT INTO ingresos_evento (idreparticion, descripcion ,monto, tipopago, noperacion)
    VALUES (_idreparticion, _descripcion, _monto, _tipopago, nullif(_noperacion, ''));

    -- Obtener el ID generado
    IF existe_error = 1 THEN
        SET _idingreso = -1;
    ELSE
        SET _idingreso = LAST_INSERT_ID();
    END IF;
END $$

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_registrar_egresos;
DELIMITER $$
CREATE PROCEDURE sp_registrar_egresos (
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
END $$

DELIMITER ;

