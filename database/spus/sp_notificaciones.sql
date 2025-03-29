USE vega_producciones_erp;

-- DROP PROCEDURE `sp_registrar_notificacion_viatico` 
DROP PROCEDURE IF EXISTS `sp_registrar_notificacion`;
DELIMITER $$

-- CALL sp_registrar_notificacion(@idnotificacion,1,3,1,2,'yooo')
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
    VALUES (_idusuariodest, _idusuariorem , _tipo, nullif(_idreferencia,''), _mensaje);

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

DROP PROCEDURE IF EXISTS sp_obtener_notificacion_dp;
DELIMITER $$
CREATE PROCEDURE sp_obtener_notificacion_dp
(
    IN _idreferencia INT
)
BEGIN
	SELECT 
		NOTIF.idnotificacion, RAE.tipo, RAE.fecha, RAE.hora, DP.iddetalle_presentacion, DP.fecha_presentacion, USU.nom_usuario, DP.horainicio, DP.horafinal, DP.establecimiento, DP.modalidad, DP.tipo_evento, DIS.distrito, PRO.provincia, DEP.departamento
    FROM notificaciones NOTIF
    LEFT JOIN reportes_artista_evento RAE ON RAE.idreporte = NOTIF.idreferencia
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = RAE.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE NOTIF.idreferencia = _idreferencia AND NOTIF.tipo = 2;
END $$

CALL sp_obtener_notificacion_dp (27)