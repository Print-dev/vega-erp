<?php require_once '../header.php' ?>

<div class="container-fluid py-4 px-0">
    <div class="row d-flex flex-nowrap">
        <div class="card">
            <div class="card-body">
                <div class="row g-2 mb-4">
                    <h1 class="fw-bold">Registrar nuevo</h1>
                </div>
                <div class="row g-2 mb-4">
                    <div class="text-center my-4 position-relative">
                        <hr>
                        <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Seleccionar Colaborador</span>
                    </div>

                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <div class="form-floating">
                                <select name="colaborador" id="colaborador" class="form-select" placeholder="colaborador">

                                </select>
                                <label for="colaborador" class="form-label">Colaborador</label>
                            </div>
                        </div>
                    </div>

                    <div class="text-center my-4 position-relative">
                        <hr>
                        <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Informacion de Nomina / Pago</span>
                    </div>

                    <div class="row"> <!-- Esta fila agrupa las columnas correctamente -->
                        <div class="col-md-3 mb-3">
                            <div class="form-floating">
                                <select name="tipo" id="tipo" class="form-select" placeholder="tipo">
                                    <option value="">Selecciona</option>
                                    <option value="1">Planilla</option>
                                    <option value="2">Contrato</option>
                                    <option value="3">Locación</option>
                                </select>
                                <label for="tipo" class="form-label">Tipo</label>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="form-floating">
                                <input type="date" id="fechaingresonomina" class="form-control" autocomplete="off" placeholder="Fecha de ingreso">
                                <label for="fechaingresonomina" class="form-label">Fecha de ingreso</label>
                            </div>
                        </div>
                        <!-- <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <select name="cargo" id="cargo" class="form-select" placeholder="cargo">

                                        </select>
                                        <label for="cargo" class="form-label">Cargo</label>
                                        <i class="bi bi-plus-circle fs-4 text-primary" role="button" title="Nueva Cargo" data-bs-toggle="modal" data-bs-target="#modal-nuevocargo"></i>
                                    </div>
                                </div> -->

                        <!-- 
                                <div class="row align-items-center g-2 mt-3">
                                    <label for="cargo" class="col-sm-1 col-form-label">Cargo:</label>

                                    <div class="col-sm-5 d-flex align-items-center">
                                        <select name="cargo" id="cargo" class="form-select me-2 filters" required>
                                            <option value="">Seleccione</option>
                                        </select>
                                        <i class="bi bi-plus-circle fs-4 text-primary" role="button" title="Nueva Cargo" data-bs-toggle="modal" data-bs-target="#modal-nuevocargo"></i>
                                    </div>
                                </div>
 -->

                        <div class="col-md-3 mb-3">
                            <div class="form-floating">
                                <input type="text" id="ruc" class="form-control" autocomplete="off" placeholder="Ruc">
                                <label for="ruc" class="form-label">Ruc</label>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="form-floating">
                                <input type="text" id="clavesol" class="form-control" autocomplete="off" placeholder="Clave Sol">
                                <label for="clavesol" class="form-label">Clave Sol</label>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="form-floating">
                                <input type="text" id="ncuenta" class="form-control" autocomplete="off" placeholder="N° Cuenta">
                                <label for="ncuenta" class="form-label">N° Cuenta</label>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <button class="btn btn-primary h-100 " id="btnInformacionPago">
                                Terminar Registro
                            </button>
                        </div>
                    </div>
                </div>
                <!-- <hr>
                    <div class="row">
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary" id="btn-registrar-nomina">Registrar</button>
                        </div>
                    </div> -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-nuevocargo" tabindex="-1" aria-labelledby="moda-nuevocargo" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h1 class="modal-title fs-5" id="moda-nuevocargo">Nueva Cargo</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row justify-content-center">
                            <div class="col-md-12">
                                <div class=" mb-3">
                                    <label for="cargonuevo">Cargo</label>
                                    <input type="text" class="form-control" id="cargonuevo" placeholder="Cargo">
                                </div>
                                <button type="button" class="btn btn-primary w-100" id="btnGuardarNuevoCargo">Guardar</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/nominas/registrar-nomina.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>


</body>

</html>