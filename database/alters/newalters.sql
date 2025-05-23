ALTER TABLE agenda_editores ADD COLUMN altoketicket INT NULL DEFAULT 1 AFTER estado;
ALTER TABLE comprobantes ADD COLUMN noperacion	varchar(15) null;
ALTER TABLE usuarios
MODIFY COLUMN marcaagua VARCHAR(40) NULL,
MODIFY COLUMN firma VARCHAR(40) NULL;

ALTER TABLE empresa
MODIFY COLUMN logoempresa VARCHAR(80) NULL;
ALTER TABLE empresa ADD COLUMN correo			varchar(120) null;
ALTER TABLE empresa ADD COLUMN contrasenagmailapp			varchar(120) null;

ALTER TABLE empresa
  DROP COLUMN usuariosol,
  DROP COLUMN clavesol,
  DROP COLUMN certificado;
  
  ALTER TABLE precios_entrada_evento
  DROP COLUMN preciogeneral,
  DROP COLUMN preciovip,
  ADD COLUMN entradas TEXT NULL;
  
  ALTER TABLE ingresos_evento ADD COLUMN     medio		varchar(30) null;
  
  ALTER TABLE empresa ADD COLUMN ncuenta	varchar(30) null;
ALTER TABLE empresa ADD COLUMN ncci	varchar(30) null;
ALTER TABLE empresa ADD COLUMN banco varchar(30) null;
ALTER TABLE empresa ADD COLUMN moneda varchar(30) null;

ALTER TABLE tarifario
  ADD COLUMN tipo_evento INT NOT NULL;
  
  ALTER TABLE detalles_presentacion
DROP CONSTRAINT ck_tevento_dp;

ALTER TABLE detalles_presentacion
ADD COLUMN idnacionalidad INT NULL,
ADD CONSTRAINT fk_idnacionalidad_dp FOREIGN KEY (idnacionalidad) REFERENCES nacionalidades(idnacionalidad);

ALTER TABLE tarifario
ADD COLUMN idnacionalidad INT NULL,
ADD CONSTRAINT fk_idnacionalidad_tarifario FOREIGN KEY (idnacionalidad) REFERENCES nacionalidades(idnacionalidad);

ALTER TABLE detalles_presentacion
ADD COLUMN idnacionalidad INT NULL,
ADD CONSTRAINT fk_idnacionalidad_dp FOREIGN KEY (idnacionalidad) REFERENCES nacionalidades(idnacionalidad);

ALTER TABLE detalles_presentacion ADD COLUMN esExtranjero TINYINT AFTER created_at;
 ALTER TABLE tarifario
  MODIFY COLUMN idprovincia INT NULL;
  
  ALTER TABLE tarifario
  MODIFY COLUMN idprovincia INT NULL;
  
  ALTER TABLE detalles_presentacion ADD COLUMN esExtranjero TINYINT AFTER created_at;
  
  ALTER TABLE nacionalidades ADD COLUMN pais VARCHAR(50) NOT NULL;
