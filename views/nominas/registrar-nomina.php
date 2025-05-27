<?php require_once '../header.php' ?>

<div class="container-fluid py-4 px-0">
    <div class="row d-flex flex-nowrap">
        <div class="card">
            <div class="card-body">
                <form action="" id="form-registro-gasto">
                    <div class="row g-2 mb-4">
                        <h1 class="fw-bold">Registrar nuevo</h1>
                    </div>
                    <div class="row g-2 mb-4">
                        <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Datos generales</span>
                        </div>
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <div class="form-floating">
                                    <select name="tipo" id="tipo" class="form-select" placeholder="Tipo">
                                        <option value="">Selecciona</option>
                                        <option value="1">Planilla</option>
                                        <option value="2">Contrato</option>
                                    </select>
                                    <label for="tipo" class="form-label">Tipo</label>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="nombreapellido" class="form-control" autocomplete="off">
                                    <label for="nombreapellido" class="form-label">Nombre y Apellidos</label>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="dni" class="form-control" autocomplete="off" placeholder="Dni">
                                    <label for="dni" class="form-label">Dni</label>
                                </div>
                            </div>

                            <div class="col-md-3 mb-3" id="div-evento">
                                <div class="form-floating">
                                    <select name="cargo" id="cargo" class="form-select" placeholder="Cargo">
                                    </select>
                                    <label for="cargo" class="form-label">Cargo</label>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="fnacimiento" class="form-control" autocomplete="off" placeholder="Fecha de nacimiento">
                                    <label for="fnacimiento" class="form-label">Fecha de nacimiento</label>
                                </div>
                            </div>
                        </div>
                        <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Datos Personales</span>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <select name="estadocivil" id="estadocivil" class="form-select" placeholder="Estado Civil">
                                        <option value="">Selecciona</option>
                                        <option value="1">Soltero(a)</option>
                                        <option value="2">Casado(a)</option>
                                        <option value="3">divorciado(a)</option>
                                        <option value="4">Conviviente</option>
                                        <option value="5">viudo(a)</option>
                                    </select>
                                    <label for="estadocivil" class="form-label">Estado Civil</label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <select name="sexo" id="sexo" class="form-select" placeholder="Sexo">
                                        <option value="">Selecciona</option>
                                        <option value="1">Masculino</option>
                                        <option value="2">Femenino</option>
                                    </select>
                                    <label for="sexo" class="form-label">Sexo</label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="domicilio" class="form-control" autocomplete="off" placeholder="Domicilio">
                                    <label for="domicilio" class="form-label">Domicilio</label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="correo" class="form-control" autocomplete="off" placeholder="Correo">
                                    <label for="correo" class="form-label">Correo</label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="nivelestudio" class="form-control" autocomplete="off" placeholder="Nivel de estudio">
                                    <label for="nivelestudio" class="form-label">Nivel de estudio</label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="contactoemergencia" class="form-control" autocomplete="off" placeholder="Contacto de emergencia">
                                    <label for="contactoemergencia" class="form-label">Contacto de emergencia</label>
                                </div>
                            </div>
                        </div>
                        <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Datos generales</span>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="discapacidad" class="form-control" autocomplete="off" placeholder="Discapacidad/Enfermedad">
                                    <label for="discapacidad" class="form-label">Discapacidad/Enfermedad</label>
                                </div>
                            </div>
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
                        </div>
                        <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Información de pago</span>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="ruc" class="form-control" autocomplete="off" placeholder="Ruc">
                                    <label for="ruc" class="form-label">Ruc</label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="clavesol" class="form-control" autocomplete="off" placeholder="Clave Sol">
                                    <label for="clavesol" class="form-label">Clave Sol</label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-floating">
                                    <input type="text" id="ncuenta" class="form-control" autocomplete="off" placeholder="N° Cuenta">
                                    <label for="ncuenta" class="form-label">N° Cuenta</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary" id="btn-registrar-gasto">Registrar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/gastos/registrar-gasto.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>


</body>

</html>