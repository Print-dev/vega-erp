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

    function createTable(data) {
        let rows = $("#tb-body-tarifario").find("tr");
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
                myTable = $("#table-tarifarios").DataTable({ 
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
        $q("#table-tarifarios tbody").innerHTML = "";
        filters.forEach((x) => {
            /* x.addEventListener("change", async () => {
                await dataFilters();
            }); */
            if (x.id === "nomusuario") {
                x.addEventListener("input", async () => {
                    console.log($q("#nomusuario").value)
                    await dataFilters();
                });
            }
            
        });
    }

    //chargerEventsButton();

    async function dataFilters() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarTarifas");
        params.append("nomusuario", $q("#nomusuario").value ? $q("#nomusuario").value : ''); // completar luego
        
        //alert("asdasdd")
        const data = await getDatos(`${host}tarifa.controller.php`, params);
        //console.log(data);
        console.log("data -> ", data)
        $q("#table-tarifarios tbody").innerHTML = "";

        if (data.length === 0) {
            $q("#table-tarifarios tbody").innerHTML = `
              <tr>
                <td colspan="9">Sin resultados</td>
              </tr>
              `;
        }

        data.forEach((x, i) => {
            $q("#table-tarifarios tbody").innerHTML += `
              <tr>
                <td>${x.idtarifario}</td>
                <td>${x.nom_usuario}</td>
                <td>${x.tipo_evento == 1 ? "Público" : "Privado"}</td>
                <td>${x.provincia ? "Perú" : x.pais}</td>
                <td>${x.departamento ?? "No aplica"}</td>
                <td>${x.provincia ?? "No aplica"}</td>                                                                                             
                <td>${x.precio ?? "No aplica"}</td>                                                                                             
              </tr>
              `;
        });
        //disabledBtnArea();
        createTable(data);

    }

    function createTable(data) {
        let rows = $("#tb-body-tarifario").find("tr");
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
                myTable = $("#table-tarifarios").DataTable({
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
    /* function chargerEventsButton() {
        document.querySelector(".table-responsive").addEventListener("click", async (e) => {
            if (e.target) {
                idactivo = 0;
                if (e.target.classList.contains("btn-editar")) {
                    buttonEditar(e);
                }
                if (e.target.classList.contains("btn-deshabilitar")) {
                    buttonDeshabilitar(e);
                }
            }
        });
    } */

    /**
     * Abre el modal de asignar Area
     * @param {*} e evento del boton
     */
    /* function buttonEditar(e) {
        ideditar = e.target.getAttribute("data-id");

        alert("editando")
    }

    async function buttonDeshabilitar(e) {
        iddeshabilitar = e.target.getAttribute("data-id");

        if (await ask("¿Desea deshabilitar este usuario?")) {
            alert("deshabilitando....")
        }
    } */
})