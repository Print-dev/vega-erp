<?php require_once '../../header.php' ?>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header text-center bg-primary text-white">
                    <h4>Registrar Sucursal</h4>
                </div>
                <div class="card-body">
                    <form action="ruta_del_servidor_o_script.php" method="POST">
                        <div class="mb-3">
                            <label for="nombre_sucursal" class="form-label">Nombre de la Sucursal:</label>
                            <input type="text" id="nombre_sucursal" name="nombre_sucursal" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="direccion" class="form-label">Dirección:</label>
                            <input type="text" id="direccion" name="direccion" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="telefono" class="form-label">Teléfono:</label>
                            <input type="tel" id="telefono" name="telefono" class="form-control" required pattern="^\+?[1-9]\d{1,14}$" placeholder="Ej: +51 123 456 789">
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Correo Electrónico:</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="pais" class="form-label">País:</label>
                            <input type="text" id="pais" name="pais" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="ciudad" class="form-label">Ciudad:</label>
                            <input type="text" id="ciudad" name="ciudad" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="estado" class="form-label">Estado/Provincia:</label>
                            <input type="text" id="estado" name="estado" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="codigo_postal" class="form-label">Código Postal:</label>
                            <input type="text" id="codigo_postal" name="codigo_postal" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="fecha_apertura" class="form-label">Fecha de Apertura:</label>
                            <input type="date" id="fecha_apertura" name="fecha_apertura" class="form-control" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Registrar Sucursal</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once '../../footer.php' ?>
<script src="<?= $hostOnlyHeader ?>/js/sucursales/registrar-sucursal.js"></script>
</body>

</html>