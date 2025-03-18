document.addEventListener("DOMContentLoaded", () => {
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
    let rows = $("#tb-body-reparticion").find("tr");
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
        myTable = $("#table-reparticiones").DataTable({
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
    $q("#table-reparticiones tbody").innerHTML = "";
    filters.forEach((x) => {
      x.addEventListener("change", async () => {
        await dataFilters();
      });
      if (x.id === "evento") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
    });
  }

  chargerEventsButton();

  async function dataFilters() {
    const params = new URLSearchParams();
    params.append("operation", "filtrarReparticiones");
    params.append("evento", $q("#evento").value || "");

    const data = await getDatos(`${host}reparticion.controller.php`, params);
    console.log("data -> ", data);

    $q("#table-reparticiones tbody").innerHTML = "";

    if (data.length === 0) {
      $q("#table-reparticiones tbody").innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
    }

    listCajas = []

    data.forEach((x) => {
      /* if(x.estado == 2){
        listCajas.push({
          fecha_apertura: x.fecha_apertura,
          fecha_apertura: x.fecha_apertura,
          evento: x.nom_usuario ? `${x.nom_usuario} - ${x.establecimiento}` : "No aplica",
          montoinicial: x.ccinicial,
          incremento: x.incremento,
          decremento: x.decremento,
          ccfinal: x.ccfinal,
          estado: x.estado,
        })
      } */
      $q("#table-reparticiones tbody").innerHTML += `
            <tr>
                <td>${x.nom_usuario} - ${x.establecimiento}</td>
                <td>${x.montototal ? x.montototal : 0}</td>
                <td>${x.montorepresentante ? x.montorepresentante : 0}</td>
                <td>${x.montopromotor ? x.montopromotor : 0}</td>
                <td>${x.ingresototal ? x.ingresototal : 0}</td>
                <td>${x.montoartista ? x.montoartista : 0}</td>
                <td>${x.montofinal ? x.montofinal : 0}</td>  
                <td>
                    ${x.estado == 1
          ? `<button class="btn btn-sm btn-success btn-ingresos" data-id="${x.idreparticion}" data-iddp="${x.iddetalle_presentacion}">Registrar Ingresos</button>
              <button class="btn btn-sm btn-success btn-egresos" data-id="${x.idreparticion}" data-iddp="${x.iddetalle_presentacion}">Registrar Egresos</button>
                           <button class="btn btn-sm btn-danger btn-cerrar" data-id="${x.idreparticion}">Cerrar Caja</button>`
          : "Cerrado"}
                </td>
            </tr>
        `;
    });
    console.log("listCajas -> ", listCajas);
    /* const ultimaCaja = await obtenerUltimaCCFinal(); // sale error aca, corregir
    console.log("fcajaestado -> ", ultimaCaja[0].estado);

    if (ultimaCaja[0].estado == 2) {
      $q(".contenedor-btn-nuevacaja").hidden = false
    } else {
      $q(".contenedor-btn-nuevacaja").hidden = true
    } */
    //disabledBtnArea();
    createTable(data);

  }

  function createTable(data) {
    let rows = $("#tb-body-reparticion").find("tr");
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
        myTable = $("#table-reparticiones").DataTable({
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
  
  function chargerEventsButton() {
    document
      .querySelector(".table-responsive")
      .addEventListener("click", async (e) => {
        if (e.target) {
          if (e.target.classList.contains("btn-ingresos")) {
            buttonIngresos(e);
          }
          if (e.target.classList.contains("btn-egresos")) {
            buttonEgresos(e);
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

  function buttonIngresos(e){
    idreparticion = e.target.getAttribute("data-id");
    iddp = e.target.getAttribute("data-iddp");
    window.localStorage.clear()
    window.localStorage.setItem("idreparticion", idreparticion)
    window.localStorage.setItem("iddp", iddp)
    window.location.href = `http://localhost/vega-erp/views/contabilidad/reparticion/registrar-ingresos`
    return
  }

  function buttonEgresos(e){
    idreparticion = e.target.getAttribute("data-id");
    iddp = e.target.getAttribute("data-iddp");
    window.localStorage.clear()
    window.localStorage.setItem("idreparticion", idreparticion)
    window.localStorage.setItem("iddp", iddp)
    window.location.href = `http://localhost/vega-erp/views/contabilidad/reparticion/registrar-egresos`
    return
  }
});
