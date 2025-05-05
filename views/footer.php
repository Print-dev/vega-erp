</main>
<!-- Modal de crear especificaciones -->
<div class="modal fade" id="mdl-crear-espec" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" style="max-width: 650px;">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Crear Especificacion</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-12">
            <div class="form-floating">
              <input type="text" class="form-control" id="new_especificacion">
              <label for="new_especificacion" class="form-label">Nueva Especificacion</label>
            </div>
            <div class="d-flex mt-2">
              <button type="button" class="btn btn-sm btn-success ms-auto" id="add_espec">Registrar</button>
            </div>
          </div>
        </div>
        <hr>
        <div class="row mt-2">
          <div class="table-responsive">
            <table class="" id="tb-especificaciones">
              <thead>
                <tr>
                  <th class="text-center">Id</th>
                  <th class="text-center">Especificacion</th>
                </tr>
              </thead>
              <tbody id="tbody-espec"></tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>
<!-- ./Modal de crear especificaciones -->

<script>
  const host = "http://localhost/vega-erp/controllers/";
  const hostOnlyJs = "http://localhost/vega-erp"
  <?php $hostOnly = "http://localhost/vega-erp" ?>
  const hostOnly = "<?= $hostOnly ?>";
  <?php $hostWithAppName = "http://localhost/vega-erp" ?>
</script>
<!-- <script>
    const idusuarioLogeado = "<?php echo $_SESSION['login']['idusuario']; ?>"
    const nivelacceso = "<?php echo $_SESSION['login']['nivelacceso']; ?>"
</script> -->

<!-- Notificaciones js -->

<script src="<?= $hostOnly ?>/js/notificacionGlobal.js"></script>
<!-- Core -->
<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
  crossorigin="anonymous"></script>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- Script personzalizado -->

<!-- <script src="http://localhost/CMMS/js/dashboard/select-option.js"></script> -->
<!-- SWEET ALERT -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Libreria que simplifica sweet alert -->
<script src="<?= $hostOnly ?>/js/swalcustom.js"></script>
<!-- Archivo para obtener fecha y hora de peru -->
<script src="<?= $hostOnly ?>/js/utiles.js"></script>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<!-- JQUERY -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//cdn.datatables.net/2.1.8/js/dataTables.min.js"></script>

<!-- <script src="<?= $hostOnly ?>/js/calcularFechaProgramadaTarea.js"></script> -->
<script>
  // Manejo de la apertura/cierre del dropdown
  const dropdownButton = document.getElementById('drop-sb');
  dropdownButton?.addEventListener('click', () => {
    const dropdown = dropdownButton?.closest('.drop-sb');
    dropdown?.classList.toggle('show');
  });

  // Cerrar el dropdown cuando se hace clic fuera
  document?.addEventListener('click', (e) => {
    const dropdown = document.querySelector('.drop-sb');
    if (!dropdown?.contains(e.target)) {
      dropdown?.classList.remove('show');
    }
  });
  //--------------------------------------------------------------------------------------------//

  document.addEventListener("DOMContentLoaded", () => {
    //const host = `http://localhost/vega-erp/controllers/`;
  });
</script>