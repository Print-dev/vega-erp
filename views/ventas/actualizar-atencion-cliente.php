<?php require_once '../header.php' ?>

<div class="container-fluid ">
    <form action="" id="form-atencion-clientes">
        <div class="card" style="border-color:rgb(247, 247, 242); box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
            <div class="card-header">
                <h1 id="titulo-registrar-at-clientes">ACTUALIZAR DATOS DE EVENTO</h1>
                <div class="card-body">
                    <div class="row">                        
                        <div class="card-body  row g-2 ">                            
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="date" class="form-control" id="fechapresentacion" autocomplete="off">
                                    <label for="fechapresentacion" class="form-label">Fecha de evento</label>
                                </div>

                            </div>

                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="time" id="horainicio" name="horainicio"
                                        class="form-control">
                                    <label for="horainicio" class="form-label">Hora de inicio</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="time" id="horafinal" name="horafinal"
                                        class="form-control">
                                    <label for="horafinal" class="form-label">Hora Final</label>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input type="text" id="establecimiento" name="establecimiento"
                                        class="form-control" autocomplete="off">
                                    <label for="establecimiento" class="form-label">Establecimiento</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <textarea class="form-control" id="referencia" rows="3"></textarea>
                                    <label for="referencia" class="form-label">Referencia</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="tipoevento" id="tipoevento" class="form-select">
                                        <option value="">Selecciona</option>
                                        <option value="1">Publico</option>
                                        <option value="2">Privado</option>
                                    </select>
                                    <label for="tipoevento" class="form-label">Tipo evento</label>
                                </div>
                            </div>                            
                            <div class="col-md-2" id="container-validez">
                                <div class="form-floating">
                                    <input type="number" id="validez" name="validez"
                                        class="form-control">
                                    <label for="validez" class="form-label">Dias de validez/Vigencia</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="nacionalidad2" id="nacionalidad2" class="form-select" ">
                                        <option value="">Selecciona</option>
                                        <option value=" 31">Peru</option>
                                    </select>
                                    <label for="nacionalidad2" class="form-label">País</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="departamento2" id="departamento2" class="form-select">
                                        <option value="">Selecciona</option>
                                    </select>
                                    <label for="departamento2" class="form-label">Departamento</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="provincia2" id="provincia2" class="form-select">
                                        <option value="">Selecciona</option>
                                    </select>
                                    <label for="provincia2" class="form-label">Provincia</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="distrito2" id="distrito2" class="form-select">
                                        <option value="">Selecciona</option>
                                    </select>
                                    <label for="distrito2" class="form-label">Distrito</label>
                                </div>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="igv">
                                <label class="form-check-label" for="igv">
                                    IGV incluido
                                </label>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-end">
                    <div class="d-flex gap-2">
                        <button type="button" id="btnActualizarEvento" class="btn btn-primary">
                            <i class="fa-solid fa-floppy-disk px-2"></i>Actualizar</button>                        
                        <a href="<?= $hostOnlyHeader ?>/views/ventas/listar-atencion-cliente" id="btnRegresarAC" class="btn btn-primary">
                            <i class="fa-solid fa-circle-left px-2"></i>Regresar</a>
                       
                    </div>
                </div>
            </div>
    </form>
</div>


<!-- MODAL PARA COTIZAR DE MANERA CONTRATO -->
<div class="modal fade" id="modal-fechasagenda" tabindex="-1" aria-labelledby="modalfechasagenda" aria-hidden="true">
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
</div>

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/ventas/actualizar-evento.js"></script> 

</body>

</html>