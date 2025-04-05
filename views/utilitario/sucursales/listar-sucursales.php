<?php require_once '../../header.php' ?>

<style>
    .contenedor-general {
        display: flex;
        flex-direction: column;
        height: auto;
        min-height: 100vh;
    }
</style>

<div class="container-fluid contenedor-general">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Sucursales</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="<?= $hostOnlyHeader ?>/views/utilitario/sucursales/registrar-sucursal" class="btn btn-primary">Nuevo Sucursal</a>
                </div>
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <div class="card border-0">
                                <div class="card-body border-0">

                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select name="nacionalidad" id="nacionalidad" class="form-select filter">
                                                    <option value="">Selecciona</option>
                                                    <option value="31">Perú</option>
                                                </select>
                                                <label for="nacionalidad" class="form-label">Nacionalidad</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select name="departamento" id="departamento" class="form-select filter">

                                                </select>
                                                <label for="departamento" class="form-label">Departamento</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select name="provincia" id="provincia" class="form-select filter">

                                                </select>
                                                <label for="provincia" class="form-label">Provincia</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select name="distrito" id="distrito" class="form-select filter">

                                                </select>
                                                <label for="distrito" class="form-label">Distrito</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="nombresucursal" autocomplete="off">
                                                <label for="nombresucursal">Nombre</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- <hr> -->
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-sucursales">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Sucursal</th>
                                                <th>Nombre</th>
                                                <th>Ruc</th>
                                                <th>Telefono</th>
                                                <th>Direccion</th>
                                                <th>Representante</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-sucursal">
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ./Modal Para elegir la especificacion -->
                </div>
            </div>
        </div>
    </div>

    <?php require_once '../../footer.php' ?>
    <script src="<?= $hostOnlyHeader ?>/js/sucursales/listar-sucursales.js"></script>
    </body>

    </html>