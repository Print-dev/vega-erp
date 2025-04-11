<?php require_once '../../header.php' ?>

<div class="container-fluid">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Boletas Emitidas</h1>
                </div>
                <div class="col-md-6 text-end contenedor-btn-nuevacaja">
                    <a href="<?= $hostOnlyHeader ?> /views/comprobantes/boletas/listar-boletas" class="btn btn-primary" id="btnNuevaCaja">Emitir Boleta</a>
                </div>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <!-- Datos del Cliente -->
                    <h5 class="mb-3">Datos del Cliente</h5>
                    <div class="col-md-4">
                        <label for="tipoDocCliente" class="form-label">Tipo de Documento</label>
                        <select class="form-select" id="tipoDocCliente" name="tipoDocCliente" required>
                            <option value="6" selected>RUC</option>
                            <option value="1">DNI</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="numDocCliente" class="form-label">Número de Documento</label>
                        <input type="text" class="form-control" id="numDocCliente" name="numDocCliente" required>
                    </div>
                    <div class="col-md-4">
                        <label for="rznSocialCliente" class="form-label">Razón Social / Nombre</label>
                        <input type="text" class="form-control" id="rznSocialCliente" name="rznSocialCliente" required>
                    </div>

                    <!-- Datos del Producto -->
                    <h5 class="mt-4 mb-3">Detalle del Producto</h5>
                    <div class="col-md-4">
                        <label for="codProducto" class="form-label">Código del Producto</label>
                        <input type="text" class="form-control" id="codProducto" name="codProducto" value="P001">
                    </div>
                    <div class="col-md-4">
                        <label for="descripcionProducto" class="form-label">Descripción</label>
                        <input type="text" class="form-control" id="descripcionProducto" name="descripcionProducto" required>
                    </div>
                    <div class="col-md-2">
                        <label for="cantidad" class="form-label">Cantidad</label>
                        <input type="number" class="form-control" id="cantidad" name="cantidad" value="1" min="1" required>
                    </div>
                    <div class="col-md-2">
                        <label for="precioUnitario" class="form-label">Precio Unitario (con IGV)</label>
                        <input type="number" class="form-control" id="precioUnitario" name="precioUnitario" step="0.01" required>
                    </div>

                    <!-- Datos adicionales -->
                    <h5 class="mt-4 mb-3">Información de Factura</h5>
                    <div class="col-md-3">
                        <label for="serie" class="form-label">Serie</label>
                        <input type="text" class="form-control" id="serie" name="serie" value="F001" required>
                    </div>
                    <div class="col-md-3">
                        <label for="correlativo" class="form-label">Correlativo</label>
                        <input type="text" class="form-control" id="correlativo" name="correlativo" required>
                    </div>
                    <div class="col-md-3">
                        <label for="fechaEmision" class="form-label">Fecha de Emisión</label>
                        <input type="date" class="form-control" id="fechaEmision" name="fechaEmision" value="<?= date('Y-m-d') ?>" required>
                    </div>
                    <div class="col-md-3">
                        <label for="moneda" class="form-label">Moneda</label>
                        <select class="form-select" id="moneda" name="moneda" required>
                            <option value="PEN" selected>Soles (PEN)</option>
                            <option value="USD">Dólares (USD)</option>
                        </select>
                    </div>

                    <!-- Totales -->
                    <div class="col-md-4 mt-4">
                        <label for="montoTotal" class="form-label">Monto Total (con IGV)</label>
                        <input type="number" class="form-control" id="montoTotal" name="montoTotal" readonly>
                    </div>
                    <div class="col-md-8 mt-4">
                        <label for="leyenda" class="form-label">Monto en Letras</label>
                        <input type="text" class="form-control" id="leyenda" name="leyenda" readonly>
                    </div>
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

    <div class="modal fade" id="modal-cierrecaja" tabindex="-1" aria-labelledby="modalcierrecaja" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalcierrecaja"></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover text-center align-middle w-auto mx-auto">
                            <thead class="table-dark">
                                <tr>
                                    <th>Ingreso</th>
                                    <th>Gasto</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody class="tbody-reg-cierrecaja">
                                <!-- Aquí van los datos dinámicos -->
                            </tbody>
                            <tfoot class="monto">
                                <tr>
                                    <td class="text-center fw-bold">Total Ingreso: <span id="totalIngreso">S/. 0.00</span></td>
                                    <td class="text-center fw-bold">Total Gasto: <span id="totalGasto">S/. 0.00</span></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                </div>

            </div>
        </div>
    </div>

    <?php require_once '../../footer.php' ?>

    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

    <script src="<?= $hostOnlyHeader ?> /js/boletas/listar-boletas.js"></script>

    </body>

    </html>