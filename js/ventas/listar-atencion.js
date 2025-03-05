document.addEventListener("DOMContentLoaded", async () => {
  const host = "http://localhost/vega-erp/controllers/";
  let myTable = null;
  let idprovincia = -1;
  let provincia = "";
  let idartista = -1;
  let idcliente = -1;
  let precioTarifa = -1;
  let igv = -1;
  let iddetallepresentacion = -1;

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

  // ***************************************** OBTENER DATOS ********************************

  async function obtenerDPporId(iddp) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDPporId");
    params.append("iddetallepresentacion", iddp);
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    return data;
  }

  async function verificarDatosIncompletosCliente(idcliente) {
    const params = new URLSearchParams();
    params.append("operation", "verificarDatosIncompletosCliente");
    params.append("idcliente", idcliente);
    const data = await getDatos(`${host}cliente.controller.php`, params);
    return data;
  }

  async function obtenerContratoPorDP(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerContratoPorDP");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const data = await getDatos(`${host}contrato.controller.php`, params);
    return data;
  }

  async function obtenerTarifaArtistaPorProvincia(idprovincia, idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerTarifaArtistaPorProvincia");
    params.append("idprovincia", idprovincia);
    params.append("idusuario", idusuario);
    const data = await getDatos(`${host}tarifa.controller.php`, params);
    return data;
  }

  // ******************************************** REGISTRAR DATOS ************************************************

  async function registrarContrato(iddetallepresentacion, estado) {
    const convenio = new FormData();
    convenio.append("operation", "registrarContrato");
    convenio.append("iddetallepresentacion", iddetallepresentacion); // id artista
    convenio.append("montopagado", $q("#montopagado").value);
    convenio.append("estado", estado);

    const fconvenio = await fetch(`${host}contrato.controller.php`, {
      method: "POST",
      body: convenio,
    });
    const rconvenio = await fconvenio.json();
    return rconvenio;
  }

  function createTable(data) {
    let rows = $("#tb-body-atencion").find("tr");
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
        myTable = $("#table-atenciones").DataTable({
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
    $q("#table-atenciones tbody").innerHTML = "";
    filters.forEach((x) => {
      /* x.addEventListener("change", async () => {
        await dataFilters();
      }); */
      if (x.id === "ncotizacion") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
      if (x.id === "ndocumento") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
    });
  }

  chargerEventsButton();

  async function dataFilters() {
    const params = new URLSearchParams();
    params.append("operation", "filtrarAtenciones");
    params.append(
      "ncotizacion",
      $q("#ncotizacion").value ? $q("#ncotizacion").value : ""
    );
    params.append(
      "ndocumento",
      $q("#ndocumento").value ? $q("#ndocumento").value : ""
    );
    //alert("asdasdd")
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    console.log(data);
    console.log("data -> ", data);
    $q("#table-atenciones tbody").innerHTML = "";

    if (data.length === 0) {
      $q("#table-atenciones tbody").innerHTML = `
          <tr>
            <td colspan="9">No encontrado</td>
          </tr>
          `;
    }

    data.forEach((x, i) => {
      $q("#table-atenciones tbody").innerHTML += `
          <tr>
            <td>${x.iddetalle_presentacion}</td>
            <td>${x.ncotizacion}</td>
            <td>${x.nom_usuario}</td>
            <td>${x.ndocumento}</td>
            <td>${x.razonsocial}</td>
            <td>${
              x.tipo_evento == 1
                ? "Público"
                : x.tipo_evento == 2
                ? "Privado"
                : ``
            }</td>
            <td>${
              x.modalidad == 1 ? "Convenio" : x.modalidad == 2 ? "Contrato" : ``
            }</td>
            <td>${x.fecha_presentacion}</td>                        
            <td>
              ${
                parseInt(x.modalidad) == 1
                  ? `<button type="button" class="btn btn-sm btn-warning btn-convenio" data-id=${x.iddetalle_presentacion} title="Generar Convenio">
                  Convenio
                </button>`
                  : parseInt(x.modalidad) == 2
                  ? `
                <button type="button" class="btn btn-sm btn-success btn-cotizar" data-id=${x.iddetalle_presentacion} 
                  data-estado=${x.condicion} title="Cotizar">Cotizar</button>`
                  : ``
              }
              ${
                parseInt(x.modalidad) === 2
                  ? `
                <button type="button" class="btn btn-sm btn-secondary btn-contrato" data-id=${x.iddetalle_presentacion} title="Generar contrato">
                  Generar Contrato
                </button>`
                  : ``
              }
              
              <button type="button" class="btn btn-sm btn-danger btn-cancelar" data-id=${
                x.iddetalle_presentacion
              } title="Cancelar">
                Cancelar
              </button>
            </td>
          </tr>
          `;
    });
    //disabledBtnArea();
    createTable(data);
  }

  function createTable(data) {
    let rows = $("#tb-body-atencion").find("tr");
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
        myTable = $("#table-atenciones").DataTable({
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
          idactivo = 0;
          if (e.target.classList.contains("btn-convenio")) {
            buttonConvenio(e);
          }
          if (e.target.classList.contains("btn-cotizar")) {
            await buttonCotizar(e);
          }
          if (e.target.classList.contains("btn-contrato")) {
            await buttonContrato(e);
          }
          /* if(e.target.classList.contains("show-espec")){//abre el sidebar
          await btnSBUpdateActivo(e);
        }
        if (e.target.classList.contains("change-area")) {
          buttonCambiarArea(e);
        } */
        }
      });
  }

  /**
   * Abre el modal de asignar Area
   * @param {*} e evento del boton
   */
  function buttonConvenio(e) {
    idconvenio = e.target.getAttribute("data-id");

    const modalImg = new bootstrap.Modal($q("#modal-convenio"));
    modalImg.show();
  }

  async function buttonCotizar(e) {
    idcotizar = e.target.getAttribute("data-id");
    await renderizarUbigeoPresentacion(idcotizar);
    const modalImg = new bootstrap.Modal($q("#modal-previacotizacion"));
    modalImg.show();
  }

  async function buttonContrato(e) {
    iddp = e.target.getAttribute("data-id");
    const dp = await obtenerDPporId(iddp);
    idprovincia = dp[0].idprovincia;
    idartista = dp[0].idusuario;
    idcliente = dp[0].idcliente;
    igv = dp[0].igv;
    iddetallepresentacion = dp[0].iddetalle_presentacion;
    console.log(dp);
    const cliente = await verificarDatosIncompletosCliente(dp[0].idcliente);
    const contratoExiste = await obtenerContratoPorDP(iddp);

    console.log(contratoExiste);

    console.log(cliente);
    if (
      cliente[0].ndocumento.length === 11 && // Un RUC tiene 11 dígitos
      cliente[0].ndocumento.startsWith("1") // Verifica si empieza con "1"
    ) {
      // Es un RUC de persona natural
      console.log("es ruc persona natural");
      if (
        !cliente[0].correo ||
        !cliente[0].direccion ||
        !cliente[0].ndocumento ||
        !cliente[0].razonsocial ||
        !cliente[0].telefono
      ) {
        console.log("su legal esta null");
        const modalDatos = new bootstrap.Modal(
          $q("#modal-datosclienteincompletos")
        );
        modalDatos.show();
        await renderizarDatosClienteIncompleto(cliente[0]);
      }
    } else if (
      cliente[0].ndocumento.length === 11 &&
      cliente[0].ndocumento.startsWith("2") // Verifica si empieza con "2"
    ) {
      // Es un RUC de empresa (persona jurídica)
      console.log("es ruc empresa");
      if (
        !cliente[0].correo ||
        !cliente[0].direccion ||
        !cliente[0].ndocumento ||
        !cliente[0].razonsocial ||
        !cliente[0].representantelegal ||
        !cliente[0].telefono
      ) {
        console.log("su legal esta null");

        if (contratoExiste.length > 0) {
          const modalDatos = new bootstrap.Modal(
            $q("#modal-datosclienteincompletos")
          );
          modalDatos.show();
          await renderizarDatosClienteIncompleto(cliente[0]);
        } else {
          const modalDatos = new bootstrap.Modal($q("#modal-contrato"));
          modalDatos.show();
        }
      }
    } else if (
      cliente[0].ndocumento.length === 8 // Un DNI tiene 8 dígitos
    ) {
      // Es un DNI (persona natural)
      console.log("es dni persona natural");
      if (
        !cliente[0].correo ||
        !cliente[0].direccion ||
        !cliente[0].ndocumento ||
        !cliente[0].razonsocial ||
        !cliente[0].telefono
      ) {
        console.log("su legal esta null");
        if (contratoExiste.length > 0) {
          const modalDatos = new bootstrap.Modal(
            $q("#modal-datosclienteincompletos")
          );
          modalDatos.show();
          await renderizarDatosClienteIncompleto(cliente[0]);
        } else {
          const modalDatos = new bootstrap.Modal($q("#modal-contrato"));
          modalDatos.show();
        }
      }
    }

    if (contratoExiste.length > 0) {
      //http://localhost/vega-erp/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=1&idprovincia=100&idusuario=2&precio=2500
      window.open(
        `http://localhost/vega-erp/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=${
          contratoExiste[0].idcontrato
        }&idprovincia=${idprovincia}&idusuario=${idartista}&precio=${2500}`
      );
      //window.open(`http://localhost/vega-erp/generators/generadores_pdf/cotizacion/cotizacion.php?iddetallepresentacion=${iddetalleevento}&idprovincia=${idprovincia}&idusuario=${idartista}&provincia=${provincia}&precio=${2500}`)
      return;
    }

    /* const modalImg = new bootstrap.Modal($q("#modal-previacotizacion"));
    modalImg.show(); */
    //alert("CONSULTANDOCONTRATO")
  }

  // ******************************************* VINCULANDO DATOS A MODALES ********************************

  async function renderizarUbigeoPresentacion(iddp) {
    const dp = await obtenerDPporId(iddp);
    console.log(dp);
    //alert("asdasdd")
    idprovincia = dp[0].idprovincia;
    idartista = dp[0].idusuario;
    provincia = dp[0].provincia;
    iddetalleevento = dp[0].iddetalle_presentacion;

    $q("#tInfoCotizacion").innerHTML = "";
    dp.forEach((detdp) => {
      $q("#tInfoCotizacion").innerHTML = `
        <tr>
          <td>${detdp.departamento}</td>
          <td>${detdp.provincia}</td>
          <td>Alta</td>
          <td>2000</td>
        </tr>
      `;
    });
  }

  async function renderizarDatosClienteIncompleto(cliente) {
    // renderiza los datos completos e incompletos a los campos del modal
    $q("#razonsocial").value = cliente.razonsocial;
    $q("#representantelegal").value = cliente.representantelegal;
    $q("#telefono").value = cliente.telefono;
    $q("#correo").value = cliente.correo;
    $q("#direccion").value = cliente.direccion;
  }

  //  ******************************************* EVENTOS *******************************************************

  $q("#btnGenerarCotizacion").addEventListener("click", async (e) => {
    //const tarifaArtista = await obtenerTarifasPorProvincia()
    //    const cotizacion = await obtenerCotizacion(iddetalleevento)
    console.log("clickeando");
    window.open(
      `http://localhost/vega-erp/generators/generadores_pdf/cotizacion/cotizacion.php?iddetallepresentacion=${iddetalleevento}&idprovincia=${idprovincia}&idusuario=${idartista}&provincia=${provincia}&precio=${2500}`
    );
    return;
  });

  $q("#montopagado").addEventListener("input", async () => {
    $q("#porciento").innerHTML = "";
    $q("#btnGenerarReserva").hidden = true
    let precioFinal = -1;
    let precio25 = -1;
    let precio50 = -1;

    console.log("adasddadsadds");
    const tarifa = await obtenerTarifaArtistaPorProvincia(
      idprovincia,
      idartista
    );
    console.log("tarifa->", tarifa);

    if (igv == 0) {
      precioFinal = parseFloat(tarifa[0].precio) + 2500;
    } else if (igv == 1) {
      precioFinal = (parseFloat(tarifa[0].precio) + 2500) * 1.18; // Se multiplica por 1.18 para agregar IGV
    }

    precio25 = precioFinal * 0.25;
    precio50 = precioFinal * 0.5;

    let montoPagado = parseFloat($q("#montopagado").value); // Convertir a número

    if (montoPagado >= precio50) {
      console.log("pago del 50%");
      $q("#porciento").innerHTML =
        '<label for="" class="text-success" id="porciento"><small>Pago del 50%</small></label>';
    } else if (montoPagado >= precio25) {
      console.log("pago del 25%");
      $q("#porciento").innerHTML =
        '<label for="" class="text-success" id="porciento"><small>Pago del 25%</small></label>';

      $q("#btnGenerarReserva").hidden = false
    }
  });


  
  $q("#btnGenerarReserva").addEventListener("click", async () => {
    if (montoPagado >= precio50) {
      console.log("pago del 50%");
      $q("#porciento").innerHTML =
        '<label for="" class="text-success" id="porciento"><small>Pago del 50%</small></label>';

      const idcontrato = await registrarContrato(iddetallepresentacion, 2);
      if (idcontrato) {
        showToast("Pago guardado", "SUCCESS");
      }
    } else if (montoPagado >= precio25) {
      console.log("pago del 25%");
      $q("#porciento").innerHTML =
        '<label for="" class="text-success" id="porciento"><small>Pago del 25%</small></label>';
      const idcontrato = await registrarContrato(iddetallepresentacion, 1);
      if (idcontrato) {
        showToast("Pago guardado", "SUCCESS");
      }
    }
  });
});

// *****************************************************************************************
