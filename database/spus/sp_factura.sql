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
    INSERT INTO detalles_factura (idcomprobante, estado, info)
    VALUES (_idcomprobante, _estado, _info);
END $$

DROP PROCEDURE IF EXISTS sp_obtener_facturas;
DELIMITER $$
CREATE PROCEDURE sp_obtener_facturas
(
    IN _fechaemision DATE,
    IN _horaemision TIME,
    IN _numero_comprobante VARCHAR(20) -- Por ejemplo: 'F001-00000001'
)
BEGIN
	SELECT 
        COMP.idcomprobante,
        COMP.idsucursal,
        COMP.idcliente,
        COMP.idtipodoc,
        COMP.fechaemision,
        COMP.horaemision,
        COMP.nserie,
        COMP.correlativo,
        COMP.tipomoneda,
        COMP.monto,
        CONCAT(COMP.nserie, '-', COMP.correlativo) AS numero_comprobante,
        SUM(ITEM.valortotal) AS total_valortotal,
        CLI.razonsocial,
        CLI.ndocumento
    FROM comprobantes COMP
    LEFT JOIN items_factura ITEM ON ITEM.idcomprobante = COMP.idcomprobante
    LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
    WHERE (_numero_comprobante IS NULL OR CONCAT(nserie, '-', correlativo) = _numero_comprobante)
    AND (_fechaemision IS NULL OR COMP.fechaemision = _fechaemision OR COMP.fechaemision IS NULL)
    AND (_horaemision IS NULL OR COMP.horaemision = _horaemision OR COMP.horaemision IS NULL)
     GROUP BY 
        COMP.idcomprobante,
        COMP.idsucursal,
        COMP.idcliente,
        COMP.idtipodoc,
        COMP.fechaemision,
        COMP.horaemision,
        COMP.nserie,
        COMP.correlativo,
        COMP.tipomoneda,
        COMP.monto;
END $$
SELECT * FROM items_factura
-- CALL sp_obtener_facturas ('2025-04-11', '08:20:45','F001-00000001');