USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_comprobante`;
DELIMITER $$
CREATE PROCEDURE sp_registrar_comprobante(
    OUT _idcomprobante	INT ,
    IN _idsucursal int,
    IN _idcliente INT, 
    IN _idtipodoc char(2),
	IN _tipopago  INT,
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
    INSERT INTO comprobantes (idsucursal, idcliente, idtipodoc, tipopago, nserie, correlativo, tipomoneda , monto)
    VALUES (_idsucursal , _idcliente, _idtipodoc, _tipopago, _nserie, _correlativo, _tipomoneda, _monto);

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
    INSERT INTO items_comprobante (idcomprobante, cantidad, descripcion, valorunitario, valortotal)
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
    INSERT INTO detalles_comprobante (idcomprobante, estado, info)
    VALUES (_idcomprobante, _estado, _info);
END $$

DROP PROCEDURE IF EXISTS sp_obtener_comprobante_por_tipodoc;
DELIMITER $$
CREATE PROCEDURE sp_obtener_comprobante_por_tipodoc
(
    IN _idcomprobante INT,
    IN _idtipodoc	CHAR(2)
)
BEGIN
	SELECT 
		COMP.idcomprobante,
        COMP.nserie,
        COMP.correlativo,
        CLI.razonsocial,
        COMP.fechaemision,
        COMP.horaemision,
        COMP.tipomoneda,
        COMP.tipopago,
        CLI.ndocumento,
        CLI.direccion,
        DIS.distrito,
        PRO.provincia,
        DEP.departamento
    FROM comprobantes COMP
	LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
    LEFT JOIN sucursales SUC ON SUC.idsucursal = COMP.idsucursal
	LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE COMP.idcomprobante = _idcomprobante
    AND COMP.idtipodoc = _idtipodoc;
END $$


-- CALL sp_obtener_facturas ('2025-04-11', '08:20:45','F001-00000001');