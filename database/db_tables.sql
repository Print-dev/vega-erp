-- DROP DATABASE IF EXISTS vega_producciones_erp;
-- CREATE DATABASE vega_producciones_erp;
-- USE vega_producciones_erp;
select * from nivelaccesos;
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

CREATE TABLE empresa (
	idempresa		INT auto_increment PRIMARY KEY,
    ruc				char(11)  null,
    logoempresa		varchar(40) null,
    razonsocial		varchar(120)  null,
	nombrecomercial	varchar(120) null, -- este nombre aparecera en la sidebar como nombre de la aplicacion
    nombreapp 		varchar(120) null,
    direccion		varchar(120)  null,
    web				varchar(120)  null
    -- usuariosol		char(8) null,
    -- clavesol		char(12) null,
    -- certificado		text null,
    -- correo			varchar(120) null,
    -- contrasenagmailapp varchar(120) null
) ENGINE = INNODB;

-- ALTER TABLE empresa
-- MODIFY COLUMN logoempresa VARCHAR(80) NULL;
-- ALTER TABLE empresa ADD COLUMN correo			varchar(120) null;
-- ALTER TABLE empresa ADD COLUMN contrasenagmailapp			varchar(120) null;
-- ALTER TABLE empresa ADD COLUMN ncuenta	varchar(30) null;
-- ALTER TABLE empresa ADD COLUMN ncci	varchar(30) null;
-- ALTER TABLE empresa ADD COLUMN banco varchar(30) null;
-- ALTER TABLE empresa ADD COLUMN moneda varchar(30) null;

-- ALTER TABLE empresa
 -- DROP COLUMN usuariosol,
 -- DROP COLUMN clavesol,
  -- DROP COLUMN certificado;


CREATE TABLE sucursales (
	idsucursal		int auto_increment primary key,
    idempresa		int not null,
    iddistrito		int not null,
    idresponsable	int null, -- idusuario
	nombre			varchar(120) null,
	ruc				char(11) not null,
    telefono		char(20)  null,
    direccion		varchar(120)  not null,
    email			varchar(120)  null,
    constraint fk_iddistrito_sucu foreign key (iddistrito) references distritos (iddistrito),
    constraint fk_idempresa_sucu foreign key (idempresa) references empresa (idempresa)
)  ENGINE=INNODB;

