<?php require_once '../../header.php' ?>
<div class="container-fluid">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Tarifas</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="http://localhost/vega-erp/views/utilitario/tarifas/registrar-tarifa" class="btn btn-primary">Editar/Agregar Tarifarios</a>
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
                                                <input type="text" class="form-control filter" id="nomusuario" autocomplete="off">
                                                <label for="nomusuario">Artista</label>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-tarifarios">
                                        <thead class="text-center">
                                            <tr>
                                                <th>#</th>
                                                <th>Artista</th>
                                                <th>Departamento</th>
                                                <th>Provincia</th>
                                                <th>Precio</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-tarifario">
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
    <script src="http://localhost/vega-erp/js/tarifarios/listar-tarifarios.js"></script>

    </body>

    </html>