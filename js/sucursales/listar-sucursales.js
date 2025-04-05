document.addEventListener("DOMContentLoaded", async () => {
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

    // ****************************************** RENDER PREVIEW ****************************************************

    async function obtenerDepartamentos() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDepartamentos");
        params.append("idnacionalidad", $q("#nacionalidad").value);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    async function obtenerProvincias() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerProvincias");
        params.append("iddepartamento", $q("#departamento").value);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    async function obtenerDistritos() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDistritos");
        params.append("idprovincia", $q("#provincia").value);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    $q("#nacionalidad").addEventListener("change", async () => {
        const departamentos = await obtenerDepartamentos();
        $q("#departamento").innerHTML = "<option value=''>Selecciona</option>";
        departamentos.forEach(dpa => {
            $q("#departamento").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
        });
    });

    $q("#departamento").addEventListener("change", async () => {
        const provincias = await obtenerProvincias();
        $q("#provincia").innerHTML = "<option value=''>Selecciona</option>";
        provincias.forEach(prv => {
            $q("#provincia").innerHTML += `<option value="${prv.idprovincia}">${prv.provincia}</option>`;
        });
    });

    $q("#provincia").addEventListener("change", async () => {
        const distritos = await obtenerDistritos();
        $q("#distrito").innerHTML = "<option value=''>Selecciona</option>";
        distritos.forEach(dst => {
            $q("#distrito").innerHTML += `<option value="${dst.iddistrito}">${dst.distrito}</option>`;
        });
    });


    // ******************************* CONFIGURACION DE TABLA *******************************************************

    function createTable(data) {
        let rows = $("#tb-body-sucursal").find("tr");
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
                myTable = $("#table-sucursales").DataTable({
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
        $q("#table-sucursales tbody").innerHTML = "";
        filters.forEach((x) => {
            x.addEventListener("change", async () => {
                await dataFilters();
            });
            if (x.id === "nombresucursal") {
                x.addEventListener("input", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "nacionalidad") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "departamento") {
                x.addEventListener("change", async (e) => {
                    console.log(e.target.value);
                    await dataFilters();
                });
            }
            if (x.id === "provincia") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
            if (x.id === "distrito") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
        });
    }

    chargerEventsButton();

    async function dataFilters() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarSucursales");
        params.append("nombre", $q("#nombresucursal").value ? $q("#nombresucursal").value : '');
        params.append("iddepartamento", $q("#departamento").value ? $q("#departamento").value : '');
        params.append("idprovincia", $q("#provincia").value ? $q("#provincia").value : '');
        params.append("iddistrito", $q("#distrito").value ? $q("#distrito").value : '');
        //alert("asdasdd")
        const data = await getDatos(`${host}sucursal.controller.php`, params);
        //console.log(data);
        console.log("data -> ", data)
        $q("#table-sucursales tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-sucursales tbody").innerHTML = `
              <tr>
                <td colspan="9">Sin resultados</td>
              </tr>
              `;
        }

        data.forEach((x, i) => {
            $q("#table-sucursales tbody").innerHTML += `
              <tr>
                <td>${x.departamento} - ${x.provincia}</td>
                <td>${x.nombre}</td>
                <td>${x.ruc}</td>
                <td>${x.telefono}</td>
                <td>${x.direccion}</td>
                <td>${x.nombres} ${x.apellidos}</td>                                                                               
                <td>
                  <button type="button" class="btn btn-sm btn-success btn-editar" data-idsucursal=${x.idsucursal} title="Editar usuario">
                      Editar
                    </button>                           
                </td>
              </tr>
              `;
        });
        //disabledBtnArea();
        createTable(data);

    }

    function createTable(data) {
        let rows = $("#tb-body-sucursal").find("tr");
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
                myTable = $("#table-sucursales").DataTable({
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
                if (e.target.classList.contains("btn-editar")) {
                    buttonEditar(e);
                }
                /* if (e.target.classList.contains("btn-deshabilitar")) {
                    buttonDeshabilitar(e);
                }

                if (e.target.classList.contains("btn-habilitar")) {
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

    function buttonEditar(e) {
        idsucursal = e.target.getAttribute("data-idsucursal");
        window.localStorage.clear()
        window.localStorage.setItem("idsucursal", idsucursal);
        window.location.href = `${hostOnly}/views/utilitario/sucursales/actualizar-sucursal`;
    }
})