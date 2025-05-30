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
                    <h1>Pagos</h1>
                </div>
                <!-- <div class="col-md-6 text-end contenedor-btn-nuevacaja">
                    <a href="<?= $hostOnlyHeader ?> /views/contabilidad/cuotas/listar-cuotas" class="btn btn-primary" id="btnNuevaCaja"></a>
                </div> -->
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <div class="card border-0">
                                <div class="card-body border-0">

                                    <div class="row">
                                        <!-- <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="date" id="fecha" class="form-control filter">
                                                <label for="fecha">Fecha Venc.</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" id="numerocomprobante" class="form-control filter" placeholder="N° Comprobante">
                                                <label for="numerocomprobante">N° Comprobante</label>
                                            </div>
                                        </div> -->
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select id="idcliente" class="form-control filter">
                                                </select>
                                                <label for="idcliente">Cliente</label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-pagos">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Evento</th>
                                                <th>Cliente</th>
                                                <th>N° Documento</th>
                                                <th>Monto pagado</th>
                                                <th>Medio</th>
                                                <th>N° Operacion</th>
                                                <th>Fecha de pago</th>                                                
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-pago">
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

    <?php require_once '../../footer.php' ?>

    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

    <script src="<?= $hostOnlyHeader ?>/js/pagos/listar-pagos.js"></script>

    </body>

    </html>