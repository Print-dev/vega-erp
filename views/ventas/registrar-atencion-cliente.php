<?php require_once '../header.php' ?>

<style>
    #titulo-registrar-at-clientes {
        font-family: "Outfit", serif;
        font-weight: 400;
        font-style: normal;
        font-size: 30px;
    }
</style>

<div class="container-fluid mt-5">
    <div class="card" style="border-color:rgb(247, 247, 242); box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
-webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
-moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row ">
                <h1 id="titulo-registrar-at-clientes">REGISTRAR ATENCION CLIENTE</h1>
                <div class="row">

                    <div class="card border-0">
                        <div class="card-header border-0">
                            <div class="col-md-5">
                                <label for="razonsocial" class="form-label">N° Documento / RUC</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="ndocumento" aria-label="ndocumento" aria-describedby="button-addon2">
                                    <button class="btn btn-primary" type="button" id="btnBuscarCliente">Buscar</button>
                                </div>

                            </div>
                        </div>
                        <div class="card-body p-4 row g-2 ">
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="artista" id="artista" class="form-select">
                                        <option value="">Selecciona</option>
                                    </select>
                                    <label for="artista" class="form-label">Artista</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="date" class="form-control" id="fechaevento" autocomplete="off">
                                    <label for="fechaevento" class="form-label">Fecha de evento</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="date" class="form-control" id="fechaevento2" autocomplete="off">
                                    <label for="fechaevento2" class="form-label">Fecha de evento 2</label>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" id="razonsocial" name="razonsocial"
                                        class="form-control">
                                    <label for="razonsocial" class="form-label">Razon social/Nombre</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="number" id="telefono" name="telefono" maxlength="9" max="9"
                                        class="form-control">
                                    <label for="telefono" class="form-label">Telefono</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="departamento" id="departamento" class="form-select">
                                        <option value="">Selecciona</option>
                                    </select>
                                    <label for="departamento" class="form-label">Departamento</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="provincia" id="provincia" class="form-select">
                                        <option value="">Selecciona</option>
                                    </select>
                                    <label for="provincia" class="form-label">Provincia</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="distrito" id="distrito" class="form-select">
                                        <option value="">Selecciona</option>
                                    </select>
                                    <label for="distrito" class="form-label">Distrito</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="modalidad" id="modalidad" class="form-select">
                                        <option value="">Selecciona</option>
                                        <option value="">Convenio</option>
                                        <option value="">Contrato</option>
                                    </select>
                                    <label for="modalidad" class="form-label">Modalidad</label>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="time" id="tiempopresentacion" name="tiempopresentacion"
                                        class="form-control">
                                    <label for="tiempopresentacion" class="form-label">Tiempo de presentacion</label>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input type="text" id="establecimiento" name="establecimiento"
                                        class="form-control">
                                    <label for="establecimiento" class="form-label">Establecimiento</label>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-floating">
                                    <select name="tipoevento" id="tipoevento" class="form-select">
                                        <option value="">Selecciona</option>
                                        <option value="">Publico</option>
                                        <option value="">Privado</option>
                                    </select>
                                    <label for="tipoevento" class="form-label">Tipo evento</label>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-floating">
                                    <input type="number" id="validez" name="validez"
                                        class="form-control">
                                    <label for="validez" class="form-label">Dias de validez</label>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="card-footer d-flex justify-content-end">
            <div class="d-flex gap-2">
                <button type="button" id="btnGuardarAC" class="btn btn-primary">
                    <i class="fa-solid fa-floppy-disk px-2"></i>Guardar y cotizar</button>
                <button type="button" id="btnLimpiarAC" class="btn btn-primary">
                    <i class="fa-solid fa-eraser px-2"></i>Limpiar</button>
                <a href="http://localhost/vega-erp/views/ventas/listar-atencion-cliente" id="btnRegresarAC" class="btn btn-primary">
                    <i class="fa-solid fa-circle-left px-2"></i>Regresar</a>
            </div>
        </div>
    </div>
</div>

<!-- MODAL PARA COTIZAR -->
<div class="modal fade" id="modal-choose-especificacion" tabindex="-1" aria-labelledby="modalPreviaCotizacion" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="modalPreviaCotizacion">Previa Cotizacion</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close-mdl-cotizacion">Cerrar</button>
        <button type="button" class="btn btn-primary" id="btnGenerarCotizacion">Generar Cotizacion</button>
      </div>
    </div>
  </div>
</div>

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="http://localhost/vega-erp/js/ventas/cotizar.js"></script>

</body>
</html>