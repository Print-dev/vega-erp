USE vega_producciones_erp;

-- DROP procedure if exists sp_o


drop procedure if exists sp_registrar_cajachica;
DELIMITER $$
CREATE PROCEDURE sp_registrar_cajachica (
    OUT _idcajachica INT,
	IN _ccinicial double (8,2),
    IN _incremento double (8,2),
    IN _ccfinal double (8,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO cajachica (ccinicial, incremento, ccfinal)
    VALUES (_ccinicial, _incremento, _ccfinal);
    
    IF existe_error = 1 THEN
        SET _idcajachica = -1;
    ELSE
        SET _idcajachica = LAST_INSERT_ID();
    END IF;
END $$

drop procedure if exists sp_registrar_gasto;
DELIMITER $$
CREATE PROCEDURE sp_registrar_gasto (
    OUT _idgasto INT,
	IN _idcajachica int,
    IN _concepto varchar(300),
    IN _monto double (8,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    INSERT INTO gastos_cajachica (idcajachica, concepto, monto)
    VALUES (_idcajachica, _concepto, _monto);
    
    IF existe_error = 1 THEN
        SET _idgasto = -1;
    ELSE
        SET _idgasto = LAST_INSERT_ID();
    END IF;
END $$

