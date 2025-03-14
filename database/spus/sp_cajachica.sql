DROP PROCEDURE IF EXISTS sp_filtrar_cajachica;
DELIMITER $$

CREATE PROCEDURE sp_filtrar_cajachica
(
    IN _fecha_apertura DATETIME,
    IN _fecha_cierre   DATETIME
)
BEGIN
    SELECT *
    FROM cajachica
    WHERE 
        (_fecha_apertura IS NULL OR fecha_apertura >= _fecha_apertura)
        AND (_fecha_cierre IS NULL OR fecha_cierre <= _fecha_cierre OR fecha_cierre IS NULL);
END $$
DELIMITER ;

CALL sp_filtrar_cajachica(NULL, NULL);

DROP PROCEDURE IF EXISTS sp_actualizar_estado_caja;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_estado_caja
(
	IN _idcajachica			INT,
    IN _estado			tinyint
)
BEGIN 
	UPDATE cajachica SET
    estado = _estado,
    fecha_cierre = now()
    WHERE idcajachica = _idcajachica;
END $$

DROP PROCEDURE IF EXISTS sp_actualizar_ccfinal;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_ccfinal
(
	IN _idcajachica			INT,
    IN _ccfinal			double (10,2)
)
BEGIN 
	UPDATE cajachica SET
    ccfinal = _ccfinal
    WHERE idcajachica = _idcajachica;
END $$

DROP PROCEDURE IF EXISTS sp_registrar_cajachica;
DELIMITER $$

CREATE PROCEDURE sp_registrar_cajachica (
    OUT _idcajachica INT,
    IN _ccinicial DOUBLE(10,2),
    IN _incremento DOUBLE(10,2),
    IN _ccfinal DOUBLE(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;

    -- Insertar nueva caja chica
    INSERT INTO cajachica (ccinicial, incremento, ccfinal, estado, fecha_cierre, fecha_apertura)
    VALUES (_ccinicial, _incremento, _ccfinal, 1, NULL, NOW());

    -- Obtener el ID generado
    IF existe_error = 1 THEN
        SET _idcajachica = -1;
    ELSE
        SET _idcajachica = LAST_INSERT_ID();
    END IF;
END $$

DELIMITER ;

-- ==============================================

-- Eliminar procedimiento si ya existe
DROP PROCEDURE IF EXISTS sp_registrar_gasto;
DELIMITER $$

CREATE PROCEDURE sp_registrar_gasto (
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
END $$

DELIMITER ;
