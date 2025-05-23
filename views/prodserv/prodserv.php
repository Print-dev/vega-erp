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
                    <h1>Productos y Servicios</h1>
                </div>
                <div class="col-md-6 text-end">
                    <button class="btn btn-info" id="btnNuevoProdserv" data-bs-toggle="modal" data-bs-target="#modal-nuevo-prodserv">Nuevo Prod Serv.</button>
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
                                                <input type="text" class="form-control filter" id="nombre" autocomplete="off" placeholder="Nombre">
                                                <label for="nombre">Nombre</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="dni" autocomplete="off" placeholder="Dni">
                                                <label for="dni">Dni</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> -->
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-prodservs">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Nombre</th>
                                                <th>Tipo</th>
                                                <th>Codigo</th>
                                                <th>Proveedor</th>
                                                <th>Precio</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-prodserv">
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
<div class="modal fade" id="modal-nuevo-prodserv" tabindex="-1" aria-labelledby="modalnuevoprodserv" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalnuevoprodserv">Ingresar producto/servicio</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" id="formProdserv">
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre">
                                <label for="nombre" class="form-label">Nombre <span class="text-danger">(*)</span></label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <select name="tipo" id="tipo" class="form-select filter" placeholder="Tipo">
                                    <option value="">Seleccione</option>
                                    <option value="1">Producto</option>
                                    <option value="2">Servicio</option>
                                </select>
                                <label for="tipo" class="form-label">Tipo <span class="text-danger">(*)</span></label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="text" id="codigo" name="codigo" class="form-control" placeholder="Codigo">
                                <label for="codigo" class="form-label">Codigo <span class="text-danger">(*)</span></label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <select name="proveedor" id="proveedor" class="form-select filter" placeholder="Proveedor">
                                </select>
                                <label for="proveedor" class="form-label">Proveedor</label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="number" id="precio" name="precio" class="form-control" placeholder="Precio" step="any">
                                <label for="precio" class="form-label">Precio <span class="text-danger">(*)</span></label>
                            </div>
                        </div>

                    </div>
                    <button type="submit" class="btn btn-primary w-100 btnGuardarProdserv">Guardar</button>
                </form>

            </div>

        </div>
    </div>
</div>


<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/prodserv/listar-prodserv.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->

</body>

</html>