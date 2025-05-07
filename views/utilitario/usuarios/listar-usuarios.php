<?php require_once '../../header.php' ?>
<div class="container-fluid">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Usuarios</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="<?= $hostOnlyHeader ?>/views/utilitario/usuarios/registrar-usuario" class="btn btn-primary">Nuevo Usuario</a>
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
                                                <select name="sucursal" id="sucursal" class="form-select filter">

                                                </select>
                                                <label for="sucursal" class="form-label">Sucursal</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select name="nivelacceso" id="nivelacceso" class="form-select filter">

                                                </select>
                                                <label for="nivelacceso" class="form-label">Nivel</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="ndocumento" autocomplete="off">
                                                <label for="ndocumento">Nº Documento</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="nombres" autocomplete="off">
                                                <label for="nombres">Nombres</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="apellidos" autocomplete="off">
                                                <label for="apellidos">Apellidos</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="nomusuario" autocomplete="off">
                                                <label for="nomusuario">Usuario</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="telefono" autocomplete="off">
                                                <label for="telefono">Telefono</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-usuarios">
                                        <thead class="text-center" style="background-color:rgb(255, 250, 230);">
                                            <tr>
                                                <th>#</th>
                                                <th>Nivel/Rol</th>
                                                <th>N° Documento</th>
                                                <th>Nombres</th>
                                                <th>Apellidos</th>
                                                <th>Usuario</th>
                                                <th>Telefono</th>
                                                <th>Estado</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-usuario">
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

    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script src="<?= $hostOnlyHeader ?>/js/usuarios/listar-usuarios.js"></script>

    </body>

    </html>