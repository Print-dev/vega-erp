-- USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_comprobante`;
DELIMITER $$
CREATE PROCEDURE sp_registrar_comprobante(
    OUT _idcomprobante	INT ,
    IN _iddetallepresentacion INT,
    IN _idsucursal int,
    IN _idcliente INT, 
    IN _idtipodoc char(2),
	IN _tipopago  INT,
    IN _nserie char(4),
    IN _correlativo char(8),
    IN _tipomoneda varchar(40),
    IN _monto 	decimal(10,2),
    IN _tieneigv	tinyint,
    IN _noperacion varchar(15)
)
BEGIN
	    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO comprobantes (iddetallepresentacion, idsucursal, idcliente, idtipodoc, tipopago, nserie, correlativo, tipomoneda , monto, tieneigv, noperacion)
    VALUES (_iddetallepresentacion, _idsucursal, _idcliente, _idtipodoc, _tipopago, _nserie, _correlativo, _tipomoneda, _monto, _tieneigv, nullif(_noperacion,''));

    IF existe_error = 1 THEN
        SET _idcomprobante = -1;
    ELSE
        SET _idcomprobante = LAST_INSERT_ID();
    END IF;
END $$
select * from comprobantes;
-- CALL sp_registrar_comprobante (@idcomprobante, 19, 1, 1, '01', 1, 'F001', '00000001', 'PEN', 49205, 1, '');
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
    COMP.iddetallepresentacion,
		COMP.idcomprobante,
        COMP.monto,
		COMP.idcomprobante,
        COMP.nserie,
        COMP.correlativo,
        CLI.razonsocial,
        COMP.fechaemision,
        COMP.horaemision,
        COMP.tipomoneda,
        COMP.tipopago,
        COMP.noperacion,
        CLI.ndocumento,
        CLI.direccion,
        DIS.distrito,
        PRO.provincia,
        DEP.departamento,
        COMP.tieneigv,
		SUC.telefono as telefono_sucursal
    FROM comprobantes COMP
	LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
    LEFT JOIN sucursales SUC ON SUC.idsucursal = COMP.idsucursal
	LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    WHERE COMP.idcomprobante = _idcomprobante
    AND COMP.idtipodoc = _idtipodoc;
END $$

DROP PROCEDURE IF EXISTS sp_obtener_notas_de_venta;
 DELIMITER $$
 CREATE PROCEDURE sp_obtener_notas_de_venta
 (
     IN _fechaemision DATE,
     IN _horaemision TIME,
     IN _numero_comprobante VARCHAR(20) -- Por ejemplo: 'F001-00000001'
 )
 BEGIN
 	SELECT 
		DP.iddetalle_presentacion,
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
     LEFT JOIN items_comprobante ITEM ON ITEM.idcomprobante = COMP.idcomprobante
     LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
     LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = iddetallepresentacion
     WHERE CONCAT(COMP.nserie, '-', COMP.correlativo) LIKE CONCAT('%', COALESCE(_numero_comprobante, ''), '%')
     AND (_fechaemision IS NULL OR COMP.fechaemision = _fechaemision OR COMP.fechaemision IS NULL)
     AND (_horaemision IS NULL OR COMP.horaemision = _horaemision OR COMP.horaemision IS NULL)
     AND COMP.idtipodoc = '02'
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
		DP.iddetalle_presentacion,
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
     LEFT JOIN items_comprobante ITEM ON ITEM.idcomprobante = COMP.idcomprobante
     LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
     LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = iddetallepresentacion
     WHERE CONCAT(COMP.nserie, '-', COMP.correlativo) LIKE CONCAT('%', COALESCE(_numero_comprobante, ''), '%')
     AND (_fechaemision IS NULL OR COMP.fechaemision = _fechaemision OR COMP.fechaemision IS NULL)
     AND (_horaemision IS NULL OR COMP.horaemision = _horaemision OR COMP.horaemision IS NULL)
     AND COMP.idtipodoc = '01'
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
 
DROP PROCEDURE IF EXISTS `sp_registrar_cuota_factura`;
DELIMITER $$
CREATE PROCEDURE `sp_registrar_cuota_factura`(
	IN _idcomprobante INT,
    IN _fecha	date ,
    IN _monto decimal(10,2)
)
BEGIN
    INSERT INTO cuotas_comprobante (idcomprobante, fecha, monto)
    VALUES (_idcomprobante, _fecha, _monto);
END $$


DROP PROCEDURE IF EXISTS sp_obtener_cuotas;
DELIMITER $$

CREATE PROCEDURE sp_obtener_cuotas
(
    IN _fecha DATE,
    IN _numero_comprobante VARCHAR(20),
    IN _idcliente INT
)
BEGIN
    SELECT 
        CCMP.idcuotacomprobante, 
        CLI.idcliente,
        CLI.razonsocial,
        CLI.ndocumento,
        CCMP.idcomprobante, 
        COMP.nserie, 
        COMP.correlativo, 
        CONCAT(COMP.nserie, '-', COMP.correlativo) AS numero_comprobante,
        CCMP.fecha, 
        CCMP.monto AS monto_a_pagar, 
        CCMP.estado,
        IFNULL(SUM(PC.montopagado), 0) AS total_pagado

    FROM cuotas_comprobante CCMP
    LEFT JOIN comprobantes COMP ON COMP.idcomprobante = CCMP.idcomprobante
    LEFT JOIN clientes CLI ON CLI.idcliente = COMP.idcliente
    LEFT JOIN pagos_cuota PC ON PC.idcuotacomprobante = CCMP.idcuotacomprobante

    WHERE 
        (_fecha IS NULL OR CCMP.fecha = _fecha OR CCMP.fecha IS NULL)
        AND (_numero_comprobante IS NULL 
             OR CONCAT(COMP.nserie, '-', COMP.correlativo) LIKE CONCAT('%', COALESCE(_numero_comprobante, ''), '%'))
        AND (_idcliente IS NULL OR COMP.idcliente = _idcliente OR COMP.idcliente IS NULL)

    GROUP BY CCMP.idcuotacomprobante;
END $$
DELIMITER ;

select * from cuotas_comprobante;

DROP PROCEDURE IF EXISTS `sp_registrar_pago_cuota`;
DELIMITER $$
CREATE PROCEDURE sp_registrar_pago_cuota(
	IN _idcuotacomprobante INT,
    IN _montopagado decimal(10,2),
    IN _tipo_pago 	TINYINT, 
    IN _noperacion	VARCHAR(20)
)
BEGIN
    
    INSERT INTO pagos_cuota (idcuotacomprobante, montopagado, tipo_pago, noperacion)
    VALUES (_idcuotacomprobante, _montopagado, _tipo_pago, NULLIF(_noperacion, ''));
END $$

DROP PROCEDURE IF EXISTS `sp_actualizar_estado_cuota_comprobante`;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_estado_cuota_comprobante(
	IN _idcuotacomprobante INT,
    IN _estado TINYINT
)
BEGIN
    		UPDATE cuotas_comprobante SET
	estado = _estado
    WHERE idcuotacomprobante = _idcuotacomprobante; 
END $$


-- CALL sp_obtener_cuotas (null, 'F001-00000003', null);