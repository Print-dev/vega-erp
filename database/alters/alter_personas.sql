USE vega_producciones_erp;

ALTER TABLE detalles_presentacion DROP CONSTRAINT ck_estado_dp;
ALTER TABLE detalles_presentacion ADD CONSTRAINT ck_estado_dp CHECK (estado IN (1, 2, 3));
ALTER TABLE detalles_presentacion ADD COLUMN referencia varchar(200) null;
ALTER TABLE detalles_presentacion DROP FOREIGN KEY nombre_del_constraint;
ALTER TABLE detalles_presentacion DROP FOREIGN KEY fk_filmmaker_dp;

ALTER TABLE notificaciones_viatico CHANGE COLUMN filmmaker idusuario INT;
ALTER TABLE notificaciones_viatico DROP FOREIGN KEY fk_filmmamker_nt;
ALTER TABLE notificaciones_viatico ADD CONSTRAINT fk_filmmamker_nt FOREIGN KEY (idusuario) REFERENCES usuarios (idusuario);
ALTER TABLE agenda_editores ADD CONSTRAINT chk_tipotarea CHECK(tipotarea IN (1,2,3,4,5));
ALTER TABLE agenda_editores
DROP COLUMN observaciones;

ALTER TABLE agenda_editores
DROP COLUMN url_video;
ALTER TABLE agenda_editores
DROP COLUMN url_imagen;
ALTER TABLE agenda_editores CHANGE COLUMN ideditores idagendaeditor INT;
ALTER TABLE agenda_editores MODIFY idagendaeditor INT AUTO_INCREMENT;
ALTER TABLE detalles_presentacion DROP COLUMN filmmaker;
ALTER TABLE subidas_agenda_edicion DROP COLUMN url_imagen;
ALTER TABLE subidas_agenda_edicion DROP COLUMN url_video;
ALTER TABLE subidas_agenda_edicion ADD COLUMN url text not null;
ALTER TABLE viaticos ADD COLUMN idusuario	INT NOT NULL;
ALTER TABLE viaticos ADD CONSTRAINT fk_idusuario_vi foreign key (idusuario) references usuarios (idusuario);
ALTER TABLE usuarios ADD COLUMN marcaagua 	varchar(40) null;

ALTER TABLE notificaciones DROP COLUMN idreferencia;
ALTER TABLE notificaciones ADD COLUMN idrefefencia INT NULL;

ALTER TABLE notificaciones DROP CONSTRAINT chk_tipo;
ALTER TABLE notificaciones ADD CONSTRAINT  chk_tipo check(tipo IN (1,2)) ; -- ir cambiando constantemente
ALTER TABLE notificaciones DROP COLUMN idrefefencia;
ALTER TABLE notificaciones ADD COLUMN idreferencia INT NULL;

ALTER TABLE agenda_editores DROP COLUMN tipotarea;
ALTER TABLE agenda_editores ADD COLUMN idtipotarea INT NOT NULL;
ALTER TABLE agenda_editores ADD CONSTRAINT fk_idtipotarea_agen foreign key (idtipotarea) REFERENCES tipotarea (idtipotarea);

ALTER TABLE agenda_editores ADD COLUMN hora_entrega TIME NOT NULL;
ALTER TABLE agenda_editores ADD COLUMN    idcommunitymanager 	int null;
ALTER TABLE agenda_editores DROP COLUMN idcommunitymanager;
ALTER TABLE agenda_commanager ADD COLUMN  portalpublicar 		varchar(120) not null;
ALTER TABLE agenda_commanager ADD COLUMN estado				SMALLINT null default 1;
ALTER TABLE agenda_commanager ADD COLUMN copy				text null;
ALTER TABLE agenda_commanager ADD COLUMN fechapublicacion datetime null;

ALTER TABLE viaticos DROP COLUMN pasaje;
ALTER TABLE viaticos ADD COLUMN pasaje decimal(7,2) null;
ALTER TABLE viaticos DROP COLUMN comida;
ALTER TABLE viaticos ADD COLUMN hospedaje decimal(7,2) null;
ALTER TABLE viaticos ADD COLUMN desayuno tinyint null;
ALTER TABLE viaticos ADD COLUMN almuerzo tinyint null;
ALTER TABLE viaticos ADD COLUMN cena tinyint null;
ALTER TABLE detalles_presentacion ADD COLUMN lugardestino	varchar(100) null;
ALTER TABLE detalles_presentacion DROP COLUMN lugardestino;
ALTER TABLE viaticos DROP COLUMN viaje;
ALTER TABLE usuarios ADD COLUMN firma varchar(40) null;
ALTER TABLE usuarios ADD COLUMN esRepresentante tinyint null;
ALTER TABLE usuarios DROP COLUMN esRepresentante;
ALTER TABLE usuarios ADD COLUMN idsucursal 	int not null;

ALTER TABLE empresa DROP COLUMN iddistrito;
ALTER TABLE empresa DROP CONSTRAINT fk_iddistrito_empresa;
ALTER TABLE empresa ADD COLUMN nombreapp varchar(120) null;
ALTER TABLE comprobantes ADD COLUMN     tipopago		int not null;