CREATE TABLE personas
(
	idpersona     int auto_increment  primary key,
	num_doc       varchar(20)         null,
	apellidos     varchar(100)        null,
	nombres	      varchar(100)        null,
	genero        char(1)             null,
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
select*from usuarios;
CREATE TABLE nivelaccesos
(
	idnivelacceso INT AUTO_INCREMENT PRIMARY KEY,
    nivelacceso   VARCHAR(30) NOT NULL,
	create_at	  DATETIME			  NOT NULL DEFAULT NOW(),
    update_at	  DATETIME			  NULL
)ENGINE=INNODB;


CREATE TABLE usuarios (
    idusuario INT AUTO_INCREMENT PRIMARY KEY,
    idsucursal INT NOT NULL,
    idnivelacceso INT NOT NULL,
    idpersona INT NOT NULL,
    nom_usuario VARCHAR(30) NOT NULL,
    claveacceso VARBINARY(255) NOT NULL,
    color CHAR(7) NULL,
    porcentaje INT NULL,
    marcaagua VARCHAR(40) NULL,
    firma VARCHAR(40) NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    create_at DATETIME NOT NULL DEFAULT NOW(),
    update_at DATETIME NULL,
    CONSTRAINT fk_idpersona FOREIGN KEY (idpersona)
        REFERENCES personas (idpersona),
    CONSTRAINT fk_idnivelacceso FOREIGN KEY (idnivelacceso)
        REFERENCES nivelaccesos (idnivelacceso),
    CONSTRAINT uk_nom_usuario UNIQUE (nom_usuario),
    CONSTRAINT ck_estado_usuario CHECK (estado IN (1 , 2)),
    CONSTRAINT fk_idsucursal FOREIGN KEY (idsucursal)
        REFERENCES sucursales (idsucursal)
)  ENGINE=INNODB;

CREATE TABLE proveedores (
    idproveedor INT AUTO_INCREMENT PRIMARY KEY,
    empresa	VARCHAR(120) NULL,
    nombre VARCHAR(120) NULL,
    contacto INT NULL,
    correo VARCHAR(120) NULL,
    dni char(15) NULL,
    banco VARCHAR(120) NULL,
    ctabancaria INT NULL,
    servicio VARCHAR(120) NULL,
    nproveedor VARCHAR(40) NULL    
)  ENGINE=INNODB;
SELECT * FROM proveedores order by idproveedor DESC;
-- ALTER TABLE usuarios
-- MODIFY COLUMN marcaagua VARCHAR(120) NULL,
-- MODIFY COLUMN firma VARCHAR(120) NULL;
-- ALTER TABLE usuarios ADD COLUMN idsucursal int not null;

CREATE TABLE conceptos (
    idconcepto INT AUTO_INCREMENT PRIMARY KEY,
    concepto	VARCHAR(120) NULL 
)  ENGINE=INNODB;
select * from conceptos;


CREATE TABLE subtipos (
    idsubtipo INT AUTO_INCREMENT PRIMARY KEY,
    idconcepto INT NOT NULL,
    subtipo	VARCHAR(120) NULL,
    constraint fk_idsubtipo foreign key (idconcepto) references conceptos(idconcepto)
)  ENGINE=INNODB;
select* from subtipos;
CREATE TABLE tarifario (
	idtarifario int auto_increment primary key,
    idusuario		int not null,
    idprovincia	int not null,
	precio			decimal(10,2) not null,
    -- tipo_evento	int	not null,
    constraint fk_idartista_tar foreign key (idusuario) references usuarios (idusuario),
    constraint fk_provincia_tarifario_art foreign key (idprovincia) references provincias (idprovincia)
) ENGINE = INNODB;
-- ALTER TABLE tarifario ADD COLUMN tipo_evento INT NOT NULL;
select * from tarifario;
-- ALTER TABLE tarifario
	-- ADD COLUMN idnacionalidad INT NULL,
	-- ADD CONSTRAINT fk_idnacionalidad_tarifario FOREIGN KEY (idnacionalidad) REFERENCES nacionalidades(idnacionalidad);
-- ALTER TABLE tarifario
 -- MODIFY COLUMN idprovincia INT NULL;
SELECT * FROM tarifario;
-- SELECT * FROM tarifario WHERE idprovincia = 1 and tipo_evento = 2;
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
    tipodoc		int null, -- 1: dni, 2: ruc
    iddistrito	int null,
    ndocumento	CHAR(20)	null,
    razonsocial	varchar(130)  null,
    representantelegal varchar(130) null,
	telefono    char(15)	null,
	correo		varchar(130) null,
    direccion	varchar(130) null,
    constraint fk_iddistrito_cli foreign key (iddistrito) references distritos (iddistrito),
    constraint    uk_telefono         UNIQUE(telefono),
    constraint 	uk_numdocumento_cli	unique(ndocumento),
    constraint chk_tipodoc		check(tipodoc IN (1,2))
)engine=innodb;
-- ALTER TABLE detalles_presentacion
-- ADD COLUMN modotransporte INT NULL AFTER modalidad;
ALTER TABLE detalles_presentacion ADD COLUMN estadoCordinacionTecnica tinyint null default 0;
ALTER TABLE detalles_presentacion ADD COLUMN estadoCordinacionPublicidad tinyint null default 0;
SELECT *
FROM detalles_presentacion
GROUP BY establecimiento;

CREATE table detalles_presentacion (
	iddetalle_presentacion	int auto_increment primary key,
    idusuario			int not null,
    idcliente			int not null,
    iddistrito			int null,
    ncotizacion			CHAR(9) null,
    fecha_presentacion	date not null,
    horainicio	time null,
    horafinal 	time null,
    establecimiento	varchar(80) null,
    referencia 		varchar(200) null,
    acuerdo			TEXT null,
    tipo_evento		int null, -- 1= publico, 2= privado
    modalidad		int null, -- 1= convenio, 2= contrato	
	modotransporte	int null,
	validez			int		null,
    igv				tinyint	not null,
    reserva			tinyint null default 0,
    pagado50		tinyint null default 0,
    tienecaja		tinyint null default 0,
    estado			tinyint null default 1, -- 1: activo, 2:vencido, 3: cancelado
    created_at		date null default now(),
    constraint fk_idusuario_dp foreign key (idusuario) references usuarios (idusuario) ON DELETE CASCADE, -- artista
    constraint fk_idcliente_dp foreign key (idcliente) references clientes (idcliente) ON DELETE CASCADE,
    constraint fk_iddistrito_dp foreign key (iddistrito) references distritos (iddistrito) ON DELETE CASCADE,
    constraint    chk_detalle_p          CHECK(modalidad IN(1, 2)),
    constraint ck_estado_dp				check(estado IN (1,2,3)),
    constraint ck_tevento_dp				check(tipo_evento IN (1,2)),
    constraint	uk_ncotizacion 			UNIQUE(ncotizacion),
    constraint uk_idp 					UNIQUE(iddetalle_presentacion)
)engine=innodb;
select * from detalles_presentacion;
UPDATE detalles_presentacion
SET esExtranjero = 0,
    idnacionalidad = 31;
