USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `obtenerConvenioPorId`
DELIMITER //
CREATE PROCEDURE `obtenerConvenioPorId`(
	IN _idtarea	INT
)
BEGIN
	SELECT 		
		*
	FROM convenios C
	LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = C.iddetalle_presentacion
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.iddetalle_presentacion
    WHERE TAR.idtarea = _idtarea -- me quede aca
	GROUP BY TAR.idtarea, TAR.fechainicio, TAR.horainicio, TAR.estado;
END //


DELIMITER $$
CREATE PROCEDURE sp_registrar_convenio (
    OUT _idconvenio INT,
	IN _iddetalle_presentacion INT,
    IN _abono_garantia DOUBLE,
    IN _abono_publicidad DOUBLE,
    IN _propuesta_cliente text,
    IN _estado int
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO convenios (iddetalle_presentacion, abono_garantia, abono_publicidad, propuesta_cliente, estado)
    VALUES (_iddetalle_presentacion, _abono_garantia, _abono_publicidad, _propuesta_cliente, _estado);
    
    IF existe_error = 1 THEN
        SET _idconvenio = -1;
    ELSE
        SET _idconvenio = LAST_INSERT_ID();
    END IF;
END $$

DROP PROCEDURE IF EXISTS sp_actualizar_estado_convenio;
DELIMITER $$
CREATE PROCEDURE sp_actualizar_estado_convenio
(
	IN _idconvenio			INT,
    IN _estado			INT
)
BEGIN 
	UPDATE convenios SET
    estado = _estado,
    updated_at = now()
    WHERE idconvenio = _idconvenio;
END $$

