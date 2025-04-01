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
    

select * from sucursales
insert into sucursales (iddistrito, nombre, ruc, telefono, direccion)
END //