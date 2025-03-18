<?php require_once '../../header.php' ?>
<div class="container-fluid">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Reparticiones</h1>
                </div>
                <div class="col-md-6 text-end">
                    <!-- <a href="http://localhost/vega-erp/views/utilitario/usuarios/registrar-usuario" class="btn btn-primary"></a> -->
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
                                            <input type="text" class="form-control filter" id="evento" autocomplete="off">

                                                <label for="evento" class="form-label">Evento</label>
                                            </div>
                                        </div>                                        
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-reparticiones">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Evento</th>
                                                <th>Monto Total</th>
                                                <th>Monto Vega</th>
                                                <th>Monto promotor</th>
                                                <th>Ingreso total</th>
                                                <th>Apellidos</th>
                                                <th>Monto Artista</th>
                                                <th>Monto Rep Vega</th>                                                
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-reparticion">
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
    <?php require_once '../../footer.php' ?>

    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

    <script src="http://localhost/vega-erp/js/reparticiones/listar-reparticiones.js"></script>

    </body>

    </html>