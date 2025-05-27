document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let idcolaborador
    let idnomina
    let idgastoentrada
    let modalComprobantes = new bootstrap.Modal($q("#modal-comprobantes"))
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


    async function obtenerGastoEntradaPorId(idgastoentrada) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerGastoEntradaPorId");
        params.append("idgastoentrada", idgastoentrada);
        const data = await getDatos(`${host}gastoentrada.controller.php`, params);
        return data
    }

    async function registrarNomina() {
        const colaborador = new FormData();
        colaborador.append("operation", "registrarNomina");
        colaborador.append("idcolaborador", $q("#colaborador").value || '');
        colaborador.append("tiempo", $q("#tiempo").value || '');
        colaborador.append("rendimiento", $q("#rendimiento").value || '');
        colaborador.append("proporcion", $q("#proporcion").value || '');
        colaborador.append("acumulado", $q("#acumulado").value || '');

        const fcolaborador = await fetch(`${host}nomina.controller.php`, {
            method: "POST",
            body: colaborador,
        });
        const rcolaborador = await fcolaborador.json();
        return rcolaborador;
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
        params.append("estado", 2);

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
                ${x.comprobante_url
                    ? `<img src="https://res.cloudinary.com/dynpy0r4v/image/upload/v1748079000/${x.comprobante_url}" height="30" alt="Voucher Pago">`
                    : ''
                }
            </td>
            <td>
                ${x.comprobante_fac_bol
                    ? `<img src="https://res.cloudinary.com/dynpy0r4v/image/upload/v1748079000/${x.comprobante_fac_bol}" height="30" alt="Voucher Pago">`
                    : ''
                }
            </td>
            <td>
                <button class="btn btn-sm btn-primary btn-actualizar" data-idgastoentrada="${x.idgastoentrada}">Actualizar</button>
                <button class="btn btn-sm btn-primary btn-comprobante" data-idgastoentrada="${x.idgastoentrada}">Ver Comprobantes</button>
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
                    if (e.target.classList.contains("btn-actualizar")) {
                        await buttonActualizar(e);
                    }
                    if (e.target.classList.contains("btn-comprobante")) {
                        await buttonComprobante(e);
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

    async function buttonComprobante(e) {
        idgastoentrada = e.target.getAttribute("data-idgastoentrada");
        console.log("idgastoentrada -> ", idgastoentrada);
        modalComprobantes.show();
        const comprobantes = await obtenerGastoEntradaPorId(idgastoentrada);
        console.log("comprobantes -> ", comprobantes);

        const urlBase = "https://res.cloudinary.com/dynpy0r4v/image/upload/v1748079334/";

        const comprobanteUrl = comprobantes[0]?.comprobante_url;
        const comprobanteFacBol = comprobantes[0]?.comprobante_fac_bol;

        $q("#div-comprobantes").innerHTML = `
        <div class="d-flex flex-column gap-4">
            <div class="mb-3">
                <h6 class="text-center">Archivo adjunto comprobante</h6>
                ${comprobanteUrl ?
                `<img src="${urlBase + comprobanteUrl}" alt="Comprobante 1" class="img-fluid rounded border mx-auto d-block" id="comprobante1-preview">` :
                `<div class="border rounded text-center p-3 text-muted">Sin archivo adjunto</div>`
            }
            </div>
            <div >
                <h6 class="text-center">Boleta o factura</h6>
                ${comprobanteFacBol ?
                `<img src="${urlBase + comprobanteFacBol}" alt="Comprobante 2" class="img-fluid rounded border mx-auto d-block" id="comprobante2-preview">` :
                `<div class="border rounded text-center p-3 text-muted">Sin archivo adjunto</div>`
            }
            </div>
        </div>
    `;
    }



    async function buttonActualizar(e) {
        idgastoentrada = e.target.getAttribute("data-idgastoentrada");
        console.log("idgastoentrada -> ", idgastoentrada);
        window.localStorage.clear()
        window.localStorage.setItem("idgastoentrada", idgastoentrada)
        window.location.href = `${hostOnly}/views/contabilidad/gastos/actualizar-gasto`
    }




})