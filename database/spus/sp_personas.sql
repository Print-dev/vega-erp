USE vega_producciones_erp;

DELIMITER $$

CREATE PROCEDURE sp_registrar_persona (
    OUT _idpersona INT,
    IN _num_doc VARCHAR(20),
    IN _apellidos VARCHAR(100),
    IN _nombres VARCHAR(100),
    IN _genero CHAR(1),
    IN _direccion VARCHAR(150),
    IN _telefono CHAR(15),
    IN _telefono2 CHAR(15),
    IN _correo VARCHAR(150),
    IN _iddistrito INT
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO personas (num_doc, apellidos, nombres, genero, direccion, telefono, telefono2, correo, iddistrito)
    VALUES (_num_doc, _apellidos, _nombres, _genero, _direccion, _telefono, _telefono2, NULLIF(_correo, ''), _iddistrito);
    
    IF existe_error = 1 THEN
        SET _idpersona = -1;
    ELSE
        SET _idpersona = LAST_INSERT_ID();
    END IF;
END $$

DELIMITER ;
