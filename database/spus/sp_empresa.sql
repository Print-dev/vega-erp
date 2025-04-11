USE vega_producciones_erp;

drop procedure if exists sp_obtener_empresa;
DELIMITER //
CREATE PROCEDURE `sp_obtener_empresa`(

)
BEGIN
    SELECT 
	*
    FROM empresa EMP
    LEFT JOIN distritos DIS ON DIS.iddistrito = EMP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento;
-- insert into sucursales (iddistrito, idresponsable, nombre, ruc, telefono, direccion) values (959, 'NEGOCIACIONES Y PRODUCCIONES VEGA S.A.C.', '20608627422', '')
END //

DROP PROCEDURE if exists sp_actualizar_empresa;
DELIMITER //
CREATE PROCEDURE sp_actualizar_empresa (
	IN _idempresa INT,
    IN _ruc char(11),
    IN _logoempresa varchar(40),
    IN _razonsocial VARCHAR(120),
    IN _nombrecomercial varchar(120),
    IN _nombreapp varchar(120),
    IN _direccion varchar(120),
    IN _web VARCHAR(120),
    IN _usuariosol char(8),
    IN _clavesol char(12),
    IN _certificado text
)
BEGIN
		UPDATE empresa SET
	ruc = _ruc,
    logoempresa = nullif(_logoempresa, ''),
    razonsocial = nullif(_razonsocial,''),
    nombrecomercial = nullif(_nombrecomercial, ''),
    nombreapp = nullif(_nombreapp, ''),
    direccion = nullif(_direccion, ''),
    web = nullif(_web, ''),
    usuariosol = nullif(_usuariosol, ''),
    clavesol = nullif(_clavesol, ''),
    certificado = nullif(_certificado , '')
    WHERE idempresa = _idempresa; 
END //
