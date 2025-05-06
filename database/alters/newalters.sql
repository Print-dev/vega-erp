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
