<?php require_once '../header.php' ?>

<div class="container mt-4">
    <h2 class="mb-3">Subir Contenido</h2>

    <form id="form-subircontenido" class="card p-3 shadow-sm">
        <!-- Input para subir imagen -->
        <div class="mb-3 text-center">
    <!-- Botón personalizado para subir imágenes -->
            <label for="upload_widget" class="btn btn-primary d-flex align-items-center justify-content-center gap-2 px-4 py-2 shadow">
                <i class="bi bi-cloud-upload-fill fs-5"></i> Subir Evidencia
            </label>
            <input type="button" id="upload_widget" class="d-none" accept="image/*">

            <!-- Vista previa de la imagen -->
            <div class="mt-3">
                <img id="previewImagen" src="" alt="Vista previa" class="img-fluid d-none rounded shadow" style="max-height: 500px;">
            </div>

            <!-- Mensaje de ayuda -->
            <small class="form-text text-muted">Selecciona una imagen para cargarla.</small>
        </div>


        <!-- Vista previa de imagen -->
        <div class="mb-3 text-center">
            <img id="previewImagen" src="" alt="Vista previa" class="img-fluid d-none" style="max-height: 500px;">
        </div>
        

        <div class="text-end">
            <button type="button" class="btn btn-primary" id="btnGuardarContenido">Guardar</button>
            <button type="button" class="btn btn-primary" id="btnVerHistorial">Ver historial</button>
        </div>
    </form>
</div>

<div class="modal fade" id="modal-historial" tabindex="-1" aria-labelledby="modalhistorial" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalhistorial">Asignar Filmmaker</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-historial p-3">
                    
                </div>
            </div>
        </div>
    </div>
</div>


<?php require_once '../footer.php' ?>


<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

<!-- <script>
    const idusuarioLogeado = "<?php echo $_SESSION['login']['idusuario']; ?>"
    const nivelacceso = "<?php echo $_SESSION['login']['nivelacceso']; ?>"
</script> -->

<script src="http://localhost/vega-erp/js/agenda/subir-contenido-edicion.js"></script> 
<script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script>

</body>

</html>