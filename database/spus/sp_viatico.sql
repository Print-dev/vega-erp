USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_viatico`;
DELIMITER $$
CREATE PROCEDURE sp_registrar_viatico(
    OUT _idviatico INT,
	IN _iddetalle_presentacion INT,
    IN _pasaje decimal(7,2),
    IN _comida	decimal(7,2),
    IN _viaje	decimal(8,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO viaticos (iddetalle_presentacion, pasaje, comida, viaje)
    VALUES (_iddetalle_presentacion, _pasaje, _comida, _viaje);
    
    IF existe_error = 1 THEN
        SET _idviatico = -1;
    ELSE
        SET _idviatico = LAST_INSERT_ID();
    END IF;
END $$

CALL sp_registrar_viatico (@idviatico, 2, 5.00, 45.00, null)

DROP PROCEDURE IF EXISTS sp_actualizar_viatico;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_viatico
(
	IN _idviatico			INT,
    IN _pasaje			INT,
    IN _comida			INT,
    IN _viaje			INT
)
BEGIN 
	UPDATE viaticos SET
    pasaje = _pasaje,
    comida = _comida,
    viaje = nullif(_viaje, '')
    WHERE idviatico = _idviatico;
END $$