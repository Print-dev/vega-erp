<?php require_once '../../header.php' ?>
<div class="container-fluid ">
    <div class="card" style="border-color:rgb(247, 247, 242); box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <h1 id="titulo-registrar-at-clientes">Registrar Egreso</h1>

        <div class="card-body d-flex justify-content-center">
            <div class="table-responsive" style="max-width: 800px; width: 100%;">
                <table class="table table-striped table-hover text-center align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th style="min-width: 100px;">Tipo Pago</th>
                            <th style="min-width: 100px;">N° Operacion</th>
                            <th style="min-width: 300px; max-width: 500px; white-space: normal;">Descripcion</th>
                            <th style="min-width: 150px;">Monto</th>
                        </tr>
                    </thead>
                    <div class="tbody-container">
                        <tbody class="tbody-egresos">
                            <!-- Las filas se agregarán dinámicamente aquí -->
                        </tbody>
                    </div>
                    <tfoot class="monto">
                        <tr>
                            <td colspan="3" class="text-end">Total:</td>
                            <td class="text-center" id="totalEgresos"></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>




        <div class="card-footer d-flex justify-content-end">
            <div class="d-flex gap-2">
                <button type="button" id="btnRegistrarNuevoEgreso" class="btn btn-primary text-start">
                    <i class="fa-solid fa-plus px-2"></i>Registra Nuevo Egreso</button>
                <a href="http://localhost/vega-erp/views/contabilidad/reparticion/listar-reparticion" class="btn btn-primary">
                    <i class="fa-solid fa-circle-left px-2"></i>Regresar</a>

            </div>
        </div>
    </div>
    <div class="modal fade" id="modal-egreso" tabindex="-1" aria-labelledby="modalegreso" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalegreso">Registra Nuevo Egreso</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                            <input type="text" id="descripcion" name="descripcion" class="form-control">
                            <label for="descripcion" class="form-label">Descripcion</label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="number" id="monto" name="monto" class="form-control">
                                <label for="monto" class="form-label">Monto</label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <select id="tipopago" name="tipopago" class="form-select">
                                    <option value="-1">Seleccionar</option>
                                    <option value="1">Transferencia</option>
                                    <option value="2">Contado</option>
                                </select>
                                <label for="tipopago" class="form-label">Tipo de pago</label>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="number" id="noperacion" name="noperacion" maxlength="15" class="form-control">
                                <label for="noperacion" class="form-label">N° Operacion</label>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer text-end">
                    <button type="button" class="btn btn-secondary" id="btnRegistrarEgreso">Guardar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once '../../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

<script src="http://localhost/vega-erp/js/reparticiones/registrar-egresos.js"></script>

</body>

</html>