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
    
    INSERT INTO detalles_presentacion (idusuario, idcliente, iddistrito, ncotizacion, fecha_presentacion, hora_presentacion, tiempo_presentacion, establecimiento, tipo_evento, modalidad, validez, igv, tipo_pago)
    VALUES (_idusuario, _idcliente, _iddistrito, NULLIF(_ncotizacion, ''), _fechapresentacion, _horapresentacion, _tiempopresentacion, _establecimiento, _tipoevento, _modalidad, NULLIF(_validez, ''), _igv, _tipopago);
    
    IF existe_error = 1 THEN
        SET _iddetalle_presentacion = -1;
    ELSE
        SET _iddetalle_presentacion = LAST_INSERT_ID();
    END IF;
END $$

drop procedure if exists sp_obtener_dp_porid;
DELIMITER //
CREATE PROCEDURE `sp_obtener_dp_porid`(
	IN _iddetalle_presentacion	INT
)
BEGIN
	SELECT 		
		DP.iddetalle_presentacion, DE.departamento, PRO.provincia, DIS.distrito, PRO.idprovincia, USU.idusuario, CLI.idcliente, DP.igv
	FROM detalles_presentacion DP
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
	LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
    WHERE DP.iddetalle_presentacion = _iddetalle_presentacion; -- me quede aca
END //

drop procedure if exists sp_obtener_detalles_evento;
DELIMITER //
CREATE PROCEDURE `sp_obtener_detalles_evento`(
	IN _ncotizacion CHAR(9),
    IN _ndocumento CHAR(9)
)
BEGIN
	SELECT 		
		DP.iddetalle_presentacion, CLI.ndocumento ,DP.ncotizacion ,USU.nom_usuario, CLI.razonsocial, DP.tipo_evento, DP.modalidad, DP.fecha_presentacion, CO.idcontrato, DP.validez
	FROM detalles_presentacion DP
	INNER JOIN usuarios USU ON USU.idusuario = DP.idusuario
    INNER JOIN clientes CLI ON CLI.idcliente = DP.idcliente
    LEFT JOIN contratos CO ON CO.iddetalle_presentacion = DP.iddetalle_presentacion
    WHERE DP.ncotizacion LIKE CONCAT('%', COALESCE(_ncotizacion, ''), '%')
		AND CLI.ndocumento LIKE CONCAT('%', COALESCE(_ndocumento, ''), '%');
END //

DROP PROCEDURE sp_actualizar_estado_dp;
DELIMITER //
CREATE PROCEDURE sp_actualizar_estado_dp (
	IN _iddetalle_presentacion INT,
    IN _estado TINYINT
)
BEGIN
		UPDATE detalles_presentacion SET
    estado = _estado
    WHERE idcontrato = _idcontrato; 
END //