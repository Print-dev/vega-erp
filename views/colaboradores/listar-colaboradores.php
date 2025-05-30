<?php require_once '../header.php' ?>
<style>
    .contenedor-general {
        display: flex;
        flex-direction: column;
        height: auto;
        min-height: 100vh;
    }

    #table-colaboradores {
        font-size: 12px;
        /* Reducir el tamaño de la fuente */
        width: 100%;
        border-collapse: collapse;
        /* Unir bordes para ahorrar espacio */
    }

    /* Ajustar el padding de las celdas */
    #table-colaboradores th,
    #table-colaboradores td {
        /* Reducir el espacio interno */
        text-align: left;
        white-space: nowrap;
        /* Evitar saltos de línea */
    }

    /* Ajustar el ancho de columnas específicas */
    #table-colaboradores th:nth-child(1),
    #table-colaboradores td:nth-child(1) {
        width: 1%;
    }

    /* # */
    #table-colaboradores th:nth-child(2),
    #table-colaboradores td:nth-child(2) {
        width: 1%;
    }

    /* N° Cotización */
    #table-colaboradores th:nth-child(3),
    #table-colaboradores td:nth-child(3) {
        width: 1%;
    }

    /* Artista */
    #table-colaboradores th:nth-child(4),
    #table-colaboradores td:nth-child(4) {
        width: 1%;
    }

    /* Lugar */
    #table-colaboradores th:nth-child(5),
    #table-colaboradores td:nth-child(5) {
        width: 1%;
    }

    /* Ubigeo */
    #table-colaboradores th:nth-child(6),
    #table-colaboradores td:nth-child(6) {
        width: 1%;
    }


    #table-colaboradores tbody tr:nth-child(odd) {
        background-color: #f9f9f9;
        /* Gris claro */
    }

    #table-colaboradores tbody tr:nth-child(even) {
        background-color: #ffffff;
        /* Blanco */
    }

    #table-colaboradores_length {
        margin-top: 20px;
        margin-bottom: 20px;
    }

    #table-colaboradores_filter {
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
                    <h1>Colaboradores</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="<?= $hostOnlyHeader ?>/views/colaboradores/registrar-colaborador" class="btn btn-info">Nuevo Colaborador</a>
                </div>
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <div class="card border-0" hidden>
                                <div class="card-body border-0">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="num_doc" autocomplete="off" placeholder="N° Documento">
                                                <label for="num_doc">N° Documento</label>
                                            </div>
                                        </div>
                                        <!-- <div class="col-md-4">
                                            <div class="form-floating">
                                                <select name="idarea" id="idarea" class="form-select filter">

                                                </select>
                                                <label for="idarea" class="form-label">Área</label>                                                
                                            </div>
                                        </div> -->
                                        <div class="col-md-3 mb-3">
                                            <div class="form-floating">
                                                <select name="cargo" id="cargo" class="form-select" placeholder="cargo">

                                                </select>
                                                <label for="cargo" class="form-label">Cargo</label>
                                                <i class="bi bi-plus-circle fs-4 text-primary" role="button" title="Nueva Cargo" data-bs-toggle="modal" data-bs-target="#modal-nuevocargo"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-colaboradores">
                                        <thead class="text-center">
                                            <tr>
                                                <th>N° Doc</th>
                                                <th>Nombres y apellidos</th>                                                                                                
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-colaborador">
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
<!-- <div class="modal fade" id="modal-fechasagenda" tabindex="-1" aria-labelledby="modalfechasagenda" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalfechasagenda">Fechas ocupadas</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table rounded">
                    <div class="contenedor-fechasocupadas">

                    </div>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary btnGuardarContrato" id="close-mdl-fechasagenda" data-bs-dismiss="modal" aria-label="Close">Cerrar</button>
            </div>
        </div>
    </div>
</div> -->

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

<div class="modal fade" id="modal-actualizar-proveedor" tabindex="-1" aria-labelledby="modalactualizar-proveedor" aria-hidden="true">
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


<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/colaboradores/listar-colaboradores.js"></script>
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>

</body>

</html>