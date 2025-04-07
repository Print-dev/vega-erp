USE vega_producciones_erp;

drop procedure if exists sp_listar_sucursales;
DELIMITER //
CREATE PROCEDURE `sp_listar_sucursales`(
	IN _nombre varchar(120),
    IN _iddepartamento int,
    IN _idprovincia int,
    IN _iddistrito	int
)
BEGIN
    SELECT 
	SUC.idsucursal, DEP.iddepartamento, DEP.departamento, PRO.idprovincia, PRO.provincia, DIS.iddistrito, DIS.distrito,SUC.nombre, SUC.ruc, SUC.telefono, SUC.direccion, PER.nombres, PER.apellidos
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    LEFT JOIN usuarios USU ON USU.idusuario = SUC.idresponsable
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE (SUC.nombre LIKE CONCAT('%', COALESCE(_nombre, ''), '%') OR _nombre IS NULL)
	AND (DIS.iddistrito LIKE CONCAT('%', COALESCE(_iddistrito, ''), '%') OR _iddistrito IS NULL)
	AND (PRO.idprovincia LIKE CONCAT('%', COALESCE(_idprovincia, ''), '%') OR _idprovincia IS NULL)
    AND (DEP.iddepartamento LIKE CONCAT('%', COALESCE(_iddepartamento, ''), '%') OR _iddepartamento IS NULL);
-- insert into sucursales (iddistrito, idresponsable, nombre, ruc, telefono, direccion) values (959, 'NEGOCIACIONES Y PRODUCCIONES VEGA S.A.C.', '20608627422', '')
END //

DROP PROCEDURE IF EXISTS `sp_registrar_sucursal`;
DELIMITER $$
CREATE PROCEDURE sp_registrar_sucursal(
	IN _iddistrito INT,
    IN _idresponsable	INT ,
    IN _nombre varchar(120),
    IN _ruc char(11),
    IN _telefono char(20),
    IN _direccion varchar(120),
    IN _web varchar(120),
    IN _email varchar(120)
)
BEGIN
    INSERT INTO sucursales (iddistrito, idresponsable, nombre, ruc, telefono, direccion, web, email)
    VALUES (_iddistrito, nullif(_idresponsable, ''), nullif(_nombre, ''), _ruc, nullif(_telefono, ''), _direccion, nullif(_web,''), nullif(_email, ''));
END $$
-- call sp_registrar_sucursal (959, 1, 'Vega', '20608627422', '999333212', 'av polla', null, null)
-- select * from sucursales;
DROP PROCEDURE if exists sp_actualizar_sucursal;
DELIMITER //
CREATE PROCEDURE sp_actualizar_sucursal (
	IN _idsucursal INT,
    IN _iddistrito INT,
    IN _idresponsable INT,
    IN _nombre VARCHAR(120),
    IN _ruc char(11),
    IN _telefono CHAR(20),
    IN _direccion VARCHAR(120),
    IN _web VARCHAR(120),
    IN _email VARCHAR(120)
)
BEGIN
		UPDATE sucursales SET
    iddistrito = _iddistrito,
    idresponsable = _idresponsable,
    nombre = _nombre,
    ruc = _ruc,
    telefono = _telefono,
    direccion = _direccion,
    web = _web,
    email = _email
    WHERE idsucursal = _idsucursal; 
END //

drop procedure if exists sp_obtener_representante;
DELIMITER //
CREATE PROCEDURE `sp_obtener_representante`(
	IN _idsucursal INT
)
BEGIN
    SELECT 
	SUC.idsucursal, DEP.departamento, PRO.provincia, DIS.distrito, SUC.nombre, SUC.ruc, SUC.telefono, SUC.direccion, PER.nombres, PER.apellidos, USU.firma, PER.num_doc 
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    LEFT JOIN usuarios USU ON USU.idusuario = SUC.idresponsable
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona
    WHERE SUC.idsucursal = _idsucursal;
END //
