
 
DROP PROCEDURE IF EXISTS sp_registrar_proveedor;
DELIMITER //
CREATE PROCEDURE sp_registrar_proveedor(
    OUT _idproveedor INT,
    IN _empresa VARCHAR(120),
    IN _nombre VARCHAR(120),
    IN _contacto INT,
    IN _correo VARCHAR(120),
    IN _dni INT,
    IN _banco VARCHAR(200),
    IN _ctabancaria INT,
    IN _servicio VARCHAR(120),
    IN _nproveedor VARCHAR(40)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO proveedores (empresa,nombre, contacto, correo, dni, banco, ctabancaria, servicio, nproveedor)
    VALUES (nullif(_empresa,''), nullif(_nombre,''), nullif(_contacto, '') , nullif(_correo,''), nullif(_dni,''), nullif(_banco,''), nullif(_ctabancaria,''), nullif(_servicio,''), nullif(_nproveedor,''));

    IF existe_error = 1 THEN
        SET _idproveedor = -1;
    ELSE
        SET _idproveedor = LAST_INSERT_ID();
    END IF;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS sp_filtrar_proveedores;
DELIMITER //
CREATE PROCEDURE sp_filtrar_proveedores(
    IN _nombre VARCHAR(120),
    IN _dni CHAR(15)
)
BEGIN
    SELECT *
    FROM proveedores PRO
    WHERE 
        (_nombre IS NULL OR PRO.nombre LIKE CONCAT('%', _nombre, '%')) AND
        (_dni IS NULL OR PRO.dni LIKE CONCAT('%', _dni, '%'))
        ORDER BY idproveedor DESC;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_actualizar_proveedor;
DELIMITER //
CREATE PROCEDURE sp_actualizar_proveedor
(
	IN _idproveedor			INT,
    IN _empresa			VARCHAR(120),
    IN _nombre			VARCHAR(120),
    IN _contacto			INT,
    IN _correo			VARCHAR(120),
    IN _dni				CHAR(15),
    IN _banco			VARCHAR(120),
    IN _ctabancaria			INT,
    IN _servicio			VARCHAR(120),
    IN _nproveedor			VARCHAR(40)
)
BEGIN 
	UPDATE proveedores SET
    empresa = nullif(_empresa,''),
    nombre = nullif(_nombre,''),
    contacto = nullif(_contacto,''),
    correo = nullif(_correo,''),
    dni = nullif(_dni,''),
    banco = nullif(_banco,''),
    ctabancaria = nullif(_ctabancaria,''),
    servicio = nullif(_servicio,''),
    nproveedor = nullif(_nproveedor,'')
    WHERE idproveedor = _idproveedor;
    
END //
DELIMITER ;

