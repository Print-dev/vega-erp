document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    //let idproveedor
    let modalActualizarCargo = new bootstrap.Modal($q("#modal-actualizar-cargo"))
    let modalNuevoCargo = new bootstrap.Modal($q("#modal-nuevo-cargo"))
    //let modalActualizarProveedor = new bootstrap.Modal($q("#modal-actualizar-proveedor")) 
    let idpersonacolaborador = window.localStorage.getItem("idpersonacolaborador") || -1;


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
        }
    
        await obtenerAreas() */

    // ************************************ REGISTRAR DATOS ********************************

    async function registrarSalario(idcolaborador) {
        const nomina = new FormData();
        nomina.append("operation", "registrarSalario");
        nomina.append("idcolaborador", idcolaborador);
        nomina.append("salario", $q("#salario").value || '');
        nomina.append("periodo", $q("#periodo").value || '');
        nomina.append("horas", $q("#horas").value || '');
        nomina.append("costohora", $q("#costohora").value || '');

        const fnomina = await fetch(`${host}nomina.controller.php`, {
            method: "POST",
            body: nomina,
        });
        const rnomina = await fnomina.json();
        return rnomina;
    }

    async function registrarCargoColaborador(idpersonacolaborador) {
        const nomina = new FormData();
        nomina.append("operation", "registrarCargoColaborador");
        nomina.append("idpersonacolaborador", idpersonacolaborador || "");
        nomina.append("cargo", $q("#cargo").value || "");
        nomina.append("fechainicio", $q("#fechainicio").value || '');

        const fnomina = await fetch(`${host}colaborador.controller.php`, {
            method: "POST",
            body: nomina,
        });
        const rnomina = await fnomina.json();
        return rnomina;
    }

    async function actualizarSalario(idsalario) {
        const nomina = new FormData();
        nomina.append("operation", "actualizarSalario");
        nomina.append("idsalario", idsalario);
        nomina.append("salario", $q("#salarioactualizar").value || '');
        nomina.append("periodo", $q("#periodoactualizar").value || '');
        nomina.append("horas", $q("#horasactualizar").value || '');
        nomina.append("costohora", $q("#costohoraactualizar").value || '');
        nomina.append("fechainicio", $q("#fechainicioactualizar").value || '');

        const fnomina = await fetch(`${host}nomina.controller.php`, {
            method: "POST",
            body: nomina,
        });
        const rnomina = await fnomina.json();
        return rnomina;
    }

    $q("#formcargo").addEventListener("submit", async (e) => {
        console.log("llego -> ");
        e.preventDefault()
        const colaboradorRegistrado = await registrarCargoColaborador(idcolaborador)
        console.log("colaboradorRegistrado -> ", colaboradorRegistrado);
        if (colaboradorRegistrado) {
            showToast("Asignado!", "SUCCESS")
            modalNuevoCargo.hide()
            await dataFilters()
        }
    })

    /* 
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
        } */

    // *********************************** OBTENER DATOS ********************************

    /*     async function obtenerProveedorPorId(idproveedor) {
            const params = new URLSearchParams();
            params.append("operation", "obtenerProveedorPorId");
            params.append("idproveedor", idproveedor);
            const data = await getDatos(`${host}proveedor.controller.php`, params);
            return data;
        } */


    async function obtenerSalarioPorId(idsalario) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerSalarioPorId");
        params.append("idsalario", idsalario);
        const data = await getDatos(`${host}nomina.controller.php`, params);
        return data;
    }

    async function obtenerCargoColaboradorPorId(idcargocolaborador) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerCargoColaboradorPorId");
        params.append("idcargocolaborador", idcargocolaborador);
        const data = await getDatos(`${host}colaborador.controller.php`, params);
        return data;
    }


    function createTable(data) {
        let rows = $("#tb-body-cargo").find("tr");
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
                myTable = $("#table-cargos").DataTable({
                    paging: true,
                    searching: false,
                    ordering: false,
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
        $q("#table-cargos tbody").innerHTML = "";
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
        params.append("operation", "filtrarCargos");
        params.append("idpersonacolaborador", "idpersonacolaborador");
        const data = await getDatos(`${host}colaborador.controller.php`, params);
        console.log("data -> ", data);

        $q("#table-cargos tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-cargos tbody").innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
        }

        listCajas = []

        data.forEach((x) => {
            $q("#table-cargos tbody").innerHTML += `
            <tr>
                <td>${x.idcargocolaborador ?? ''}</td>
                <td>${x.cargo ?? ''}</td>
                <td>${x.fechainicio ?? ''}</td>
                <td>${x.fechafin ?? ''}</td>
                <td>
                    <button class="btn btn-sm btn-primary btn-actualizar" data-idcargocolaborador="${x.idcargocolaborador}">Actualizar</button>
                    <button class="btn btn-sm btn-danger btn-borrar" data-idcargocolaborador="${x.idcargocolaborador}">Borrar</button>
                </td>
            </tr>
        `;
        });
        createTable(data);
    }

    function createTable(data) {
        let rows = $("#tb-body-cargo").find("tr");
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
                myTable = $("#table-cargos").DataTable({
                    paging: true,
                    searching: false,
                    ordering: false,
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
                    if (e.target.classList.contains("btn-borrar")) {
                        buttonBorrar(e);
                    }
                    if (e.target.classList.contains("btn-salario")) {
                        buttonSalario(e);
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

    /*     $q("#formProveedor").addEventListener("submit", async (e) => {
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
        }) */
    /* 
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
        }) */

    async function buttonActualizar(e) {
        idcargocolaborador = e.target.getAttribute("data-idcargocolaborador");
        const cargoCol = await obtenerCargoColaboradorPorId(idcargocolaborador)
        console.log("cargoCol .> ", cargoCol);
        $q("#cargoactualizar").value = cargoCol[0].cargo;
        $q("#fechainicioactualizar").value = cargoCol[0].fechainicio;    
        
        modalActualizarCargo.show()
    }

    $q("#formActualizarCargo").addEventListener("submit", async (e) => {
        e.preventDefault()
        console.log("clicka salario");
        const salarioActualzado = await actualizarSalario(idcargocolaborador)
        console.log("salario actualizado -> ", salarioActualzado);
        if (salarioActualzado) {
            showToast("Salario actualizado correctamente", "SUCCESS");
            modalActualizarCargo.hide();
            $q("#formActualizarCargo").reset();
            await dataFilters();
        }
    })

    function buttonBorrar(e) {
        idcargocolaborador = e.target.getAttribute("data-idcargocolaborador");
        console.log("idcargocolaborador -> ", idcargocolaborador);
        alert("prueba de borrando")
    }

    /*     function buttonSalario(e) {
            idcolaborador = e.target.getAttribute("data-idcolaborador");
            window.localStorage.clear()
            window.localStorage.setItem("idcolaborador", idcolaborador);
            window.location.href = `${hostOnly}/views/colaboradores/salarios-colaborador`;
        } */
    /* 
        $q("#formcargo").addEventListener("submit", async (e) => {
            e.preventDefault()
            const salarioRegistrado = await registrarSalario(idcolaborador);
            console.log("salrio registrado -> ", salarioRegistrado);
            if (salarioRegistrado) {
                showToast("Salario registrado correctamente", "SUCCESS");
                $q("#formsalario").reset();
                await dataFilters();
            }
    
        }) */
})