USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_registrar_persona;
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
    VALUES (nullif(_num_doc, ''), nullif(_apellidos,''), nullif(_nombres,''),nullif(_genero, ''), nullif(_direccion,''), nullif(_telefono,''), nullif(_telefono2,''), NULLIF(_correo, ''), nullif(_iddistrito,''));
    
    IF existe_error = 1 THEN
        SET _idpersona = -1;
    ELSE
        SET _idpersona = LAST_INSERT_ID();
    END IF;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS sp_search_persona_numdoc;
DELIMITER $$
CREATE PROCEDURE sp_search_persona_numdoc
(
	IN _num_doc VARCHAR(20)
)
BEGIN
	SELECT 
    P.idpersona, P.apellidos, P.nombres, P.genero, P.direccion,P.telefono, P.telefono2, P.correo, 
    NA.idnacionalidad,  D.iddepartamento, PR.idprovincia, DI.iddistrito,
    U.nom_usuario, U.idnivelacceso
    FROM usuarios U
    LEFT JOIN personas P ON U.idpersona = P.idpersona
    LEFT JOIN distritos DI ON DI.iddistrito = P.iddistrito
    LEFT JOIN provincias PR ON PR.idprovincia = DI.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NA ON NA.idnacionalidad = D.idnacionalidad
    WHERE P.num_doc = _num_doc;
END $$