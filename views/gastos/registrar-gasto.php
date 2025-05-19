<?php require_once '../header.php' ?>

<div class="container-fluid py-4 px-0">
    <div class="row d-flex flex-nowrap">
        <div class="card">
            <div class="card-body">
                <form action="" id="form-registro-gasto">
                    <div class="row g-2 mb-4">

                    </div>
                    <div class="row g-2 mb-4">
                        <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">General</span>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <select name="estado" id="estado" class="form-select" ">
                                    <option value="">Selecciona</option>
                                    <option value=" 1">Pendiente</option>
                                    <option value="2">Pagado</option>
                                </select>
                                <label for="estado" class="form-label">estado</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-floating">
                                <input type="date" id="fechagasto" class="form-control" autocomplete="off">
                                <label for="fechagasto" class="form-label">Fecha de gasto</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-floating">
                                <input type="date" id="fechavencimiento" class="form-control" autocomplete="off">
                                <label for="fechavencimiento" class="form-label">Fecha de vencimiento</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <select name="tipo" id="tipo" class="form-select" ">
                                    <option value="">Selecciona</option>
                                    <option value=" 1">Variables</option>
                                    <option value="2">Fijo</option>
                                </select>
                                <label for="tipo" class="form-label">Concepto</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <select name="concepto" id="concepto" class="form-select" ">
                                    <option value="">Selecciona</option>
                                    <option value=" 1">Oficina</option>
                                    <option value="2">Inventario</option>
                                </select>
                                <label for="concepto" class="form-label">Concepto</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <select name="subtipo" id="subtipo" class="form-select" ">
                                    <option value="">Selecciona</option>
                                    <option value=" 1">Inventario</option>
                                </select>
                                <label for="subtipo" class="form-label">SubTipo</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <select name="proveedor" id="proveedor" class="form-select" ">
                                    <option value="">Selecciona</option>
                                    <option value=" 1">VAMAS SAC</option>
                                </select>
                                <label for="proveedor" class="form-label">Proveedor</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <select name="colaborador" id="colaborador" class="form-select" ">
                                        <option value="">Selecciona</option>
                                        <option value=" 1">Royer</option>
                                </select>
                                <label for="colaborador" class="form-label">Colaborador</label>
                            </div>
                        </div>
                        <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Detalles de costo</span>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="number" id="costounitario" class="form-control" autocomplete="off">
                                <label for="costounitario" class="form-label">Costo Unitario</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="number" id="pagadoanticipo" class="form-control" autocomplete="off">
                                <label for="pagadoanticipo" class="form-label">Pago Anticipado</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="date" id="costofinal" class="form-control" autocomplete="off">
                                <label for="costofinal" class="form-label">Costo Final</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="number" id="costofinalunit" class="form-control" autocomplete="off">
                                <label for="costofinalunit" class="form-label">Costo Final Unit</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="date" id="egreso" class="form-control" autocomplete="off">
                                <label for="egreso" class="form-label">Egreso</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="date" id="montopdte" class="form-control" autocomplete="off">
                                <label for="montopdte" class="form-label">Monto Pendiente</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="number" id="impuestos" class="form-control" autocomplete="off">
                                <label for="impuestos" class="form-label">Impuestos</label>
                            </div>
                        </div>

                        <!-- SOLO EN INVENTARIO -->
                        <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Producto o Servicio</span>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="text" id="nombre" class="form-control" autocomplete="off">
                                <label for="nombre" class="form-label">Nombre</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="number" id="cantidad" class="form-control" autocomplete="off">
                                <label for="cantidad" class="form-label">Cantidad</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="number" id="unidades" class="form-control" autocomplete="off">
                                <label for="unidades" class="form-label">Unidades</label>
                            </div>
                        </div>
                        <!-- CONDICIONADO -->
                        <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Forma de pago</span>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <select name="formapago" id="formapago" class="form-select" ">
                                        <option value="">Selecciona</option>
                                        <option value=" 1">BCP</option>
                                </select>
                                <label for="formapago" class="form-label">Forma de pago</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="text" id="cuenta" class="form-control" autocomplete="off">
                                <label for="cuenta" class="form-label">Cuenta</label>
                            </div>
                        </div>
                        <!-- FACTURA -->
                        <div class="text-center my-4 position-relative">
                            <hr>
                            <span class="position-absolute top-50 start-50 translate-middle bg-white px-3">Datos de facturación</span>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="text" id="foliofactura" class="form-control" autocomplete="off">
                                <label for="foliofactura" class="form-label">N° Factura</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="number" id="tasafactura" class="form-control" autocomplete="off">
                                <label for="tasafactura" class="form-label">Tasa Factura</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="date" id="emision" class="form-control" autocomplete="off">
                                <label for="emision" class="form-label">Emisión</label>
                            </div>
                        </div>
                        <!-- DESCRIPCION INFORMATIVA DEL GASTO O ENTRADA -->
                        <div class="col-md-1">
                            <div class="form-floating">
                                <input type="date" id="descripcion" class="form-control" autocomplete="off">
                                <label for="descripcion" class="form-label">Descripción</label>
                            </div>
                        </div>



                        <!-- <div class="col-md-1">
                            <div class="form-floating">
                                <input type="date" id="gastoabono" class="form-control" autocomplete="off">
                                <label for="gastoabono" class="form-label">Gasto Abono</label>
                            </div>
                        </div>
 -->

                    </div>
                    <div class="row">
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary" id="btn-registrar-gasto">Registrar Gasto</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/gastos/listar-gastos.js"></script>
<!-- <script src="https://upload-widget.cloudinary.com/latest/global/all.js" type="text/javascript"></script> -->

</body>

</html>