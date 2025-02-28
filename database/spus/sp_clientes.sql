USE vega_producciones_erp;

DELIMITER $$

CREATE PROCEDURE sp_registrar_cliente (
    OUT _idcliente INT,
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
    
    INSERT INTO clientes (iddistrito, ndocumento, razonsocial, representantelegal, telefono, correo, direccion)
    VALUES (NULLIF(_iddistrito, '') , NULLIF(_ndocumento, ''), NULLIF(_razonsocial, ''), NULLIF(_representantelegal, ''), NULLIF(_telefono, ''), NULLIF(_correo, ''), NULLIF(_direccion, ''));
    
    IF existe_error = 1 THEN
        SET _idcliente = -1;
    ELSE
        SET _idcliente = LAST_INSERT_ID();
    END IF;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS sp_search_cliente_numdoc;
DELIMITER $$
CREATE PROCEDURE sp_search_cliente_numdoc
(
	IN _ndocumento char(20)
)
BEGIN
	SELECT 
    C.idcliente, C.ndocumento, C.razonsocial, C.representantelegal, C.telefono, C.correo, C.direccion, 
    NA.idnacionalidad,  D.iddepartamento, PR.idprovincia, DI.iddistrito
    FROM clientes C
    LEFT JOIN distritos DI ON DI.iddistrito = C.iddistrito
    LEFT JOIN provincias PR ON PR.idprovincia = DI.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    LEFT JOIN nacionalidades NA ON NA.idnacionalidad = D.idnacionalidad
    WHERE C.ndocumento = _ndocumento;
END $$

CALL sp_search_cliente_numdoc('20607656372')