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
