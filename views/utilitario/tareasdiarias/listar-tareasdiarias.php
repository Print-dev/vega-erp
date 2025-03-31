<?php require_once '../../header.php' ?>


<style>
    /* Evita que el texto de la tarea sea opacado por el bloque */
    .fc-event-title {
        white-space: normal !important;
        /* Permite que el texto se divida en varias líneas */
        overflow: visible !important;
        text-overflow: ellipsis;
        word-wrap: break-word;
    }

    .fc-event {
        /* Ajusta la altura mínima para mejorar la visualización */
        padding: 5px;
    }

    .fc-daygrid-event {
        white-space: nowrap;
        /* Evita que los eventos se expandan en varias líneas */
        overflow: hidden;
        /* Oculta el contenido extra */
        text-overflow: ellipsis;
        /* Muestra "..." cuando el texto es muy largo */
        max-width: 100%;
        /* Ajusta al ancho disponible */
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

    .fc-popover {
        position: absolute !important;
        z-index: 9999 !important;
        width: auto;
        max-width: 400px;
        max-height: 530px;
        overflow-y: auto;
        background: white;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 10px;
    }

    .fc .fc-more-popover .fc-popover-body {
        min-width: 300px;
    }

    /* Estilo para el botón "+X more" */
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

    .label {
        display: inline-block;
        width: 20px;
        height: 20px;
        border-radius: 4px;
        margin-right: 8px;
        border: 1px solid #ccc;
    }
</style>
<div class="row g-0 mb-3 contenedor-filtros-agenda">
    <div class="card border-0">
        <div class="card-body border-0">
            <div class="row ">
                <div class="col-md-2 contenedor-select-tipo-filtro-edicion">
                    <div class="form-floating">
                        <select name="nivelacceso" id="nivelacceso" class="form-select" required>
                            <option value="">Seleccione</option>
                            <option value="10">Edicion y Publicidad</option>
                            <option value="11">Filmmaker</option>
                        </select>
                        <label for="nivelacceso" class="form-label">Nivel/Rol</label>
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
            <div class="text-end">
                <a href="<?= $hostOnlyHeader ?>/views/utilitario/tareasdiarias/registrar-tareadiaria" class="btn btn-primary" id="btnAsignarTareaDiaria">Asignar Tarea Diaria</a>
            </div>
        </div>

    </div>
</div>
<button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#modalLeyenda">
    <i class="fa-solid fa-question"></i> Ayuda
</button>
<div class="contenedor-calendario">
    <div id='calendar'></div>

</div>



<!-- Modal -->
<div class="modal fade" id="modalLeyenda" tabindex="-1" aria-labelledby="modalLeyendaLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLeyendaLabel">Leyenda de Colores</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><span class="label" style="background-color: #eae6e6;"></span> Azul - Pendiente</p>
                <p><span class="label" style="background-color: #ff4d4d;"></span> Rojo - Atrasado</p>
                <p><span class="label" style="background-color: #28a745;"></span> Verde - Completado</p>
                <p><span class="label" style="background-color: #FFA500;"></span> Naranja - Completado con atraso</p>
            </div>
        </div>
    </div>
</div>

<?php require_once '../../footer.php' ?>
<script src="<?= $hostOnlyHeader ?>/js/tareasdiarias/listar-tareasdiarias.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<!-- Importar idioma español -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/es.js"></script>
</body>

</html>