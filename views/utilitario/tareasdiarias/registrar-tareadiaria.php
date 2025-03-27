<?php require_once '../../header.php' ?>

<div class="container">
    <div class="col-md-6 mx-auto bg-white p-4 rounded shadow">
        <h1 class="text-center mb-4">Asignar Tarea Diaria</h1>

        <!-- Selección de nivel de acceso -->
        <div class="mb-3">
            <label for="nivelacceso" class="form-label">Nivel  / ROl</label>
            <select id="nivelacceso" class="form-select">
                <option value="">Seleccione</option>
                <option value="10">Edicion y Publicidad</option>
                <option value="11">Filmmaker</option>
            </select>
        </div>

        <!-- Selección de Responsable -->

        <div class="mb-3">
            <label for="responsable" class="form-label">Responsable</label>
            <select id="responsable" class="form-select">
            </select>
        </div>

        <!-- Selección de Tarea -->
        <div class="mb-3">
            <label for="tarea" class="form-label">Tarea</label>
            <select id="tarea" class="form-select">
            </select>
        </div>

        <!-- Fecha de Entrega -->
        <div class="mb-3">
            <label for="fechaentrega" class="form-label">Fecha de Entrega</label>
            <input type="date" id="fechaentrega" class="form-control">
        </div>

        <!-- Hora de Entrega -->
        <div class="mb-3">
            <label for="horaentrega" class="form-label">Hora de Entrega</label>
            <input type="time" id="horaentrega" class="form-control">
        </div>

        <!-- Botón de Envío -->
        <button class="btn btn-primary w-100 mb-3" id="btnAgregarTarea">Agregar Tarea</button>
        <button class="btn btn-primary w-100" id="btnNuevaTarea">Nueva Tarea</button>
    </div>
</div>

<div class="modal fade" id="modal-nuevatarea" tabindex="-1" aria-labelledby="modalnuevatarea" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header border-0">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class=" container">
                    <div class="col-md-8 mx-auto">
                        <div class="mb-3">
                            <label for="txtNuevaTarea" class="form-label">Nueva Tarea</label>
                            <input type="text" id="txtNuevaTarea" class="form-control mb-3">
                            <button class="btn btn-primary w-100 mb-3" id="btnGuardarNuevaTarea">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<?php require_once '../../footer.php' ?>
<script src="http://localhost/vega-erp/js/tareasdiarias/registrar-tareadiaria.js"></script>
</body>

</html>