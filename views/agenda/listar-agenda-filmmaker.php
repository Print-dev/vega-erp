<?php require_once '../header.php' ?>

<div class="row g-0 mb-3 contenedor-filtros-agenda">
    <div class="card border-0">
        <div class="card-body border-0">
            <label for="">Filtros</label>
            <div class="row ">
                <!-- <div class="col-md-2 mb-3">
                    <div class="form-floating">
                        <select name="nivelacceso" id="nivelacceso" class="form-select" required>
                        </select>
                        <label for="nivelacceso" class="form-label">Nivel/Rol</label>
                    </div>
                </div> -->
                <div class="col-md-2 contenedor-select-tipo-filtro-edicion" hidden>
                    <div class="form-floating">
                        <select name="tipofiltroedicion" id="tipofiltroedicion" class="form-select" required>
                            <option value="1" selected>Todas las Agendas</option>
                            <option value="2">Por Usuario</option>
                        </select>
                        <label for="tipofiltroedicion" class="form-label">Tipo Filtro</label>
                    </div>
                </div>
                <div class="col-md-2 contenedor-select-usuario">
                    <div class="form-floating">
                        <select name="usuario" id="usuario" class="form-select" required>
                        </select>
                        <label for="usuario" class="form-label">Usuario</label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="contenedor-calendario">
    <div id='calendar'></div>

</div>

<div class="modal fade" id="modal-viatico" tabindex="-1" aria-labelledby="modalviatico" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalviatico">Reportar Viático</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-info-agenda">
                    <div class="container-fluid">
                        <div class="row g-3 align-items-center">
                            <div class="row g-3 align-items-center">
                                <div class="col-md-4 text-end">
                                    <label for="pasaje" class="form-label">Pasaje:</label>
                                </div>
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <span class="input-group-text">S/.</span>
                                        <input type="number" id="pasaje" name="pasaje" class="form-control">
                                    </div>
                                </div>
                            </div>

                            <div class="row g-3 align-items-center">
                                <div class="col-md-4 text-end">
                                    <label for="comida" class="form-label">Comida:</label>
                                </div>
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <span class="input-group-text">S/.</span>
                                        <input type="number" id="comida" name="comida" class="form-control">
                                    </div>
                                </div>
                            </div>

                            <div class="row g-3 align-items-center contenedor-viatico-viaje">
                                <div class="col-md-4 text-end">
                                    <label for="viaje" class="form-label">Viatico de viaje:</label>
                                </div>
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <span class="input-group-text">S/.</span>
                                        <input type="number" id="viaje" name="viaje" class="form-control">
                                    </div>
                                </div>
                            </div>



                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer text-end">
                <button class="btn btn-info" id="btnActualizarViatico" hidden>Actualizar</button>
                <button class="btn btn-primary" id="btnGuardarViatico">Guardar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-infoagendaartista" tabindex="-1" aria-labelledby="modalinfoagendaartista" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalinfoagendaartista">Detalles agenda</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-info-agenda p-3">

                </div>
            </div>
            <div class="modal-footer">
                <!-- <button type="button" class="btn btn-secondary" id="btnActualizarDatos">Actualizar Datos</button>
                <button type="button" class="btn btn-primary btnGuardarContrato" id="close-mdl-datoscliente" data-bs-dismiss="modal">Cerrar</button> -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-acuerdo" tabindex="-1" aria-labelledby="modalacuerdo" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalacuerdo">Acuerdo</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-acuerdo-agenda p-3">
                    <textarea name="acuerdo" id="acuerdo" class="form-control"></textarea>
                </div>
            </div>
            <div class="modal-footer text-end">
                <button type="button" class="btn btn-secondary" id="btnGuardarAcuerdo">Guardar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-monto" tabindex="-1" aria-labelledby="modalmonto" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalmonto">Monto</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-monto p-3">

                </div>
            </div>
            <div class="modal-footer text-end">
                <button type="button" class="btn btn-secondary" id="btnGuardarAcuerdo">Guardar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-filmmaker" tabindex="-1" aria-labelledby="modalfilmmaker" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalfilmmaker">Asignar Filmmaker</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-filmmaker p-3">
                    <div class="form-floating">
                        <select name="filmmaker" id="filmmaker" class="form-select">
                        </select>
                        <label for="filmmaker" class="form-label">Filmmaker</label>
                    </div>
                </div>
            </div>
            <div class="modal-footer text-end">
                <button type="button" class="btn btn-secondary" id="btnGuardarFilmmaker">Asignar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-asignareditor" tabindex="-1" aria-labelledby="modalasignareditor" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalasignareditor">Asignar Editor</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-asignacion p-3">
                    <div class="row g-3 align-items-center justify-content-center">
                        <div class="col-md-4">
                            <div class="form-floating">
                                <select name="asignacion" id="asignacion" class="form-select">
                                </select>
                                <label for="asignacion" class="form-label">Seleccionar Editor</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <select name="tipotarea" id="tipotarea" class="form-select">
                                    <option value="-1">Seleccione</option>
                                    <option value="1">Flayer</option>
                                    <option value="2">Saludos</option>
                                    <option value="3">Reels</option>
                                    <option value="4">Fotos</option>
                                    <option value="5">Contenido</option>
                                </select>
                                <label for="tipotarea" class="form-label">Tarea</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input type="date" id="fechaentrega" name="fechaentrega" class="form-control">
                                <label for="fechaentrega" class="form-label">Fecha de Entrega</label>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="table-responsive d-flex justify-content-center">
                        <table class="table table-striped table-hover text-center align-middle w-auto mx-auto" id="table-tarifarios">
                            <thead class="table-dark">
                                <tr>
                                <th>Flayer</th>
                                <th>Saludos</th>
                                <th>Reels</th>
                                <th>Fotos</th>  
                                <th>Contenido</th>  
                                </tr>
                            </thead>
                            <tbody class="contenedor-asignados">
                                                     
                            </tbody>
                        </table>
                    </div>                    
                </div>
            </div>
            <div class="modal-footer text-end">
                <button type="button" class="btn btn-secondary" id="btnGuardarAsignacion">Asignar</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="modal-progresoedicion" tabindex="-1" aria-labelledby="modalprogresoedicion" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalprogresoedicion">Progreso edicion</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-progreso p-3">                    
                    <div class="table-responsive d-flex justify-content-center">
                        <table class="table table-striped table-hover text-center align-middle w-auto mx-auto" id="table-tarifarios">
                            <thead class="table-dark">
                                <tr>
                                <th>Fecha</th>
                                <th>Usuario</th>
                                <th>Tipo Tarea</th>
                                <th>Estado</th>  
                                <th>Subidas</th>  
                                </tr>
                            </thead>
                            <tbody class="contenedor-tareas-edicion-pendientes">
                                                           
                            </tbody>
                        </table>
                    </div>                    
                </div>
            </div>           
        </div>
    </div>
</div>

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<!-- Importar idioma español -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/es.js"></script>

<!-- <script>
    const idusuarioLogeado = "<?php echo $_SESSION['login']['idusuario']; ?>"
    const nivelacceso = "<?php echo $_SESSION['login']['nivelacceso']; ?>"
</script> -->

<script src="http://localhost/vega-erp/js/agenda/obtencion-agenda-nivel.js"></script> 
<script src="http://localhost/vega-erp/js/agenda/listar-agenda-filmmaker.js"></script> 

</body>

</html>