<?php require_once '../header.php' ?>
<style>
    .contenedor-general {
        display: flex;
        flex-direction: column;
        height: auto;
        min-height: 100vh;
    }

    h1 {
        font-size: 2rem;
        color: #000;
    }

    /* Ajustar el tamaño de la tabla principal */
    #table-atenciones {
        font-size: 12px;
        /* Reducir el tamaño de la fuente */
        width: 100%;
        border-collapse: collapse;
        /* Unir bordes para ahorrar espacio */
    }

    /* Ajustar el padding de las celdas */
    #table-atenciones th,
    #table-atenciones td {
        /* Reducir el espacio interno */
        text-align: left;
        white-space: nowrap;
        /* Evitar saltos de línea */
    }

    /* Ajustar el ancho de columnas específicas */
    #table-atenciones th:nth-child(1),
    #table-atenciones td:nth-child(1) {
        width: 1%;
    }

    /* # */
    #table-atenciones th:nth-child(2),
    #table-atenciones td:nth-child(2) {
        width: 1%;
    }

    /* N° Cotización */
    #table-atenciones th:nth-child(3),
    #table-atenciones td:nth-child(3) {
        width: 1%;
    }

    /* Artista */
    #table-atenciones th:nth-child(4),
    #table-atenciones td:nth-child(4) {
        width: 1%;
    }

    /* Lugar */
    #table-atenciones th:nth-child(5),
    #table-atenciones td:nth-child(5) {
        width: 1%;
    }

    /* Ubigeo */
    #table-atenciones th:nth-child(6),
    #table-atenciones td:nth-child(6) {
        width: 1%;
    }


    #table-atenciones tbody tr:nth-child(odd) {
        background-color: #f9f9f9;
        /* Gris claro */
    }

    #table-atenciones tbody tr:nth-child(even) {
        background-color: #ffffff;
        /* Blanco */
    }

    #table-atenciones_length {
        margin-top: 20px;
        margin-bottom: 20px;
    }

    #table-atenciones_filter {
        margin-top: 20px;
        margin-bottom: 20px;
    }

    tbody,
    td,
    tfoot,
    th,
    thead,
    tr {
        border-style: none;
        border-bottom: none;
    }

    /* Opciones */

    /* Ajustar el contenedor de la tabla para evitar desbordamientos */
    .table-responsive {
        overflow-x: auto;
        /* Habilitar scroll horizontal si es necesario */
        max-width: 100%;
    }

    /* Reducir el tamaño del título */
    h1 {
        font-size: 1.5rem !important;
        /* Título más compacto */
        margin-bottom: 0.5rem !important;
    }

    /* Ajustar el botón "Nueva Atención" */
    .btn .btn-primary {
        padding: 0.10rem 0.5rem;
        font-size: 0.875rem;
    }
</style>
<div class=" contenedor-general">
    <div class="card" style="border-color: #f2f4f7; box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
-webkit-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);
-moz-box-shadow: 1px 1px 0px 0px rgba(0,0,0,0.11);">
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <h1>Atención al cliente</h1>
                </div>
                <div class="col-md-6 text-end">
                    <a href="<?= $hostOnlyHeader ?>/views/ventas/registrar-atencion-cliente" class="btn btn-primary">Nueva Atencion</a>
                </div>
            </div>
            <div class="row">
                <div class="card border-0">
                    <div class="card-body">
                        <div class="row g-0 mb-3">
                            <div class="card border-0">
                                <div class="card-body border-0">
                                    <label for="">Filtros</label>
                                    <div class="row">
                                        <div class="col-md-1">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="ncotizacion" autocomplete="off">
                                                <label for="ncotizacion">N° Cot</label>
                                            </div>
                                        </div>
                                        <div class="col-md-1">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="ndocumento" autocomplete="off">
                                                <label for="ndocumento">DNI/RUC</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select name="nomusuario" id="nomusuario" class="form-select filter" required>
                                                </select>
                                                <label for="nomusuario">Artista</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="text" class="form-control filter" id="establecimiento" autocomplete="off">
                                                <label for="establecimiento">Lugar</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="date" class="form-control filter" id="fechapresentacion" autocomplete="off">
                                                <label for="fechapresentacion">Fecha</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <select id="mes" class="form-control filter">
                                                    <option value="">Seleccionar</option>
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
                                                <label for="mes">Mes</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-floating">
                                                <input type="week" id="año_semana" class="form-control filter">
                                                <label for="año_semana">Semana</label>
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
                                <thead class="text-center" style="background-color:rgb(255, 255, 255);">
                                    <tr>
                                        <th>N° Cotizacion</th>
                                        <th>Artista</th>
                                        <!-- <th>N° Documento/RUC</th>
                                        <th>Cliente</th>
                                        <th>Tipo evento</th>
                                        <th>Modalidad</th>
                                        <th>País</th> -->
                                        <th>Lugar</th>
                                        <th>Ubigeo</th>
                                        <th>Fecha presentacion</th>
                                        <!-- <th>Estado</th>
                                        <th>Estado propuesta</th> -->
                                        <th>Opciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tb-body-atencion" class="border-0">
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