-- ALTER TABLE detalles_presentacion ADD COLUMN esExtranjero TINYINT AFTER created_at;
-- ALTER TABLE detalles_presentacion
-- ADD COLUMN idnacionalidad INT NULL,
-- ADD CONSTRAINT fk_idnacionalidad_dp FOREIGN KEY (idnacionalidad) REFERENCES nacionalidades(idnacionalidad);


-- select  * from detalles_presentacion;
CREATE TABLE responsables_boleteria_contratoreservasreservas (
	idresponsablecontrato	int auto_increment primary key,
    iddetalle_presentacion 	int not null,
    idusuarioBoleteria		int null,
    idusuarioContrato		int null,
    constraint fk_idusuario_boleteria foreign key (idusuarioBoleteria) references usuarios (idusuario),
    constraint fk_idusuario_contrato foreign key (idusuarioContrato) references usuarios (idusuario)
) ENGINE = INNODB;

select  * from colaboradores;

-- ESTA TABLA SOLO SERA PARA EVENTOS DE TIPO CONVENIO
CREATE TABLE precios_entrada_evento ( 
	idprecioentradaevento	int auto_increment primary key,
    iddetalle_presentacion 	int not null,
    preciogeneral		decimal(10,2) null,
    preciovip		decimal(10,2) null,
    constraint fk_iddp_entrada_convenio foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion)
) ENGINE = INNODB;

ALTER TABLE precios_entrada_evento
  DROP COLUMN preciogeneral,
  DROP COLUMN preciovip,
  ADD COLUMN entradas TEXT NULL;

CREATE TABLE reportes_artista_evento (
	idreporte	int auto_increment primary key,
    iddetalle_presentacion int not null,
    tipo		int	not null, -- 1: salida, 2: retorno 
    fecha		date null default now(),
    hora		time null default now(),
	constraint fk_iddp_report_art_evento foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion)
) ENGINE = innodb;


CREATE TABLE agenda_asignaciones ( -- tabla que asigna la agenda a un filmmaker
    idasignacion INT AUTO_INCREMENT PRIMARY KEY,
    iddetalle_presentacion INT NOT NULL,
    idusuario INT NOT NULL,
    FOREIGN KEY (iddetalle_presentacion) REFERENCES detalles_presentacion(iddetalle_presentacion) ON DELETE CASCADE,
    FOREIGN KEY (idusuario) REFERENCES usuarios(idusuario) ON DELETE CASCADE
);
create table convenios (
	idconvenio	int auto_increment primary key,
    iddetalle_presentacion int not null,
    abono_garantia	decimal(10,2) null,
    abono_publicidad decimal(10,2) null,
	porcentaje_vega	 int not null,
    porcentaje_promotor int not null,
	propuesta_cliente text not null,
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
-- select * from pagos_contrato (idcontrato, monto, tipopago, noperacion) values ();
-- select * from contratos;
create table pagos_contrato (
	idpagocontrato		int auto_increment primary key,
    idcontrato	int not null,
    monto		decimal(10,2) not null,
    tipo_pago	tinyint	not null, -- 1: transferencia, 2: contado
    noperacion	varchar(20) null,
    fecha_pago	date	not null ,
    hora_pago	time 	not null,
    estado	 	int			not null, -- 1: pendiente (25%), 2: adelanto (no colocar), 3: aprobado (50%)
    constraint fk_idcontrato	foreign key (idcontrato) references contratos (idcontrato),
    constraint ck_tipopago_pc	check (tipo_pago IN (1,2)),
    constraint ck_estado_pc	check (estado IN (1, 3))
) engine = innodb;
select * from pagos_contrato;
-- cambiar este camp
create table reservas (
	idreserva		int auto_increment primary key,
    idpagocontrato	int not null,
    vigencia		int not null,
    fechacreada		date not null,
    constraint fk_idpagocontrato_res foreign key (idpagocontrato) references pagos_contrato (idpagocontrato)
) engine = innodb;
select * from reservas;
CREATE TABLE viaticos (
	idviatico		int auto_increment primary key,
    iddetalle_presentacion int not null,
    idusuario		int		not null,
    pasaje			decimal(7,2) null, -- modificado 
    hospedaje 		decimal(7,2) null, -- recien agregado
    desayuno		tinyint null, -- recien agregado
    almuerzo		tinyint null,
    cena			tinyint	null,
    constraint fk_iddp_viatico foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion),
    constraint fk_idusuario_v foreign key (idusuario) references usuarios (idusuario)
) engine = innodb;

