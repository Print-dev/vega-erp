<?php require_once '../../header.php' ?>
<div class="row g-0 h-100 mb-3">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header border-0 d-flex justify-content-between align-items-center">
                <h2>Registrar Sucursal</h2>
                <a href="<?= $hostOnlyHeader ?>/views/utilitario/sucursales/listar-sucursales" class="btn btn-outline-primary btn-sm ms-auto m-0">
                    <i class="fa-solid fa-circle-left"></i> Regresar
                </a>
            </div>
            <div class="card-body">
                <form id="form-sucursal">
                    <h5>Datos de la Sucursal</h5>

                    <div class="row g-2 mb-3">
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre de la Sucursal" required>
                                <label for="nombre">Nombre de la Sucursal</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <input type="text" id="ruc" name="ruc" maxlength="11" class="form-control" placeholder="RUC" required>
                                <label for="ruc">RUC</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-floating">
                                <input type="tel" id="telefono" name="telefono" maxlength="20" class="form-control" placeholder="Teléfono">
                                <label for="telefono">Teléfono</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <input type="text" id="web" name="web" class="form-control" placeholder="Sitio Web">
                                <label for="web">Sitio Web</label>
                            </div>
                        </div>
                    </div>

                    <div class="row g-2 mb-3">
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="email" id="email" name="email" class="form-control" placeholder="Correo Electrónico">
                                <label for="email">Correo Electrónico</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="text" id="direccion" name="direccion" class="form-control" placeholder="Dirección" required>
                                <label for="direccion">Dirección</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="text" id="ubigeo" name="ubigeo" class="form-control" placeholder="Ubigeo" required>
                                <label for="ubigeo">Ubigeo</label>
                            </div>
                        </div>
                    </div>

                    <h5 class="mt-4">Ubicación Geográfica</h5>
                    <div class="row g-2 mb-3">
                        <div class="col-md-3">
                            <div class="form-floating">
                                <select name="nacionalidad" id="nacionalidad" class="form-select" required>
                                    <option value="">Selecciona</option>
                                    <option value="31">Perú</option>
                                </select>
                                <label for="nacionalidad">Nacionalidad</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <select name="departamento" id="departamento" class="form-select" required></select>
                                <label for="departamento">Departamento</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <select name="provincia" id="provincia" class="form-select" required></select>
                                <label for="provincia">Provincia</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <select name="iddistrito" id="iddistrito" class="form-select" required></select>
                                <label for="iddistrito">Distrito</label>
                            </div>
                        </div>
                    </div>

                    <h5 class="mt-4">Responsable</h5>
                    <div class="row g-2 mb-3">
                        <div class="col-md-6">
                            <div class="form-floating">
                                <select name="idresponsable" id="idresponsable" class="form-select">
                                    <option value="">Selecciona Responsable</option>
                                    <!-- Opciones cargadas desde DB -->
                                </select>
                                <label for="idresponsable">Responsable</label>
                            </div>
                        </div>                        

                    </div>

                    <div class="row mt-4">
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-primary form-control">Registrar Sucursal</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<?php require_once '../../footer.php' ?>
<script src="<?= $hostOnlyHeader ?>/js/sucursales/registrar-sucursal.js"></script>
</body>

</html>