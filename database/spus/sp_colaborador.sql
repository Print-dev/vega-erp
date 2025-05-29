DROP PROCEDURE IF EXISTS `sp_registrar_colaborador`;
DELIMITER //
CREATE PROCEDURE sp_registrar_colaborador(
    OUT _idcolaborador INT,
    IN _idpersonacolaborador int,
    IN _camisa VARCHAR(80),
    IN _pantalon VARCHAR(80),
	IN _zapatos  VARCHAR(80)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO colaboradores (idpersonacolaborador, camisa, pantalon, zapatos)
    VALUES (nullif(_idpersonacolaborador,''), nullif(_camisa,''), nullif(_pantalon,''), nullif(_zapatos,''));

    IF existe_error = 1 THEN
        SET _idcolaborador = -1;
    ELSE
        SET _idcolaborador = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `sp_registrar_persona_colaborador`;
DELIMITER //
CREATE PROCEDURE sp_registrar_persona_colaborador(
    OUT _idpersonacolaborador INT,
    IN _nombreapellidos VARCHAR(150),
    IN _dni varchar(8),
    IN _fnacimiento DATE,
    IN _estadocivil smallint,
    IN _sexo CHAR(1),
    IN _domicilio varchar(200),
    IN _correo varchar(200),
    IN _nivelestudio VARCHAR(200),
    IN _contactoemergencia varchar(200),
    IN _discapacidad VARCHAR(200)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO personas_colaboradores (nombreapellidos, dni, fnacimiento, estadocivil, sexo, domicilio, correo, nivelestudio, contactoemergencia, discapacidad)
    VALUES (nullif(_nombreapellidos,'') , nullif(_dni,''), nullif(_fnacimiento,''), nullif(_estadocivil,''), nullif(_sexo,''), nullif(_domicilio,''), nullif(_correo,''), nullif(_nivelestudio,''), nullif(_contactoemergencia,''), nullif(_discapacidad,''));

    IF existe_error = 1 THEN
        SET _idpersonacolaborador = -1;
    ELSE
        SET _idpersonacolaborador = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

