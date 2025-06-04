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
                    <h1>Nómina de colaboradores</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="<?= $hostOnlyHeader ?>/views/nominas/registrar-nomina" class="btn btn-primary">Nueva Registro</a>

                    <button class="btn btn-success" id="btnGenerarExcel"><i class="fa-solid fa-file-excel"></i> Descargar en Excel</button>
                    <!-- <button class="btn btn-info" id="btnGenerarFicha"><i class="fa-regular fa-file-lines"></i>  Descargar Ficha(s)</button> -->
                </div>
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <div class="card border-0">
                                <div class="card-body border-0">
                                    <div class="row">
                                        <div class="col-md-2 mb-3">
                                            <div class="form-floating">
                                                <select name="tipo" id="tipo" class="form-select" placeholder="Tipo">
                                                    <option value="-1">Selecciona</option>
                                                    <option value="1">Individual</option>
                                                    <option value="2">Rango</option>
                                                </select>
                                                <label for="tipo" class="form-label">Tipo</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 mb-3" id="div-mesanoindividual">
                                            <div class="form-floating">
                                                <input type="month" class="form-control filter" id="mesanoindividual" autocomplete="off" placeholder="mesanoindividual">
                                                <label for="mesanoindividual">Mes/Año</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 mb-3" id="div-mesanorangoincio">
                                            <div class="form-floating">
                                                <input type="month" class="form-control filter" id="mesanorangoincio" autocomplete="off" placeholder="Mes/Año">
                                                <label for="mesanorangoincio">Mes/Año</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 mb-3" id="div-mesanorangofin">
                                            <div class="form-floating">
                                                <input type="month" class="form-control filter" id="mesanorangofin" autocomplete="off" placeholder="Mes/Año">
                                                <label for="mesanorangofin">Mes/Año</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 mb-3">
                                            <div class="form-floating">
                                                <select name="colaborador" id="colaborador" class="form-select filter" placeholder="Colaborador">
                                                </select>
                                                <label for="colaborador" class="form-label">Colaborador</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-nominas">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Tipo</th>
                                                <th>Nombres y Apellidos</th>
                                                <th>Cargo</th>
                                                <th>Correo</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-nomina">
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
<div class="modal fade" id="modal-nuevo-colaborador-nomina" tabindex="-1" aria-labelledby="modalcolaboradornomina" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalcolaboradornomina">Asignar Colaborador a nómina</h1>
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

<div class="modal fade" id="modal-acumulados" tabindex="-1" aria-labelledby="modallabel-acumulados" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modaltitle-acumulado">Acumulados</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" id="formAcumulados">
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col">Fecha</th>
                                    <th scope="col">Descripción</th>
                                    <th scope="col" class="text-end">Monto (S/)</th>
                                    <th scope="col" class="text-end">Opc.</th>
                                </tr>
                            </thead>
                            <tbody id="div-acumulado">

                            </tbody>
                            <tfoot id="div-totalacumulado">

                            </tfoot>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-info" tabindex="-1" aria-labelledby="modallabel-info" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modaltitle-acumulado">info</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="div-info">


                <!-- HACER UN DIV PARA MOSTRAR LA INFORMACION DEL COLABORADOR TANTO DE SU NOMINA ACTUAL -->
            </div>
        </div>
    </div>
</div>

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
<script src="https://cdnjs.cloudflare.com/ajax/libs/exceljs/4.4.0/exceljs.min.js" integrity="sha512-dlPw+ytv/6JyepmelABrgeYgHI0O+frEwgfnPdXDTOIZz+eDgfW07QXG02/O8COfivBdGNINy+Vex+lYmJ5rxw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.sheetjs.com/xlsx-0.20.0/package/exceljs.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/nominas/listar-nominas.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->

</body>

</html>