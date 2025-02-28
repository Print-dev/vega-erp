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

CREATE TABLE tarifario (
	idtarifario int auto_increment primary key,
    idusuario		int not null,
    iddepartamento	int not null,
	precio			decimal(7,2) not null,
    constraint fk_idartista_tar foreign key (idusuario) references usuarios (idusuario),
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

create table clientes (
	idcliente	int auto_increment primary key,
    iddistrito	int null,
    ndocumento	CHAR(20)	null,
    razonsocial	varchar(130)  null,
	telefono    char(15)	null,
	correo		varchar(130) null,
    direccion	varchar(130) null,
    constraint fk_iddistrito_cli foreign key (iddistrito) references distritos (iddistrito),
    constraint    uk_telefono         UNIQUE(telefono),
    constraint 	chk_telefono		CHECK(telefono LIKE '9%'),
    constraint 	chk_numdocumento	check(ndocumento)
)engine=innodb;

create table detalles_presentacion (
	iddetalle_presentacion	int auto_increment primary key,
    idusuario			int not null,
    idcliente			int not null,
    iddistrito			int not null,
    ncotizacion			CHAR(9) not null,
    fecha_presentacion	date not null,
    hora_presentacion	time not null,
    tiempo_presentacion int  not null,
    establecimiento	varchar(80) not null,
    tipo_evento		int not null,
    modalidad		int	not null,
	validez			int		null,
    igv				tinyint	not null,
    tipo_pago		int not null,
    constraint fk_idusuario_dp foreign key (idusuario) references usuarios (idusuario),
    constraint fk_idcliente_dp foreign key (idcliente) references clientes (idcliente),
    constraint fk_iddistrito_dp foreign key (iddistrito) references distritos (iddistrito),
    constraint    chk_detalle_p          CHECK(modalidad IN(1, 2)),
    constraint    chk_detalle_p_tp          CHECK(tipo_pago IN(1, 2)),
    constraint	uk_ncotizacion 			UNIQUE(ncotizacion)
)engine=innodb;

create table convenios (
	idconvenio	int auto_increment primary key,
    iddetalle_presentacion int not null,
    abono_garantia	double null,
    abono_publicidad double null,
	propuesta_cliente text not null,
    estado			int null default 1, -- 1 = pendiente, 2 = aprobada, 3 = no aprobado
    created_at		datetime null default now(),
    updated_at		datetime null ,
    constraint fk_dp_cv foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion)
) engine = innodb;

create table contratos (
	idcontrato	int auto_increment primary key,
    iddetalle_presentacion	int not null,
    monto_pagado		double not null,
    estado				int not null default 1, -- 1 = pendiente de pago (pago 15%), 2- pagado, 3- caducado
    created_at			datetime	null default now(),
	updated_at		datetime null ,
    constraint fk_dp_cs foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion)
) engine = innodb;