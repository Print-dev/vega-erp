<?php require_once '../../header.php' ?>
<!-- <link rel="stylesheet" href="http://localhostOnlyHeader/SIGEMAPRE/css/usuario-register.css"> -->

<div class="row g-0 h-100 mb-3">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header border-0 d-flex justify-content-between align-items-center">
                <h2>Actualizar Cliente</h2>

                <a href="<?= $hostOnlyHeader ?>/views/utilitario/clientes/listar-clientes" class="btn btn-outline-primary btn-sm ms-auto m-0" type="button"><i class="fa-solid fa-circle-left"></i> Regresar</a>
            </div>
            <div class="card-body ">
                <form action="" id="form-cliente">
                    <div class="row g-2 mb-4">
                        <div class="card-body row g-2">
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="text" id="ndocumento" name="ndocumento"
                                        class="form-control" placeholder="Nª Documento / RUC." >
                                    <label for="ndocumento" class="form-label">Nª Documento / RUC.</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <input type="text" id="razonsocial" name="razonsocial"
                                        class="form-control" >
                                    <label for="razonsocial" class="form-label">Razon social/Nombre</label>
                                </div>
                            </div>
                            <div class="col-md-3" id="container-representantelegal" hidden>
                                <div class="form-floating">
                                    <input type="text" id="representantelegal" name="representantelegal"
                                        class="form-control">
                                    <label for="representantelegal" class="form-label">Representante legal</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="number" id="telefono" name="telefono" maxlength="9"
                                        class="form-control" >
                                    <label for="telefono" class="form-label">Telefono</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="text" id="correo" name="correo"
                                        class="form-control" >
                                    <label for="correo" class="form-label">Correo</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="nacionalidad" id="nacionalidad" class="form-select" >
                                        <option value="" selected>Selecciona</option>
                                        <option value="31">Peruana</option>
                                    </select>
                                    <label for="nacionalidad" class="form-label">Nacionalidad</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="departamento" id="departamento" class="form-select" >
                                    </select>
                                    <label for="departamento" class="form-label">Departamento</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="provincia" id="provincia" class="form-select" >
                                    </select>
                                    <label for="provincia" class="form-label">Provincia</label>
                                </div>
                            </div>
                            <div class="col-md-3 ">
                                <div class="form-floating">
                                    <select name="distrito" id="distrito" class="form-select" >
                                    </select>
                                    <label for="distrito" class="form-label">Distrito</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" id="direccion" name="direccion"
                                        class="form-control" >
                                    <label for="direccion" class="form-label">Direccion</label>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-2">
                            <button type="submit" class="form-control btn btn-primary" id="btnEnviar">
                                Actualizar
                            </button>
                        </div>
                       
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>
</div>
<?php require_once '../../footer.php' ?>
<script src="<?= $hostOnlyHeader ?>/js/clientes/actualizar-cliente.js"></script>
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>
</body>

</html>