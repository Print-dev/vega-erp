INSERT INTO nacionalidades (nacionalidad) VALUES
('Afgana'),
('Albanesa'),
('Alemana'),
('Andorrana'),
('Angoleña'),
('Argentina'),
('Australiana'),
('Belga'),
('Boliviana'),
('Brasileña'),
('Canadiense'),
('Chilena'),
('China'),
('Colombiana'),
('Costarricense'),
('Cubana'),
('Ecuatoriana'),
('Egipcia'),
('Española'),
('Estadounidense'),
('Filipina'),
('Francesa'),
('Guatemalteca'),
('Hondureña'),
('India'),
('Italiana'),
('Japonesa'),
('Mexicana'),
('Panameña'),
('Paraguaya'),
('Peruana'),
('Portuguesa'),
('Salvadoreña'),
('Suiza'),
('Uruguaya'),
('Venezolana');

INSERT INTO departamentos (departamento, idnacionalidad) VALUES
('Amazonas', 31),
('Áncash', 31),
('Apurímac', 31),
('Arequipa', 31),
('Ayacucho', 31),
('Cajamarca', 31),
('Callao', 31),
('Cusco', 31),
('Huancavelica', 31),
('Huánuco', 31),
('Ica', 31),
('Junín', 31),
('La Libertad', 31),
('Lambayeque', 31),
('Lima', 31),
('Loreto', 31),
('Madre de Dios', 31),
('Moquegua', 31),
('Pasco', 31),
('Piura', 31),
('Puno', 31),
('San Martín', 31),
('Tacna', 31),
('Tumbes', 31),
('Ucayali', 31);

INSERT INTO provincias (provincia, iddepartamento) VALUES
-- Amazonas
('Chachapoyas', 1), ('Bagua', 1), ('Bongará', 1), ('Condorcanqui', 1), ('Luya', 1), ('Rodríguez de Mendoza', 1), ('Utcubamba', 1),
-- Áncash
('Huaraz', 2), ('Aija', 2), ('Antonio Raymondi', 2), ('Asunción', 2), ('Bolognesi', 2), ('Carhuaz', 2), ('Carlos Fermín Fitzcarrald', 2), ('Casma', 2), ('Corongo', 2), ('Huari', 2), ('Huarmey', 2), ('Huaylas', 2), ('Mariscal Luzuriaga', 2), ('Ocros', 2), ('Pallasca', 2), ('Pomabamba', 2), ('Recuay', 2), ('Santa', 2), ('Sihuas', 2), ('Yungay', 2),
-- Apurímac
('Abancay', 3), ('Andahuaylas', 3), ('Antabamba', 3), ('Aymaraes', 3), ('Cotabambas', 3), ('Chincheros', 3), ('Grau', 3),
-- Arequipa
('Arequipa', 4), ('Camaná', 4), ('Caravelí', 4), ('Castilla', 4), ('Caylloma', 4), ('Condesuyos', 4), ('Islay', 4), ('La Unión', 4),
-- Ayacucho
('Huamanga', 5), ('Cangallo', 5), ('Huanca Sancos', 5), ('Huanta', 5), ('La Mar', 5), ('Lucanas', 5), ('Parinacochas', 5), ('Paucar del Sara Sara', 5), ('Sucre', 5), ('Víctor Fajardo', 5), ('Vilcas Huamán', 5),
-- Cajamarca
('Cajamarca', 6), ('Cajabamba', 6), ('Celendín', 6), ('Chota', 6), ('Contumazá', 6), ('Cutervo', 6), ('Hualgayoc', 6), ('Jaén', 6), ('San Ignacio', 6), ('San Marcos', 6), ('San Miguel', 6), ('San Pablo', 6), ('Santa Cruz', 6),
-- Callao
('Callao', 7),
-- Cusco
('Cusco', 8), ('Acomayo', 8), ('Anta', 8), ('Calca', 8), ('Canas', 8), ('Canchis', 8), ('Chumbivilcas', 8), ('Espinar', 8), ('La Convención', 8), ('Paruro', 8), ('Paucartambo', 8), ('Quispicanchi', 8), ('Urubamba', 8),
-- Huancavelica
('Huancavelica', 9), ('Acobamba', 9), ('Angaraes', 9), ('Castrovirreyna', 9), ('Churcampa', 9), ('Huaytará', 9), ('Tayacaja', 9),
-- Huánuco
('Huánuco', 10), ('Ambo', 10), ('Dos de Mayo', 10), ('Huacaybamba', 10), ('Huamalíes', 10), ('Leoncio Prado', 10), ('Marañón', 10), ('Pachitea', 10), ('Puerto Inca', 10), ('Lauricocha', 10), ('Yarowilca', 10),
-- Ica
('Ica', 11), ('Chincha', 11), ('Nasca', 11), ('Palpa', 11), ('Pisco', 11),
-- Junín
('Huancayo', 12), ('Concepción', 12), ('Chanchamayo', 12), ('Jauja', 12), ('Junín', 12), ('Satipo', 12), ('Tarma', 12), ('Yauli', 12), ('Chupaca', 12),
-- La Libertad
('Trujillo', 13), ('Ascope', 13), ('Bolívar', 13), ('Chepén', 13), ('Julcán', 13), ('Otuzco', 13), ('Pacasmayo', 13), ('Pataz', 13), ('Sánchez Carrión', 13), ('Santiago de Chuco', 13), ('Gran Chimú', 13), ('Virú', 13),
-- Lima
('Lima', 15), ('Barranca', 15), ('Cajatambo', 15), ('Canta', 15), ('Cañete', 15), ('Huaral', 15), ('Huarochirí', 15), ('Huaura', 15), ('Oyón', 15), ('Yauyos', 15);


