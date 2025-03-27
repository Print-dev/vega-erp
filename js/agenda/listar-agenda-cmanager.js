document.addEventListener("DOMContentLoaded", async () => {
    // modales
    let modalContenidos

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


    async function obtenerDps(idusuario) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDps");
        params.append("idusuario", idusuario);
        const data = await getDatos(`${host}tareadiaria.controller.php`, params);
        return data
    }

    // ******************************************** DATATABLE ************************************************

    function createTable(data) {
        let rows = $("#tb-body-atencion").find("tr");
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
                myTable = $("#table-atenciones").DataTable({
                    processing: true, // Muestra un indicador de carga
                    serverSide: true, // Activa la paginación en el servidor
                    ajax: {
                        url: `${host}detalleevento.controller.php`,
                        type: "POST",
                        data: function (d) {
                            d.operation = "filtrarAtenciones";
                            d.ncotizacion = $("#ncotizacion").val() || "";
                            d.ndocumento = $("#ndocumento").val() || "";
                        }
                    },
                    columns: [
                        { data: "iddetalle_presentacion" },
                        { data: "ncotizacion", defaultContent: "No aplica" },
                        { data: "nom_usuario", defaultContent: "" },
                        { data: "ndocumento", defaultContent: "" },
                        { data: "razonsocial", defaultContent: "" },
                        {
                            data: "tipo_evento",
                            render: function (data) {
                                return data == 1 ? "Público" : data == 2 ? "Privado" : "";
                            }
                        },
                        {
                            data: "modalidad",
                            render: function (data) {
                                return data == 1 ? "Convenio" : data == 2 ? "Contrato" : "";
                            }
                        },
                        { data: "fecha_presentacion" },
                        {
                            data: "estado",
                            render: function (data) {
                                return data == 1 ? "Activo" : data == 2 ? "Caducado" : "";
                            }
                        },
                        { data: "opciones", orderable: false, searchable: false }
                    ],
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
                    }
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

    changeByFilters();

    function changeByFilters() {
        const filters = $all(".filter");
        $q("#table-atenciones tbody").innerHTML = "";
        filters.forEach((x) => {
            /* x.addEventListener("change", async () => {
              await dataFilters();
            }); */
            if (x.id === "ncotizacion") {
                x.addEventListener("input", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "ndocumento") {
                x.addEventListener("input", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "nomusuario") {
                x.addEventListener("input", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "establecimiento") {
                x.addEventListener("input", async () => {
                    await dataFilters();
                });
            }
        });
    }


    chargerEventsButton();

    async function dataFilters() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarAtenciones");
        params.append(
            "ncotizacion",
            $q("#ncotizacion").value ? $q("#ncotizacion").value : ""
        );
        params.append(
            "ndocumento",
            $q("#ndocumento").value ? $q("#ndocumento").value : ""
        );
        params.append("nomusuario", $q("#nomusuario").value ? $q("#nomusuario").value : "")
        params.append("establecimiento", $q("#establecimiento").value ? $q("#establecimiento").value : "")

        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        console.log("data -> ", data);

        const tbody = $q("#table-contenidos tbody");
        tbody.innerHTML = "";

        if (data.length === 0) {
            tbody.innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
            return; // Salimos de la función si no hay datos
        }

        for (const x of data) {

            tbody.innerHTML += `
            <tr>
                <td>${x.ncotizacion ? x.ncotizacion : 'no aplica'}</td>
                <td>${x.nom_usuario ? x.nom_usuario : ''}</td>
                <td>${x.ndocumento ? x.ndocumento : ''}</td>
                <td>${x.razonsocial ? x.razonsocial : ''}</td>
                <td>${x.tipo_evento == 1 ? "Público" : x.tipo_evento == 2 ? "Privado" : ``}</td>
                <td>${x.modalidad == 1 ? "Convenio" : x.modalidad == 2 ? "Contrato" : ``}</td>
                <td>${x.establecimiento ? x.establecimiento : ``}</td>
                <td>${x.departamento}/${x.provincia}/${x.distrito}</td>
                <td>${x.fecha_presentacion}</td>                        
                <td>${x.estado == 1 ? 'Activo' : x.estado == 2 ? 'Caducado' : x.estado == 3 ? 'Cancelado' : ''}</td>                        
                <td>
                    ${x.estado == 3 ? '' : `
                        ${x.estado == 2 ? '' : parseInt(x.estado_convenio) == 2 ? `
                        <button type="button" class="btn btn-sm btn-warning btn-propuesta" data-idusuario="${x.idusuario}" data-fechapresentacion="${x.fecha_presentacion}" data-id=${x.iddetalle_presentacion} title="Detalles propuesta">
                            Detalles Propuesta
                        </button>
                        <button type="button" class="btn btn-sm btn-warning btn-convenio" data-id=${x.iddetalle_presentacion} title="Generar Convenio">
                            Generar Convenio
                        </button>
                    ` : parseInt(x.modalidad) == 1 ? `
                        <button type="button" class="btn btn-sm btn-warning btn-propuesta" data-idusuario="${x.idusuario}" data-fechapresentacion="${x.fecha_presentacion}" data-id=${x.iddetalle_presentacion} title="Detalles propuesta">
                            Detalles Propuesta
                        </button>
                        <button type="button" class="btn btn-sm btn-warning btn-convenio" data-id=${x.iddetalle_presentacion} title="Generar Convenio">
                            Generar Convenio
                        </button>
                    ` : parseInt(x.modalidad) == 2 ? `
                        <button type="button" class="btn btn-sm btn-success btn-cotizar" data-id=${x.iddetalle_presentacion} data-estado=${x.condicion} title="Cotizar">Cotizar</button>
                    ` : ``}

                    ${x.estado == 2 ? '' : parseInt(x.modalidad) === 2 ? `
                        <button type="button" class="btn btn-sm btn-secondary btn-pagar" data-id=${x.iddetalle_presentacion} title="Pagar">
                            Pagar
                        </button>
                        <button type="button" class="btn btn-sm btn-secondary btn-contrato" data-id=${x.iddetalle_presentacion} title="Generar contrato">
                            Generar Contrato
                        </button>
                    ` : ``}

                    ${x.estado == 2 ? '' : parseInt(x.pagado50) == 1 ? `` : parseInt(x.reserva) == 1 ? `
                        <button type="button" class="btn btn-sm btn-primary btn-reserva" data-id=${x.iddetalle_presentacion} title="Generar Reserva">
                            Generar Reserva
                        </button>
                    ` : ``}

                      ${x.tienecaja == 1 ? '' : x.modalidad == 2 ? '' : `<button type="button" class="btn btn-sm btn-warning btn-caja" data-id=${x.iddetalle_presentacion} title="Generar Caja Chica">
                          Generar Caja Chica  
                      </button> `
                    }
                    <button type="button" class="btn btn-sm btn-primary btn-actualizar" data-id=${x.iddetalle_presentacion} title="Actualizar Evento">
                        Actualizar
                      </button>
                    <button type="button" class="btn btn-sm btn-danger btn-cancelar" data-id=${x.iddetalle_presentacion} title="Cancelar Evento">
                        Cancelar
                      </button>
                      `}
                </td>
            </tr>
        `;

            
        }
        createTable(data);
    }

    function createTable(data) {
        let rows = $("#tb-body-atencion").find("tr");
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
                myTable = $("#table-atenciones").DataTable({
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
        document
            .querySelector(".table-responsive")
            .addEventListener("click", async (e) => {
                if (e.target) {
                    idactivo = 0;
                    if (e.target.classList.contains("btn-propuesta")) {
                        await buttonPropuesta(e);
                    }
                    if (e.target.classList.contains("btn-cotizar")) {
                        await buttonCotizar(e);
                    }
                    if (e.target.classList.contains("btn-pagar")) {
                        await buttonPagar(e);
                    }
                    if (e.target.classList.contains("btn-contrato")) {
                        await buttonContrato(e);
                    }
                    if (e.target.classList.contains("btn-reserva")) {
                        await buttonReserva(e);
                    }
                    if (e.target.classList.contains("btn-convenio")) {
                        await buttonConvenio(e);
                    }
                    if (e.target.classList.contains("btn-caja")) {
                        await buttonCaja(e);
                    }
                    if (e.target.classList.contains("btn-actualizar")) {
                        await buttonActualizar(e);
                    }
                    if (e.target.classList.contains("btn-cancelar")) {
                        await buttonCancelar(e);
                    }
                    /* if(e.target.classList.contains("show-espec")){//abre el sidebar
                    await btnSBUpdateActivo(e);
                  }
                  if (e.target.classList.contains("change-area")) {
                    buttonCambiarArea(e);
                  } */
                }
            });
    }

    // ********************************************* OBTENCION DE DATASA ****************************************************************


    // ********************************************* REGISTROS Y ACTUALIZACION DE DATASA ****************************************************************

    async function asignarPortalWebContenido(idagendacommanager, portalpublicar) {
        const body = new FormData();
        body.append("operation", "asignarPortalWebContenido");
        body.append("idagendacommanager", idagendacommanager); // id artista
        body.append("portalpublicar", portalpublicar);

        const fbody = await fetch(`${host}agendacmanager.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function actualizarEstadoPublicarContenido(idagendacommanager, estado) {
        const body = new FormData();
        body.append("operation", "actualizarEstadoPublicarContenido");
        body.append("idagendacommanager", idagendacommanager); // id artista
        body.append("estado", estado);

        const fbody = await fetch(`${host}agendacmanager.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }
    // ********************************************* EVENTOS  ****************************************************************
})