-- CONTABILIDAD 
CREATE TABLE montoCajaChica (
    idmonto INT AUTO_INCREMENT PRIMARY KEY,
    monto DECIMAL(10,2) NOT NULL  -- Monto total disponible para caja chica
) ENGINE = InnoDB;

CREATE TABLE cajachica (
	idcajachica	int auto_increment primary key,
    iddetalle_presentacion int null,
    idmonto		int not null,
    ccinicial 	double (10,2) not null,
    incremento	double (10,2) not null,
    decremento 	double (10,2) not null,
    ccfinal		double (10,2) not null,
    estado 		tinyint null default 1, -- 1- abierta, 2- cerrada
    fecha_cierre datetime null,
    fecha_apertura	datetime default now(),
    constraint ck_estado_cajch	check (estado IN (1,2)),
    constraint fk_iddp_cajachicaa foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion),
    constraint fk_idmonto_caja foreign key (idmonto) references montoCajaChica (idmonto)
) engine = innodb;
-- ALTER TABLE cajachica DROP COLUMN abiertopor;
-- ALTER TABLE cajachica DROP FOREIGN KEY fk_idusuario_abiertopor;
-- ALTER TABLE cajachica ADD COLUMN creadopor INT NULL;
-- ALTER TABLE cajachica ADD CONSTRAINT fk_idusuario_abierto foreign key (creadopor) references usuarios (idusuario);
-- select * from cajachica;
CREATE TABLE gastos_cajachica (
	idgasto		int auto_increment primary key,
    idcajachica		int not null,
    fecha_gasto	datetime default now(),
    concepto	varchar(250) not null,
    monto		double (10,2) not null,
    constraint fk_idcaja_gastos foreign key (idcajachica) references cajachica (idcajachica) ON DELETE CASCADE
) engine = innodb;

CREATE TABLE notificaciones_viatico (
    idnotificacion_viatico INT AUTO_INCREMENT PRIMARY KEY,
    idviatico int not null,
    idusuario INT NOT NULL,
    mensaje varchar(200) NOT NULL,
    fecha datetime DEFAULT now(),
    constraint fk_idviatico_nt foreign key (idviatico) references viaticos (idviatico),
    constraint fk_filmmamker_nt foreign key (idusuario) references usuarios (idusuario)
) engine = innodb;

CREATE TABLE notificaciones (
    idnotificacion INT AUTO_INCREMENT PRIMARY KEY,
    idusuariodest INT NOT NULL,-- Usuario que recibe la notificación
    idusuariorem INT NOT NULL, -- usuario que envia la notificacion
    tipo INT NOT NULL, -- 1- viatico, 2- DETLLAE PRESENTACION, 3: asignacion de filmmaker, 4: propuestas, 5: precios de entrada de evento, 6: Reporte de salida y entrada de artista
    idreferencia INT NULL, -- ID del registro relacionado
    mensaje VARCHAR(200) NOT NULL,
    estado INT NULL DEFAULT 1, 
    fecha DATETIME DEFAULT NOW(),
    constraint fk_usuario_notif foreign key (idusuariodest) references usuarios(idusuario),
    constraint fk_usuario_rem foreign key (idusuariorem) references usuarios(idusuario),
    constraint chk_estado_not check(estado IN (1,2))
);
select * from notificaciones;
select * from usuarios;
select * from detalles_presentacion where iddetalle_presentacion = 138;
CREATE TABLE reparticion_ingresos (
	idreparticion	int auto_increment primary key,
    iddetalle_presentacion int not null,    
    estado			tinyint null default 1, -- 1: abierto, 2: cerrado 
	constraint fk_rep_ing foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion),
    constraint fk_estado_ing check (estado IN (1, 2))
) engine = innodb;


CREATE TABLE ingresos_evento (
	idingreso	int auto_increment primary key,
    idreparticion int not null,
    descripcion	varchar(80) not null,
    monto		decimal(10,2) not null,
    tipopago	tinyint	not null, -- 1: transferencia, 2: contado
    noperacion	varchar(15) null,	
    constraint fk_idreparticion_ing foreign key (idreparticion) references reparticion_ingresos (idreparticion)
) engine = innodb;
-- ALTER TABLE ingresos_evento ADD COLUMN     medio		varchar(30) null;

CREATE TABLE egresos_evento (
	idegreso	int auto_increment primary key,
    idreparticion int not null,
    descripcion	varchar(80) not null,
    monto		decimal(10,2) not null,
    tipopago	tinyint	not null, -- 1: transferencia, 2: contado
    noperacion	varchar(15) null,	
    constraint fk_idreparticion_egre foreign key (idreparticion) references reparticion_ingresos (idreparticion)
) engine = innodb;

