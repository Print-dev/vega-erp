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
                    <h1>Salarios</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="<?= $hostOnlyHeader ?>/views/colaboradores/listar-colaboradores" class="btn btn-info">Regresar</a>
                    <button class="btn btn-info" id="btnNuevoSalario" data-bs-toggle="modal" data-bs-target="#modal-nuevo-salario">Asignar Colaborador</button>
                </div>
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">

                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-salarios">
                                        <thead class="text-center">
                                            <tr>
                                                <th>#</th>
                                                <th>Salario (s/.)</th>
                                                <th>Costo x Hora</th>
                                                <th>Periodo</th>
                                                <th>Horas</th>
                                                <th>Fecha Ingreso</th>
                                                <th>Fecha Fin</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-salario">
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

<div class="modal fade" id="modal-nuevo-salario" tabindex="-1" aria-labelledby="modalnuevo-salario" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalnuevo-salario">Nuevo salario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" id="formsalario">
                <div class="modal-body">
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="salario" name="salario" class="form-control" placeholder="Salario (S/.)">
                            <label for="salario" class="form-label">Salario (S/.)</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <select name="periodo" id="periodo" class="form-select" placeholder="Periodo">
                                <option value="">Selecciona</option>
                                <option value="1">Quincenal</option>
                                <option value="2">Semanal</option>
                                <option value="3">Mensual</option>
                            </select>
                            <label for="periodo" class="form-label">Periodo</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="horas" name="horas" class="form-control" placeholder="Horas">
                            <label for="horas" class="form-label">Horas</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="costohora" name="costohora" class="form-control" placeholder="Costo x Hora">
                            <label for="costohora" class="form-label">Costo x Hora</label>
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

                    <button class="btn btn-primary w-100" type="submit" id="btnGuardarSalario">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>


<div class="modal fade" id="modal-actualizar-salario" tabindex="-1" aria-labelledby="modalactualizar-salario" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalactualizar-salario">Actualizar salario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" id="formActualizarSalario">
                <div class="modal-body">
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="salarioactualizar" name="salarioactualizar" class="form-control" placeholder="Salario (S/.)">
                            <label for="salarioactualizar" class="form-label">Salario (S/.)</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <select name="periodoactualizar" id="periodoactualizar" class="form-select" placeholder="Periodo">
                                <option value="">Selecciona</option>
                                <option value="1">Semanal</option>
                                <option value="2">Quincenal</option>
                                <option value="3">Mensual</option>
                            </select>
                            <label for="periodoactualizar" class="form-label">Periodo</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="horasactualizar" name="horasactualizar" class="form-control" placeholder="Horas">
                            <label for="horasactualizar" class="form-label">Horas</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="number" id="costohoraactualizar" name="costohoraactualizar" class="form-control" placeholder="Costo x Hora">
                            <label for="costohoraactualizar" class="form-label">Costo x Hora</label>
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="date" id="fechainicioactualizar" name="fechainicioactualizar" class="form-control" placeholder="Fecha de ingreso">
                            <label for="fechainicioactualizar" class="form-label">Fecha de ingreso</label>
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

                    <button class="btn btn-primary w-100" type="submit" id="btnActualizarSalario">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>



<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/colaboradores/salario-colaborador.js"></script>
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>

</body>

</html>