use vega_producciones_erp;

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