CREATE TABLE agenda_edicion ( -- tabla que envuelve la tabla agenda editores
    idagendaedicion INT AUTO_INCREMENT PRIMARY KEY,
    iddetalle_presentacion INT NOT NULL,  -- Relación con la agenda del evento
    constraint fk_iddp_ag_edicion foreign key (iddetalle_presentacion) references detalles_presentacion (iddetalle_presentacion)
);
select * from detalles_presentacion;
select * from agenda_edicion;

CREATE TABLE tipotarea (
	idtipotarea	int auto_increment primary key,
    tipotarea varchar(30) not null
) engine = innodb;
 
-- ALTER TABLE agenda_editores ADD COLUMN altoketicket INT NULL DEFAULT 1 AFTER estado;
CREATE TABLE agenda_editores (
	idagendaeditor	int auto_increment primary key,
    idagendaedicion int not null,
    idusuario		int not null,
    idtipotarea 		int not null, -- 1: flayer, 2: saludos, 3: reels, 4: fotos, 5: contenido
    estado			int null default 1, -- 1: pendiente, 2- completado, 3: atrasado, 4: completado con atraso
    altoketicket	int null default 1, -- 1: pendiente, 2: completado
	fecha_asignacion datetime null default now(),
    fecha_entrega 	date not null,
    hora_entrega	time not null,
    constraint fk_idagendaedicion foreign key (idagendaedicion) references agenda_edicion (idagendaedicion),
    constraint fk_idusuario_ag_edit foreign key (idusuario) references usuarios (idusuario),
    constraint fk_idtipotarea_agen foreign key (idtipotarea) references tipotarea (idtipotarea)
) engine = innodb;

CREATE TABLE subidas_agenda_edicion (
	idsubida	int  auto_increment primary key,
    idagendaeditor int not null,
    url 			text not null,
	observaciones	varchar(250) null,
    constraint fk_subidas_agenda_edi foreign key (idagendaeditor) references agenda_editores (idagendaeditor)
) engine=innodb;

-- AGREGADO EL 26-06-2025 - 16:33
CREATE TABLE agenda_commanager (
	idagendacommanager	int auto_increment primary key,
    idagendaeditor 		int not null,
    idusuarioCmanager 	int not null,
    portalpublicar 		varchar(120) null,
    fechapublicacion	datetime null,
    copy				text null,
    estado				SMALLINT null default 1, -- 1: no publicado, 2: publicado
    constraint fk_idagendaeditor_cm foreign key (idagendaeditor) references agenda_editores (idagendaeditor),
    constraint fk_idusuarioCmanaget foreign key (idusuarioCmanager) references usuarios (idusuario)
) engine = innodb;

--  -------------------------------------------- NUEVAS TABLAS AGREGASDAS -----------------------------------------
-- AGREGADO EL 26-06-2025 - 16:33
CREATE TABLE tareas_diarias (
	idtareadiaria	int auto_increment primary key,
	tarea			varchar(120) not null
) ENGINE = INNODB;

-- AGREGADO EL 26-06-2025 - 16:33
CREATE TABLE tareas_diaria_asignacion (
	idtaradiariaasig int auto_increment primary key,
    idusuario 		int not null,
	idtareadiaria	int not null,
    fecha_entrega	date not null,
    hora_entrega 	time not null,
    estado			SMALLINT default 1, -- 1: pendiente, 2: atrasado, 3: completado, 4: completado con atraso
    constraint fk_idusuario	foreign key (idusuario) references usuarios (idusuario),
    constraint fk_idtareadiaria_asig foreign key (idtareadiaria) references tareas_diarias (idtareadiaria)
) engine = innodb;
select * from tareas_diaria_asignacion;
-- --------------------------------------------- TABLAS FACTURA Y BOLETA -----------------------------------------------
-- ALTER TABLE comprobantes
-- ADD COLUMN iddetallepresentacion INT not NULL AFTER idcomprobante;
-- ALTER TABLE comprobantes ADD CONSTRAINT fk_iddp_compr foreign key (iddetallepresentacion) references detalles_presentacion (iddetalle_presentacion)
-- ALTER TABLE comprobantes ADD COLUMN noperacion	varchar(15) null;
CREATE TABLE comprobantes (
	idcomprobante		INT auto_increment PRIMARY KEY,
    iddetallepresentacion	int not null,
    idsucursal		int not null,
	idcliente		int not null,
    idtipodoc		char(2) not null, -- esto en realidad no es un id 
	tipopago		INT not null,
	fechaemision	DATE null default now(),
    horaemision     time null default now(),
    nserie			char(4) not null,
    correlativo		char(8) not null,
    tipomoneda		varchar(40) not null,
    monto			decimal(10,2) not null,
    tieneigv 		tinyint not null,
    noperacion	varchar(15) null,	
	constraint fk_idcliente_comp	foreign key (idcliente) references clientes (idcliente) ON DELETE CASCADE,
    constraint fk_idsucursal_comp foreign key (idsucursal) references sucursales (idsucursal) ON DELETE CASCADE,
	constraint fk_iddp_comp foreign key (iddetallepresentacion) references detalles_presentacion (iddetalle_presentacion) ON DELETE CASCADE
) ENGINE = INNODB;
CREATE TABLE items_comprobante (
	iditemcomprobante	int auto_increment primary key,
    idcomprobante	int not null,
    cantidad		int not null,
    descripcion		text not null,
    valorunitario	decimal(10,2) not null,
    valortotal		decimal(10,2) not null,
	constraint fk_items_factura	foreign key (idcomprobante) references comprobantes (idcomprobante)
) ENGINE = INNODB;

