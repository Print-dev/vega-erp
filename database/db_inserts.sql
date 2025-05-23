
INSERT INTO personas (num_doc, apellidos, nombres, genero, direccion, telefono, telefono2, correo, iddistrito)
VALUES ('72754752', 'Avalos Romero', 'Royer Alexis', 'M', 'Asent. H. Fe y Alegria Mz D Lt 08', '973189350', null, 'royer.190818@email.com', 959);

INSERT INTO nivelaccesos (nivelacceso) values 
	('Vendedor'),
    ('Vendedor Externo'),
    ('Administrador'),
    ('Gerente'),
    ('Director'),
    ('Artista'),
    ('Asistente de Gerencia'),
    ('Community Manager'),
    ('Contabilidad'),
    ('Edicion y Produccion'),
    ('Filmmaker');
    
select * from nivelaccesos;
INSERT INTO nivelaccesos (nivelacceso) values ('Organizador');
    
    INSERT INTO permisos (idnivelacceso, modulo, ruta, texto, visibilidad, icono) 
VALUES 
(3, 'ventas', '', 'Ventas', true, 'fa-solid fa-arrow-trend-up'),
(3, 'ventas', 'listar-atencion-cliente', 'Atención al cliente', false, 'fa-solid fa-users'),
(3, 'ventas', 'registrar-atencion-cliente', '', false, NULL),
(3, 'ventas', 'update-atencion-cliente', NULL, false, NULL);

INSERT INTO empresa (
    ruc, 
    logoempresa, 
    razonsocial, 
    nombrecomercial,
    nombreapp,
    direccion, 
    web, 
    usuariosol, 
    clavesol, 
    certificado
) VALUES (
    '12345678901',               -- ruc (código único de empresa)
    'logo.png',                  -- logoempresa (nombre del archivo de logo o NULL si no se tiene)
    'Razón Social Ejemplo S.A.', -- razonsocial (nombre completo de la empresa)
    'Nombre Comercial S.A.',     -- nombrecomercial 
    'Vega Producciones',			-- (nombre para la barra lateral de la aplicación)
    'Av. Ejemplo 123',           -- direccion (dirección física de la empresa)
    'https://www.ejemplo.com',   -- web (sitio web de la empresa, puede ser NULL)
    'SOL12345',                  -- usuariosol (usuario del sistema SUNAT, si aplica)
    'Clave1234',                 -- clavesol (clave del sistema SUNAT, si aplica)
    'CertificadoEmpresa'         -- certificado (campo de certificado, puede ser NULL)
);


INSERT INTO sucursales (
	idempresa,
    iddistrito,
    idresponsable,
    nombre,
    ruc,
    telefono,
    direccion,
    email
) VALUES (
	1,	
    1,                          -- iddistrito (debe existir en la tabla distritos)
    5,                          -- idresponsable (puede ser null si no hay responsable)
    'Sucursal Central',         -- nombre
    '20123456789',              -- ruc
    '012345678',                -- telefono
    'Av. Siempre Viva 742',     -- direccion
    'contacto@sucursalcentral.com' -- email
);

INSERT INTO usuarios (idsucursal, idnivelacceso, idpersona, nom_usuario, claveacceso, color, porcentaje) values
	(1, 3, 1, 'royer', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC', null, null);
-- select * from sucursales;
-- INSERT INTO clientes (tipodoc, iddistrito, ndocumento, razonsocial, telefono, correo, direccion) values (2 ,74, '10727547521', 'AVALOS ROMERO ROYER ALEXIS', '973189350', 'alexisjkg@gmail.com', 'Asent. FALSA 123');
    


-- INSERT INTO tarifario (idusuario, idprovincia, precio) VALUES (2, 100, 3000.00);

INSERT INTO montoCajaChica (monto) values (0.00);
select * from montoCajaChica;
-- INSERT INTO cajachica (idmonto ,ccinicial, incremento, ccfinal) VALUES (1, 200.00, 50.00, 258.00);

 -- INSERT INTO gastos_cajachica (idcajachica, concepto, monto) values (1, "compra de 2 audifonos", 5.00); 
-- INSERT INTO gastos_cajachica (idcajachica, concepto, monto) values (1, "compra de 1 cable red", 3.00); 

-- INSERT INTO agenda_edicion (iddetalle_presentacion) values (1);
-- INSERT INTO agenda_editores (idagendaedicion, idusuario, tipotarea, fecha_entrega) VALUES (1, 9, 1, '2025-03-25');
INSERT INTO tipotarea (tipotarea) VALUES 
	('Flayer'),
    ('Saludos'),
    ('Reels'),
    ('Fotos'),
    ('Contenido');
    
    select * from nivelaccesos;
    
    
    INSERT INTO conceptos (concepto) VALUES ("oficina"),("ventas"),("costos"),("produccion"),("proyecto"),("fiscal"),("otros"),("inventario");
INSERT INTO subtipos (idconcepto, subtipo) VALUES (1, "renta oficina"),(1, "nomina"),(1, "material oficina"),(1, "gastos oficina"),(1, "capacitacion"),(1, "gasolina"),(1, "cursos"),(1, "seguro camioneta"),(1, "servicios");
INSERT INTO subtipos (idconcepto, subtipo) VALUES (2, "publicidad"),(2, "envio"),(2, "subcontratacion"),(2, "pagina web"),(2, "mensualidad"),(2, "anualidad"),(2, "subscripcion");
INSERT INTO subtipos (idconcepto, subtipo) VALUES (3, "paqueteria"),(3, "envios"),(2, "comisiones"),(2, "pago a cliente");
INSERT INTO subtipos (idconcepto, subtipo) VALUES (4, "materia prima"),(3, "materiales"),(2, "cajas"),(2, "envolturas");
INSERT INTO subtipos (idconcepto, subtipo) VALUES (5, "mano de obra"),(3, "materia prima"),(2, "contratacion"),(2, "extras");
INSERT INTO subtipos (idconcepto, subtipo) VALUES (7, "impuestos"),(3, "contables"),(2, "contador"),(2, "multa");
INSERT INTO subtipos (idconcepto, subtipo) VALUES (8, "comida"),(3, "viaje"),(2, "gasolina");