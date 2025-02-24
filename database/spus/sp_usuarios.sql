USE vega_producciones_erp;

DELIMITER $$
CREATE PROCEDURE sp_registrar_usuario
(
	OUT _idusuario INT,
    IN _idpersona INT,
    IN _nom_usuario VARCHAR(120),
    IN _claveacceso VARBINARY(255),
    IN _idnivelacceso INT
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO usuarios (idpersona, nom_usuario, claveacceso, idnivelacceso)VALUES 
		(_idpersona, _nom_usuario, _claveacceso, _idnivelacceso);
        
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
		P.apellidos,P.nombres AS dato, P.num_doc, P.genero, P.telefono, P.idpersona, P.direccion, P.correo,
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