USE vega_producciones_erp;

drop procedure if exists sp_listar_sucursales;
DELIMITER //
CREATE PROCEDURE `sp_listar_sucursales`(
)
BEGIN
    SELECT 
	*
    FROM sucursales SUC
    LEFT JOIN distritos DIS ON DIS.iddistrito = SUC.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DEP ON DEP.iddepartamento = PRO.iddepartamento
    LEFT JOIN usuarios USU ON USU.idusuario = SUC.idresponsable
    LEFT JOIN personas PER ON PER.idpersona = USU.idpersona;
-- insert into sucursales (iddistrito, nombre, ruc, telefono, direccion) values (959, 'NEGOCIACIONES Y PRODUCCIONES VEGA S.A.C.', '20608627422', '')
END //

