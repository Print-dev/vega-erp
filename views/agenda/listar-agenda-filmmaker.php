<?php require_once '../header.php' ?>

<style>
    /* Evita que el texto de la tarea sea opacado por el bloque */
    .fc .fc-daygrid-event {
        padding: 1px 4px;
        font-size: 11px;
        line-height: 1.2;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    /* Reduce el margen vertical entre eventos */
    .fc-daygrid-event-harness {
        margin-bottom: 1px !important;
    }

    /* Opcional: achica los bordes de los eventos */
    .fc-event {
        border-radius: 3px;
    }

    /* Aumenta el alto del contenedor para permitir más eventos */
    .fc-daygrid-day-frame {
        min-height: 100px;
        /* puedes ajustar este valor */
    }

    .contenedor-calendario {
        position: relative;
        width: 100%;
        height: calc(100vh - 100px);
        /* Ajusta el 100% de la altura menos 100px para margen */
        min-height: 500px;
        /* Asegura una altura mínima */
        max-height: 100vh;
        /* Evita que crezca demasiado */
        overflow: visible !important;
        resize: vertical;
        /* Permite ajuste manual si es necesario */
    }

    #calendar {
        width: 100%;
        height: 100%;
        /* Hace que el calendario ocupe toda la altura del contenedor */
    }

    .tippy-box[data-theme~='custom'] {
        max-width: none;
        /* para que no lo limite */
        width: 350px;
        /* o el tamaño que desees */
        background-color: rgb(252, 249, 246);
        /* tu color personalizado */
        color: black;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        padding: 10px;

        /* para evitar límites de tamaño */
    }

    .fc .fc-more-link {
        background-color: #007bff;
        /* Color azul */
        color: white;
        /* Texto en blanco */
        padding: 4px 8px;
        border-radius: 5px;
        font-weight: bold;
        font-size: 14px;
        display: inline-block;
        text-align: center;
        width: 100%;
    }

    /* Cambiar color cuando el usuario pase el mouse */
    .fc .fc-more-link:hover {
        background-color: #0056b3;
        /* Azul más oscuro */
        text-decoration: none;
        cursor: pointer;
    }


    @media (max-width: 768px) {
        .fc-toolbar.fc-header-toolbar {
            flex-direction: column;
        }

        .fc-toolbar-chunk {
            width: 100%;
            text-align: center;
            margin-bottom: 5px;
        }

        .fc-button-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .fc-button {
            flex: 1;
            min-width: 80px;
            margin: 2px;
        }
    }

    /* Centra el grupo central (prev, title, next) en una sola línea */
    .fc-header-toolbar .fc-toolbar-chunk {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* Ajusta el margen entre los botones y el título */
    .fc-toolbar-title {
        margin: 0 10px;
        white-space: nowrap;
    }

    /* Evita que los botones salten de línea */
    .fc .fc-button {
        flex-shrink: 0;
        margin: 0;
    }

    /* Asegura que todo esté alineado correctamente */
    .fc .fc-toolbar.fc-header-toolbar {
        flex-wrap: nowrap !important;
        gap: 0;
    }
</style>


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
                <!-- <div class="col-md-2 contenedor-select-tipo-filtro-edicion" hidden>
                    <div class="form-floating">
                        <select name="tipofiltroedicion" id="tipofiltroedicion" class="form-select" required>
                            <option value="1" selected>Todas las Agendas</option>
                            <option value="2">Por Usuario</option>
                        </select>
                        <label for="tipofiltroedicion" class="form-label">Tipo Filtro</label>
                    </div>
                </div> -->
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
<!-- <a href="<?= $hostWithAppName ?>/views/utilitario/tareasdiarias/listar-tareasdiarias" class="btn btn-primary" id="btnAsignarTareaDiaria">Asignar Tarea Diaria</a>
 -->
<div class="container-fluid">
    <div class="contenedor-calendario">
        <div id='calendar'></div>
    </div>
</div>

<div class="modal fade" id="modal-viatico" tabindex="-1" aria-labelledby="modalviatico" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalviatico">Reportar Viático</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <!-- Sección de gastos -->
                        <div class="col-md-6">
                            <h5 class="mb-3">Detalles del Viático</h5>

                            <div class="mb-3">
                                <label for="pasaje" class="form-label">Pasaje (Opcional):</label>
                                <div class="input-group">
                                    <span class="input-group-text">S/.</span>
                                    <input type="number" id="pasaje" name="pasaje" class="form-control">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="hospedaje" class="form-label">Hospedaje:</label>
                                <div class="input-group">
                                    <span class="input-group-text">S/.</span>
                                    <input type="number" id="hospedaje" name="hospedaje" class="form-control">
                                </div>
                            </div>

                            <div class="mb-3 contenedor-comida">
                                <input type="checkbox" id="chkdesayuno">
                                <label for="chkdesayuno">Desayuno</label>
                                <input type="checkbox" id="chkalmuerzo">
                                <label for="chkalmuerzo">Almuerzo</label>
                                <input type="checkbox" id="chkcena">
                                <label for="chkcena">Cena</label>
                                <!-- <div class="input-group">
                                    <span class="input-group-text">S/.</span>
                                    <input type="number" id="comida" name="comida" class="form-control">
                                </div> -->
                            </div>

                            <!-- <div class="mb-3 contenedor-viatico-viaje">
                                <label for="viaje" class="form-label">Viático de viaje:</label>
                                <div class="input-group">
                                    <span class="input-group-text">S/.</span>
                                    <input type="number" id="viaje" name="viaje" class="form-control">
                                </div>
                            </div> -->
                        </div>

                        <!-- Sección de destinatarios -->
                        <div class="col-md-6 contenedor-admins">

                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
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

<!-- <div class="modal fade" id="modal-admins" tabindex="-1" aria-labelledby="modaladmins" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modaladmins">A quien desea enviar</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-progreso p-3">                    
                    <div class="table-responsive d-flex justify-content-center">
                        <table class="table table-striped table-hover text-center align-middle w-auto mx-auto" id="table-tarifarios">
                            <input type="checkbox" name="admin" id="admin">
                            <label for="">Admin 1</label>
                        </table>
                    </div>                    
                </div>
            </div>           
        </div>
    </div>
</div>
 -->
<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<!-- Importar idioma español -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/es.js"></script>

<!-- <script>
    const idusuarioLogeado = "<?php echo $_SESSION['login']['idusuario']; ?>"
    const nivelacceso = "<?php echo $_SESSION['login']['nivelacceso']; ?>"
</script> -->

<script src="<?= $hostWithAppName ?>/js/agenda/listar-agenda-filmmaker.js"></script>
<script src="<?= $hostWithAppName ?>/js/agenda/obtencion-agenda-nivel.js"></script>

</body>

</html>