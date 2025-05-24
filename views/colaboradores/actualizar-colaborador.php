<?php require_once '../header.php' ?>
<!-- <link rel="stylesheet" href="http://localhostOnlyHeader/SIGEMAPRE/css/usuario-register.css"> -->

<div class="row g-0 h-100 mb-3">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header border-0 d-flex justify-content-between align-items-center">
                <h2>Actualizar Colaborador</h2>

                <a id="btnRegresarActualizarUsuario" class="btn btn-outline-primary btn-sm ms-auto m-0" type="button"><i class="fa-solid fa-circle-left"></i> Regresar</a>
            </div>
            <div class="card-body ">
                <h5>Datos de la Persona</h5>
                <form action="" id="form-person-user">
                    <div class="row g-2 mb-4">
                        <div class="col-md-4">
                            <div class="input-group" style="height: 100%;">
                                <input type="text"
                                    style="height: 100%;"
                                    autocomplete="off"
                                    id="num_doc"
                                    placeholder="Num Doc."
                                    pattern="[0-9]*"
                                    class="form-control"
                                    minlength="8"
                                    maxlength="20"
                                    autofocus
                                    title="Ingresa solo números.">

                            </div>
                            <div class="d-flex" style="display: flex;">
                                <span id="showTipoDoc" style="font-size: small; margin-left: auto; margin-right:12%"></span>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="form-floating">
                                <input type="text" autocomplete="off" class="form-control" id="apellidos" minlength="3">
                                <label for="apellidos" class="form-label">Apellidos</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <input type="text" autocomplete="off" class="form-control" id="nombres">
                                <label for="nombres" class="form-label">Nombres</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-floating">
                                <select name="genero" id="genero" class="form-select">
                                    <option value="">Selecciona</option>
                                    <option value="F">Femenino</option>
                                    <option value="M">Masculino</option>
                                </select>
                                <label for="genero" class="form-label">Genero</label>
                            </div>
                        </div>
                    </div>
                    <div class="row g-2 mb-3 mt-1">
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="text" id="direccion" class="form-control" autocomplete="off">
                                <label for="direccion" class="form-label">Direccion</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-floating">
                                <input
                                    type="tel"
                                    autocomplete="off"
                                    class="form-control"
                                    id="telefono1"
                                    pattern="[0-9]+"
                                    maxlength="9"
                                    minlength="9">
                                <label for="telefono1" class="form-label">Telefono</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-floating">
                                <input
                                    type="tel"
                                    autocomplete="off"
                                    class="form-control"
                                    id="telefono2"
                                    pattern="[0-9]+"
                                    maxlength="9"
                                    minlength="9">
                                <label for="telefono2" class="form-label">Telefono 2 (opcional)</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="email" id="correo" class="form-control" autocomplete="off" placeholder="Email (Opcional)">
                                <label for="correo" class="form-label">Email (Opcional)</label>
                            </div>
                        </div>
                    </div>
                    <div class="row g-2 mb-5 mt-3 form-group">
                        <div class="col-md-3">
                            <div class="form-floating">
                                <select name="nacionalidad" id="nacionalidad" class="form-select" ">
                  <option value="">Selecciona</option>
                  <option value=" 31">Peru</option>
                                </select>
                                <label for="nacionalidad" class="form-label">Nacionalidad</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <select name="departamento" id="departamento" class="form-select" ">
                </select>
                <label for=" departamento" class="form-label">Departamento</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <select name="provincia" id="provincia" class="form-select" ">
                </select>
                <label for=" provincia" class="form-label">Provincia</label>
                            </div>
                        </div>
                        <div class="col-md-3 ">
                            <div class="form-floating">
                                <select name="distrito" id="distrito" class="form-select" ">
                </select>
                <label for=" distrito" class="form-label">Distrito</label>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-sm-3 p-3">
                            <button type="button" class="form-control btn btn-primary w-75" id="btnActualizarPersona">
                                Actualizar Datos Persona
                            </button>
                        </div>
                    </div>
                    <hr>
                    <div class="row g-2 mb-3 mt-3 form-group">
                        <h5>Datos de Colaborador</h5>
                        <label for="fechaingreso" class="col-sm-1 form-label size-label mt-3">Fecha ingreso:</label>
                        <div class="col-sm-5">
                            <input type="date" id="fechaingreso" class="form-control" autocomplete="off" required>
                        </div>
                    </div>
                    <div class="row align-items-center g-2 mt-3">
                        <label for="area" class="col-sm-1 col-form-label">Cargo:</label>

                        <div class="col-sm-5 d-flex align-items-center">
                            <select name="area" id="area" class="form-select me-2 filters" required>
                                <option value="">Seleccione</option>
                            </select>
                            <i class="bi bi-plus-circle fs-4 text-primary" role="button" title="Agregar área" title="Nueva Área" data-bs-toggle="modal" data-bs-target="#modal-nuevaarea"></i>
                        </div>
                    </div>
                    <div class="row g-2 mt-3">
                        <label for="responsable" class="col-sm-1 form-label size-label mt-3">Responsable</label>
                        <div class="col-sm-5">
                            <select name="responsable" id="responsable" class="form-select" required>
                            </select>
                        </div>
                    </div>
                    <div class="row g-2 mt-3">
                        <label for="sucursal" class="col-sm-1 form-label size-label mt-3">Sucursal</label>
                        <div class="col-sm-5">
                            <select name="sucursal" id="sucursal" class="form-select" required>
                                <option value="">Selecciona</option>
                            </select>
                        </div>
                    </div>
                    <div class="row g-2 mt-3">
                        <label for="banco" class="col-sm-1 form-label size-label mt-3">Banco</label>
                        <div class="col-sm-5">
                            <select name="banco" id="banco" class="form-select">
                                <option value="">Selecciona</option>
                                <option value="1">BBVA</option>
                                <option value="2">BCP</option>

                            </select>
                        </div>
                    </div>
                    <div class="row g-2 mt-3">
                        <label for="ncuenta" class="col-sm-1 form-label size-label mt-3">N° Cuenta:</label>
                        <div class="col-sm-5">
                            <input type="text" id="ncuenta" class="form-control" autocomplete="off">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-sm-3 p-3">
                            <button type="button" class="form-control btn btn-primary w-75" id="btnActualizarColaborador">
                                Actualizar Datos Colaborador
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-nuevaarea" tabindex="-1" aria-labelledby="modalnuevaarea" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h1 class="modal-title fs-5" id="modalnuevaarea">Nueva Area</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row justify-content-center">
                            <div class="col-md-12">
                                <div class=" mb-3">
                                    <label for="areanueva">Área</label>
                                    <input type="text" class="form-control" id="areanueva" placeholder="Área">
                                </div>
                                <button type="button" class="btn btn-primary w-100" id="btnGuardarNuevaArea">Guardar</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once '../footer.php' ?>
<script src="<?= $hostOnlyHeader ?>/js/colaboradores/actualizar-colaborador.js"></script>
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>
</body>

</html>