-- USE vega_producciones_erp;

drop procedure if exists sp_filtrar_reparticiones;
DELIMITER //
CREATE PROCEDURE `sp_filtrar_reparticiones`(
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
END //
DELIMITER ;

-- CALL sp_registrar_reparticion (@idreparticion,1, 0,0,0,0,0,0);

DROP PROCEDURE IF EXISTS sp_registrar_reparticion;
DELIMITER //
CREATE PROCEDURE sp_registrar_reparticion (
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
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS sp_registrar_ingreso;
DELIMITER //
CREATE PROCEDURE sp_registrar_ingreso (
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
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_registrar_egresos;
DELIMITER //
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
END //

DELIMITER ;

