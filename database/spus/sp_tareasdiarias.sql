USE vega_producciones_erp;

-- NO HABRA UN SPU PARA REGISTRAR TAREOS DIARIOS PQ ES MUY FACL (ACTUALIZACION: SI LO HABRA PARA RECIBIR SU ID Y COLOCARLO EN EL SELECT)
DROP PROCEDURE IF EXISTS sp_asignar_tarea_diaria;
DELIMITER $$
CREATE PROCEDURE sp_asignar_tarea_diaria
(
	OUT _idtaradiariaasig INT,
    IN _idusuario INT,
    IN _idtareadiaria int,
    IN _fecha_entrega DATE,
    IN _hora_entrega TIME
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tareas_diaria_asignacion (idusuario, idtareadiaria, fecha_entrega, hora_entrega)VALUES 
		(_idusuario, _idtareadiaria, _fecha_entrega, _hora_entrega);
        
	IF existe_error= 1 THEN
		SET _idtaradiariaasig = -1;
	ELSE
        SET _idtaradiariaasig = last_insert_id();
	END IF;
END $$

DROP PROCEDURE IF EXISTS sp_registrar_tarea_diaria;
DELIMITER $$
CREATE PROCEDURE sp_registrar_tarea_diaria
(
	OUT _idtareadiaria INT,
    IN _tarea varchar(120)
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tareas_diarias (tarea)VALUES 
		(_tarea);
        
	IF existe_error= 1 THEN
		SET _idtareadiaria = -1;
	ELSE
        SET _idtareadiaria = last_insert_id();
	END IF;
END $$


DROP PROCEDURE IF EXISTS sp_obtener_tareas_diarias_por_usuario;
DELIMITER $$
CREATE PROCEDURE sp_obtener_tareas_diarias_por_usuario
(
    IN _idusuario INT
)
BEGIN
	SELECT 
		TDA.idtaradiariaasig, PER.nombres, PER.apellidos, TDA.fecha_entrega, TDA.hora_entrega, TDA.estado, TD.tarea, TD.idtareadiaria
    FROM tareas_diaria_asignacion TDA
    LEFT JOIN tareas_diarias TD ON TD.idtareadiaria  = TDA.idtareadiaria
    LEFT JOIN usuarios USU ON USU.idusuario = TDA.idusuario
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE TDA.idusuario = _idusuario;
END $$

DROP PROCEDURE if exists sp_actualizar_estado_tarea_diaria_asignacion;
DELIMITER //
CREATE PROCEDURE sp_actualizar_estado_tarea_diaria_asignacion (
	IN _idtaradiariaasig INT,
    IN _estado SMALLINT
)
BEGIN
		UPDATE tareas_diaria_asignacion SET
    estado = _estado    
    WHERE idtaradiariaasig = _idtaradiariaasig; 
END //

CALL sp_obtener_tareas_diarias_por_usuario (2)