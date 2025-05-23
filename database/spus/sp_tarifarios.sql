-- USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_obtener_tarifario_por_provincia;
DELIMITER //
CREATE PROCEDURE sp_obtener_tarifario_por_provincia
(
	IN _iddepartamento INT,
    IN _idusuario INT,
    IN _tipo_evento INT
)
BEGIN
	SELECT 
	T.idtarifario, T.precio, T.tipo_evento, NAC.idnacionalidad, NAC.pais,PR.idprovincia, D.iddepartamento, USU.idusuario
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE PR.iddepartamento = _iddepartamento AND USU.idusuario = _idusuario AND T.tipo_evento = _tipo_evento;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_search_tarifa_artista_por_provincia;
DELIMITER //
CREATE PROCEDURE sp_search_tarifa_artista_por_provincia
(
	IN _idprovincia INT,
    IN _idusuario INT,
	IN _tipo_evento INT
)
BEGIN
	SELECT 
	T.idtarifario, T.precio, T.tipo_evento, NAC.idnacionalidad, NAC.pais, PR.idprovincia, D.iddepartamento
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE PR.idprovincia = _idprovincia AND USU.idusuario = _idusuario AND T.tipo_evento = _tipo_evento;
END //
DELIMITER ;
select * from tarifario
select*from usuarios
call sp_search_tarifa_artista_por_provincia(161, 8, 2)
select * from provincias;
DROP PROCEDURE IF EXISTS sp_obtener_tarifario_artista_pais;
DELIMITER //
CREATE PROCEDURE sp_obtener_tarifario_artista_pais
(
    IN _idusuario INT,
    IN _idnacionalidad INT,
	IN _tipo_evento INT
)
BEGIN
	SELECT 
	T.idtarifario, T.precio, T.tipo_evento, NAC.idnacionalidad, NAC.pais, T.precioExtranjero
    FROM usuarios USU
    LEFT JOIN tarifario T ON T.idusuario = USU.idusuario
    LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE USU.idusuario = _idusuario AND NAC.idnacionalidad = _idnacionalidad AND T.tipo_evento = _tipo_evento;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_search_tarifa_artista;
DELIMITER //
CREATE PROCEDURE sp_search_tarifa_artista
(
	IN _nom_usuario varchar(30)
)
BEGIN
	SELECT 
    T.idtarifario, USU.nom_usuario, D.departamento, PR.provincia, T.precio, NAC.pais, T.tipo_evento
    FROM tarifario T
    LEFT JOIN usuarios USU ON USU.idusuario = T.idusuario 
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
	LEFT JOIN nacionalidades NAC ON NAC.idnacionalidad = T.idnacionalidad
    WHERE USU.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%');
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_registrar_tarifa;
DELIMITER //
CREATE PROCEDURE sp_registrar_tarifa
(
	OUT _idtarifario INT,
    IN _idusuario INT,
    IN _idprovincia int,
    IN _precio decimal(10,2),
    IN _tipo_evento INT,
    IN _idnacionalidad INT,
    IN _precioExtranjero decimal(10,2)
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tarifario (idusuario, idprovincia, precio, tipo_evento, idnacionalidad, precioExtranjero)VALUES 
		(_idusuario, nullif(_idprovincia, ''), _precio, _tipo_evento, nullif(_idnacionalidad , ''), nullif(_precioExtranjero,''));
        
	IF existe_error= 1 THEN
		SET _idtarifario = -1;
	ELSE
        SET _idtarifario = last_insert_id();
	END IF;
END //
DELIMITER ;
select*from tarifario;
CALL sp_registrar_tarifa (@_idtarifario, 5, '', 333, 1, 31);
DROP PROCEDURE IF EXISTS sp_actualizar_tarifa;
DELIMITER //
CREATE PROCEDURE sp_actualizar_tarifa
(
	IN _idtarifario			INT,
    IN _precio			DECIMAL(10,2)
)
BEGIN 
	UPDATE tarifario SET
    precio = _precio
    WHERE idtarifario = _idtarifario;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_actualizar_tarifa_precio_extranjero;
DELIMITER //
CREATE PROCEDURE sp_actualizar_tarifa_precio_extranjero
(
	IN _idtarifario			INT,
    IN _precioExtranjero DECIMAL(10,2)
)
BEGIN 
	UPDATE tarifario SET
    precioExtranjero = _precioExtranjero
    WHERE idtarifario = _idtarifario;
END //
DELIMITER ;