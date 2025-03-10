

INSERT INTO personas (num_doc, apellidos, nombres, genero, direccion, telefono, telefono2, correo, iddistrito)
VALUES ('12345678', 'Pérez', 'Juan', 'M', 'Av. Principal 123', '987654321', '912345678', 'juan.perez@email.com', 1),
	('72754758', 'Test Test', 'Test Test', 'F', 'calle false 777', '999333222', '', 'test@gmail.com', 1);

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

INSERT INTO usuarios (idnivelacceso, idpersona, nom_usuario, claveacceso) values
	(3, 1, 'royer', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC'),
    (6, 2, 'Azucena Calvay', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC');

INSERT INTO clientes (tipodoc, iddistrito, ndocumento, razonsocial, telefono, correo, direccion) values
	(2 ,74, '10727547521', 'AVALOS ROMERO ROYER ALEXIS', '973189350', 'alexisjkg@gmail.com', 'Asent. FALSA 123');
    


INSERT INTO tarifario (idusuario, idprovincia, precio) VALUES (2, 100, 3000.00);