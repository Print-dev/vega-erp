USE vega_producciones_erp;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_obtener_tarifario_por_provincia;
DELIMITER $$
CREATE PROCEDURE sp_obtener_tarifario_por_provincia
(
	IN _iddepartamento INT,
    IN _idusuario INT
)
BEGIN
	SELECT 
	T.idtarifario, T.precio, PR.idprovincia, D.iddepartamento, USU.idusuario
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    WHERE PR.iddepartamento = _iddepartamento AND USU.idusuario = _idusuario ;
END $$

DROP PROCEDURE IF EXISTS sp_search_tarifa_artista_por_provincia;
DELIMITER $$
CREATE PROCEDURE sp_search_tarifa_artista_por_provincia
(
	IN _idprovincia INT,
    IN _idusuario INT
)
BEGIN
	SELECT 
	T.idtarifario, T.precio, PR.idprovincia, D.iddepartamento
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    WHERE PR.idprovincia = _idprovincia AND USU.idusuario = _idusuario;
END $$

-- CALL sp_search_tarifa_artista_por_provincia (100, 2)

DROP PROCEDURE IF EXISTS sp_search_tarifa_artista;
DELIMITER $$
CREATE PROCEDURE sp_search_tarifa_artista
(
	IN _nom_usuario varchar(30)
)
BEGIN
	SELECT 
    T.idtarifario, USU.nom_usuario, D.departamento, PR.provincia, T.precio
    FROM tarifario T
    LEFT JOIN usuarios USU ON USU.idusuario = T.idusuario 
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    WHERE USU.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%');
END $$

CALL sp_search_tarifa_artista('A');

DELIMITER $$
CREATE PROCEDURE sp_registrar_tarifa
(
	OUT _idtarifario INT,
    IN _idusuario INT,
    IN _idprovincia int,
    IN _precio decimal(8,2)
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tarifario (idusuario, idprovincia, precio)VALUES 
		(_idusuario, _idprovincia, _precio);
        
	IF existe_error= 1 THEN
		SET _idtarifario = -1;
	ELSE
        SET _idtarifario = last_insert_id();
	END IF;
END $$

DROP PROCEDURE IF EXISTS sp_actualizar_tarifa;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_tarifa
(
	IN _idtarifario			INT,
    IN _precio			INT
)
BEGIN 
	UPDATE tarifario SET
    precio = _precio
    WHERE idtarifario = _idtarifario;
END $$