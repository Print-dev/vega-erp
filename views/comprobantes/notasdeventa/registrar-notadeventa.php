<?php require_once '../../header.php' ?>

<div class="row g-0 h-100 mb-3">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header border-0 d-flex justify-content-between align-items-center">
                <h2>Registrar nota de venta</h2>

                <a href="<?= $hostOnlyHeader ?>/views/comprobantes/notasdeventa/listar-notasdeventa" class="btn btn-outline-primary btn-sm ms-auto m-0" type="button"><i class="fa-solid fa-circle-left"></i> Regresar</a>
            </div>
            <div class="card-body ">
                <div class="row g-3">
                    <!-- <div class="col-md-3">
                        <div class="form-floating">
                            <input type="text" id="nserie" name="nserie"
                                class="form-control" readonly value="F001">
                            <label for="nserie" class="form-label">Serie</label>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-floating">
                            <input type="text" id="correlativo" name="correlativo"
                                class="form-control" readonly value="00000123">
                            <label for="correlativo" class="form-label">Correlativo</label>
                        </div>
                    </div> -->
                    <div class="col-md-3">
                        <div class="form-floating">
                            <select name="tipomoneda" id="tipomoneda" class="form-select">
                                <option value="" selected>Selecciona</option>
                                <option value="PEN">Soles</option>
                            </select>
                            <label for="tipomoneda" class="form-label">Moneda</label>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-floating">
                            <select name="tipooperacion" id="tipooperacion" class="form-select">
                                <option value="" selected>Selecciona</option>
                                <option value="0101">Venta interna</option>
                            </select>
                            <label for="tipooperacion" class="form-label">Tipo de operación</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select name="cliente" id="cliente" class="form-select">
                            </select>
                            <label for="cliente" class="form-label">Cliente</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select name="sucursal" id="sucursal" class="form-select">
                                <option value="" selected>Selecciona</option>
                            </select>
                            <label for="sucursal" class="form-label">Sucursal</label>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-floating">
                            <input type="number" id="ubigeo" name="ubigeo" class="form-control" placeholder="Ubigeo" required>
                            <label for="ubigeo">Ubigeo</label>
                        </div>
                    </div>
                    <div class="text-center my-4 position-relative">
                        <hr>
                        <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">
                            Detalle del Producto
                        </span>
                    </div> <!-- Datos del Producto -->

                    <div class="row">
                        <div class="col-md-11">
                            <div class="form-floating">
                                <select name="evento" id="evento" class="form-select">
                                    <!-- Opciones aquí -->
                                </select>
                                <label for="evento" class="form-label">Eventos</label>
                            </div>
                        </div>
                        <div class="col-md-1 d-flex justify-content-center align-items-center">
                            <div class="form-floating w-100">
                                <button class="btn btn-danger btn btn-danger w-100" id="btnDeseleccionarEvento" title="Deseleccionar Evento">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>


                    <!-- <div class="col-md-4">
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
                    </div> -->

                    <div class="table-responsive mt-4">
                        <table class="table table-hover align-middle text-center" id="tablaProductos">
                            <thead class="">
                                <tr>
                                    <th>#</th>
                                    <th width="50%">Descripción</th>
                                    <th>Precio Unitario (sin IGV)</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                                <!-- <tr>
                                    <td colspan="2" class="no-border"></td>
                                    <td><strong>Operación Gravada</strong></td>
                                    <td class="border-cell" id="txtOperacionGravada">S/ 0.00</td>
                                </tr> -->
                                <!-- <tr>
                                    <td colspan="2" class="no-border"></td>
                                    <td><strong>IGV</strong></td>
                                    <td class="border-cell" id="txtIGV">S/ 0.00</td>
                                </tr> -->
                                <tr>
                                    <td colspan="2" class="no-border"></td>
                                    <td><strong>Importe Total</strong></td>
                                    <td class="border-cell" id="txtImporteTotal">S/ 0.00</td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="no-border"></td>
                                    <td><strong>Forma de Pago</strong></td>
                                    <td class="border-cell">
                                        <select name="tipopago" id="tipopago" class="form-select">
                                            <option value="1">Contado</option>
                                            <!-- <option value="2">Crédito</option> -->
                                            <option value="3">Deposito</option>
                                        </select>
                                    </td>
                                </tr>
                                <!-- Cuotas se insertan después de esta fila -->
                                <tr class="contenedor-cuotas"></tr>

                                <!-- Botón Agregar Cuota -->
                                <tr id="contenedor-btn-agregar-cuota" hidden>
                                    <td colspan="2" class="no-border"></td>
                                    <!-- <td colspan="2" class="no-border">
                                        <button class="btn btn-primary w-100" id="btnAgregarCuota">Agregar Cuota</button>
                                    </td> -->
                                    <td colspan="2" class="no-border">
                                        <input type="text" class="form-control" id="noperacion" name="noperacion" placeholder="N° de operacion" required>
                                    </td>
                                </tr>

                            </tfoot>

                        </table>
                    </div>

                    <!-- Totales -->
                    <div class="col-md-10 mt-4">
                        <div class="input-group mb-3">
                            <span class="input-group-text fw-bolder" id="basic-addon3">IMPORTE EN LETRAS</span>
                            <input type="text" class="form-control" id="importeletra" aria-describedby="basic-addon3" readonly>
                        </div>

                    </div>
                    <div class="col-md-2 mt-4">
                        <button type="button" class="btn btn-primary " id="btnEmitirComprobante">Emitir Comprobante</button>
                    </div>
                </div>

            </div>

        </div>


    </div>
</div>
</div>
</div>

<?php require_once '../../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

<script src="<?= $hostOnlyHeader ?> /js/notasdeventa/registrar-notadeventa.js"></script>
<script src="https://cdn.jsdelivr.net/npm/n2words@1.21.0/dist/n2words.min.js"></script>

</body>

</html>