UPDATE nacionalidades SET pais = 'Afganistán' WHERE idnacionalidad = 1;
UPDATE nacionalidades SET pais = 'Albania' WHERE idnacionalidad = 2;
UPDATE nacionalidades SET pais = 'Alemania' WHERE idnacionalidad = 3;
UPDATE nacionalidades SET pais = 'Andorra' WHERE idnacionalidad = 4;
UPDATE nacionalidades SET pais = 'Angola' WHERE idnacionalidad = 5;
UPDATE nacionalidades SET pais = 'Argentina' WHERE idnacionalidad = 6;
UPDATE nacionalidades SET pais = 'Australia' WHERE idnacionalidad = 7;
UPDATE nacionalidades SET pais = 'Bélgica' WHERE idnacionalidad = 8;
UPDATE nacionalidades SET pais = 'Bolivia' WHERE idnacionalidad = 9;
UPDATE nacionalidades SET pais = 'Brasil' WHERE idnacionalidad = 10;
UPDATE nacionalidades SET pais = 'Canadá' WHERE idnacionalidad = 11;
UPDATE nacionalidades SET pais = 'Chile' WHERE idnacionalidad = 12;
UPDATE nacionalidades SET pais = 'China' WHERE idnacionalidad = 13;
UPDATE nacionalidades SET pais = 'Colombia' WHERE idnacionalidad = 14;
UPDATE nacionalidades SET pais = 'Costa Rica' WHERE idnacionalidad = 15;
UPDATE nacionalidades SET pais = 'Cuba' WHERE idnacionalidad = 16;
UPDATE nacionalidades SET pais = 'Ecuador' WHERE idnacionalidad = 17;
UPDATE nacionalidades SET pais = 'Egipto' WHERE idnacionalidad = 18;
UPDATE nacionalidades SET pais = 'España' WHERE idnacionalidad = 19;
UPDATE nacionalidades SET pais = 'Estados Unidos' WHERE idnacionalidad = 20;
UPDATE nacionalidades SET pais = 'Filipinas' WHERE idnacionalidad = 21;
UPDATE nacionalidades SET pais = 'Francia' WHERE idnacionalidad = 22;
UPDATE nacionalidades SET pais = 'Guatemala' WHERE idnacionalidad = 23;
UPDATE nacionalidades SET pais = 'Honduras' WHERE idnacionalidad = 24;
UPDATE nacionalidades SET pais = 'India' WHERE idnacionalidad = 25;
UPDATE nacionalidades SET pais = 'Italia' WHERE idnacionalidad = 26;
UPDATE nacionalidades SET pais = 'Japón' WHERE idnacionalidad = 27;
UPDATE nacionalidades SET pais = 'México' WHERE idnacionalidad = 28;
UPDATE nacionalidades SET pais = 'Panamá' WHERE idnacionalidad = 29;
UPDATE nacionalidades SET pais = 'Paraguay' WHERE idnacionalidad = 30;
UPDATE nacionalidades SET pais = 'Perú' WHERE idnacionalidad = 31;
UPDATE nacionalidades SET pais = 'Portugal' WHERE idnacionalidad = 32;
UPDATE nacionalidades SET pais = 'El Salvador' WHERE idnacionalidad = 33;
UPDATE nacionalidades SET pais = 'Suiza' WHERE idnacionalidad = 34;
UPDATE nacionalidades SET pais = 'Uruguay' WHERE idnacionalidad = 35;
UPDATE nacionalidades SET pais = 'Venezuela' WHERE idnacionalidad = 36;

 ALTER TABLE tarifario ADD COLUMN precioExtranjero DECIMAL (10,2) null;

ALTER TABLE usuarios
MODIFY COLUMN nom_usuario VARCHAR(120) NOT NULL;

-- ******************** LUEGO DE HABERSE SUBIDO AL HOSTINGER ************************************
SET SQL_SAFE_UPDATES = 0;


UPDATE detalles_presentacion
SET esExtranjero = 0,
    idnacionalidad = 31;
    
INSERT INTO agenda_edicion (iddetalle_presentacion) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(36),(37),(38),(39),(40),
(41),(42),(43),(44),(45),(46),(47),(48),(49),(50),
(51),(52),(53),(54),(55),(56),(57),(58),(59),(60),
(61),(62),(63);

INSERT INTO agenda_edicion (iddetalle_presentacion) VALUES
(65),(66),(67),(68),(69),(70),
(71),(72),(73),(74),(75),(76),(77),(78),(79),(80),
(81),(82),(83),(84),(85),(86),(87),(88),(89),(90),
(91),(92),(93),(94),(95),(96),(97),(98),(99),(100),
(101),(102),(103),(104);

INSERT INTO agenda_edicion (iddetalle_presentacion) VALUES
(115),(116),(117),(118),(119),(120),
(121),(122),(123),(124),(125),(126),(127),(128);

select * from detalles_presentacion;

SELECT DISTINCT iddetalle_presentacion 
FROM detalles_presentacion 
ORDER BY iddetalle_presentacion;

WITH RECURSIVE posibles_id AS (
  SELECT 1 AS id
  UNION ALL
  SELECT id + 1 FROM posibles_id WHERE id < 128
)
SELECT id
FROM posibles_id
WHERE id NOT IN (SELECT iddetalle_presentacion FROM detalles_presentacion);

ALTER TABLE sucursales ADD COLUMN ubigeo CHAR(6) NULL;

ALTER TABLE cajachica ADD COLUMN creadopor INT NULL;
ALTER TABLE cajachica ADD CONSTRAINT fk_idusuario_abierto foreign key (creadopor) references usuarios (idusuario);

-- 1. Eliminar la restricción actual
ALTER TABLE gastos_cajachica
DROP FOREIGN KEY fk_idcaja_gastos;

-- 2. Agregar nuevamente la restricción con ON DELETE CASCADE
ALTER TABLE gastos_cajachica
ADD CONSTRAINT fk_idcaja_gastos
FOREIGN KEY (idcajachica)
REFERENCES cajachica(idcajachica)
ON DELETE CASCADE;


