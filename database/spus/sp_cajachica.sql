DROP PROCEDURE IF EXISTS sp_filtrar_cajachica;
DELIMITER $$

-- CALL sp_filtrar_cajachica (null, null, null, null, 'h');

CREATE PROCEDURE sp_filtrar_cajachica(
    IN _fecha_apertura DATETIME,
    IN _fecha_cierre DATETIME,
    IN _mes INT,
    IN _año_semana INT,
    IN _busqueda_general VARCHAR(255)
)
BEGIN
    SELECT 
    CA.idcajachica, CA.idmonto, CA.ccinicial, CA.incremento, CA.ccfinal, CA.estado, CA.fecha_cierre, CA.fecha_apertura,
    DP.iddetalle_presentacion, DP.fecha_presentacion, DP.establecimiento,
	USU.nom_usuario
    FROM cajachica CA
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = CA.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
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
END $$

DELIMITER ;

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

DROP PROCEDURE IF EXISTS sp_actualizar_monto_cajachica;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_monto_cajachica
(
	IN _idmonto			INT,
    IN _monto			 DECIMAL(10,2)
)
BEGIN 
	UPDATE montoCajaChica SET
    monto = _monto
    WHERE idmonto = _idmonto;
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

DROP PROCEDURE IF EXISTS sp_actualizar_incremento;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_incremento
(
	IN _idcajachica			INT,
    IN _incremento			double (10,2)
)
BEGIN 
	UPDATE cajachica SET
    incremento = _incremento
    WHERE idcajachica = _idcajachica;
END $$


DROP PROCEDURE IF EXISTS sp_registrar_cajachica;
DELIMITER $$

CREATE PROCEDURE sp_registrar_cajachica (
    OUT _idcajachica INT,
    IN _iddetalle_presentacion INT,
    IN _idmonto INT,
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
    INSERT INTO cajachica (iddetalle_presentacion, idmonto ,ccinicial, incremento, ccfinal, estado, fecha_cierre, fecha_apertura)
    VALUES (nullif(_iddetalle_presentacion, ''), _idmonto ,_ccinicial, _incremento, _ccfinal, 1, NULL, NOW());

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
