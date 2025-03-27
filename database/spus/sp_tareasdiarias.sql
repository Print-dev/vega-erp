USE vega_producciones_erp;

-- NO HABRA UN SPU PARA REGISTRAR TAREOS DIARIOS PQ ES MUY FACL 
DROP PROCEDURE IF EXISTS sp_asignar_tarea_diaria;
DELIMITER $$
CREATE PROCEDURE sp_asignar_tarea_diaria
(
	OUT _idtaradiariaasig INT,
    IN _idusuario INT,
    IN _idtareadiaria int,
    IN _fecha_entrega DATE,
    IN _hora_entrega TIME,
    IN _estado SMALLINT
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tareas_diaria_asignacion (idusuario, idtareadiaria, fecha_entrega, hora_entrega, estado)VALUES 
		(_idusuario, _idtareadiaria, _fecha_entrega, _hora_entrega, _estado);
        
	IF existe_error= 1 THEN
		SET _idtaradiariaasig = -1;
	ELSE
        SET _idtaradiariaasig = last_insert_id();
	END IF;
END $$