<?php require_once '../../header.php' ?>

<div class="container-fluid">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
-webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
-moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Caja Chica</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="http://localhost/vega-erp/views/contabilidad/caja-chica/registrar-caja" class="btn btn-primary">Registrar Gasto</a>
                </div>
            </div>
            <!-- <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <div class="card border-0">
                                <div class="card-body border-0">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="ncotizacion" autocomplete="off">
                                                <label for="ncotizacion">Nº Cotizacion</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="ndocumento" autocomplete="off">
                                                <label for="ndocumento">Nº Documento/RUC</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row g-1">
                        <div class="table-responsive">
                            <table class="table" id="table-atenciones">
                                <thead class="text-center">
                                    <tr>
                                        <th>#</th>
                                        <th>N° Cotizacion</th>
                                        <th>Artista</th>
                                        <th>N° Documento/RUC</th>
                                        <th>Cliente</th>
                                        <th>Tipo evento</th>
                                        <th>Modalidad</th>
                                        <th>Fecha presentacion</th>
                                        <th>Estado</th>
                                        <th>Opciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tb-body-atencion">
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div> -->

            <!-- ./Modal Para elegir la especificacion -->
        </div>
    </div>
</div>
</div>

<?php require_once '../../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

<script src="http://localhost/vega-erp/js/contabilidad/listar-cajachica.js"></script>

</body>

</html>