<!-- MODAL PARA COTIZAR DE MANERA CONTRATO -->
<div class="modal fade" id="modal-previacotizacion" tabindex="-1" aria-labelledby="modalPreviaCotizacion" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalPreviaCotizacion">Previa cotizacion</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row g-1">
                    <div class="table-responsive">
                        <div class="contenedor-cotizacion">
                            <table class="table">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Departamento</th>
                                        <th>Provincia</th>
                                        <th>Tiempo Estimado</th>
                                        <th>Dificultad</th>
                                        <th>Precio S/.</th>
                                    </tr>
                                </thead>
                                <tbody id="tInfoCotizacion"></tbody>
                            </table>
                        </div>

                        <!-- TARIFA -->
                        <div class="contenedor-tarifa">
                            <table class="table">
                                <thead class="table-dark">
                                    <tr>
                                        <th colspan="3">Descripción</th>
                                        <th>Tiempo</th>
                                        <th>Costo</th>
                                    </tr>
                                </thead>
                                <tbody id="tInfoDescripcionTarifa"></tbody>
                            </table>
                        </div>
                        <div class="contenedor-tarifa-extranjero">
                            <table class="table">
                                <thead class="table-dark">
                                    <tr>
                                        <th colspan="3">Descripción</th>
                                        <th>Tiempo</th>
                                        <th>Tipo</th>
                                        <th>Precio</th>
                                        <th>Precio Viaje</th>
                                        <th>Opciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tInfoDescripcionTarifaExtranjero"></tbody>
                            </table>
                        </div>

                        <!-- PIE -->
                        <div class="d-flex justify-content-center mb-3">
                            <div class="form-floating col-md-8">
                                <select name="sucursal" id="sucursal" class="form-select">
                                    <option value="">Selecciona</option>
                                </select>
                                <label for="sucursal" class="form-label">Sucursal</label>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="btnGenerarCotizacion">Generar Cotizacion</button>
                <!--                 <button type="button" class="btn btn-primary btnGuardarContrato" id="close-mdl-cotizacion">Guardar y cerrar</button>
 -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-previageneracion" tabindex="-1" aria-labelledby="modalPreviaGeneracion" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalPreviaGeneracion">Seleccionar Sucursal</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex justify-content-center mb-3">
                    <div class="form-floating col-md-8">
                        <select name="sucursalDocumento" id="sucursalDocumento" class="form-select">
                            <option value="">Selecciona</option>
                        </select>
                        <label for="sucursalDocumento" class="form-label">Sucursal</label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="btnGenerarDocumento">Generar Documento</button>
                <!--                 <button type="button" class="btn btn-primary btnGuardarContrato" id="close-mdl-cotizacion">Guardar y cerrar</button>
 -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-infoevento" tabindex="-1" aria-labelledby="modalinfoevento" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalinfoevento">Informacion evento</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="contenedor-infoevento p-3">

                </div>
            </div>

        </div>
    </div>
</div>


