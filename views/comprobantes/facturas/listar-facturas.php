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
                    <h1>Facturas Emitidas</h1>
                </div>
                <div class="col-md-6 text-end contenedor-btn-nuevacaja">
                    <a href="<?= $hostOnlyHeader ?> /views/comprobantes/facturas/registrar-factura" class="btn btn-primary" id="btnNuevaCaja">Emitir Factura</a>
                </div>
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <div class="card border-0">
                                <div class="card-body border-0">

                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="date" id="fechaemision" class="form-control filter">
                                                <label for="fechaemision">Fecha de emisión</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="time" id="horaemision" class="form-control filter">
                                                <label for="horaemision">Hora de emisión</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" id="numerocomprobante" class="form-control filter" placeholder="N° de Comprobante">
                                                <label for="numerocomprobante">N° de Comprobante</label>
                                            </div>
                                        </div>
                                        <!-- <div class="col-md-2">
                                            <div class="form-floating">
                                                <select id="mes" class="form-control filter">
                                                    <option value="">Seleccionar Mes</option>
                                                    <option value="1">Enero</option>
                                                    <option value="2">Febrero</option>
                                                    <option value="3">Marzo</option>
                                                    <option value="4">Abril</option>
                                                    <option value="5">Mayo</option>
                                                    <option value="6">Junio</option>
                                                    <option value="7">Julio</option>
                                                    <option value="8">Agosto</option>
                                                    <option value="9">Septiembre</option>
                                                    <option value="10">Octubre</option>
                                                    <option value="11">Noviembre</option>
                                                    <option value="12">Diciembre</option>
                                                </select>
                                                <label for="mes">Filtrar por Mes</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="week" id="año_semana" class="form-control filter">
                                                <label for="año_semana">Filtrar por Semana</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" id="busqueda_general" class="form-control filter">
                                                <label for="busqueda_general">Evento</label>
                                            </div>
                                        </div> -->
                                    </div>

                                </div>
                            </div>

                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-facturas">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Fecha Emitido</th>
                                                <th>Comprobante</th>
                                                <th>Cliente</th>
                                                <th>Monto</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-factura">
                                        </tbody>

                                    </table>

                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- <div class="card-footer row">
                        <div class="text-end">
                            <a type="button" class="btn btn-success" id="btnGenerarExcelCaja"><i class="fa-solid fa-file-csv"></i> Generar CSV</a>
                            <a type="button" class="btn btn-success" id="btnGenerarCierreCajaChicaFiltro"> Generar Cierre</a>
                        </div>
                    </div> -->
                    <!-- ./Modal Para elegir la especificacion -->
                </div>
            </div>
        </div>
    </div>

    <!-- <div class="modal fade" id="modal-gastos" tabindex="-1" aria-labelledby="modalgastos" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalgastos">Registro de Gastos</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover text-center align-middle w-auto mx-auto">
                            <thead class="table-dark">
                                <th>Fecha</th>
                                <th>Concepto</th>
                                <th>Monto</th>
                            </thead>
                            <tbody class="tbody-reg-gastos">

                            </tbody>
                            <tfoot class="monto">
                                <tr>
                                    <td colspan="2" class="text-end">Total:</td>
                                    <td class="text-center" id="totalGastos"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div> -->
<!--     <div class="w-full">
        <div class="d-flex justify-content-between">
            <span>Factura</span>
            <span class="badge">
                F001
            </span>
        </div>
    </div> -->
    <!-- <div class="modal fade" id="modal-verificarsunat" tabindex="-1" aria-labelledby="modalverificarsunat" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h1 class="modal-title fs-5" id="modalverificarsunat"></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="contenedor-verificacion">
                        
                    </div>
                </div>

            </div>
        </div>
    </div> -->
    <?php require_once '../../footer.php' ?>

    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

    <script src="<?= $hostOnlyHeader ?> /js/facturas/listar-facturas.js"></script>

    </body>

    </html>