<?php require_once '../../header.php' ?>

<div class="container-fluid py-4 px-0">
    <div class="row d-flex flex-nowrap">
        <div class="card">
            <div class="card-body">
                <form action="" id="form-registro-gasto">
                    <div class="row g-2 mb-4">
                        <h1 class="fw-bold">Ingresar</h1>
                    </div>
                    <div class="row g-2 mb-4">
                        <!-- <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">General</span>
                        </div> -->
                        <div class="col-md-4">
                            <div class="form-floating">
                                <select name="referido" id="referido" class="form-select" placeholder="Referido">
                                    <option value="">Selecciona</option>
                                    <option value="1">Artistas</option>
                                    <option value="2">Eventos</option>
                                </select>
                                <label for="referido" class="form-label">Referido</label>
                            </div>
                        </div>
                        <div class="col-md-4" id="div-artista">
                            <div class="form-floating">
                                <select name="artista" id="artista" class="form-select" placeholder="Referido">
                                </select>
                                <label for="artista" class="form-label">Artista</label>
                            </div>
                        </div>
                        <div class="col-md-4" id="div-evento">
                            <div class="form-floating">
                                <select name="evento" id="evento" class="form-select" placeholder="Referido">
                                </select>
                                <label for="evento" class="form-label">Evento</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <select name="tipo" id="tipo" class="form-select" placeholder="Tipo">
                                    <option value="">Selecciona</option>
                                    <option value="1">Gasto</option>
                                    <option value="2">Entrada</option>
                                </select>
                                <label for="tipo" class="form-label">Tipo</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <select name="estado" id="estado" class="form-select" placeholder="Estado">
                                    <option value="">Selecciona</option>
                                    <option value="1">Pendiente</option>
                                    <option value="2">Pago</option>
                                </select>
                                <label for="estado" class="form-label">Estado</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="text" id="concepto" class="form-control" autocomplete="off" placeholder="Concepto">
                                <label for="concepto" class="form-label">Concepto</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="date" id="fechagasto" class="form-control" autocomplete="off">
                                <label for="fechagasto" class="form-label">F. Gasto</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="number" id="monto" class="form-control" autocomplete="off" step="any">
                                <label for="monto" class="form-label">Monto</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <select name="mediopago" id="mediopago" class="form-select" placeholder="Medio Pago">
                                    <option value="">Selecciona</option>
                                    <option value="1">Transferencia</option>
                                    <option value="2">Efectivo</option>
                                </select>
                                <label for="mediopago" class="form-label">Medio Pago</label>
                            </div>
                        </div>
                        <div class="col-md-4" id="div-detalles">
                            <div class="form-floating">
                                <input type="text" id="detalles" class="form-control" autocomplete="off" placeholder="Detalles">
                                <label for="detalles" class="form-label">Detalles</label>
                            </div>
                        </div>
                        <div id="div-comprobante-pago">
                            <div class="col-md-4 d-flex flex-column align-items-center">
                                <img id="previewImagenPago" src="ruta/logo-por-defecto.png" class="img-fluid mb-2 border rounded" style="max-height: 180px; object-fit: contain;">
                                <input id="upload_widget_pago" type="file" name="upload_widget_pago" class="btn btn-primary w-100 d-flex align-items-center justify-content-center">
                                <i class="fa-solid fa-cloud-upload-alt me-2"></i> Seleccionar Logo (app)
                                <!--  <div class="mt-3">
                                <img id="previewImagenLogo" src="" alt="Vista previa" class="img-fluid rounded shadow" style="max-height: 300px;">
                            </div> -->
                            </div>
                        </div>

                        <div class="col-md-4 d-flex flex-column align-items-center">
                            <img id="previewImagenFacturaBoleta" src="ruta/logo-por-defecto.png" class="img-fluid mb-2 border rounded" style="max-height: 180px; object-fit: contain;">
                            <input id="upload_widget_facturaboleta" type="file" name="upload_widget_facturaboleta" class="btn btn-primary w-100 d-flex align-items-center justify-content-center">
                            <i class="fa-solid fa-cloud-upload-alt me-2"></i> Seleccionar Logo (app)
                            <!--  <div class="mt-3">
                                <img id="previewImagenLogo" src="" alt="Vista previa" class="img-fluid rounded shadow" style="max-height: 300px;">
                            </div> -->
                        </div>

                    </div>
                    <hr>
                    <div class="row">
                        <div class="text-end">
                            <button type="button" class="btn btn-danger" id="btn-resetear">Resetear</button>
                            <button type="submit" class="btn btn-primary" id="btn-registrar-gasto">Registrar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<?php require_once '../../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/gastos/registrar-gasto.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>


</body>

</html>