CREATE TABLE detalles_comprobante (
	iddetallecomprobante int auto_increment primary key,
    idcomprobante		int not null,
    estado				varchar(10) not null,
    info				varchar(60) not null,
	constraint fk_iddetallefactura	foreign key (idcomprobante) references comprobantes (idcomprobante) ON DELETE CASCADE
) ENGINE = INNODB;

CREATE TABLE cuotas_comprobante (
	idcuotacomprobante	int auto_increment primary key,
    idcomprobante		int		not null,
	fecha				date	not null, -- fecha de vencimiento
	monto				decimal(10,2) not null,
    fechapagado			date null,
    horapagado			time null,
    estado				tinyint null default 0, -- 0:pendiente, 1: pagado, 2: atrasado, 3: pagado con atraso, 4: parcial
    constraint 	fk_idcuotacomprobante	foreign key (idcomprobante) references comprobantes (idcomprobante)
) ENGINE = INNODB;

CREATE TABLE pagos_cuota (
	idpagocuota			int auto_increment primary key,
    idcuotacomprobante 	int		not null,
    fechapagado			date  null default now(),
    horapagado			time null default now(),
	montopagado			decimal(10,2) not null,
    tipo_pago	tinyint	not null, -- 1: transferencia, 2: contado
    noperacion	varchar(20) null,
    constraint 	fk_idcuotacomprobante_pago	foreign key (idcuotacomprobante) references cuotas_comprobante (idcuotacomprobante)
) ENGINE = INNODB;

-- ***************************************************** SECCION RECURSOS HUMANOS ************************************************************************
-- select*from cargos
CREATE TABLE cargos ( -- AREAS DE UN COLABORADOR, EJEMP: sistemas, diseño, marketing, etc.
    idcargo INT AUTO_INCREMENT PRIMARY KEY,
    cargo VARCHAR(100) NOT NULL
);
-- ALTER TABLE personas_colaboradores ADD COLUMN idcargo INT NULL
-- ALTER TABLE nominas DROP CONSTRAINT fk_idcargo_nomina
-- ALTER TABLE personas_colaboradores ADD constraint fk_idcargo_nomina foreign key (idcargo) references cargos(idcargo) ON DELETE CASCADE
 
CREATE TABLE personas_colaboradores (
	idpersonacolaborador int auto_increment primary key,
    nombreapellidos 	varchar(150) null,
    dni					varchar(8) null,
    fnacimiento 		date null,
    estadocivil			SMALLINT null, -- 1: soltero, 2: casado, 3: divorciado, 4: conviviente. 5: viudo
    sexo				CHAR(1) null,
    domicilio			varchar(200) null,
    correo				varchar(200) null,
    nivelestudio		varchar(200) null,
    contactoemergencia	varchar(200) null,
    discapacidad 		varchar(200) null,
    foto				VARCHAR(80) NULL,
	idcargo			int null
) ENGINE = INNODB;	
-- select * from colaboradores
CREATE TABLE colaboradores (
    idcolaborador INT AUTO_INCREMENT PRIMARY KEY,
    idpersonacolaborador INT NOT NULL,
	camisa			varchar(80) null,
    pantalon		varchar(80) null,
    zapatos			varchar(80) null,
    CONSTRAINT fk_idper_col foreign key (idpersonacolaborador) references personas_colaboradores (idpersonacolaborador) ON DELETE CASCADE
) ENGINE = INNODB;
-- select *  from nominas
-- select *  from nominas
CREATE TABLE nominas (
	idnomina int auto_increment primary key,
    idcolaborador INT NULL,
    tipo 	INT null, -- 1: planilla, 2: contrato, 3: locacion
    fechaingreso	DATE NULL,
    ruc				varchar(20) null,
    clavesol		varchar(20) null,
    ncuenta			varchar(20) null,
	constraint fk_idcolaborador_nomina foreign key (idcolaborador) references colaboradores (idcolaborador) ON DELETE CASCADE
) ENGINE = INNODB;


