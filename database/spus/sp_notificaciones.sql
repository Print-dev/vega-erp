USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_notificacion_viatico`;
DELIMITER $$

CREATE PROCEDURE sp_registrar_notificacion_viatico(
    OUT _idnotificacion_viatico INT,
    IN _idviatico INT,
    IN _filmmaker INT,
    IN _mensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        SET _idnotificacion_viatico = -1; -- Devolver -1 si hay error
    END;
    
    -- Insertar la notificación
    INSERT INTO notificaciones_viatico (idviatico, filmmaker, mensaje) 
    VALUES (_idviatico, _filmmaker, _mensaje);

    -- Obtener el ID generado
    SET _idnotificacion_viatico = LAST_INSERT_ID();
END $$

DELIMITER ;

-- CALL sp_registrar_notificacion_viatico (@idnotificacion, 1, 3, 'Johan envio un viatico');

DROP PROCEDURE IF EXISTS sp_obtener_notificaciones_viatico;
DELIMITER $$
CREATE PROCEDURE sp_obtener_notificaciones_viatico
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
