USE vega_producciones_erp;

DELIMITER $$

CREATE PROCEDURE sp_registrar_detalle_evento (
    OUT _iddetalle_evento INT,
	IN _idusuario int,
    IN _idcliente int,
    IN _fechapresentacion date,
    IN _horapresentacion time,
    IN _tiempopresentacion int,
    IN _establecimiento VARCHAR(80),
    IN _tipoevento CHAR(1),
    IN _modalidad varchar(10),
    IN _validez int,
    IN _igv boolean,
    IN _tipopago VARCHAR(10)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO personas (idusuario, idcliente, fecha_presentacion, hora_presentacion, tiempo_presentacion, establecimiento, tipo_evento, modalidad, validez, igv, tipo_pago, iddistrito)
    VALUES (_idusuario, _idcliente, _fechapresentacion, _horapresentacion, _tiempopresentacion, _establecimiento, _tipoevento, _modalidad, _validez, _igv, _tipopago, _iddistrito);
    
    IF existe_error = 1 THEN
        SET _iddetalle_evento = -1;
    ELSE
        SET _iddetalle_evento = LAST_INSERT_ID();
    END IF;
END $$
