<?php require_once '../../header.php' ?>
<style>
    .contenedor-general {
        display: flex;
        flex-direction: column;
        height: auto;
        min-height: 100vh;
    }

    #table-gastos {
        font-size: 12px;
        /* Reducir el tamaño de la fuente */
        width: 100%;
        border-collapse: collapse;
        /* Unir bordes para ahorrar espacio */
    }

    /* Ajustar el padding de las celdas */
    #table-gastos th,
    #table-gastos td {
        /* Reducir el espacio interno */
        text-align: left;
        white-space: nowrap;
        /* Evitar saltos de línea */
    }

    /* Ajustar el ancho de columnas específicas */
    #table-gastos th:nth-child(1),
    #table-gastos td:nth-child(1) {
        width: 1%;
    }

    /* # */
    #table-gastos th:nth-child(2),
    #table-gastos td:nth-child(2) {
        width: 1%;
    }

    /* N° Cotización */
    #table-gastos th:nth-child(3),
    #table-gastos td:nth-child(3) {
        width: 1%;
    }

    /* Artista */
    #table-gastos th:nth-child(4),
    #table-gastos td:nth-child(4) {
        width: 1%;
    }

    /* Lugar */
    #table-gastos th:nth-child(5),
    #table-gastos td:nth-child(5) {
        width: 1%;
    }

    /* Ubigeo */
    #table-gastos th:nth-child(6),
    #table-gastos td:nth-child(6) {
        width: 1%;
    }


    #table-gastos tbody tr:nth-child(odd) {
        background-color: #f9f9f9;
        /* Gris claro */
    }

    #table-gastos tbody tr:nth-child(even) {
        background-color: #ffffff;
        /* Blanco */
    }

    #table-gastos_length {
        margin-top: 20px;
        margin-bottom: 20px;
    }

    #table-gastos_filter {
        margin-top: 20px;
        margin-bottom: 20px;
    }

    tbody,
    td,
    tfoot,
    th,
    thead,
    tr {
        border-style: none;
        border-bottom: none;
    }
</style>
<div class="container-fluid contenedor-general">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Gastos por pagar</h1>
                </div>
                <!-- <div class="col-md-6 text-end">
                    <a class="btn btn-info" id="btnNuevoColaboradorNomina" href="<?= $hostOnlyHeader ?>/views/contabilidad/gtxp/registrar-gtxp">Nuevo Gasto</a>
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
                                                <select name="artista" id="artista" class="form-select filter">
                                                </select>
                                                <label for="artista">Artista</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select name="evento" id="evento" class="form-select filter">
                                                </select>
                                                <label for="evento">Evento</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="date" class="form-control filter" id="fechagasto" autocomplete="off" placeholder="Fecha Gasto">
                                                <label for="fechagasto">Fecha Gasto</label>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-gastos">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Artista</th>
                                                <th>Evento</th>
                                                <th>Fecha de gasto</th>
                                                <th>Monto</th> <!-- ESTO SERA SUBTIPO PERO COMO PARA QUE ENTIENDAN -->
                                                <th>Medio de pago</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-gasto">
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
</div>

<!-- MODAL PARA COTIZAR DE MANERA CONTRATO -->
<div class="modal fade" id="modal-pagar" tabindex="-1" aria-labelledby="modalpagar" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalpagar">Nuevo gasto</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" id="formPagar">
                    <div class="row">
                        <div class="col-md-6 mb-3" id="div-mediopago">
                            <div class="form-floating">
                                <select name="mediopago" id="mediopago" class="form-select" placeholder="Medio Pago">
                                    <option value="">Selecciona</option>
                                    <option value="1">Transferencia</option>
                                    <option value="2">Efectivo</option>
                                </select>
                                <label for="mediopago" class="form-label">Medio Pago</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3" id="div-detalles">
                            <div class="form-floating">
                                <input type="text" id="detalles" class="form-control" autocomplete="off" placeholder="Detalles">
                                <label for="detalles" class="form-label">Detalles</label>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div id="div-comprobante-pago">
                                <div class="col-md-4 d-flex flex-column align-items-center w-100">
                                    <!-- Vista previa -->
                                    <img id="previewImagenPago" src="" class="img-fluid mb-3 border rounded" style="max-height: 180px; object-fit: contain;">

                                    <!-- Input de archivo oculto + etiqueta como botón -->
                                    <input id="upload_widget_pago" type="file" name="upload_widget_pago" class="d-none">
                                    <label for="upload_widget_pago" class="btn btn-primary w-100 d-flex align-items-center justify-content-center">
                                        <i class="fa-solid fa-cloud-upload-alt me-2"></i> Seleccionar Comprobante de Pago
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div id="div-comprobante-fac-bol">
                                <div class="col-md-4 d-flex flex-column align-items-center w-100">
                                    <!-- Vista previa -->
                                    <img id="previewImagenFacturaBoleta" src="" class="img-fluid mb-3 border rounded" style="max-height: 180px; object-fit: contain;">

                                    <!-- Input de archivo oculto + etiqueta como botón -->
                                    <input id="upload_widget_facturaboleta" type="file" name="upload_widget_facturaboleta" class="d-none">
                                    <label for="upload_widget_facturaboleta" class="btn btn-primary w-100 d-flex align-items-center justify-content-center">
                                        <i class="fa-solid fa-cloud-upload-alt me-2"></i> Seleccionar Factura o Boleta
                                    </label>
                                </div>
                            </div>

                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 btnGuardarPago">Guardar</button>
                </form>

            </div>

        </div>
    </div>
