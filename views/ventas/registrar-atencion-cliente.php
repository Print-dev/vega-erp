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
    <div class="card">
        <div class="card-body">
            <div class="row ">
                <h1 id="titulo-registrar-at-clientes">REGISTRAR ATENCION CLIENTE</h1>
                <div class="row">
                    
                    <div class="card-body p-4 row g-2 ">
                    <div class="col-md-5">
                            <div class="input-group mb-3">
                                <div class="form-floating flex-grow-1">
                                    <input type="text" id="ndocumento" class="form-control" placeholder="Nº Documento / RUC">
                                    <label for="ndocumento">Nº Documento / RUC</label>
                                </div>
<!--                                 <button class="btn btn-primary" type="button" id="button-addon2">Buscar</button>
 -->                            </div>
                        </div>

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
        <div class="card-footer d-flex justify-content-end">
            <div class="d-flex gap-2">
                <button type="button" id="btnGuardarAC" class="btn btn-primary">Guardar</button>
                <button type="button" id="btnLimpiarAC" class="btn btn-primary">Limpiar</button>
                <button type="button" id="btnRegresarAC" class="btn btn-primary">Regresar</button>
            </div>
        </div>
    </div>
</div>

<?php require_once '../footer.php' ?>