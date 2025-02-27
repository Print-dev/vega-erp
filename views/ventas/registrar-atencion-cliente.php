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

                        <div class="col-md-4">
                            <div class="input-group" style="height: 100%;">
                                <input type="text"
                                style="height: 100%;"
                                autocomplete="off"
                                id="ndocumento"
                                placeholder="Nª Documento / RUC."
                                pattern="[0-9]*"
                                class="form-control"
                                minlength="8"
                                maxlength="20"
                                required
                                autofocus
                                title="Ingresa solo números.">
                                <span class="input-group-text btn-primary" style="cursor: pointer;" id="search">
                                <i class="fa-solid fa-magnifying-glass"></i>
                                </span>
                            </div>
                            <div class="d-flex" style="display: flex;">
                                <span id="showTipoDoc" style="font-size: small; margin-left: auto; margin-right:12%"></span>
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
                                <input type="text" id="correo" name="correo"
                                    class="form-control">
                                <label for="correo" class="form-label">Correo</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                            <select name="nacionalidad" id="nacionalidad" class="form-select" required">    
                                <option value="">Selecciona</option>
                                <option value="31">Peru</option>
                            </select>
                            <label for="nacionalidad" class="form-label">Nacionalidad</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                            <select name="departamento" id="departamento" class="form-select" required">    
                            </select>
                            <label for="departamento" class="form-label">Departamento</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                            <select name="provincia" id="provincia" class="form-select" required">    
                            </select>
                            <label for="provincia" class="form-label">Provincia</label>
                            </div>
                        </div>
                        <div class="col-md-3 ">
                            <div class="form-floating">
                            <select name="distrito" id="distrito" class="form-select" required">    
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
                    <div class="card-body  row g-2 ">
                        <hr>
                        <h1 class="card-title">Datos de evento</h1>

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
                                <input type="time" id="horapresentacion" name="horapresentacion"
                                    class="form-control">
                                <label for="horapresentacion" class="form-label">Hora de presentacion</label>
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
                                <input type="number" id="validez" name="validez"
                                    class="form-control">
                                <label for="validez" class="form-label">Dias de validez</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                            <select name="nacionalidad2" id="nacionalidad2" class="form-select" required">    
                                <option value="">Selecciona</option>
                                <option value="31">Peru</option>
                            </select>
                            <label for="nacionalidad2" class="form-label">Nacionalidad</label>
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
                            <input class="form-check-input" type="checkbox" value="" id="igv">
                            <label class="form-check-label" for="igv">
                                IGV incluido
                            </label>
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
    </form>
</div>

<!-- MODAL PARA COTIZAR -->
<div class="modal fade" id="modal-previacotizacion" tabindex="-1" aria-labelledby="modalPreviaCotizacion" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalPreviaCotizacion">Previa Cotizacion</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table rounded">
                    <thead class="table-dark">
                        <tr>
                            <th>Departamento</th>
                            <th>Provincia</th>
                            <th>Dificultad</th>
                            <th>Precio S/.</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Ica</td>
                            <td>Chincha</td>
                            <td>Alta</td>
                            <td>2000</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"   id="btnGenerarCotizacion">Generar Cotizacion</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="close-mdl-cotizacion">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="http://localhost/vega-erp/js/ventas/cotizar.js"></script>

</body>

</html>