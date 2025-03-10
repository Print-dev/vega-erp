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
                                        <th>Estado</th>
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
                <!--                 <button type="button" class="btn btn-primary btnGuardarContrato" id="close-mdl-cotizacion">Guardar y cerrar</button>
 -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-datosclienteincompletos" tabindex="-1" aria-labelledby="modalDatosClienteIncompletos" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalDatosClienteIncompletos">Previa Contrato</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table rounded">
                    <tbody id="tDatosClienteIncompleto">
                        <span class="text-danger">Antes de generar contrato llena los datos del cliente</span>
                        <div class="row g-2 mt-2">
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input type="text" id="ndocumentocli" name="ndocumentocli"
                                        class="form-control">
                                    <label for="ndocumentocli" class="form-label">N° Documento</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="nacionalidad" id="nacionalidad" class="form-select" required>
                                        <option value="" selected>Selecciona</option>
                                        <option value="31">Peruana</option>
                                    </select>
                                    <label for="nacionalidad" class="form-label">Nacionalidad</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="departamento" id="departamento" class="form-select" required>
                                    </select>
                                    <label for="departamento" class="form-label">Departamento</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="provincia" id="provincia" class="form-select" required>
                                    </select>
                                    <label for="provincia" class="form-label">Provincia</label>
                                </div>
                            </div>
                            <div class="col-md-3 ">
                                <div class="form-floating">
                                    <select name="distrito" id="distrito" class="form-select" required>
                                    </select>
                                    <label for="distrito" class="form-label">Distrito</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input type="text" id="razonsocial" name="razonsocial"
                                        class="form-control">
                                    <label for="razonsocial" class="form-label">Razon social/Nombre</label>
                                </div>
                            </div>
                            <div class="col-md-4" id="container-representantelegal" hidden>
                                <div class="form-floating">
                                    <input type="text" id="representantelegal" name="representantelegal"
                                        class="form-control">
                                    <label for="representantelegal" class="form-label">Representante legal</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <input type="number" id="telefono" name="telefono" maxlength="9" min="0"
                                        class="form-control">
                                    <label for="telefono" class="form-label">Telefono</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input type="text" id="correo" name="correo"
                                        class="form-control">
                                    <label for="correo" class="form-label">Correo</label>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-floating">
                                    <input type="text" id="direccion" name="direccion"
                                        class="form-control">
                                    <label for="direccion" class="form-label">Direccion</label>
                                </div>
                            </div>
                        </div>
                    </tbody>

                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="btnActualizarDatosCliente">Actualizar Datos</button>
                <button type="button" class="btn btn-primary btnGuardarContrato" id="close-mdl-datoscliente" data-bs-dismiss="modal">Cerrar</button>
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
                <button type="button" class="btn btn-secondary" id="btnActualizarPropuesta">Actualizar</button>
                <button type="button" class="btn btn-secondary" id="btnGuardarPendiente">Guardar pendiente</button>
                <button type="button" class="btn btn-secondary" id="btnAprobarPropuesta">Aprobar Propuesta</button>

            </div>
        </div>
    </div>
</div>


<!-- MODAL PARA CONTRATO CONVENIO -->
<div class="modal fade" id="modal-contrato" tabindex="-1" aria-labelledby="modalContrato" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalContrato">Pagar Contrato de Presentación</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row g-2 d-flex justify-content-center">
                            <div class="col-md-6 ">
                                <!-- <label for="" style="text-align: center; color: red;">Recordatorio: Si el tarifario no esta definido para este lugar no podrá hacer los cálculos</label> -->
                                <div id="montoActual">

                                </div>
                                <div class="form-floating ">
                                    <input type="number" id="montopagado" name="montopagado"
                                        class="form-control " min="0">
                                    <label for="montopagado" class="form-label">Monto</label>
                                </div>
                                <div id="porciento">

                                </div>
                                <div class="form-floating mt-3">
                                    <select name="tipopago" id="tipopago" class="form-select">
                                        <option value="-1">Selecciona</option>
                                        <option value="1">Transferencia</option>
                                        <option value="2">Contado</option>
                                    </select>
                                    <label for="tipopago" class="form-label">Tipo de pago</label>
                                </div>
                                <div class="form-floating mt-3" id="contenedor-noperacion" hidden>
                                    <input type="text" id="noperacion" name="noperacion"
                                        class="form-control " min="0">
                                    <label for="noperacion" class="form-label">N° Operacion</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer" id="contenedor-botones">
                <button type="button" class="btn btn-secondary" id="btnGuardar" hidden>Guardar</button>
                <!-- <button type="button" class="btn btn-secondary" id="btnGenerarReserva" hidden>Generar Reserva</button> -->
                <button type="button" class="btn btn-primary" id="close-mdl-convenio" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-reserva" tabindex="-1" aria-labelledby="modalReserva" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalReserva">Detalles a previa reserva</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row g-2 d-flex justify-content-center">
                            <div class="col-md-6 ">
                                <div class="form-floating ">
                                    <input type="number" id="vigencia" name="vigencia"
                                        class="form-control " min="0">
                                    <label for="vigencia" class="form-label">Vigencia</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer" id="contenedor-botones">
                <button type="button" class="btn btn-secondary" id="btnGuardarReserva">Guardar</button>
                <!-- <button type="button" class="btn btn-secondary" id="btnGenerarReserva" hidden>Generar Reserva</button> -->
                <button type="button" class="btn btn-primary" id="close-mdl-convenio" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="http://localhost/vega-erp/js/ventas/listar-atencion.js"></script>

</body>

</html>