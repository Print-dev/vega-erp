<?php require_once '../header.php' ?>

<div class="container-fluid">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Contenidos listos para publicar</h1>
                </div>

            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <div class="card border-0">
                                <div class="card-body border-0">

                                    <div class="row">                                        
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="establecimiento" autocomplete="off">
                                                <label for="establecimiento">Establecimiento/Lugar</label>
                                            </div>
                                        </div>                                    
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="date" class="form-control filter" id="fechapresentacion" autocomplete="off">
                                                <label for="fechapresentacion">Fecha de evento</label>
                                            </div>
                                        </div>                                    
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select name="artista" class="form-control filter" id="artista">
                                                    
                                                </select>
                                                <label for="artista">Artista</label>
                                            </div>
                                        </div>                                    
                                        <div class="col-md-2 contenedor-select-editor">
                                            <div class="form-floating">
                                                <select name="usuarioeditor" class="form-control filter" id="usuarioeditor">

                                                </select>
                                                <label for="usuarioeditor">Editor</label>
                                            </div>
                                        </div>                                    
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    
                                    <table class="table" id="table-contenidos">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Establecimiento/Lugar</th>                                                
                                                <th>Fecha de evento</th>
                                                <th>Artista</th>
                                                <th>Usuario Editor</th>
                                                <th>Contenido</th>
                                                <th>Red Social</th>
                                                <th>Fecha Publicado</th>
                                                <th>Copy</th>
                                                <th>Publicar</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-contenido">
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ./Modal Para elegir la especificacion -->
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-pendientes" tabindex="-1" aria-labelledby="modalpendientes" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalpendientes">Detalles agenda</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="contenedor-info-agenda p-3">

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

    <!-- <script src="<?= $hostWithAppName ?>/js/agenda/obtencion-agenda-nivel.js"></script>
 -->
    <script src="<?= $hostWithAppName ?>/js/agenda/listar-agenda-cmanager.js"></script>

    </body>

    </html>