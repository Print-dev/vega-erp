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
                    <h1>Gastos e Ingresos</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a class="btn btn-info" id="btnNuevoColaboradorNomina" href="<?= $hostOnlyHeader ?>/views/gastos/registrar-gasto">Nuevo Gasto</a>
                </div>
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <div class="card border-0" hidden>
                                <div class="card-body border-0">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="proveedor" autocomplete="off" placeholder="Proveedor">
                                                <label for="proveedor">Proveedor</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="fechagasto" autocomplete="off" placeholder="Fecha Gasto">
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
                                                <th>Estado</th>
                                                <th>Fecha Gasto</th>
                                                <th>Fecha Vencimiento</th>
                                                <th>Razón</th> <!-- ESTO SERA SUBTIPO PERO COMO PARA QUE ENTIENDAN -->
                                                <th>Gasto</th>
                                                <th>Costo Final</th>
                                                <th>Monto Pendiente</th>
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
<div class="modal fade" id="modal-nuevo-gasto" tabindex="-1" aria-labelledby="modalnuevogasto" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalnuevogasto">Nuevo gasto</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" id="formNomina">
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <select name="colaborador" id="colaborador" class="form-select filter" placeholder="Colaboradores">

                                </select>
                                <label for="colaborador" class="form-label">Colaboradores <span class="text-danger">(*)</span></label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="number" id="tiempo" name="tiempo" class="form-control" placeholder="Tiempo" disabled>
                                <label for="tiempo" class="form-label">Tiempo <span class="text-danger">(*)</span></label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="number" id="rendimiento" name="rendimiento" class="form-control" placeholder="Rendimiento">
                                <label for="rendimiento" class="form-label">Rendimiento <span class="text-danger">(*)</span></label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="number" id="proporcion" name="proporcion" class="form-control" placeholder="Proporción">
                                <label for="proporcion" class="form-label">Proporción <span class="text-danger">(*)</span></label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="number" id="acumulado" name="acumulado" class="form-control" placeholder="Acumulado">
                                <label for="acumulado" class="form-label">Acumulado <span class="text-danger">(*)</span></label>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 btnGuardarNomina">Guardar</button>
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
<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/gastos/listar-gastos.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->

</body>

</html>