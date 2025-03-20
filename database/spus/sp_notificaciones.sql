USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_notificacion`;
DELIMITER $$

CREATE PROCEDURE sp_registrar_notificacion(
    OUT _idnotificacion INT,
    IN _idusuariodest INT,
    IN _idusuariorem INT,
    IN _tipo INT,
    IN _idreferencia INT,
    IN _mensaje VARCHAR(200)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO notificaciones (idusuariodest, idusuariorem, tipo, idreferencia, mensaje) 
    VALUES (_idusuariodest, idusuariorem , _tipo, _idreferencia, _mensaje);

    IF existe_error = 1 THEN
        SET _idnotificacion = -1;
    ELSE
        SET _idnotificacion = LAST_INSERT_ID();
    END IF;
END $$

DELIMITER ;

-- CALL sp_registrar_notificacion_viatico (@idnotificacion, 1, 3, 'Johan envio un viatico');

DROP PROCEDURE IF EXISTS sp_obtener_notificaciones;
DELIMITER $$
CREATE PROCEDURE sp_obtener_notificaciones
(
	IN _iddepartamento INT,
    IN _idusuario INT
)
BEGIN
	SELECT 
		*
    FROM notificaciones NOTIF
    WHERE NOTIF.idusuario = _idusuario;
END $$
