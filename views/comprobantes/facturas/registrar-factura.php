<?php require_once '../../header.php' ?>
<!-- <link rel="stylesheet" href="http://localhostOnlyHeader/SIGEMAPRE/css/usuario-register.css"> -->

<div class="row g-0 h-100 mb-3">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header border-0 d-flex justify-content-between align-items-center">
                <h2>Registrar Facturas</h2>

                <a href="<?= $hostOnlyHeader ?>/views/comprobantes/facturas/listar-facturas" class="btn btn-outline-primary btn-sm ms-auto m-0" type="button"><i class="fa-solid fa-circle-left"></i> Regresar</a>
            </div>
            <div class="card-body ">
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

        <div class="row mt-3">
            <div class="col-sm-3 p-3">
                <button type="submit" class="form-control btn btn-primary w-75" id="btnEnviar" disabled>
                    Registrar
                </button>
            </div>
        </div>
        </form>
    </div>
</div>
</div>
</div>
<?php require_once '../../footer.php' ?>
<script src="<?= $hostOnlyHeader ?>/js/facturas/registrar-factura.js"></script>
</body>

</html>