<?php require_once '../../header.php'; ?>
<h2 class=" my-4">Registrar Tarifa</h2>

<div class="container-fluid">
    <div class="row card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Datos del artista</h5>
            <a href="<?= $host ?>views/utilitario/tarifas/listar-tarifas" class="btn btn-outline-primary btn-sm">
                <i class="fa-solid fa-circle-left"></i> Regresar
            </a>
        </div>

        <div class="card-body">
            <form id="form-person-user">
                <div class="row g-3 ">
                    <div class="col-md-4">
                        <div class="form-floating">
                            <select name="artista" id="artista" class="form-select" required></select>
                            <label for="artista">Artista</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-floating">
                            <select name="nacionalidad" id="nacionalidad" class="form-select" required>
                                <option value="" selected>Selecciona</option>
                                <option value="31">Peru</option>
                            </select>
                            <label for="nacionalidad">Nacionalidad</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-floating">
                            <select name="departamento" id="departamento" class="form-select" required></select>
                            <label for="departamento">Departamento</label>
                        </div>
                    </div>
                </div>

                <hr class="my-4">

                <div class="table-responsive d-flex justify-content-center">
                    <table class="table table-striped table-hover text-center align-middle w-auto mx-auto" id="table-tarifarios">
                        <thead class="table-dark">
                            <tr>
                                <th>Provincia</th>
                                <th>Costo</th>
                                <th>Opciones</th>
                            </tr>
                        </thead>
                        <tbody id="tb-body-tarifario">
                            <!-- Contenido dinámico -->
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
    </div>
</div>

<?php require_once '../../footer.php'; ?>

<script src="http://localhost/vega-erp/js/tarifarios/registrar-tarifario.js"></script>

</body>

</html>