USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_viatico`;
DELIMITER $$
CREATE PROCEDURE sp_registrar_viatico(
    OUT _idviatico INT,
	IN _iddetalle_presentacion INT,
    IN _pasaje decimal(10,2),
    IN _comida	decimal(10,2),
    IN _viaje	decimal(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO viaticos (iddetalle_presentacion, pasaje, comida, viaje)
    VALUES (_iddetalle_presentacion, _pasaje, _comida, _viaje);
    
    IF existe_error = 1 THEN
        SET _idviatico = -1;
    ELSE
        SET _idviatico = LAST_INSERT_ID();
    END IF;
END $$

CALL sp_registrar_viatico (@idviatico, 2, 5.00, 45.00, null)

DROP PROCEDURE IF EXISTS sp_actualizar_viatico;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_viatico
(
	IN _idviatico			INT,
    IN _pasaje			INT,
    IN _comida			INT,
    IN _viaje			INT
)
BEGIN 
	UPDATE viaticos SET
    pasaje = _pasaje,
    comida = _comida,
    viaje = nullif(_viaje, '')
    WHERE idviatico = _idviatico;
END $$

DROP PROCEDURE IF EXISTS sp_obtener_info_viatico;
DELIMITER $$
CREATE PROCEDURE sp_obtener_info_viatico
(
	IN _idviatico INT
)
BEGIN
	SELECT 
		VIA.idviatico,
        VIA.pasaje, VIA.comida, VIA.viaje,
        USU.nom_usuario,
        DP.fecha_presentacion, DP.horainicio, DP.horafinal, DP.establecimiento,
        DE.departamento, PRO.provincia, DIS.distrito,
        DE.iddepartamento
    FROM viaticos VIA
    LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = VIA.iddetalle_presentacion
    LEFT JOIN usuarios USU ON USU.idusuario = DP.idusuario
    LEFT JOIN distritos DIS ON DIS.iddistrito = DP.iddistrito
    LEFT JOIN provincias PRO ON PRO.idprovincia = DIS.idprovincia
    LEFT JOIN departamentos DE ON DE.iddepartamento = PRO.iddepartamento
    WHERE VIA.idviatico = _idviatico;
END $$