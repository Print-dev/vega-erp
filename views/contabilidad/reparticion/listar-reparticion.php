<?php require_once '../../header.php' ?>
<div class="container-fluid">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Reparticiones</h1>
                </div>
                <div class="col-md-6 text-end">
                    <!-- <a href="http://localhost/vega-erp/views/utilitario/usuarios/registrar-usuario" class="btn btn-primary"></a> nomusuario -->
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
                                                <select name="nomusuario" id="nomusuario" class="form-select filter" required>
                                                </select>
                                                <label for="nomusuario">Artista</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="establecimiento" autocomplete="off">
                                                <label for="establecimiento" class="form-label">Lugar/Establecimiento</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="date" class="form-control filter" id="fechapresentacion" autocomplete="off">
                                                <label for="fechapresentacion" class="form-label">Fecha presentacion</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-reparticiones">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Evento</th>
                                                <th>Lugar/Establecimiento</th>
                                                <th>Fecha presentacion</th>
                                                <!--                                                 <th>Ingreso total</th>
                                                <th>Egreso total</th> -->
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-reparticion">
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
    <div class="modal fade" id="modal-calculoreparticion" tabindex="-1" aria-labelledby="modalcalculoreparticion" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalcalculoreparticion">
                        <h3 class="fw-bold">Gastos General de Evento</h3>
                    </h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Contenedor de ingresos (Izquierda) -->
                    <div class="card">
                        <div class="card-body">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h4 class="fw-bold text-center">Ingresos</h4>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover text-center align-middle">
                                                <thead class="table-dark">
                                                    <tr>
                                                        <th style="min-width: 100px;">Descripción</th>
                                                        <th style="min-width: 100px;">Ingreso (+ S/.)</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="tbody-ingresos">
                                                    <!-- Filas dinámicas aquí -->
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td class="text-end fw-bold">Total:</td>
                                                        <td class="text-center fw-bold" id="totalIngresos">S/. 0.00</td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- Contenedor de egresos (Derecha) -->
                                    <div class="col-md-6">
                                        <h4 class="fw-bold text-center">Egresos</h4>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover text-center align-middle">
                                                <thead class="table-dark">
                                                    <tr>
                                                        <th style="min-width: 100px;">Descripción</th>
                                                        <th style="min-width: 100px;">Egresos (- S/.)</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="tbody-egresos">
                                                    <!-- Filas dinámicas aquí -->
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td class="text-end fw-bold">Total:</td>
                                                        <td class="text-center fw-bold" id="totalEgresos">S/. 0.00</td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <div class="text-end">
                                    <label for="" id="gastoGeneralEvento"></label>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="card-body">
                            <div class="row text-center contenedor-ganancias">

                            </div>
                        </div>
                        <hr>
                        <div class="card-body">
                            <div class="card-body">
                                <h4 class="fw-bold">Gastos unicos Vega</h4>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover text-center align-middle">
                                        <thead class="table-dark">
                                            <tr>
                                                <th style="min-width: 100px;">Descripcion</th>
                                                <th style="min-width: 100px;">Costo</th>
                                            </tr>
                                        </thead>
                                        <tbody class="tbody-cajachica">
                                            <!-- Filas dinámicas aquí -->
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td class="text-end fw-bold">Total:</td>
                                                <td class="text-center fw-bold" id="totalcajachica">S/. 0.00</td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer ">
                                <div class="text-end">
                                    <h5 class="fw-bold" id="ingresoTotalEvento"></h5>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="card-body bg-primary">
                            <div class="row text-center contenedor-reparticion">

                            </div>
                        </div>
                    </div>
                </div>

                <!-- <div class="modal-footer text-end">
                    <button type="button" class="btn btn-secondary" id="btnRegistrarEgreso">Guardar</button>
                </div> -->
            </div>
        </div>
    </div>
    <?php require_once '../../footer.php' ?>

    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

    <script src="http://localhost/vega-erp/js/reparticiones/listar-reparticiones.js"></script>

    </body>

    </html>