INSERT INTO distritos (distrito, idprovincia) VALUES
-- Distritos de Chachapoyas
('Chachapoyas', 1), ('Asunción', 1), ('Balsas', 1), ('Cheto', 1), ('Chiliquín', 1), ('Chuquibamba', 1), ('Granada', 1), ('Huancas', 1), ('La Jalca', 1), ('Leimebamba', 1), ('Levanto', 1), ('Magdalena', 1), ('Mariscal Castilla', 1), ('Molinopampa', 1), ('Montevideo', 1), ('Olleros', 1), ('Quinjalca', 1), ('San Francisco de Daguas', 1), ('San Isidro de Maino', 1), ('Soloco', 1), ('Sonche', 1),
-- Distritos de Bagua
('Bagua', 2), ('Aramango', 2), ('Copallín', 2), ('El Parco', 2), ('Imaza', 2), ('La Peca', 2),
-- Distritos de Huaraz
('Huaraz', 8), ('Cochabamba', 8), ('Colcabamba', 8), ('Huanchay', 8), ('Independencia', 8), ('Jangas', 8), ('La Libertad', 8), ('Olleros', 8), ('Pampas', 8), ('Pariacoto', 8), ('Pira', 8), ('Tarica', 8),
-- Distritos de Abancay
('Abancay', 22), ('Chacoche', 22), ('Circa', 22), ('Curahuasi', 22), ('Huanipaca', 22), ('Lambrama', 22), ('Pichirhua', 22), ('San Pedro de Cachora', 22), ('Tamburco', 22),
-- Distritos de Andahuaylas
('Andahuaylas', 23), ('Andarapa', 23), ('Chiara', 23), ('Huancarama', 23), ('Huancaray', 23), ('Huayana', 23), ('José María Arguedas', 23), ('Kishuara', 23), ('Pacobamba', 23), ('Pacucha', 23), ('Pampachiri', 23), ('Pomacocha', 23), ('San Antonio de Cachi', 23), ('San Jerónimo', 23), ('San Miguel de Chaccrampa', 23), ('Santa María de Chicmo', 23), ('Talavera', 23), ('Tumay Huaraca', 23), ('Turpo', 23),
-- distritos de chincha
('Chincha Alta', 100),
('Alto Larán', 100),
('Chavín', 100),
('Chincha Baja', 100),
('El Carmen', 100),
('Grocio Prado', 100),
('Pueblo Nuevo', 100),
('San Juan de Yanac', 100),
('San Pedro de Huacarpana', 100),
('Sunampe', 100),
('Tambo de Mora', 100);



INSERT INTO personas (num_doc, apellidos, nombres, genero, direccion, telefono, telefono2, correo, iddistrito)
VALUES ('12345678', 'Pérez', 'Juan', 'M', 'Av. Principal 123', '987654321', '912345678', 'juan.perez@email.com', 1);

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
	(3, 1, 'royer', '$2y$10$dd0F7Ch7mNrkw2EIZAh9FurwSYjpQ3C9dA6wySo5MG75MzPT1IyUC')
