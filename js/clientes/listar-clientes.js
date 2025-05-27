document.addEventListener("DOMContentLoaded", function () {
    let myTable = null;


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

    // *********************************** OBTENER DATOS ********************************

    function createTable(data) {
        let rows = $("#tb-body-cliente").find("tr");
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
                myTable = $("#table-clientes").DataTable({
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

    changeByFilters();

    function changeByFilters() {
        const filters = $all(".filter");
        $q("#table-clientes tbody").innerHTML = "";
        filters.forEach((x) => {
            x.addEventListener("change", async () => {
                await dataFilters();
            });
            if (x.id === "ndocumento") {
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
            }
        });
    }

    chargerEventsButton();

    async function dataFilters() {
        const params = new URLSearchParams();
        params.append("operation", "buscarCliente");
        params.append("ndocumento", $q("#ndocumento").value || "");
        params.append("telefono", $q("#telefono").value || "");
        params.append("razonsocial", $q("#razonsocial").value || "");

        const data = await getDatos(`${host}cliente.controller.php`, params);
        console.log("data -> ", data);

        $q("#table-clientes tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-clientes tbody").innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
        }

        listCajas = []

        data.forEach((x) => {

            $q("#table-clientes tbody").innerHTML += `
            <tr>
                <td>${x.ndocumento}</td>
                <td>${x.tipodoc == 1 ? "DNI" : x.tipodoc == 2 ? "RUC" : ''}</td>
                <td>${x.razonsocial}</td>
                <td>${x.representantelegal ?? "no aplica"}</td>
                <td>${x.telefono}</td>
                <td>${x.correo}</td>
                <td>${x.direccion}</td>
                <td>${(x.departamento && x.provincia && x.distrito) ? `${x.departamento}/${x.provincia}/${x.distrito}` : 'No aplica'}</td>
                <td>
                    <button class="btn btn-sm btn-primary btn-actualizar" data-idcliente="${x.idcliente}">Actualizar</button>
                    <button class="btn btn-sm btn-danger btn-borrar" data-idcliente="${x.idcliente}">Borrar</button>
                </td>
            </tr>
        `;
        });

        createTable(data);

    }

    function createTable(data) {
        let rows = $("#tb-body-cliente").find("tr");
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
                myTable = $("#table-clientes").DataTable({
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
                    if (e.target.classList.contains("btn-actualizar")) {
                        buttonActualizar(e);
                    }
                    if (e.target.classList.contains("btn-borrar")) {
                        buttonBorrar(e);
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

    async function eliminarCliente(idcliente) {
        const prodserv = new FormData();
        prodserv.append("operation", "eliminarCliente");
        prodserv.append("idcliente", idcliente);

        const fprodserv = await fetch(`${host}cliente.controller.php`, {
            method: "POST",
            body: prodserv,
        });
        const rprodserv = await fprodserv.json();
        return rprodserv;
    }


    function buttonActualizar(e) {
        const idcliente = e.target.getAttribute("data-idcliente")
        window.localStorage.clear()
        window.localStorage.setItem("idcliente", idcliente)
        window.location.href = `${hostOnly}/views/utilitario/clientes/actualizar-cliente`;
    }

    async function buttonBorrar(e) {
        const idcliente = e.target.getAttribute("data-idcliente")
        const clienteEliminado = await eliminarCliente(idcliente)
        if (await ask("¿Confirmar eliminación?")) {
            showToast("Eliminado!", "SUCCESS")
            console.log("cliente eliminado -> ", clienteEliminado);
            await dataFilters()
            return
        }
        /*         window.localStorage.clear()
                window.localStorage.setItem("idcliente", idcliente)
                window.location.href = `${hostOnly}/views/utilitario/clientes/actualizar-cliente`; */
    }

    // *********************************** eventos ********************************


})