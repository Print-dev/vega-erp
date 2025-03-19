USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_registrar_usuario;
DELIMITER $$
CREATE PROCEDURE sp_registrar_usuario
(
	OUT _idusuario INT,
    IN _idpersona INT,
    IN _nom_usuario VARCHAR(120),
    IN _claveacceso VARBINARY(255),
    IN _color CHAR(7),
    IN _porcentaje INT,
    IN _idnivelacceso INT
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO usuarios (idpersona, nom_usuario, claveacceso, color, porcentaje ,idnivelacceso)VALUES 
		(_idpersona, _nom_usuario, _claveacceso, nullif(_color, ''), nullif(_porcentaje, '') ,_idnivelacceso);
        
	IF existe_error= 1 THEN
		SET _idusuario = -1;
	ELSE
        SET _idusuario = last_insert_id();
	END IF;
END $$

DROP PROCEDURE IF EXISTS sp_obtener_usuario_por_id;
DELIMITER $$
CREATE PROCEDURE sp_obtener_usuario_por_id
(
	IN _idusuario INT
)
BEGIN
	SELECT
		P.apellidos,P.nombres AS dato, P.num_doc, P.genero, P.telefono, P.idpersona, P.direccion, P.correo, U.porcentaje,
        U.idusuario,U.nom_usuario, U.estado,
        NA.nivelacceso
		FROM usuarios U
        INNER JOIN nivelaccesos NA ON U.idnivelacceso = NA.idnivelacceso
        INNER JOIN personas P ON U.idpersona = P.idpersona
        WHERE idusuario = _idusuario;
END $$

DROP PROCEDURE IF EXISTS sp_user_login;
DELIMITER $$
CREATE PROCEDURE sp_user_login
(
	IN _usuario VARCHAR(30)
)
BEGIN
	SELECT
		US.idusuario,
        PE.apellidos, PE.nombres,
        US.nom_usuario,
        US.claveacceso, US.estado,
        NA.nivelacceso,
        NA.idnivelacceso
		FROM usuarios US
        INNER JOIN nivelaccesos NA ON US.idnivelacceso = NA.idnivelacceso
        INNER JOIN personas PE ON PE.idpersona = US.idpersona
        WHERE US.nom_usuario = _usuario;
END $$

CALL sp_user_login('royer.18');

DROP PROCEDURE IF EXISTS sp_obtener_usuario_por_nivel;
DELIMITER $$
CREATE PROCEDURE sp_obtener_usuario_por_nivel
(
	IN _idnivelacceso INT
)
BEGIN
	SELECT
		US.idusuario,
        US.nom_usuario,
        US.estado,
        NA.nivelacceso,
        NA.idnivelacceso
		FROM usuarios US
        INNER JOIN nivelaccesos NA ON US.idnivelacceso = NA.idnivelacceso
        WHERE NA.idnivelacceso = _idnivelacceso;
END $$

CALL sp_obtener_usuario_por_nivel(6)

DROP PROCEDURE IF EXISTS sp_obtener_usuarios;
DELIMITER $$

CREATE PROCEDURE sp_obtener_usuarios
(
	IN _nivelacceso VARCHAR(30),
	IN _num_doc	VARCHAR(20),
	IN _nombres VARCHAR(100),
    IN _apellidos VARCHAR(100),
    IN _telefono CHAR(15),
    IN _nom_usuario VARCHAR(30)
)
BEGIN
	SELECT
		US.idusuario, NA.nivelacceso, PE.num_doc, PE.nombres, PE.apellidos, US.nom_usuario, PE.telefono, US.estado
	FROM usuarios US
	left JOIN personas PE ON PE.idpersona = US.idpersona
    left JOIN nivelaccesos NA ON NA.idnivelacceso = US.idnivelacceso
	WHERE NA.nivelacceso LIKE CONCAT('%', COALESCE(_nivelacceso, ''), '%')
	  AND PE.num_doc LIKE CONCAT('%', COALESCE(_num_doc, ''), '%') 
	  AND PE.nombres LIKE CONCAT('%', COALESCE(_nombres, ''), '%') 
	  AND PE.apellidos LIKE CONCAT('%', COALESCE(_apellidos, ''), '%') 
	  AND PE.telefono LIKE CONCAT('%', COALESCE(_telefono, ''), '%') 
	  AND US.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%');
END $$

-- CALL sp_obtener_usuarios('Art','','','','','');

DELIMITER ;