<div class="modal fade" id="modal-datosclienteincompletos" tabindex="-1" aria-labelledby="modalDatosClienteIncompletos" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalDatosClienteIncompletos">Previa Contrato</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table rounded">
                    <tbody id="tDatosClienteIncompleto">
                        <span class="text-danger">Antes de generar contrato llena los datos del cliente</span>
                        <div class="row g-2 mt-2">
                            <div class="col-md-4">
                                <div class="form-floating border border-danger rounded">
                                    <input type="text" id="ndocumentocli" name="ndocumentocli"
                                        class="form-control">
                                    <label for="ndocumentocli" class="form-label">N° Documento <span class="text-danger">(*)</span></label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating  border border-danger rounded">
                                    <select name="nacionalidad" id="nacionalidad" class="form-select" required>
                                        <option value="" selected>Selecciona</option>
                                        <option value="31">Peruana</option>
                                    </select>
                                    <label for="nacionalidad" class="form-label">Nacionalidad <span class="text-danger">(*)</span></label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating border border-danger rounded">
                                    <select name="departamento" id="departamento" class="form-select" required>
                                    </select>
                                    <label for="departamento" class="form-label">Departamento <span class="text-danger">(*)</span></label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating border border-danger rounded">
                                    <select name="provincia" id="provincia" class="form-select" required>
                                    </select>
                                    <label for="provincia" class="form-label">Provincia <span class="text-danger">(*)</span></label>
                                </div>
                            </div>
                            <div class="col-md-3 ">
                                <div class="form-floating border border-danger rounded">
                                    <select name="distrito" id="distrito" class="form-select" required>
                                    </select>
                                    <label for="distrito" class="form-label">Distrito <span class="text-danger">(*)</span></label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating border border-danger rounded">
                                    <input type="text" id="razonsocial" name="razonsocial"
                                        class="form-control">
                                    <label for="razonsocial" class="form-label">Razon social/Nombre <span class="text-danger">(*)</span></label>
                                </div>
                            </div>
                            <div class="col-md-4" id="container-representantelegal" hidden>
                                <div class="form-floating">
                                    <input type="text" id="representantelegal" name="representantelegal"
                                        class="form-control">
                                    <label for="representantelegal" class="form-label">Representante legal</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <input type="number" id="telefono" name="telefono" maxlength="9" min="0"
                                        class="form-control">
                                    <label for="telefono" class="form-label">Telefono</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input type="text" id="correo" name="correo"
                                        class="form-control">
                                    <label for="correo" class="form-label">Correo</label>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-floating border border-danger rounded">
                                    <input type="text" id="direccion" name="direccion"
                                        class="form-control">
                                    <label for="direccion" class="form-label">Direccion <span class="text-danger">(*)</span></label>
                                </div>
                            </div>
                        </div>
                    </tbody>

                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="btnActualizarDatosCliente">Actualizar Datos</button>
                <button type="button" class="btn btn-primary btnGuardarContrato" id="close-mdl-datoscliente" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<!-- MODAL PARA CONTRATO CONVENIO -->
<div class="modal fade" id="modal-convenio" tabindex="-1" aria-labelledby="modalContratoConvenio" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalContratoConvenio">Propuesta de cliente</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row g-3 align-items-center">
                        <div class="row g-3 align-items-center">
                            <div class="col-md-4 text-end">
                                <label for="abonogarantia" class="form-label">Abono de garantía:</label>
                            </div>
                            <div class="col-md-8">
                                <div class="input-group">
                                    <span class="input-group-text">S/.</span>
                                    <input type="number" id="abonogarantia" name="abonogarantia" class="form-control">
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 align-items-center">
                            <div class="col-md-4 text-end">
                                <label for="abonopublicidad" class="form-label">Abono de publicidad:</label>
                            </div>
                            <div class="col-md-8">
                                <div class="input-group">
                                    <span class="input-group-text">S/.</span>
                                    <input type="number" id="abonopublicidad" name="abonopublicidad" class="form-control">
                                </div>
                            </div>
                        </div>

                        <hr>
                        <label for="porcentajevega" class="form-label">Acuerdo %</label>
                        <div class="row g-3 align-items-center">
                            <div class="col-md-4 text-end">
                                <label for="porcentajevega" class="form-label">Vega:</label>
                            </div>
                            <div class="col-md-8">
                                <div class="input-group">
                                    <input type="number" id="porcentajevega" name="porcentajevega" max="100" min="0" class="form-control">
                                    <span class="input-group-text">%</span>
                                </div>
                            </div>
                        </div>


                        <div class="row g-3 align-items-center">
                            <div class="col-md-4 text-end">
                                <label for="porcentajepromotor" class="form-label">Promotor:</label>
                            </div>
                            <div class="col-md-8">
                                <div class="input-group">
                                    <input type="number" id="porcentajepromotor" name="porcentajepromotor" max="100" min="0" class="form-control">
                                    <span class="input-group-text">%</span>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <label for="propuestacliente" class="form-label">Detalle:</label>
                        <div class="col-md-12">
                            <textarea class="form-control" id="propuestacliente" rows="3"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <div class="modal-body" id="contenedor-general-admins">
                <div class="container-fluid">
                    <p><strong>Enviar propuesta a:</strong></p>

                    <div class="contenedor-admins">

                    </div>
                </div>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-secondary" id="btnActualizarPropuesta">Actualizar</button>
                <!-- <button type="button" class="btn btn-secondary" id="btnGuardarPendiente">Guardar pendiente</button> -->
                <!-- <button type="button" class="btn btn-secondary" id="btnAprobarPropuesta">Aprobar Propuesta</button> -->
                <button type="button" class="btn btn-secondary" id="btnEnviarPropuesta">Enviar la Propuesta</button>
            </div>

        </div>
    </div>
