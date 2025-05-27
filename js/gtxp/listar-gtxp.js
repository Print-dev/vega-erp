document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let idcolaborador
    let idnomina
    let idgastoentrada
    let modalPagar = new bootstrap.Modal($q("#modal-pagar"))
    /*     let modalNuevoProvedor = new bootstrap.Modal($q("#modal-nuevo-proveedor"))
        let modalActualizarProveedor = new bootstrap.Modal($q("#modal-actualizar-proveedor"))
     */
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

    $q("#div-detalles").hidden = true
    $q("#div-comprobante-pago").hidden = true
    /*     $q("#div-detalles").hidden = true
     */

    // ************************************ REGISTRAR DATOS ********************************
    await obtenerUsuariosPorNivel()
    await obtenerEventos()

    async function obtenerUsuariosPorNivel() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", 6);

        try {
            const data = await getDatos(`${host}usuario.controller.php`, params);

            console.log(data);
            $q("#artista").innerHTML = '<option value="">Todos</option>'
            data.forEach(artista => {
                $q("#artista").innerHTML += `
                    <option value="${artista.idusuario}">${artista.nom_usuario}</option>
                `
            });
            //return data // Verifica la estructura de los datos en la consola
        } catch (error) {
            console.error("Error al obtener los usuarios:", error);
        }
    }



    async function obtenerEventos() { // PARA OBTENER DATOS DE CLIENTE Y DE EVENTO (NO INCLUYE TARIFARIO NI COSTO EN PRESENTACION DE TAL LOCAL)
        const params = new URLSearchParams();
        params.append("operation", "obtenerEventosUnicos");
        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        $q("#evento").innerHTML = '<option value="">Todos</option>'
        data.forEach(evento => {
            $q("#evento").innerHTML += `<option value="${evento.iddetalle_presentacion}">${evento.establecimiento}</option>`

        });
        //        return data
    }

