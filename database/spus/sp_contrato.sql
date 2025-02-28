USE vega_producciones_erp;

DELIMITER $$
CREATE PROCEDURE sp_registrar_contrato(
    OUT _idcontrato INT,
	IN _iddetalle_presentacion INT,
    IN _monto_pagado DOUBLE,
    IN _estado int
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO convenios (iddetalle_presentacion, monto_pagado, estado)
    VALUES (_iddetalle_presentacion, _monto_pagado, _estado);
    
    IF existe_error = 1 THEN
        SET _idcontrato = -1;
    ELSE
        SET _idcontrato = LAST_INSERT_ID();
    END IF;
END $$

DROP PROCEDURE IF EXISTS sp_actualizar_estado_contrato;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_estado_contrato
(
	IN _idcontrato			INT,
    IN _estado			INT
)
BEGIN 
	UPDATE contratos SET
    estado = _estado,
    updated_at = now()
    WHERE idcontrato = _idcontrato;
END $$
