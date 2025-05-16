USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_colaborador`;
DELIMITER //

-- CALL sp_registrar_notificacion(@idnotificacion,1,3,1,2,'yooo')
CREATE PROCEDURE sp_registrar_colaborador(
    OUT _idcolaborador INT,
    IN _idpersona INT,
    IN _idsucursal INT,
    IN _fechaingreso DATE,
    IN _periodo INT,
    IN _idarea int
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO colaboradores (idpersona, idsucursal, fechaingreso, periodo, idarea)
    VALUES (_idpersona, _idsucursal, _fechaingreso, _periodo , _idarea);

    IF existe_error = 1 THEN
        SET _idcolaborador = -1;
    ELSE
        SET _idcolaborador = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;
-- CALL sp_registrar_colaborador (@idcolaborador,15, '2025-05-10', 3)

DROP PROCEDURE if exists sp_actualizar_colaborador;
DELIMITER //
CREATE PROCEDURE sp_actualizar_colaborador (
	IN _idcolaborador int,
	IN _idsucursal INT,
    IN _fechaingreso DATE,
    IN _periodo INT,
    IN _idarea INT
)
BEGIN
		UPDATE colaboradores 
    SET 
		idsucursal = NULLIF(_idsucursal, ''),
        fechaingreso = NULLIF(_fechaingreso, ''),
        periodo = NULLIF(_periodo, ''),
        idarea = NULLIF(_idarea, '')
    WHERE idcolaborador = _idcolaborador;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `sp_registrar_salario`;
DELIMITER //
CREATE PROCEDURE sp_registrar_salario(
    OUT _idsalario INT,
    IN _idcolaborador int,
    IN _salario DECIMAL(10,2),
    IN _horas DECIMAL(10,2),
    IN _costohora DECIMAL(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    -- Insertar la notificación
    INSERT INTO salarios (idcolaborador, salario, horas, costohora)
    VALUES (_idcolaborador, _salario , _horas, _costohora);

    IF existe_error = 1 THEN
        SET _idsalario = -1;
    ELSE
        SET _idsalario = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

DROP PROCEDURE if exists sp_actualizar_salario;
DELIMITER //
CREATE PROCEDURE sp_actualizar_salario (
	IN _idsalario INT,
    IN _salario DECIMAL(10,2),
    IN _horas DECIMAL(10,2),
    IN _costohora DECIMAL(10,2),
    IN _fechainicio DATE
)
BEGIN
		UPDATE salarios SET
        salario = nullif(_salario,''),
        horas = nullif(_horas, ''),
        costohora = nullif(_costohora, ''),
        fechainicio = nullif(_fechainicio, '')
    WHERE idsalario = _idsalario; 
END //
DELIMITER ;


-- CALL sp_registrar_salario(@idsalario, 1, 1200, 30)
DROP PROCEDURE IF EXISTS `sp_registrar_nomina`;
DELIMITER //
CREATE PROCEDURE sp_registrar_nomina(
    OUT _idnomina INT,
    IN _idcolaborador int,
    IN _periodo INT,
    IN _fechainicio DATE,
    IN _fechafin DATE,
    IN _horas INT,
    IN _rendimiento DECIMAL(10,2),
    IN _proporcion DECIMAL(10,2),
    IN _acumulado DECIMAL(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO nomina (idcolaborador, periodo, fechainicio, fechafin ,horas, rendimiento, proporcion,acumulado)
    VALUES (_idcolaborador, _periodo , _fechainicio, nullif(_fechafin, ''), _horas, _rendimiento, _proporcion, _acumulado);

    IF existe_error = 1 THEN
        SET _idnomina = -1;
    ELSE
        SET _idnomina = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

SELECT*FROM personas;
DROP PROCEDURE IF EXISTS sp_filtrar_nominas;
DELIMITER //
CREATE PROCEDURE sp_filtrar_nominas(
	-- IN _nombres VARCHAR(100),
	-- IN _num_doc VARCHAR(20)
)
BEGIN
	SELECT 
	NOM.idnomina, COL.idcolaborador, PE.nombres, PE.apellidos, NOM.periodo, NOM.fechainicio, NOM.fechafin, NOM.horas, NOM.costohora, NOM.salario, AR.area, AR.idarea
    FROM nomina NOM
	LEFT JOIN colaboradores	COL ON COL.idcolaborador = NOM.idcolaborador
	left JOIN personas PE ON PE.idpersona = COL.idpersona
    LEFT JOIN areas AR ON AR.idarea = COL.idarea
    -- WHERE (PE.num_doc LIKE CONCAT('%', COALESCE(_num_doc, ''), '%') OR PE.num_doc IS NULL) AND
	-- (PE.nombres LIKE CONCAT('%', COALESCE(_nombres, ''), '%') OR PE.nombres IS NULL)
    ORDER BY idcolaborador DESC;
END //

CALL sp_filtrar_nominas (null,null)


DROP PROCEDURE IF EXISTS sp_filtrar_salarios;
DELIMITER //
CREATE PROCEDURE sp_filtrar_salarios(
	IN _idcolaborador INT
	-- IN _nombres VARCHAR(100),
	-- IN _num_doc VARCHAR(20)
)
BEGIN
	SELECT 
	*
    FROM salarios NOM
	LEFT JOIN colaboradores	COL ON COL.idcolaborador = NOM.idcolaborador
    WHERE (_idcolaborador IS NULL OR COL.idcolaborador = _idcolaborador)
    ORDER BY idsalario DESC;
END //

CALL sp_filtrar_salarios(1)