CREATE TABLE salarios (
    idsalario INT AUTO_INCREMENT PRIMARY KEY,
    idcolaborador INT NOT NULL,
    salario	DECIMAL (10,2) NOT NULL,
	periodo INT NOT NULL, -- 1: Semanal. 2: Quincenal. 3: Mensual
    horas	DECIMAL (10,2) NOT NULL,
    costohora DECIMAL(10, 2) NOT NULL,
    fechainicio DATE DEFAULT NOW(),
    fechafin DATE DEFAULT NULL,
    CONSTRAINT fk_idcolaborador_salario FOREIGN KEY (idcolaborador) REFERENCES colaboradores(idcolaborador) ON DELETE CASCADE
) ENGINE = INNODB;

-- ********************************************** MODIFICAR DESDE AQUI ---

CREATE TABLE pagos_trabajadores (
  idpagotrabajadores INT AUTO_INCREMENT PRIMARY KEY,
  idtrabajador INT NOT NULL,
  periodo_inicio DATE NOT NULL,
  periodo_fin DATE NOT NULL,
  fecha_deposito DATE,
  monto_a_pagar DECIMAL(10,2),
  tipo_pago ENUM('QUINCENA', 'MENSUAL') NOT NULL,
  boucher_url TEXT,
  observaciones TEXT,
  FOREIGN KEY (idtrabajador) REFERENCES trabajadores(idtrabajador)
);

CREATE TABLE detalle_pago_artista (
  iddetallepagoartista INT AUTO_INCREMENT PRIMARY KEY,
  idpagotrabajadores INT NOT NULL,
  total_eventos_asistidos INT DEFAULT 0,
  adelantos DECIMAL(10,2) DEFAULT 0.00,
  CONSTRAINT fk_pagoartista FOREIGN KEY (idpagotrabajadores) REFERENCES pagos_trabajadores(idpagotrabajadores) ON DELETE CASCADE
);

CREATE TABLE detalle_pago_empresa (
  iddetallepagoempresa INT AUTO_INCREMENT PRIMARY KEY,
  idpagotrabajadores INT NOT NULL,
  total_dias_laborados INT DEFAULT 0,
  adelantos DECIMAL(10,2) DEFAULT 0.00,
  saldo_a_favor DECIMAL(10,2) DEFAULT 0.00,
  bono_productividad DECIMAL(10,2) DEFAULT 0.00,
  CONSTRAINT fk_pagoempresa FOREIGN KEY (idpagotrabajadores) REFERENCES pagos_trabajadores(idpagotrabajadores) ON DELETE CASCADE
);

CREATE TABLE adelantos_trabajadores (
  idadelanto INT AUTO_INCREMENT PRIMARY KEY,
  idcolaborador INT NOT NULL,
  fecha DATE NOT NULL,
  monto DECIMAL(10,2),
  motivo TEXT,
  CONSTRAINT fk_idcolaborador_adelanto FOREIGN KEY (idcolaborador) REFERENCES colaboradores(idcolaborador)
);

-- ********************************************** GASTOS *********************************************
CREATE TABLE gastosyentradas (
  idgastoentrada INT AUTO_INCREMENT PRIMARY KEY,
  estado 		INT NOT NULL, -- 1: PENDIENTE. 2: PAGADO
  concepto VARCHAR(200) NULL, -- PONER UNA NOTA : MAXIMO SOLO 200 CARACTERES
  fecha_gasto DATE NOT NULL,	
  monto DECIMAL(10,2) NOT NULL,
  iddetallepresentacion INT NULL, -- puede ser NULL si es solo de artista
  idusuario INT NULL, -- puede ser NULL si es solo del evento
  mediopago INT NULL, -- 1: Transferencia, 2: Efectivo
  detalles  VARCHAR(200) NULL, -- opcional
  comprobante_url VARCHAR(200) NULL, -- imagen o archivo
  comprobante_fac_bol VARCHAR(200) NULL, -- imagen o archivo
  CONSTRAINT fk_idusuario_gastoentrada FOREIGN KEY (idusuario) REFERENCES usuarios (idusuario) ON DELETE CASCADE,
  CONSTRAINT fk_iddp_gastoentrada FOREIGN KEY (iddetallepresentacion) REFERENCES detalles_presentacion (iddetalle_presentacion) ON DELETE CASCADE
);
select * from gastosyentradas;
-- *************************** APARTIR DE ABAJO NO CONSIDERAR ***************************************

