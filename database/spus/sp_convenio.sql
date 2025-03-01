USE vega_producciones_erp;


DROP PROCEDURE IF EXISTS `obtenerContratoConvenio`
DELIMITER //
CREATE PROCEDURE `obtenerContratoConvenio`(
	IN _idconvenio	INT
)
BEGIN
	SELECT 		
		C.idconvenio, 
        CLI.razonsocial, CLI.ndocumento, CLI.direccion, 
        DISCLI.distrito, PROCLI.provincia, DECLI.departamento, 
        USU.nom_usuario,
        DP.fecha_presentacion,
		DP.tiempo_presentacion,
        DP.hora_presentacion,
        DP.establecimiento,
        DISDP.distrito, PRODP.provincia, DEDP.departamento,
        DP.igv,
		C.abono_garantia, C.abono_publicidad
	FROM convenios C
	LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = C.iddetalle_presentacion
    LEFT JOIN clientes CLI ON CLI.idcliente = DP.iddetalle_presentacion
    LEFT JOIN distritos DISCLI ON DISCLI.iddistrito = CLI.iddistrito
    LEFT JOIN provincias PROCLI ON PROCLI.idprovincia = DISCLI.idprovincia
    LEFT JOIN departamentos DECLI ON DECLI.iddepartamento = PROCLI.iddepartamento
    LEFT JOIN distritos DISDP ON DISDP.iddistrito = DP.iddistrito
	LEFT JOIN provincias PRODP ON PRODP.idprovincia = DISDP.idprovincia
    LEFT JOIN departamentos DEDP ON DEDP.iddepartamento = PRODP.iddepartamento
    LEFT JOIN usuarios	USU ON USU.idusuario = DP.idusuario
    WHERE C.idconvenio = _idconvenio; -- me quede aca
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

DROP PROCEDURE IF EXISTS `obtenerConvenioPorIdDP`
DELIMITER //
CREATE PROCEDURE `obtenerConvenioPorIdDP`(
	IN _iddetalle_presentacion	INT
)
BEGIN
	SELECT 		
		C.idconvenio
	FROM convenios C
	LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = C.iddetalle_presentacion
    WHERE C.iddetalle_presentacion = _iddetalle_presentacion; -- me quede aca
END //
