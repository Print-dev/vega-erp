document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let clienteSelect = $q("#idcliente");
    let idcuotacomprobante
    let idcomprobante
    let pagosCuotas = []
    let montoapagar

    // MODALES
    let modalHistorialAbonados
    let modalAbonar

    function $q(object = null) {
        return document.querySelector(object);
    }

    function $all(object = null) {
        return document.querySelectorAll(object);
    }

    async function getDatos(link, params) {
        let data = await fetch(`${link}?${params}`);
        return data.json();
    }

    await obtenerClientes()

    // ************************************************ OBTENER DATOS ****************************************************

    async function obtenerClientes() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerClientes");
        const data = await getDatos(`${host}cliente.controller.php`, params);
        console.log("data .> ", data);
        clienteSelect.innerHTML = '<option value="">Selecciona</option>'
        data.forEach(cliente => {
            clienteSelect.innerHTML += `<option value="${cliente.idcliente}">${cliente.razonsocial}</option>`
        });
        return data
    }

    async function obtenerPagosCuotasPorIdCuota(idcuotacomprobante) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerPagosCuotasPorIdCuota");
        params.append("idcuotacomprobante", idcuotacomprobante);
        const data = await getDatos(`${host}comprobante.controller.php`, params);
        console.log("data .> ", data);
        return data
    }
    async function obtenerComprobantePorTipoDoc(idcomprobante) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerComprobantePorTipoDoc");
        params.append("idcomprobante", idcomprobante);
        params.append("idtipodoc", '01');
        const data = await getDatos(`${host}comprobante.controller.php`, params);
        console.log("data .> ", data);
        return data
    }



    async function registrarPagoCuota(idcuotacomprobante, montopagado, tipopago, noperacion) {
        const comprobante = new FormData();
        comprobante.append("operation", "registrarPagoCuota");
        comprobante.append("idcuotacomprobante", idcuotacomprobante); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
        comprobante.append("montopagado", montopagado);
        comprobante.append("tipopago", tipopago);
        comprobante.append("noperacion", noperacion);

        const fcomprobante = await fetch(`${host}comprobante.controller.php`, {
            method: "POST",
            body: comprobante,
        });
        const rcomprobante = await fcomprobante.json();
        //console.log("rivatico . ", rcomprobante)
        return rcomprobante;
    }

    async function actualizarEstadoCuotaComprobante(idcuotacomprobante, estado) {
        const comprobante = new FormData();
        comprobante.append("operation", "actualizarEstadoCuotaComprobante");
        comprobante.append("idcuotacomprobante", idcuotacomprobante);
        comprobante.append("estado", estado);

        const fcomprobante = await fetch(`${host}comprobante.controller.php`, {
            method: "POST",
            body: comprobante,
        });
        const rcomprobante = await fcomprobante.json();
        //console.log("rivatico . ", rcomprobante)
        return rcomprobante;
    }

    async function actualizarPagado50DP(iddetallepresentacion) {
        const pagado50 = new FormData();
        pagado50.append("operation", "actualizarPagado50DP");
        pagado50.append("iddetallepresentacion", iddetallepresentacion);
        pagado50.append("pagado50", 1);

        const fpagado50 = await fetch(`${host}detalleevento.controller.php`, {
            method: "POST",
            body: pagado50,
        });
        const rpagado50 = await fpagado50.json();
        return rpagado50;
    }

    async function actualizarEstadoReservaDp(iddetallepresentacion, estreserva) {
        const reserva = new FormData();
        reserva.append("operation", "actualizarEstadoReservaDp");
        reserva.append("iddetallepresentacion", iddetallepresentacion);
        reserva.append("reserva", estreserva);

        const freserva = await fetch(`${host}detalleevento.controller.php`, {
            method: "POST",
            body: reserva,
        });
        const rreserva = await freserva.json();
        return rreserva;
    }


    // ******************************* CONFIGURACION DE TABLA *******************************************************

    function createTable(data) {
        let rows = $("#tb-body-cuota").find("tr");
        ////console.log(rows.length);
        if (data.length > 0) {
            if (myTable) {
                if (rows.length > 0) {
                    myTable.clear().rows.add(rows).draw();
                } else if (rows.length === 1) {
                    myTable.clear().draw(); // Limpia la tabla si no hay filas.
                }
            } else {
                // Inicializa DataTable si no ha sido inicializado antes
                myTable = $("#table-cuotas").DataTable({
                    paging: true,
                    searching: false,
                    lengthMenu: [5, 10, 15, 20],
                    pageLength: 5,
                    language: {
                        lengthMenu: "Mostrar _MENU_ filas por página",
                        paginate: {
                            previous: "Anterior",
                            next: "Siguiente",
                        },
                        search: "Buscar:",
                        info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
                        emptyTable: "No se encontraron registros",
                    },
                });
                // if (rows.length > 0) {
                //   myTable.rows.add(rows).draw(); // Si hay filas, agrégalas.
                // }
            }
        }
    }


    (async () => {
        await dataFilters();
    })();


    changeByFilters()

    function changeByFilters() {
        const filters = $all(".filter");
        $q("#table-cuotas tbody").innerHTML = "";
        filters.forEach((x) => {
            x.addEventListener("change", async () => {
                await dataFilters();
            });
            if (x.id === "fecha") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "numerocomprobante") {
                x.addEventListener("input", async (e) => {
                    console.log(e.target.value);
                    await dataFilters();
                });
            }
            if (x.id === "idcliente") {
                x.addEventListener("change", async (e) => {
                    console.log(e.target.value);
                    await dataFilters();
                });
            }
        });
    }

    chargerEventsButton();

    async function dataFilters() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarCuotas");
        params.append("fecha", $q("#fecha").value ? $q("#fecha").value : '');
        params.append("numerocomprobante", $q("#numerocomprobante").value ? $q("#numerocomprobante").value : '');
        params.append("idcliente", $q("#idcliente").value ? $q("#idcliente").value : '');
        //alert("asdasdd")
        const data = await getDatos(`${host}comprobante.controller.php`, params);
        //console.log(data);
        console.log("data -> ", data)
        $q("#table-cuotas tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-cuotas tbody").innerHTML = `
              <tr>
                <td colspan="9">Sin resultados</td>
              </tr>
              `;
        }

        data.forEach(async (x, i) => {
            $q("#table-cuotas tbody").innerHTML += `
              <tr>
                <td>${x.fecha}</td>
                <td>${x.razonsocial} - ${x.ndocumento}</td>
                <td>${x.monto_a_pagar}</td>
                <td>${x.total_pagado}</td>
                <td>${x.numero_comprobante}</td>                                                                            
                <td>${x.estado == 0 ? 'pendiente' : x.estado == 1 ? 'pagado' : x.estado == 2 ? 'vencido' : ''}</td>                                                                            
                <td>
                    <button class="btn btn-primary btn-ver-historial" data-idcuotacomprobante=${x.idcuotacomprobante} title="Ver historial">
                    Ver historial
                    </button>                                                          
                </td>
                <td>
                    <button class="btn btn-primary btn-abonar" data-idcuotacomprobante=${x.idcuotacomprobante} data-idcomprobante=${x.idcomprobante} data-montoapagar=${x.monto_a_pagar} data-estado=${x.estado} ${x.estado == 1 ? 'disabled' : x.estado == 2 ? 'disabled' : ''} title="Abonar">
                    Abonar
                    </button>                                                          
                </td>
              </tr>
              `;
            if (x.fecha < obtenerFechaHoraPeru()) {
                $q("#table-cuotas tbody").lastElementChild.classList.add('bg-danger')

                if (x.estado == 1) {
                    const estadoCuotaActualizado = await actualizarEstadoCuotaComprobante(x.idcuotacomprobante, 2)
                    console.log("estado cuota actualizado -> ", estadoCuotaActualizado);

                }
            }
        });
        //disabledBtnArea();
        createTable(data);


    }

    function createTable(data) {
        let rows = $("#tb-body-cuota").find("tr");
        ////console.log(rows.length);
        if (data.length > 0) {
            if (myTable) {
                if (rows.length > 0) {
                    myTable.clear().rows.add(rows).draw();
                } else if (rows.length === 1) {
                    myTable.clear().draw(); // Limpia la tabla si no hay filas.
                }
            } else {
                // Inicializa DataTable si no ha sido inicializado antes
                myTable = $("#table-cuotas").DataTable({
                    paging: true,
                    searching: false,
                    lengthMenu: [5, 10, 15, 20],
                    pageLength: 5,
                    language: {
                        lengthMenu: "Mostrar _MENU_ filas por página",
                        paginate: {
                            previous: "Anterior",
                            next: "Siguiente",
                        },
                        search: "Buscar:",
                        info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
                        emptyTable: "No se encontraron registros",
                    },
                });
                // if (rows.length > 0) {
                //   myTable.rows.add(rows).draw(); // Si hay filas, agrégalas.
                // }
            }
        }
    }

    /**
  * Carga los botones que estan en la tabla
  */
    function chargerEventsButton() {
        document.querySelector(".table-responsive").addEventListener("click", async (e) => {
            if (e.target) {
                idactivo = 0;
                if (e.target.classList.contains("btn-ver-historial")) {
                    btnVerHistorial(e);
                }
                if (e.target.classList.contains("btn-abonar")) {
                    btnAbonar(e);
                }
                /* if (e.target.classList.contains("btn-cuotas-comprobante")) {
                    buttonCuotaComprobante(e);
                }
 */
                /* if (e.target.classList.contains("btn-habilitar")) {
                    buttonHabilitar(e);
                } */
                /* if(e.target.classList.contains("btn-info-baja")){
                  await showReporte(e);
                }
                if(e.target.classList.contains("show-espec")){//abre el sidebar
                  await btnSBUpdateActivo(e);
                }
                if (e.target.classList.contains("change-area")) {
                  buttonCambiarArea(e);
                } */
            }
        });
    }

    async function btnVerHistorial(e) {
        pagosCuotas = []
        idcuotacomprobante = e.target.getAttribute("data-idcuotacomprobante");

        modalHistorialAbonados = new bootstrap.Modal($q("#modal-historialabonados"))
        modalHistorialAbonados.show();
        pagosCuotas = await obtenerPagosCuotasPorIdCuota(idcuotacomprobante)
        console.log("pagos cuotas -> ", pagosCuotas);
        $q(".contenedor-historialabonados").innerHTML = ''
        if (pagosCuotas.length > 0) {
            pagosCuotas.forEach(pagos => {
                $q(".contenedor-historialabonados").innerHTML += `
                <div class="w-100">
                    <div class="d-flex justify-content-between align-items-center mt-3">
                        <span>${formatDate(pagos.fechapagado)} <span class="badge bg-info p-2">${formatHour(pagos.horapagado)}</span></span>
                        <span class="badge bg-primary p-2">S/ ${pagos.montopagado}</span>
                    </div>                        
                </div>
                <hr>
            `
            });
        } else {
            $q(".contenedor-historialabonados").innerHTML = `
                <div class="w-100">
                    <div class="d-flex justify-content-center align-items-center mt-3">
                        <span>No hay pagos registrados</span>
                    </div>                        
                </div>
            `
        }
    }

    async function btnAbonar(e) {
        pagosCuotas = []
        idcuotacomprobante = e.target.getAttribute("data-idcuotacomprobante");
        idcomprobante = e.target.getAttribute("data-idcomprobante");
        montoapagar = e.target.getAttribute("data-montoapagar");
        estado = e.target.getAttribute("data-estado");

        if (estado == 1) {
            showToast("Esta cuota ya esta pagada", "INFO")
            return
        }
        modalAbonar = new bootstrap.Modal($q("#modal-abonar"))
        modalAbonar.show();
        pagosCuotas = await obtenerPagosCuotasPorIdCuota(idcuotacomprobante)
        console.log("pagos cuotas -> ", pagosCuotas);

    }

    $q("#btnAbonar").addEventListener("click", async () => {
        const comprobantes = await obtenerComprobantePorTipoDoc(idcomprobante)
        console.log("comprobantes -<", comprobantes);
        const monto = parseFloat(comprobantes[0].monto); // por ejemplo 71.700
        const iddp = comprobantes[0].iddetallepresentacion
        const porcentaje25 = monto * 0.25;
        const porcentaje50 = monto * 0.50;

        console.log("monto total del comprobante --> ", monto);
        const cuotaPagada = await registrarPagoCuota(idcuotacomprobante, $q("#montopagado").value, $q("#tipopago").value, $q("#noperacion").value)
        console.log("cuota pagada -> ", cuotaPagada);
        if (cuotaPagada) {
            showToast("pagado correctamente", "SUCCESS")

            modalAbonar.hide()
            await dataFilters()
            const sumaCuotasActuales = pagosCuotas.reduce((acum, cuota) => {
                return acum + parseFloat(cuota.montopagado || 0);
            }, 0);
            console.log("sumaCuotasActuales -> ", sumaCuotasActuales);
            const sumaTotal = sumaCuotasActuales + parseFloat($q("#montopagado").value)
            console.log("sumaCuotas + el actual -> ", sumaTotal);
            const esEntre25y50 = sumaTotal >= porcentaje25 && sumaTotal < porcentaje50;

            $q("#montopagado").value = ''
            $q("#tipopago").value = ''
            $q("#noperacion").value = ''
            if (sumaTotal >= parseFloat(montoapagar)) {
                console.log("es igual al 50%");

                showToast("Cuota pagada correctamente", "SUCCESS")
                modalAbonar.hide()
                const cuotaPagada = await actualizarEstadoCuotaComprobante(idcuotacomprobante, 1)
                console.log("cuota pagada -> ", cuotaPagada);
                await dataFilters()
                const pagado50 = await actualizarPagado50DP(iddp)
                console.log("pagado 50% -> ", pagado50);
                return
            } else if (esEntre25y50) {
                console.log("es igual al 25%");
                const reservaGenerada = await actualizarEstadoReservaDp(iddp, 1)
                console.log("reservaGenerada -> ", reservaGenerada);
            }


        } else {
            alert("Error al pagar la cuota")
        }
    })
})