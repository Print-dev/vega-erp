USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_colaborador`;
DELIMITER //

-- CALL sp_registrar_notificacion(@idnotificacion,1,3,1,2,'yooo')
CREATE PROCEDURE sp_registrar_colaborador(
    OUT _idcolaborador INT,
    IN _idpersona INT,
    IN _fechaingreso DATE,
    IN _area int
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO colaboradores (idpersona, fechaingreso, area)
    VALUES (_idpersona, _fechaingreso , _area);

    IF existe_error = 1 THEN
        SET _idcolaborador = -1;
    ELSE
        SET _idcolaborador = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS `sp_registrar_salario`;
DELIMITER //
CREATE PROCEDURE sp_registrar_salario(
    OUT _idsalario INT,
    IN _idcolaborador int,
    IN _salario DECIMAL(10,2),
    IN _costohora DECIMAL(10,2),
    IN _fechainicio DATE
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO colaboradores (idcolaborador, salario, costohora, fechainicio)
    VALUES (_idcolaborador, _salario , _costohora, _fechainicio);

    IF existe_error = 1 THEN
        SET _idsalario = -1;
    ELSE
        SET _idsalario = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

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
    VALUES (_idcolaborador, _periodo , _fechainicio, _fechafin, _horas, _rendimiento, _proporcion, _acumulado);

    IF existe_error = 1 THEN
        SET _idnomina = -1;
    ELSE
        SET _idnomina = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

