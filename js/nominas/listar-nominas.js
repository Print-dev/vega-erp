document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let idcolaborador
    let idnomina
    let colaboradorObt = []
    let salarioObt = []
    let tiempocalculado
    //let modalAcumulados = new bootstrap.Modal($q("#modal-acumulados"))
    let modalInfo = new bootstrap.Modal($q("#modal-info"))
    let totalAcumulado = 0
    let listNominas = []
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


    /*     $q("#mesindividual").addEventListener("change", async (e) => {
            console.log(e.target.value);
        })
     */

    $q("#div-mesanoindividual").hidden = true
    $q("#div-mesanorangoincio").hidden = true
    $q("#div-mesanorangofin").hidden = true
    // ************************************ REGISTRAR DATOS ********************************

    async function obtenerColaboradores() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarColaboradores");
        params.append("numdoc", "");
        //params.append("idarea", "");
        console.log("holaaaa");
        const data = await getDatos(`${host}nomina.controller.php`, params);
        $q("#colaborador").innerHTML = `<option value="">Todos</option>`;
        console.log("data -> ", data);

        data.forEach(nomina => {
            $q("#colaborador").innerHTML += `
            <option value="${nomina.idcolaborador}">${nomina.nombreapellidos}</option>
        `;
        });
    }


    /* async function obtenerColaboradorPorId(idcolaborador) {
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
 */

    async function obtnerNominaPorId(idnomina) {
        const params = new URLSearchParams();
        params.append("operation", "obtnerNominaPorId");
        params.append("idnomina", idnomina);

        const data = await getDatos(`${host}nomina.controller.php`, params);
        console.log("data -> ", data);
        return data
    }

    async function obtenerFichaColaborador(idnomina) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerFichaColaborador");
        params.append("idnomina", idnomina);

        const data = await getDatos(`${host}colaborador.controller.php`, params);
        console.log("data -> ", data);
        return data
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
        await obtenerColaboradores()

    })();

    changeByFilters();

    function changeByFilters() {
        const filters = $all(".filter");
        $q("#table-nominas tbody").innerHTML = "";
        filters.forEach((x) => {
            x.addEventListener("input", async () => {
                await dataFilters();
            });
            if (x.id === "mesanoindividual") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "mesanorangoincio") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "mesanorangofin") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "colaborador") {
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
        params.append("operation", "filtrarNominas");
        //if (tipo === "1") { // Individual
        const mesIndividual = $q("#mesanoindividual").value;
        //if (mesIndividual) {
        const inicio = $q("#mesanorangoincio").value;
        const fin = $q("#mesanorangofin").value;
        const [ano, mes] = mesIndividual.split('-');
        const [anoInicio, mesInicio] = inicio.split('-');
        const [anoFin, mesFin] = fin.split('-');
        const idColaborador = $q("#colaborador").value;

        const tipo = $q("#tipo").value;

        if (tipo === "1") { // Individual
            params.append("mesindividual", mes || "");
            params.append("anoindividual", ano || "");
            params.append("mesrangoinicio", "");
            params.append("anorangoinicio", "");
            params.append("mesrangofin", "");
            params.append("anorangofin", "");
            params.append("idcolaborador", idColaborador || "");

        } else if (tipo === "2") { // Rango
            params.append("mesindividual", "");
            params.append("anoindividual", "");
            params.append("mesrangoinicio", mesInicio || "");
            params.append("anorangoinicio", anoInicio || "");
            params.append("mesrangofin", mesFin || "");
            params.append("anorangofin", anoFin || "");
            params.append("idcolaborador", idColaborador || "");

        } else {
            params.append("mesindividual", "");
            params.append("anoindividual", "");
            params.append("mesrangoinicio", "");
            params.append("anorangoinicio", "");
            params.append("mesrangofin", "");
            params.append("anorangofin", "");
            params.append("idcolaborador", idColaborador || "");
        }
        //}

        /*         params.append("mesindividual", $q("#mesindividual").value || "");
                params.append("anoindividual", $q("#anoindividual").value || "");
                params.append("mesrangoincio", $q("#mesrangoincio").value || "");
                params.append("anorangoinicio", $q("#anorangoinicio").value || "");
                params.append("mesrangofin", $q("#mesrangofin").value || "");
                params.append("anorangofin", $q("#anorangofin").value || "");
                params.append("idcolaborador", $q("#colaborador").value || ""); */

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

        listNominas = []

        for (const x of data) {

            // Insertar fila con total acumulado calculado

            //INSERTANDO A LA LISTA DE NOMINAS
            listNominas.push({
                camisa: x.camisa,
                cargo: x.cargo,
                clavesol: x.clavesol,
                contactoemergencia: x.contactoemergencia,
                correo: x.correo,
                discapacidad: x.discapacidad,
                dni: x.dni,
                domicilio: x.domicilio,
                estadocivil: x.estadocivil == 1 ? "Soltero" : x.estadocivil == 2 ? "Casado" : x.estadocivil == 3 ? "Divorciado" : x.estadocivil == 4 ? "Conviviente" : x.estadocivil == 5 ? "Viudo" : "",
                fechaingreso: x.fechaingreso,
                fnacimiento: x.fnacimiento,
                idcolaborador: x.idcolaborador,
                ncuenta: x.ncuenta,
                nivelestudio: x.nivelestudio,
                nombreapellidos: x.nombreapellidos,
                pantalon: x.pantalon,
                ruc: x.ruc,
                sexo: x.sexo,
                tipo: x.tipo == 1 ? "Planilla" : x.tipo == 2 ? "Contrato" : x.tipo == 3 ? "Locación" : '',
                zapatos: x.zapatos,
            })

            $q("#table-nominas tbody").innerHTML += `
                <tr>
                    <td>${x.tipo == 1 ? "Planilla" : x.tipo == 2 ? "Contrato" : x.tipo == 3 ? "Locación" : ''}</td>
                    <td>${x.nombreapellidos ?? ''}</td>
                    <td>${x.cargo ?? ''}</td>
                    <td>${x.correo ?? ''}</td>
                    <td>
                        <button class="btn btn-sm btn-primary btn-info" data-idnomina="${x.idnomina}">Info</button>
                        <button class="btn btn-sm btn-primary btn-actualizar" data-idnomina="${x.idnomina}">Actualizar</button>
                        <button class="btn btn-sm btn-danger btn-borrar" data-idnomina="${x.idnomina}">Borrar</button>
                        <button class="btn btn-sm btn-info btn-ficha" data-idnomina="${x.idnomina}">Ficha</button>
                    </td>
                </tr>
            `;
        }


        createTable(data);
        console.log("listNominas CON TODO RENDER -> ", listNominas);
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
                    if (e.target.classList.contains("btn-actualizar")) {
                        await buttonActualizar(e);
                    }
                    if (e.target.classList.contains("btn-info")) {
                        await buttonInfo(e);
                    }
                    if (e.target.classList.contains("btn-ficha")) {
                        await buttonFicha(e);
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

    async function buttonActualizar(e) {
        idnomina = e.target.getAttribute("data-idnomina");
        window.localStorage.clear()

        window.localStorage.setItem("idnomina", idnomina)
        window.location.href = `${hostOnly}/views/nominas/actualizar-nomina`;
    }

    async function buttonBorrar(e) {
        idnomina = e.target.getAttribute("data-idnomina");

        console.log("idnomina -> ", idnomina);
        alert("prueba de borrando")
    }

    async function buttonInfo(e) {
        idnomina = e.target.getAttribute("data-idnomina");
        console.log("idnomina-> ", idnomina);
        const nomina = await obtnerNominaPorId(idnomina)
        console.log("idnomina -> ", nomina);
        modalInfo.show()

        $q("#div-info").innerHTML = `
        <div class="container">
            <div class="mb-4">
                <h5 class="fw-bold border-bottom pb-2">Datos generales</h5>
                <div class="row">
                    <div class="col-md-6"><strong>Nombre y Apellidos:</strong> ${nomina[0]?.nombreapellidos ?? ""}</div>
                    <div class="col-md-6"><strong>DNI:</strong> ${nomina[0]?.dni ?? ""}</div>
                    <div class="col-md-6"><strong>Sexo:</strong> ${nomina[0]?.sexo ?? ""}</div>
                    <div class="col-md-6"><strong>Fecha de Nacimiento:</strong> ${nomina[0]?.fnacimiento ?? ""}</div>
                    <div class="col-md-6"><strong>Estado Civil:</strong> ${nomina[0]?.estadocivil == 1 ? "Soltero" : nomina[0]?.estadocivil == 2 ? "Casado" : nomina[0]?.estadocivil == 3 ? "Divorciado" : nomina[0]?.estadocivil == 4 ? "Conviviente" : nomina[0]?.estadocivil == 5 ? "Viudo" : ""}</div>
                    <div class="col-md-6"><strong>Correo:</strong> ${nomina[0]?.correo ?? ""}</div>
                    <div class="col-md-6"><strong>Domicilio:</strong> ${nomina[0]?.domicilio ?? ""}</div>
                    <div class="col-md-6"><strong>Contacto de Emergencia:</strong> ${nomina[0]?.contactoemergencia ?? ""}</div>
                    <div class="col-md-6"><strong>Fecha de Ingreso:</strong> ${nomina[0]?.fnacimiento ?? ""}</div>
                    <div class="col-md-6"><strong>Cargo:</strong> ${nomina[0]?.cargo ?? ""}</div>
                    <div class="col-md-6"><strong>Discapacidad:</strong> ${nomina[0]?.discapacidad ?? ""}</div>
                    <div class="col-md-6"><strong>Nivel de Estudio:</strong> ${nomina[0]?.nivelestudio ?? ""}</div>
                </div>
            </div>

            <div class="mb-4">
                <h5 class="fw-bold border-bottom pb-2">Datos físicos</h5>
                <div class="row">
                    <div class="col-md-4"><strong>Camisa:</strong> ${nomina[0]?.camisa ?? ""}</div>
                    <div class="col-md-4"><strong>Pantalón:</strong> ${nomina[0]?.pantalon ?? ""}</div>
                    <div class="col-md-4"><strong>Zapatos:</strong> ${nomina[0]?.zapatos ?? ""}</div>
                </div>
            </div>

            <div>
                <h5 class="fw-bold border-bottom pb-2">Información de pago</h5>
                <div class="row">
                    <div class="col-md-6"><strong>RUC:</strong> ${nomina[0]?.ruc ?? ""}</div>
                    <div class="col-md-6"><strong>N° de Cuenta:</strong> ${nomina[0]?.ncuenta ?? ""}</div>
                    <div class="col-md-6"><strong>Clave SOL:</strong> ${nomina[0]?.clavesol ?? ""}</div>
                    <div class="col-md-6"><strong>Tipo:</strong> ${nomina[0]?.tipo == 1 ? "Planilla" : nomina[0]?.tipo == 2 ? "Contración" : nomina[0]?.tipo == 3 ? "Locación" : ""}</div>
                </div>
            </div>
        </div>
        `
    }

    $q("#btnGenerarExcel").addEventListener("click", async () => {
        console.log("listNominas -> ", listNominas);

        if (listNominas.length === 0) {
            showToast("No hay datos para exportar.", "ERROR");
            return;
        }

        const workbook = new ExcelJS.Workbook();
        const worksheet = workbook.addWorksheet("Nómina de colaboradores");

        // TÍTULO DEL REPORTE
        worksheet.mergeCells('A1:R1');
        const titleCell = worksheet.getCell('A1');
        titleCell.value = 'REPORTE    ENERO    2025';
        titleCell.font = { bold: true, size: 12 };
        titleCell.alignment = { horizontal: 'center', vertical: 'middle' };
        titleCell.fill = {
            type: 'pattern',
            pattern: 'solid',
            fgColor: { argb: 'FFFF00' } // Amarillo
        };

        // Fila vacía
        worksheet.addRow([]);

        // ENCABEZADOS DE SECCIONES
        const sectionHeaders = [
            { text: 'DATOS GENERALES', start: 'A', end: 'E' },
            { text: 'DATOS PERSONALES', start: 'F', end: 'K' },
            { text: 'DATOS FÍSICOS', start: 'L', end: 'N' },
            { text: 'INFORMACIÓN DE PAGOS', start: 'O', end: 'R' }
        ];

        // Agregar encabezados de sección
        const sectionRow = worksheet.addRow([]);
        sectionHeaders.forEach(section => {
            const startCol = section.start.charCodeAt(0) - 64; // A=1, B=2, etc.
            const endCol = section.end.charCodeAt(0) - 64;

            // Merge cells para cada sección
            worksheet.mergeCells(`${section.start}3:${section.end}3`);
            const sectionCell = worksheet.getCell(`${section.start}3`);
            sectionCell.value = section.text;
            sectionCell.font = { bold: true, color: { argb: 'FFFFFF' } };
            sectionCell.alignment = { horizontal: 'center', vertical: 'middle' };
            sectionCell.fill = {
                type: 'pattern',
                pattern: 'solid',
                fgColor: { argb: '000000' } // Negro
            };
        });

        // ENCABEZADOS DE COLUMNAS
        const detailHeaders = [
            // DATOS GENERALES
            'TIPO', 'NOMBRE Y APELLIDOS', 'DNI', 'CARGO', 'F. NACIMIENTO', 'ESTADO CIVIL',
            // DATOS PERSONALES  
            'SEXO', 'DOMICILIO', 'CORREO ELECTRONICO', 'NIVEL DE ESTUDIO', 'CONTACTO DE EMERGENCIA (NOMBRE Y APELLIDOS)', 'DISCAPACIDAD / ENFERMEDAD',
            // DATOS FÍSICOS
            'CAMISA/CASA CA', 'PANTALON', 'ZAPATOS',
            // INFORMACIÓN DE PAGOS
            'RUC', 'CLAVE SOL', 'CUENTA DE BANCO'
        ];

        const headerRow = worksheet.addRow(detailHeaders);

        // Estilo para encabezados de columnas
        headerRow.eachCell((cell, index) => {
            cell.font = { bold: true, size: 9 };
            cell.alignment = { horizontal: 'center', vertical: 'middle', wrapText: true };
            cell.fill = {
                type: 'pattern',
                pattern: 'solid',
                fgColor: { argb: 'FFFF00' } // Amarillo
            };
            cell.border = {
                top: { style: 'thin' },
                bottom: { style: 'thin' },
                left: { style: 'thin' },
                right: { style: 'thin' }
            };
        });

        // FILA TIPO - ELIMINAR ESTA SECCIÓN
        // Ya no necesitamos una fila separada para TIPO

        // AGREGAR DATOS
        listNominas.forEach((nomina, index) => {
            const dataRow = worksheet.addRow([
                nomina.tipo || '', // Columna A - Tipo
                nomina.nombreapellidos || '', // Nombre completo
                nomina.dni || '',
                nomina.cargo || '',
                nomina.fnacimiento || '',
                nomina.estadocivil || '',
                nomina.sexo || '',
                nomina.domicilio || '',
                nomina.correo || '',
                nomina.nivelestudio || '',
                nomina.contactoemergencia || '',
                nomina.discapacidad || '',
                nomina.camisa || '',
                nomina.pantalon || '',
                nomina.zapatos || '',
                nomina.ruc || '',
                nomina.clavesol || '',
                nomina.ncuenta || ''
            ]);

            // Estilo para filas de datos
            dataRow.eachCell((cell, colIndex) => {
                cell.border = {
                    top: { style: 'thin' },
                    bottom: { style: 'thin' },
                    left: { style: 'thin' },
                    right: { style: 'thin' }
                };
                cell.alignment = { horizontal: 'left', vertical: 'middle' };
            });
        });

        // AJUSTAR DIMENSIONES
        // Altura de filas
        worksheet.getRow(1).height = 25; // Título
        worksheet.getRow(3).height = 30; // Encabezados de sección
        worksheet.getRow(4).height = 50; // Encabezados de columnas

        // Ancho de columnas
        const columnWidths = [
            12, // A - Tipo
            25, // B - Nombre
            12, // C - DNI
            20, // D - Cargo
            15, // E - F. Nacimiento
            15, // F - Estado Civil
            8,  // G - Sexo
            30, // H - Domicilio
            25, // I - Correo
            20, // J - Nivel Estudio
            30, // K - Contacto Emergencia
            25, // L - Discapacidad
            12, // M - Camisa
            12, // N - Pantalón
            12, // O - Zapatos
            15, // P - RUC
            15, // Q - Clave Sol
            20  // R - Cuenta Banco
        ];

        worksheet.columns.forEach((column, index) => {
            if (columnWidths[index]) {
                column.width = columnWidths[index];
            }
        });

        // DESCARGAR ARCHIVO
        const buffer = await workbook.xlsx.writeBuffer();
        const blob = new Blob([buffer], {
            type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        });
        const url = URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.href = url;
        a.download = `nomina_${new Date().getFullYear()}_${new Date().getMonth() + 1}.xlsx`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    });

    $q("#tipo").addEventListener("change", async (e) => {
        const tipo = e.target.value
        if (tipo == 1) {
            $q("#div-mesanoindividual").hidden = false
            $q("#div-mesanorangoincio").hidden = true
            $q("#div-mesanorangofin").hidden = true

            $q("#mesanoindividual").value = ""
            $q("#mesanorangoincio").value = ""
            $q("#mesanorangofin").value = ""
        } else if (tipo == 2) {
            $q("#div-mesanoindividual").hidden = true
            $q("#div-mesanorangoincio").hidden = false
            $q("#div-mesanorangofin").hidden = false
            $q("#mesanoindividual").value = ""
            $q("#mesanorangoincio").value = ""
            $q("#mesanorangofin").value = ""
        }
    })

    /* $q("#btnGenerarFicha").addEventListener("click", async () => {
        //const ficha = await obtenerFichaColaborador(1)
        window.open(`${hostOnly}/generators/generadores_pdf/ficha_colaborador/fichacolaborador.php?idnomina=${4}`, '_blank');
        return
    }) */

    async function buttonFicha(e) {
        idnomina = e.target.getAttribute("data-idnomina");

        window.open(`${hostOnly}/generators/generadores_pdf/ficha_colaborador/fichacolaborador.php?idnomina=${idnomina}`, '_blank');
        return
    }

    /* async function buttonAcumulados(e) {
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
    } */
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

    /*     $q("#btnNuevoColaboradorNomina").addEventListener("click", async () => {
            console.log("butttoooon");
            await obtnerNominaPorId();
        }) */

    /*  $q("#colaborador").addEventListener("change", async (e) => {
         idcolaborador = e.target.value;
         colaboradorObt = await obtenerColaboradorPorId(idcolaborador)
         salarioObt = await obtenerUltimoSalarioColaborador(idcolaborador)
         console.log("salarioObt -> ", salarioObt);
         console.log("colaboradorObt -> ", colaboradorObt);
         tiempocalculado = calcularDiasTrabajados(colaboradorObt[0].fechaingreso)
         console.log("tiempocalculado >", tiempocalculado);
         $q("#tiempo").value = tiempocalculado ?? '';
     })
  */
    /* $q("#formNomina").addEventListener("submit", async (e) => {
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

    }) */
})