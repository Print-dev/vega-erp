document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let idcolaborador
    let idnomina
    let colaboradorObt = []
    let salarioObt = []
    let tiempocalculado
    let modalProdserv = new bootstrap.Modal($q("#modal-nuevo-prodserv"))
    let modalProdservAct = new bootstrap.Modal($q("#modal-actualizar-prodserv"))
    let totalAcumulado = 0
    let idprodserv
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
    await obtenerProveedores()
    async function obtenerProveedores() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarProveedores");
        params.append("nombre", "");
        params.append("dni", "");

        const data = await getDatos(`${host}proveedor.controller.php`, params);
        console.log("data -> ", data);
        $q("#proveedor").innerHTML = `
            <option value="">Seleccione un proveedor</option>
        `;
        data.forEach(proveedor => {
            $q("#proveedor").innerHTML += `
                <option value="${proveedor.idproveedor}">${proveedor.nombre}</option>
            `;
        });
        $q("#proveedoract").innerHTML = `
            <option value="">Seleccione un proveedor</option>
        `;
        data.forEach(proveedor => {
            $q("#proveedoract").innerHTML += `
                <option value="${proveedor.idproveedor}">${proveedor.nombre}</option>
            `;
        });
    }

    async function obenerProdservPorId(idprodserv) {
        const params = new URLSearchParams();
        params.append("operation", "obenerProdservPorId");
        params.append("idprodserv", idprodserv);
        const data = await getDatos(`${host}prodserv.controller.php`, params);
        return data
    }
    /*     async function obtenerColaboradorPorId(idcolaborador) {
            const params = new URLSearchParams();
            params.append("operation", "obtenerColaboradorPorId");
            params.append("idcolaborador", idcolaborador);
            const data = await getDatos(`${host}nomina.controller.php`, params);
            return data
        }
    
        async function obtenerAcumuladosNomina(idnomina) {
            const params = new URLSearchParams();
            params.append("operation", "obtenerAcumuladosNomina");
            params.append("idnomina", idnomina);
            const data = await getDatos(`${host}nomina.controller.php`, params);
            return data
        }
    
        async function obtenerUltimoSalarioColaborador(idcolaborador) {
            const params = new URLSearchParams();
            params.append("operation", "obtenerUltimoSalarioPorColaborador");
            params.append("idcolaborador", idcolaborador);
            const data = await getDatos(`${host}nomina.controller.php`, params);
            return data
        } */

    async function registrarProdserv() {
        const prodserv = new FormData();
        prodserv.append("operation", "registrarProdserv");
        prodserv.append("nombre", $q("#nombre").value || "");
        prodserv.append("tipo", $q("#tipo").value || "");
        prodserv.append("codigo", $q("#codigo").value || "");
        prodserv.append("idproveedor", $q("#proveedor").value || "");
        prodserv.append("precio", $q("#precio").value || "");

        const fprodserv = await fetch(`${host}prodserv.controller.php`, {
            method: "POST",
            body: prodserv,
        });
        const rprodserv = await fprodserv.json();
        return rprodserv;
    }

    async function actualizarProdserv(idprodserv) {
        const prodserv = new FormData();
        prodserv.append("operation", "actualizarProdserv");
        prodserv.append("idprodserv", idprodserv);
        prodserv.append("nombre", $q("#nombreact").value || "");
        prodserv.append("tipo", $q("#tipoact").value || "");
        prodserv.append("codigo", $q("#codigoact").value || "");
        prodserv.append("idproveedor", $q("#proveedoract").value || "");
        prodserv.append("precio", $q("#precioact").value || "");

        const fprodserv = await fetch(`${host}prodserv.controller.php`, {
            method: "POST",
            body: prodserv,
        });
        const rprodserv = await fprodserv.json();
        return rprodserv;
    }

    async function eliminarProdserv(idprodserv) {
        const prodserv = new FormData();
        prodserv.append("operation", "eliminarProdserv");
        prodserv.append("idprodserv", idprodserv);

        const fprodserv = await fetch(`${host}prodserv.controller.php`, {
            method: "POST",
            body: prodserv,
        });
        const rprodserv = await fprodserv.json();
        return rprodserv;
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
        let rows = $("#tb-body-prodserv").find("tr");
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
                myTable = $("#table-prodservs").DataTable({
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
        $q("#table-prodservs tbody").innerHTML = "";
        filters.forEach((x) => {
            x.addEventListener("input", async () => {
                await dataFilters();
            });
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
        params.append("operation", "filtrarProdserv");
        /*         params.append("nombre", $q("#nombre").value || "");
                params.append("dni", $q("#dni").value || ""); */

        const data = await getDatos(`${host}prodserv.controller.php`, params);
        console.log("data -> ", data);

        $q("#table-prodservs tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-prodservs tbody").innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
        }

        listCajas = []

        for (const x of data) {

            // Insertar fila con total acumulado calculado
            $q("#table-prodservs tbody").innerHTML += `
                <tr>
                    <td>${x.nombre_prodserv ?? ""}</td>
                    <td>${x.tipo ?? ''}</td>
                    <td>${x.codigo ?? ''}</td>
                    <td>${x.proveedor_proveedor ?? ''}</td>
                    <td>${x.precio ?? 0}</td>
                    <td>
                        <button class="btn btn-sm btn-primary btn-actualizar" data-idprodserv="${x.idprodserv}">Actualizar</button>
                        <button class="btn btn-sm btn-danger btn-borrar" data-idprodserv="${x.idprodserv}">Borrar</button>
                    </td>
                </tr>
            `;
        }


        createTable(data);
    }

    function createTable(data) {
        let rows = $("#tb-body-prodserv").find("tr");
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
                myTable = $("#table-prodservs").DataTable({
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
        idprodserv = e.target.getAttribute("data-idprodserv");

        console.log("idprodserv -> ", idprodserv);
        const prodservEliminado = await eliminarProdserv(idprodserv)
        console.log("prodservEliminado -> ", prodservEliminado);
        if (await ask("¿Está seguro de eliminar este producto o servicio?")) {
            if (prodservEliminado) {
                showToast("Se eliminó correctamente el producto o servicio", "SUCCESS")
                await dataFilters()
                return
            } else {
                showToast("No se pudo eliminar el producto o servicio", "ERROR")
            }
        }
    }

    async function buttonActualizar(e) {
        idprodserv = e.target.getAttribute("data-idprodserv");

        console.log("idprodserv -> ", idprodserv);
        modalProdservAct.show()
        const prodserv = await obenerProdservPorId(idprodserv)
        console.log("obenerProdservPorId -> ", prodserv);
        $q("#nombreact").value = prodserv[0]?.nombre
        $q("#tipoact").value = prodserv[0]?.tipo
        $q("#codigoact").value = prodserv[0]?.codigo
        $q("#proveedoract").value = prodserv[0]?.idproveedor
        $q("#precioact").value = prodserv[0]?.precio
    }

    $q("#formProdserv").addEventListener("submit", async (e) => {
        e.preventDefault()
        const prodservregis = await registrarProdserv()
        console.log("prodserv regis- >", prodservregis);
        await dataFilters()
        modalProdserv.hide()

    })


    $q("#formProdservAct").addEventListener("submit", async (e) => {
        e.preventDefault()
        const prodservreact = await actualizarProdserv(idprodserv)
        console.log("prodserv regis- >", prodservreact)
        if (prodservreact) {
            showToast("Se actualizó correctamente el producto o servicio", "SUCCESS")
            await dataFilters()
            modalProdservAct.hide()
            return
        }


    })



})