document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let modalNuevoProvedor = new bootstrap.Modal($q("#modal-nuevo-proveedor"))
    let modalActualizarProveedor = new bootstrap.Modal($q("#modal-actualizar-proveedor"))
    let idcolaborador

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

    await obtenerCargos()


    /*     async function obtenerAreas() {
            const data = await getDatos(`${host}nomina.controller.php`, "operation=obtenerAreas");
            console.log(data);
            $q("#idarea").innerHTML = `<option value="">Seleccione</option>`
            data.forEach((x) => {
                $q("#idarea").innerHTML += `
                    <option value="${x.idarea}">${x.area}</option>
                `;
            }
            );
    
            return data
        } */

    async function obtenerCargos() {
        const data = await getDatos(`${host}colaborador.controller.php`, "operation=obtenerCargos");
        console.log(data);
        $q("#cargo").innerHTML = "<option value=''>Selecciona</option>";
        data.forEach(cargo => {
            $q("#cargo").innerHTML += `<option value="${cargo.idcargo}">${cargo.cargo}</option>`;
        });

    }


    //await obtenerAreas()

    // ************************************ REGISTRAR DATOS ********************************

    async function registrarProveedor() {
        const proveedor = new FormData();
        proveedor.append("operation", "registrarProveedor");
        proveedor.append("empresa", $q("#empresa").value || '');
        proveedor.append("nombre", $q("#nombreempresa").value || '');
        proveedor.append("contacto", $q("#contacto").value || '');
        proveedor.append("correo", $q("#correo").value || '');
        proveedor.append("dni", $q("#dniempresa").value || '');
        proveedor.append("banco", $q("#banco").value || '');
        proveedor.append("ctabancaria", $q("#ctabancaria").value || '');
        proveedor.append("servicio", $q("#servicio").value || '');
        proveedor.append("nproveedor", $q("#nproveedor").value || '');

        const fproveedor = await fetch(`${host}proveedor.controller.php`, {
            method: "POST",
            body: proveedor,
        });
        const rproveedor = await fproveedor.json();
        return rproveedor;
    }

    async function actualizarProveedor(idproveedor) {
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
    }

    // *********************************** OBTENER DATOS ********************************

    async function obtenerProveedorPorId(idproveedor) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerProveedorPorId");
        params.append("idproveedor", idproveedor);
        const data = await getDatos(`${host}proveedor.controller.php`, params);
        return data;
    }

    function createTable(data) {
        let rows = $("#tb-body-colaborador").find("tr");
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
                myTable = $("#table-colaboradores").DataTable({
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
        $q("#table-colaboradores tbody").innerHTML = "";
        filters.forEach((x) => {
            x.addEventListener("input", async () => {
                await dataFilters();
            });
            x.addEventListener("change", async () => {
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
        params.append("operation", "filtrarColaboradores");
        params.append("numdoc", $q("#num_doc").value || "");
        params.append("cargo", $q("#cargo").value || "");

        const data = await getDatos(`${host}nomina.controller.php`, params);
        console.log("data -> ", data);

        $q("#table-colaboradores tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-colaboradores tbody").innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
        }

        listCajas = []

        data.forEach((x) => {

            $q("#table-colaboradores tbody").innerHTML += `
            <tr>
                <td>${x.dni ?? ''}</td>
                <td>${x.nombreapellidos ?? ''}</td>
                <td>
                    <button class="btn btn-sm btn-primary btn-cargo" data-idpersonacolaborador="${x.idpersonacolaborador}">Cargo</button>
                    <button class="btn btn-sm btn-primary btn-salario" data-idpersonacolaborador="${x.idpersonacolaborador}">Salario</button>
                    <button class="btn btn-sm btn-primary btn-actualizar" data-idpersonacolaborador="${x.idpersonacolaborador}">Actualizar</button>
                    <button class="btn btn-sm btn-danger btn-deshabilitar" data-idpersonacolaborador="${x.idpersonacolaborador}">Deshabilitar</button>
                </td>
            </tr>
        `;
        });
        createTable(data);
    }

    function createTable(data) {
        let rows = $("#tb-body-colaborador").find("tr");
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
                myTable = $("#table-colaboradores").DataTable({
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
                    if (e.target.classList.contains("btn-actualizar")) {
                        await buttonActualizar(e);
                    }
                    if (e.target.classList.contains("btn-deshabilitar")) {
                        buttonDeshabilitar(e);
                    }
                    if (e.target.classList.contains("btn-salario")) {
                        buttonSalario(e);
                    }
                    if (e.target.classList.contains("btn-cargo")) {
                        buttonCargo(e);
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

    $q("#formProveedor").addEventListener("submit", async (e) => {
        e.preventDefault();
        console.log("nombre de valor ", $q("#nombreempresa").value);
        const proveedorRegistrado = await registrarProveedor();
        console.log("proveedorRegistrado -> ", proveedorRegistrado);
        if (proveedorRegistrado.idproveedor > 0) {
            showToast("Proveedor registrado correctamente", "SUCCESS");
            modalNuevoProvedor.hide();
            $q("#formProveedor").reset();
            await dataFilters();
        }
    })

    $q("#formActualizarProveedor").addEventListener("submit", async (e) => {
        e.preventDefault();
        const proveedorActualizado = await actualizarProveedor(idproveedor);
        console.log("proveedorActualizado -> ", proveedorActualizado);
        if (proveedorActualizado) {
            showToast("Proveedor actualizado correctamente", "SUCCESS");
            modalActualizarProveedor.hide();
            $q("#formActualizarProveedor").reset();
            await dataFilters();
        }
    })

    async function buttonActualizar(e) {
        idcolaborador = e.target.getAttribute("data-idcolaborador");
        window.localStorage.clear()
        window.localStorage.setItem("idcolaborador", idcolaborador);
        window.location.href = `${hostOnly}/views/colaboradores/actualizar-colaborador`;
        /* console.log("idproveedor -> ", idproveedor);
        const proveedorObtenido = await obtenerProveedorPorId(idproveedor)
        console.log("proveedorObtenido -> ", proveedorObtenido);
        await obtenerProveedorPorId(idproveedor).then((data) => {
            console.log("data -> ", data);
            $q("#empresaactualizar").value = data[0].empresa ?? '';
            $q("#nombreempresaactualizar").value = data[0].nombre ?? '';
            $q("#contactoactualizar").value = data[0].contacto ?? '';
            $q("#correoactualizar").value = data[0].correo ?? '';
            $q("#dniempresaactualizar").value = data[0].dni ?? '';
            $q("#bancoactualizar").value = data[0].banco ?? '';
            $q("#ctabancariaactualizar").value = data[0].ctabancaria ?? '';
            $q("#servicioactualizar").value = data[0].servicio ?? '';
            $q("#nproveedoractualizar").value = data[0].nproveedor ?? '';
        }); */
        modalActualizarProveedor.show()
    }

    function buttonCargo(e) {
        idcolaborador = e.target.getAttribute("data-idcolaborador");
        console.log("idcolaborador -> ", idcolaborador);
        window.localStorage.clear()
        window.localStorage.setItem("idcolaborador", idcolaborador);
        window.location.href = `${hostOnly}/views/colaboradores/cargos-colaborador`;
    }

    function buttonSalario(e) {
        idcolaborador = e.target.getAttribute("data-idcolaborador");
        window.localStorage.clear()
        window.localStorage.setItem("idcolaborador", idcolaborador);
        window.location.href = `${hostOnly}/views/colaboradores/salarios-colaborador`;
    }
})