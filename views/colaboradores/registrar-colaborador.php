<?php require_once '../header.php' ?>

<div class="container-fluid py-4 px-0">
    <div class="row d-flex flex-nowrap">
        <div class="card">
            <div class="card-body">
                <div class="row g-2 mb-4">
                    <h1 class="fw-bold">Registrar Colaborador</h1>
                </div>
                <div class="row g-2 mb-4">
                    <!-- <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Datos generales</span>
                        </div> -->
                    <hr>
                    <div class="row">
                        <div class="row mb-4">
                            <button class="btn btn-primary w-100" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseDatosGenerales" aria-expanded="false" aria-controls="collapseDatosGenerales">
                                Datos Generales y Personales
                            </button>
                        </div>
                        <div class="collapse show" id="collapseDatosGenerales">
                            <div class="row">
                                <!-- Inputs en dos columnas -->
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="text" id="nombreapellido" class="form-control" placeholder="Nombre y Apellidos">
                                                <label for="nombreapellido">Nombre y Apellidos</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="text" id="dni" class="form-control" placeholder="DNI">
                                                <label for="dni">DNI</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="date" id="fnacimiento" class="form-control" placeholder="Fecha de nacimiento">
                                                <label for="fnacimiento">Fecha de nacimiento</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <select name="estadocivil" id="estadocivil" class="form-select">
                                                    <option value="">Selecciona</option>
                                                    <option value="1">Soltero(a)</option>
                                                    <option value="2">Casado(a)</option>
                                                    <option value="4">Divorciado(a)</option>
                                                    <option value="5">Conviviente</option>
                                                    <option value="6">Viudo(a)</option>
                                                </select>
                                                <label for="estadocivil">Estado Civil</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <select name="sexo" id="sexo" class="form-select">
                                                    <option value="">Selecciona</option>
                                                    <option value="M">Masculino</option>
                                                    <option value="F">Femenino</option>
                                                </select>
                                                <label for="sexo">Sexo</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="text" id="domicilio" class="form-control" placeholder="Domicilio">
                                                <label for="domicilio">Domicilio</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="text" id="correo" class="form-control" placeholder="Correo">
                                                <label for="correo">Correo</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="text" id="nivelestudio" class="form-control" placeholder="Nivel de estudio">
                                                <label for="nivelestudio">Nivel de estudio</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="text" id="contactoemergencia" class="form-control" placeholder="Contacto de emergencia">
                                                <label for="contactoemergencia">Contacto de emergencia</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="text" id="discapacidad" class="form-control" placeholder="Discapacidad">
                                                <label for="discapacidad">Discapacidad</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Imagen a la derecha -->
                                <div class="col-md-4 d-flex flex-column align-items-center justify-content-start">
                                    <div class="border mb-3" style="height: 80%; width: 90%; max-width: 250px; aspect-ratio: 1/1; background-color: #f0f0f0;">
                                        <img id="previewImagenColaborador" src="https://res.cloudinary.com/dynpy0r4v/image/upload/v1717209573/desconocido_wzzhyk.jpg" class="img-fluid h-100 w-100 object-fit-contain" alt="Vista previa de la foto">
                                    </div>

                                    <div id="div-subirfoto">
                                        <input type="file" id="upload_widget_colaborador" class="d-none" accept="image/*">
                                        <label for="upload_widget_colaborador" class="btn btn-dark w-100 text-center">
                                            Subir Foto
                                        </label>
                                    </div>
                                </div>

                                <!-- Botón de continuar -->
                                <div class="col-md-12 mt-4">
                                    <button class="btn btn-primary w-100" id="btnDatosGenerales">
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
                                <button type="button" class="btn btn-warning w-100" id="btnGuardarNuevoCargo">Guardar</button>
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
<script src="<?= $hostOnlyHeader ?>/js/colaboradores/registrar-colaborador.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>


</body>

</html>