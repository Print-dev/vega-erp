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
                <div class="col-md-6 text-end contenedor-btn-nuevacaja">
                    <button type="button" class="btn btn-info" id="btnMontoCajaChica" data-bs-toggle="modal" data-bs-target="#modal-monto-cajachica">Monto Caja Chica</button>
                    <a href="<?= $hostOnlyHeader ?>/views/contabilidad/caja-chica/registrar-caja" class="btn btn-primary" id="btnNuevaCaja">Abrir Nueva Caja</a>
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
                                                <input type="date" id="fechaapertura" class="form-control filter">
                                                <label for="fechaapertura">Filtro Fecha de apertura</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="date" id="fechacierre" class="form-control filter">
                                                <label for="fechacierre">Filtro Fecha de cierre</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select id="mes" class="form-control filter">
                                                    <option value="">Seleccionar Mes</option>
                                                    <option value="1">Enero</option>
                                                    <option value="2">Febrero</option>
                                                    <option value="3">Marzo</option>
                                                    <option value="4">Abril</option>
                                                    <option value="5">Mayo</option>
                                                    <option value="6">Junio</option>
                                                    <option value="7">Julio</option>
                                                    <option value="8">Agosto</option>
                                                    <option value="9">Septiembre</option>
                                                    <option value="10">Octubre</option>
                                                    <option value="11">Noviembre</option>
                                                    <option value="12">Diciembre</option>
                                                </select>
                                                <label for="mes">Filtrar por Mes</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="week" id="año_semana" class="form-control filter">
                                                <label for="año_semana">Filtrar por Semana</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" id="busqueda_general" class="form-control filter">
                                                <label for="busqueda_general">Evento</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 contenedor-creador-cajachica">
                                            <div class="form-floating">
                                                <select id="creador" class="form-control filter">

                                                </select>
                                                <label for="creador">Creador</label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <hr>
                            <div class="row g-1">
                                <div class="table-responsive">
                                    <table class="table" id="table-cajaschicas">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Fecha Apertura</th>
                                                <th>Fecha Cierre</th>
                                                <th>Evento</th>
                                                <th>Ubigeo</th>
                                                <th>Monto Inicial</th>
                                                <th>Incremento</th>
                                                <th>Decremento</th>
                                                <th>Registro de pagos</th>
                                                <th>Gasto Total</th>
                                                <th>Monto Final</th>
                                                <th>Opciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tb-body-cajachica">
                                        </tbody>

                                    </table>

                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="card-footer row">
                        <div class="text-end">
                            <a type="button" class="btn btn-success" id="btnGenerarExcelCaja"><i class="fa-solid fa-file-csv"></i> Generar CSV</a>
                            <a type="button" class="btn btn-success" id="btnGenerarCierreCajaChicaFiltro"> Resumen</a>
                        </div>
                    </div>
                    <!-- ./Modal Para elegir la especificacion -->
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-gastos" tabindex="-1" aria-labelledby="modalgastos" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalgastos">Registro de Gastos</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover text-center align-middle w-auto mx-auto">
                            <thead class="table-dark">
                                <th>Fecha</th>
                                <th>Concepto</th>
                                <th>Monto</th>
                            </thead>
                            <tbody class="tbody-reg-gastos">

                            </tbody>
                            <tfoot class="monto">
                                <tr>
                                    <td colspan="2" class="text-end">Total:</td>
                                    <td class="text-center" id="totalGastos"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-monto-cajachica" tabindex="-1" aria-labelledby="modalmonto-cajachica" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalmonto-cajachica">Monto de Caja Chica</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="row justify-content-center">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-floating">
                                            <!-- <input type="text" id="ccinicial" name="ccinicial" class="form-control" placeholder="C.C.Inicial"> -->
                                            <p for="txtMontoCajaChica" id="txtMontoCajaChica" class="form-label"></p>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-floating">
                                            <select id="operacionCC" name="operacionCC" class="form-select">
                                                <option value="agregar">Agregar</option>
                                                <option value="quitar">Quitar</option>
                                            </select>
                                            <label for="operacionCC" class="form-label">Operación</label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-floating">
                                            <input type="text" id="incremento" name="incremento" class="form-control" placeholder="Monto">
                                            <label for="incremento" class="form-label">Monto</label>
                                        </div>
                                    </div>
                                    <div class="col-md-1">
                                        <button type="button" class="btn btn-primary" id="btnGuardarMontoCajaChica">Guardar</button>
                                    </div>
                                    <div class="col-md-12 mb-5">
                                        <div class="form-floating text-center">
                                            <label for="nuevoMonto" class="form-label" id="nuevoMonto"></label>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-cierrecaja" tabindex="-1" aria-labelledby="modalcierrecaja" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modalcierrecaja"></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover text-center align-middle w-auto mx-auto">
                            <thead class="table-dark">
                                <tr>
                                    <th>Monto Inicial</th>
                                    <th>Gasto</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody class="tbody-reg-cierrecaja">
                                <!-- Aquí van los datos dinámicos -->
                            </tbody>
                            <tfoot class="monto">
                                <tr>
                                    <td class="text-center fw-bold">Total Monto Inicial: <span id="totalIngreso">S/. 0.00</span></td>
                                    <td class="text-center fw-bold">Total Gasto: <span id="totalGasto">S/. 0.00</span></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                </div>

            </div>
        </div>
    </div>

    <?php require_once '../../footer.php' ?>

    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/exceljs/4.4.0/exceljs.min.js" integrity="sha512-dlPw+ytv/6JyepmelABrgeYgHI0O+frEwgfnPdXDTOIZz+eDgfW07QXG02/O8COfivBdGNINy+Vex+lYmJ5rxw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.sheetjs.com/xlsx-0.20.0/package/exceljs.min.js"></script>

    <script src="<?= $hostOnlyHeader ?>/js/contabilidad/listar-cajachica.js"></script>

    </body>

    </html>