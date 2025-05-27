
DROP PROCEDURE IF EXISTS `sp_registrar_prodserv`; -- old
DELIMITER //
CREATE PROCEDURE sp_registrar_prodserv(
    OUT _idprodserv INT,
    IN _nombre VARCHAR(80),
    IN _tipo INT,
    IN _codigo VARCHAR(10),
    IN _idproveedor INT,
    IN _precio DECIMAL(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    
    -- Insertar la notificación
    INSERT INTO prodserv (nombre, tipo, codigo, idproveedor, precio)
    VALUES (_nombre , _tipo, _codigo, nullif(_idproveedor, ''), _precio);

    IF existe_error = 1 THEN
        SET _idprodserv = -1;
    ELSE
        SET _idprodserv = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_filtrar_prodserv;
DELIMITER //
CREATE PROCEDURE sp_filtrar_prodserv(
	-- IN _nombres VARCHAR(100),
	-- IN _num_doc VARCHAR(20)
)
BEGIN
	SELECT 
	PROD.idprodserv,
    PROD.nombre as nombre_prodserv,
    PROD.tipo,
    PROD.codigo,
    PRO.nombre as nombre_proveedor,
    PROD.precio
	from prodserv PROD
    LEFT JOIN proveedores PRO ON PRO.idproveedor = PROD.idproveedor
    ORDER BY idprodserv DESC;
END //

DROP PROCEDURE if exists sp_actualizar_prodserv;
DELIMITER //
CREATE PROCEDURE sp_actualizar_prodserv (
	IN _idprodserv INT,
	IN _nombre VARCHAR(80),
	IN _tipo INT,
	IN _codigo varchar(10),
	IN _idproveedor INT,
    IN _precio DECIMAL(10,2)
)
BEGIN
		UPDATE prodserv 
    SET 
		nombre = NULLIF(_nombre, ''),
		tipo = NULLIF(_tipo, ''),
        codigo = NULLIF(_codigo, ''),
        idproveedor = NULLIF(_idproveedor, ''),
        precio = NULLIF(_precio, '')
    WHERE idprodserv = _idprodserv;
END //
DELIMITER ;
