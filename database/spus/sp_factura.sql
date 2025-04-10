USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_comprobante`;
DELIMITER $$
CREATE PROCEDURE sp_registrar_comprobante(
    OUT _idcomprobante	INT ,
    IN _idsucursal int,
    IN _idcliente INT, 
    IN _idtipodoc char(2),
    IN _nserie char(4),
    IN _correlativo char(8),
    IN _tipomoneda varchar(40),
    IN _monto 	decimal(10,2)
)
BEGIN
	    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO comprobantes (idsucursal, idcliente, idtipodoc, nserie, correlativo, tipomoneda , monto)
    VALUES (_idsucursal , _idcliente, _idtipodoc, _nserie, _correlativo, _tipomoneda, _monto);

    IF existe_error = 1 THEN
        SET _idcomprobante = -1;
    ELSE
        SET _idcomprobante = LAST_INSERT_ID();
    END IF;
END $$

DROP PROCEDURE IF EXISTS `sp_registrar_item_comprobante`;
DELIMITER $$
CREATE PROCEDURE sp_registrar_item_comprobante(
	IN _idcomprobante INT,
    IN _cantidad	INT ,
    IN _descripcion text,
    IN _valorunitario decimal(10,2) ,
    IN _valortotal decimal(10,2) 
)
BEGIN
    INSERT INTO items_factura (idcomprobante, cantidad, descripcion, valorunitario, valortotal)
    VALUES (_idcomprobante, _cantidad, _descripcion, _valorunitario, _valortotal);
END $$

DROP PROCEDURE IF EXISTS `sp_registrar_detalle_comprobante`;
DELIMITER $$
CREATE PROCEDURE sp_registrar_detalle_comprobante(
	IN _idcomprobante INT,
    IN _estado	varchar(10),
    IN _info varchar(60)
)
BEGIN
    INSERT INTO items_factura (idcomprobante, estado, info)
    VALUES (_idcomprobante, _estado, _info);
END $$