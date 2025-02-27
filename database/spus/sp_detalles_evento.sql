USE vega_producciones_erp;
drop procedure if exists sp_registrar_detalle_presentacion;

DELIMITER $$
CREATE PROCEDURE sp_registrar_detalle_presentacion (
    OUT _iddetalle_presentacion INT,
	IN _idusuario int,
    IN _idcliente int,
	IN _iddistrito int,
    IN _ncotizacion	char(9),
    IN _fechapresentacion date,
    IN _horapresentacion time,
    IN _tiempopresentacion int,
    IN _establecimiento VARCHAR(80),
    IN _tipoevento int,
    IN _modalidad int,
    IN _validez int,
    IN _igv tinyint,
    IN _tipopago int
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO detalles_presentacion (idusuario, idcliente, iddistrito, ncotizacion,fecha_presentacion, hora_presentacion, tiempo_presentacion, establecimiento, tipo_evento, modalidad, validez, igv, tipo_pago)
    VALUES (_idusuario, _idcliente, _iddistrito, _ncotizacion, _fechapresentacion, _horapresentacion, _tiempopresentacion, _establecimiento, _tipoevento, _modalidad, NULLIF(_validez, ''), _igv, _tipopago);
    
    IF existe_error = 1 THEN
        SET _iddetalle_presentacion = -1;
    ELSE
        SET _iddetalle_presentacion = LAST_INSERT_ID();
    END IF;
END $$
