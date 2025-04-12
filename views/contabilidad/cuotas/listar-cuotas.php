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
                    <h1>Cuotas</h1>
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
                                        <div class="col-md-2">
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
                                        </div>
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
                                    <table class="table" id="table-cuotas">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Fecha vencimiento</th>
                                                <th>Cliente</th>
                                                <th>Monto a pagar</th>
                                                <th>Monto pagado</th>
                                                <th>N° Comprobante</th>
                                                <th>Estado</th>
                                                <th>Montos abonados</th>
                                                <th>Accionar</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-cuota">
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

    <div class="modal fade" id="modal-historialabonados" tabindex="-1" aria-labelledby="modalhistorialabonados" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalhistorialabonados">Historial de abonos</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body contenedor-historialabonados">


                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-abonar" tabindex="-1" aria-labelledby="modalabonar" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalabonar">Abonar</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body contenedor-abonar">
                    <!-- Monto a abonar -->
                    <div class="mb-3">
                        <label for="montopagado" class="form-label">Monto a abonar</label>
                        <input type="number" step="0.01" min="0" class="form-control" id="montopagado" name="montopagado" required>
                    </div>
                    <div class="mb-3">
                        <label for="tipopago">Tipo de pago</label>
                        <select id="tipopago" class="form-control filter">
                            <option value="1">Contado</option>
                            <option value="1">Transferencoa</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="noperacion" class="form-label">N° Operación</label>
                        <input type="number" step="0.01" min="0" class="form-control" id="noperacion" name="noperacion" required>
                    </div>

                </div>
                <div class="card-footer">
                    <div class="w-100">
                        <button type="button" class="btn btn-primary w-100" id="btnAbonar">Abonar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php require_once '../../footer.php' ?>

    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

    <script src="<?= $hostOnlyHeader ?> /js/cuotas/listar-cuotas.js"></script>

    </body>

    </html>