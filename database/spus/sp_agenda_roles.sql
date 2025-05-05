-- use vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_asignar_agenda;
DELIMITER //
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
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_obtener_filmmaker_asignado;
DELIMITER //
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
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_asignar_agenda_editor; -- editado
DELIMITER //
CREATE PROCEDURE sp_asignar_agenda_editor (
    OUT _idagendaeditor INT,
	IN _idagendaedicion int,
	IN _idusuario int,
    IN _idtipotarea INT,
    IN _fecha_entrega date,
    IN _hora_entrega TIME
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO agenda_editores (idagendaedicion, idusuario , idtipotarea, fecha_entrega, hora_entrega)
    VALUES (_idagendaedicion, _idusuario, _idtipotarea, _fecha_entrega, _hora_entrega);
    
    IF existe_error = 1 THEN
        SET _idagendaeditor = -1;
    ELSE
        SET _idagendaeditor = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;


DROP PROCEDURE if exists sp_actualizar_agenda_editor;
DELIMITER //
CREATE PROCEDURE sp_actualizar_agenda_editor (
	IN _idagendaeditor INT,
    IN _idusuario INT,
    IN _idtipotarea INT,
    IN _fecha_entrega DATE,
	IN _hora_entrega TIME
)
BEGIN
		UPDATE agenda_editores SET
    idusuario = _idusuario,
    idtipotarea = _idtipotarea,
    fecha_entrega = _fecha_entrega,
    hora_entrega = _hora_entrega
    WHERE idagendaeditor = _idagendaeditor; 
END //
DELIMITER ;

DROP PROCEDURE if exists obtenerUsuarioAsignado;
DELIMITER //
CREATE PROCEDURE obtenerUsuarioAsignado(
    IN p_idagendaedicion INT,
    IN p_idtipotarea INT
)
BEGIN
    SELECT 
        ae.idagendaeditor,
        ae.idusuario,
        u.nom_usuario,
        tt.tipotarea,
        tt.idtipotarea,
        ae.estado,
        ae.fecha_asignacion,
        ae.fecha_entrega,
        ae.hora_entrega
    FROM agenda_editores ae
    JOIN usuarios u ON ae.idusuario = u.idusuario
    JOIN tipotarea tt ON ae.idtipotarea = tt.idtipotarea
    WHERE ae.idagendaedicion = p_idagendaedicion
    AND ae.idtipotarea = p_idtipotarea;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_subir_contenido_editor; -- editado
DELIMITER //
CREATE PROCEDURE sp_subir_contenido_editor (
	OUT _idsubida INT,
    IN _idagendaeditor INT,
	IN _url TEXT
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO subidas_agenda_edicion (idagendaeditor, url)
    VALUES (_idagendaeditor, _url);
    
    IF existe_error = 1 THEN
        SET _idsubida = -1;
    ELSE
        SET _idsubida = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_obtener_contenido_historial_edicion;
DELIMITER //
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
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_obtener_agenda_editores;
DELIMITER //
CREATE PROCEDURE sp_obtener_agenda_editores
(
    IN _idagendaedicion INT
)
BEGIN
	SELECT 
	AGE.idagendaeditor, TIPO.idtipotarea, TIPO.tipotarea, PER.nombres, USU.idusuario, AGE.fecha_entrega, AGE.hora_entrega, AGE.estado, AGE.altoketicket
    FROM agenda_editores AGE
    LEFT JOIN tipotarea TIPO ON TIPO.idtipotarea = AGE.idtipotarea
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.idagendaedicion = _idagendaedicion;
END //
DELIMITER ;

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
DELIMITER ;

DROP PROCEDURE if exists sp_actualizar_estado_tarea_edicion;
DELIMITER //
CREATE PROCEDURE sp_actualizar_estado_tarea_edicion (
	IN _idagendaeditor INT,
    IN _estado INT
)
BEGIN
	UPDATE agenda_editores SET
    estado = _estado
    WHERE idagendaeditor = _idagendaeditor; 

END //
DELIMITER ;

DROP PROCEDURE if exists sp_actualizar_estado_tarea_altoketicket;
DELIMITER //
CREATE PROCEDURE sp_actualizar_estado_tarea_altoketicket (
	IN _idagendaeditor INT,
    IN _altoketicket VARCHAR(250)
)
BEGIN
	UPDATE agenda_editores SET
    altoketicket = _altoketicket
    WHERE idagendaeditor = _idagendaeditor; 

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_obtener_usuario_asignado_tarea;
DELIMITER //
CREATE PROCEDURE sp_obtener_usuario_asignado_tarea
(
    IN _idusuario INT,
    IN _idagendaedicion INT
)
BEGIN
	SELECT 
	AGE.idagendaedicion, AGE.idagendaeditor, AGE.idtipotarea, PER.nombres, USU.idusuario, AGE.fecha_entrega, AGE.estado
    FROM agenda_editores AGE
    LEFT JOIN usuarios USU ON USU.idusuario = AGE.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE AGE.idusuario = _idusuario AND AGE.idagendaedicion = _idagendaedicion;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_quitar_tarea_usuario;
DELIMITER //
CREATE PROCEDURE sp_quitar_tarea_usuario
(
    IN _idagendaeditor INT
)
BEGIN	
	DELETE FROM agenda_editores WHERE idagendaeditor = _idagendaeditor;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_obtener_tareas_editor;
DELIMITER //
CREATE PROCEDURE sp_obtener_tareas_editor
(
    IN _idusuario INT
)
BEGIN	
	SELECT 
		AGED.idagendaeditor, AGEN.idagendaedicion, AGED.idusuario as idusuarioEdicion, AGED.fecha_asignacion, DP.fecha_presentacion, DP.horainicio, DP.horafinal, DP.establecimiento, DP.estado, USU.nom_usuario, USUDP.color, TIP.tipotarea
		FROM agenda_editores AGED
        LEFT JOIN tipotarea TIP ON TIP.idtipotarea = AGED.idtipotarea
		LEFT JOIN agenda_edicion AGEN ON AGEN.idagendaedicion = AGED.idagendaedicion
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGEN.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_idusuario IS NULL OR AGED.idusuario = _idusuario OR AGED.idusuario IS NULL);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_mostrar_contenido_revisado_edicion;
DELIMITER //
CREATE PROCEDURE sp_mostrar_contenido_revisado_edicion
(
    IN _iddetalle_presentacion INT
)
BEGIN	
	SELECT 
	*
		FROM agenda_edicion AGED		
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGED.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_iddetalle_presentacion IS NULL OR AGED.iddetalle_presentacion = _iddetalle_presentacion OR AGED.iddetalle_presentacion IS NULL);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_mostrar_contenido_revisado_filmmakers;
DELIMITER //
CREATE PROCEDURE sp_mostrar_contenido_revisado_filmmakers
(
    IN _iddetalle_presentacion INT
)
BEGIN	
	SELECT 
	*
		FROM agenda_asignaciones AGENA		
		LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = AGENA.iddetalle_presentacion
		LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
        LEFT JOIN usuarios USUDP ON USUDP.idusuario = DP.idusuario
        WHERE (_iddetalle_presentacion IS NULL OR AGENA.iddetalle_presentacion = _iddetalle_presentacion OR AGENA.iddetalle_presentacion IS NULL);
END //
DELIMITER ;