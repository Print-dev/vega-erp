USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_registrar_usuario;
DELIMITER $$
CREATE PROCEDURE sp_registrar_usuario
(
	OUT _idusuario INT,
    IN _idsucursal INT,
    IN _idpersona INT,
    IN _nom_usuario VARCHAR(120),
    IN _claveacceso VARBINARY(255),
    IN _color CHAR(7),
    IN _porcentaje INT,
    IN _marcaagua VARCHAR(80),
    IN _firma	VARCHAR(80),
    IN _idnivelacceso INT
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO usuarios (idsucursal, idpersona, nom_usuario, claveacceso, color, porcentaje, marcaagua ,firma, idnivelacceso)VALUES 
		(_idsucursal, _idpersona, _nom_usuario, _claveacceso, nullif(_color, ''), nullif(_porcentaje, ''), nullif(_marcaagua, ''), nullif(_firma, ''),_idnivelacceso);
        
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
        NA.idnivelacceso,
        US.estado
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
        NA.idnivelacceso,
        PER.nombres
		FROM usuarios US
        INNER JOIN nivelaccesos NA ON US.idnivelacceso = NA.idnivelacceso
        LEFT JOIN personas PER ON PER.idpersona = US.idpersona
        WHERE NA.idnivelacceso = _idnivelacceso;
END $$

-- CALL sp_obtener_usuario_por_nivel(6)
-- CALL sp_obtener_usuarios (NULL,NULL,NULL,NULL,NULL,NULL)
DROP PROCEDURE IF EXISTS sp_obtener_usuarios;
DELIMITER $$

CREATE PROCEDURE sp_obtener_usuarios
(
	IN _nivelacceso VARCHAR(30),
	IN _num_doc	VARCHAR(20),
	IN _nombres VARCHAR(100),
    IN _apellidos VARCHAR(100),
    IN _telefono CHAR(15),
    IN _nom_usuario VARCHAR(30),
    IN _idsucursal INT
)
BEGIN
	SELECT
		US.idusuario, NA.nivelacceso, PE.num_doc, PE.nombres, PE.apellidos, US.nom_usuario, PE.telefono, US.estado
	FROM usuarios US
	left JOIN personas PE ON PE.idpersona = US.idpersona
    left JOIN nivelaccesos NA ON NA.idnivelacceso = US.idnivelacceso
	WHERE (NA.nivelacceso LIKE CONCAT('%', COALESCE(_nivelacceso, ''), '%') OR NA.nivelacceso IS NULL)
  AND (PE.num_doc LIKE CONCAT('%', COALESCE(_num_doc, ''), '%') OR PE.num_doc IS NULL)
  AND (PE.nombres LIKE CONCAT('%', COALESCE(_nombres, ''), '%') OR PE.nombres IS NULL)
  AND (PE.apellidos LIKE CONCAT('%', COALESCE(_apellidos, ''), '%') OR PE.apellidos IS NULL)
  AND (PE.telefono LIKE CONCAT('%', COALESCE(_telefono, ''), '%') OR PE.telefono IS NULL)
  AND (US.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%') OR US.nom_usuario IS NULL)
  AND (US.idsucursal LIKE CONCAT('%', COALESCE(_idsucursal, ''), '%') OR US.idsucursal IS NULL);

END $$
DELIMITER ;


DROP PROCEDURE if exists sp_actualizar_usuario;
DELIMITER //
CREATE PROCEDURE sp_actualizar_usuario (
	IN _idsucursal INT,
	IN _idusuario INT,
    IN _nom_usuario VARCHAR(30),
    IN _claveacceso VARBINARY(255),
    IN _color	CHAR(7),
    IN _porcentaje INT,
    IN _marcaagua varchar(80),
    IN _firma	VARCHAR(80)
)
BEGIN
		UPDATE usuarios 
    SET 
		idsucursal = NULLIF(_idsucursal, ''),
        nom_usuario = NULLIF(_nom_usuario, ''),
        color = NULLIF(_color, ''),
        porcentaje = NULLIF(_porcentaje, ''),
        marcaagua = NULLIF(_marcaagua, ''),
        firma = NULLIF(_firma, ''),
        update_at = NOW()
    WHERE idusuario = _idusuario;

    -- Solo actualizar claveacceso si se proporciona un valor válido
    IF _claveacceso IS NOT NULL AND LENGTH(_claveacceso) > 0 THEN
        UPDATE usuarios 
        SET claveacceso = _claveacceso
        WHERE idusuario = _idusuario;
    END IF;
END //

DROP PROCEDURE if exists sp_actualizar_persona;
DELIMITER //
CREATE PROCEDURE sp_actualizar_persona (
	IN _idpersona INT,
    IN _num_doc VARCHAR(20),
    IN _apellidos varchar(100),
    IN _nombres	varchar(100),
    IN _genero char(1),
    IN _direccion varchar(150),
    IN _telefono char(15),
    IN _telefono2 char(15),
    IN _correo char(150),
    IN _iddistrito INT
)
BEGIN
		UPDATE personas SET
        num_doc = nullif(_num_doc,''),
        apellidos = nullif(_apellidos, ''),
        nombres = nullif(_nombres, ''),
        genero = nullif(_genero, ''),
        telefono = nullif(_telefono, ''),
        telefono2 = nullif(_telefono2, ''),
        correo = nullif(_correo, ''),
        iddistrito = nullif(_iddistrito, ''),
		update_at = now()
    WHERE idpersona = _idpersona; 
END //

DROP PROCEDURE if exists sp_deshabilitar_usuario;
DELIMITER //
CREATE PROCEDURE sp_deshabilitar_usuario (
	IN _idusuario INT,
    IN _estado TINYINT
)
BEGIN
		UPDATE usuarios SET
        estado = _estado,
        update_at = now()
    WHERE idusuario = _idusuario; 
END //
