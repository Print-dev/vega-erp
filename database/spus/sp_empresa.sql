-- USE vega_producciones_erp;

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
    IN _logoempresa varchar(80),
    IN _razonsocial VARCHAR(120),
    IN _nombrecomercial varchar(120),
    IN _nombreapp varchar(120),
    IN _direccion varchar(120),
    IN _web VARCHAR(120),
    -- IN _usuariosol char(8),
    -- IN _clavesol char(12),
    -- IN _certificado text,
    IN _correo varchar(120),
    IN _contrasenagmailapp varchar(120),
    IN _ncuenta VARCHAR(30),
    IN _ncci VARCHAR(30),
    IN _banco VARCHAR(30),
    IN _moneda VARCHAR(30)
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
    -- usuariosol = nullif(_usuariosol, ''),
    -- clavesol = nullif(_clavesol, ''),
    -- certificado = nullif(_certificado , ''),
    correo = nullif(_correo , ''),
    contrasenagmailapp = nullif(_contrasenagmailapp , ''),
    ncuenta = nullif(_ncuenta , ''),
    ncci = nullif(_ncci , ''),
    banco = nullif(_banco , ''),
    moneda = nullif(_moneda , '')
    WHERE idempresa = _idempresa; 
END //
