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

    .tippy-box[data-theme~='mi-tema'] {
        background-color: #f9f3d2;
        /* color personalizado */
        color: #000;
        border: 1px solid #ccc;
        padding: 8px;
        font-size: 14px;
        border-radius: 6px;
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
                        <label for="usuario" class="form-label">Artista</label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="">
    <div class="contenedor-calendario">
        <div id="calendar"></div>
    </div>
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

                            <!--    <div class="row g-3 align-items-center contenedor-viatico-viaje">
                                <div class="col-md-4 text-end">
                                    <label for="viaje" class="form-label">Viatico de viaje:</label>
                                </div>
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <span class="input-group-text">S/.</span>
                                        <input type="number" id="viaje" name="viaje" class="form-control">
                                    </div>
                                </div>
                            </div> -->



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

<!-- <div class="modal fade" id="modal-infoagendaartista" tabindex="-1" aria-labelledby="modalinfoagendaartista" aria-hidden="true">
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
              
            </div>
        </div>
    </div>
</div> -->

<div class="modal fade" id="modal-acuerdo" tabindex="-1" aria-labelledby="modalacuerdo" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalacuerdo">Observación</h1>
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
                <div class="text-center my-4 position-relative">
                    <hr>
                    <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Filmakers Asignados</span>
                </div>
                <div class="contenedor-filmmakers-asignados">

                </div>
            </div>
            <div class="modal-footer text-end">
                <button type="button" class="btn btn-secondary" id="btnGuardarFilmmaker">Asignar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-lugardestino" tabindex="-1" aria-labelledby="modallugardestino" aria-hidden="true">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="form-floating">
                        <input type="text" name="destino" id="destino" class="form-control">
                        <label for="destino" class="form-label">Lugar de destino</label>

                    </div>
                </div>
            </div>
            <div class="modal-footer text-end">
                <button type="button" class="btn btn-secondary" id="btnSalida">Reportar Salida</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-infoevento" tabindex="-1" aria-labelledby="modalinfoevento" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalinfoevento">Informacion evento</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-infoevento p-3">

                </div>
            </div>

        </div>
    </div>
</div>



<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js"></script>
<!-- Importar idioma español -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/es.js"></script>

<!-- Tippy.js (para popover) -->
<!-- <link href="https://unpkg.com/tippy.js@6/animations/scale.css" rel="stylesheet">
<script src="https://unpkg.com/@popperjs/core@2"></script>
<script src="https://unpkg.com/tippy.js@6"></script> -->
<script src="<?= $hostWithAppName ?>/js/agenda/obtencion-agenda-nivel.js"></script>
<script src="<?= $hostWithAppName ?>/js/agenda/listar-agenda-artista.js"></script>

</body>

</html>