/*     async function obtenerEventos() { // PARA OBTENER DATOS DE CLIENTE Y DE EVENTO (NO INCLUYE TARIFARIO NI COSTO EN PRESENTACION DE TAL LOCAL)
        const params = new URLSearchParams();
        params.append("operation", "filtrarAtenciones");
        params.append("ncotizacion", "");
        params.append("ndocumento", "");
        params.append("nomusuario", "")
        params.append("establecimiento", "")
        params.append("fechapresentacion", "")
        params.append("mes", "")
        params.append("añosemana", "")
        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        $q("#evento").innerHTML = '<option value="">Todos</option>'
        data.forEach(evento => {
            $q("#evento").innerHTML += `<option value="${evento.iddetalle_presentacion}">${evento.nom_usuario} - ${evento.establecimiento} (${evento.departamento} | ${evento.provincia} | ${evento.distrito}) [${evento.fecha_presentacion}]</option>`

        });
        //        return data
    } */


    async function obtenerColaboradorPorId(idcolaborador) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerColaboradorPorId");
        params.append("idcolaborador", idcolaborador);
        const data = await getDatos(`${host}nomina.controller.php`, params);
        return data
    }

    async function pagarGastoEntrada(idgastoentrada, estado, comprobanteurl, comprobantefacbol) {
        const ge = new FormData();
        ge.append("operation", "pagarGastoEntrada");
        ge.append("idgastoentrada", idgastoentrada);
        ge.append("estado", estado);
        ge.append("mediopago", $q("#mediopago").value || '');
        ge.append("detalles", $q("#detalles").value || '');
        ge.append("comprobanteurl", comprobanteurl ? comprobanteurl : '');
        ge.append("comprobantefacbol", comprobantefacbol ? comprobantefacbol : '');
        ge.append("publicIdComprobanteURLanterior", '');
        ge.append("publicIdComprobanteFacBolanterior", '');

        const fge = await fetch(`${host}gastoentrada.controller.php`, {
            method: "POST",
            body: ge,
        });
        const rge = await fge.json();
        return rge;
    }

    async function eliminarGastoEntrada(idgastoentrada) {
        const ge = new FormData();
        ge.append("operation", "eliminarGastoEntrada");
        ge.append("idgastoentrada", idgastoentrada);

        const fge = await fetch(`${host}gastoentrada.controller.php`, {
            method: "POST",
            body: ge,
        });
        const rge = await fge.json();
        return rge;
    }


    /*     async function actualizarProveedor(idproveedor) {
            const proveedor = new FormData();
            proveedor.append("operation", "actualizarProveedor");
            proveedor.append("idproveedor", idproveedor);
            proveedor.append("empresa", $q("#empresaactualizar").value || '');
            proveedor.append("nombre", $q("#nombreempresaactualizar").value || '');
            proveedor.append("contacto", $q("#contactoactualizar").value || '');
            proveedor.append("correo", $q("#correoactualizar").value || '');
            proveedor.append("dni", $q("#dniempresaactualizar").value || '');
            proveedor.append("banco", $q("#bancoactualizar").value || '');
            proveedor.append("ctabancaria", $q("#ctabancariaactualizar").value || '');
            proveedor.append("servicio", $q("#servicioactualizar").value || '');
            proveedor.append("nproveedor", $q("#nproveedoractualizar").value || '');
    
            const fproveedor = await fetch(`${host}proveedor.controller.php`, {
                method: "POST",
                body: proveedor,
            });
            const rproveedor = await fproveedor.json();
            return rproveedor;
        } */

    // *********************************** OBTENER DATOS ********************************

    /*     async function obtenerProveedorPorId(idproveedor) {
            const params = new URLSearchParams();
            params.append("operation", "obtenerProveedorPorId");
            params.append("idproveedor", idproveedor);
            const data = await getDatos(`${host}proveedor.controller.php`, params);
            return data;
        } */

    function createTable(data) {
        let rows = $("#tb-body-gasto").find("tr");
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
                myTable = $("#table-gastos").DataTable({
                    paging: true,
                    searching: true,
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

    changeByFilters();

    function changeByFilters() {
        const filters = $all(".filter");
        $q("#table-gastos tbody").innerHTML = "";
        filters.forEach((x) => {
            x.addEventListener("input", async () => {
                await dataFilters();
            });
            if (x.id === "artista") {
                x.addEventListener("artista", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "evento") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "fechagasto") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
            /* if (x.id === "ndocumento") {
                x.addEventListener("input", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "telefono") {
                x.addEventListener("input", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "razonsocial") {
                x.addEventListener("input", async () => {
                    await dataFilters();
                });
            } */
        });
    }

    chargerEventsButton();

    async function dataFilters() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarGastos");
        params.append("idusuario", $q("#artista").value || "");
        params.append("iddetallepresentacion", $q("#evento").value || "");
        params.append("fechagasto", $q("#fechagasto").value || "");
        params.append("estado", 1);

        const data = await getDatos(`${host}gastoentrada.controller.php`, params);
        console.log("data -> ", data);

        $q("#table-gastos tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-gastos tbody").innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
        }

        listCajas = []

        data.forEach((x) => {
            $q("#table-gastos tbody").innerHTML += `
        <tr>
            <td>${x.nom_usuario ?? "No aplica"}</td>
            <td>${x.establecimiento ?? "No aplica"}</td>
            <td>${x.fecha_gasto}</td>
            <td>${x.monto}</td>
            <td>${x.mediopago == 1 ? "Transferencia" : "Efectivo"}</td>            
            <td>
                <button class="btn btn-sm btn-primary btn-pagar" data-idgastoentrada="${x.idgastoentrada}">Pagar</button>
                <button class="btn btn-sm btn-primary btn-borrar" data-idgastoentrada="${x.idgastoentrada}">Borrar</button>
            </td>
        </tr>
    `;
        });

        createTable(data);
    }

    function createTable(data) {
        let rows = $("#tb-body-gasto").find("tr");
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
                myTable = $("#table-gastos").DataTable({
                    paging: true,
                    searching: true,
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
                    if (e.target.classList.contains("btn-borrar")) {
                        await buttonBorrar(e);
                    }
                    if (e.target.classList.contains("btn-pagar")) {
                        await buttonPagar(e);
                    }
                    /* if (e.target.classList.contains("btn-cerrar")) {
                        buttonCerrarCaja(e);
                    }
                    if (e.target.classList.contains("btn-vergastos")) {
                        buttonVerGastos(e);
                    } */
                }
            });
    }

    async function buttonBorrar(e) {
        idgastoentrada = e.target.getAttribute("data-idgastoentrada");
        console.log("idgastoentrada -> ", idgastoentrada);
        if (await ask("Confirmar eliminación")) {
            const gastoEliminado = await eliminarGastoEntrada(idgastoentrada)
            console.log("eliminarGastoEntrada -> ", gastoEliminado);
            if (gastoEliminado) {
                showToast("Eliminado!", "SUCCESS")
                await dataFilters()
            }
        }
    }

    async function buttonPagar(e) {
        idgastoentrada = e.target.getAttribute("data-idgastoentrada");
        console.log("idgastoentrada -> ", idgastoentrada);
        modalPagar.show()
    }

    $q("#mediopago").addEventListener("change", async (e) => {
        const tipopago = e.target.value
        if (tipopago == "1") {
            $q("#div-comprobante-pago").hidden = false
            $q("#div-detalles").hidden = true

        } else {
            $q("#div-comprobante-pago").hidden = true
            $q("#div-detalles").hidden = false

        }
    })

    $q("#formPagar").addEventListener("submit", async (e) => {
        e.preventDefault()
        const imagenInputPago = $q("#upload_widget_pago");
        const filePago = imagenInputPago.files[0];
        const imagenInputFacturaBoleta = $q("#upload_widget_facturaboleta");
        const fileFacturaBoleta = imagenInputFacturaBoleta.files[0];
        console.log("filePago -> ", filePago);
        console.log("fileFacturaBoleta -> ", fileFacturaBoleta);

        if (!fileFacturaBoleta) {
            showToast("Suba el/los comprobantes debidos", "ERROR")
            return
        } else {
            const gastopagado = await pagarGastoEntrada(idgastoentrada, 2, filePago, fileFacturaBoleta)
            console.log("gasto o entrada actualizada -> ", gastopagado);
            if (gastopagado) {
                showToast("Se ha pagado correctamente", "SUCCESS", 1000);
                modalPagar.hide()
                await dataFilters()
                return
            }
        }
    })

    $q("#upload_widget_pago").addEventListener("change", function (e) {
        console.log("cambiando...");
        const file = e.target.files[0];
        console.log("file de imagen event -> ", file);
        const preview = $q("#previewImagenPago");

        if (file && file.type.startsWith("image/")) {
            console.log("renderizando ,,,,");
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = "block";
            };
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
            preview.style.display = "none";
        }
    });

    $q("#upload_widget_facturaboleta").addEventListener("change", function (e) {
        console.log("cambiando...");
        const file = e.target.files[0];
        console.log("file de imagen event -> ", file);
        const preview = $q("#previewImagenFacturaBoleta");

        if (file && file.type.startsWith("image/")) {
            console.log("renderizando ,,,,");
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = "block";
            };
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
            preview.style.display = "none";
        }
    });

})