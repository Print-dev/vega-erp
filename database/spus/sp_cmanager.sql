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
    IN _establecimiento INT,
    IN _fecha_presentacion DATE,
    IN _
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
    WHERE DEP.idagendaeditor = _iddetalle_presentacion;
END $$
call sp_obtener_agenda_cmmanager(15)
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

