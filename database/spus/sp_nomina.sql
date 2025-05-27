USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_colaborador`;
DELIMITER //

-- CALL sp_registrar_notificacion(@idnotificacion,1,3,1,2,'yooo')
CREATE PROCEDURE sp_registrar_colaborador(
    OUT _idcolaborador INT,
    IN _idpersona INT,
    IN _idsucursal INT,
    IN _fechaingreso DATE,
    IN _idarea int,
	IN _idresponsable INT,
    IN _banco INT,
    IN _ncuenta CHAR(20)    
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;

    
    -- Insertar la notificación
    INSERT INTO colaboradores (idpersona, idsucursal, fechaingreso, idarea, idresponsable, banco, ncuenta)
    VALUES (_idpersona, _idsucursal, _fechaingreso , _idarea, _idresponsable, nullif(_banco, ''), nullif(_ncuenta, ''));

    IF existe_error = 1 THEN
        SET _idcolaborador = -1;
    ELSE
        SET _idcolaborador = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

-- CALL sp_registrar_colaborador(@idcolaborador, 1, 1, "2025-01-01", 1)
select * from colaboradores;
-- CALL sp_registrar_colaborador (@idcolaborador,15, '2025-05-10', 3)

DROP PROCEDURE if exists sp_actualizar_colaborador;
DELIMITER //
CREATE PROCEDURE sp_actualizar_colaborador (
	IN _idcolaborador int,
	IN _idsucursal INT,
    IN _fechaingreso DATE,
    IN _idarea INT,
    IN _idresponsable INT,
    IN _banco INT,
    IN _ncuenta CHAR(20)
)
BEGIN
		UPDATE colaboradores 
    SET 
		idsucursal = NULLIF(_idsucursal, ''),
        fechaingreso = NULLIF(_fechaingreso, ''),
        idarea = NULLIF(_idarea, ''),
        idresponsable = NULLIF(_idresponsable, ''),
        banco = NULLIF(_banco, ''),
        ncuenta = nullif(_ncuenta ,'')
    WHERE idcolaborador = _idcolaborador;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `sp_registrar_salario`;
DELIMITER //
CREATE PROCEDURE sp_registrar_salario(
    OUT _idsalario INT,
    IN _idcolaborador int,
    IN _salario DECIMAL(10,2),
	IN _periodo INT,
    IN _horas DECIMAL(10,2),
    IN _costohora DECIMAL(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    -- Insertar la notificación
    INSERT INTO salarios (idcolaborador, salario, periodo, horas, costohora)
    VALUES (_idcolaborador, _salario , _periodo ,_horas, _costohora);

    IF existe_error = 1 THEN
        SET _idsalario = -1;
    ELSE
        SET _idsalario = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

CALL sp_registrar_salario(@idsalario, 1,'1200',1, 200.50, 30.0);
select * from salarios;

DROP PROCEDURE if exists sp_actualizar_salario;
DELIMITER //
CREATE PROCEDURE sp_actualizar_salario (
	IN _idsalario INT,
    IN _salario DECIMAL(10,2),
    IN _periodo INT,
    IN _horas DECIMAL(10,2),
    IN _costohora DECIMAL(10,2),
    IN _fechainicio DATE
)
BEGIN
		UPDATE salarios SET
        salario = nullif(_salario,''),
		periodo = nullif(_periodo, ''),
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
    IN _salario_usado DECIMAL(10,2),
    IN _periodo INT,
    IN _idarea INT,
    IN _horas DECIMAL(10,2),
    IN _tiempo DECIMAL(10,2),
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
    INSERT INTO nomina (idcolaborador, salario_usado, periodo, idarea ,horas, tiempo, rendimiento, proporcion,acumulado)
    VALUES (_idcolaborador , _salario_usado, _periodo, _idarea,_horas,nullif(_tiempo, '') , nullif(_rendimiento, ''), nullif(_proporcion,''), nullif(_acumulado,''));

    IF existe_error = 1 THEN
        SET _idnomina = -1;
    ELSE
        SET _idnomina = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_obtener_ultimanomina_por_colaborador;
DELIMITER //
CREATE PROCEDURE sp_obtener_ultimanomina_por_colaborador(
	IN _idcolaborador INT
)
BEGIN
	SELECT * 
	FROM colaboradores COL
	INNER JOIN nomina NOM ON NOM.idcolaborador = COL.idcolaborador
	WHERE COL.idcolaborador = _idcolaborador
	ORDER BY NOM.idnomina DESC
	LIMIT 1;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_obtener_acumulados_nomina;
DELIMITER //
CREATE PROCEDURE sp_obtener_acumulados_nomina(
	IN _idnomina INT
)
BEGIN
	SELECT * 
	FROM gastos_nomina GAS
	INNER JOIN nomina NOM ON NOM.idnomina = GAS.idnomina
	WHERE NOM.idnomina = _idnomina
	ORDER BY NOM.idnomina DESC;
    
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `sp_registrar_gasto`; -- old
DELIMITER //
CREATE PROCEDURE sp_registrar_gasto(
    OUT _idgastonomina INT,
    IN _idnomina int,
    IN _tipo INT,
    IN _subtipo INT,
    IN _descripcion TEXT,
    IN _monto DECIMAL(10,2)
)
BEGIN
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
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_filtrar_nominas;
DELIMITER //
CREATE PROCEDURE sp_filtrar_nominas(
	-- IN _nombres VARCHAR(100),
	-- IN _num_doc VARCHAR(20)
)
BEGIN
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
END //

select * from colaboradores;
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

DROP PROCEDURE IF EXISTS sp_obtener_salario_por_colaborador;
DELIMITER //
CREATE PROCEDURE sp_obtener_salario_por_colaborador(
	IN _idcolaborador INT
)
BEGIN
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
END //
DELIMITER ;

-- CALL sp_obtener_salario_por_colaborador (1)

DROP PROCEDURE IF EXISTS sp_obtener_salario_por_colaborador;
DELIMITER //
CREATE PROCEDURE sp_obtener_salario_por_colaborador(
	IN _idcolaborador INT
)
BEGIN
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
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_obtener_colaborador_por_id;
DELIMITER //
CREATE PROCEDURE sp_obtener_colaborador_por_id(
	IN _idcolaborador INT
)
BEGIN
	SELECT 
		*
	FROM colaboradores COL
	INNER JOIN areas AR ON COL.idarea = AR.idarea
    
    WHERE COL.idcolaborador = _idcolaborador
	LIMIT 1;
END //
DELIMITER ;

CALL sp_obtener_colaborador_por_id(1)