</div>
<!-- 
<div class="modal fade" id="modal-nuevo-proveedor" tabindex="-1" aria-labelledby="modalnuevo-proveedor" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalnuevo-proveedor">Nuevo Proveedor</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" id="formProveedor">
                <div class="modal-body">
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="empresa" name="empresa" class="form-control" placeholder="Empresa">
                            <label for="empresa" class="form-label">Empresa</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="nombreempresa" name="nombreempresa" class="form-control" placeholder="Nombre">
                            <label for="nombreempresa">Nombre</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="contacto" name="contacto" class="form-control" placeholder="Contacto">
                            <label for="contacto">Contacto</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="correo" name="correo" class="form-control" placeholder="Correo">
                            <label for="correo">Correo</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="dniempresa" name="dniempresa" class="form-control" placeholder="DNI">
                            <label for="dniempresa">DNI</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="banco" name="banco" class="form-control" placeholder="Banco">
                            <label for="banco">Banco</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="ctabancaria" name="ctabancaria" class="form-control" placeholder="Cta.Bancaria">
                            <label for="ctabancaria">Cta.Bancaria</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="servicio" name="servicio" class="form-control" placeholder="Serv/Prov">
                            <label for="servicio">Serv/Prov</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="nproveedor" name="nproveedor" class="form-control" placeholder="Cta.Bancaria">
                            <label for="nproveedor">No.Proveedor</label>
                        </div>
                    </div>
                    <hr>
                    <button class="btn btn-primary w-100" type="submit" id="btnGuardarProveedor">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>
 -->
<!-- <div class="modal fade" id="modal-actualizar-proveedor" tabindex="-1" aria-labelledby="modalactualizar-proveedor" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalactualizar-proveedor">Nuevo Proveedor</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" id="formActualizarProveedor">
                <div class="modal-body">
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="empresaactualizar" name="empresaactualizar" class="form-control" placeholder="Empresa">
                            <label for="empresaactualizar" class="form-label">Empresa</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="nombreempresaactualizar" name="nombreempresaactualizar" class="form-control" placeholder="Nombre">
                            <label for="nombreempresaactualizar">Nombre</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="contactoactualizar" name="contactoactualizar" class="form-control" placeholder="Contacto">
                            <label for="contactoactualizar">Contacto</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="correoactualizar" name="correoactualizar" class="form-control" placeholder="Correo">
                            <label for="correoactualizar">Correo</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="dniempresaactualizar" name="dniempresaactualizar" class="form-control" placeholder="DNI">
                            <label for="dniempresaactualizar">DNI</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="bancoactualizar" name="bancoactualizar" class="form-control" placeholder="Banco">
                            <label for="bancoactualizar">Banco</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="ctabancariaactualizar" name="ctabancariaactualizar" class="form-control" placeholder="Cta.Bancaria">
                            <label for="ctabancariaactualizar">Cta.Bancaria</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="servicioactualizar" name="servicioactualizar" class="form-control" placeholder="Serv/Prov">
                            <label for="servicioactualizar">Serv/Prov</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="nproveedoractualizar" name="nproveedoractualizar" class="form-control" placeholder="Cta.Bancaria">
                            <label for="nproveedoractualizar">No.Proveedor</label>
                        </div>
                    </div>
                    <hr>
                    <button class="btn btn-primary w-100" type="submit" id="btnActualizarProveedor">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>

 -->
<?php require_once '../../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/gtxp/listar-gtxp.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->

</body>

</html>