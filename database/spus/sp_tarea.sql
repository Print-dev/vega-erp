USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_registrar_nuevo_tipotarea;
DELIMITER $$
CREATE PROCEDURE sp_registrar_nuevo_tipotarea
(
	OUT _idtipotarea INT,
    IN _tipotarea VARCHAR(30)
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
        SET existe_error = 1;
	END;
    
    INSERT INTO tipotarea (tipotarea) VALUES 
		(_tipotarea);
        
	IF existe_error= 1 THEN
		SET _idtipotarea = -1;
	ELSE
        SET _idtipotarea = last_insert_id();
	END IF;
END $$

-- CALL sp_registrar_nuevo_tipotarea (@idtipotarea, 'Grabaciones');