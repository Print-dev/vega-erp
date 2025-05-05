-- USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS sp_obtener_permisos;
DELIMITER $$
CREATE PROCEDURE sp_obtener_permisos(IN p_idnivelacceso INT)
BEGIN
    SELECT 
        modulo, ruta, texto, visibilidad, icono
    FROM permisos
    WHERE idnivelacceso = p_idnivelacceso;
END $$

DELIMITER ;
