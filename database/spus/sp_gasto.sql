USE vega_producciones_erp;

DROP PROCEDURE IF EXISTS `sp_registrar_gasto_nomina`;
DELIMITER //
CREATE PROCEDURE sp_registrar_gasto_nomina(
    OUT _idgastonomina INT,
    IN _idnomina int,
    IN _descripcion text,
    IN _monto DECIMAL(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET existe_error = 1;
    END;
    
    -- Insertar la notificación
    INSERT INTO gastos_nomina (idnomina, descripcion, monto)
    VALUES (_idnomina , _descripcion, _monto);


    IF existe_error = 1 THEN
        SET _idgastonomina = -1;
    ELSE
        SET _idgastonomina = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_filtrar_gastos;
DELIMITER //

CREATE PROCEDURE sp_filtrar_gastos(
    IN _idproveedor INT,
    IN _fgasto DATE
)
BEGIN
    SELECT 
        *
    FROM 
        gastosentradas GASTOS
        LEFT JOIN colaboradores COL ON COL.idcolaborador = GASTOS.idcolaborador
        LEFT JOIN proveedores PRO ON PRO.idproveedor = GASTOS.idproveedor
		LEFT JOIN subtipos SUB ON SUB.idsubtipo = GASTOS.subtipo
        LEFT JOIN conceptos CON ON CON.idconcepto = SUB.idconcepto
    WHERE 
        (_idproveedor IS NULL OR GASTOS.idproveedor = _idproveedor)
        AND (_fgasto IS NULL OR GASTOS.fgasto = _fgasto)
    ORDER BY 
        GASTOS.idgastoentrada DESC;
END //
DELIMITER ;

call sp_filtrar_gastos (null , null);
select * from gastosentradas;

DROP PROCEDURE IF EXISTS sp_filtrar_gastosyentradas;
DELIMITER //

CREATE PROCEDURE sp_filtrar_gastosyentradas(
    IN _idusuario INT,
    IN _iddetallepresentacion INT,
    IN _fecha_gasto DATE,
    IN _estado INT
)
BEGIN
    SELECT 
        *
    FROM 
        gastosyentradas GASTOS
        LEFT JOIN usuarios USU ON USU.idusuario = GASTOS.idusuario
        LEFT JOIN detalles_presentacion DP ON DP.iddetalle_presentacion = GASTOS.iddetallepresentacion		
    WHERE 
		(_idusuario IS NULL OR USU.idusuario = _idusuario)
        AND (_iddetallepresentacion IS NULL OR DP.iddetalle_presentacion = _iddetallepresentacion)
        AND (_fecha_gasto IS NULL OR GASTOS.fecha_gasto = _fecha_gasto)
        AND (_estado IS NULL OR GASTOS.estado = _estado)
    ORDER BY 
        GASTOS.idgastoentrada DESC;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `sp_registrar_gasto_entrada`;
DELIMITER //
CREATE PROCEDURE sp_registrar_gasto_entrada(
    OUT _idgastoentrada INT,
    IN _estadopago INT,
    IN _fgasto DATE,
    IN _fvencimiento DATE,
    IN _tipo INT,
    IN _concepto INT,
    IN _subtipo INT,
    IN _idproveedor INT,
    IN _idcolaborador INT,
    IN _gasto DECIMAL(10,2),
    IN _cunitario DECIMAL(10,2),
    IN _pagado DECIMAL(10,2),
    IN _idproducto INT,
    IN _cantidad INT,
    IN _unidades INT,
    IN _formapago INT,
    IN _cuenta INT,
    IN _foliofactura VARCHAR(13),
    IN _emision DATE,
    IN _descripcion TEXT,
    IN _costofinal DECIMAL(10,2),
    IN _egreso DECIMAL(10,2),
    IN _montopdte DECIMAL(10,2),
    IN _impuestos DECIMAL(10,2),
    IN _costofinalunit DECIMAL(10,2)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;


    -- Insertar en la tabla nomina
    INSERT INTO gastosentradas (
        estadopago,
        fgasto,
        fvencimiento,
        tipo,
        concepto,
        subtipo,
        idproveedor,
        idcolaborador,
        gasto,
        cunitario,
        pagado,
        idproducto,
        cantidad,
        unidades,
        formapago,
        cuenta,
        foliofactura,
        emision,
        descripcion,
        costofinal,
        egreso,
        montopdte,
        impuestos,
        costofinalunit
    )
    VALUES (
        NULLIF(_estadopago, ''),
        NULLIF(_fgasto, ''),
        NULLIF(_fvencimiento, ''),
        NULLIF(_tipo, ''),
        NULLIF(_concepto, ''),
        NULLIF(_subtipo, ''),
        NULLIF(_idproveedor, ''),
        NULLIF(_idcolaborador, ''),
        NULLIF(_gasto, ''),
        NULLIF(_cunitario, ''),
        NULLIF(_pagado, ''),
        NULLIF(_idproducto, ''),
        NULLIF(_cantidad, ''),
        NULLIF(_unidades, ''),
        NULLIF(_formapago, ''),
        NULLIF(_cuenta, ''),
        NULLIF(_foliofactura, ''),
        NULLIF(_emision, ''),
        NULLIF(_descripcion, ''),
        NULLIF(_costofinal, ''),
        NULLIF(_egreso, ''),
        NULLIF(_montopdte, ''),
        NULLIF(_impuestos, ''),
        NULLIF(_costofinalunit, '')
    );

    -- Devolver el ID insertado o -1 si hubo error
    IF existe_error = 1 THEN
        SET _idgastoentrada = -1;
    ELSE
        SET _idgastoentrada = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

CALL sp_registrar_gasto_entrada(
	@idgastoentrada,
    NULL,  -- _estadopago
    NULL,  -- _fgasto
    NULL,  -- _fvencimiento
    NULL,  -- _tipo
    NULL,  -- _concepto
    NULL,  -- _subtipo
    NULL,  -- _idproveedor
    NULL,  -- _idcolaborador
    NULL,  -- _cunitario
    NULL,  -- _pagado
    NULL,  -- _idproducto
    NULL,  -- _cantidad
    NULL,  -- _unidades
    NULL,  -- _formapago
    NULL,  -- _cuenta
    NULL,  -- _foliofactura
    NULL,  -- _tasafactura
    NULL,  -- _emision
    NULL,  -- _descripcion
    NULL,  -- _costofinal
    NULL,  -- _egreso
    NULL,  -- _montopdte
    NULL,  -- _impuestos
    NULL   -- _costofinalunit
);


-- ****************************** APARTIR DE ACA SI CONSIDERA *****************************************

CALL sp_registrar_gasto_entrada (@idgastoyentrada, 'asdas', '2025-05-21', 2000, 1, 139, 1, 1, 'sasdads', '','');
DROP PROCEDURE IF EXISTS `sp_registrar_gasto_entrada`;
DELIMITER //
CREATE PROCEDURE sp_registrar_gasto_entrada(
    OUT _idgastoentrada INT,
    IN _estado INT,
    IN _concepto VARCHAR(200),
    IN _fecha_gasto date,
	IN _monto DECIMAL(10,2),
    IN _iddetallepresentacion INT,
    IN _idusuario INT,
    IN _mediopago INT,
    IN _detalles VARCHAR(200),
    IN _comprobante_url VARCHAR(200),
    IN _comprobante_fac_bol VARCHAR(200)
)
BEGIN
    DECLARE existe_error INT DEFAULT 0;
    

    -- Insertar la notificación
    INSERT INTO gastosyentradas (estado, concepto, fecha_gasto, monto, iddetallepresentacion, idusuario, mediopago, detalles, comprobante_url, comprobante_fac_bol)
    VALUES (_estado, nullif(_concepto,''), _fecha_gasto , _monto, _iddetallepresentacion, _idusuario,nullif(_mediopago,''),_detalles,_comprobante_url,_comprobante_fac_bol );

    IF existe_error = 1 THEN
        SET _idgastoentrada = -1;
    ELSE
        SET _idgastoentrada = LAST_INSERT_ID();
    END IF;
END //
DELIMITER ;

DROP PROCEDURE if exists sp_pagar_gastoyentrada;
DELIMITER //
CREATE PROCEDURE sp_pagar_gastoyentrada (
	IN _idgastoentrada INT,
	IN _estado INT,
	IN _mediopago INT,
    IN _detalles VARCHAR(200),
	IN _comprobante_url VARCHAR(200),
    IN _comprobante_fac_bol VARCHAR(200)
)
BEGIN
		UPDATE gastosyentradas 
    SET 
		estado = NULLIF(_estado, ''),
		mediopago = NULLIF(_mediopago, ''),
        detalles = NULLIF(_detalles, ''),
        comprobante_url = NULLIF(_comprobante_url, ''),
        comprobante_fac_bol = NULLIF(_comprobante_fac_bol, '')
    WHERE idgastoentrada = _idgastoentrada;
    
END //
DELIMITER ;
-- select * from gastosyentradas
-- CALL sp_pagar_gastoyentrada (1,2, 1, '', '', '');