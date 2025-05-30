document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;

    // MODALES
    let modalVerificarSunat

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

    // **************************************** OBTENER DATA *****************************************************

    async function obtenerDetallesComprobante(idcomprobante) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDetallesComprobante");
        params.append("idcomprobante", idcomprobante);
        const data = await getDatos(`${host}comprobante.controller.php`, params);
        return data
    }

    // ***************************** REGISTROS DE DATA **************************************************************

    async function descargarXML(archivo) {
        const params = new URLSearchParams();
        params.append("operation", "descargarXML");
        params.append("archivo", archivo);
        const data = await getDatos(`${host}comprobante.controller.php`, params);
        return data
    }

    /*   async function descargarXML(archivo) {
          const comprobante = new FormData();
          comprobante.append("operation", "descargarXML");
          comprobante.append("archivo", archivo)
  
          const fcomprobante = await fetch(`${host}comprobante.controller.php`, {
              method: "POST",
              body: comprobante,
          });
          const rcomprobante = await fcomprobante.json();
          //console.log("rivatico . ", rcomprobante)
          return rcomprobante;
      }
   */

    // ******************************* CONFIGURACION DE TABLA *******************************************************

    function createTable(data) {
        let rows = $("#tb-body-factura").find("tr");
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
                myTable = $("#table-facturas").DataTable({
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
        $q("#table-facturas tbody").innerHTML = "";
        filters.forEach((x) => {
            x.addEventListener("change", async () => {
                await dataFilters();
            });
            if (x.id === "numerocomprobante") {
                x.addEventListener("input", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "fechaemision") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "horaemision") {
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
        params.append("operation", "filtrarFacturas");
        params.append("fechaemision", $q("#fechaemision").value ? $q("#fechaemision").value : '');
        params.append("horaemision", $q("#horaemision").value ? $q("#horaemision").value : '');
        params.append("numerocomprobante", $q("#numerocomprobante").value ? $q("#numerocomprobante").value : '');
        //alert("asdasdd")
        const data = await getDatos(`${host}comprobante.controller.php`, params);
        //console.log(data);
        console.log("data -> ", data)
        $q("#table-facturas tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-facturas tbody").innerHTML = `
              <tr>
                <td colspan="9">Sin resultados</td>
              </tr>
              `;
        }

        data.forEach((x, i) => {
            $q("#table-facturas tbody").innerHTML += `
              <tr>
                <td>${x.fechaemision} - ${x.horaemision}</td>
                <td>${x.numero_comprobante}</td>
                <td>${x.razonsocial} - ${x.ndocumento}</td>
                <td>S/ ${x.total_valortotal}</td>                                                                            
                <td>
                    <button class=" btn-verificar-sunat border-0 bg-white" style="cursor: pointer;" data-idcomprobante=${x.idcomprobante} title="Verificar Sunat">
                        <img class="hidden-event-icon" src="https://www.svgrepo.com/show/402906/white-heavy-check-mark.svg" style="width: 24px; height: 24px;">
                    </button>
                    <button class="btn-pdf-comprobante border-0 bg-white" style="cursor: pointer;" data-idcomprobante=${x.idcomprobante} title="Descargar PDF Comprobante">
                        <img class="hidden-event-icon" src="https://apisunat.codersfree.com/img/icons/pdf_cpe.svg" style="width: 24px; height: 24px;">
                    </button>
                    <button class=" btn-xml-comprobante border-0 bg-white" style="cursor: pointer;" data-idcomprobante=${x.idcomprobante} data-serie=${x.nserie} data-correlativo=${x.correlativo} title="Descargar XML Comprobante">
                        <img class="hidden-event-icon" src="https://apisunat.codersfree.com/img/icons/xml_cpe.svg" style="width: 24px; height: 24px;">
                    </button>
                    <button class=" btn-cdr-comprobante border-0 bg-white" style="cursor: pointer;" data-idcomprobante=${x.idcomprobante} data-serie=${x.nserie} data-correlativo=${x.correlativo} title="Descargar CDR Comprobante">
                        <img class="hidden-event-icon" src="https://apisunat.codersfree.com/img/icons/get_cdr.svg" style="width: 24px; height: 24px;">
                    </button>
                    
                </td>
              </tr>
              `;
        });
        //disabledBtnArea();
        createTable(data);

    }

    function createTable(data) {
        let rows = $("#tb-body-factura").find("tr");
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
                myTable = $("#table-facturas").DataTable({
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
                if (e.target.classList.contains("btn-verificar-sunat")) {
                    btnVerificarSunat(e);
                }
                if (e.target.classList.contains("btn-pdf-comprobante")) {

                    buttonPDFComprobante(e);
                }
                if (e.target.classList.contains("btn-xml-comprobante")) {
                    buttonXMLComprobante(e);
                }
                if (e.target.classList.contains("btn-cdr-comprobante")) {
                    buttonCDRComprobante(e);
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

    async function btnVerificarSunat(e) {
        idcomprobante = e.target.getAttribute("data-idcomprobante");

        /* modalVerificarSunat = new bootstrap.Modal($q("#modal-verificarsunat"))
        modalVerificarSunat.show() */

        const detallesComprobante = await obtenerDetallesComprobante(idcomprobante)
        console.log("detalles comprobante -> ", detallesComprobante);

        showHtmlInfo({
            icon: "success",
            title: "<strong>Detalles de la factura</strong>",
            html: `
            <div class="w-100">
                <div class="d-flex justify-content-between align-items-center">
                    <span>Factura</span>
                    <span class="badge bg-primary p-2">F001</span>
                </div>
                <div class="d-flex align-items-center mt-4">
                    <i class="fa-solid fa-check me-2 text-success"></i>
                    <span>Enviado a SUNAT</span>
                </div>
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <span>Estado</span>
                    <span class="badge bg-primary p-2">${detallesComprobante[0]?.estado}</span>
                </div>
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <span>Codigo</span>
                    <span class="badge bg-primary p-2">0</span>                    
                </div>
                <div class="row text-center mt-4">
                    <span>${detallesComprobante[0]?.info}</span>
                </div>
            </div>
            `,
            icon: "success",
            footer: "Vega Producciones V.1.0"
        });

    }

    async function buttonPDFComprobante(e) {
        idcomprobante = e.target.getAttribute("data-idcomprobante");
        window.open(
            `${hostOnly}/generators/generadores_pdf/comprobantefactura/comprobantefactura.php?idcomprobante=${idcomprobante}&idtipodoc=01`
        );
    }

    async function buttonXMLComprobante(e) {
        idcomprobante = e.target.getAttribute("data-idcomprobante");
        serie = e.target.getAttribute("data-serie");
        correlativo = e.target.getAttribute("data-correlativo");
        //const url = `${hostOnly}/descargar_xml.php?archivo=${encodeURIComponent(nombreArchivo)}`;
        console.log("descargarXML -> ");
        console.log(`${rucEmpresa}-01-${serie}-${correlativo}`);
        const nombreArchivo = `${rucEmpresa}-01-${serie}-${correlativo}`;

        // Redirecciona al script PHP que hace la descarga
        window.open(`${hostOnly}/controllers/comprobante.controller.php?operation=descargarXML&archivo=${encodeURIComponent(nombreArchivo)}`, '_blank');
    }

    async function buttonCDRComprobante(e) {
        idcomprobante = e.target.getAttribute("data-idcomprobante");
        serie = e.target.getAttribute("data-serie");
        correlativo = e.target.getAttribute("data-correlativo");
        //const url = `${hostOnly}/descargar_xml.php?archivo=${encodeURIComponent(nombreArchivo)}`;
        console.log("descargarXML -> ");
        console.log(`${rucEmpresa}-01-${serie}-${correlativo}`);
        const nombreArchivo = `R-${rucEmpresa}-01-${serie}-${correlativo}`;

        // Redirecciona al script PHP que hace la descarga
        window.open(`${hostOnly}/controllers/comprobante.controller.php?operation=descargarCDR&archivo=${encodeURIComponent(nombreArchivo)}`, '_blank');
    }

    /*     async function buttonCuotaComprobante(e) {
            idcomprobante = e.target.getAttribute("data-idcomprobante");
            window.location.clear()
            window.localStorage.setItem("idcomprobante", idcomprobante);
            window.location.href = `${hostOnly}/views/contabilidad/cuotas`;	
        } */
})