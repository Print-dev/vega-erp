USE vega_producciones_erp;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_search_tarifa_artista;
DELIMITER $$
CREATE PROCEDURE sp_search_tarifa_artista
(
	IN _nom_usuario varchar(30)
)
BEGIN
	SELECT 
    T.idtarifario, USU.nom_usuario, D.departamento, PR.provincia, T.precio
    FROM tarifario T
    LEFT JOIN usuarios USU ON USU.idusuario = T.idusuario 
    LEFT JOIN provincias PR ON PR.idprovincia = T.idprovincia
    LEFT JOIN departamentos D ON D.iddepartamento = PR.iddepartamento
    WHERE USU.nom_usuario LIKE CONCAT('%', COALESCE(_nom_usuario, ''), '%');
END $$

CALL sp_search_tarifa_artista('A');