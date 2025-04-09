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
    <form action="" id="form-atencion-clientes">
        <div class="card" style="border-color:rgb(255, 255, 255); box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
            <div class="card-header">
                <h1 id="titulo-registrar-at-clientes">DATOS DE EMPRESA</h1>
                <div class="card-body">
                    <div class="row">
                        <!-- Vista previa del logo + botón subir -->
                        <div class="col-md-4 d-flex flex-column align-items-center">
                            <img id="logo-preview" src="ruta/logo-por-defecto.png" class="img-fluid mb-2 border rounded" style="max-height: 180px; object-fit: contain;">
                            <input type="file" name="logoempresa" id="logoempresa" class="form-control mt-2">
                            <label for="logoempresa" class="form-text text-muted mt-1">Subir imagen</label>
                        </div>

                        <!-- Inputs: ruc, razonsocial, nombrecomercial, direccion -->
                        <div class="col-md-8">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="ruc" class="form-label">RUC</label>
                                    <input type="text" name="ruc" id="ruc" class="form-control" maxlength="11">
                                </div>
                                <div class="col-md-6">
                                    <label for="razonsocial" class="form-label">Razón Social</label>
                                    <input type="text" name="razonsocial" id="razonsocial" class="form-control">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="nombrecomercial" class="form-label">Nombre Comercial</label>
                                    <input type="text" name="nombrecomercial" id="nombrecomercial" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label for="direccion" class="form-label">Dirección</label>
                                    <input type="text" name="direccion" id="direccion" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Inputs en columna -->
                    <div class="row mt-4">
                        <div class="col-md-4 mb-3">
                            <label for="usuariosol" class="form-label">Usuario SOL</label>
                            <input type="text" name="usuariosol" id="usuariosol" class="form-control" maxlength="8">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="clavesol" class="form-label">Clave SOL</label>
                            <input type="password" name="clavesol" id="clavesol" class="form-control" maxlength="12">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="certificado" class="form-label">Certificado</label>
                            <textarea name="certificado" id="certificado" class="form-control" rows="3"></textarea>
                        </div>
                    </div>
                </div>

                <div class="card-footer d-flex justify-content-end">
                    <div class="d-flex gap-2">
                        <button type="button" id="btnActualizarEvento" class="btn btn-primary">
                            <i class="fa-solid fa-floppy-disk px-2"></i>Actualizar</button>
                    </div>
                </div>
            </div>
    </form>
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

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/empresa/actualizar-empresa.js"></script>

</body>

</html>