CREATE TABLE nomina (
	idnomina INT auto_increment PRIMARY KEY,
	idcolaborador INT NULL,
	idresponsable INT NULL,
    salario_usado INT NOT NULL,
    adelanto 	INT NULL,
    fechadeposito DATETIME NULL,
    cuenta		INT NULL,
    quincena 	DECIMAL(10,2) NULL,
    totaleventos int null,
    constraint fk_idnomina foreign key (idcolaborador) references colaboradores (idcolaborador) ON DELETE CASCADE,
    constraint fk_idresponsable_artista foreign key (idusuario) references usuarios (idusuario)
) ENGINE = INNODB;

create TABLE nomina (
    idnomina INT AUTO_INCREMENT PRIMARY KEY,
    idcolaborador INT NOT NULL,
    salario_usado INT NOT NULL,
    periodo INT NOT NULL,
	idarea	INT NOT NULL,
    horas DECIMAL(10,2) NOT NULL,
	tiempo DECIMAL(10,2) NOT NULL,
    rendimiento DECIMAL(10,2) NULL,
    proporcion DECIMAL(10,2) null,
    acumulado DECIMAL(10,2)  null,
    created_at DATETIME DEFAULT NOW(),
    CONSTRAINT fk_idempleado_nomina FOREIGN KEY (idcolaborador) REFERENCES colaboradores(idcolaborador) ON DELETE CASCADE,
    CONSTRAINT fk_idarea_nomina foreign key (idarea) references areas (idarea) ON DELETE CASCADE
)ENGINE = INNODB;

DROP TABLE gastos_nomina (
    idgastonomina INT AUTO_INCREMENT PRIMARY KEY,
    idnomina INT NOT NULL,
    descripcion TEXT,
    monto DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    CONSTRAINT fk_gasto_nomina FOREIGN KEY (idnomina) REFERENCES nomina(idnomina) ON DELETE CASCADE
) ENGINE=INNODB;
select * from gastos_nomina;

CREATE TABLE acumulados_nomina (
	idacumulado_nomina INT auto_increment primary key,
    idnomina INT NOT NULL,
    acumulado DECIMAL(10,2) not null,
    CONSTRAINT fk_idnomina_acumulado foreign key (idnomina) references nominas (idnomina)
) ENGINE = INNODB;

CREATE TABLE gastosentradas ( -- SE PENSARA EN AGREGAR
	idgastoentrada INT auto_increment primary key,
	estadopago INT NULL,
	fgasto DATE NULL,
	fvencimiento DATE NULL,          -- como 'bonificación', 'descuento', 'aporte', etc.
    tipo INT NULL,
    concepto VARCHAR(40) NULL,
    idproveedor INT NULL
) ENGINE = INNODB;

CREATE TABLE gastosentradas (
    idgastoentrada INT AUTO_INCREMENT PRIMARY KEY,
    estadopago INT NULL,
    fgasto DATE NULL,
    fvencimiento DATE NULL,          -- como 'bonificación', 'descuento', 'aporte', etc.
    tipo INT NULL,  -- 1: fijo, 2: variable
    concepto INT NULL,
    subtipo INT NULL,
    idproveedor INT NULL,
    idcolaborador INT NULL,
    gasto DECIMAL(10,2) NULL,
    cunitario DECIMAL(10,2) NULL,
    pagado DECIMAL(10,2) NULL, -- pago anticipado
    idproducto INT NULL,
    cantidad INT NULL,
    unidades INT NULL,
    formapago INT NULL,
    cuenta	  INT NULL,
    foliofactura VARCHAR(13) NULL, 
    emision	 DATE NULL,
    descripcion TEXT NULL,
    costofinal DECIMAL(10,2) NULL,
    egreso 	DECIMAL(10,2) NULL,
    montopdte DECIMAL(10,2) NULL,
    impuestos DECIMAL(10,2) NULL,
    costofinalunit DECIMAL(10,2) NULL,
    created_at DATETIME DEFAULT NOW(),
    CONSTRAINT fk_subtipo_gastoentrada foreign key (subtipo) references subtipos (idsubtipo) ON DELETE CASCADE
) ENGINE = INNODB;

CREATE TABLE prodserv (
	idprodserv INT auto_increment primary key,
    nombre VARCHAR(80) NULL,
    tipo	INT NULL,
    codigo 	varchar(10) null,
    idproveedor INT NULL,
    precio 		DECIMAL(10,2) null,
	constraint fk_idproveedor foreign key (idproveedor) references proveedores (idproveedor) ON DELETE CASCADE
) ENGINE = INNODB;
SELECT * FROM prodserv