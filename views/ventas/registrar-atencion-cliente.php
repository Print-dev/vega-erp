<?php require_once '../header.php' ?>

<style>
    #titulo-registrar-at-clientes {
        font-family: "Outfit", serif;
        font-weight: 400;
        font-style: normal;
        font-size: 30px;
    }
</style>

<div class="container-fluid ">
    <form action="" id="form-atencion-clientes">
        <div class="card" style="border-color:rgb(247, 247, 242); box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
            <div class="card-header">
                <h1 id="titulo-registrar-at-clientes">REGISTRAR ATENCION CLIENTE</h1>
                <div class="card-body">
                    <div class="row">
                        <div class="card-body row g-2">
                            <h1 class="card-title">Datos de cliente</h1>
                            <!-- <div class="col-md-2">
                                <div class="input-group" style="height: 100%;">
                                    <input type="text"
                                        style="height: 100%;"
                                        autocomplete="off"
                                        id="ndocumento"
                                        placeholder="Nª Documento / RUC."
                                        class="form-control"


                                        autofocus>
                                    <span class="input-group-text btn-primary" style="cursor: pointer;" id="search">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </span>
                                </div>
                                <div class="d-flex" style="display: flex;">
                                    <span id="showTipoDoc" style="font-size: small; margin-left: auto; margin-right:12%"></span>
                                </div>
                            </div> -->
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="text" id="ndocumento" name="ndocumento"
                                        class="form-control" placeholder="Nª Documento / RUC.">
                                    <label for="ndocumento" class="form-label">Nª Documento / RUC.</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <input type="text" id="razonsocial" name="razonsocial"
                                        class="form-control">
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
                                        class="form-control">
                                    <label for="telefono" class="form-label">Telefono</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="text" id="correo" name="correo"
                                        class="form-control">
                                    <label for="correo" class="form-label">Correo</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="nacionalidad" id="nacionalidad" class="form-select">
                                        <option value="" selected>Selecciona</option>
                                        <option value="31">Peruana</option>
                                    </select>
                                    <label for="nacionalidad" class="form-label">Nacionalidad</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="departamento" id="departamento" class="form-select">
                                    </select>
                                    <label for="departamento" class="form-label">Departamento</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select name="provincia" id="provincia" class="form-select">
                                    </select>
                                    <label for="provincia" class="form-label">Provincia</label>
                                </div>
                            </div>
                            <div class="col-md-3 ">
                                <div class="form-floating">
                                    <select name="distrito" id="distrito" class="form-select">
                                    </select>
                                    <label for="distrito" class="form-label">Distrito</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" id="direccion" name="direccion"
                                        class="form-control">
                                    <label for="direccion" class="form-label">Direccion</label>
                                </div>
                            </div>

                        </div>
                        <div class="card-footer border-0">
                            <div class="text-start">
                                <button type="button" class="btn btn-primary" id="btnBuscarCliente">Buscar</button>
                            </div>
                        </div>
                        <div class="card-body  row g-2 ">
                            <hr>
                            <h1 class="card-title">Datos de evento</h1>

                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="artista" id="artista" class="form-select">
                                    </select>
                                    <label for="artista" class="form-label">Artista</label>
                                </div>
                            </div>
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
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="modalidad" id="modalidad" class="form-select">
                                        <option value="-1">Selecciona</option>
                                        <option value="1">Convenio</option>
                                        <option value="2">Contrato</option>
                                    </select>
                                    <label for="modalidad" class="form-label">Modalidad</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="modotransporte" id="modotransporte" class="form-select">
                                        <option value="1">Tierra</option>
                                        <option value="2">Vuelo</option>
                                    </select>
                                    <label for="modotransporte" class="form-label">Modo Transporte</label>
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
                        <button type="submit" id="btnGuardarAC" class="btn btn-primary">
                            <i class="fa-solid fa-floppy-disk px-2"></i>Guardar</button>
                        <button type="button" id="btnLimpiarAC" class="btn btn-primary">
                            <i class="fa-solid fa-eraser px-2"></i>Limpiar</button>
                        <a href="<?= $hostOnlyHeader ?>/views/ventas/listar-atencion-cliente" id="btnRegresarAC" class="btn btn-primary">
                            <i class="fa-solid fa-circle-left px-2"></i>Regresar</a>
                        <button class="btn btn-primary" type="button" id="btnConsultarFecha">
                            <i class="fa-solid fa-magnifying-glass"></i> Consultar fechas reservadas</button>
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


<!-- MODAL PARA CONTRATO CONVENIO -->
<!-- <div class="modal fade" id="modal-convenio" tabindex="-1" aria-labelledby="modalContratoConvenio" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalContratoConvenio">Previa Convenio</h1>
                <a href="<?= $hostOnlyHeader ?>/views/ventas/listar-atencion-cliente" class="btn-close"></a>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row g-2">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="number" id="abonogarantia" name="abonogarantia"
                                        class="form-control">
                                    <label for="abonogarantia" class="form-label">Abono de garantía</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="number" id="abonopublicidad" name="abonopublicidad"
                                        class="form-control">
                                    <label for="abonopublicidad" class="form-label">Abono de publicidad</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 mt-3">
                            <div class="mb-3">
                                <label for="propuestacliente" class="form-label">Propuesta de cliente</label>
                                <textarea class="form-control" id="propuestacliente" rows="3"></textarea>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="btnGenerarConvenio">Generar Convenio</button>
                <button type="button" class="btn btn-primary btnGuardarConvenio" id="close-mdl-convenio">Guardar y cerrar</button>
            </div>
        </div>
    </div>
</div>
 -->


<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/ventas/cotizar.js"></script>

</body>

</html>