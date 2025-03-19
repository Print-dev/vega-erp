ALTER TABLE detalles_presentacion DROP CONSTRAINT ck_estado_dp;
ALTER TABLE detalles_presentacion ADD CONSTRAINT ck_estado_dp CHECK (estado IN (1, 2, 3));
