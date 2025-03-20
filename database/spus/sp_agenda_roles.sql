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
