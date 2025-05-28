document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let idcolaborador
    let idnomina
    let colaboradorObt = []
    let salarioObt = []
    let tiempocalculado
    let modalAcumulados = new bootstrap.Modal($q("#modal-acumulados"))
    let totalAcumulado = 0
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

    async function obtenerColaboradores() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarColaboradores");
        params.append("numdoc", "");
        params.append("idarea", "");

        const data = await getDatos(`${host}nomina.controller.php`, params);
        console.log("data -> ", data);
        $q("#colaborador").innerHTML = `<option value="">Seleccione</option>`;
        data.forEach(nomina => {
            $q("#colaborador").innerHTML += `
            <option value="${nomina.idcolaborador}">${nomina.nombres} ${nomina.apellidos}</option>
        `;
        });
    }

    async function obtenerColaboradorPorId(idcolaborador) {
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
    }

    async function registrarNomina(idcolaborador, salariousado, periodo, idarea, horas, tiempo) {
        const colaborador = new FormData();
        colaborador.append("operation", "registrarNomina");
        colaborador.append("idcolaborador", idcolaborador);
        colaborador.append("salariousado", salariousado);
        colaborador.append("periodo", periodo);
        colaborador.append("idarea", idarea);
        colaborador.append("horas", horas);
        colaborador.append("tiempo", tiempo);
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
        let rows = $("#tb-body-nomina").find("tr");
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
                myTable = $("#table-nominas").DataTable({
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
        $q("#table-nominas tbody").innerHTML = "";
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
        params.append("operation", "filtrarNominas");
        /*         params.append("nombre", $q("#nombre").value || "");
                params.append("dni", $q("#dni").value || ""); */

        const data = await getDatos(`${host}nomina.controller.php`, params);
        console.log("data -> ", data);

        $q("#table-nominas tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-nominas tbody").innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
        }

        listCajas = []

        for (const x of data) {
            //const acumuladosNomina = await obtenerAcumuladosNomina(x.idnomina);

            // Sumar todos los montos
            //const totalAcumulado = acumuladosNomina.reduce((sum, item) => {
            //    return sum + parseFloat(item.monto || 0);
            //}, 0);
            //<td>${totalAcumulado.toFixed(2)}</td>

            // Insertar fila con total acumulado calculado
            $q("#table-nominas tbody").innerHTML += `
                <tr>
                    <td>${x.nombres && x.apellidos ? x.nombres + " " + x.apellidos : ''}</td>
                    <td>${x.fechaingreso ?? ''}</td>
                    <td>${x.salario_usado ?? ''}</td>
                    <td>${x.horas ?? ''}</td>
                    <td>${x.periodo == 1 ? "Quincenal" : x.periodo == 2 ? "Semanal" : x.periodo == 3 ? "Mensual" : ''}</td>
                    <td>${x.area ?? ''}</td>
                    <td>${x.tiempo ?? ''}</td>
                    <td>${x.rendimiento ?? 0}</td>
                    <td>${x.proporcion ?? 0}</td>
                    <td>
                        <button class="btn btn-sm btn-primary btn-acumulados" data-idnomina="${x.idnomina}">Ver Acumulados</button>
                        <button class="btn btn-sm btn-danger btn-borrar" data-idnomina="${x.idnomina}">Borrar</button>
                    </td>
                </tr>
            `;
        }


        createTable(data);
    }

    function createTable(data) {
        let rows = $("#tb-body-nomina").find("tr");
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
                myTable = $("#table-nominas").DataTable({
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
                    if (e.target.classList.contains("btn-borrar")) {
                        await buttonBorrar(e);
                    }
                    if (e.target.classList.contains("btn-acumulados")) {
                        await buttonAcumulados(e);
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
        idnomina = e.target.getAttribute("data-idnomina");

        console.log("idnomina -> ", idnomina);
        alert("prueba de borrando")
    }

    async function buttonAcumulados(e) {
        idnomina = e.target.getAttribute("data-idnomina");
        console.log("idnomina -> ", idnomina);

        modalAcumulados.show()
        const acumuladosNomina = await obtenerAcumuladosNomina(idnomina)
        console.log("acumuladosNomina -> ", acumuladosNomina);
        totalAcumulado = 0
        $q("#div-acumulado").innerHTML = ``
        acumuladosNomina.forEach(acumulado => {
            const monto = parseFloat(acumulado.monto) || 0;
            totalAcumulado += monto;

            const [fecha, hora] = acumulado.created_at.split(" ");
            $q("#div-acumulado").innerHTML += `
            <tr>
                <td>${formatearFecha(fecha) + " " + formatHour(hora)} </td>
                <td>${acumulado.descripcion ?? "Sin descripción"}</td>
                <td class="text-end">${acumulado.monto}</td>
                <td class="text-end">
                <button type="button" id="btn-borraracumulado" data-idgastonomina="${acumulado.idgastonomina}">
                    <i class="bi bi-trash"></i>                
                </button>
                </td>
            </tr>
            `
        });
        console.log("totalAcumulado -> ", totalAcumulado);
        $q("#div-totalacumulado").innerHTML = `
        <tr class="fw-bold">
            <td colspan="2" class="text-end">Total Acumulado</td>
            <td class="text-end">${totalAcumulado.toFixed(2)}</td>
        </tr>
        `

        $all("#btn-borraracumulado").forEach(btn => {
            btn.addEventListener("click", e => {
                const button = e.target.closest("button");
                const idgastonomina = button.getAttribute("data-idgastonomina");
                console.log("idgastonomina ->", idgastonomina);
            });
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
    
        async function buttonBorrar(e) {
            idproveedor = e.target.getAttribute("data-idproveedor");
            console.log("idproveedor -> ", idproveedor);
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
            });
            modalActualizarProveedor.show()
        }
    
        function buttonDeshabilitar(e) {
            idproveedor = e.target.getAttribute("data-idproveedor");
            console.log("idproveedor -> ", idproveedor);
        } */

    $q("#btnNuevoColaboradorNomina").addEventListener("click", async () => {
        console.log("butttoooon");
        await obtenerColaboradores();
    })

    $q("#colaborador").addEventListener("change", async (e) => {
        idcolaborador = e.target.value;
        colaboradorObt = await obtenerColaboradorPorId(idcolaborador)
        salarioObt = await obtenerUltimoSalarioColaborador(idcolaborador)
        console.log("salarioObt -> ", salarioObt);
        console.log("colaboradorObt -> ", colaboradorObt);
        tiempocalculado = calcularDiasTrabajados(colaboradorObt[0].fechaingreso)
        console.log("tiempocalculado >", tiempocalculado);
        $q("#tiempo").value = tiempocalculado ?? '';
    })

    $q("#formNomina").addEventListener("submit", async (e) => {
        e.preventDefault()
        console.log("formNomina");
        console.log("oj de colaborador -> ", colaboradorObt[0]);
        console.log("idarea de colaborador -> ", colaboradorObt[0]?.idarea);
        const nominaRegistrada = await registrarNomina(idcolaborador, salarioObt[0]?.salario, salarioObt[0]?.periodo, colaboradorObt[0]?.idarea, salarioObt[0]?.horas, tiempocalculado);
        console.log("nominaRegistrada -> ", nominaRegistrada);
        if (nominaRegistrada) {
            showToast("Nomina registrada correctamente", "SUCCESS");
            $q("#formNomina").reset();
            await dataFilters();
        }

    })
})