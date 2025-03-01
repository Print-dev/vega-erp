<?php require_once '../header.php' ?>
<div class="container-fluid">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
-webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
-moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Atención al cliente</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="http://localhost/vega-erp/views/ventas/registrar-atencion-cliente" class="btn btn-primary">Nueva Atencion</a>
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
                                                <input type="text" class="form-control filter" id="ncotizacion" autocomplete="off">
                                                <label for="ncotizacion">Nº Cotizacion</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="ndocumento" autocomplete="off">
                                                <label for="ndocumento">Nº Documento/RUC</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row g-1">
                        <div class="table-responsive">
                            <table class="table" id="table-atenciones">
                                <thead class="text-center">
                                    <tr>
                                        <th>#</th>
                                        <th>N° Cotizacion</th>
                                        <th>Artista</th>
                                        <th>N° Documento/RUC</th>
                                        <th>Cliente</th>
                                        <th>Tipo evento</th>
                                        <th>Modalidad</th>
                                        <th>Fecha presentacion</th>
                                        <th>Opciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tb-body-atencion">
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

<!-- MODAL PARA COTIZAR DE MANERA CONTRATO -->
<div class="modal fade" id="modal-previacotizacion" tabindex="-1" aria-labelledby="modalPreviaCotizacion" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalPreviaCotizacion">Tarifario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table rounded">
                    <thead class="table-dark">
                        <tr>
                            <th>Departamento</th>
                            <th>Provincia</th>
                            <th>Dificultad</th>
                            <th>Precio S/.</th>
                        </tr>
                    </thead>
                    <tbody id="tInfoCotizacion">

                    </tbody>

                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="btnGenerarCotizacion">Generar Cotizacion</button>
                <button type="button" class="btn btn-primary btnGuardarContrato" id="close-mdl-cotizacion">Guardar y cerrar</button>
            </div>
        </div>
    </div>
</div>


<!-- MODAL PARA CONTRATO CONVENIO -->
<div class="modal fade" id="modal-convenio" tabindex="-1" aria-labelledby="modalContratoConvenio" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalContratoConvenio">Contrato Convenio</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row g-2">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="number" id="abonogarantia" name="abonogarantia"
                                        class="form-control">
                                    <label for="abonogarantia" class="form-label">Abono de garantía</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="number" id="abonopublicidad" name="abonopublicidad"
                                        class="form-control">
                                    <label for="abonopublicidad" class="form-label">Abono de publicidad</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 mt-3">
                            <div class="mb-3">
                                <label for="propuestacliente" class="form-label">Propuesta de cliente</label>
                                <textarea class="form-control" id="propuestacliente" rows="3"></textarea>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="btnGenerarConvenio">Generar Convenio</button>
                <button type="button" class="btn btn-primary btnGuardarConvenio" id="close-mdl-convenio">Guardar y cerrar</button>
            </div>
        </div>
    </div>
</div>


<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="http://localhost/vega-erp/js/ventas/listar-atencion.js"></script>

</body>

</html>