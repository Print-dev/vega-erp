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