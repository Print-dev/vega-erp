USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_obtener_nomina_porid;
DELIMITER //
CREATE PROCEDURE sp_obtener_nomina_porid(
	IN _idnomina INT
)
BEGIN
	SELECT * 
	FROM nominas NOM
	LEFT JOIN colaboradores COL ON COL.idcolaborador = NOM.idcolaborador
    LEFT JOIN personas_colaboradores PERCO ON PERCO.idpersonacolaborador = COL.idpersonacolaborador
	WHERE NOM.idnomina = _idnomina
	ORDER BY NOM.idnomina DESC;
END //
DELIMITER ;

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
    IN _tipo INT,
    IN _fechaingreso DATE,
    IN _ruc varchar(20),
    IN _clavesol varchar(20),
    IN _ncuenta varchar(20)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO nominas (idcolaborador, tipo, fechaingreso, idcargo, ruc, clavesol, ncuenta)
    VALUES (nullif(_idcolaborador,'') , nullif(_tipo,''), nullif(_fechaingreso,''), nullif(_idcargo,''), nullif(_ruc,''), nullif(_clavesol, '') , nullif(_ncuenta, ''));

    IF existe_error = 1 THEN
        SET _idnomina = -1;
    ELSE
        SET _idnomina = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

-- NUEVA NOMINA

DROP PROCEDURE IF EXISTS `sp_registrar_nomina`;
DELIMITER //
CREATE PROCEDURE sp_registrar_nomina(
    OUT _idnomina INT,
    IN _tipo int,
    IN _nombreapellido INT,
    IN _dni CHAR(15),
    IN _idarea INT,
    IN _fnacimiento DATE,
    IN _estadocivil int,
    IN _sexo int,
    IN _domicilio varchar(130),
    IN _correo	varchar(150),
    IN _nivelestudio	varchar(150),
    IN _contactoemergencia	varchar(200),
    IN _discapacidad 	varchar(200),
    IN _camisa			varchar(80),
    IN _pantalon		varchar(80),
    IN _ruc				varchar(80),
    IN _clavesol		varchar(20),
    IN _ncuenta			varchar(20)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    -- Insertar la notificación
    INSERT INTO nominas (tipo, nombreapellido, dni, idarea, fnacimiento, estadocivil, sexo, domicilio, correo, nivelestudio, contactoemergencia,discapacidad, camisa, pantalon, ruc, clavesol, ncuenta)
    VALUES (nullif(_tipo,''), nullif(_nombreapellido,''), nullif(_dni,''), nullif(_idarea,''), nullif(_fnacimiento,''), nullif(_estadocivil, '') , nullif(_sexo, ''), nullif(_domicilio,''), nullif(_correo,''), nullif(_nivelestudio, ''), nullif(_contactoemergencia,''), nullif(_discapacidad, ''), nullif(_camisa,''), nullif(_pantalon,''), nullif(_ruc,''), nullif(_clavesol,''), nullif(_ncuenta, ''));

    IF existe_error = 1 THEN
        SET _idnomina = -1;
    ELSE
        SET _idnomina = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

CALL sp_registrar_nomina(
    @idnomina,      -- OUT
    NULL,           -- _tipo
    NULL,           -- _nombreapellido
    NULL,           -- _dni
    NULL,           -- _idarea
    NULL,           -- _fnacimiento
    NULL,           -- _estadocivil
    NULL,           -- _sexo
    NULL,           -- _domicilio
    NULL,           -- _correo
    NULL,           -- _nivelestudio
    NULL,           -- _contactoemergencia
    NULL,           -- _discapacidad
    NULL,           -- _camisa
    NULL,           -- _pantalon
    NULL,           -- _ruc
    NULL,           -- _clavesol
    NULL            -- _ncuenta
);


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
    IN _mesindividual INT,
    IN _anoindividual INT,
    IN _mesrangoinicio INT,
    IN _anorangoinicio INT,
    IN _mesrangofin INT,
    IN _anorangofin INT,
    IN _idcolaborador INT
)
BEGIN
    SELECT 
        PERCO.nombreapellidos,
        PERCO.dni,
        CAR.cargo,
        PERCO.fnacimiento,
        PERCO.estadocivil,
        PERCO.sexo,
        PERCO.domicilio,
        PERCO.correo,
        PERCO.nivelestudio,
        PERCO.contactoemergencia,
        PERCO.discapacidad,
        COL.idcolaborador,
        COL.camisa, 
        COL.pantalon,
        COL.zapatos,
        NOM.ruc,
        NOM.idnomina,
        NOM.clavesol,
        NOM.ncuenta,
        NOM.tipo,
        NOM.fechaingreso
    FROM nominas NOM
    LEFT JOIN colaboradores COL ON COL.idcolaborador = NOM.idcolaborador
    LEFT JOIN personas_colaboradores PERCO ON PERCO.idpersonacolaborador = COL.idpersonacolaborador
	LEFT JOIN cargos CAR ON CAR.idcargo = PERCO.idcargo
    WHERE 
        (
            -- Filtro individual
            (_mesindividual IS NOT NULL AND _anoindividual IS NOT NULL AND 
             MONTH(NOM.fechaingreso) = _mesindividual AND YEAR(NOM.fechaingreso) = _anoindividual)
            OR
            -- Filtro por rango
            (_mesrangoinicio IS NOT NULL AND _anorangoinicio IS NOT NULL AND 
             _mesrangofin IS NOT NULL AND _anorangofin IS NOT NULL AND
             NOM.fechaingreso BETWEEN 
                 STR_TO_DATE(CONCAT('01/', _mesrangoinicio, '/', _anorangoinicio), '%d/%m/%Y') AND
                 LAST_DAY(STR_TO_DATE(CONCAT('01/', _mesrangofin, '/', _anorangofin), '%d/%m/%Y'))
            )
            OR
            -- Sin filtros de fecha
            (_mesindividual IS NULL AND _anoindividual IS NULL AND
             _mesrangoinicio IS NULL AND _anorangoinicio IS NULL AND
             _mesrangofin IS NULL AND _anorangofin IS NULL)
        )
        AND 
        -- Filtro por colaborador (opcional)
        (_idcolaborador IS NULL OR COL.idcolaborador = _idcolaborador)
    ORDER BY NOM.fechaingreso DESC, NOM.idnomina DESC;
END //
DELIMITER ;

select*from nominas;
CALL sp_filtrar_nominas(NULL, NULL, 04, 2025, 08, 2025, NULL);

-- Muestra solo nóminas de junio 2023select * from colaboradores;
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