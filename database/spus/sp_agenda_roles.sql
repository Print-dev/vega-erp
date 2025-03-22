use vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_asignar_agenda;
DELIMITER $$
CREATE PROCEDURE sp_asignar_agenda (
    OUT _idasignacion INT,
	IN _iddetalle_presentacion int,
    IN _idusuario INT
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO agenda_asignaciones (iddetalle_presentacion, idusuario)
    VALUES (_iddetalle_presentacion, _idusuario);
    
    IF existe_error = 1 THEN
        SET _idasignacion = -1;
    ELSE
        SET _idasignacion = LAST_INSERT_ID();
    END IF;
END $$

DROP PROCEDURE IF EXISTS sp_obtener_filmmaker_asignado;
DELIMITER $$
CREATE PROCEDURE sp_obtener_filmmaker_asignado
(
    IN _iddetalle_presentacion INT
)
BEGIN
	SELECT 
		AGE.idasignacion, AGE.iddetalle_presentacion, AGE.idusuario, PER.nombres, PER.apellidos
    FROM agenda_asignaciones AGE
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.iddetalle_presentacion = _iddetalle_presentacion;
END $$


-- EDITORES 
-- SELECT * FROM agenda_editores;
-- CALL sp_asignar_agenda_editor(@idagendaeditor, 1,10,2,'2025-03-28');
DROP PROCEDURE IF EXISTS sp_asignar_agenda_editor; -- editado
DELIMITER $$
CREATE PROCEDURE sp_asignar_agenda_editor (
    OUT _idagendaeditor INT,
	IN _idagendaedicion int,
	IN _idusuario int,
    IN _tipotarea INT,
    IN _fecha_entrega DATETIME
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO agenda_editores (idagendaedicion, idusuario , tipotarea, fecha_entrega)
    VALUES (_idagendaedicion, _idusuario, _tipotarea, _fecha_entrega);
    
    IF existe_error = 1 THEN
        SET _idagendaeditor = -1;
    ELSE
        SET _idagendaeditor = LAST_INSERT_ID();
    END IF;
END $$

DROP PROCEDURE if exists sp_actualizar_agenda_editor; -- ELIMINAR ESTO
DELIMITER //
CREATE PROCEDURE sp_actualizar_agenda_editor (
	IN _idagendaeditor INT,
    IN _urlimagen VARCHAR(40),
    IN _urlvideo VARCHAR(200)
)
BEGIN
		UPDATE agenda_editores SET
    url_imagen = _urlimagen,
    url_video = _urlvideo
    WHERE idagendaeditor = _idagendaeditor; 
END //

DROP PROCEDURE IF EXISTS sp_subir_contenido_editor; -- editado
DELIMITER $$
CREATE PROCEDURE sp_subir_contenido_editor (
	OUT _idsubida INT,
    IN _idagendaeditor INT,
	IN _url_imagen varchar(40),
    IN _url_video varchar(200)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO subidas_agenda_edicion (idagendaeditor, url_imagen , url_video)
    VALUES (_idagendaeditor, nullif(_url_imagen,''), nullif(_url_video,''));
    
    IF existe_error = 1 THEN
        SET _idsubida = -1;
    ELSE
        SET _idsubida = LAST_INSERT_ID();
    END IF;
END $$


DROP PROCEDURE IF EXISTS sp_obtener_contenido_historial_edicion;
DELIMITER $$
CREATE PROCEDURE sp_obtener_contenido_historial_edicion
(
    IN _idagendaeditor INT
)
BEGIN
	SELECT 
	*
    FROM subidas_agenda_edicion SUBI
    LEFT JOIN agenda_editores AGE ON AGE.idagendaeditor = SUBI.idagendaeditor
    WHERE SUBI.idagendaeditor = _idagendaeditor;
END $$

DROP PROCEDURE IF EXISTS sp_obtener_agenda_editores;
DELIMITER $$
CREATE PROCEDURE sp_obtener_agenda_editores
(
    IN _idagendaedicion INT
)
BEGIN
	SELECT 
	AGE.idagendaeditor, AGE.tipotarea, PER.nombres, USU.idusuario, AGE.fecha_entrega, AGE.estado
    FROM agenda_editores AGE
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.idagendaedicion = _idagendaedicion;
END $$


DROP PROCEDURE if exists sp_actualizar_observacion_subida; -- ELIMINAR ESTO (que?)
DELIMITER //
CREATE PROCEDURE sp_actualizar_observacion_subida (
	IN _idsubida INT,
    IN _observaciones VARCHAR(250)
)
BEGIN
	UPDATE subidas_agenda_edicion SET
    observaciones = _observaciones
    WHERE idsubida = _idsubida; 

END //

DROP PROCEDURE if exists sp_actualizar_estado_tarea_edicion;
DELIMITER //
CREATE PROCEDURE sp_actualizar_estado_tarea_edicion (
	IN _idagendaeditor INT,
    IN _estado VARCHAR(250)
)
BEGIN
	UPDATE agenda_editores SET
    estado = _estado
    WHERE idagendaeditor = _idagendaeditor; 

END //



-- CALL sp_subir_contenido_editor(@idsubida, 1, 'hola.kjpg','');
select * from subidas_agenda_edicion

DROP PROCEDURE IF EXISTS sp_obtener_usuario_asignado_tarea;
DELIMITER $$
CREATE PROCEDURE sp_obtener_usuario_asignado_tarea
(
    IN _idusuario INT
)
BEGIN
	SELECT 
	AGE.idagendaeditor, AGE.tipotarea, PER.nombres, USU.idusuario, AGE.fecha_entrega, AGE.estado
    FROM agenda_editores AGE
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.idusuario = _idusuario;
END $$

DROP PROCEDURE IF EXISTS sp_quitar_tarea_usuario;
DELIMITER $$
CREATE PROCEDURE sp_quitar_tarea_usuario
(
    IN _idagendaeditor INT
)
BEGIN	
	DELETE FROM agenda_editores WHERE idagendaeditor = _idagendaeditor;
END $$

DROP PROCEDURE IF EXISTS sp_obtener_tareas_editor;
DELIMITER $$
CREATE PROCEDURE sp_obtener_tareas_editor
(
    IN _idusuario INT
)
BEGIN	
	SELECT 
		AGED.idagendaeditor, AGED.fecha_asignacion, DP.fecha_presentacion, DP.horainicio, DP.horafinal, DP.establecimiento, DP.estado, USU.nom_usuario, USUDP.color
		FROM agenda_editores AGED
		LEFT JOIN agenda_edicion AGEN ON AGEN.idagendaedicion = AGED.idagendaedicion
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGEN.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_idusuario IS NULL OR AGED.idusuario = _idusuario OR AGED.idusuario IS NULL);
END $$

-- CALL sp_obtener_tareas_editor (6);
-- select * from usuarios;