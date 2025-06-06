document.addEventListener("DOMContentLoaded", async () => {
  //VARIABLES LONGITUDES Y LATITUDES
  let ws
  // Mantiene un indicador para saber si el WebSocket está listo para enviar
  let wsReady = false;
  let iddetallepresentacion = -1
  let latOrigen
  let lonOrigen
  let calcularDificultadPrecio = []
  let idUsuario
  let costoDificultad
  let idnacionalidadObtenido
  let precioTarifaArtista
  let tarifaArtista = []
  let usuarioSelect = $q("#usuario")

  navigator.geolocation.getCurrentPosition(function (position) {
    latOrigen = position.coords.latitude;
    lonOrigen = position.coords.longitude;
    console.log(`Tu ubicación: ${latOrigen},${lonOrigen}`);
  });

  /*   (async () => {
      ws = new WebSocket("ws://localhost:8000");
  
      ws.onopen = () => {
        wsReady = true;
        console.log("WebSocket abierto pe");
      };
  
      ws.onclose = () => {
        wsReady = false;
        console.log("WebSocket cerrado pe");
      };
    })();
   */

  //VARIABLES
  let agenda = [];
  let iddp = -1
  let idviatico = -1
  let iddepartamento = -1;
  let idprovincia = -1;
  let iddistrito = -1;
  let idagendaedicion = -1
  let idasignacion

  console.log("idusuario logeado", idusuarioLogeado)

  console.log("NIVEL ACCESO DE USUARIO -> ", nivelacceso)
  //MODALES

  let modalInfoAgenda;
  let modalViatico;
  let modalAcuerdo
  let modalMonto;
  let modalFilmmaker
  let modalAsignarEditor
  let modalProgresoEdicion
  let modalSalida

  //CALENDARIO
  let calendarEl;

  // OBTENCION DE VARIABLES PERSONALIZADAS

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

  // ********************************************* WEBSCOKETS **********************************************************
  /* ws.onmessage = (event) => {
    try {
      const data = JSON.parse(event.data);
  
      if (data.type === "notificacion") {
        console.log("📢 Nueva notificación recibida:", data);
  
        // Aquí puedes mostrar la notificación en la UI
        alert(`🔔 Nueva notificación: ${data.mensaje}`);
      }
    } catch (error) {
      console.error("Error al procesar el mensaje WebSocket:", error);
    }
  }; */ // QUITADO PQ YA SE PUSO EN NOTIFICACION GLOBAL .JS
  // ****************************************** OBTENER DATOS **********************************************************

  //(async () => {
  /* if (nivelacceso != "Artista") {
    const niveles = await obtenerNiveles();
    $q("#nivelacceso").innerHTML = `<option value="">Selecciona</option>`;
    niveles.forEach((nivel) => {
      $q(
        "#nivelacceso"
      ).innerHTML += `<option value="${nivel.idnivelacceso}">${nivel.nivelacceso}</option>`;
    });
  } */



  //})();



  async function obtenerNiveles() {
    const data = await getDatos(
      `${host}recurso.controller.php`,
      "operation=obtenerNiveles"
    );
    console.log(data);
    return data;
  }

  async function obtenerUsuarios(idnivelacceso) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorNivel");
    params.append("idnivelacceso", idnivelacceso);
    const data = await getDatos(`${host}usuario.controller.php`, params);
    console.log(data);
    usuarioSelect.innerHTML = "<option value=''>Todos</option>";
    data.forEach((artista) => {
      usuarioSelect.innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
    });
    return data

  }

  async function obtenerDepartamentoPorId(iddepartamento) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDepartamentoPorId");
    params.append("iddepartamento", iddepartamento);
    const data = await getDatos(`${host}recurso.controller.php`, params);
    return data
  }

  async function obtenerViatico(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerViatico");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const data = await getDatos(`${host}viatico.controller.php`, params);
    return data
  }

  async function obtenerAcuerdo(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerAcuerdo");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    return data
  }

  async function obtenerContratoConvenio(idconvenio) { // PARA OBTENER MONTOS DE CONVENIO
    const params = new URLSearchParams();
    params.append("operation", "obtenerContratoConvenio");
    params.append("idconvenio", idconvenio);
    const data = await getDatos(`${host}convenio.controller.php`, params);
    return data
  }

  async function obtenerContrato(idcontrato) { // PARA OBTENER DATOS DE CLIENTE Y DE EVENTO (NO INCLUYE TARIFARIO NI COSTO EN PRESENTACION DE TAL LOCAL)
    const params = new URLSearchParams();
    params.append("operation", "obtenerContrato");
    params.append("idcontrato", idcontrato);
    const data = await getDatos(`${host}contrato.controller.php`, params);
    return data
  }

  async function obtenerFilmmakers() { // PARA OBTENER DATOS DE CLIENTE Y DE EVENTO (NO INCLUYE TARIFARIO NI COSTO EN PRESENTACION DE TAL LOCAL)
    const params = new URLSearchParams();
    params.append("operation", "obtenerFilmmakers");
    const data = await getDatos(`${host}recurso.controller.php`, params);
    return data
  }

  async function obtenerUsuariosPorNivel(idnivelacceso) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorNivel");
    params.append("idnivelacceso", idnivelacceso);

    try {
      const data = await getDatos(`${host}usuario.controller.php`, params);

      console.log(data);
      return data // Verifica la estructura de los datos en la consola
    } catch (error) {
      console.error("Error al obtener los usuarios:", error);
    }
  }


  async function obtenerTarifaArtistaPorProvincia(idprovincia, idusuario, tipoevento) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerTarifaArtistaPorProvincia");
    params.append("idprovincia", idprovincia);
    params.append("idusuario", idusuario);
    params.append("tipoevento", tipoevento);
    const fpersona = await getDatos(`${host}tarifa.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerUsuarioPorId(idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorId");
    params.append("idusuario", idusuario);
    const fpersona = await getDatos(`${host}usuario.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerFilmmakerAsignado(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerFilmmakerAsignado");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const fpersona = await getDatos(`${host}agenda.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerLongLatPorCiudad(provincia) {
    $q(".contenedor-monto").innerHTML = "<p class='text-center'>Cargando...</p>";

    const Fdata = await fetch(`https://nominatim.openstreetmap.org/search?q=${provincia}&format=json`)
    const data = await Fdata.json()
    return data
  }
  async function obtenerTarifaArtistaPorPais(idusuario, idnacionalidad, tipoevento) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerTarifaArtistaPorPais");
    params.append("idusuario", idusuario);
    params.append("idnacionalidad", idnacionalidad);
    params.append("tipoevento", tipoevento);
    const data = await getDatos(`${host}tarifa.controller.php`, params);
    return data
  }

  async function obtenerDuracionDeViaje(lon_origen, lat_origen, lon_destino, lat_destino) {
    try {
      $q(".contenedor-monto").innerHTML = "<p class='text-center'>Cargando...</p>";
      const url = `https://router.project-osrm.org/route/v1/driving/${lon_origen},${lat_origen};${lon_destino},${lat_destino}?overview=false`;
      const Fdata = await fetch(url);

      if (!Fdata.ok) {
        throw new Error(`Error ${Fdata.status}: ${Fdata.statusText}`);
      }

      const data = await Fdata.json();
      return data;
    } catch (error) {
      showToast(`Error al obtener la duración del viaje: ${error.message}`, "ERROR");
      console.log("Error al obtener la duración del viaje -> ", error);
      return null; // Devuelve null en caso de error
    }
  }


  async function obtenerDPporId(iddp) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDPporId");
    params.append("iddetallepresentacion", iddp);
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    return data;
  }


  async function obtenerFilmmakerAsociadoEvento(idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerFilmmakerAsociadoEvento");
    params.append("idusuario", idusuario);
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    return data;
  }

  // ************************************** OBTENCION DE AGENDAS **************************************************************
  async function obtenerTodasLasAgendasEdicion() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerTodasLasAgendasEdicion");
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
  }

  async function obtenerAgendaEdicionPorEditorYGeneral(idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerAgendaEdicionPorEditorYGeneral");
    params.append("idusuario", idusuario);
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
  } //ME QUEDE ACA , falta filtrarlos por idusuario para obtener tanto todas las tareas de todoso los usuarios y de tan solo un usuario

  async function obtenerEditoresAsignados(idagendaedicion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerEditoresAsignados");
    params.append("idagendaedicion", idagendaedicion);
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
  }

  async function obtenerFilmmakersDP(iddp) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerFilmmakersDP");
    params.append("iddetallepresentacion", iddp);
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
  }

  // *************************************** REGISTRAR DATOS ***************************************************************

  async function asignarAgendaEditor(idagendaedicion) {

    const body = new FormData();
    body.append("operation", "asignarAgendaEditor");
    body.append("idagendaedicion", idagendaedicion); // id artista
    body.append("idusuario", $q("#asignacion").value);
    body.append("tipotarea", $q("#tipotarea").value);
    body.append("fechaentrega", $q("#fechaentrega").value);

    const fbody = await fetch(`${host}agenda.controller.php`, {
      method: "POST",
      body: body,
    });
    const rbody = await fbody.json();
    return rbody;
  }

  async function reportarSalidaRetornoArtista(iddetallepresentacion, tipo, fecha, hora) {

    const body = new FormData();
    body.append("operation", "reportarSalidaRetornoArtista");
    body.append("iddetallepresentacion", iddetallepresentacion); // id artista
    body.append("tipo", tipo);
    body.append("fecha", fecha);
    body.append("hora", hora);

    const fbody = await fetch(`${host}agenda.controller.php`, {
      method: "POST",
      body: body,
    });
    const rbody = await fbody.json();
    return rbody;
  }

  async function registrarViatico(iddetallepresentacion) {
    console.log("valor pasaje -> ", $q("#pasaje").value);
    const viatico = new FormData();
    viatico.append("operation", "registrarViatico");
    viatico.append("iddetallepresentacion", iddetallepresentacion); // id artista
    viatico.append("idusuario", $q("#pasaje").value);
    viatico.append("comida", $q("#comida").value);
    viatico.append("viaje", $q("#viaje").value ? $q("#viaje").value : '');

    const fviatico = await fetch(`${host}viatico.controller.php`, {
      method: "POST",
      body: viatico,
    });
    const rviatico = await fviatico.json();
    return rviatico;
  }

  /*   function enviarPusher(idusuario, type, mensaje) {
      if (wsReady) {
        ws.send(JSON.stringify({
          idusuario: idusuario,
          type: type,
          mensaje: mensaje
        }));
  
        console.log("Notificación enviada por WebSocket.");
      } else {
        console.warn("WebSocket no está listo para enviar notificaciones.");
      }
    } */

  function enviarPusher(idusuario, type, mensaje) {
    fetch(`${hostOnly}/pusher.php`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        idusuario: idusuario,
        type: type, // evento, viatico, etc.
        mensaje: mensaje
      })
    })
      .then(response => response.json())
      .then(data => {
        console.log("Notificación enviada por Pusher.", data);
      })
      .catch(err => {
        console.error("Error al enviar notificación:", err);
      });
  }

  async function registrarNotificacion(idusuariodest, idusuariorem, tipo, idviatico, mensaje) {
    const viatico = new FormData();
    viatico.append("operation", "registrarNotificacion");
    viatico.append("idusuariodest", idusuariodest); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
    viatico.append("idusuariorem", idusuariorem); // id usuario envia la notificacion
    viatico.append("tipo", tipo);
    viatico.append("idreferencia", idviatico ? idviatico : '');
    viatico.append("mensaje", mensaje);

    const fviatico = await fetch(`${host}notificacion.controller.php`, {
      method: "POST",
      body: viatico,
    });
    const rviatico = await fviatico.json();
    console.log("rivatico . ", rviatico)

    return rviatico;
  }

  async function eliminarFilmmakerDP(idasignacion) {
    const filmmaker = new FormData();
    filmmaker.append("operation", "eliminarFilmmakerDP");
    filmmaker.append("idasignacion", idasignacion);

    const ffilmmaker = await fetch(`${host}agenda.controller.php`, {
      method: "POST",
      body: filmmaker,
    });
    const rfilmmaker = await ffilmmaker.json();
    console.log("rivatico . ", rfilmmaker)

    return rfilmmaker;
  }

  async function actualizarViatico(idviatico) {
    const viatico = new FormData();
    viatico.append("operation", "actualizarViatico");
    viatico.append("idviatico", idviatico);
    viatico.append("pasaje", $q("#pasaje").value);
    viatico.append("comida", $q("#comida").value);
    viatico.append("viaje", $q("#viaje").value ? $q("#viaje").value : '');

    const fviatico = await fetch(`${host}viatico.controller.php`, {
      method: "POST",
      body: viatico,
    });
    const rviatico = await fviatico.json();
    return rviatico;
  }


  async function actualizarEstadoCordinacionTecnica(iddetallepresentacion, estadocordinaciontecnica) {
    const cordinacion = new FormData();
    cordinacion.append("operation", "actualizarEstadoCordinacionTecnica");
    cordinacion.append("iddetallepresentacion", iddetallepresentacion); // id artista
    cordinacion.append("estadocordinaciontecnica", estadocordinaciontecnica);

    const fcordinacion = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: cordinacion,
    });
    const rcordinacion = await fcordinacion.json();
    return rcordinacion;
  }

  async function actualizarEstadoCordinacionPublicidad(iddetallepresentacion, estadocordinacionpublicidad) {
    const cordinacion = new FormData();
    cordinacion.append("operation", "actualizarEstadoCordinacionPublicidad");
    cordinacion.append("iddetallepresentacion", iddetallepresentacion); // id artista
    cordinacion.append("estadocordinacionpublicidad", estadocordinacionpublicidad);

    const fcordinacion = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: cordinacion,
    });
    const rcordinacion = await fcordinacion.json();
    return rcordinacion;
  }


  async function editarAcuerdoEvento(iddetallepresentacion) {
    const acuerdo = new FormData();
    acuerdo.append("operation", "editarAcuerdoEvento");
    acuerdo.append("iddetallepresentacion", iddetallepresentacion);
    acuerdo.append("acuerdo", $q("#acuerdo").value);

    const facuerdo = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: acuerdo,
    });
    const racuerdo = await facuerdo.json();
    return racuerdo;
  }

  /* async function asignarLugarDestinoBus(iddetallepresentacion) {
    const acuerdo = new FormData();
    acuerdo.append("operation", "asignarLugarDestinoBus");
    acuerdo.append("iddetallepresentacion", iddetallepresentacion);
    acuerdo.append("lugardestino", $q("#destino").value);

    const facuerdo = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: acuerdo,
    });
    const racuerdo = await facuerdo.json();
    return racuerdo;
  } */

  /* async function asignarFilmmakerDP(iddetallepresentacion) {
    const filmmaker = new FormData();
    filmmaker.append("operation", "asignarFilmmakerDP");
    filmmaker.append("iddetallepresentacion", iddetallepresentacion);
    filmmaker.append("filmmaker", $q("#filmmaker").value);
 
    const ffilmmaker = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: filmmaker,
    });
    const rfilmmaker = await ffilmmaker.json();
    return rfilmmaker;
  } */
  async function asignarAgenda(iddetallepresentacion) {
    const filmmaker = new FormData();
    filmmaker.append("operation", "asignarAgenda");
    filmmaker.append("iddetallepresentacion", iddetallepresentacion);
    filmmaker.append("idusuario", $q("#filmmaker").value);

    const ffilmmaker = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: filmmaker,
    });
    const rfilmmaker = await ffilmmaker.json();
    return rfilmmaker;
  }

  // ****************************************** CONFIGURACION DE CALENDARIO **********************************************************
  calendarEl = document.getElementById("calendar");

  function ajustarEventos() {
    if (window.innerWidth < 768) {
      calendar.setOption("dayMaxEvents", 0); // En móviles, siempre mostrar "+X more"
    } else {
      calendar.setOption("dayMaxEvents", 3); // En PC, mostrar hasta 3 eventos antes de colapsar
    }
  }

  const calendar = new FullCalendar.Calendar(calendarEl, {
    height: "95%",
    initialView: "dayGridMonth", // Vista inicial: mes
    headerToolbar: {
      left: "today",
      center: "prev title next",
      right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth", // Filtros de vista
    },
    events: [], // Aquí se cargarán los eventos dinámicamente
    locale: "es",
    dayMaxEvents: 1, // Muestra hasta 3 eventos antes de colapsar
    eventLimitClick: "popover", // Muestra un popover con los eventos restantes
    eventClick: async function (evento) {
      $q(".contenedor-monto").innerHTML = "";
      const btnVerMontos = evento.jsEvent.target.closest("#btnVerMontos");
      const btnReportarSalida = evento.jsEvent.target.closest("#btnReportarSalida");
      const btnReportarRetorno = evento.jsEvent.target.closest("#btnReportarRetorno");
      console.log("btnVerMontos ->", btnVerMontos);
      if (btnVerMontos) {
        console.log("CLICK EN VER MONTOS");

        const idcontrato = btnVerMontos.getAttribute("data-idcontrato");
        const idconvenio = btnVerMontos.getAttribute("data-idconvenio");
        modalMonto = new bootstrap.Modal($q("#modal-monto"));
        modalMonto.show();
        console.log("idcontrato -> ", idcontrato);
        if (idcontrato != "null") {  // Verifica si idcontrato tiene un valor válido
          const contrato = await obtenerContrato(idcontrato);
          console.log("contrato -> ", contrato);

          const tarifaArtista = await obtenerTarifaArtistaPorProvincia(
            contrato[0]?.idprovincia_evento,
            contrato[0]?.idusuario,
            contrato[0]?.tipo_evento
          );
          console.log("tarifaArtista -> ", tarifaArtista);
          //await renderizarUbigeoPresentacion(contrato[0]?.iddetalle_presentacion);
          const dp = await obtenerDPporId(contrato[0]?.iddetalle_presentacion);
          console.log(dp);

          const longlatCiudad = await obtenerLongLatPorCiudad(dp[0]?.departamento + ',' + dp[0]?.provincia)
          console.log("longlatCiudad->>>", longlatCiudad)
          const infoRecorrido = await obtenerDuracionDeViaje(lonOrigen, latOrigen, longlatCiudad[0]?.lon, longlatCiudad[0]?.lat)
          const duracionTiempoCrudo = infoRecorrido.routes[0]?.duration
          calcularDificultadPrecio = calcularPrecio(duracionTiempoCrudo)
          const precioArtista = parseFloat(tarifaArtista[0]?.precio) || 0;
          const costoDificultad = parseFloat(calcularDificultadPrecio?.costoDificultad) || 0;
          const igv = (precioArtista + costoDificultad) * 0.18;

          const total = contrato[0]?.igv == 0
            ? precioArtista + costoDificultad
            : precioArtista + costoDificultad + igv;

          $q(".contenedor-monto").innerHTML = ''

          $q(".contenedor-monto").innerHTML = `
              <div class="table-responsive d-flex justify-content-center">
                <table class="table table-striped table-hover text-center align-middle w-auto mx-auto" id="table-tarifarios">
                  <thead class="table-dark">
                    <tr>
                      <th>Descripción</th>
                      <th>Tiempo</th>
                      <th>Costo</th>
                      <th>Total</th>  
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>Presentacion artistica de ${contrato[0]?.nom_usuario}</td>
                      <td>${calculateDuration(contrato[0]?.horainicio, contrato[0]?.horafinal)}</td>
                      <td>S/. ${tarifaArtista[0]?.precio || 0}</td>
                      <td>S/. ${tarifaArtista[0]?.precio || 0}</td>
                    </tr>
                    <tr>
                      <td>Puesto en la locacion de ${contrato[0]?.provincia}</td>
                      <td>${calcularDificultadPrecio?.horasEstimadas}</td>
                      <td>S/. ${calcularDificultadPrecio?.costoDificultad}</td>
                      <td>S/. ${calcularDificultadPrecio?.costoDificultad}</td>
                    </tr>
                    <tr>
                      <td colspan="2" class="text-end">(Opcional)</td>                  
                      <td colspan="1">IGV (18%)</td>                  
                      <td>${contrato[0]?.igv == 0 ? 'No incluye' : contrato[0]?.igv == 1 ? `S/. ${igv.toFixed(2)}` : ''}</td>                  
                    </tr>
                    <tr>
                      <td colspan="3" class="text-end">TOTAL</td>                  
                      <td><strong>S/. ${total.toFixed(2)}</strong></td>                                    
                    </tr>
                  </tbody>
                </table>
              </div>
            `;
        } else if (idconvenio != "null") {  // Solo entra aquí si idcontrato NO es válido
          $q(".contenedor-monto").innerHTML = "";

          const convenio = await obtenerContratoConvenio(idconvenio);
          console.log("convenio -> ", convenio);
          $q(".contenedor-monto").innerHTML = `
              <div class="table-responsive d-flex justify-content-center">
                <table class="table table-striped table-hover text-center align-middle w-auto mx-auto">
                  <thead class="table-dark">
                    <tr>
                      <th>Concepto</th>
                      <th>Porcentaje</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>Promotor</td>
                      <td>${convenio[0]?.porcentaje_promotor || 0}%</td>
                    </tr>
                    <tr>
                      <td>Vega</td>
                      <td>${convenio[0]?.porcentaje_vega || 0}%</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            `;
        } else {
          $q(".contenedor-monto").innerHTML = '<label class="fw-light">Aun no hay montos disponibles.</label>'
        }
      }
      if (btnReportarSalida) {
        /* iddetallepresentacion = btnReportarSalida.getAttribute("data-iddp")
        //modalSalida = new bootstrap.Modal($q("#modal-lugardestino"))
        //modalSalida.show() // YA NO IRA MODAL , SOLO UN CLICK Y SE REGISTRA LA SALIDA / RETORNO

        $q("#btnSalida").addEventListener("click", async () => {
          const { fecha, hora } = obtenerSoloFechaHoraPeruSeparadaFormatoMysql();
          console.log("Fecha Perú (MySQL):", fecha);
          console.log("Hora Perú:", hora);

          btnReportarSalida.disabled = true;
          btnReportarSalida.innerHTML = '<i class="fas fa-save"></i> Reportando...'; // Cambia al icono de disquete o uno similar
          const usuariosAdmin = await obtenerUsuarios("3")
          const usuarioLogeado = await obtenerUsuarioPorId(idusuarioLogeado)
          console.log("usuarioLogeado -> ", usuarioLogeado);
          const mensaje = `${usuarioLogeado[0]?.nom_usuario} ha acaba de salir el ${formatDate(fecha)} a las ${formatHour(hora)}, click para mas detalles`
          console.log("usuariosAdmin -> ", usuariosAdmin);

          const reporteRegistradoEventoArt = await reportarSalidaRetornoArtista(iddetallepresentacion, 1, fecha, hora)
          //const destinoBusAsignado = await asignarLugarDestinoBus(iddetallepresentacion)
          //console.log("destino bus asignado ? ", destinoBusAsignado);
          console.log("reporte de registro de salida del arrtista-> ", reporteRegistradoEventoArt);
          if (reporteRegistradoEventoArt.idreporte) {
            showToast("Salida Reportada!", "SUCCESS")
            for (const admins of usuariosAdmin) {
              console.log("admins -> ", admins);
              const notificacionSalida = await registrarNotificacion(admins.idusuario, idusuarioLogeado, 2, reporteRegistradoEventoArt.idreporte, mensaje)
              console.log("notificacion salida -> ", notificacionSalida);
            }
            modalSalida.hide()
            setTimeout(() => {
              btnReportarSalida.disabled = false;
              btnReportarSalida.innerHTML = 'Reportar Salida'; // Reemplaza con el texto original
            }, 2500);
            return
          }
        }) */
        iddetallepresentacion = btnReportarSalida.getAttribute("data-iddp")
        const { fecha, hora } = obtenerSoloFechaHoraPeruSeparadaFormatoMysql();
        console.log("Fecha Perú (MySQL):", fecha);
        console.log("Hora Perú:", hora);

        btnReportarSalida.disabled = true;
        btnReportarSalida.innerHTML = '<i class="fas fa-save"></i> Reportando...'; // Cambia al icono de disquete o uno similar
        const usuariosAdmin = await obtenerUsuarios("3")
        const usuarioLogeado = await obtenerUsuarioPorId(idusuarioLogeado)
        console.log("usuarioLogeado -> ", usuarioLogeado);
        const mensaje = `${usuarioLogeado[0]?.nom_usuario} ha acaba de salir el ${formatDate(fecha)} a las ${formatHour(hora)}, click para mas detalles`
        console.log("usuariosAdmin -> ", usuariosAdmin);

        const reporteRegistradoEventoArt = await reportarSalidaRetornoArtista(iddetallepresentacion, 1, fecha, hora)
        //const destinoBusAsignado = await asignarLugarDestinoBus(iddetallepresentacion)
        //console.log("destino bus asignado ? ", destinoBusAsignado);
        console.log("reporte de registro de salida del arrtista-> ", reporteRegistradoEventoArt);
        if (reporteRegistradoEventoArt.idreporte) {
          showToast("Salida Reportada!", "SUCCESS")
          for (const admins of usuariosAdmin) {
            console.log("admins -> ", admins);
            const notificacionSalida = await registrarNotificacion(admins.idusuario, idusuarioLogeado, 2, reporteRegistradoEventoArt.idreporte, mensaje)
            enviarPusher(admins.idusuario, "notificacion", mensaje)
            console.log("notificacion salida -> ", notificacionSalida);
          }
          //modalSalida.hide()
          setTimeout(() => {
            btnReportarSalida.disabled = false;
            btnReportarSalida.innerHTML = 'Reportar Salida'; // Reemplaza con el texto original
          }, 2500);
          return
        }
      }
      if (btnReportarRetorno) {
        /* modalSalida = new bootstrap.Modal($q("#modal-salida"))
        modalSalida.show() */ // YA NO IRA MODAL , SOLO UN CLICK Y SE REGISTRA LA SALIDA / RETORNO
        const iddetallepresentacion = btnReportarRetorno.getAttribute("data-iddp")
        const { fecha, hora } = obtenerSoloFechaHoraPeruSeparadaFormatoMysql();
        console.log("Fecha Perú (MySQL):", fecha);
        console.log("Hora Perú:", hora);

        btnReportarRetorno.disabled = true;
        btnReportarRetorno.innerHTML = '<i class="fas fa-save"></i> Reportando...'; // Cambia al icono de disquete o uno similar
        const usuariosAdmin = await obtenerUsuarios("3")
        const usuarioLogeado = await obtenerUsuarioPorId(idusuarioLogeado)
        console.log("usuarioLogeado -> ", usuarioLogeado);
        const mensaje = `${usuarioLogeado[0]?.nom_usuario} ha acaba de retornar el ${formatDate(fecha)} a las ${formatHour(hora)}, click para mas detalles`
        console.log("usuariosAdmin -> ", usuariosAdmin);
        console.log("el que pueda leer esto se la come completa XD");
        const reporteRegistradoEventoArt = await reportarSalidaRetornoArtista(iddetallepresentacion, 2, fecha, hora)

        console.log("reporte de registro de retorno del arrtista-> ", reporteRegistradoEventoArt);
        if (reporteRegistradoEventoArt.idreporte) {
          showToast("Retorno Reportada!", "SUCCESS")
          for (const admins of usuariosAdmin) {
            console.log("admins -> ", admins);
            const notificacionRetorno = await registrarNotificacion(admins.idusuario, idusuarioLogeado, 2, reporteRegistradoEventoArt.idreporte, mensaje)
            enviarPusher(admins.idusuario, "notificacion", mensaje)
            console.log("notificacion retorno -> ", notificacionRetorno);
          }
          setTimeout(() => {
            btnReportarRetorno.disabled = false;
            btnReportarRetorno.innerHTML = 'Reportar Retorno'; // Reemplaza con el texto original
          }, 2500);
          return
        }
      }

      console.log("evento -> ", evento)
      if (evento.event.extendedProps.estadoBadge.text == "Incompleto") {
        if (nivelacceso == "Artista" || nivelacceso == "Filmmaker") {
          return

        }
        /* window.localStorage.clear()
        window.localStorage.setItem("iddp", evento.event.extendedProps.iddetalle_presentacion)
        window.location.href = `${hostOnly}/views/ventas/actualizar-atencion-cliente` */
      }
    },
    eventDidMount: function (info) {
      console.log("info ->", info);
      let horaInicio = info.event.extendedProps.horainicio
        ? formatHour(info.event.extendedProps.horainicio)
        : "Hora no definida";
      let horaFinal = info.event.extendedProps.horafinal
        ? formatHour(info.event.extendedProps.horafinal)
        : "Hora no definida";

      let estado = info.event.extendedProps?.estadoBadge;
      let badgeHtml = `<span class="${estado?.class}">${estado?.text}</span>`;
      const content = document.createElement('div');
      //if(nivelacceso == "Edicion ")
      content.innerHTML = `
      ${info.event.extendedProps?.text == "Incompleto" && nivelacceso == "Administrador" ?
          `
          <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
            <div>00:00 - 00:00</div>
            <div>${badgeHtml}</div>
          </div>
          <div style="padding: 8px; word-wrap: break-word; 
          overflow-wrap: break-word;
          white-space: normal;">
            <div style="font-size: 20px; font-weight: bold;">${info.event.extendedProps?.title
          }</div>
          <div><strong>Click aqui para editar</strong>
          </div>
          ` : info.event.extendedProps?.text == "Incompleto" && nivelacceso == "Artista" ? `
            <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
            <div>00:00 - 00:00</div>
            <div>${badgeHtml}</div>
          </div>
          <div style="padding: 8px; word-wrap: break-word; 
          overflow-wrap: break-word;
          white-space: normal;">
            <div style="font-size: 20px; font-weight: bold;">Este evento esta siendo editado por el encargado.</div>
          
          ` :
            info.event.extendedProps?.estado == 3 || info.event.extendedProps?.estado == 2 ? `
          <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
          <div>${horaInicio} - ${horaFinal}</div>
          <div>${badgeHtml}</div>
        </div>
        <div style="padding: 8px; word-wrap: break-word; 
        overflow-wrap: break-word;
        white-space: normal;">
          <div style="font-size: 20px; font-weight: bold;">${info.event.extendedProps?.title
              }</div>
            <div><strong>Local:</strong> ${info.event.extendedProps?.establecimiento || "No definido"
              }</div>
            <div><strong>Tiempo:</strong> ${calculateDuration(
                info.event.extendedProps?.horainicio,
                info.event.extendedProps?.horafinal
              )}</div>
            <button class="btn btn-primary w-100" id="btnInfo" style="flex: 1;" data-iddp="${info.event.extendedProps?.iddetalle_presentacion}">Info</button>` :
              `
          <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
          <div>${horaInicio} - ${horaFinal}</div>
          <div>${badgeHtml}</div>
        </div>
        <div style="padding: 8px; word-wrap: break-word; 
        overflow-wrap: break-word;
        white-space: normal;">
          <div style="font-size: 20px; font-weight: bold;">${info.event.extendedProps?.title
              }</div>
            <div><strong>Local:</strong> ${info.event.extendedProps?.establecimiento || "No definido"
              }</div>
            <div><strong>Tiempo:</strong> ${calculateDuration(
                info.event.extendedProps?.horainicio,
                info.event.extendedProps?.horafinal
              )}</div>
    
        ${nivelacceso == "Administrador" ? `
          <label ><strong>Observaciones:</strong></label>
          <div id="text-acuerdo" class="mt-1" style="
        background: #fff; 
        padding: 5px; 
        border-radius: 5px; 
        word-wrap: break-word; 
        overflow-wrap: break-word;
        white-space: normal;
      ">
        ${info.event.extendedProps?.acuerdo ||
                "Sin Observaciones."
                }
      </div>
          ` : ''}
          ${nivelacceso == "Administrador" ? `
            <div><strong>FILMMAKERS:</strong> ${info.event.extendedProps?.filmmaker}</div>
          ` : ''}
    
          <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px;">
            ${nivelacceso == "Administrador" ? `
              <button class="btn btn-primary" id="btnAsignarFilmmaker" style="flex: 1;" data-iddp="${info.event.extendedProps?.iddetalle_presentacion}">Filmmaker</button>
              <button class="btn btn-primary" id="btnEditarAcuerdo" style="flex: 1;" data-iddp="${info.event.extendedProps?.iddetalle_presentacion}">Observaciones</button>
              <button class="btn btn-primary" id="btnInfo" style="flex: 1;" data-iddp="${info.event.extendedProps?.iddetalle_presentacion}">Info</button>
            ` : ``}
    
            ${nivelacceso == "Artista" ? `
              <button type="button" class="btn btn-primary" id="btnVerMontos" style="flex: 1;" data-idcontrato="${info.event.extendedProps?.idcontrato}" data-idconvenio="${info.event.extendedProps?.idconvenio}">Ver Monto gaaa</button>
              <button type="button" class="btn btn-primary" id="btnReportarSalida" style="flex: 1;" data-iddp="${info.event.extendedProps?.iddetalle_presentacion}">Reportar Salida</button>
              <button type="button" class="btn btn-primary" id="btnReportarRetorno" style="flex: 1;" data-iddp="${info.event.extendedProps?.iddetalle_presentacion}">Reportar Retorno</button>
            ` : ''}
          </div>
          `}
      `;

      const instance = tippy(info.el, {
        content: content,
        interactive: true,
        trigger: "click",
        allowHTML: true,
        theme: "custom", // usamos tema personalizado
        placement: "auto",
        onShow(instance) {
          // Espera un pequeño tiempo para que el DOM esté listo
          setTimeout(() => {
            const btnVerMontos = $q("#btnVerMontos");
            const btnReportarSalida = $q("#btnReportarSalida")
            const btnReportarRetorno = $q("#btnReportarRetorno")
            if (btnVerMontos) {
              btnVerMontos.addEventListener("click", async (e) => {
                console.log("CLICK EN VER MONTOS");
                console.log("e -> ", e);
                const idcontrato = e.target.getAttribute("data-idcontrato");
                const idconvenio = e.target.getAttribute("data-idconvenio");
                console.log("idcontrato -> ", idcontrato);
                console.log("idconvenio -> ", idconvenio);
                $q(".contenedor-monto").innerHTML = ''
                modalMonto = new bootstrap.Modal($q("#modal-monto"));
                modalMonto.show();


                //let monto = 0;
                if (idcontrato != "null") {  // Verifica si idcontrato tiene un valor válido
                  const contrato = await obtenerContrato(idcontrato);
                  console.log("contrato -> ", contrato);


                  //await renderizarUbigeoPresentacion(contrato[0]?.iddetalle_presentacion);
                  const dp = await obtenerDPporId(contrato[0]?.iddetalle_presentacion);
                  console.log(dp);

                  if (dp[0]?.idnacionalidad == 31) {
                    const tarifaArtista = await obtenerTarifaArtistaPorProvincia(
                      contrato[0]?.idprovincia_evento,
                      contrato[0]?.idusuario,
                      contrato[0]?.tipo_evento
                    );
                    console.log("tarifaArtista -> ", tarifaArtista);
                    const longlatCiudad = await obtenerLongLatPorCiudad(dp[0]?.departamento + ',' + dp[0]?.provincia)
                    console.log("longlatCiudad->>>", longlatCiudad)
                    const infoRecorrido = await obtenerDuracionDeViaje(lonOrigen, latOrigen, longlatCiudad[0]?.lon, longlatCiudad[0]?.lat)
                    console.log("infoRecorrido -> ", infoRecorrido);
                    const duracionTiempoCrudo = infoRecorrido.routes[0]?.duration
                    calcularDificultadPrecio = calcularPrecio(duracionTiempoCrudo)
                    costoDificultad = calcularDificultadPrecio?.costoDificultad // PRECIO POR VIAJE
                    idnacionalidadObtenido = dp[0]?.idnacionalidad
                    precioTarifaArtista = tarifaArtista[0]?.precio


                  } else {
                    const tarifaArtista = await obtenerTarifaArtistaPorPais(dp[0]?.idusuario, dp[0]?.idnacionalidad, dp[0]?.tipo_evento)
                    costoDificultad = tarifaArtista[0]?.precio
                    idnacionalidadObtenido = tarifaArtista[0]?.idnacionalidad
                    precioTarifaArtista = tarifaArtista[0]?.precioExtranjero

                  }

                  //const precioArtista = precioTarifaArtista; // PRECIO POR PRESENTACION
                  //const costoDificultad = parseFloat(calcularDificultadPrecio?.costoDificultad) || 0; // VIAJE
                  const igv = (precioTarifaArtista + costoDificultad) * 0.18;
                  const total = contrato[0]?.igv == 0
                    ? precioTarifaArtista + costoDificultad
                    : precioTarifaArtista + costoDificultad + igv;



                  $q(".contenedor-monto").innerHTML = `
                    <div class="table-responsive d-flex justify-content-center">
                      <table class="table table-striped table-hover text-center align-middle w-auto mx-auto" id="table-tarifarios">
                        <thead class="table-dark">
                          <tr>
                            <th>Descripción</th>
                            <th>Tiempo</th>
                            <th>Costo</th>
                            <th>Total</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>Presentacion artistica de ${contrato[0]?.nom_usuario}</td>
                            <td>${calculateDuration(contrato[0]?.horainicio, contrato[0]?.horafinal)}</td>
                            <td>S/. ${tarifaArtista[0]?.precio || 0}</td>
                            <td>S/. ${tarifaArtista[0]?.precio || 0}</td>
                          </tr>
                          <tr>
                            <td>Puesto en la locacion de ${contrato[0]?.provincia}</td>
                            <td>${calcularDificultadPrecio?.horasEstimadas}</td>
                            <td>S/. ${calcularDificultadPrecio?.costoDificultad}</td>
                            <td>S/. ${calcularDificultadPrecio?.costoDificultad}</td>
                          </tr>
                          <tr>
                            <td colspan="2" class="text-end">(Opcional)</td>
                            <td colspan="1">IGV (18%)</td>
                            <td>${contrato[0]?.igv == 0 ? 'No incluye' : contrato[0]?.igv == 1 ? `S/. ${igv.toFixed(2)}` : ''}</td>
                          </tr>
                          <tr>
                            <td colspan="3" class="text-end">TOTAL</td>
                            <td><strong>S/. ${total.toFixed(2)}</strong></td>
                          </tr>
                        </tbody>
                      </table>
                    </div >
                  `;
                } else if (idconvenio != "null") {  // Solo entra aquí si idcontrato NO es válido
                  $q(".contenedor-monto").innerHTML = "";

                  const convenio = await obtenerContratoConvenio(idconvenio);
                  console.log("convenio -> ", convenio);
                  $q(".contenedor-monto").innerHTML = `
                    <div class="table-responsive d-flex justify-content-center">
                      <table class="table table-striped table-hover text-center align-middle w-auto mx-auto">
                        <thead class="table-dark">
                          <tr>
                            <th>Concepto</th>
                            <th>Porcentaje</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>Promotor</td>
                            <td>${convenio[0]?.porcentaje_promotor || 0}%</td>
                          </tr>
                          <tr>
                            <td>Vega</td>
                            <td>${convenio[0]?.porcentaje_vega || 0}%</td>
                          </tr>
                        </tbody>
                      </table>
                    </div >
                  `;
                }// ... tu lógica para mostrar el modal y renderizar el monto
                else {
                  $q(".contenedor-monto").innerHTML = "Aun no hay nada para mostrar";
                }
              });
            }
            if (btnReportarSalida) {
              btnReportarSalida.addEventListener("click", async (e) => {
                iddetallepresentacion = e.target.getAttribute("data-iddp")
                const { fecha, hora } = obtenerSoloFechaHoraPeruSeparadaFormatoMysql();
                console.log("Fecha Perú (MySQL):", fecha);
                console.log("Hora Perú:", hora);

                btnReportarSalida.disabled = true;
                btnReportarSalida.innerHTML = '<i class="fas fa-save"></i> Reportando...'; // Cambia al icono de disquete o uno similar
                const usuariosAdmin = await obtenerUsuarios("3")
                const usuarioLogeado = await obtenerUsuarioPorId(idusuarioLogeado)
                console.log("usuarioLogeado -> ", usuarioLogeado);
                const mensaje = `${usuarioLogeado[0]?.nom_usuario} ha acaba de salir el ${formatDate(fecha)} a las ${formatHour(hora)}, click para mas detalles`
                console.log("usuariosAdmin -> ", usuariosAdmin);

                const reporteRegistradoEventoArt = await reportarSalidaRetornoArtista(iddetallepresentacion, 1, fecha, hora)
                //const destinoBusAsignado = await asignarLugarDestinoBus(iddetallepresentacion)
                //console.log("destino bus asignado ? ", destinoBusAsignado);
                console.log("reporte de registro de salida del arrtista-> ", reporteRegistradoEventoArt);
                if (reporteRegistradoEventoArt.idreporte) {
                  showToast("Salida Reportada!", "SUCCESS")
                  for (const admins of usuariosAdmin) {
                    console.log("admins -> ", admins);
                    const notificacionSalida = await registrarNotificacion(admins.idusuario, idusuarioLogeado, 6, reporteRegistradoEventoArt.idreporte, mensaje)
                    enviarPusher(admins.idusuario, "notificacion", mensaje)
                    console.log("notificacion salida -> ", notificacionSalida);
                  }
                  //modalSalida.hide()
                  setTimeout(() => {
                    btnReportarSalida.disabled = false;
                    btnReportarSalida.innerHTML = 'Reportar Salida'; // Reemplaza con el texto original
                  }, 2500);
                  return
                }
              })
            }
            if (btnReportarRetorno) {
              btnReportarRetorno.addEventListener("click", async (e) => {
                const iddetallepresentacion = e.target.getAttribute("data-iddp")
                const { fecha, hora } = obtenerSoloFechaHoraPeruSeparadaFormatoMysql();
                console.log("Fecha Perú (MySQL):", fecha);
                console.log("Hora Perú:", hora);

                btnReportarRetorno.disabled = true;
                btnReportarRetorno.innerHTML = '<i class="fas fa-save"></i> Reportando...'; // Cambia al icono de disquete o uno similar
                const usuariosAdmin = await obtenerUsuarios("3")
                const usuarioLogeado = await obtenerUsuarioPorId(idusuarioLogeado)
                console.log("usuarioLogeado -> ", usuarioLogeado);
                const mensaje = `${usuarioLogeado[0]?.nom_usuario} ha acaba de retornar el ${formatDate(fecha)} a las ${formatHour(hora)}, click para mas detalles`
                console.log("usuariosAdmin -> ", usuariosAdmin);
                const reporteRegistradoEventoArt = await reportarSalidaRetornoArtista(iddetallepresentacion, 2, fecha, hora)

                console.log("reporte de registro de retorno del arrtista-> ", reporteRegistradoEventoArt);
                if (reporteRegistradoEventoArt.idreporte) {
                  showToast("Retorno Reportada!", "SUCCESS")
                  for (const admins of usuariosAdmin) {
                    console.log("admins -> ", admins);
                    const notificacionRetorno = await registrarNotificacion(admins.idusuario, idusuarioLogeado, 6, reporteRegistradoEventoArt.idreporte, mensaje)
                    enviarPusher(admins.idusuario, "notificacion", mensaje)
                    console.log("notificacion retorno -> ", notificacionRetorno);
                  }
                  setTimeout(() => {
                    btnReportarRetorno.disabled = false;
                    btnReportarRetorno.innerHTML = 'Reportar Retorno'; // Reemplaza con el texto original
                  }, 2500);
                  return
                }
              })
            }
          }, 10);
        },
      });
    }

  });
  calendar.render();
  calendar.setOption("locale", "es");
  ajustarEventos(); // Aplicar ajuste inicial

  // Detectar cambios de tamaño de pantalla y ajustar eventos
  window.addEventListener("resize", ajustarEventos);


  if (nivelacceso == "Artista") {
    agenda = []
    //$q("#nivelacceso").remove()
    $q("#usuario").remove()
    $q(".contenedor-filtros-agenda").remove()
    const agendaUsuario = await obtenerAgenda(idusuarioLogeado, null, 6);
    console.log("agendaUsuario todo obtenido ->", agendaUsuario);

    await configurarCalendario(agendaUsuario)
    return
  } else if (nivelacceso == "Filmmaker") {
    agenda = []
    //$q("#nivelacceso").remove()
    $q("#usuario").remove()
    $q(".contenedor-filtros-agenda").remove()
    const agendaUsuario = await obtenerAgenda(idusuarioLogeado, null, 11);
    console.log("agendaUsuario todo obtenido ->", agendaUsuario);

    await configurarCalendario(agendaUsuario)
    return
  }

  const agendaArt = await obtenerAgenda(null, null, 6)
  console.log("agenda art -> ", agendaArt);
  await configurarCalendario(agendaArt)
  // **************************************** CONFIGURACION AGENDA **********************************************************

  async function configurarCalendario(agendaUsuario) {
    console.log("agendaUsuario -> ", agendaUsuario);
    let incompleto = false


    // Convertir los datos de la agenda en eventos para FullCalendar
    for (const evento of agendaUsuario) {
      incompleto =
        !evento.horainicio ||
        !evento.horafinal ||
        evento.horainicio == "00:00:00" ||
        evento.horafinal == "00:00:00" ||
        !evento.modalidad ||
        !evento.establecimiento ||
        !evento.tipo_evento;

      const esContratoValido =
        parseInt(evento.modalidad) === 2 &&
        parseInt(evento.estadoContrato) === 2;
      const esConvenioValido =
        parseInt(evento.modalidad) === 1 &&
        parseInt(evento.estado_convenio) === 2;

      let estadoBadge = {
        text: "No Confirmado",
        class: "badge bg-danger",
      };

      if (evento.estado == 2) {
        estadoBadge = {
          text: "Caducado",
          class: "badge bg-danger",
        };
      }
      else if (incompleto) {
        estadoBadge = {
          text: "Incompleto",
          class: "badge bg-danger",
        };
      } else if (evento.estado == 3) {
        estadoBadge = {
          text: "Cancelado",
          class: "badge bg-danger",
        };
      } else {
        if (esContratoValido || esConvenioValido) {
          estadoBadge = {
            text: "Confirmado",
            class: "badge bg-success",
          };
        }
      }

      const idsUsuarios = evento.idusuarioAgenda && typeof evento.idusuarioAgenda === "string"
        ? evento.idusuarioAgenda.split(",").map(id => id.trim())
        : [];

      console.log("Raw idusuarioAgenda ->", evento.idusuarioAgenda);
      console.log("idsUsuarios ->", idsUsuarios);
      // Obtener filmmakers de cada usuario
      let filmmakers = [];

      for (const id of idsUsuarios) {
        console.log("Obteniendo filmmaker para id:", id);
        let filmmakerObtenido = await obtenerUsuarioPorId(id);
        console.log("filmmakerObtenido -> ", filmmakerObtenido);
        if (filmmakerObtenido && filmmakerObtenido.length > 0) {
          filmmakers.push(filmmakerObtenido[0].dato);
        }
      }

      let filmmakersTexto = filmmakers.length > 0 ? filmmakers.join(", ") : "No asignado";

      if (nivelacceso) { //evento?.estado == 1 &&  evento?.idusuario == idusuarioLogeado || filmmakerObtenido[0]?.idusuario == idusuarioLogeado || 
        //console.log("entre pq soy admin");
        console.log("Evento agregado a la agenda:", evento);

        agenda.push({
          title: evento.nom_usuario,
          start: evento.fecha_presentacion,
          iddetalle_presentacion: evento.iddetalle_presentacion,
          backgroundColor: `rgb(252, 249, 246)`,
          borderColor: `rgb(252, 249, 246)`,
          textColor: "black",
          extendedProps: {
            estadoBadge,
            horainicio: evento.horainicio,
            horafinal: evento.horafinal,
            title: evento.nom_usuario,
            backgroundColor: evento.color,
            establecimiento: evento.establecimiento,
            iddepartamento: evento.iddepartamento,
            filmmaker: filmmakersTexto,
            idusuario: evento.idusuario,
            acuerdo: evento.acuerdo,
            idcontrato: evento.idcontrato,
            idconvenio: evento.idconvenio,
            estado: evento.estado,
            idagendaedicion: evento.idagendaedicion,
            iddetalle_presentacion: evento.iddetalle_presentacion,
          },
        });
      }
    }
    // Limpiar eventos previos y agregar los nuevos al calendario
    calendar.removeAllEvents();
    calendar.addEventSource(agenda);

    console.log("Eventos agregados al calendario:", calendar.getEvents());
    console.log("Cantidad de eventos en el calendario:", calendar.getEvents().length);


    // Personalizar la apariencia de los eventos para mostrar el badge
    calendar.setOption("eventContent", function (arg) {
      //      console.log("Evento extendido:", arg.event.extendedProps); // Verificar los datos
      /* if (arg.event.extendedProps.estadoBadge.text == "Incompleto" && nivelacceso !== "Administrador") {
        console.log("es incompleto ? ->", arg.event.extendedProps.estadoBadge.text);
        console.log("el nivel aceso es admi?", nivelacceso);
        console.log("entrando a la validacion del incompleto admini");
        agenda = []
        calendar.removeAllEvents();
        calendar.addEventSource(agenda);
        return

      } */
      let horaInicio = arg.event.extendedProps.horainicio
        ? formatHour(arg.event.extendedProps.horainicio)
        : "Hora no definida";
      let horaFinal = arg.event.extendedProps.horafinal
        ? formatHour(arg.event.extendedProps.horafinal)
        : "Hora no definida";

      let estado = arg.event.extendedProps?.estadoBadge;
      let badgeHtml = `<span class="${estado?.class}">${estado?.text}</span>`;
      console.log("ENTRANDO ANTES DE RENDERIZAR TODO");
      let establecimiento = arg.event.extendedProps.establecimiento || '';
      let maxLength = 5;

      if (establecimiento.length > maxLength) {
        establecimiento = establecimiento.substring(0, maxLength) + '...';
      }
      return {
        html: `
          <div style="
            
            padding: 4px 6px; 
            word-wrap: break-word; 
            overflow-wrap: break-word; 
            white-space: normal; 
            max-width: 220px; 
            font-size: 12px; 
            display: flex; 
            align-items: center;
            gap: 6px;
            ">
            <div style="
                width: 10px; 
                height: 10px; 
                border-radius: 50%; 
                background-color: ${arg.event.extendedProps.backgroundColor || '#28a745'};
                flex-shrink: 0;
            "></div>
            <span class="titulo-card">
                ${arg.event.title}
                - ${establecimiento || "No definido"}
            </span>
            </div>
      `,
      };
    });
  }


  // ******************************************* EVENTOS *************************************************************

  await obtenerUsuarios("6");


  //const nivel = $q("#nivelacceso").value
  /* if ($q("#nivelacceso").value == 10) {
    $q(".contenedor-select-tipo-filtro-edicion").hidden = false
    $q(".contenedor-select-usuario").hidden = true
  } */

  // MANEJADOR DE AGENDAS SEGUN NIVEL/ROL DE USUARIO

  /* $q("#nivelacceso")?.addEventListener("change", async () => {
    $q(".contenedor-select-usuario").hidden = false
    $q(".contenedor-select-tipo-filtro-edicion").hidden = true
    console.log("nivel ccceso escogido: ", $q("#nivelacceso").value);
    
  }); */
  //$q(".contenedor-select-usuario").hidden = true
  /* $q("#tipofiltroedicion").addEventListener("change", async () => {
    console.log("valor del select filtro adentor- > ", $q("#tipofiltroedicion").value);
    if ($q("#tipofiltroedicion").value == 2) {
      $q(".contenedor-select-usuario").hidden = false
      console.log("entrando con solo usuarios");
      await manejadorAgendaPorNivel("10")
    }
    else if ($q("#tipofiltroedicion").value == 1) {
      console.log("obteniendo todas las agendas");
      $q(".contenedor-select-usuario").hidden = true
      await manejadorAgendaPorNivel("10")
    }
  }) */

  async function manejadorAgendaPorNivel(nivelacceso) {
    let agendaUsuario = []
    switch (nivelacceso) {
      case "6": // ARTISTAS
        console.log("nivel 6 ");
        agenda = [];
        console.log("idUsuario ->", idUsuario);
        if (idUsuario === "-1") {
          agendaUsuario = await obtenerAgenda(null, null, 6);
          console.log("agendaUsuario todo obtenido ->", agendaUsuario);

          await configurarCalendario(agendaUsuario)
          return; // Si no se selecciona un usuario, no hacer nada
        }
        if (idUsuario == undefined) {
          agendaUsuario = await obtenerAgenda(idusuarioLogeado, null, 6);
          console.log("agendaUsuario todo obtenido ->", agendaUsuario);
          await configurarCalendario(agendaUsuario)
          return;
        }
        agendaUsuario = await obtenerAgenda(idUsuario, null, 6);
        console.log("agendaUsuario todo obtenido ->", agendaUsuario);

        if (agendaUsuario.length > 0) {
          await configurarCalendario(agendaUsuario)
        } else {
          await configurarCalendario([])
        }

        break;

      default:
        break;
    }
  }

  $q("#usuario")?.addEventListener("change", async (e) => {
    idUsuario = e.target.value;
    //const nivel = $q("#nivelacceso").value
    console.log("nivel  ->>>>", 6);
    console.log("idUsuario  ->>>>", idUsuario);
    await manejadorAgendaPorNivel("6")
  });

  document.addEventListener("click", async (e) => {
    console.log("clickaaa", e);
    if (e.target && e.target.id === "btnVerProgreso") {
      /* window.localStorage.clear()
      window.localStorage.setItem("idagendaedicion", idagendaedicion)
      window.location.href = `${ host } /views/agenda / asignar - agenda - edicion` */
      idagendaedicion = e.target.getAttribute("data-idagendaedicion");

      modalProgresoEdicion = new bootstrap.Modal($q("#modal-progresoedicion"));
      modalProgresoEdicion.show();

      const editoresAsignados = await obtenerEditoresAsignados(idagendaedicion)
      console.log("editoresAsignados ->", editoresAsignados);
      $q(".contenedor-tareas-edicion-pendientes").innerHTML = ``
      editoresAsignados.forEach(editor => {

        $q(".contenedor-tareas-edicion-pendientes").innerHTML += `
        < tr >
              <td>${editor.fecha_entrega}</td>
              <td>${editor.nombres}</td>
              <td>${editor.tipotarea == 1 ? 'Flayer' : editor.tipotarea == 2 ? 'Saludos' : editor.tipotarea == 3 ? 'Reels' : editor.tipotarea == 4 ? 'Fotos' : editor.tipotarea == 5 ? 'Contenido' : 'No especificado'}</td>
              <td>
                <select name="tipotarea" id="tipotarea" class="form-select">
                    <option value="-1">Seleccione</option>
                    <option value="1" ${editor.estado == 1 ? 'selected' : ''}>Pendiente</option>
                    <option value="2" ${editor.estado == 2 ? 'selected' : ''}>Completado</option>
                </select>
              </td>
              <td>
                  <button type="button" class="btn btn-primary" id="btnAbrirModalSubir" data-idagendaeditor="${editor.idagendaeditor}">Ver</button>
              </td>        
          </tr >
    `
      });
      $all("#btnAbrirModalSubir").forEach(btn => {
        btn.addEventListener("click", (e) => {
          idagendaeditor = e.target.getAttribute("data-idagendaeditor")
          console.log("id agenda edicion -> ", idagendaeditor);
          window.localStorage.clear()
          window.localStorage.setItem("idagendaeditor", idagendaeditor)
          window.location.href = `${hostOnly} /views/agenda / subir - contenido - edicion`
          return
        })
      })
    }
    if (e.target && e.target.id === "btnAsignarEditor") {
      /* window.localStorage.clear()
      window.localStorage.setItem("idagendaedicion", idagendaedicion)
      window.location.href = `${ host } /views/agenda / asignar - agenda - edicion` */
      idagendaedicion = e.target.getAttribute("data-idagendaedicion");

      modalAsignarEditor = new bootstrap.Modal($q("#modal-asignareditor"));
      modalAsignarEditor.show();

      const editoresAsignados = await obtenerEditoresAsignados(idagendaedicion)
      console.log("editoresAsignados ->", editoresAsignados);
      $q(".contenedor-asignados").innerHTML = ``
      editoresAsignados.forEach(editor => {

        $q(".contenedor-asignados").innerHTML = `
    <tr>
              <td>${editor.nombres && editor.tipotarea == 1 ? editor.nombres : 'No asignado'}</td>
              <td>${editor.nombres && editor.tipotarea == 2 ? editor.nombres : 'No asignado'}</td>
              <td>${editor.nombres && editor.tipotarea == 3 ? editor.nombres : 'No asignado'}</td>
              <td>${editor.nombres && editor.tipotarea == 4 ? editor.nombres : 'No asignado'}</td>
              <td>${editor.nombres && editor.tipotarea == 5 ? editor.nombres : 'No asignado'}</td>
              
          </tr >
    `
      });
    }

    if (e.target && e.target.id === "btnViatico") {
      iddp = e.target.getAttribute("data-iddp");
      iddepartamento = e.target.getAttribute("data-iddepartamento");
      console.log("ID DEPARTAMENTO ELEGIDO -> ", iddepartamento)
      console.log("iddetalle_repsentacion elegida -> ", iddp)

      modalViatico = new bootstrap.Modal($q("#modal-viatico"));
      modalViatico.show();
      await renderizarInfoAgenda(iddp, iddepartamento)
    }
    if (e.target && e.target.id === "btnEditarAcuerdo") {
      iddp = e.target.getAttribute("data-iddp");
      modalAcuerdo = new bootstrap.Modal($q("#modal-acuerdo"));
      modalAcuerdo.show();
      $q("#acuerdo").value = ""
      const acuerdoObtenido = await obtenerAcuerdo(iddp)
      console.log("acuerdoObtenido -> ", acuerdoObtenido)
      if (acuerdoObtenido.length > 0) {
        $q("#acuerdo").value = acuerdoObtenido[0].acuerdo
      }
    }
    if (e.target && e.target.id === "btnAsignarFilmmaker") {
      iddp = e.target.getAttribute("data-iddp")
      console.log("iddp -> ", iddp)
      modalFilmmaker = new bootstrap.Modal($q("#modal-filmmaker"));
      modalFilmmaker.show();
      const filmmakers = await obtenerUsuariosPorNivel("11")
      console.log("filmmakers -> ", filmmakers)
      const filmmakersDP = await obtenerFilmmakersDP(iddp)
      $q("#filmmaker").innerHTML = "<option value=''>Selecciona</option>"
      filmmakers.forEach(filmmaker => {
        $q("#filmmaker").innerHTML += `<option value="${filmmaker.idusuario}"> ${filmmaker.nombres} ${filmmaker.apellidos}</option>`
      })
      console.log(" filmmakersDP ->", filmmakersDP);
      if (filmmakersDP.length > 0) {
        $q(".contenedor-filmmakers-asignados").innerHTML = ''
        filmmakersDP.forEach(filmmakerDP => {
          $q(".contenedor-filmmakers-asignados").innerHTML += `
    <div class="d-flex justify-content-around align-items-center mb-3" style = "background-color:rgb(212, 212, 212);" data-idasignacion="${filmmakerDP?.idasignacion}">
              <label for="">${filmmakerDP.nombres} ${filmmakerDP.apellidos} - (${filmmakerDP.nom_usuario})</label>
              <i class="fa-solid fa-trash btnQuitarFilmmaker p-3" data-idasignacion="${filmmakerDP?.idasignacion}" title="Quitar Filmmaker" style="cursor: pointer; color: white; background-color: red"></i>
          </div>
    `
        })
      } else {
        $q(".contenedor-filmmakers-asignados").innerHTML = `
    <div class="container">
      <div class="text-center">
        <p>sin filmmakers asignados.</p>
      </div>
                </div>
    `
      }


      $all(".btnQuitarFilmmaker").forEach(btn => {
        btn.addEventListener("click", async (e) => {
          idasignacion = e.target.getAttribute("data-idasignacion")
          console.log("idasignacion -> ", idasignacion);
          const filmmakerDPeliminado = await eliminarFilmmakerDP(idasignacion)
          console.log("filmmaker dp eliminado -> ", filmmakerDPeliminado);
          if (filmmakerDPeliminado) {
            const divFilmmaker = document.querySelector(`.contenedor-filmmakers-asignados[data-idasignacion="${idasignacion}"]`);
            if (divFilmmaker) divFilmmaker.remove();
            showToast("Filmmaker removido!", "SUCCESS")
            return
          }
          return
        })
      })
    }
    if (e.target && e.target.id === "btnInfo") {
      iddp = e.target.getAttribute("data-iddp")
      modalInfoEvento = new bootstrap.Modal($q("#modal-infoevento"))
      modalInfoEvento.show()

      const dpInfo = await obtenerDPporId(iddp)
      console.log("dpInfo -> ", dpInfo);
      const ubicacion = dpInfo[0]?.esExtranjero == 0 ? dpInfo[0]?.departamento + "/" + dpInfo[0]?.provincia + "/" + dpInfo[0]?.distrito : dpInfo[0]?.establecimiento + "/" + dpInfo[0]?.pais

      const contenedorModal = $q(".contenedor-infoevento");
      contenedorModal.innerHTML = `
          <div class="mt-3">
                <h4 class="fw-bold">Promotor:</h4><br>
                <label class="fw-bold">Nombre/Razon Social:</label> <span id="noti-pasaje">${dpInfo[0]?.razonsocial ? dpInfo[0]?.razonsocial.toUpperCase() : 'Sin datos'}</span> <br>
                <label class="fw-bold">Celular:</label> <span id="noti-pasaje">${dpInfo[0]?.telefono ? dpInfo[0]?.telefono : 'Sin celular/telefono'}</span> <br>

                <h4 class="fw-bold">Detalles evento:</h4><br>
                <label class="fw-bold">Artista:</label> <span id="noti-pasaje">${dpInfo[0]?.nom_usuario ? dpInfo[0]?.nom_usuario?.toUpperCase() : ''}</span> <br>
                <label class="fw-bold">Lugar:</label> <span id="noti-comida">${dpInfo[0]?.establecimiento ? dpInfo[0]?.establecimiento.toUpperCase() : ''}</span> <br>
                <label class="fw-bold">Fecha:</label> <span id="noti-viaje">${formatDate(dpInfo[0]?.fecha_presentacion) ? formatDate(dpInfo[0]?.fecha_presentacion) : ''}</span> <br>
                <label class="fw-bold">Desde - hasta:</label> <span id="noti-viaje">${formatHour(dpInfo[0]?.horainicio) ?? "0:00"} - ${formatHour(dpInfo[0]?.horafinal) ?? "0:00"}</span> <br>
                <label class="fw-bold">Tiempo:</label> <span id="noti-viaje">${calculateDuration(dpInfo[0]?.horainicio ?? "0:00", dpInfo[0]?.horafinal ?? "0:00")}</span> <br>
                <label class="fw-bold">Ubicacion:</label> <span id="noti-viaje">${ubicacion}</span> <br>
                <label class="fw-bold">Modalidad:</label> <span id="noti-viaje">${dpInfo[0]?.modalidad == 1 ? "Convenio" : dpInfo[0]?.modalidad == 2 ? "Contrato" : ''}</span>
                <hr>
                <div class="mt-3">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="cordinaciontecnica" ${dpInfo[0]?.estadoCordinacionTecnica == 1 ? "checked" : ""}>
                    <label class="form-check-label fw-normal" for="cordinaciontecnica">
                      coordinación técnica (pantalla, luces y sonido)
                    </label>
                  </div>
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="cordinacionpublicidad" ${dpInfo[0]?.estadoCordinacionPublicidad == 1 ? "checked" : ""}>
                    <label class="form-check-label fw-normal" for="cordinacionpublicidad">
                      coordinación publicidad
                    </label>
                  </div>
                </div>
                <hr>
                <div class="${dpInfo[0]?.estado == 3 ? `bg-danger` : `bg-info`} text-white p-3 fw-bolder text-center">
                  ${dpInfo[0]?.estado == 3 ? `CANCELADO` : 'ACTIVO'}
                </div>

              </div>    
        `;

      $q("#cordinaciontecnica").addEventListener("change", async (e) => {
        console.log("cambiando tecnica");

        const estado = e.target.checked ? 1 : 0; // 👈 convierte a número
        const cordtecact = await actualizarEstadoCordinacionTecnica(iddp, estado);
        console.log("cordtecact", cordtecact);
      });

      $q("#cordinacionpublicidad").addEventListener("change", async (e) => {
        console.log("cambiando publicidad");
        const estado = e.target.checked ? 1 : 0; // 👈 convierte a número
        const cordpubact = await actualizarEstadoCordinacionPublicidad(iddp, estado);
        console.log("cordpubact", cordpubact);
      });

    }

    if (e.target && e.target.id === "btnVerMontos") {
      $q(".contenedor-monto").innerHTML = ''
      console.log("CLICK EN VER MONTOS");
      const idcontrato = e.target.getAttribute("data-idcontrato")
      const idconvenio = e.target.getAttribute("data-idconvenio")
      modalMonto = new bootstrap.Modal($q("#modal-monto"));
      modalMonto.show();

      console.log("idcontrato -> ", idcontrato)
      console.log("idconvenio -> ", idconvenio)
      //let monto = 0;
      if (idcontrato != "null") {  // Verifica si idcontrato tiene un valor válido
        const contrato = await obtenerContrato(idcontrato);
        console.log("contrato -> ", contrato);

        const tarifaArtista = await obtenerTarifaArtistaPorProvincia(
          contrato[0]?.idprovincia_evento,
          contrato[0]?.idusuario,
          contrato[0]?.tipo_evento
        );
        console.log("tarifaArtista -> ", tarifaArtista);
        //await renderizarUbigeoPresentacion(contrato[0]?.iddetalle_presentacion);
        const dp = await obtenerDPporId(contrato[0]?.iddetalle_presentacion);
        console.log(dp);

        const longlatCiudad = await obtenerLongLatPorCiudad(dp[0]?.departamento + ',' + dp[0]?.provincia)
        console.log("longlatCiudad->>>", longlatCiudad)
        const infoRecorrido = await obtenerDuracionDeViaje(lonOrigen, latOrigen, longlatCiudad[0]?.lon, longlatCiudad[0]?.lat)
        const duracionTiempoCrudo = infoRecorrido.routes[0]?.duration
        calcularDificultadPrecio = calcularPrecio(duracionTiempoCrudo)
        const precioArtista = parseFloat(tarifaArtista[0]?.precio) || 0;
        const costoDificultad = parseFloat(calcularDificultadPrecio?.costoDificultad) || 0;
        const igv = (precioArtista + costoDificultad) * 0.18;

        const total = contrato[0]?.igv == 0
          ? precioArtista + costoDificultad
          : precioArtista + costoDificultad + igv;



        $q(".contenedor-monto").innerHTML = `
    <div class="table-responsive d-flex justify-content-center">
      <table class="table table-striped table-hover text-center align-middle w-auto mx-auto" id="table-tarifarios">
        <thead class="table-dark">
          <tr>
            <th>Descripción</th>
            <th>Tiempo</th>
            <th>Costo</th>
            <th>Total</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Presentacion artistica de ${contrato[0]?.nom_usuario}</td>
            <td>${calculateDuration(contrato[0]?.horainicio, contrato[0]?.horafinal)}</td>
            <td>S/. ${tarifaArtista[0]?.precio || 0}</td>
            <td>S/. ${tarifaArtista[0]?.precio || 0}</td>
          </tr>
          <tr>
            <td>Puesto en la locacion de ${contrato[0]?.provincia}</td>
            <td>${calcularDificultadPrecio?.horasEstimadas}</td>
            <td>S/. ${calcularDificultadPrecio?.costoDificultad}</td>
            <td>S/. ${calcularDificultadPrecio?.costoDificultad}</td>
          </tr>
          <tr>
            <td colspan="2" class="text-end">(Opcional)</td>
            <td colspan="1">IGV (18%)</td>
            <td>${contrato[0]?.igv == 0 ? 'No incluye' : contrato[0]?.igv == 1 ? `S/. ${igv.toFixed(2)}` : ''}</td>
          </tr>
          <tr>
            <td colspan="3" class="text-end">TOTAL</td>
            <td><strong>S/. ${total.toFixed(2)}</strong></td>
          </tr>
        </tbody>
      </table>
            </div >
    `;
      } else if (idconvenio != "null") {  // Solo entra aquí si idcontrato NO es válido
        $q(".contenedor-monto").innerHTML = "";

        const convenio = await obtenerContratoConvenio(idconvenio);
        console.log("convenio -> ", convenio);
        $q(".contenedor-monto").innerHTML = `
    <div class="table-responsive d-flex justify-content-center">
      <table class="table table-striped table-hover text-center align-middle w-auto mx-auto">
        <thead class="table-dark">
          <tr>
            <th>Concepto</th>
            <th>Porcentaje</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Promotor</td>
            <td>${convenio[0]?.porcentaje_promotor || 0}%</td>
          </tr>
          <tr>
            <td>Vega</td>
            <td>${convenio[0]?.porcentaje_vega || 0}%</td>
          </tr>
        </tbody>
      </table>
            </div >
    `;
      }

      //      showToast(`El monto a pagar es de S /.${ monto } `, "INFO")
    }
    /* if (e.target && e.target.id === "btnReportarSalida") {
      modalSalida = new bootstrap.Modal($q("#modal-salida"))
      modalSalida.show()
    } */
  }); // ME QUEDE ACA -> REVISAR EL MODAL DE VIATICO

  async function renderizarInfoAgenda(iddp, iddepartamento) {
    $q("#btnActualizarViatico").hidden = true
    $q("#btnGuardarViatico").hidden = false
    $q("#pasaje").value = ""
    $q("#comida").value = ""
    $q("#viaje").value = ""
    let isLima = false;
    console.log("iddp existe  ee -> ", iddp)
    const viaticoExiste = await obtenerViatico(iddp)
    console.log("viaticoExiste ._< ", viaticoExiste)
    if (viaticoExiste.length > 0) {
      $q("#pasaje").value = viaticoExiste[0]?.pasaje
      $q("#comida").value = viaticoExiste[0]?.comida
      $q("#viaje").value = viaticoExiste[0]?.viaje
      $q("#btnActualizarViatico").hidden = false
      idviatico = viaticoExiste[0]?.idviatico
      $q("#btnGuardarViatico").hidden = true
    }
    const departamento = await obtenerDepartamentoPorId(iddepartamento)
    console.log("departamento -> ", departamento)
    if (departamento[0].iddepartamento == 15) { // LIMA
      isLima = true;
    }

    console.log("isLima ??", isLima)
    /* if (isLima) {
      $q(".contenedor-viatico-viaje").hidden = true
    } else {
      $q(".contenedor-viatico-viaje").hidden = false
    } */

  }

  $q("#btnGuardarAcuerdo").addEventListener("click", async () => {

    const acuerdoEditado = await editarAcuerdoEvento(iddp)
    console.log("ACUERDO EDITADO -> ", acuerdoEditado)
    if (acuerdoEditado) {
      //$q("#text-acuerdo").innerHTML = $q("#acuerdo").value
      showToast("Acuerdo editado correctamente", "SUCCESS")
      const agendaUsuario = await obtenerAgenda(idUsuario);
      console.log("agendaUsuario todo obtenido ->", agendaUsuario);
      await configurarCalendario(agendaUsuario)
      modalAcuerdo.hide()
    }
  })

  $q("#btnGuardarViatico").addEventListener("click", async () => {

    if ($q("#pasaje").value == "" || $q("#comida").value == "") {
      showToast("Por favor, complete los campos obligatorios", "ERROR")
      return
    }
    const viaticoRegistrado = await registrarViatico(iddp)
    console.log("viaticoRegistrado -> ", viaticoRegistrado)
    const usuarioFilmmaker = await obtenerUsuarioPorId(idusuarioLogeado)
    console.log("usuarioFilmmaker -> ", usuarioFilmmaker)
    if (viaticoRegistrado.idviatico) {
      // PONER UNA SECCION ACA PARA NOTIFICAR QUE SE REGISTRO CORRECTAMENTE
      console.log("entrando a la validacaion...")
      const mensaje = `${usuarioFilmmaker[0]?.dato} ha reportado un viatico, haz click para ver`
      const notificacionRegistrada = await registrarNotificacion(idusuarioLogeado, 1, viaticoRegistrado.idviatico, mensaje)
      console.log("notificacion registrada ? -> ", notificacionRegistrada)
      console.log("mensaje -> ", mensaje)
      showToast("Viático registrado correctamente", "SUCCESS")
      //await 
      modalViatico.hide()
    }
  })

  $q("#btnActualizarViatico").addEventListener("click", async () => {
    const viaticoActualizado = await actualizarViatico(idviatico)
    console.log("viaticoActualizado -> ", viaticoActualizado)
    if (viaticoActualizado.update) {
      showToast("Viático actualizado correctamente", "SUCCESS")
      return
    }
  })

  $q("#btnGuardarFilmmaker").addEventListener("click", async () => {
    console.log("click al btn guardar filmmaker")
    console.log("iddp-- > ", iddp);
    console.log("valor filmamker elegido -> ", $q("#filmmaker").value);
    const dpObtenido = await obtenerFilmmakerAsociadoEvento($q("#filmmaker").value);
    console.log("Este filmmaker está asociado a un evento -> ", dpObtenido);

    // Verificar si algún elemento tiene el mismo iddetalle_presentacion que iddp
    const existe = dpObtenido.some(item => item.idusuario == $q("#filmmaker").value && item.iddetalle_presentacion == iddp);

    if (existe) {
      showToast("Este filmmaker ya está asignado a este evento", "ERROR");
      return;
    } // este id usuario es del filmmaker
    const filmmakerAsignado = await asignarAgenda(iddp)
    console.log("filmmakerAsignado -> ", filmmakerAsignado)
    if (filmmakerAsignado.idasignacion) {
      showToast("Filmmaker asignado correctamente", "SUCCESS")
      const notiAsigFilm = await registrarNotificacion($q("#filmmaker").value, idusuarioLogeado, 3, filmmakerAsignado.idasignacion, "Has sido asignado a un nuevo evento, revisa tu agenda")
      console.log("noti asig film -< ", notiAsigFilm);
      enviarPusher($q("#filmmaker").value, "asignacion filmmaker", "Has sido asignado a un nuevo evento, revisa tu agenda")
      /*       const agendaUsuario = await obtenerAgenda(idUsuario);
            console.log("agendaUsuario todo obtenido ->", agendaUsuario);
      
            calendar.removeAllEvents()
            await configurarCalendario(agendaUsuario) */

      modalFilmmaker.hide()
    }
  })

  // *********************************** RENDERIZACION **********************************************************


});
