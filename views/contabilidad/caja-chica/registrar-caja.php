<?php require_once '../../header.php' ?>

<div class="container-fluid ">
    <form action="" id="form-registrar-caja" >
        <div class="card" style="border-color:rgb(247, 247, 242); box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
    -moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
            <h1 id="titulo-registrar-at-clientes">Registrar Gasto</h1>
            <div class="card-body d-flex justify-content-center">
                <div class="col-md-6 col-lg-5"> <!-- Contenedor con ancho limitado -->
                    <!-- Primera fila: C.C. Inicial y Incrementar C.C. Inicial -->
                    <div class="row g-2">
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" id="ccinicial" name="ccinicial" class="form-control" placeholder="C.C.Inicial">
                                <label for="ccinicial" class="form-label">C.C.Inicial</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" id="incremento" name="incremento" class="form-control" placeholder="Incrementar C.C.Inicial">
                                <label for="incremento" class="form-label">Incrementar C.C.Inicial</label>
                            </div>
                        </div>
                    </div>

                    <!-- Segunda fila: C.C. Final debajo de C.C. Inicial -->
                    
                </div>
            </div>


            <div class="card-body d-flex justify-content-center">
                <div class="table-responsive" style="max-width: 800px; width: 100%;"> <!-- Contenedor con ancho limitado -->
                    <table class="table table-striped table-hover text-center align-middle" id="table-tarifarios">
                        <thead class="table-dark">
                            <tr>
                                <th style="min-width: 300px; max-width: 500px; white-space: normal;">Concepto</th>
                                <th style="min-width: 150px;">Costo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="text-start" style="word-wrap: break-word; overflow-wrap: break-word; white-space: normal;">
                                    Compra de 2 audífonos
                                </td>
                                <td>S/. 80.00</td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>



            <div class="card-footer d-flex justify-content-end">
                <div class="d-flex gap-2">
                    <button type="button" id="btnRegistrarNuevoGasto" class="btn btn-primary text-start">
                        <i class="fa-solid fa-floppy-disk px-2"></i>Registra Nuevo Gasto</button>
                    <button type="submit" id="btnGenerarCierre" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk px-2"></i>Generar Cierre</button>
                    <a href="http://localhost/vega-erp/views/contabilidad/caja-chica/caja-chica" class="btn btn-primary">
                        <i class="fa-solid fa-circle-left px-2"></i>Regresar</a>

                </div>
            </div>
    </form>
</div>

<div class="modal fade" id="modal-registrarcaja" tabindex="-1" aria-labelledby="modalregistrarcaja" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalregistrarcaja">Registra Nueva Caja Chica</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <textarea name="concepto" id="concepto" class="form-control"></textarea>
                            <label for="montoccitotal" class="form-label">Concepto</label>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-floating">
                            <input type="number" id="monto" name="monto" maxlength="9" class="form-control">
                            <label for="monto" class="form-label">Monto</label>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer text-end">
                <button type="button" class="btn btn-secondary" id="btnRegistrarGasto">Guardar</button>
            </div>
        </div>
    </div>
</div>

<?php require_once '../../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

<script src="http://localhost/vega-erp/js/contabilidad/registrar-cajachica.js"></script>

</body>

</html>