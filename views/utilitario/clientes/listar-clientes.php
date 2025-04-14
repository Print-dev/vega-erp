<?php require_once '../../header.php' ?>

<style>
    .contenedor-general {
        display: flex;
        flex-direction: column;
        height: auto;
        min-height: 100vh;
    }
</style>

<div class="container-fluid contenedor-general">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h1>Clientes</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="<?= $hostOnlyHeader ?>/views/utilitario/clientes/registrar-cliente" class="btn btn-primary">Nuevo Cliente</a>
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
                                                <input type="text" class="form-control filter" id="ndocumento" autocomplete="off" placeholder="N° Documento"> 
                                                <label for="ndocumento">N° Documento</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="telefono" autocomplete="off" placeholder="Telefono"> 
                                                <label for="telefono">Telefono</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="razonsocial" autocomplete="off" placeholder="Razon Social"> 
                                                <label for="razonsocial">Razon Social</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- <hr> -->
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-clientes">
                                        <thead class="text-center">
                                            <tr>
                                                <th>N° Documento</th>
                                                <th>Tipo Documento</th>
                                                <th>Razon Social</th>
                                                <th>Representante Legal</th>
                                                <th>Telefono</th>
                                                <th>Correo</th>
                                                <th>Dirección</th>
                                                <th>Ubigeo</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-cliente">
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
    <script src="<?= $hostOnlyHeader ?>/js/clientes/listar-clientes.js"></script>
    </body>

    </html>