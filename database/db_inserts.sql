

INSERT INTO personas (num_doc, apellidos, nombres, genero, direccion, telefono, telefono2, correo, iddistrito)
VALUES ('12345678', 'Pérez', 'Juan', 'M', 'Av. Principal 123', '987654321', '912345678', 'juan.perez@email.com', 1),
	('72754758', 'Test Test', 'Test Test', 'F', 'calle false 777', '999333222', '', 'test@gmail.com', 1),
	('72754753', 'Fulano Doe', 'Johan', 'M', 'calle false 333', '999333000', '', 'teste@gmail.com', 1),
	('72754759', 'Quispe Mamani', 'Ray', 'M', 'calle false 444', '999333040', '', 'testo@gmail.com', 1),
	('72754754', 'Test Test', 'Oscar Manuel', 'M', 'calle false 888', '999333041', '', 'tiesto@gmail.com', 1),
	('72754757', 'Doe Doe', 'Andres', 'M', 'calle av tomas valle', '999333043', '', 'hola@gmail.com', 1);

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
    
    INSERT INTO permisos (idnivelacceso, modulo, ruta, texto, visibilidad, icono) 
VALUES 
(3, 'ventas', '', 'Ventas', true, 'fa-solid fa-arrow-trend-up'),
(3, 'ventas', 'listar-atencion-cliente', 'Atención al cliente', false, 'fa-solid fa-users'),
(3, 'ventas', 'registrar-atencion-cliente', '', false, NULL),
(3, 'ventas', 'update-atencion-cliente', NULL, false, NULL);

INSERT INTO usuarios (idnivelacceso, idpersona, nom_usuario, claveacceso, color, porcentaje) values
	(3, 1, 'royer', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC', null, null),
    (6, 2, 'Azucena Calvay', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC', '#6173cc', 75),
    (11,3, 'Johan Films', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC', null, null),
    (11,4, 'Ray Films', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC', null , null),
    (6,5, 'Oscar Manuel y Orquesta', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC', '#6ccc61', null),
    (10,6, 'Andres Editor', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC', null, null);

INSERT INTO clientes (tipodoc, iddistrito, ndocumento, razonsocial, telefono, correo, direccion) values
	(2 ,74, '10727547521', 'AVALOS ROMERO ROYER ALEXIS', '973189350', 'alexisjkg@gmail.com', 'Asent. FALSA 123');
    


INSERT INTO tarifario (idusuario, idprovincia, precio) VALUES (2, 100, 3000.00);

INSERT INTO montoCajaChica (monto) values (500.00);
INSERT INTO cajachica (idmonto ,ccinicial, incremento, ccfinal) VALUES (1, 200.00, 50.00, 258.00);

INSERT INTO gastos_cajachica (idcajachica, concepto, monto) values (1, "compra de 2 audifonos", 5.00); 
INSERT INTO gastos_cajachica (idcajachica, concepto, monto) values (1, "compra de 1 cable red", 3.00); 

-- INSERT INTO agenda_edicion (iddetalle_presentacion) values (1);
-- INSERT INTO agenda_editores (idagendaedicion, idusuario, tipotarea, fecha_entrega) VALUES (1, 9, 1, '2025-03-25');