ALTER TABLE responsables_boleteria_contratoreservasreservas
ADD CONSTRAINT fk_iddetalle_presentacion_rbc
FOREIGN KEY (iddetalle_presentacion)
REFERENCES detalles_presentacion(iddetalle_presentacion)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea existente
ALTER TABLE precios_entrada_evento
DROP FOREIGN KEY fk_iddp_entrada_convenio;

-- 2. Volver a agregarla con ON DELETE CASCADE
ALTER TABLE precios_entrada_evento
ADD CONSTRAINT fk_iddp_entrada_convenio
FOREIGN KEY (iddetalle_presentacion)
REFERENCES detalles_presentacion(iddetalle_presentacion)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea actual
ALTER TABLE convenios
DROP FOREIGN KEY fk_dp_cv;

-- 2. Re-crear la clave foránea con ON DELETE CASCADE
ALTER TABLE convenios
ADD CONSTRAINT fk_dp_cv
FOREIGN KEY (iddetalle_presentacion)
REFERENCES detalles_presentacion(iddetalle_presentacion)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea actual
ALTER TABLE contratos
DROP FOREIGN KEY fk_dp_cs;

-- 2. Agregar nuevamente la clave foránea con ON DELETE CASCADE
ALTER TABLE contratos
ADD CONSTRAINT fk_dp_cs
FOREIGN KEY (iddetalle_presentacion)
REFERENCES detalles_presentacion(iddetalle_presentacion)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea actual
ALTER TABLE pagos_contrato
DROP FOREIGN KEY fk_idcontrato;

-- 2. Volver a crearla con ON DELETE CASCADE
ALTER TABLE pagos_contrato
ADD CONSTRAINT fk_idcontrato
FOREIGN KEY (idcontrato)
REFERENCES contratos(idcontrato)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea actual
ALTER TABLE reservas
DROP FOREIGN KEY fk_idpagocontrato_res;

-- 2. Agregarla nuevamente con ON DELETE CASCADE
ALTER TABLE reservas
ADD CONSTRAINT fk_idpagocontrato_res
FOREIGN KEY (idpagocontrato)
REFERENCES pagos_contrato(idpagocontrato)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea actual
ALTER TABLE viaticos
DROP FOREIGN KEY fk_iddp_viatico;

-- 2. Agregarla nuevamente con ON DELETE CASCADE
ALTER TABLE viaticos
ADD CONSTRAINT fk_iddp_viatico
FOREIGN KEY (iddetalle_presentacion)
REFERENCES detalles_presentacion(iddetalle_presentacion)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea actual
ALTER TABLE reparticion_ingresos
DROP FOREIGN KEY fk_rep_ing;

-- 2. Volver a agregarla con ON DELETE CASCADE
ALTER TABLE reparticion_ingresos
ADD CONSTRAINT fk_rep_ing
FOREIGN KEY (iddetalle_presentacion)
REFERENCES detalles_presentacion(iddetalle_presentacion)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea actual
ALTER TABLE ingresos_evento
DROP FOREIGN KEY fk_idreparticion_ing;

-- 2. Volver a agregarla con ON DELETE CASCADE
ALTER TABLE ingresos_evento
ADD CONSTRAINT fk_idreparticion_ing
FOREIGN KEY (idreparticion)
REFERENCES reparticion_ingresos(idreparticion)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea actual
ALTER TABLE egresos_evento
DROP FOREIGN KEY fk_idreparticion_egre;

-- 2. Volver a agregarla con ON DELETE CASCADE
ALTER TABLE egresos_evento
ADD CONSTRAINT fk_idreparticion_egre
FOREIGN KEY (idreparticion)
REFERENCES reparticion_ingresos(idreparticion)
ON DELETE CASCADE;

-- 1. Eliminar la clave foránea actual
ALTER TABLE agenda_edicion
DROP FOREIGN KEY fk_iddp_ag_edicion;

-- 2. Volver a agregarla con ON DELETE CASCADE
ALTER TABLE agenda_edicion
ADD CONSTRAINT fk_iddp_ag_edicion
FOREIGN KEY (iddetalle_presentacion)
REFERENCES detalles_presentacion(iddetalle_presentacion)
ON DELETE CASCADE;

ALTER TABLE detalles_presentacion ADD COLUMN estadoCordinacionTecnica tinyint null default 0;
ALTER TABLE detalles_presentacion ADD COLUMN estadoCordinacionPublicidad tinyint null default 0;
