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
  let idcontrato = -1
  let idpagocontrato = -1

  //MODALES
  let modalDatosContrato
  let modalDatosClienteIncompleto
  let modalReserva

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

  async function obtenerPagosContratoPorIdContrato(idcontrato) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerPagosContratoPorIdContrato");
    params.append("idcontrato", idcontrato);
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

  async function obtenerReservaPorPagoContrato(idpagocontrato) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerReservaPorPagoContrato");
    params.append("idpagocontrato", idpagocontrato);
    const data = await getDatos(`${host}contrato.controller.php`, params);
    return data;
  }

  // ******************************************** REGISTRAR DATOS ************************************************

  async function registrarContrato(iddetallepresentacion, estado) {
    const convenio = new FormData();
    convenio.append("operation", "registrarContrato");
    convenio.append("iddetallepresentacion", iddetallepresentacion); // id artista
    //convenio.append("montopagado", $q("#montopagado").value);
    convenio.append("estado", estado);

    const fconvenio = await fetch(`${host}contrato.controller.php`, {
      method: "POST",
      body: convenio,
    });
    const rconvenio = await fconvenio.json();
    return rconvenio;
  }

  async function registrarPagoContrato(idcontrato, estado) {
    const fechaHoraPeru = obtenerFechaHoraPeru();

    const pago = new FormData();
    pago.append("operation", "registrarPagoContrato");
    pago.append("idcontrato", idcontrato);
    pago.append("monto", $q("#montopagado").value);
    pago.append("tipopago", $q("#tipopago").value);
    pago.append("noperacion", $q("#noperacion").value.trim() ? $q("#noperacion").value.trim() : '');
    pago.append("fechapago", fechaHoraPeru[0]);
    pago.append("horapago", fechaHoraPeru[1]);
    pago.append("estado", estado);

    const fpago = await fetch(`${host}contrato.controller.php`, {
      method: "POST",
      body: pago,
    });
    const rpago = await fpago.json();
    return rpago;
  }

  async function actualizarEstadoReservaDp(iddetallepresentacion, estreserva) {
    const reserva = new FormData();
    reserva.append("operation", "actualizarEstadoReservaDp");
    reserva.append("iddetallepresentacion", iddetallepresentacion);
    reserva.append("reserva", estreserva);

    const freserva = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: reserva,
    });
    const rreserva = await freserva.json();
    return rreserva;
  }

  async function registrarReserva(idpagocontrato, vigencia) {
    const fechaHoraPeru = obtenerFechaHoraPeru();

    const reserva = new FormData();
    reserva.append("operation", "registrarReserva");
    reserva.append("idpagocontrato", idpagocontrato);
    reserva.append("vigencia", vigencia);
    reserva.append("fechacreada", fechaHoraPeru[0]);

    const freserva = await fetch(`${host}contrato.controller.php`, {
      method: "POST",
      body: reserva,
    });
    const rreserva = await freserva.json();
    return rreserva;
  }

  async function actualizarPagado50DP(iddetallepresentacion) {
    const pagado50 = new FormData();
    pagado50.append("operation", "actualizarPagado50DP");
    pagado50.append("iddetallepresentacion", iddetallepresentacion);
    pagado50.append("pagado50", 1);

    const fpagado50 = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: pagado50,
    });
    const rpagado50 = await fpagado50.json();
    return rpagado50;
  }

  // ******************************************** DATATABLE ************************************************

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
            <td>${x.ncotizacion ? x.ncotizacion : 'no aplica'}</td>
            <td>${x.nom_usuario}</td>
            <td>${x.ndocumento}</td>
            <td>${x.razonsocial}</td>
            <td>${x.tipo_evento == 1
          ? "Público"
          : x.tipo_evento == 2
            ? "Privado"
            : ``
        }</td>
            <td>${x.modalidad == 1 ? "Convenio" : x.modalidad == 2 ? "Contrato" : ``
        }</td>
            <td>${x.fecha_presentacion}</td>                        
            <td>
              ${parseInt(x.modalidad) == 1
          ? `<button type="button" class="btn btn-sm btn-warning btn-convenio" data-id=${x.iddetalle_presentacion} title="Generar Convenio">
                  Convenio
                </button>`
          : parseInt(x.modalidad) == 2
            ? `
                <button type="button" class="btn btn-sm btn-success btn-cotizar" data-id=${x.iddetalle_presentacion} 
                  data-estado=${x.condicion} title="Cotizar">Cotizar</button>`
            : ``
        }
              ${parseInt(x.modalidad) === 2
          ? `
                <button type="button" class="btn btn-sm btn-secondary btn-pagar" data-id=${x.iddetalle_presentacion} title="Pagar">
                  Pagar
                </button>
                <button type="button" class="btn btn-sm btn-secondary btn-contrato" data-id=${x.iddetalle_presentacion} title="Generar contrato">
                  Generar Contrato
                </button>
                `
          : ``
        }

        ${
          parseInt(x.pagado50) == 1 ? `` : parseInt(x.reserva) == 1
          ? `<button type="button" class="btn btn-sm btn-primary btn-reserva" data-id=${x.iddetalle_presentacion} title="Generar Reserva">
              Generar Reserva
            </button>` : ``}
              
              
          `;

      // Evento para actualizar estado dp
      console.log("dias de validez: ", x.validez)
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
          if (e.target.classList.contains("btn-pagar")) {
            await buttonPagar(e);
          }
          if (e.target.classList.contains("btn-contrato")) {
            await buttonContrato(e);
          }
          if (e.target.classList.contains("btn-reserva")) {
            await buttonReserva(e);
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
    let pagoAdelantadoO50 = false
    idcontrato = e.target.getAttribute("data-id");
    const dp = await obtenerDPporId(idcontrato); //esto en realidad es id detalle presentacion
    idprovincia = dp[0].idprovincia
    idartista = dp[0].idusuario;
    const contrato = await obtenerContratoPorDP(idcontrato) //esto en realidad es id detalle presentacion
    console.log("contratoo al dar click al btn contrato -> ", contrato)
    if (contrato.length > 0) {
      const pagosContrato = await obtenerPagosContratoPorIdContrato(contrato[0]?.idcontrato)
      console.log("pagos contrato al dar click al btn contrato -> ", pagosContrato)
      for (let i = 0; i < pagosContrato.length; i++) {
        if (pagosContrato[i].estado == 3) {
          // ya se pago el 25% restante o bien ya se pago el 50% de golpe
          pagoAdelantadoO50 = true
          break;
        }

      }
      if (pagoAdelantadoO50) {
        window.open(
          `http://localhost/vega-erp/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=${contrato[0].idcontrato
          }&idprovincia=${idprovincia}&idusuario=${idartista}&precio=${2500}`
        );
        return
      }
    }
    showToast("Aun no puedes generar contrato hasta pagar el adelanto del 50%", "ERROR")
  }

  async function buttonReserva(e) {

    let pagoAdelantadoO25 = false
    idcontrato = e.target.getAttribute("data-id");
    const contrato = await obtenerContratoPorDP(idcontrato) //esto en realidad es id detalle presentacion
    console.log("contrato  existe ->", contrato)
    if (contrato.length > 0) {
      const pagosContrato = await obtenerPagosContratoPorIdContrato(contrato[0]?.idcontrato)
      console.log("pagos contrato al dar click al btn contrato -> ", pagosContrato)
      for (let i = 0; i < pagosContrato.length; i++) {
        if (pagosContrato[i].estado == 1) {
          // ya se pago el 25%
          pagoAdelantadoO25 = true
          break;
        }

      }
      idpagocontrato = pagosContrato[0]?.idpagocontrato
      const reservaExiste = await obtenerReservaPorPagoContrato(pagosContrato[0]?.idpagocontrato)
      console.log("reserva existe -> ", reservaExiste)
      if (pagoAdelantadoO25) {
        if (reservaExiste.length > 0) {
          window.open(
            `http://localhost/vega-erp/generators/generadores_pdf/constancia_reserva/constanciareserva.php?iddetallepresentacion=${idcontrato}&idpagocontrato=${pagosContrato[0]?.idpagocontrato}` // esto en realida es el iddetalle_presentacion
          );
          console.log("Si existe la reserva")
          return
        } else {
          // abrir modal
          console.log("NO existe la reserva")
          modalReserva = new bootstrap.Modal(
            $q("#modal-reserva")
          );
          modalReserva.show();
          return
        }
      }
    }
    showToast("Aun no puedes generar reserva hasta pagar el adelanto del 25%", "ERROR")
  }

  async function buttonPagar(e) {
    $q("#montopagado").value = 0
    $q("#contenedor-noperacion").hidden = true
    $q("#noperacion").value = ''
    $q("#tipopago").value = -1
    iddp = e.target.getAttribute("data-id");
    const dp = await obtenerDPporId(iddp);
    idprovincia = dp[0].idprovincia;
    idartista = dp[0].idusuario;
    idcliente = dp[0].idcliente;
    igv = dp[0].igv;
    iddetallepresentacion = dp[0].iddetalle_presentacion;
    totalPagado = 0
    console.log(dp);
    const cliente = await verificarDatosIncompletosCliente(dp[0].idcliente);
    console.log(iddp);
    const contratoExiste = await obtenerContratoPorDP(iddp);
    console.log(contratoExiste);
    idcontrato = contratoExiste[0]?.idcontrato
    console.log("idcontrato existente -> " + idcontrato)


    console.log(cliente);
    if (
      cliente[0].ndocumento.length === 11 && // Un RUC tiene 11 dígitos
      cliente[0].ndocumento.startsWith("1") // Verifica si empieza con "1"
    ) {
      // Es un RUC de persona natural
      console.log("es ruc persona natural");

      console.log("su legal esta null");
      if (contratoExiste?.length > 0) {
        let pago50 = false
        const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
        console.log("pagos -> ", pagos)

        totalPagado = pagos.reduce((acumulador, pago) => acumulador + parseFloat(pago.monto), 0);

        console.log("Total pagado: ", totalPagado);
        /*  if (totalPagado == 0){
           
         } */

        pagos.forEach(pago => {
          if (pago?.tipo_pago == 3) {
            pago50 = true
          }
        });
        console.log("pago50 bool -> ", pago50)
        if (pago50) {
          let incompleto = false
          const datosIncompletos = await verificarDatosIncompletosCliente(idcliente)
          for (const clave in datosIncompletos) {
            if (datosIncompletos[clave] === null || datosIncompletos[clave] === "") {
              //console.log(`El campo "${clave}" está vacío. Deteniendo el ciclo.`);
              incompleto = true;
              break;
            }
            //console.log(`${clave}: ${datosIncompletos[clave]}`);
          }
          if (incompleto) {
            modalDatosClienteIncompleto = new bootstrap.Modal(
              $q("#modal-datosclienteincompletos")
            );
            modalDatosClienteIncompleto.show();
            await renderizarDatosClienteIncompleto(cliente[0]);
            return
          }
          window.open(
            `http://localhost/vega-erp/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=${contratoExiste[0].idcontrato
            }&idprovincia=${idprovincia}&idusuario=${idartista}&precio=${2500}`
          );

        }
        else if (!pago50) {
          modalDatosContrato = new bootstrap.Modal($q("#modal-contrato"));
          modalDatosContrato.show();
          console.log("aca se regsitrara el contrato apenas habra", contratoExiste)
          //$q("#btnGenerarReserva").hidden = false
          $q("#montoActual").innerHTML = `<label for="" class="text-primary">Monto actual pagado: ${totalPagado}</label>`;
        }
      } else {
        const contrato = await registrarContrato(iddetallepresentacion, 1);
        console.log("idcontrato > ", contrato)
        idcontrato = contrato.idcontrato
        if (idcontrato) {
          modalDatosContrato = new bootstrap.Modal($q("#modal-contrato"));
          modalDatosContrato.show();
        }
      }

    } else if (
      cliente[0].ndocumento.length === 11 &&
      cliente[0].ndocumento.startsWith("2") // Verifica si empieza con "2"
    ) {
      // Es un RUC de empresa (persona jurídica)
      console.log("es ruc empresa");

      console.log("su legal esta null");
      console.log("contratoExiste -> ", contratoExiste)


      if (contratoExiste?.length > 0) {
        let pago50 = false
        const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
        console.log("pagos -> ", pagos)

        totalPagado = pagos.reduce((acumulador, pago) => acumulador + parseFloat(pago.monto), 0);

        console.log("Total pagado: ", totalPagado);


        pagos.forEach(pago => {
          if (pago?.tipo_pago == 3) {
            pago50 = true
          }
        });
        console.log("pago50 bool -> ", pago50)
        if (pago50) {
          let incompleto = false
          const datosIncompletos = await verificarDatosIncompletosCliente(idcliente)
          for (const clave in datosIncompletos) {
            if (datosIncompletos[clave] === null || datosIncompletos[clave] === "") {
              //console.log(`El campo "${clave}" está vacío. Deteniendo el ciclo.`);
              incompleto = true;
              break;
            }
            //console.log(`${clave}: ${datosIncompletos[clave]}`);
          }
          if (incompleto) {
            modalDatosClienteIncompleto = new bootstrap.Modal(
              $q("#modal-datosclienteincompletos")
            );
            modalDatosClienteIncompleto.show();
            await renderizarDatosClienteIncompleto(cliente[0]);
            return
          }
          window.open(
            `http://localhost/vega-erp/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=${contratoExiste[0].idcontrato
            }&idprovincia=${idprovincia}&idusuario=${idartista}&precio=${2500}`
          );

        }
        else if (!pago50) {
          modalDatosContrato = new bootstrap.Modal($q("#modal-contrato"));
          modalDatosContrato.show();
          console.log("aca se regsitrara el contrato apenas habra", contratoExiste)
          //$q("#btnGenerarReserva").hidden = false
          $q("#montoActual").innerHTML = `<label for="" class="text-primary">Monto actual pagado: ${totalPagado}</label>`;
        }
      } else {
        const contrato = await registrarContrato(iddetallepresentacion, 1);
        console.log("idcontrato > ", contrato)
        idcontrato = contrato.idcontrato
        if (idcontrato) {
          modalDatosContrato = new bootstrap.Modal($q("#modal-contrato"));
          modalDatosContrato.show();
        }

      }

    } else if (
      cliente[0].ndocumento.length === 8 // Un DNI tiene 8 dígitos
    ) {
      // Es un DNI (persona natural)
      console.log("es dni persona natural");

      console.log("su legal esta null");
      if (contratoExiste.length > 0) {
        let pago50 = false
        const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
        console.log("pagos -> ", pagos)

        totalPagado = pagos.reduce((acumulador, pago) => acumulador + parseFloat(pago.monto), 0);

        console.log("Total pagado: ", totalPagado);


        pagos.forEach(pago => {
          if (pago?.tipo_pago == 3) {
            pago50 = true
          }
        });
        console.log("pago50 bool -> ", pago50)
        if (pago50) {
          let incompleto = false
          const datosIncompletos = await verificarDatosIncompletosCliente(idcliente)
          for (const clave in datosIncompletos) {
            if (datosIncompletos[clave] === null || datosIncompletos[clave] === "") {
              //console.log(`El campo "${clave}" está vacío. Deteniendo el ciclo.`);
              incompleto = true;
              break;
            }
            //console.log(`${clave}: ${datosIncompletos[clave]}`);
          }
          if (incompleto) {
            modalDatosClienteIncompleto = new bootstrap.Modal(
              $q("#modal-datosclienteincompletos")
            );
            modalDatosClienteIncompleto.show();
            await renderizarDatosClienteIncompleto(cliente[0]);
            return
          }
          window.open(
            `http://localhost/vega-erp/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=${contratoExiste[0].idcontrato
            }&idprovincia=${idprovincia}&idusuario=${idartista}&precio=${2500}`
          );

        }
        else if (!pago50) { // ESTO ES CUANDO ES 25%  
          modalDatosContrato = new bootstrap.Modal($q("#modal-contrato"));
          modalDatosContrato.show();
          console.log("aca se regsitrara el contrato apenas habra", contratoExiste)
          //$q("#btnGenerarReserva").hidden = false
          $q("#montoActual").innerHTML = `<label for="" class="text-primary">Monto actual pagado: ${totalPagado}</label>`;
        }
      } else {
        console.log("iddetallepresentacion -> ", iddetallepresentacion)
        const contrato = await registrarContrato(iddetallepresentacion, 1);
        console.log("idcontrato > ", contrato)
        idcontrato = contrato.idcontrato
        if (idcontrato) {
          modalDatosContrato = new bootstrap.Modal($q("#modal-contrato"));
          modalDatosContrato.show();
        }
      }

    }

    //if (contratoExiste.length > 0) {
    //http://localhost/vega-erp/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=1&idprovincia=100&idusuario=2&precio=2500
    /* window.open(
      `http://localhost/vega-erp/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=${contratoExiste[0].idcontrato
      }&idprovincia=${idprovincia}&idusuario=${idartista}&precio=${2500}`
    ); */ // HABILITAR ESTO LUEGO DE LAS CONDICIONES
    //window.open(`http://localhost/vega-erp/generators/generadores_pdf/cotizacion/cotizacion.php?iddetallepresentacion=${iddetalleevento}&idprovincia=${idprovincia}&idusuario=${idartista}&provincia=${provincia}&precio=${2500}`)
    //return;
    //}

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

  $q("#btnGuardarReserva").addEventListener("click", async (e) => {
    const reservaGenerada = await registrarReserva(idpagocontrato, $q("#vigencia").value)
    console.log("reserva gerenada- >", reservaGenerada)
    if (reservaGenerada) {
      modalReserva?.hide()
      showToast("La reserva esta lista para ser generada", "SUCCESS")
    }
  })

  $q("#btnGenerarCotizacion").addEventListener("click", async (e) => {
    //const tarifaArtista = await obtenerTarifasPorProvincia()
    //    const cotizacion = await obtenerCotizacion(iddetalleevento)
    console.log("clickeando");
    window.open(
      `http://localhost/vega-erp/generators/generadores_pdf/cotizacion/cotizacion.php?iddetallepresentacion=${iddetalleevento}&idprovincia=${idprovincia}&idusuario=${idartista}&provincia=${provincia}&precio=${2500}`
    );
    return;
  });

  // HACER APARECER UN LABEL QUE DIGA EL PORCENTAJE DE PAGO MIENTRAS SE VA DIGITANDO 
  $q("#montopagado").addEventListener("input", async () => {
    $q("#montoActual").innerHTML = `<label for="" class="text-primary">Monto actual pagado: ${totalPagado}</label>`;

    $q("#porciento").innerHTML = "";
    $q("#btnGuardar").hidden = true
    let precioFinal = -1;
    let precio25 = -1;
    let precio50 = -1;

    console.log("adasddadsadds");
    const tarifa = await obtenerTarifaArtistaPorProvincia(
      idprovincia,
      idartista
    );

    const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
    console.log("pagos -> ", pagos)


    console.log("tarifa->", tarifa);

    if (igv == 0) {
      precioFinal = parseFloat(tarifa[0].precio) + 2500;
    } else if (igv == 1) {
      precioFinal = (parseFloat(tarifa[0].precio) + 2500) * 1.18; // Se multiplica por 1.18 para agregar IGV
    }

    precio25 = precioFinal * 0.25;
    precio50 = precioFinal * 0.5;

    if (parseFloat($q("#montopagado").value) >= precio50 || totalPagado >= precio50) {
      console.log("pago del 50%");
      $q("#porciento").innerHTML =
        '<label for="" class="text-success"><small>Pago del 50%</small></label>';
      $q("#btnGuardar").hidden = false
    } else if (parseFloat($q("#montopagado").value) >= precio25 || totalPagado >= precio25) {
      console.log("pago del 25%");
      $q("#porciento").innerHTML =
        '<label for="" class="text-success"><small>Pago del 25%</small></label>';

      $q("#btnGuardar").hidden = false

    } else if ($q("#montopagado").value == 0) {
      console.log("no hay ningun pago")
      $q("#porciento").innerHTML = ''
    } // este ultimo else if no funciona.
  });

  /*  $q("#btnGuardar").addEventListener("click", async () => {
     
   }) */

  // BOTON PARA GUARDAR LOS MONTOS QUE SE VAN PAGANDO YA SEA  25% o 25%
  $q("#btnGuardar").addEventListener("click", async () => {

    console.log("iddetallepresentacion -> ", iddetallepresentacion)
    console.log("entrando...")
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

    try {
      if ($q("#montopagado").value > 0) {
        if ((parseFloat($q("#montopagado").value) + totalPagado) >= precio50) {
          console.log("pago del 50%");
          console.log("verificando que existe el idcontrato ->", idcontrato)
          if ($q("#tipopago").value == 1) {
            if ($q("#noperacion").value.trim() !== "") {
              const pagoContrato = await registrarPagoContrato(idcontrato, 3)
              console.log("Pago guardado", pagoContrato)
              const dp = await obtenerDPporId(iddetallepresentacion)
              console.log("dp otenida antes de actualzar:-> ", dp)
              if (dp[0]?.pagado50 == 0) {
                if (pagoContrato.idpagocontrato) {
                  const pagado50DP = await actualizarPagado50DP(iddetallepresentacion)
                  if (pagado50DP) {
                    modalDatosContrato?.hide()
                    await dataFilters()
                    showToast("Pago guardado, ya puede generar el contrato.", "SUCCESS", 3000);
                  }
                }
              } else if (dp[0]?.pagado50 == 1) {
                if (pagoContrato.idpagocontrato) {
                  modalDatosContrato?.hide()
                  showToast("Pago guardado, ya puede generar el contrato.", "SUCCESS", 3000);
                }
              }

              return
            }
            showToast("Digite el numero de operación.", "ERROR");
          } else if ($q("#tipopago").value == 2) {
            console.log("idcontrato -> ", idcontrato)
            const pagoContrato = await registrarPagoContrato(idcontrato, 3)
            console.log("Pago guardado", pagoContrato)
            const dp = await obtenerDPporId(iddetallepresentacion)
            console.log("dp otenida antes de actualzar:-> ", dp)

            if (dp[0]?.pagado50 == 0) {
              if (pagoContrato.idpagocontrato) {
                const pagado50DP = await actualizarPagado50DP(iddetallepresentacion)
                if (pagado50DP) {
                  await dataFilters()
                  modalDatosContrato?.hide()
                  showToast("Pago guardado, ya puede generar el contrato.", "SUCCESS", 3000);
                }
              }
            } else if (dp[0]?.pagado50 == 1) {
              if (pagoContrato.idpagocontrato) {
                modalDatosContrato?.hide()
                showToast("Pago guardado, ya puede generar el contrato.", "SUCCESS", 3000);
              }
            }
          } else {
            showToast("Eliga una opcion de pago", "ERROR");
          }

          /* const idcontrato = await registrarContrato(iddetallepresentacion, 2);
          console.log("idcontrato > ", idcontrato) */


        } else if ((parseFloat($q("#montopagado").value) + totalPagado) >= precio25) {
          console.log("pago del 25%");
          console.log("verificando que existe el idcontrato ->", idcontrato)

          if ($q("#tipopago").value == 1) {
            if ($q("#noperacion").value.trim() !== "") {
              const pagoContrato = await registrarPagoContrato(idcontrato, 1)

              console.log("Pago guardado", pagoContrato)
              if (pagoContrato.idpagocontrato) {
                showToast("Pago guardado", "SUCCESS");
                modalDatosContrato?.hide()
                const dpExiste = await obtenerDPporId(iddetallepresentacion)
                console.log("DP EXISTE ? -> ", dpExiste)

                if (dpExiste[0].reserva == 0) {
                  const estadoReserva = await actualizarEstadoReservaDp(iddetallepresentacion, 1)
                  console.log("Estado reserva actualizado", estadoReserva)
                  await dataFilters()
                } else if (dpExiste[0].reserva == 1) {
                  return
                }
              }
              return
            }
            showToast("Digite el numero de operación.", "ERROR");
          } else if ($q("#tipopago").value == 2) {
            const pagoContrato = await registrarPagoContrato(idcontrato, 1)
            console.log("Pago guardado", pagoContrato)
            if (pagoContrato.idpagocontrato) {
              showToast("Pago guardado", "SUCCESS");
              modalDatosContrato?.hide()
              const dpExiste = await obtenerDPporId(iddetallepresentacion)
              console.log("DP EXISTE ? -> ", dpExiste)
              if (dpExiste[0].reserva == 0) {
                const estadoReserva = await actualizarEstadoReservaDp(iddetallepresentacion, 1)
                console.log("Estado reserva actualizado", estadoReserva)
                await dataFilters()
              } else if (dpExiste[0].reserva == 1) {
                return
              }
            }
          } else {
            showToast("Eliga una opcion de pago", "ERROR");
          }

          /* const idcontrato = await registrarContrato(iddetallepresentacion, 1);
          console.log("idcontrato > ", idcontrato)
           */

        }
      } else if ($q("#montopagado").value < 0) {
        showToast("No puede ingresar un monto negativo", "WARNING", 3000);
        return
      } else if ($q("#montopagado").value == 0 || $q("#montopagado").value == -0) {
        showToast("Debe ingresar un monto mayor a 0", "WARNING", 3000);
        $q("#porciento").innerHTML = ''
        return
      }
    } catch (error) {
      console.log("error -> ", error)
    }
  });

  /* $q("#btnGenerarReserva").addEventListener("click", async () => {
    alert("GENERANDO RESERVA")
  })
 */
  $q("#tipopago").addEventListener("change", async (e) => {
    const tipoPago = e.target.value;

    if (tipoPago == 1) {
      $q("#contenedor-noperacion").hidden = false

    } else if (tipoPago == 2) {
      $q("#contenedor-noperacion").hidden = true
      $q("#noperacion").value = ''
    }

  })
});

// *****************************************************************************************
