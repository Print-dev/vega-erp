USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_asignar_agenda_cmanager;
DELIMITER $$
CREATE PROCEDURE sp_asignar_agenda_cmanager
(
	OUT _idagendacommanager INT,
    IN _idagendaeditor INT,
    IN _idusuarioCmanager INT
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO agenda_commanager (idagendaeditor,idusuarioCmanager) VALUES 
		(_idagendaeditor,_idusuarioCmanager);
        
	IF existe_error= 1 THEN
		SET _idagendacommanager = -1;
	ELSE
        SET _idagendacommanager = last_insert_id();
	END IF;
END $$
-- select * from agenda_commanager;
-- CALL sp_asignar_agenda_cmanager (@idagenda, 15)

DROP PROCEDURE IF EXISTS sp_obtener_agenda_cmmanager;
DELIMITER $$
CREATE PROCEDURE sp_obtener_agenda_cmmanager
(
    IN _idagendaeditor INT
)
BEGIN
	SELECT 
    * 
    FROM agenda_commanager  AGENC
    LEFT JOIN agenda_editores AGENE ON AGENE.idagendaeditor = AGENC.idagendaeditor
    LEFT JOIN agenda_edicion AGENED ON AGENED.idagendaedicion = AGENE.idagendaedicion
    LEFT JOIN detalles_presentacion DEP ON DEP.iddetalle_presentacion = AGENED.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DEP.idusuario
    LEFT JOIN tipotarea TIPO ON TIPO.idtipotarea = AGENE.idtipotarea
    WHERE AGENE.idagendaeditor = _idagendaeditor;
END $$

DROP PROCEDURE IF EXISTS sp_obtener_tareas_para_publicar;
DELIMITER $$
CREATE PROCEDURE sp_obtener_tareas_para_publicar
(
    IN _establecimiento varchar(80),
    IN _fecha_presentacion DATE,
    IN _idusuario	INT,
    IN _idusuarioEditor int
    )
BEGIN
	SELECT 
		AGENC.idagendacommanager, AGENE.estado as estadoProgreso, DEP.establecimiento, DEP.fecha_presentacion, USU.idusuario, USU.nom_usuario, AGENC.idusuarioCmanager, PERAGEN.nombres, TIPO.tipotarea, AGENC.copy, AGENC.portalpublicar, AGENC.estado, AGENC.idusuarioCmanager 
    FROM agenda_commanager  AGENC
    LEFT JOIN agenda_editores AGENE ON AGENE.idagendaeditor = AGENC.idagendaeditor
    LEFT JOIN agenda_edicion AGENED ON AGENED.idagendaedicion = AGENE.idagendaedicion
    LEFT JOIN detalles_presentacion DEP ON DEP.iddetalle_presentacion = AGENED.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DEP.idusuario
    LEFT JOIN usuarios USUAGEN ON USUAGEN.idusuario = AGENE.idusuario
    LEFT JOIN personas PERAGEN ON PERAGEN.idpersona = USUAGEN.idpersona
    LEFT JOIN tipotarea TIPO ON TIPO.idtipotarea = AGENE.idtipotarea
    WHERE 
    (DEP.establecimiento IS NULL OR DEP.establecimiento LIKE CONCAT('%', COALESCE(_establecimiento, ''), '%'))
    AND (DEP.fecha_presentacion LIKE CONCAT('%', COALESCE(_fecha_presentacion, ''), '%') OR _fecha_presentacion IS NULL)
    AND (DEP.idusuario LIKE CONCAT('%', COALESCE(_idusuario, ''), '%') OR _idusuario IS NULL)
    AND (AGENC.idusuarioCmanager LIKE CONCAT('%', COALESCE(_idusuarioEditor, ''), '%') OR _idusuarioEditor IS NULL) AND
    AGENE.estado = 2 OR AGENE.estado = 4;
END $$

-- call sp_obtener_tareas_para_publicar("mega", null , 10, 9)

select * from detalles_presentacion;
DROP PROCEDURE IF EXISTS sp_quitar_responsable_posteo;
DELIMITER $$
CREATE PROCEDURE sp_quitar_responsable_posteo
(
    IN _idagendaeditor INT
)
BEGIN	
	DELETE FROM agenda_commanager WHERE idagendaeditor = _idagendaeditor;
END $$


DROP PROCEDURE if exists sp_asignar_portal_web_contenido;
DELIMITER //
CREATE PROCEDURE sp_asignar_portal_web_contenido (
	IN _idagendacommanager INT,
    IN _portalpublicar VARCHAR(120)
)
BEGIN
		UPDATE agenda_commanager SET
    portalpublicar = _portalpublicar    
    WHERE idagendacommanager = _idagendacommanager; 
END //

DROP PROCEDURE if exists sp_actualizar_estado_publicar_contenido;
DELIMITER //
CREATE PROCEDURE sp_actualizar_estado_publicar_contenido (
	IN _idagendacommanager INT,
    IN _estado SMALLINT
)
BEGIN
		UPDATE agenda_commanager SET
    estado = _estado    
    WHERE idagendacommanager = _idagendacommanager; 
END //

-- CALL sp_actualizar_estado_publicar_contenido (1, 2)

DROP PROCEDURE if exists sp_actualizar_copy_contenido;
DELIMITER //
CREATE PROCEDURE sp_actualizar_copy_contenido (
	IN _idagendacommanager INT,
    IN _copy text
)
BEGIN
		UPDATE agenda_commanager SET
    copy = _copy    
    WHERE idagendacommanager = _idagendacommanager; 
END //

