DROP DATABASE IF EXISTS vega_producciones_erp;
CREATE DATABASE vega_producciones_erp;
USE vega_producciones_erp;

CREATE TABLE nacionalidades (
    idnacionalidad INT AUTO_INCREMENT PRIMARY KEY,
    nacionalidad VARCHAR(100) NOT NULL
);

CREATE TABLE departamentos (
    iddepartamento INT AUTO_INCREMENT PRIMARY KEY,
    idnacionalidad INT not null,
    departamento VARCHAR(100) NOT NULL,
    constraint fk_idnacionalidad FOREIGN KEY (idnacionalidad) references nacionalidades (idnacionalidad)
);

CREATE TABLE provincias
(
	idprovincia		INT AUTO_INCREMENT PRIMARY KEY,
	iddepartamento 	INT NOT NULL,
    provincia		VARCHAR(80) NOT NULL,
    CONSTRAINT fk_iddepartamento FOREIGN KEY(iddepartamento) REFERENCES departamentos (iddepartamento)
)ENGINE=INNODB;

CREATE TABLE distritos
(
	iddistrito		INT AUTO_INCREMENT PRIMARY KEY,
    idprovincia		INT NOT NULL,
    distrito		VARCHAR(80) NOT NULL,
    CONSTRAINT fk_idprovincia FOREIGN KEY(idprovincia) REFERENCES provincias(idprovincia)
)ENGINE=INNODB;

CREATE TABLE personas
(
	idpersona     int auto_increment  primary key,
	num_doc       varchar(20)         not null,
	apellidos     varchar(100)        not null,
	nombres	      varchar(100)        not null,
	genero        char(1)             not null,
    direccion	  VARCHAR(150)	  	  NULL,
	telefono      char(15)		      null,
    telefono2	  char(15)			  null,
	correo        char(150)		      null,
    iddistrito	  int				  null,
    create_at	  DATETIME			  NOT null DEFAULT NOW(),
    update_at	  DATETIME			  NULL, 
	constraint    uk_telefono         UNIQUE(telefono),
	constraint    uk_num_doc          UNIQUE(num_doc),
	constraint    chk_genero          CHECK(genero IN('M', 'F')),
    CONSTRAINT 	  uk_correo			  UNIQUE(correo),
    constraint	  fk_iddistrito 	  foreign key (iddistrito) references distritos (iddistrito)
)ENGINE=INNODB;

CREATE TABLE nivelaccesos
(
	idnivelacceso INT AUTO_INCREMENT PRIMARY KEY,
    nivelacceso   VARCHAR(30) NOT NULL,
	create_at	  DATETIME			  NOT NULL DEFAULT NOW(),
    update_at	  DATETIME			  NULL
)ENGINE=INNODB;

CREATE TABLE usuarios
(
	idusuario	INT AUTO_INCREMENT PRIMARY KEY,
    idnivelacceso INT NOT NULL,
    idpersona	INT NOT NULL,
    nom_usuario VARCHAR(30) NOT NULL,
    claveacceso VARBINARY(255) not null, 
	estado 		TINYINT NOT NULL DEFAULT 1, -- 1=activo, 0=baja/inactivo/suspendido/baneado, 2=no asignado
	create_at	  DATETIME			  NOT NULL DEFAULT NOW(),
    update_at	  DATETIME			  NULL,
    CONSTRAINT fk_idpersona FOREIGN KEY (idpersona) REFERENCES personas(idpersona),
    CONSTRAINT fk_idnivelacceso FOREIGN KEY(idnivelacceso) REFERENCES nivelaccesos(idnivelacceso),
    CONSTRAINT uk_nom_usuario UNIQUE(nom_usuario)
)ENGINE=INNODB;

CREATE TABLE artistas (
	idartista 	INT auto_increment primary key,
    idpersona	int not null,
    biografia	varchar(300) null,
    web			varchar(120) null,
    facebook	varchar(120) null,
    youtube		varchar(120) null,
    tiktok		varchar(120) null,
    constraint fk_idpersona_art foreign key (idpersona) references personas (idpersona)
)ENGINE = INNODB;

CREATE TABLE tarifario (
	idtarifario int auto_increment primary key,
    idartista		int not null,
    iddepartamento	int not null,
	precio			decimal(7,2) not null,
    constraint fk_idartista_tar foreign key (idartista) references artistas (idartista),
    constraint fk_iddepartamento_tarifario_tar foreign key (iddepartamento) references departamentos (iddepartamento)
) ENGINE = INNODB;

CREATE TABLE permisos (
    idpermiso INT AUTO_INCREMENT PRIMARY KEY,
    idnivelacceso INT NOT NULL,
    modulo VARCHAR(50) NOT NULL,
    ruta VARCHAR(100) NOT NULL,
    texto VARCHAR(100) NULL,
    visibilidad BOOLEAN NOT NULL,
    icono VARCHAR(100) NULL,
    constraint fk_idnivelacceso_p FOREIGN KEY (idnivelacceso) REFERENCES nivelaccesos(idnivelacceso),
    constraint uk_idnivelacceso_p UNIQUE(idnivelacceso, ruta)
) ENGINE=INNODB;

create table atencion_cliente (
	idatencion_cliente	int auto_increment primary key,
    idusuario	int			not null, -- id artista
    iddistrito	int			not null,
    ndocumento	varchar(20) not null,
    razonsocial	varchar(120) not null,
    tipo		char(1) not null,
    telefono	char(15) not null,
    fecha_evento	date not null,
    hora_presentacion	time not null,
    tiempo_presentacion int  not null,
    establecimiento	varchar(80) not null,
    tipo_evento		char(1) not null,
    igv				boolean	not null,
    correo			varchar(130) not null,
    direccion		varchar(130) not null,
    tipo_pago		char(1) not null,
    validez			int		null,
    constraint fk_idartista_ac	foreign key (idusuario) references usuarios (idusuario),
    constraint fk_iddistrito_ac foreign key (iddistrito) references distritos (iddistrito)
) engine = innodb;

create table convenios (
	idconvenio	int auto_increment primary key,
    idatencion_cliente int not null,
    abono_garantia	double null,
    abono_publicidad double null,
	propuesta_cliente text not null,
    estado			int null default 1, -- 1 = aprobada, 2 = no aprobado
    constraint fk_idatencion_cliente foreign key (idatencion_cliente) references atencion_cliente (idatencion_cliente)
) engine = innodb;

create table contratos (
	idcontrato	int auto_increment primary key,
    idatencion_cliente	int not null,
    monto_pagado		double not null,
    estado				int not null default 1, -- 1 = pendiente de pago (pago 15%), 2- pagado, 3- caducado
    constraint fk_idatencion_cliente_contratos foreign key (idatencion_cliente) references atencion_cliente (idatencion_cliente)
) engine = innodb;