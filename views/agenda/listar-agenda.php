<?php require_once '../header.php' ?>

<style>
        /* Evita que el texto de la tarea sea opacado por el bloque */
        .fc-event-title {
            white-space: normal !important; /* Permite que el texto se divida en varias líneas */
            overflow: visible !important;
            text-overflow: ellipsis;
            word-wrap: break-word;
        }

        .fc-event {
            min-height: 50px; /* Ajusta la altura mínima para mejorar la visualización */
            padding: 5px;
            font-size: 14px;
        }
    </style>

<div class="row g-0 mb-3">
    <div class="card border-0">
        <div class="card-body border-0">
            <label for="">Filtros</label>
            <div class="row">
                <div class="col-md-2 mb-3">
                    <div class="form-floating">
                        <select name="nivelacceso" id="nivelacceso" class="form-select" required>
                        </select>
                        <label for="nivelacceso" class="form-label">Nivel/Rol</label>
                    </div>
                </div>
                <div class="col-md-2 ">
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

<div id='calendar'></div>


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


<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
 <!-- Importar idioma español -->
 <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/es.js"></script>
<script src="http://localhost/vega-erp/js/agenda/listar-agenda.js"></script>

</body>

</html>