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
                    <h1>Cargos</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="<?= $hostOnlyHeader ?>/views/colaboradores/listar-colaboradores" class="btn btn-info">Regresar</a>
                    <button class="btn btn-info" id="btnNuevoCargo" data-bs-toggle="modal" data-bs-target="#modal-nuevo-cargo">Nuevo Cargo</button>
                </div>
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">

                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-cargos">
                                        <thead class="text-center">
                                            <tr>
                                                <th>#</th>
                                                <th>Cargo</th>
                                                <th>Fecha de inicio</th>
                                                <th>FECHA de fin</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-cargo">
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

<div class="modal fade" id="modal-nuevo-cargo" tabindex="-1" aria-labelledby="modalnuevo-cargo" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalnuevo-cargo">Nuevo cargo</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" id="formcargo">
                <div class="modal-body">
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="cargo" name="cargo" class="form-control" placeholder="cargo (S/.)">
                            <label for="cargo" class="form-label">Cargo</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="date" id="fechainicio" name="fechainicio" class="form-control" placeholder="Fecha Inicio">
                            <label for="fechainicio" class="form-label">Fecha Inicio</label>
                        </div>
                    </div>
                    <!-- <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="date" id="costohora" name="costohora" class="form-control" placeholder="Costo x Hora">
                            <label for="costohora" class="form-label">Fecha Fin</label>
                        </div>
                    </div> -->
                    <!-- <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="date" id="nombreempresa" name="nombreempresa" class="form-control" placeholder="Nombre">
                            <label for="nombreempresa">Fecha de inicio</label>
                        </div>
                    </div> -->
                    <!-- <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="date" id="contacto" name="contacto" class="form-control" placeholder="Contacto">
                            <label for="contacto">Fecha finalizado</label>
                        </div>
                    </div> -->

                    <button class="btn btn-primary w-100" type="submit" id="btnGuardarCargo">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>


<div class="modal fade" id="modal-actualizar-cargo" tabindex="-1" aria-labelledby="modalactualizar-cargo" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalactualizar-cargo">Actualizar Cargo</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" id="formActualizarCargo">
                <div class="modal-body">
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" id="cargoactualizar" name="cargoactualizar" class="form-control" placeholder="Cargo">
                            <label for="cargoactualizar" class="form-label">Cargo</label>
                        </div>
                    </div>

                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="date" id="fechainicioactualizar" name="fechainicioactualizar" class="form-control" placeholder="Fecha de inicio">
                            <label for="fechainicioactualizar" class="form-label">Fecha de inicio</label>
                        </div>
                    </div>
                    <!-- <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="date" id="nombreempresa" name="nombreempresa" class="form-control" placeholder="Nombre">
                            <label for="nombreempresa">Fecha de inicio</label>
                        </div>
                    </div> -->
                    <!-- <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="date" id="contacto" name="contacto" class="form-control" placeholder="Contacto">
                            <label for="contacto">Fecha finalizado</label>
                        </div>
                    </div> -->

                    <button class="btn btn-primary w-100" type="submit" id="btnActualizarcargo">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>



<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/colaboradores/cargos-colaborador.js"></script>
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>

</body>

</html>