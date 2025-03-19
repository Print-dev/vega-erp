document.addEventListener("DOMContentLoaded", async () => {
  let myTable = null;
  let totalIngresos = 0
  let totalEgresos = 0
  let GastoGeneralEvento = 0
  let totalGastos = 0
  let porcentajeArtista = 0
  let ingresoTotalEvento = 0
  let montoCorrespondienteVegaFinal = 0
  let porcentajeCorrespondienteVega = 0
  let montoCorrespondienteArtista = 0

  // montos correspondiente tanto para vega y promotor
  let montoCorrespondienteVega = 0
  let montoCorrespondientePromotor = 0

  // MODALES
  let modalCalculoReparticion

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

  // ******************************************** OBTENCION DE DATOS **********************************************************

  async function obtenerUsuarioPorId(idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorId");
    params.append("idusuario", idusuario);
    const fpersona = await getDatos(`${host}usuario.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerGastosPorCaja(idcajachica) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerGastosPorCaja");
    params.append("idcajachica", idcajachica);
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  }

  async function obtenerCajaChicaPorDP(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerCajaChicaPorDP");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  }

  async function obtenerConvenioPorId(idconvenio) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerConvenioPorId");
    params.append("idconvenio", idconvenio);
    const data = await getDatos(`${host}convenio.controller.php`, params);
    return data;
  }

  async function obtenerConvenioPorIdDP(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerConvenioPorIdDP");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const data = await getDatos(`${host}convenio.controller.php`, params);
    console.log("dataa line 33-> ", data);
    const convenioPropuesta = await obtenerConvenioPorId(data[0]?.idconvenio)
    return convenioPropuesta;
  }

  // ******************************* OBTENER TOTALES DE INGRESOS  Y EGRESOS ******************************

  async function obtenerEgresoPorIdReparticion(idreparticion) { // modificar
    const params = new URLSearchParams();
    params.append("operation", "obtenerEgresoPorIdReparticion");
    params.append("idreparticion", idreparticion);
    const data = await getDatos(`${host}reparticion.controller.php`, params);
    return data;
  }

  async function obtenerIngresoPorIdReparticion(idreparticion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerIngresoPorIdReparticion");
    params.append("idreparticion", idreparticion);
    const data = await getDatos(`${host}reparticion.controller.php`, params);
    return data;
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
                <td>${x.ingresototal ? x.ingresototal : 0}</td>
                <td>${x.egresototal ? x.egresototal : 0}</td>
                <td>
                    ${x.estado == 1
          ? `<button class="btn btn-sm btn-success btn-ingresos" data-id="${x.idreparticion}" data-iddp="${x.iddetalle_presentacion}">Registrar Ingresos</button>
              <button class="btn btn-sm btn-success btn-egresos" data-id="${x.idreparticion}" data-iddp="${x.iddetalle_presentacion}">Registrar Egresos</button>
              <button class="btn btn-sm btn-success btn-precio" data-id="${x.idreparticion}" data-iddp="${x.iddetalle_presentacion}" data-idusuario="${x.idusuario}">Calcular Precios</button>`
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
          if (e.target.classList.contains("btn-precio")) {
            await buttonPrecio(e);
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

  function buttonIngresos(e) {
    idreparticion = e.target.getAttribute("data-id");
    iddp = e.target.getAttribute("data-iddp");
    window.localStorage.clear()
    window.localStorage.setItem("idreparticion", idreparticion)
    window.localStorage.setItem("iddp", iddp)
    window.location.href = `http://localhost/vega-erp/views/contabilidad/reparticion/registrar-ingresos`
    return
  }

  function buttonEgresos(e) {
    idreparticion = e.target.getAttribute("data-id");
    iddp = e.target.getAttribute("data-iddp");
    window.localStorage.clear()
    window.localStorage.setItem("idreparticion", idreparticion)
    window.localStorage.setItem("iddp", iddp)
    window.location.href = `http://localhost/vega-erp/views/contabilidad/reparticion/registrar-egresos`
    return
  }

  async function buttonPrecio(e) {
    modalCalculoReparticion = new bootstrap.Modal($q("#modal-calculoreparticion"))
    modalCalculoReparticion.show()

    // PRIMERO SEGUNDO para obtener el gasto general de evento
    $q(".tbody-ingresos").innerHTML = ``
    // ME QUEDE ACA**********************************************************************************************************
 
    iddp = e.target.getAttribute("data-iddp")
    idreparticion = e.target.getAttribute("data-id")
    idusuario = e.target.getAttribute("data-idusuario")
    console.log("idddpd-> ", iddp);
    const convenioPropuesta = await obtenerConvenioPorIdDP(iddp)
    console.log("convenio propuesta -> ", convenioPropuesta);
    porcentajeVega = parseFloat(`0.${convenioPropuesta[0]?.porcentaje_vega}`)
    porcentajePromotor = parseFloat(`0.${convenioPropuesta[0]?.porcentaje_promotor}`)
    console.log("porcentaje vega -> ", porcentajeVega);
    console.log("porcentaje promotor -> ", porcentajePromotor);

    // segundo paso obtener gasto general de evento y dividir montos de acuerdo al porcentaje del convenio tanto de vega como del promotor
    const egresos = await obtenerEgresoPorIdReparticion(idreparticion)
    const ingresos = await obtenerIngresoPorIdReparticion(idreparticion)
    totalEgresos = egresos.reduce(
      (sum, egreso) => sum + parseFloat(egreso.monto),
      0
    );

    totalIngresos = ingresos.reduce(
      (sum, egreso) => sum + parseFloat(egreso.monto),
      0
    );

    console.log("monto total egresos -> ", totalEgresos);
    console.log("monto total ingresos -> ", totalIngresos);

    GastoGeneralEvento = parseFloat(totalIngresos - totalEgresos)
    console.log("gasto general evento -> ", GastoGeneralEvento);

    montoCorrespondienteVega = parseFloat(GastoGeneralEvento * porcentajeVega)
    montoCorrespondientePromotor = parseFloat(GastoGeneralEvento * porcentajePromotor)
    console.log("monto correspondiente vega -> ", montoCorrespondienteVega);
    console.log("monto correspondiente promotor -> ", montoCorrespondientePromotor);

    // tercer paso calcular gastos unicos de vega - ingreso total

    const cajaChica = await obtenerCajaChicaPorDP(iddp)
    console.log("caja chica existe -> ", cajaChica);
    const gastos = await obtenerGastosPorCaja(cajaChica[0]?.idcajachica)
    console.log("gastos -> ", gastos);

    totalGastos = gastos.reduce(
      (sum, gasto) => sum + parseFloat(gasto.monto),
      0
    );

    console.log("total de gastos de caja chica -> ", totalGastos);
    ingresoTotalEvento = montoCorrespondienteVega - totalGastos

    console.log("ingreso total de evento ->>", ingresoTotalEvento);
    const usuario = await obtenerUsuarioPorId(idusuario)
    console.log("usuario ->", usuario);
    porcentajeArtista = parseFloat(`0.${usuario[0]?.porcentaje}`)
    console.log("porcentajeArtista -> ", porcentajeArtista);
    
    // calcular porcentaje restante para vega 
    porcentajeCorrespondienteVega = parseFloat(`0.${100 - parseInt(usuario[0]?.porcentaje)}`)
    console.log("porcentajeCorrespondienteVega -> ", porcentajeCorrespondienteVega)
    montoCorrespondienteArtista = parseFloat(ingresoTotalEvento * porcentajeArtista)
    montoCorrespondienteVegaFinal = parseFloat(ingresoTotalEvento * porcentajeCorrespondienteVega)
    console.log("montoCorrespondienteArtista -> ", montoCorrespondienteArtista);
    console.log("montoCorrespondienteVegaFinal -> ", montoCorrespondienteVegaFinal);

  }
});
