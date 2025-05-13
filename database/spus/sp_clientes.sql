-- USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_registrar_cliente;
DELIMITER //
CREATE PROCEDURE sp_registrar_cliente (
    OUT _idcliente INT,
    IN _tipodoc	INT,
	IN _iddistrito INT,
    IN _ndocumento CHAR(20),
    IN _razonsocial VARCHAR(130),
    IN _representantelegal VARCHAR(130),
    IN _telefono char(15),
    IN _correo VARCHAR(130),
    IN _direccion VARCHAR(130)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO clientes (tipodoc, iddistrito, ndocumento, razonsocial, representantelegal, telefono, correo, direccion)
    VALUES (NULLIF(_tipodoc, '') , NULLIF(_iddistrito, '') , NULLIF(_ndocumento, ''), NULLIF(_razonsocial, ''), NULLIF(_representantelegal, ''), NULLIF(_telefono, ''), NULLIF(_correo, ''), NULLIF(_direccion, ''));
    
    IF existe_error = 1 THEN
        SET _idcliente = -1;
    ELSE
        SET _idcliente = LAST_INSERT_ID();
    END IF;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS sp_search_cliente_numdoc;
DELIMITER //
CREATE PROCEDURE sp_search_cliente_numdoc
(
	IN _ndocumento char(20)
)
BEGIN
	SELECT 
    C.idcliente, C.tipodoc, C.ndocumento, C.razonsocial, C.representantelegal, C.telefono, C.correo, C.direccion, 
    NA.idnacionalidad,  D.iddepartamento, PR.idprovincia, DI.iddistrito
    FROM clientes C
    LEFT JOIN distritos DI ON DI.iddistrito = C.iddistrito
    LEFT JOIN provincias PR ON PR.idprovincia = DI.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NA ON NA.idnacionalidad = D.idnacionalidad
    WHERE C.ndocumento = _ndocumento;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_search_cliente;
DELIMITER //
CREATE PROCEDURE sp_search_cliente (
    IN _ndocumento CHAR(20),
    IN _telefono VARCHAR(15), 
    IN _razonsocial VARCHAR(255)
)
BEGIN
    SELECT 
        C.idcliente, C.tipodoc, C.ndocumento, C.razonsocial, C.representantelegal, 
        C.telefono, C.correo, C.direccion, 
        NA.idnacionalidad, D.iddepartamento, PR.idprovincia, DI.iddistrito,
        D.departamento, PR.provincia, DI.distrito
    FROM clientes C
    LEFT JOIN distritos DI ON DI.iddistrito = C.iddistrito
    LEFT JOIN provincias PR ON PR.idprovincia = DI.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NA ON NA.idnacionalidad = D.idnacionalidad
    WHERE 
        (C.ndocumento = _ndocumento OR _ndocumento IS NULL OR _ndocumento = '') 
        AND (C.telefono = _telefono OR _telefono IS NULL OR _telefono = '') 
        AND (C.razonsocial LIKE CONCAT('%', _razonsocial, '%') OR _razonsocial IS NULL OR _razonsocial = '');
END //

DELIMITER ;

-- CALL sp_search_cliente_numdoc('20607656372')

DROP PROCEDURE IF EXISTS sp_actualizar_cliente;
DELIMITER //
CREATE PROCEDURE sp_actualizar_cliente
(
	IN _idcliente			INT,
    IN _tipodoc				INT,
    IN _iddistrito			INT,
    IN _ndocumento			CHAR(20),
    IN _razonsocial			VARCHAR(130),
    IN _representantelegal			VARCHAR(130),
    IN _telefono			 char(15),
    IN _correo			VARCHAR(130),
    IN _direccion			VARCHAR(130)
)
BEGIN 
	UPDATE clientes SET
    tipodoc = nullif(_tipodoc,''),
    iddistrito = nullif(_iddistrito,''),
    ndocumento = nullif(_ndocumento, ''),
    razonsocial = nullif(_razonsocial,''),
    representantelegal = nullif(_representantelegal, ''),
    telefono = nullif(_telefono, ''),
    correo = nullif(_correo, ''),
    direccion = nullif(_direccion,'')
    WHERE idcliente = _idcliente;
END //

select * from clientes

-- CALL sp_actualizar_cliente(2, 74, '72754752', 'ROYER ALEXIS AVLOS ROMEO', '', '938439212', 'alex@gmail.com', 'mi haus 69');