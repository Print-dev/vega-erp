<?php require_once '../header.php' ?>

<div class="container-fluid py-4 px-0">
    <div class="row d-flex flex-nowrap">
        <div class="card">
            <div class="card-body">
                <div class="row g-2 mb-4">
                    <h1 class="fw-bold">Actualizar Nómina</h1>
                </div>
                <div class="row g-2 mb-4">
                    <!-- <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Datos generales</span>
                        </div> -->
                    <hr>

                    <div class="row">
                        <div class="row mb-4">

                            <button class="btn btn-primary w-100" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDatosGenerales" aria-expanded="false" aria-controls="collapseDatosGenerales">
                                Datos Generales y Personales
                            </button>

                        </div>
                        <div class="collapse show" id="collapseDatosGenerales">
                            <div class="row"> <!-- Esta fila agrupa las columnas correctamente -->
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="nombreapellido" class="form-control" autocomplete="off" placeholder="Nombre y Apellidos" autofocus>
                                        <label for="nombreapellido" class="form-label">Nombre y Apellidos</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="dni" class="form-control" autocomplete="off" placeholder="Dni">
                                        <label for="dni" class="form-label">Dni</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <input type="date" id="fnacimiento" class="form-control" autocomplete="off" placeholder="Fecha de nacimiento">
                                        <label for="fnacimiento" class="form-label">Fecha de nacimiento</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <select name="estadocivil" id="estadocivil" class="form-select" placeholder="Estado Civil">
                                            <option value="">Selecciona</option>
                                            <option value="1">Soltero(a)</option>
                                            <option value="2">Casado(a)</option>
                                            <option value="4">Divorciado(a)</option>
                                            <option value="5">Conviviente</option>
                                            <option value="6">Viudo(a)</option>
                                        </select>
                                        <label for="estadocivil" class="form-label">Estado Civil</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <select name="sexo" id="sexo" class="form-select" placeholder="Sexo">
                                            <option value="">Selecciona</option>
                                            <option value="M">Masculino</option>
                                            <option value="F">Femenino</option>
                                        </select>
                                        <label for="sexo" class="form-label">Sexo</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="domicilio" class="form-control" autocomplete="off" placeholder="Domicilio">
                                        <label for="domicilio" class="form-label">Domicilio</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="correo" class="form-control" autocomplete="off" placeholder="Correo">
                                        <label for="correo" class="form-label">Correo</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="nivelestudio" class="form-control" autocomplete="off" placeholder="Nivel de estudio">
                                        <label for="nivelestudio" class="form-label">Nivel de estudio</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="contactoemergencia" class="form-control" autocomplete="off" placeholder="Contacto de emergencia">
                                        <label for="contactoemergencia" class="form-label">Contacto de emergencia</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="discapacidad" class="form-control" autocomplete="off" placeholder="Discapacidad">
                                        <label for="discapacidad" class="form-label">Discapacidad</label>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <button class="btn btn-primary h-100 " id="btnDatosGenerales">
                                        Continuar
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- <div class="row">

                        </div> -->
                    <!-- <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Datos Personales</span>
                        </div> -->
                    <hr>

                    <div class="row">
                        <div class="row mb-4">

                            <button class="btn btn-primary w-100" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDatosFisicos" aria-expanded="false" aria-controls="collapseDatosFisicos">
                                Datos Físico
                            </button>

                        </div>
                        <div class="collapse" id="collapseDatosFisicos">
                            <div class="row"> <!-- Esta fila agrupa las columnas correctamente -->
                                <!-- <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <input type="date" id="fechaingreso" class="form-control" autocomplete="off" placeholder="Fecha de ingreso">
                                        <label for="fechaingreso" class="form-label">Fecha de ingreso</label>
                                    </div>
                                </div> -->
                                <div class="col-md-4 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="camisa" class="form-control" autocomplete="off" placeholder="Camisa/Casaca">
                                        <label for="camisa" class="form-label">Camisa/Casaca</label>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="pantalon" class="form-control" autocomplete="off" placeholder="Pantalón">
                                        <label for="pantalon" class="form-label">Pantalón</label>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <div class="form-floating">
                                        <input type="text" id="zapatos" class="form-control" autocomplete="off" placeholder="Zapatos">
                                        <label for="zapatos" class="form-label">Zapatos</label>
                                    </div>
                                </div>

                                <div class="col-md-3 mb-3">
                                    <button class="btn btn-primary h-100 " id="btnDatosFisicos">
                                        Continuar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr>
                    <div class="row">
                        <div class="row mb-4">
                            <button class="btn btn-primary w-100" type="button" data-bs-toggle="collapse" data-bs-target="#collapseInformacionPago" aria-expanded="false" aria-controls="collapseInformacionPago">
                                Información de Planilla / Pago
                            </button>
                        </div>
                        <div class="collapse" id="collapseInformacionPago">
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
                                <div class="col-md-3 mb-3">
                                    <div class="form-floating">
                                        <select name="cargo" id="cargo" class="form-select" placeholder="cargo">

                                        </select>
                                        <label for="cargo" class="form-label">Cargo</label>
                                        <i class="bi bi-plus-circle fs-4 text-primary" role="button" title="Nueva Cargo" data-bs-toggle="modal" data-bs-target="#modal-nuevocargo"></i>
                                    </div>
                                </div>

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
<script src="<?= $hostOnlyHeader ?>/js/nominas/actualizar-nomina.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>


</body>

</html>