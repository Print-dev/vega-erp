-- use vega_producciones_erp;

-- USAR ESTE SPU SIEMPRE , EL OTRO SP_TAREA NO SE PQ LO CREE XD NO LO USES POR ESO (29/03/2025)

DROP PROCEDURE IF EXISTS sp_registrar_tipotarea;
DELIMITER $$
CREATE PROCEDURE sp_registrar_tipotarea (
    OUT _idtipotarea INT,
	IN _tipotarea varchar(30)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO tipotarea (tipotarea)
    VALUES (_tipotarea);
    
    IF existe_error = 1 THEN
        SET _idtipotarea = -1;
    ELSE
        SET _idtipotarea = LAST_INSERT_ID();
    END IF;
END $$

DROP PROCEDURE if exists sp_actualizar_nombre_tipotarea;
DELIMITER //
CREATE PROCEDURE sp_actualizar_nombre_tipotarea (
	IN _idtipotarea INT,
    IN _tipotarea varchar(30)
)
BEGIN
		UPDATE tipotarea SET
    tipotarea = _tipotarea    
    WHERE idtipotarea = _idtipotarea; 
END //

DROP PROCEDURE IF EXISTS sp_remover_tipotarea;
DELIMITER $$
CREATE PROCEDURE sp_remover_tipotarea
(
    IN _idtipotarea INT
)
BEGIN	
	DELETE FROM tipotarea WHERE idtipotarea = _idtipotarea;
END $$

SELECT * FROM tipotarea;
CALL sp_remover_tipotarea (6);