</div>


<!-- MODAL PARA CONTRATO CONVENIO -->
<div class="modal fade" id="modal-contrato" tabindex="-1" aria-labelledby="modalContrato" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalContrato">Pagar Contrato de Presentación</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row g-2 d-flex justify-content-center">
                            <div class="col-md-6 ">
                                <!-- <label for="" style="text-align: center; color: red;">Recordatorio: Si el tarifario no esta definido para este lugar no podrá hacer los cálculos</label> -->
                                <div id="montoActual">

                                </div>
                                <div class="form-floating ">
                                    <input type="number" id="montopagado" name="montopagado"
                                        class="form-control " min="0">
                                    <label for="montopagado" class="form-label">Monto</label>
                                </div>
                                <div id="porciento">

                                </div>
                                <div class="form-floating mt-3">
                                    <select name="tipopago" id="tipopago" class="form-select">
                                        <option value="-1">Selecciona</option>
                                        <option value="1">Transferencia</option>
                                        <option value="2">Contado</option>
                                    </select>
                                    <label for="tipopago" class="form-label">Tipo de pago</label>
                                </div>
                                <div class="form-floating mt-3" id="contenedor-noperacion" hidden>
                                    <input type="text" id="noperacion" name="noperacion"
                                        class="form-control " min="0">
                                    <label for="noperacion" class="form-label">N° Operacion</label>
                                </div>
                                <div id="historialpagos">
                                    <a href="<?= $hostOnlyHeader ?>/views/contabilidad/pagos/listar-pagos" target="_blank">Ver Historial de pagos</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer" id="contenedor-botones">
                <button type="button" class="btn btn-secondary" id="btnGuardar" hidden>Guardar</button>
                <!-- <button type="button" class="btn btn-secondary" id="btnGenerarReserva" hidden>Generar Reserva</button> -->
                <button type="button" class="btn btn-primary" id="close-mdl-convenio" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-reserva" tabindex="-1" aria-labelledby="modalReserva" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalReserva">Detalles a previa reserva</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row g-2 d-flex justify-content-center">
                            <div class="col-md-6 ">
                                <div class="form-floating ">
                                    <input type="number" id="vigencia" name="vigencia"
                                        class="form-control " min="0">
                                    <label for="vigencia" class="form-label">Vigencia</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer" id="contenedor-botones">
                <button type="button" class="btn btn-secondary" id="btnGuardarReserva">Guardar</button>
                <!-- <button type="button" class="btn btn-secondary" id="btnGenerarReserva" hidden>Generar Reserva</button> -->
                <button type="button" class="btn btn-primary" id="close-mdl-convenio" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-responsables" tabindex="-1" aria-labelledby="modalresponsables" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalresponsables">Seleccionar Respnsables</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row g-2 d-flex justify-content-center">
                            <div class="col-md-6 ">
                                <div class="form-floating mt-3">
                                    <select name="boleteria" id="boleteria" class="form-select">

                                    </select>
                                    <label for="boleteria" class="form-label">De boletería</label>
                                </div>
                                <div class="form-floating mt-3">
                                    <select name="contrato" id="contrato" class="form-select">

                                    </select>
                                    <label for="contrato" class="form-label">De cerrar contrato</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer" id="contenedor-botones">
                <button type="button" class="btn btn-secondary" id="btnGuardarResponsables">Guardar</button>
                <!-- <button type="button" class="btn btn-secondary" id="btnGenerarReserva" hidden>Generar Reserva</button> -->
                <!--                 <button type="button" class="btn btn-primary" id="close-mdl-convenio" data-bs-dismiss="modal">Cerrar</button>
 -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-precioentrada" tabindex="-1" aria-labelledby="modalprecioentrada" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modalprecioentrada">Configurar precios de entrada</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="row justify-content-center">
                            <div class="col-md-6">
                                <div class=" mb-3">
                                    <label for="entradas">Descripcion</label>
                                    <textarea class="form-control" id="entradas" name="entradas" rows="10"></textarea>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="modal-footer" id="contenedor-botones">
                <button type="button" class="btn btn-secondary" id="btnGuardarPrecioEntrada">Guardar</button>
                <button type="button" class="btn btn-secondary" id="btnActualizarPrecioEntrada" hidden>Actualizar</button>
            </div>
        </div>
    </div>
</div>

<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="<?= $hostOnlyHeader ?>/js/ventas/listar-atencion.js"></script>

</body>

</html>