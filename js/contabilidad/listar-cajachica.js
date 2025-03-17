document.addEventListener("DOMContentLoaded", async () => {
  const host = "http://localhost/vega-erp/controllers/";
  let myTable = null;

  // modales 
  let modalGastos

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

  //contenedor-btn-nuevacaja

  async function actualizarEstadoCaja(idcajachica, estado) {
    const cajaestado = new FormData();
    cajaestado.append("operation", "actualizarEstadoCaja");
    cajaestado.append("idcajachica", idcajachica);
    cajaestado.append("estado", estado);

    const fcajaestado = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: cajaestado,
    });
    const rcajaestado = await fcajaestado.json();
    return rcajaestado;
  }

  async function obtenerUltimaCCFinal() {
    const cajaestado = new URLSearchParams();
    cajaestado.append("operation", "obtenerUltimaCCFinal");

    const fcajaestado = await getDatos(`${host}cajachica.controller.php`, cajaestado)
    return fcajaestado;
  }



  // *********************************** OBTENER DATOS ********************************

  async function obtenerGastosPorCaja(idcajachica) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerGastosPorCaja");
    params.append("idcajachica", idcajachica);
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  }

  function createTable(data) {
    let rows = $("#tb-body-cajachica").find("tr");
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
        myTable = $("#table-cajaschicas").DataTable({
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
    $q("#table-cajaschicas tbody").innerHTML = "";
    filters.forEach((x) => {
      x.addEventListener("change", async () => {
        await dataFilters();
      });
      if (x.id === "busqueda_general") {
          x.addEventListener("input", async () => {
            await dataFilters();
          });
        }
    });
  }

  chargerEventsButton();

  async function dataFilters() {
    const params = new URLSearchParams();
    params.append("operation", "filtrarCajasChicas");
    params.append("fechaapertura", $q("#fechaapertura").value || "");
    params.append("fechacierre", $q("#fechacierre").value || "");
    params.append("mes", $q("#mes").value || "");
    let semana = $q("#año_semana").value; // Captura el valor en formato "YYYY-WW"
    if (semana) {
        semana = semana.replace("-W", ""); // Convierte "2025-W10" en "202510"
    }
    params.append("año_semana", semana || "");
    params.append("busqueda_general", $q("#busqueda_general").value ? $q("#busqueda_general").value :'');

    const data = await getDatos(`${host}cajachica.controller.php`, params);
    console.log("data -> ", data);

    $q("#table-cajaschicas tbody").innerHTML = "";

    if (data.length === 0) {
      $q("#table-cajaschicas tbody").innerHTML = `
            <tr>
                <td colspan="9">No encontrado</td>
            </tr>
        `;
    }

    data.forEach((x) => {
      $q("#table-cajaschicas tbody").innerHTML += `
            <tr>
                <td>${x.fecha_apertura}</td>
                <td>${x.fecha_cierre || "Aún no cerrado"}</td>
                <td>${x.nom_usuario ? `${x.nom_usuario} - ${x.establecimiento}` : "No aplica"}</td>
                <td>${x.ccinicial}</td>
                <td>${x.incremento}</td>
                <td>${x.estado == 2 ? `<button class="btn btn-sm btn-success btn-vergastos" data-id="${x.idcajachica}">Ver Gastos</button>` : "No disponible aún."}</td>
                <td>${x.ccfinal}</td>  
                <td>
                    ${x.estado == 1
          ? `<button class="btn btn-sm btn-success btn-registrar" data-id="${x.idcajachica}">Registrar Gastos</button>
                           <button class="btn btn-sm btn-danger btn-cerrar" data-id="${x.idcajachica}">Cerrar Caja</button>`
          : "Cerrado"}
                </td>
            </tr>
        `;
    });
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
    let rows = $("#tb-body-cajachica").find("tr");
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
        myTable = $("#table-cajaschicas").DataTable({
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
          if (e.target.classList.contains("btn-registrar")) {
            buttonRegistrarGastos(e);
          }
          if (e.target.classList.contains("btn-cerrar")) {
            buttonCerrarCaja(e);
          }
          if (e.target.classList.contains("btn-vergastos")) {
            buttonVerGastos(e);
          }
        }
      });
  }

  /**
   * Abre el modal de asignar Area
   * @param {*} e evento del boton
   */
  function buttonRegistrarGastos(e) {
    idcajachica = e.target.getAttribute("data-id");
    window.localStorage.clear()
    window.localStorage.setItem("idcajachica", idcajachica)
    window.location.href = `http://localhost/vega-erp/views/contabilidad/caja-chica/registrar-caja`;
    return;
  }

  async function buttonVerGastos(e) {
    let totalGastos = 0
    idgasto = e.target.getAttribute("data-id");
    const gastos = await obtenerGastosPorCaja(idgasto)
    console.log(`gastos de la caja ${idgasto}: `, gastos)
    modalGastos = new bootstrap.Modal($q("#modal-gastos"))
    modalGastos.show()
    $q(".tbody-reg-gastos").innerHTML = ''
    gastos.forEach(gasto => {
      totalGastos += parseFloat(gasto.monto);
      $q(".tbody-reg-gastos").innerHTML += `
        <tr>
            <td>${gasto.fecha_gasto}</td>
            <td>${gasto.concepto}</td>
            <td>S/. ${parseFloat(gasto.monto).toFixed(2)}</td>
        </tr>
      `
    });
    $q("#totalGastos").innerText = `S/. ${totalGastos.toFixed(2)}`;

  }

  async function buttonCerrarCaja(e) {
    idcajachica = e.target.getAttribute("data-id");
    const cajaCerrada = await actualizarEstadoCaja(idcajachica, 2);
    if (cajaCerrada) {
      showToast("Caja chica cerrada correctamente", "SUCCESS");
      await dataFilters();
      return;
    } else {
      showToast("Error al cerrar la caja chica", "ERROR");
    }
    return;
  }

  // ***************************** EVENTOS ******************************************

  $q("#btnNuevaCaja").addEventListener("click", ()=> {
    window.localStorage.clear()
  })
});
