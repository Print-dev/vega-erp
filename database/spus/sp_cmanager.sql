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
	SELECT * FROM agenda_commanager WHERE idagendaeditor = _idagendaeditor;
END $$

DROP PROCEDURE IF EXISTS sp_quitar_responsable_posteo;
DELIMITER $$
CREATE PROCEDURE sp_quitar_responsable_posteo
(
    IN _idagendaeditor INT
)
BEGIN	
	DELETE FROM agenda_commanager WHERE idagendaeditor = _idagendaeditor;
END $$
