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
	estado 		TINYINT NOT NULL DEFAULT 1, -- 1=activo, 2=baja/inactivo/suspendido/baneado/inhabilitado
	create_at	  DATETIME			  NOT NULL DEFAULT NOW(),
    update_at	  DATETIME			  NULL,
    CONSTRAINT fk_idpersona FOREIGN KEY (idpersona) REFERENCES personas(idpersona),
    CONSTRAINT fk_idnivelacceso FOREIGN KEY(idnivelacceso) REFERENCES nivelaccesos(idnivelacceso),
    CONSTRAINT uk_nom_usuario UNIQUE(nom_usuario),
    constraint ck_estado_usuario check(estado IN (1,2))
)ENGINE=INNODB;

CREATE TABLE tarifario (
	idtarifario int auto_increment primary key,
    idusuario		int not null,
    idprovincia	int not null,
	precio			decimal(8,2) not null,
    constraint fk_idartista_tar foreign key (idusuario) references usuarios (idusuario),
    constraint fk_provincia_tarifario_art foreign key (idprovincia) references provincias (idprovincia)
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
    tipodoc		int not null, -- 1: dni, 2: ruc
    iddistrito	int null,
    ndocumento	CHAR(20)	null,
    razonsocial	varchar(130)  null,
    representantelegal varchar(130) null,
	telefono    char(15)	null,
	correo		varchar(130) null,
    direccion	varchar(130) null,
    constraint fk_iddistrito_cli foreign key (iddistrito) references distritos (iddistrito),
    constraint    uk_telefono         UNIQUE(telefono),
    constraint 	chk_telefono		CHECK(telefono LIKE '9%'),
    constraint 	uk_numdocumento_cli	unique(ndocumento),
    constraint chk_tipodoc		check(tipodoc IN (1,2))
)engine=innodb;

create table detalles_presentacion (
	iddetalle_presentacion	int auto_increment primary key,
    idusuario			int not null,
    idcliente			int not null,
    iddistrito			int not null,
    ncotizacion			CHAR(9) null,
    fecha_presentacion	date not null,
    horainicio	time not null,
    horafinal 	time not null,
    establecimiento	varchar(80) not null,
    referencia 		varchar(200) not null,
    tipo_evento		int not null, -- 1= publico, 2= privado
    modalidad		int	not null, -- 1= convenio, 2= contrato
	validez			int		null,
    igv				tinyint	not null,
    reserva			tinyint null default 0,
    pagado50		tinyint null default 0,
    estado			tinyint null default 1, -- 1: activo, 2:vencido
    created_at		date null default now(),
    constraint fk_idusuario_dp foreign key (idusuario) references usuarios (idusuario),
    constraint fk_idcliente_dp foreign key (idcliente) references clientes (idcliente),
    constraint fk_iddistrito_dp foreign key (iddistrito) references distritos (iddistrito),
    constraint    chk_detalle_p          CHECK(modalidad IN(1, 2)),
    constraint ck_estado_dp				check(estado IN (1,2)),
    constraint ck_tevento_dp				check(tipo_evento IN (1,2)),
    constraint	uk_ncotizacion 			UNIQUE(ncotizacion),
    constraint uk_idp 					UNIQUE(iddetalle_presentacion)
)engine=innodb;

create table convenios (
	idconvenio	int auto_increment primary key,
    iddetalle_presentacion int not null,
    abono_garantia	decimal(8,2) null,
    abono_publicidad decimal(8,2) null,
	propuesta_cliente text not null,
    acuerdo			varchar(130) not null,
    estado			int null default 1, -- 1 = pendiente, 2 = aprobada, 3 = no aprobado
    created_at		datetime null default now(),
    updated_at		datetime null ,
    constraint fk_dp_cv foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion),
    constraint ck_estado check(estado IN(1,2,3))
) engine = innodb;

create table contratos (
	idcontrato	int auto_increment primary key,
    iddetalle_presentacion	int not null,
    estado				int null default 1, -- 1 = pendiente de pago (pago 15%), 2- pagado, 3- caducado
    created_at			datetime	null default now(),
	updated_at		datetime null ,
    constraint fk_dp_cs foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion),
    constraint ck_estado	check(estado IN (1,2,3))
) engine = innodb;

create table pagos_contrato (
	idpagocontrato		int auto_increment primary key,
    idcontrato	int not null,
    monto		decimal(8,2) not null,
    tipo_pago	tinyint	not null, -- 1: transferencia, 2: contado
    noperacion	varchar(20) null,
    fecha_pago	date	not null ,
    hora_pago	time 	not null,
    estado	 	int			not null, -- 1: pendiente (25%), 2: adelanto (no colocar), 3: aprobado (50%)
    constraint fk_idcontrato	foreign key (idcontrato) references contratos (idcontrato),
    constraint ck_tipopago_pc	check (tipo_pago IN (1,2)),
    constraint ck_estado_pc	check (estado IN (1, 3))
) engine = innodb;

create table reservas (
	idreserva		int auto_increment primary key,
    idpagocontrato	int not null,
    vigencia		int not null,
    fechacreada		date not null,
    constraint fk_idpagocontrato_res foreign key (idpagocontrato) references pagos_contrato (idpagocontrato)
) engine = innodb;

