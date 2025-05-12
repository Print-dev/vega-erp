<?php require_once '../header.php' ?>
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
                    <h1>Proveedores</h1>
                </div>
                <div class="col-md-6 text-end">
                    <button type="button" class="btn btn-info" id="btnNuevoProveedor" data-bs-toggle="modal" data-bs-target="#modal-nuevo-proveedor">Nuevo Proveedor</button>
                </div>
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <!-- <div class="card border-0">
                                <div class="card-body border-0">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="ndocumento" autocomplete="off" placeholder="N° Documento">
                                                <label for="ndocumento">N° Documento</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="telefono" autocomplete="off" placeholder="Telefono">
                                                <label for="telefono">Telefono</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="razonsocial" autocomplete="off" placeholder="Razon Social">
                                                <label for="razonsocial">Razon Social</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> -->
                            <!-- <hr> -->
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-clientes">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Empresa</th>
                                                <th>Nombre</th>
                                                <th>Contacto</th>
                                                <th>Correo</th>
                                                <th>Dni</th>
                                                <th>Banco</th>
                                                <th>Cta. Bancaria</th>
                                                <th>Serv/Prov</th>
                                                <th>No. Proveedor</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-cliente">
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
            <div class="modal-body">
                <div class="col-md-12 mb-3">
                    <div class="form-floating">
                        <input type="text" id="empresa" name="empresa" class="form-control" placeholder="Empresa">
                        <label for="empresa" class="form-label">Empresa</label>
                    </div>
                </div>
                <div class="col-md-12 mb-3">
                    <div class="form-floating">
                        <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre">
                        <label for="nombre">Nombre</label>
                    </div>
                </div>
                <div class="col-md-12 mb-3">
                    <div class="form-floating">
                        <input type="text" id="contacto" name="contacto" class="form-control" placeholder="Contacto">
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
                        <input type="text" id="dni" name="dni" class="form-control" placeholder="DNI">
                        <label for="dni">DNI</label>
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
                        <input type="text" id="ctabancaria" name="ctabancaria" class="form-control" placeholder="Cta.Bancaria">
                        <label for="ctabancaria">Cta.Bancaria</label>
                    </div>
                </div>
                <div class="col-md-12 mb-3">
                    <div class="form-floating">
                        <input type="text" id="servprod" name="servprod" class="form-control" placeholder="Serv/Prov">
                        <label for="servprod">Serv/Prov</label>
                    </div>
                </div>
                <div class="col-md-12 mb-3">
                    <div class="form-floating">
                        <input type="text" id="nproveedor" name="nproveedor" class="form-control" placeholder="Cta.Bancaria">
                        <label for="nproveedor">No.Proveedor</label>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>


<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/proveedores/listar-proveedores.js"></script>
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>

</body>

</html>