document.addEventListener("DOMContentLoaded", async () => {

  let latOrigen
  let lonOrigen
  let calcularDificultadPrecio = []

  navigator.geolocation.getCurrentPosition(function (position) {
    latOrigen = position.coords.latitude;
    lonOrigen = position.coords.longitude;
    console.log(`Tu ubicación: ${latOrigen},${lonOrigen}`);
  });

  // SELECTs
  let responsablesBoleteria = $q("#boleteria")
  let responsablesContrato = $q("#contrato")

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
  let idconvenio
  let idusuarioArtDest
  let fechapresentacion
  let tipoevento
  //let selectSucursales = $q("#sucursal")
  let idsucursal
  let iddp
  let mensaje

  //MODALES
  let modalDatosContrato
  let modalDatosClienteIncompleto
  let modalReserva
  let modalPropuestaCliente
  let modalpreviageneracion
  let modalPreviaCotizacion
  let modalInfoEvento

  // LISTAS
  let pagosExistentes = []

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

  console.log("idusuaro logeado -> ", idusuarioLogeado);
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



  // ***************************************** OBTENER DATOS ********************************

  async function obtenerSucursales() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerSucursales");
    const data = await getDatos(`${host}sucursal.controller.php`, params);
    console.log("data de succursales -> ", data);

    return data;
  }




  async function obtenerArtistas() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorNivel");
    params.append("idnivelacceso", 6);
    const data = await getDatos(`${host}usuario.controller.php`, params);
    console.log(data);
    $q("#nomusuario").innerHTML = "<option value=''>Todos</option>";
    data.forEach((artista) => {
      $q(
        "#nomusuario"
      ).innerHTML += `<option value="${artista.nom_usuario}">${artista.nom_usuario}</option>`;
    });
  }

  await obtenerArtistas()

  async function obtenerDPporId(iddp) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDPporId");
    params.append("iddetallepresentacion", iddp);
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
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

  async function obtenerTarifaArtistaPorProvincia(idprovincia, idusuario, tipoevento) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerTarifaArtistaPorProvincia");
    params.append("idprovincia", idprovincia);
    params.append("idusuario", idusuario);
    params.append("tipoevento", tipoevento);
    const data = await getDatos(`${host}tarifa.controller.php`, params);
    return data;
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


  async function obtenerReservaPorPagoContrato(idpagocontrato) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerReservaPorPagoContrato");
    params.append("idpagocontrato", idpagocontrato);
    const data = await getDatos(`${host}contrato.controller.php`, params);
    return data;
  }

  async function obtenerCajaChicaPorDP(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerCajaChicaPorDP");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  }




  // *********************************************** OBTENCION DE UBIGEOS ******************************************

  async function obtenerDepartamentos(iddepartamento) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDepartamentos");
    params.append("idnacionalidad", iddepartamento);
    const data = await getDatos(`${host}recurso.controller.php`, params);
    return data
  }

  async function obtenerProvincias(iddepartamento) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerProvincias");
    params.append("iddepartamento", iddepartamento);
    const data = await getDatos(`${host}recurso.controller.php`, params);
    return data
  }

  async function obtenerDistritos(idprovincia) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDistritos");
    params.append("idprovincia", idprovincia);
    const data = await getDatos(`${host}recurso.controller.php`, params);
    return data
  }

  async function obtenerDuracionDeViaje(lon_origen, lat_origen, lon_destino, lat_destino) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDuracionDeViaje");
    params.append("lon_origen", lon_origen);
    params.append("lat_origen", lat_origen);
    params.append("lon_destino", lon_destino);
    params.append("lat_destino", lat_destino);
    const data = await getDatos(`${host}maps.controller.php`, params);
    return data
  }

  /* async function actualizarCajaDP(iddetallepresentacion, estado) {
    const params = new URLSearchParams();
    params.append("operation", "actualizarCajaDP");
    params.append("iddetallepresentacion", iddetallepresentacion);
    params.append("tienecaja", estado);
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    return data;
  } */
  /*   async function obtenerLongLatPorCiudad(provincia) {
      const params = new URLSearchParams();
      params.append("operation", "obtenerLongLatPorCiudad");
      params.append("provincia", provincia);
      const data = await getDatos(`${host}maps.controller.php`, params);
      return data
    } */

  async function registrarCajaChica(
    iddetallepresentacion,
    idmonto,
    ccinicial,
    incremento,
    decremento,
    ccfinal
  ) {
    const cajachica = new FormData();
    cajachica.append("operation", "registrarCajaChica");
    cajachica.append(
      "iddetallepresentacion",
      iddetallepresentacion ? iddetallepresentacion : ""
    );
    cajachica.append("idmonto", idmonto);
    cajachica.append("ccinicial", ccinicial);
    cajachica.append("incremento", incremento); // id artista
    cajachica.append("decremento", decremento); // id artista
    cajachica.append("ccfinal", ccfinal);

    const fcajachica = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: cajachica,
    });
    const rcajachica = await fcajachica.json();
    return rcajachica;
  }

  async function registrarGasto(idcajachica) {
    const gasto = new FormData();
    gasto.append("operation", "registrarGasto");
    gasto.append("idcajachica", idcajachica);
    gasto.append("concepto", $q("#concepto").value); // id artista
    gasto.append("monto", $q("#monto").value);

    const fgasto = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: gasto,
    });
    const rgasto = await fgasto.json();
    return rgasto;
  }

  async function obtenerLongLatPorCiudad(provincia) {
    const Fdata = await fetch(`https://nominatim.openstreetmap.org/search?q=${provincia}&format=json`)
    const data = await Fdata.json()
    return data
  }

  async function obtenerDuracionDeViaje(lon_origen, lat_origen, lon_destino, lat_destino) {
    const Fdata = await fetch(`https://router.project-osrm.org/route/v1/driving/${lon_origen},${lat_origen};${lon_destino},${lat_destino}?overview=false`)
    const data = await Fdata.json()
    return data
  }

  async function obtenerUsuariosBoleteria() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorNivel");
    params.append("idnivelacceso", 3);
    const data = await getDatos(`${host}usuario.controller.php`, params);
    console.log(data);
    responsablesBoleteria.innerHTML = "";
    data.forEach((artista) => {
      responsablesBoleteria.innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
    });
    return data

  }

  async function obtenerUsuariosCerrarContrato() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorNivel");
    params.append("idnivelacceso", 3);
    const data = await getDatos(`${host}usuario.controller.php`, params);
    console.log(data);
    responsablesContrato.innerHTML = "";
    data.forEach((artista) => {
      responsablesContrato.innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
    });
    return data

  }

  async function obtenerResponsableBoleteriaContrato(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerResponsableBoleteriaContrato");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    console.log(data);
    return data

  }

  async function obtenerPreciosEvento(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerPreciosEvento");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    console.log(data);
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

  async function obtenerCotizacion(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerCotizacion");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const fpersona = await getDatos(`${host}detalleevento.controller.php`, params)
    console.log(fpersona);
    return fpersona
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

  async function obtenerUsuarioPorId(idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorId");
    params.append("idusuario", idusuario);
    const fpersona = await getDatos(`${host}usuario.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function actualizarCajaDP(iddetallepresentacion, estado) {
    const convenio = new FormData();
    convenio.append("operation", "actualizarCajaDP");
    convenio.append("iddetallepresentacion", iddetallepresentacion); // id artista
    convenio.append("tienecaja", estado);

    const fconvenio = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: convenio,
    });
    const rconvenio = await fconvenio.json();
    return rconvenio;
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

  async function registrarConvenio(iddetallepresentacion, estado) {
    console.log("porcentaje vega: ", $q("#porcentajevega").value)
    console.log("porcentajepromotor: ", $q("#porcentajepromotor").value)
    const pago = new FormData();
    pago.append("operation", "registrarConvenio");
    pago.append("iddetallepresentacion", iddetallepresentacion);
    pago.append("abonogarantia", $q("#abonogarantia").value);
    pago.append("abonopublicidad", $q("#abonopublicidad").value);
    pago.append("porcentajevega", parseInt($q("#porcentajevega").value));
    pago.append("porcentajepromotor", parseInt($q("#porcentajepromotor").value));
    pago.append("propuestacliente", $q("#propuestacliente").value);
    pago.append("estado", estado);

    const fpago = await fetch(`${host}convenio.controller.php`, {
      method: "POST",
      body: pago,
    });
    const rpago = await fpago.json();
    return rpago;
  }

  async function registrarAgendaEdicion(iddetallepresentacion) {
    const body = new FormData();
    body.append("operation", "registrarAgendaEdicion");
    body.append("iddetallepresentacion", iddetallepresentacion);

    const fbody = await fetch(`${host}agenda.controller.php`, {
      method: "POST",
      body: body,
    });
    const rbody = await fbody.json();
    return rbody;
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

  /* async function registrarNotificacion(artista, idusuariorem, tipo, idreferencia, mensaje) {
    const viatico = new FormData();
    viatico.append("operation", "registrarNotificacion");
    viatico.append("idusuariodest", artista); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
    viatico.append("idusuariorem", idusuariorem); // id usuario envia la notificacion
    viatico.append("tipo", tipo);
    viatico.append("idreferencia", idreferencia ? idreferencia : '');
    viatico.append("mensaje", mensaje);

    const fviatico = await fetch(`${host}notificacion.controller.php`, {
      method: "POST",
      body: viatico,
    });
    const rviatico = await fviatico.json();
    //console.log("rivatico . ", rviatico)
    return rviatico;
  } */

  async function actualizarCliente(idcliente) {

    const ndocumento = $q("#ndocumentocli").value.trim();

    // Determinar el tipo de documento
    let tipodocu = "";
    if (ndocumento.length == 8) {
      tipodocu = 1;
    } else if (ndocumento.length == 11) {
      tipodocu = 2;
    }
    console.log("tipodocu -> ", tipodocu);

    const clienteAct = new FormData();
    clienteAct.append("operation", "actualizarCliente");
    clienteAct.append("idcliente", idcliente);
    clienteAct.append("tipodoc", tipodocu);
    clienteAct.append("iddistrito", $q("#distrito").value);
    clienteAct.append("ndocumento", $q("#ndocumentocli").value ? $q("#ndocumentocli").value : '');
    clienteAct.append("razonsocial", $q("#razonsocial").value);
    clienteAct.append("representantelegal", $q("#representantelegal").value ? $q("#representantelegal").value : '');
    clienteAct.append("telefono", $q("#telefono").value ? $q("#telefono").value : '');
    clienteAct.append("correo", $q("#correo").value ? $q("#correo").value : '');
    clienteAct.append("direccion", $q("#direccion").value);

    const fclienteAct = await fetch(`${host}cliente.controller.php`, {
      method: "POST",
      body: clienteAct,
    });
    const rclienteAct = await fclienteAct.json();
    return rclienteAct;
  }

  async function actualizarEstadoDp(iddetallepresentacion, estado) {
    const detallepre = new FormData();
    detallepre.append("operation", "actualizarEstadoDp");
    detallepre.append("iddetallepresentacion", iddetallepresentacion);
    detallepre.append("estado", estado);

    const fdetallepre = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: detallepre,
    });
    const rdetallepre = await fdetallepre.json();
    return rdetallepre;
  }

  async function actualizarConvenio(idconvenio, estado) {
    const convenioupdate = new FormData();
    convenioupdate.append("operation", "actualizarConvenio");
    convenioupdate.append("idconvenio", idconvenio);
    convenioupdate.append("abonogarantia", $q("#abonogarantia").value);
    convenioupdate.append("abonopublicidad", $q("#abonopublicidad").value);
    convenioupdate.append("porcentajevega", parseInt($q("#porcentajevega").value));
    convenioupdate.append("porcentajepromotor", parseInt($q("#porcentajepromotor").value));
    convenioupdate.append("propuestacliente", $q("#propuestacliente").value);
    convenioupdate.append("estado", estado);

    const fconvenioupdate = await fetch(`${host}convenio.controller.php`, {
      method: "POST",
      body: convenioupdate,
    });
    const rconvenioupdate = await fconvenioupdate.json();
    return rconvenioupdate;
  }

  async function registrarTarifa(idartista, idprovincia, precio, tipoevento, idnacionalidad, precioextranjero) {
    const tarifa = new FormData();
    tarifa.append("operation", "registrarTarifa");
    tarifa.append("idusuario", idartista);
    tarifa.append("idprovincia", idprovincia);
    tarifa.append("precio", precio);
    tarifa.append("tipoevento", tipoevento);
    tarifa.append("idnacionalidad", idnacionalidad || '');
    tarifa.append("precioextranjero", precioextranjero || '');

    const ftarifa = await fetch(`${host}tarifa.controller.php`, {
      method: "POST",
      body: tarifa,
    });
    const rtarifa = await ftarifa.json();
    return rtarifa;
  }



  // NUEVO 
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

  async function registrarResponsableBoleteriaContrato(iddetallepresentacion, idusuarioboleteria, idusuariocontrato) {

    const reserva = new FormData();
    reserva.append("operation", "registrarResponsableBoleteriaContrato");
    reserva.append("iddetallepresentacion", iddetallepresentacion);
    reserva.append("idusuarioboleteria", idusuarioboleteria ? idusuarioboleteria : null);
    reserva.append("idusuariocontrato", idusuariocontrato ? idusuariocontrato : null);

    const freserva = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: reserva,
    });
    const rreserva = await freserva.json();
    return rreserva;
  }
  async function registrarPrecioEvento(iddetallepresentacion, entradas) {

    const reserva = new FormData();
    reserva.append("operation", "registrarPrecioEvento");
    reserva.append("iddetallepresentacion", iddetallepresentacion);
    reserva.append("entradas", entradas ? entradas : null);

    const freserva = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: reserva,
    });
    const rreserva = await freserva.json();
    return rreserva;
  }

  async function actualizarResponsableBoleteriaContrato(idresponsablecontrato, idusuarioboleteria, idusuariocontrato) {

    const reserva = new FormData();
    reserva.append("operation", "actualizarResponsableBoleteriaContrato");
    reserva.append("idresponsablecontrato", idresponsablecontrato)
    reserva.append("idusuarioboleteria", idusuarioboleteria ? idusuarioboleteria : null);
    reserva.append("idusuariocontrato", idusuariocontrato ? idusuariocontrato : null);

    const freserva = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: reserva,
    });
    const rreserva = await freserva.json();
    return rreserva;
  }

  async function actualizarPrecioEntradaEvento(idprecioentradaconvenio, entradas) {

    const reserva = new FormData();
    reserva.append("operation", "actualizarPrecioEntradaEvento");
    reserva.append("idprecioentradaconvenio", idprecioentradaconvenio)
    reserva.append("entradas", entradas ? entradas : null);

    const freserva = await fetch(`${host}detalleevento.controller.php`, {
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

  async function borrarEventoArtista(iddetallepresentacion) {
    const pagado50 = new FormData();
    pagado50.append("operation", "borrarEventoArtista");
    pagado50.append("iddetallepresentacion", iddetallepresentacion);


    const fpagado50 = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: pagado50,
    });
    const rpagado50 = await fpagado50.json();
    return rpagado50;
  }

  async function actualizarEstadoContrato(idcontrato, estado) {
    const contrato = new FormData();
    contrato.append("operation", "actualizarEstadoContrato");
    contrato.append("idcontrato", idcontrato);
    contrato.append("estado", estado);

    const fcontrato = await fetch(`${host}contrato.controller.php`, {
      method: "POST",
      body: contrato,
    });
    const rcontrato = await fcontrato.json();
    return rcontrato;
  }

  async function registrarNotificacion(idusuariodest, idusuariorem, tipo, idreferencia, mensaje) {
    const viatico = new FormData();
    viatico.append("operation", "registrarNotificacion");
    viatico.append("idusuariodest", idusuariodest); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
    viatico.append("idusuariorem", idusuariorem); // id usuario envia la notificacion
    viatico.append("tipo", tipo);
    viatico.append("idreferencia", idreferencia);
    viatico.append("mensaje", mensaje);

    const fviatico = await fetch(`${host}notificacion.controller.php`, {
      method: "POST",
      body: viatico,
    });
    const rviatico = await fviatico.json();
    console.log("rivatico . ", rviatico)
    return rviatico;
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
          pageLength: 10,
          responsive: true,
          ordering: false, // 👈 Esto desactiva el ordenamiento en el frontend
          dom: '<"top"f>rt<"bottom"lip><"clear">',
          initComplete: function () {
            $(".dataTables_filter input").addClass('form-control form-control-sm');
          },
          processing: true, // Muestra un indicador de carga
          serverSide: true, // Activa la paginación en el servidor
          ajax: {
            url: `${host}detalleevento.controller.php`,
            type: "POST",
            data: function (d) {
              d.operation = "filtrarAtenciones";
              d.ncotizacion = $("#ncotizacion").val() || "";
              d.ndocumento = $("#ndocumento").val() || "";
            }
          },
          columns: [
            { data: "iddetalle_presentacion" },
            { data: "ncotizacion", defaultContent: "No aplica" },
            { data: "nom_usuario", defaultContent: "" },
            { data: "ndocumento", defaultContent: "" },
            { data: "razonsocial", defaultContent: "" },
            {
              data: "tipo_evento",
              render: function (data) {
                return data == 1 ? "Público" : data == 2 ? "Privado" : "";
              }
            },
            {
              data: "modalidad",
              render: function (data) {
                return data == 1 ? "Convenio" : data == 2 ? "Contrato" : "";
              }
            },
            { data: "fecha_presentacion" },
            {
              data: "estado",
              render: function (data) {
                return data == 1 ? "Activo" : data == 2 ? "Caducado" : "";
              }
            },
            { data: "opciones", orderable: false, searchable: true }
          ],
          lengthMenu: [5, 10, 15, 20],
          pageLength: 10,
          language: {
            lengthMenu: "Mostrar _MENU_ filas por página",
            paginate: {
              previous: "Anterior",
              next: "Siguiente",
            },
            search: "Buscar:",
            info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
            emptyTable: "No se encontraron registros",
          }
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
      if (x.id === "nomusuario") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
      if (x.id === "establecimiento") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
      if (x.id === "fechapresentacion") {
        x.addEventListener("change", async () => {
          await dataFilters();
        });
      }
      if (x.id === "año_semana") {
        x.addEventListener("change", async () => {
          await dataFilters();
        });
      }
      if (x.id === "mes") {
        x.addEventListener("change", async () => {
          await dataFilters();
        });
      }
    });
  }


  chargerEventsButton();

  async function dataFilters() {
    const params = new URLSearchParams();
    params.append("operation", "filtrarAtenciones");
    params.append("ncotizacion", $q("#ncotizacion").value ? $q("#ncotizacion").value : "");
    params.append("ndocumento", $q("#ndocumento").value ? $q("#ndocumento").value : "");
    params.append("nomusuario", $q("#nomusuario").value ? $q("#nomusuario").value : "")
    params.append("establecimiento", $q("#establecimiento").value ? $q("#establecimiento").value : "")
    params.append("fechapresentacion", $q("#fechapresentacion").value ? $q("#fechapresentacion").value : "")
    params.append("mes", $q("#mes").value || "")
    let semana = $q("#año_semana").value; // Captura el valor en formato "YYYY-WW"
    if (semana) {
      semana = semana.replace("-W", ""); // Convierte "2025-W10" en "202510"
    }
    params.append("añosemana", semana || "");

    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    console.log("data -> ", data);

    const tbody = $q("#table-atenciones tbody");
    tbody.innerHTML = "";

    if (data.length === 0) {
      tbody.innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
      return; // Salimos de la función si no hay datos
    }

    for (const x of data) {
      tbody.innerHTML += `
            <tr class="border-0">
                <td>${x.ncotizacion ? x.ncotizacion : 'no aplica'}</td>
                <td>${x.nom_usuario ? x.nom_usuario : ''}</td>


                <td>${x.establecimiento ? x.establecimiento : ``}</td>
                <td>${x.departamento ? x.departamento + "/" + x.provincia + "/" + x.distrito : x.establecimiento + "/" + x.pais}</td>
                <td>${formatearFecha(x.fecha_presentacion)}</td>                        
                
                <td>
                    ${idusuarioLogeado == 22 ? `
                      <button type="button" class="btn btn-sm btn-secondary btn-precioentrada" data-id=${x.iddetalle_presentacion} title="Precios de entrada">
                          Precios de entrada
                        </button>                      
                      <button type="button" class="btn btn-sm btn-primary btn-infoevento" data-id=${x.iddetalle_presentacion} title="Precios de entrada">
                          Info
                        </button> 
                        <button type="button" class="btn btn-sm btn-primary btn-actualizar" data-id=${x.iddetalle_presentacion} title="Actualizar Evento">
                        Actualizar
                      </button>                     
                      ` : x.estado_convenio == 3 ? 'Desaprobado' : x.estado == 3 ? `
                      <button type="button" class="btn btn-sm btn-primary btn-infoevento" data-id=${x.iddetalle_presentacion} title="Mas información">
                          Info
                        </button> 
                         <button type="button" class="btn btn-sm btn-danger btn-reactivar" data-id=${x.iddetalle_presentacion} title="Reactivar Evento">
                        Reactivar
                      </button>
                      <span class="text-danger">Cancelado</span>
                      ` : `
                        ${x.estado == 2 ? '' : parseInt(x.estado_convenio) == 2 ? `
                        <button type="button" class="btn btn-sm btn-warning btn-propuesta" data-idusuario="${x.idusuario}" data-fechapresentacion="${x.fecha_presentacion}" data-id=${x.iddetalle_presentacion} title="Detalles propuesta">
                            Detalles Propuesta
                        </button>
                        <button type="button" class="btn btn-sm btn-warning btn-convenio" data-id=${x.iddetalle_presentacion} title="Generar Convenio">
                            Generar Convenio
                        </button>
                    ` : parseInt(x.modalidad) == 1 ? `
                        <button type="button" class="btn btn-sm btn-warning btn-propuesta" data-idusuario="${x.idusuario}" data-fechapresentacion="${x.fecha_presentacion}" data-id=${x.iddetalle_presentacion} title="Detalles propuesta">
                            Detalles Propuesta
                        </button>
                        <button type="button" class="btn btn-sm btn-warning btn-convenio" data-id=${x.iddetalle_presentacion} title="Generar Convenio">
                            Generar Convenio
                        </button>
                        `  : parseInt(x.modalidad) == 2 ? `
                        <button type="button" class="btn btn-sm btn-success btn-cotizar" data-idnacionalidad="${x.idnacionalidad}" data-id=${x.iddetalle_presentacion} data-estado=${x.condicion} title="Cotizar">Cotizar</button>
                    ` : ``}

                    ${x.estado == 2 ? '' : parseInt(x.modalidad) === 2 ? `
                        <button type="button" class="btn btn-sm btn-secondary btn-pagar" data-idnacionalidad="${x.idnacionalidad}" data-id=${x.iddetalle_presentacion} title="Pagar">
                            Pagar
                        </button>
                        <button type="button" class="btn btn-sm btn-secondary btn-contrato" data-idnacionalidad="${x.idnacionalidad}" data-id=${x.iddetalle_presentacion} title="Generar contrato">
                            Generar Contrato
                        </button>
                    ` : ``}

                    ${x.estado == 2 ? '' : parseInt(x.pagado50) == 1 ? `` : parseInt(x.reserva) == 1 ? `
                        <button type="button" class="btn btn-sm btn-primary btn-reserva" data-id=${x.iddetalle_presentacion} title="Generar Reserva">
                            Generar Reserva
                        </button>
                    ` : ``}

                      ${x.tienecaja == 1 ? '' : x.modalidad == 1 ? '' : `<button type="button" class="btn btn-sm btn-warning btn-caja" data-id=${x.iddetalle_presentacion} title="Caja Chica">
                          Caja Chica  
                      </button> `
        }
                       ${x.modalidad == 1 ? `<button type="button" class="btn btn-sm btn-secondary btn-precioentrada" data-id=${x.iddetalle_presentacion} title="Precios de entrada">
                          Precios de entrada
                        </button>` : ''}
                      <button type="button" class="btn btn-sm btn-secondary btn-responsables" data-id=${x.iddetalle_presentacion} title="Elegir Responsables">
                          Responsables
                        </button>
                       <button type="button" class="btn btn-sm btn-primary btn-infoevento" data-id=${x.iddetalle_presentacion} title="Precios de entrada">
                          Info
                        </button> 
                    <button type="button" class="btn btn-sm btn-primary btn-actualizar" data-id=${x.iddetalle_presentacion} title="Actualizar Evento">
                        Actualizar
                      </button>
                    <button type="button" class="btn btn-sm btn-danger btn-cancelar" data-id=${x.iddetalle_presentacion} title="Cancelar Evento">
                        Cancelar
                      </button>
                    <button type="button" class="btn btn-sm btn-danger btn-borrar" data-id=${x.iddetalle_presentacion} title="Borrar Evento">
                        Borrar
                      </button>
                      `}
                </td>
            </tr>
        `;

      /* if (x.estado !== 3) {
        if (x.modalidad == 2) {
          if (x.validez !== null) {
            console.log("x.validez -> ", x.validez);
            const fechaCreacion = new Date(x.created_at + "T00:00:00");
            const fechaVencimiento = calcularFechaVencimiento(fechaCreacion, x.validez);

            console.log("Fecha de creación:", fechaCreacion.toISOString().split("T")[0]);
            console.log("Fecha de vencimiento:", fechaVencimiento.toISOString().split("T")[0]);

            if (esFechaVencida(fechaVencimiento)) {
              console.log("actualizando estado a vencido...");
              if (x.vigencia_reserva) {
                console.log("HAY UNA VIGENCIA EN RESERVA, AUN NO SE VENCERA LA PRESENTACION");
                const fechaCreacionReserva = new Date(x.fechacreada_reserva + "T00:00:00");
                const fechaVencimientoReserva = calcularFechaVencimiento(fechaCreacion, x.vigencia_reserva);

                console.log("Fecha de creación de reserva:", fechaCreacionReserva.toISOString().split("T")[0]);
                console.log("Fecha de vencimiento de reserva:", fechaVencimientoReserva.toISOString().split("T")[0]);

                if (esFechaVencida(fechaVencimientoReserva)) {
                  console.log("actualizando estado de contrato a caducado...");
                  const estadoContratoActualizado = await actualizarEstadoContrato(x.idcontrato, 3);
                  console.log("estado contrato actualizado a vencido -> ", estadoContratoActualizado);
                  const vencido = await actualizarEstadoDp(x.iddetalle_presentacion, 2);
                  console.log("vencido dp ?", vencido);
                } else {
                  console.log("aun no se vence el contrato");
                }
              }
              const vencido = await actualizarEstadoDp(x.iddetalle_presentacion, 2);
              console.log("vencido dp ?", vencido);
            } else {
              console.log("aun no se vence la presentacion registrada.");
            }
          }
        }
      } */
    }
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
          searching: true,
          ordering: false, // 👈 Esto desactiva el ordenamiento en el frontend

          lengthMenu: [20, 10, 15, 20],
          pageLength: 10,
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
          if (e.target.classList.contains("btn-propuesta")) {
            await buttonPropuesta(e);
          }
          if (e.target.classList.contains("btn-cotizar")) {
            await buttonCotizar(e);
          }
          if (e.target.classList.contains("btn-pagar")) {
            //ME QUEDE ACAAAAAAAAAAAAAA GAAAAAAAAAAAAAAAAAAAAAAAA
            await buttonPagar(e); //DESCOMENTAR LUEGO PRIMERO HACER DE QUE AL PAGAR EL 25% DEL MONTO TOTAL DE LA FACTURA EN SI OSEA EL TOTAL CON IGV INCLUIDO (SI ES QUE LO TIENE), ENTONCES SE DEBA PONER EL BOTON DE GENERAR RESERVA, Y LUEGO SI SE PAGA EL 50% DEL TOTAL DE LA FACTURA ENTONCES QUE YA SE PUEDA GENERAR EL CONTRATO
          }
          if (e.target.classList.contains("btn-contrato")) {
            await buttonContrato(e);
          }
          if (e.target.classList.contains("btn-reserva")) {
            await buttonReserva(e);
          }
          if (e.target.classList.contains("btn-convenio")) {
            await buttonConvenio(e);
          }
          if (e.target.classList.contains("btn-caja")) {
            await buttonCaja(e);
          }
          if (e.target.classList.contains("btn-actualizar")) {
            await buttonActualizar(e);
          }
          if (e.target.classList.contains("btn-cancelar")) {
            await buttonCancelar(e);
          }
          if (e.target.classList.contains("btn-responsables")) {
            await buttonResponsables(e);
          }
          if (e.target.classList.contains("btn-precioentrada")) {
            await buttonPrecioEntrada(e);
          }
          if (e.target.classList.contains("btn-infoevento")) {
            await buttonInfoEvento(e);
          }
          if (e.target.classList.contains("btn-reactivar")) {
            await buttonReactivar(e);
          }
          if (e.target.classList.contains("btn-borrar")) {
            await buttonBorrar(e);
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

  async function buttonInfoEvento(e) {
    iddp = e.target.getAttribute("data-id")
    modalInfoEvento = new bootstrap.Modal($q("#modal-infoevento"))
    modalInfoEvento.show()

    const dpInfo = await obtenerDPporId(iddp)
    console.log("dpInfo -> ", dpInfo);
    const ubicacion = dpInfo[0]?.esExtranjero == 0 ? dpInfo[0]?.departamento + "/" + dpInfo[0]?.provincia + "/" + dpInfo[0]?.distrito : dpInfo[0]?.establecimiento + "/" + dpInfo[0]?.pais

    const contenedorModal = $q(".contenedor-infoevento");
    contenedorModal.innerHTML = `
       <div class="mt-3">
            <h4 class="fw-bold">Promotor:</h4><br>
             <label class="fw-bold">Nombre/Razon Social:</label> <span id="noti-pasaje">${dpInfo[0]?.razonsocial ? dpInfo[0]?.razonsocial.toUpperCase() : 'Sin dato'}</span> <br>
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

  async function buttonReactivar(e) {
    iddp = e.target.getAttribute("data-id")
    window.localStorage.clear()
    if (await ask("¿Reactivar Evento?")) {
      const cancelado = await actualizarEstadoDp(iddp, 1)
      console.log("cancelado ?>???? ", cancelado);
    }
    await dataFilters()
    return
  }

  async function buttonBorrar(e) {
    iddp = e.target.getAttribute("data-id")
    if (await ask("¿Estas seguro de borrar el evento?")) {
      if (await ask("¿Estas seguro? (Confirmacion x2)")) {
        const borrado = await borrarEventoArtista(iddp)
        console.log("borrado ?>???? ", borrado);
        await dataFilters()
      }
    }
    await dataFilters()
    return
  }


  async function buttonCaja(e) {
    iddp = e.target.getAttribute("data-id")
    /* const dpActualizado = await actualizarCajaDP(iddp, 1)
    console.log("dpActualizado -> ", dpActualizado); */
    const cajaChicaExistente = await obtenerCajaChicaPorDP(iddp)
    console.log("caja chica existente -> ", cajaChicaExistente);
    if (cajaChicaExistente.length > 0) {

      if (cajaChicaExistente[0].idcajachica) {
        /* console.log("Caja chica registrada correctamente.");
        const viaticoGasto = await registrarGasto(cajaChicaExistente[0]?.idcajachica, descripcionGasto, totalViatico)
        console.log("viatico gasto -> ", viaticoGasto); */
        window.localStorage.clear()
        window.localStorage.setItem("idcajachica", cajaChicaExistente[0].idcajachica)
        window.location.href = `${hostOnly}/views/contabilidad/caja-chica/registrar-caja`
        return
      }
    } else {
      window.localStorage.clear()
      window.localStorage.setItem("iddp", iddp)
      window.location.href = `${hostOnly}/views/contabilidad/caja-chica/registrar-caja`
      return
      /* const viaticoCaja = await registrarCajaChica(iddp, 1, 0, 0, 0, 0)
      console.log("viaticoCaja -> ", viaticoCaja);
      if (viaticoCaja.idcajachica) {
        console.log("Caja chica registrada correctamente.");
        const viaticoGasto = await registrarGasto(viaticoCaja.idcajachica, descripcionGasto, totalViatico)
        console.log("viatico gasto -> ", viaticoGasto);
      } */
    }

  }

  async function buttonActualizar(e) {
    iddp = e.target.getAttribute("data-id")
    window.localStorage.clear()
    window.localStorage.setItem("iddp", iddp)
    window.location.href = `${hostOnly}/views/ventas/actualizar-atencion-cliente`
    return
  }

  async function buttonCancelar(e) {
    iddp = e.target.getAttribute("data-id")
    window.localStorage.clear()
    if (await ask("¿Estas seguro de cancelar el evento?")) {
      if (await ask("¿Estas seguro? (Confirmacion x2)")) {
        const cancelado = await actualizarEstadoDp(iddp, 3)
        console.log("cancelado ?>???? ", cancelado);
      }
    }
    await dataFilters()
    return
  }

  async function buttonResponsables(e) {
    iddp = e.target.getAttribute("data-id")
    /* window.localStorage.clear()
    if (await ask("¿Estas seguro de cancelar el evento?")) {
      if (await ask("¿Estas seguro? (Confirmacion x2)")) {
        const cancelado = await actualizarEstadoDp(iddp, 3)
        console.log("cancelado ?>???? ", cancelado);
      }
    }
    await dataFilters() */
    new bootstrap.Modal($q("#modal-responsables")).show()
    await obtenerUsuariosCerrarContrato()
    await obtenerUsuariosBoleteria()

    const responsables = await obtenerResponsableBoleteriaContrato(iddp)
    console.log("responsale -> ", responsables);
    $q("#boleteria").value = responsables[0]?.idusuarioBoleteria
    $q("#contrato").value = responsables[0]?.idusuarioContrato
    return
  }

  async function buttonPrecioEntrada(e) {
    iddp = e.target.getAttribute("data-id")
    window.localStorage.clear()
    console.log("abriendo...");
    new bootstrap.Modal($q("#modal-precioentrada")).show()
    const preciosevento = await obtenerPreciosEvento(iddp)

    /*     $q(".contenedor-admins-precio").innerHTML = ''
        admins.forEach(admin => {
          $q(".contenedor-admins-precio").innerHTML += `
              <div class="form-check">
                <input class="form-check-input chkAdmin" type="radio" name="adminSeleccionado" id="admin-${admin.idusuario}" data-idusuario="${admin.idusuario}">
                <label class="form-check-label" for="admin-${admin.idusuario}">${admin.nombres}</label>
              </div>
            `;
        }); */

    console.log("object -> ", preciosevento);
    $q("#entradas").value = preciosevento[0]?.entradas
  }

  $q("#btnGuardarResponsables").addEventListener("click", async () => {

    const responsables = await obtenerResponsableBoleteriaContrato(iddp)
    console.log("object -> ", responsables);
    if (responsables.length > 0) {

      const actualizado = await actualizarResponsableBoleteriaContrato(responsables[0]?.idresponsablecontrato, $q("#boleteria").value, $q("#contrato").value)
      console.log("new rsponsble boleteria -> ", $q("#boleteria").value);
      console.log("new rsponsble contrato -> ", $q("#contrato").value);
      console.log("actualizado ? -< ", actualizado);
      showToast("Responsable asignado correctamente", "SUCCESS")
      return
    } else {
      const responsableRegistrado = await registrarResponsableBoleteriaContrato(iddp, $q("#boleteria").value, $q("#contrato").value)
      console.log("responsableRegistrado _>", responsableRegistrado);
      showToast("Responsable asignado correctamente", "SUCCESS")
      return

    }
  })

  $q("#btnGuardarPrecioEntrada").addEventListener("click", async () => {

    const preciosevento = await obtenerPreciosEvento(iddp)
    console.log("object -> ", preciosevento);
    if (preciosevento.length > 0) {

      const actualizado = await actualizarPrecioEntradaEvento(preciosevento[0]?.idprecioentradaevento, $q("#entradas").value)
      console.log("input general -> ", $q("#entradas").value);
      console.log("actualizado ? -< ", actualizado);
      showToast("Precio asignado correctamente", "SUCCESS")
      return
    } else {
      const precioeventoregis = await registrarPrecioEvento(iddp, $q("#entradas").value)
      console.log("precioeventoregis _>", precioeventoregis);
      if (precioeventoregis) {
        const dpInfo = await obtenerDPporId(iddp)
        mensaje = `Se ha configurado precios para el evento de ${dpInfo[0]?.nom_usuario} - ${dpInfo[0]?.establecimiento} (${formatDate(dpInfo[0]?.fecha_presentacion)})`

        const admins = await obtenerUsuariosPorNivel(3)
        console.log("admins -> ", admins);
        admins.forEach(async admin => {
          const notificacionRegistrada = await registrarNotificacion(admin.idusuario, idusuarioLogeado, 5, iddp, mensaje)
          console.log("notificacion registrada-> ", notificacionRegistrada);
          enviarPusher(admin.idusuario, "entradas", mensaje)
        });

      }
      showToast("Precio asignado correctamente", "SUCCESS")
      return

    }
  })

  async function buttonConvenio(e) {
    idconvenio = e.target.getAttribute("data-id"); //esto en realidad es id detalle presentacion
    const convenioExiste = await obtenerConvenioPorIdDP(idconvenio)
    const dp = await obtenerDPporId(idconvenio);
    console.log("convenio esxite? -> ", convenioExiste)
    const convenio = await obtenerConvenioPorId(convenioExiste[0]?.idconvenio)
    console.log("CONVEIO OBTENIDO: ", convenio)
    if (convenio.length > 0) {
      if (convenio[0]?.estado == 2 || convenio[0]?.estado == 1) { // SI EL CONVENIO YA ESTA APROBADO
        const datosIncompletos = await verificarDatosIncompletosCliente(dp[0]?.idcliente);
        idcliente = dp[0]?.idcliente
        console.log("datosIncompletos -> ", datosIncompletos);

        // Verificar si es un array y tiene al menos un elemento
        if (!Array.isArray(datosIncompletos) || datosIncompletos.length === 0) { // me quede aca, falta implementar el de tipodoc = 2 ruc
          console.error("Error: datosIncompletos no es un array válido o está vacío", datosIncompletos);
          return;
        }

        let incompleto = false;
        const datosCliente = datosIncompletos[0]; // Extraer el primer objeto del array

        for (const clave in datosCliente) {
          if (datosCliente[clave] === null || datosCliente[clave] === "") {
            // Campos que siempre son opcionales
            const esCampoOpcional = ["telefono", "correo", "representantelegal"].includes(clave);

            if (!esCampoOpcional) {
              console.log("DATOS CLIENTE incompleto");
              incompleto = true;
              break;
            }
          }
        }

        console.log("incompleto? ??? : ", incompleto)
        if (incompleto) {
          console.log("datosCliente?.tipodoc -> ", datosCliente?.tipodoc);
          if (datosCliente?.tipodoc == 1) {
            $q("#container-representantelegal").hidden = true;
            modalDatosClienteIncompleto = new bootstrap.Modal(
              $q("#modal-datosclienteincompletos")
            );
            modalDatosClienteIncompleto.show();
            await renderizarDatosClienteIncompleto(datosCliente);
            return;
          }
          else if (datosCliente?.tipodoc == 2) {
            $q("#container-representantelegal").hidden = false;
            modalDatosClienteIncompleto = new bootstrap.Modal(
              $q("#modal-datosclienteincompletos")
            );
            modalDatosClienteIncompleto.show();
            await renderizarDatosClienteIncompleto(datosCliente);
            return;
          }
          else {
            console.log("entre aca pe");
            $q("#container-representantelegal").hidden = false;
            modalDatosClienteIncompleto = new bootstrap.Modal(
              $q("#modal-datosclienteincompletos")
            );
            modalDatosClienteIncompleto.show();
            await renderizarDatosClienteIncompleto(datosCliente);
            return;
          }
        }
        // ACA SALE ERROR AUNQWEU YA LLENE TODOS LOS DATOS AUN SIGUE SALIENDO EL MODAL PARA LLENAR LOS DATOS IN OMPLETOS
        const dataSucursales = await obtenerSucursales()

        $q("#sucursalDocumento").innerHTML = "<option value=''>Seleccione</option>"
        dataSucursales.forEach((sucursal) => {
          $q("#sucursalDocumento").innerHTML += `<option value="${sucursal.idsucursal}">${sucursal.nombre}</option>`;

        });
        modalpreviageneracion = new bootstrap.Modal($q("#modal-previageneracion"));
        modalpreviageneracion.show();
        $q("#sucursalDocumento").addEventListener("change", async (e) => {
          idsucursal = e.target.value

        })

        $q("#btnGenerarDocumento").addEventListener("click", async () => {
          window.open(
            `${hostOnly}/generators/generadores_pdf/contrato_convenio/contratoconvenio.php?idconvenio=${convenio[0]?.idconvenio}&idsucursal=${idsucursal}`
          );
          return
        })

      } else if (convenio[0]?.estado == 3) { // SI EL CONVENIO FUE DESAPROBADO
        showToast("La propuesta ha sido desaprobada", "ERROR");
        return
      }
      else { // SI AUN ESTA PENDIENTE LA APROBACION
        showToast("Aun no ha sido aprobada la propuesta del cliente", "ERROR");
        return
      }

    }
    else {
      showToast("Aun no hay propuestas del cliente", "ERROR");
      return
    }
    //iddetallepresentacion = idconvenio // esto en realidad es el iddetalle_presentacion
  }

  async function buttonPropuesta(e) {
    idpropuesta = e.target.getAttribute("data-id");
    idconvenio = e.target.getAttribute("data-id");
    iddetallepresentacion = e.target.getAttribute("data-id");
    idusuarioArtDest = e.target.getAttribute("data-idusuario")
    fechapresentacion = e.target.getAttribute("data-fechapresentacion")
    console.log("fechapresentacion desde button propuesta -> ", fechapresentacion);
    // limpiar campos

    $q("#abonogarantia").value = ''
    $q("#abonopublicidad").value = ''
    $q("#porcentajevega").value = ''
    $q("#porcentajepromotor").value = ''
    $q("#propuestacliente").value = ''

    const convenioExiste = await obtenerConvenioPorIdDP(idpropuesta)
    console.log("convenio esxite? -> ", convenioExiste)
    const convenio = await obtenerConvenioPorId(convenioExiste[0]?.idconvenio)
    console.log("CONVEIO OBTENIDO: ", convenio)
    const admins = await obtenerUsuariosPorNivel(3)
    console.log("admins -> ", admins);
    if (convenio.length > 0) {
      idconvenio = convenio[0]?.idconvenio
      $q("#abonogarantia").value = convenio[0]?.abono_garantia
      $q("#abonopublicidad").value = convenio[0]?.abono_publicidad
      $q("#propuestacliente").value = convenio[0]?.propuesta_cliente
      $q("#porcentajevega").value = convenio[0]?.porcentaje_vega
      $q("#porcentajepromotor").value = convenio[0]?.porcentaje_promotor
      //$q("#btnGuardarPendiente")?.hidden = true
      $q("#btnActualizarPropuesta").hidden = false
      $q("#btnEnviarPropuesta").hidden = true
      $q("#contenedor-general-admins").hidden = true
      iddetallepresentacion = idpropuesta // esto en realidad es el iddetalle_presentacion
      modalPropuestaCliente = new bootstrap.Modal($q("#modal-convenio"));
      modalPropuestaCliente.show();
      return
    } else {

      //$q("#btnGuardarPendiente")?.hidden = false
      $q("#btnActualizarPropuesta").hidden = true
      $q("#btnEnviarPropuesta").hidden = false
      $q("#contenedor-general-admins").hidden = false
      $q(".contenedor-admins").innerHTML = ''
      console.log("apunto de renderizar los admins ...");
      admins.forEach(admin => {
        $q(".contenedor-admins").innerHTML += `
          <div class="form-check">
            <input class="form-check-input chkAdmin" type="radio" name="adminSeleccionado" id="admin-${admin.idusuario}" data-idusuario="${admin.idusuario}">
            <label class="form-check-label" for="admin-${admin.idusuario}">${admin.nombres}</label>
          </div>
        `;
      });
      iddetallepresentacion = idpropuesta // esto en realidad es el iddetalle_presentacion
      modalPropuestaCliente = new bootstrap.Modal($q("#modal-convenio"));
      modalPropuestaCliente.show();
    }

  }

  async function buttonCotizar(e) {
    idcotizar = e.target.getAttribute("data-id");
    nacionalidadObtenida = e.target.getAttribute("data-idnacionalidad")
    console.log("nacionalidadObtenida -> ", nacionalidadObtenida);
    await renderizarUbigeoPresentacion(idcotizar);
    modalPreviaCotizacion = new bootstrap.Modal($q("#modal-previacotizacion"));
    modalPreviaCotizacion.show();
    const dataSucursales = await obtenerSucursales()

    $q("#sucursal").innerHTML = "<option value=''>Seleccione</option>"
    dataSucursales.forEach((sucursal) => {
      $q("#sucursal").innerHTML += `<option value="${sucursal.idsucursal}">${sucursal.nombre}</option>`;

    });

    $q("#sucursal").addEventListener("change", async (e) => {
      idsucursal = e.target.value
    })
  }

  async function buttonContrato(e) {
    let pagoAdelantadoO50 = false
    idcontrato = e.target.getAttribute("data-id");//esto en realidad es id detalle presentacion
    nacionalidadObtenida = e.target.getAttribute("data-idnacionalidad");//esto en realidad es id detalle presentacion
    const dp = await obtenerDPporId(idcontrato);
    idprovincia = dp[0]?.idprovincia
    idartista = dp[0]?.idusuario;
    idcliente = dp[0]?.idcliente;
    tipoevento = dp[0]?.tipo_evento;

    if (nacionalidadObtenida == "31") {
      const longlatCiudad = await obtenerLongLatPorCiudad(dp[0]?.departamento + ',' + dp[0]?.provincia)
      console.log("longlatCiudad->>>", longlatCiudad)
      const infoRecorrido = await obtenerDuracionDeViaje(lonOrigen, latOrigen, longlatCiudad[0]?.lon, longlatCiudad[0]?.lat)
      const duracionTiempoCrudo = infoRecorrido.routes[0]?.duration
      calcularDificultadPrecio = calcularPrecio(duracionTiempoCrudo)

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
          const cliente = await verificarDatosIncompletosCliente(dp[0]?.idcliente);
          const contratoExiste = await obtenerContratoPorDP(idcontrato); //esto en realidad es id detalle presentacion
          console.log(contratoExiste);
          idcontrato = contratoExiste[0]?.idcontrato
          console.log("idcontrato existente -> " + idcontrato)


          console.log(cliente);
          if (contratoExiste.length > 0) {
            let pago50 = false
            const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
            console.log("pagos -> ", pagos)
            pagosExistentes = pagos

            totalPagado = pagos.reduce((acumulador, pago) => acumulador + parseFloat(pago.monto), 0);

            console.log("Total pagado: ", totalPagado);


            pagos.forEach(pago => {
              if (pago?.estado == 3) {
                pago50 = true
              }
            });
            console.log("pago50 bool -> ", pago50)
            if (pago50) {
              const datosIncompletos = await verificarDatosIncompletosCliente(idcliente);
              console.log("datosIncompletos -> ", datosIncompletos);

              // Verificar si es un array y tiene al menos un elemento
              if (!Array.isArray(datosIncompletos) || datosIncompletos.length === 0) { // me quede aca, falta implementar el de tipodoc = 2 ruc
                console.error("Error: datosIncompletos no es un array válido o está vacío", datosIncompletos);
                return;
              }

              let incompleto = false;
              const datosCliente = datosIncompletos[0]; // Extraer el primer objeto del array

              for (const clave in datosCliente) {
                if (datosCliente[clave] === null || datosCliente[clave] === "") {
                  if (!(datosCliente.tipodoc == 1 && clave === "representantelegal")) {
                    console.log("DATOS CLIENTE incompleto")
                    incompleto = true;
                    break;
                  }
                }
              }
              console.log("incompleto? ??? : ", incompleto)
              if (incompleto) {
                if (datosCliente?.tipodoc == 1) {
                  $q("#container-representantelegal").hidden = true;
                  modalDatosClienteIncompleto = new bootstrap.Modal(
                    $q("#modal-datosclienteincompletos")
                  );
                  modalDatosClienteIncompleto.show();
                  console.log("supuestamente deberia renderizar");
                  await renderizarDatosClienteIncompleto(datosCliente);
                  return;
                }
                else if (datosCliente?.tipodoc == 2) {
                  $q("#container-representantelegal").hidden = false;
                  modalDatosClienteIncompleto = new bootstrap.Modal(
                    $q("#modal-datosclienteincompletos")
                  );
                  modalDatosClienteIncompleto.show();
                  await renderizarDatosClienteIncompleto(datosCliente);
                  return;
                }
                else {
                  $q("#container-representantelegal").hidden = false;
                  modalDatosClienteIncompleto = new bootstrap.Modal(
                    $q("#modal-datosclienteincompletos")
                  );
                  modalDatosClienteIncompleto.show();
                  await renderizarDatosClienteIncompleto(datosCliente);
                  return;
                }
              }

              const dataSucursales = await obtenerSucursales()

              $q("#sucursalDocumento").innerHTML = "<option value=''>Seleccione</option>"
              dataSucursales.forEach((sucursal) => {
                $q("#sucursalDocumento").innerHTML += `<option value="${sucursal.idsucursal}">${sucursal.nombre}</option>`;

              });
              modalpreviageneracion = new bootstrap.Modal($q("#modal-previageneracion"));
              modalpreviageneracion.show();
              $q("#sucursalDocumento").addEventListener("change", async (e) => {
                idsucursal = e.target.value

              })
              $q("#btnGenerarDocumento").addEventListener("click", async () => {
                window.open(
                  `${hostOnly}/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=${contratoExiste[0]?.idcontrato
                  }&idprovincia=${idprovincia}&idusuario=${idartista}&precio=${calcularDificultadPrecio?.costoDificultad}&idsucursal=${idsucursal}&idnacionalidad=${nacionalidadObtenida}&tipoevento=${tipoevento}`
                );
                return
              })
              return
            }
          }

          /* window.open(
            `${hostOnly}/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=${contrato[0]?.idcontrato
            }&idprovincia=${idprovincia}&idusuario=${idartista}&precio=${2500}`
          );
          return */
        }
      }
    } else {
      /* const longlatCiudad = await obtenerLongLatPorCiudad(dp[0]?.departamento + ',' + dp[0]?.provincia)
      console.log("longlatCiudad->>>", longlatCiudad)
      const infoRecorrido = await obtenerDuracionDeViaje(lonOrigen, latOrigen, longlatCiudad[0]?.lon, longlatCiudad[0]?.lat)
      const duracionTiempoCrudo = infoRecorrido.routes[0]?.duration
      calcularDificultadPrecio = calcularPrecio(duracionTiempoCrudo) */
      const tarifa = await obtenerTarifaArtistaPorPais(
        idartista,
        nacionalidadObtenida,
        tipoevento
      );

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
          const cliente = await verificarDatosIncompletosCliente(dp[0]?.idcliente);
          const contratoExiste = await obtenerContratoPorDP(idcontrato); //esto en realidad es id detalle presentacion
          console.log(contratoExiste);
          idcontrato = contratoExiste[0]?.idcontrato
          console.log("idcontrato existente -> " + idcontrato)


          console.log(cliente);
          if (contratoExiste.length > 0) {
            let pago50 = false
            const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
            console.log("pagos -> ", pagos)
            pagosExistentes = pagos

            totalPagado = pagos.reduce((acumulador, pago) => acumulador + parseFloat(pago.monto), 0);

            console.log("Total pagado: ", totalPagado);


            pagos.forEach(pago => {
              if (pago?.estado == 3) {
                pago50 = true
              }
            });
            console.log("pago50 bool -> ", pago50)
            if (pago50) {
              const datosIncompletos = await verificarDatosIncompletosCliente(idcliente);
              console.log("datosIncompletos -> ", datosIncompletos);

              // Verificar si es un array y tiene al menos un elemento
              if (!Array.isArray(datosIncompletos) || datosIncompletos.length === 0) { // me quede aca, falta implementar el de tipodoc = 2 ruc
                console.error("Error: datosIncompletos no es un array válido o está vacío", datosIncompletos);
                return;
              }

              let incompleto = false;
              const datosCliente = datosIncompletos[0]; // Extraer el primer objeto del array

              for (const clave in datosCliente) {
                if (datosCliente[clave] === null || datosCliente[clave] === "") {
                  if (!(datosCliente.tipodoc == 1 && clave === "representantelegal")) {
                    console.log("DATOS CLIENTE incompleto")
                    incompleto = true;
                    break;
                  }
                }
              }
              console.log("incompleto? ??? : ", incompleto)
              if (incompleto) {
                if (datosCliente?.tipodoc == 1) {
                  $q("#container-representantelegal").hidden = true;
                  modalDatosClienteIncompleto = new bootstrap.Modal(
                    $q("#modal-datosclienteincompletos")
                  );
                  modalDatosClienteIncompleto.show();
                  console.log("supuestamente deberia renderizar");
                  await renderizarDatosClienteIncompleto(datosCliente);
                  return;
                }
                else if (datosCliente?.tipodoc == 2) {
                  $q("#container-representantelegal").hidden = false;
                  modalDatosClienteIncompleto = new bootstrap.Modal(
                    $q("#modal-datosclienteincompletos")
                  );
                  modalDatosClienteIncompleto.show();
                  await renderizarDatosClienteIncompleto(datosCliente);
                  return;
                }
                else {
                  $q("#container-representantelegal").hidden = false;
                  modalDatosClienteIncompleto = new bootstrap.Modal(
                    $q("#modal-datosclienteincompletos")
                  );
                  modalDatosClienteIncompleto.show();
                  await renderizarDatosClienteIncompleto(datosCliente);
                  return;
                }
              }

              const dataSucursales = await obtenerSucursales()

              $q("#sucursalDocumento").innerHTML = "<option value=''>Seleccione</option>"
              dataSucursales.forEach((sucursal) => {
                $q("#sucursalDocumento").innerHTML += `<option value="${sucursal.idsucursal}">${sucursal.nombre}</option>`;

              });
              modalpreviageneracion = new bootstrap.Modal($q("#modal-previageneracion"));
              modalpreviageneracion.show();
              $q("#sucursalDocumento").addEventListener("change", async (e) => {
                idsucursal = e.target.value

              })
              $q("#btnGenerarDocumento").addEventListener("click", async () => {
                window.open(
                  `${hostOnly}/generators/generadores_pdf/contrato_presentacion/contratopresentacion.php?idcontrato=${contratoExiste[0]?.idcontrato
                  }&idprovincia=${idprovincia}&idusuario=${idartista}&precio=${tarifa[0]?.precioExtranjero}&idsucursal=${idsucursal}&idnacionalidad=${nacionalidadObtenida}&tipoevento=${tipoevento}`
                );
                return
              })
              return
            }
          }
        }
      }
    }

    showToast("Aun no puedes generar contrato hasta pagar el adelanto del 50%", "ERROR")
  }

  async function buttonReserva(e) {

    let pagoAdelantadoO25 = false
    idcontrato = e.target.getAttribute("data-id");
    const contrato = await obtenerContratoPorDP(idcontrato) //esto en realidad es id detalle presentacion
    const dp = await obtenerDPporId(idcontrato);
    idcliente = dp[0]?.idcliente;
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
          // verificar datos incompletos cliente 
          console.log("id cliente _> ", idcliente);
          const datosIncompletos = await verificarDatosIncompletosCliente(idcliente);
          console.log("datosIncompletos -> ", datosIncompletos);

          // Verificar si es un array y tiene al menos un elemento
          if (!Array.isArray(datosIncompletos) || datosIncompletos.length === 0) { // me quede aca, falta implementar el de tipodoc = 2 ruc
            console.error("Error: datosIncompletos no es un array válido o está vacío", datosIncompletos);
            return;
          }

          let incompleto = false;
          const datosCliente = datosIncompletos[0]; // Extraer el primer objeto del array

          for (const clave in datosCliente) {
            if (datosCliente[clave] === null || datosCliente[clave] === "") {
              if (!(datosCliente.tipodoc == 1 && clave === "representantelegal")) {
                console.log("DATOS CLIENTE incompleto")
                incompleto = true;
                break;
              }
            }
          }
          console.log("incompleto? ??? : ", incompleto)
          if (incompleto) {
            if (datosCliente?.tipodoc == 1) {
              $q("#container-representantelegal").hidden = true;
              modalDatosClienteIncompleto = new bootstrap.Modal(
                $q("#modal-datosclienteincompletos")
              );
              modalDatosClienteIncompleto.show();
              console.log("supuestamente deberia renderizar");
              await renderizarDatosClienteIncompleto(datosCliente);
              return;
            }
            else if (datosCliente?.tipodoc == 2) {
              $q("#container-representantelegal").hidden = false;
              modalDatosClienteIncompleto = new bootstrap.Modal(
                $q("#modal-datosclienteincompletos")
              );
              modalDatosClienteIncompleto.show();
              await renderizarDatosClienteIncompleto(datosCliente);
              return;
            }
            else {
              $q("#container-representantelegal").hidden = false;
              modalDatosClienteIncompleto = new bootstrap.Modal(
                $q("#modal-datosclienteincompletos")
              );
              modalDatosClienteIncompleto.show();
              await renderizarDatosClienteIncompleto(datosCliente);
              return;
            }
          }
          const dataSucursales = await obtenerSucursales()

          $q("#sucursalDocumento").innerHTML = "<option value=''>Seleccione</option>"
          dataSucursales.forEach((sucursal) => {
            $q("#sucursalDocumento").innerHTML += `<option value="${sucursal.idsucursal}">${sucursal.nombre}</option>`;

          });
          modalpreviageneracion = new bootstrap.Modal($q("#modal-previageneracion"));
          modalpreviageneracion.show();
          $q("#sucursalDocumento").addEventListener("change", async (e) => {
            idsucursal = e.target.value

          })
          $q("#btnGenerarDocumento").addEventListener("click", async () => {
            window.open(
              `${hostOnly}/generators/generadores_pdf/constancia_reserva/constanciareserva.php?iddetallepresentacion=${idcontrato}&idpagocontrato=${pagosContrato[0]?.idpagocontrato}&idsucursal=${idsucursal}` // esto en realida es el iddetalle_presentacion
            );
            console.log("Si existe la reserva")
            return
          })
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
    nacionalidadObtenida = e.target.getAttribute("data-idnacionalidad");
    const dp = await obtenerDPporId(iddp);
    idprovincia = dp[0]?.idprovincia;
    idartista = dp[0]?.idusuario;
    idcliente = dp[0]?.idcliente;
    igv = dp[0]?.igv;
    tipoevento = dp[0]?.tipo_evento;
    iddetallepresentacion = dp[0]?.iddetalle_presentacion;
    totalPagado = 0
    console.log(dp);
    const cliente = await verificarDatosIncompletosCliente(dp[0]?.idcliente);
    console.log(iddp);
    const contratoExiste = await obtenerContratoPorDP(iddp);
    console.log(contratoExiste);
    idcontrato = contratoExiste[0]?.idcontrato
    console.log("idcontrato existente -> " + idcontrato)

    if (nacionalidadObtenida == "31") {
      const longlatCiudad = await obtenerLongLatPorCiudad(dp[0]?.departamento + ',' + dp[0]?.provincia)
      console.log("longlatCiudad->>>", longlatCiudad)
      const infoRecorrido = await obtenerDuracionDeViaje(lonOrigen, latOrigen, longlatCiudad[0]?.lon, longlatCiudad[0]?.lat)
      const duracionTiempoCrudo = infoRecorrido.routes[0]?.duration
      calcularDificultadPrecio = calcularPrecio(duracionTiempoCrudo)

      console.log(cliente);
      if (contratoExiste.length > 0) {
        const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
        console.log("pagos -> ", pagos)
        pagosExistentes = pagos

        totalPagado = pagos.reduce((acumulador, pago) => acumulador + parseFloat(pago.monto), 0);

        console.log("Total pagado: ", totalPagado);

        // ESTO ES CUANDO ES 25%  
        modalDatosContrato = new bootstrap.Modal($q("#modal-contrato"));
        modalDatosContrato.show();
        console.log("aca se regsitrara el contrato apenas habra", contratoExiste)
        //$q("#btnGenerarReserva").hidden = false
        $q("#montoActual").innerHTML = `<label for="" class="text-primary">Monto actual pagado: ${totalPagado}</label>`;

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
    } else {
      /* const cotizacion = await obtenerCotizacion(iddetalleevento)
      const tarifaArtista = await obtenerTarifaArtistaPorPais(idartista, nacionalidadObtenida, tipoevento) */
      if (contratoExiste.length > 0) {
        const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
        console.log("pagos -> ", pagos)
        pagosExistentes = pagos

        totalPagado = pagos.reduce((acumulador, pago) => acumulador + parseFloat(pago.monto), 0);

        console.log("Total pagado: ", totalPagado);

        // ESTO ES CUANDO ES 25%  
        modalDatosContrato = new bootstrap.Modal($q("#modal-contrato"));
        modalDatosContrato.show();
        console.log("aca se regsitrara el contrato apenas habra", contratoExiste)
        //$q("#btnGenerarReserva").hidden = false
        $q("#montoActual").innerHTML = `<label for="" class="text-primary">Monto actual pagado: ${totalPagado}</label>`;

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


  }

  // ******************************************* VINCULANDO DATOS A MODALES ********************************

  async function renderizarUbigeoPresentacion(iddp) {
    const dp = await obtenerDPporId(iddp);
    console.log(dp);
    //alert("asdasdd")
    idprovincia = dp[0]?.idprovincia;
    idartista = dp[0]?.idusuario;
    provincia = dp[0]?.provincia;
    iddetalleevento = dp[0]?.iddetalle_presentacion;
    tipoevento = dp[0]?.tipo_evento
    console.log("nacionaldiad obtenida -> ", nacionalidadObtenida);
    if (nacionalidadObtenida == "31") {
      /* const longlatCiudad = await obtenerLongLatPorCiudad(dp[0]?.departamento + ',' + dp[0]?.provincia)
      console.log("longlatCiudad->>>", longlatCiudad)
      const infoRecorrido = await obtenerDuracionDeViaje(lonOrigen, latOrigen, longlatCiudad[0]?.lon, longlatCiudad[0]?.lat)
      const duracionTiempoCrudo = infoRecorrido.routes[0]?.duration
      calcularDificultadPrecio = calcularPrecio(duracionTiempoCrudo) */
      calcularDificultadPrecio = calcularPrecio(3600)
      console.log("calcularDificultadPrecio -> ", calcularDificultadPrecio);
      const cotizacion = await obtenerCotizacion(iddetalleevento)
      console.log("cotizacion -> ", cotizacion);
      const tarifaArtista = await obtenerTarifaArtistaPorProvincia(idprovincia, idartista, tipoevento)
      console.log("tipoevento del dp -> ", tipoevento);
      console.log("tipoevento de la tarifa aartista  -> ", tarifaArtista[0]?.tipo_evento);
      $q(".contenedor-cotizacion").hidden = false;
      $q(".contenedor-tarifa-extranjero").hidden = true;
      $q("#tInfoCotizacion").innerHTML = "";
      $q("#tInfoCotizacion").innerHTML = `
        <tr>
          <td>${dp[0]?.departamento}</td>
          <td>${dp[0]?.provincia}</td>
          <td>${calcularDificultadPrecio?.horasEstimadas}</td>
          <td>${calcularDificultadPrecio?.dificultad}</td>
          <td>${calcularDificultadPrecio?.costoDificultad}</td>
        </tr>
      `;
      $q(".contenedor-tarifa").hidden = false;

      $q("#tInfoDescripcionTarifa").innerHTML = "";
      $q("#tInfoDescripcionTarifa").innerHTML = `
      <tr>
        <td colspan="3">Puesto en la locacion de ${cotizacion[0]?.provincia_evento + "/" + cotizacion[0]?.departamento_evento}</td>
        <td>${calculateDuration(cotizacion[0]?.horainicio, cotizacion[0]?.horafinal)}</td>
        <td>${tipoevento == tarifaArtista[0]?.tipo_evento ? tarifaArtista[0]?.precio : `
          <div>
          <input type="text" id="tarifaCosto" name="tarifaCosto" class="form-control">
          <div class="form-floating">
              <select name="tipoevento" id="tipoevento" class="form-select" required>
                  <option value="">Seleccione</option>
                  <option value="1">Publico</option>
                  <option value="2">Privado</option>
              </select>
              <label for="tipoevento">Tipo</label>
          </div>
                    <i class="fa-solid fa-floppy-disk btnGuardarTarifa" title="Guardar" style="cursor: pointer;"></i>

          </div>
          `}</td>
      </tr>
    `;

    } else {
      // MODIFICAR ACA
      const cotizacion = await obtenerCotizacion(iddetalleevento)
      const tarifaArtista = await obtenerTarifaArtistaPorPais(idartista, nacionalidadObtenida, tipoevento)
      console.log(" tarifaArtista -> ", tarifaArtista);
      $q(".contenedor-cotizacion").hidden = true;
      $q(".contenedor-tarifa").hidden = true;
      $q(".contenedor-tarifa-extranjero").hidden = false;
      $q("#tInfoDescripcionTarifaExtranjero").innerHTML = `
        <tr>
          <td colspan="3">
            Puesto en la locacion de ${cotizacion[0]?.establecimiento + "/" + cotizacion[0]?.pais}
          </td>
          <td>
            ${calculateDuration(cotizacion[0]?.horainicio, cotizacion[0]?.horafinal)}
          </td>
          <td>
            ${tipoevento == tarifaArtista[0]?.tipo_evento
          ? (tarifaArtista[0]?.tipo_evento == 1
            ? "Público"
            : tarifaArtista[0]?.tipo_evento == 2
              ? "Privado"
              : "Desconocido")
          : `
                <div class="form-floating mb-2">
                  <select name="tipoevento" id="tipoevento" class="form-select w-100" required>
                    <option value="-1">Seleccione</option>
                    <option value="1">Publico</option>
                    <option value="2">Privado</option>
                  </select>
                  <label for="tipoevento">Tipo</label>
                </div>
              `
        }
          </td>
          <td>
            ${tipoevento == tarifaArtista[0]?.tipo_evento
          ? tarifaArtista[0]?.precio
          : `
                  <input type="text" id="tarifaCosto" name="tarifaCosto" class="form-control" placeholder="Costo">
                `
        }
          </td>
          <td>
            ${tipoevento == tarifaArtista[0]?.tipo_evento
          ? tarifaArtista[0]?.precioExtranjero
          : `
                  <input type="text" id="tarifaCostoViaje" name="tarifaCostoViaje" class="form-control" placeholder="Costo Viaje">
                `
        }
          </td>
          <td ${tarifaArtista[0]?.tipo_evento || tarifaArtista[0]?.precio || tarifaArtista[0]?.precioExtranjero ? "hidden" : ''}>
            <i class="fa-solid fa-floppy-disk btnGuardarTarifaExtranjero" title="Guardar" style="cursor: pointer;"></i>
          </td>
          
        </tr>

      `;
    }

    $q(".btnGuardarTarifa")?.addEventListener("click", async () => {
      console.log("nueva tarifa->", $q("#tarifaCosto").value);
      console.log("clickckc");
      if ($q("#tarifaCosto").value.trim() == "") {
        showToast("Agregue un costo!", "ERROR")
        return
      }
      const nuevaTarifa = await registrarTarifa(idartista, idprovincia, $q("#tarifaCosto").value, $q("#tipoevento").value, nacionalidadObtenida)
      console.log("nueva tariofa rregistrada -> ", nuevaTarifa);
      modalPreviaCotizacion.hide()
      $q("#tipoevento").value = ""
      showToast("Tarifa agregada!", "SUCCESS")
      return
    })

    $q(".btnGuardarTarifaExtranjero")?.addEventListener("click", async (e) => {
      //const idnacionalidad = e.target.getAttribute("data-idnacionalidad")
      console.log("id nacionalidad bglobal .-> ", nacionalidadObtenida);
      //console.log("idnacionalidad obtenido >", idnacionalidad);
      console.log("nueva tarifa de costo->", $q("#tarifaCosto").value);
      console.log("nueva tarifa de extranjero->", $q("#tarifaCostoViaje").value);
      console.log("clickckc");
      if ($q("#tarifaCostoViaje").value.trim() == "" || $q("#tarifaCosto").value.trim() == "" || $q("#tipoevento").value == "-1") {
        showToast("Complete los campos!", "ERROR")
        return
      }
      const nuevaTarifa = await registrarTarifa(idartista, idprovincia, $q("#tarifaCosto").value, $q("#tipoevento").value, nacionalidadObtenida, $q("#tarifaCostoViaje").value)
      console.log("nueva tariofa rregistrada -> ", nuevaTarifa);
      modalPreviaCotizacion.hide()
      $q("#tipoevento").value = ""
      $q("#tarifaCostoViaje").value = ""
      $q("#tarifaCosto").value = ""
      showToast("Tarifa agregada!", "SUCCESS")
      return
    })
  }

  async function renderizarDatosClienteIncompleto(cliente) {
    // renderiza los datos completos e incompletos a los campos del modal
    //console.log("RENDERIZANDO ESTA AAAAAAAAAAAAAAAAAAAA")
    $q("#ndocumentocli").value = cliente.ndocumento;
    $q("#razonsocial").value = cliente.razonsocial;
    $q("#representantelegal").value = cliente.representantelegal;
    $q("#telefono").value = cliente.telefono;
    $q("#correo").value = cliente.correo;
    $q("#direccion").value = cliente.direccion;
    //$q("#distrito").value = cliente.iddistrito;
    if (cliente.iddistrito) {
      await cargarUbigeoDesdeDistrito(cliente.iddistrito);
    }
  }

  async function cargarUbigeoDesdeDistrito(idDistrito) {
    try {
      // 1️⃣ Obtener datos del distrito
      let distrito = await fetch(`${host}recurso.controller.php?operation=obtenerDistritoPorId&iddistrito=${idDistrito}`).then(res => res.json());
      console.log("TODAS LAS DISTRTITOS OBTENIDOAS  -> ", distrito)

      // 2️⃣ Obtener todas las provincias y marcar la seleccionada
      let provincias = await fetch(`${host}recurso.controller.php?operation=obtenerTodosProvincias`).then(res => res.json());
      console.log("TODAS LAS PROVINCIAS OBTENIDOAS  -> ", provincias)
      let provinciaSeleccionada = provincias.find(p => p.idprovincia == distrito[0].idprovincia);
      console.log("LA PROVINCIA SELCCIONADA - ", provinciaSeleccionada)

      $q("#provincia").innerHTML = provincias.map(p =>
        `<option value="${p.idprovincia}" ${p.idprovincia === distrito[0].idprovincia ? "selected" : ""}>${p.provincia}</option>`
      ).join("");

      // 3️⃣ Obtener todas los departamentos y marcar el correcto
      let departamentos = await fetch(`${host}recurso.controller.php?operation=obtenerTodosDepartamentos`).then(res => res.json());
      console.log("TODOS LOS DEPARTAMENTOS OBTENIDOS -> ", departamentos)
      console.log("LA PROVINCIA SELCCIONADA - ", provinciaSeleccionada)
      let departamentoSeleccionado = departamentos.find(d => d.iddepartamento === provinciaSeleccionada.iddepartamento);
      console.log("DEPARTAMENTO SELCCIONADO -> ", departamentoSeleccionado)
      $q("#departamento").innerHTML = departamentos.map(d =>
        `<option value="${d.iddepartamento}" ${d.iddepartamento === provinciaSeleccionada.iddepartamento ? "selected" : ""}>${d.departamento}</option>`
      ).join("");

      // 4️⃣ Obtener todas las nacionalidades y marcar la correcta
      let nacionalidades = await fetch(`${host}recurso.controller.php?operation=obtenerTodosNacionalidades`).then(res => res.json());
      console.log("NACIONALIDADES TODAS OBTENIDAS : ", nacionalidades)
      let nacionalidadSeleccionada = nacionalidades.find(n => n.idnacionalidad === departamentoSeleccionado.idnacionalidad);
      $q("#nacionalidad").innerHTML = nacionalidades.map(n =>
        `<option value="${n.idnacionalidad}" ${n.idnacionalidad === departamentoSeleccionado.idnacionalidad ? "selected" : ""}>${n.nacionalidad}</option>`
      ).join("");

      // 5️⃣ Obtener todos los distritos y seleccionar el correcto
      let distritos = await fetch(`${host}recurso.controller.php?operation=obtenerTodosDistritos`).then(res => res.json());
      $q("#distrito").innerHTML = distritos.map(d =>
        `<option value="${d.iddistrito}" ${d.iddistrito === idDistrito ? "selected" : ""}>${d.distrito}</option>`
      ).join("");

    } catch (error) {
      console.error("Error cargando ubigeo:", error);
    }
  }

  //  ******************************************* EVENTOS *******************************************************


  $q("#btnActualizarDatosCliente").addEventListener("click", async () => {
    try {
      console.log("idcliente -> ", idcliente)
      console.log("valor direccion -> ", $q("#direccion").value)
      const clienteDatosActualizados = await actualizarCliente(idcliente) // me quede aca, falta exraewr el idcliente desdde antes de ir al btnactualizardatoscliewnte
      console.log("cliente datos aactuaizado=??? ", clienteDatosActualizados)
      if (clienteDatosActualizados) {
        console.log("Cliente actualizadoooooooooooo")
        showToast("Datos de cliente actualizado", "SUCCESS")
        modalDatosClienteIncompleto.hide()
        return
      } else {
        showToast("Un error ha ocurrido", "ERROR")
        return
      }
    } catch (error) {
      showToast("Un error ha ocurrido", "ERROR")
      return
    }
  })

  $q("#btnActualizarPropuesta").addEventListener("click", async () => {
    let abonoGarantia = parseFloat($q("#abonogarantia").value.trim());
    let abonoPublicidad = parseFloat($q("#abonopublicidad").value.trim());
    //let propuestaCliente = $q("#propuestacliente").value.trim();

    // Validaciones correctas
    if (
      isNaN(abonoGarantia) || abonoGarantia < 0 ||  // Verificar que sea un número y no sea negativo
      isNaN(abonoPublicidad) || abonoPublicidad < 0
      //propuestaCliente === ""  // Verificar que el campo no esté vacío
    ) {
      showToast("Ingrese valores válidos", "ERROR");
    } else {
      const convenioActualizado = await actualizarConvenio(idconvenio, 1)
      if (convenioActualizado.update) {
        showToast("Actualizado correctamente", "SUCCESS")
        return
      } else {
        showToast("Un error ha ocurrido", "ERROR")
        return
      }
    }

  })

  /* $q("#btnAprobarPropuesta").addEventListener("click", async () => {
    if (await ask('¿Estas seguro de aprobar la propuesta?')) {
      let abonoGarantia = parseFloat($q("#abonogarantia").value.trim());
      let abonoPublicidad = parseFloat($q("#abonopublicidad").value.trim());
      let porcentajevega = parseFloat($q("#porcentajevega").value.trim());
      let porcentajepromotor = parseFloat($q("#porcentajepromotor").value.trim());
      //let propuestaCliente = $q("#propuestacliente").value.trim();

      // Validaciones correctas
      if (
        isNaN(abonoGarantia) || abonoGarantia < 0 ||  // Verificar que sea un número y no sea negativo
        isNaN(abonoPublicidad) || abonoPublicidad < 0 ||
        isNaN(porcentajevega) || porcentajevega < 0 ||
        isNaN(porcentajepromotor) || porcentajepromotor < 0
        //propuestaCliente === ""  // Verificar que el campo no esté vacío
      ) {
        showToast("Ingrese valores válidos", "ERROR");
      } else {
        console.log("iddpppp ->", iddetallepresentacion)
        const convenioExiste = await obtenerConvenioPorIdDP(parseInt(iddetallepresentacion))
        console.log("convenio esxite? -> ", convenioExiste)
        //let idusuarioArtista = convenioExiste[0].idusuario
        const convenio = await obtenerConvenioPorId(convenioExiste[0]?.idconvenio)
        console.log("CONVEIO OBTENIDO: ", convenio)
        if (convenio.length > 0) {
          const convenioaprobado = await actualizarConvenio(idconvenio, 2)
          console.log("convenio aprobad? -> ", convenioaprobado)
          if (convenioaprobado?.update) {

            await dataFilters()
            const agendaEdicionRegistrada = await registrarAgendaEdicion(iddetallepresentacion)
            console.log("agendaEdicionRegistrada->", agendaEdicionRegistrada);
            modalPropuestaCliente.hide()

            showToast("Se ha aprobado la propuesta", "SUCCESS")
            return
          } else {
            showToast("Un error ha ocurrido", "ERROR")
            return
          }
        } else {
          const convenioRegistrado = await registrarConvenio(iddetallepresentacion, 2)
          // PONER EL REGISTRR AGENDA ASIGNACIONES aca tambien
          const agendaEdicionRegistrada = await registrarAgendaEdicion(iddetallepresentacion)
          console.log("agendaEdicionRegistrada->", agendaEdicionRegistrada);
          console.log("convenio registrado a aprobado:-> ", convenioRegistrado)
          if (convenioRegistrado?.idconvenio) {

            modalPropuestaCliente.hide()
            await dataFilters()
            showToast("Se ha aprobado la propuesta", "SUCCESS")
            return
          } else {
            showToast("Un error ha ocurrido", "ERROR")
            return
          }
        }

      }
    }
  }) */

  $q("#btnEnviarPropuesta").addEventListener("click", async () => {

    const seleccionado = document.querySelector('input[name="adminSeleccionado"]:checked');
    const convenioRegistrado = await registrarConvenio(iddetallepresentacion, 1)

    console.log("convenio registrado a pendiente:-> ", convenioRegistrado)
    console.log("clickeanod ");
    if (seleccionado) {
      if (convenioRegistrado?.idconvenio) {
        const idUsuarioSeleccionado = seleccionado.dataset.idusuario;
        console.log("ID del admin seleccionado:", idUsuarioSeleccionado);
        mensaje = "Una nueva propuesta ha llegado, haz click para revisarlo."
        const notificacionRegistrada = await registrarNotificacion(idUsuarioSeleccionado, idusuarioLogeado, 4, iddetallepresentacion, mensaje)
        console.log("notificacion registrada-> ", notificacionRegistrada);
        enviarPusher(idUsuarioSeleccionado, "propuesta", mensaje)
        modalPropuestaCliente.hide()
        //await dataFilters()
        showToast("Se ha enviado la propuesta", "SUCCESS")
        return
      } else {
        showToast("Un error ha ocurrido", "ERROR")
        return
      }
    } else {
      console.log("Ningún admin seleccionado.");
    }

  })

  $q("#btnGuardarPendiente")?.addEventListener("click", async () => {
    let abonoGarantia = parseFloat($q("#abonogarantia").value.trim());
    let abonoPublicidad = parseFloat($q("#abonopublicidad").value.trim());
    let porcentajevega = parseFloat($q("#porcentajevega").value.trim());
    let porcentajepromotor = parseFloat($q("#porcentajepromotor").value.trim());

    // Validaciones correctas
    if (
      isNaN(abonoGarantia) || abonoGarantia < 0 ||  // Verificar que sea un número y no sea negativo
      isNaN(abonoPublicidad) || abonoPublicidad < 0 ||
      isNaN(porcentajevega) || porcentajevega < 0 ||
      isNaN(porcentajepromotor) || porcentajepromotor < 0
      //propuestaCliente === ""  // Verificar que el campo no esté vacío
    ) {
      showToast("Ingrese valores válidos", "ERROR");
    } else {
      const convenioRegistrado = await registrarConvenio(iddetallepresentacion, 1)
      console.log("convenio registrado a pendiente:-> ", convenioRegistrado)
      if (convenioRegistrado?.idconvenio) {
        modalPropuestaCliente.hide()
        showToast("La propuesta se ha guardado en pendiente", "SUCCESS")
        return
      } else {
        showToast("Un error ha ocurrido", "ERROR")
        return
      }
    }
  })

  $q("#btnGuardarReserva").addEventListener("click", async (e) => {
    let vigencia = Number($q("#vigencia").value.trim()); // Convertimos a número

    // Verificamos que el valor sea un número válido y mayor a 0
    if (!isNaN(vigencia) && vigencia > 0) {
      const reservaGenerada = await registrarReserva(idpagocontrato, vigencia);
      console.log("reserva generada ->", reservaGenerada);

      if (reservaGenerada) {
        modalReserva?.hide();
        showToast("La reserva está lista para ser generada", "SUCCESS");
      }
    } else {
      showToast("Ingresa un valor válido", "ERROR");
      return
    }
  })

  $q("#btnGenerarCotizacion").addEventListener("click", async (e) => {

    console.log("clickeando");
    window.open(
      `${hostOnly}/generators/generadores_pdf/cotizacion/cotizacion.php?iddetallepresentacion=${iddetalleevento}&idprovincia=${idprovincia}&idusuario=${idartista}&provincia=${provincia}&tipoevento=${tipoevento}&idnacionalidad=${nacionalidadObtenida}&precio=${calcularDificultadPrecio?.costoDificultad}&idsucursal=${idsucursal}`
    );
    return;
  });

  // HACER APARECER UN LABEL QUE DIGA EL PORCENTAJE DE PAGO MIENTRAS SE VA DIGITANDO 
  $q("#montopagado").addEventListener("input", async () => {
    /*     const cotizacion = await obtenerCotizacion(iddetalleevento)
        const tarifaArtista = await obtenerTarifaArtistaPorPais(idartista, nacionalidadObtenida, tipoevento) */
    //console.log("pagosExistentes -[->", pagosExistentes)
    $q("#montoActual").innerHTML = `<label for="" class="text-primary">Monto actual pagado: ${totalPagado}</label>`;

    $q("#porciento").innerHTML = "";
    $q("#btnGuardar").hidden = false
    let precioFinal = -1;
    let precio25 = -1;
    let precio50 = -1;

    console.log("adasddadsadds");
    console.log("el tipo de evento al tipearse el monto a pagar : ", tipoevento);
    console.log("id artista al tipearse el monto a pagar : ", idartista);
    console.log("id idprovincia al tipearse el monto a pagar : ", idprovincia);
    if (nacionalidadObtenida == "31") {
      const tarifa = await obtenerTarifaArtistaPorProvincia(
        idprovincia,
        idartista,
        tipoevento
      );

      const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
      console.log("pagos -> ", pagos)


      console.log("tarifa->", tarifa);
      console.log("tarifa[0]?.precio -> ", tarifa[0]?.precio);
      console.log("calcularDificultadPrecio?.costoDificultad -> ", calcularDificultadPrecio?.costoDificultad);
      if (igv == 0) {
        precioFinal = parseFloat(tarifa[0]?.precio) + calcularDificultadPrecio?.costoDificultad;
      } else if (igv == 1) {
        precioFinal = (parseFloat(tarifa[0]?.precio) + calcularDificultadPrecio?.costoDificultad) * 1.18; // Se multiplica por 1.18 para agregar IGV
      }

      precio25 = precioFinal * 0.25;
      precio50 = precioFinal * 0.5;

      if (parseFloat($q("#montopagado").value) >= precio50 || totalPagado >= precio50) {
        console.log("pago del 50%");
        if (pagosExistentes.length == 0) {
          $q("#porciento").innerHTML =
            '<label for="" class="text-success"><small>Pago del 50%</small></label>';
          $q("#btnGuardar").hidden = false
        }
        $q("#btnGuardar").hidden = false
      } else if (parseFloat($q("#montopagado").value) >= precio25 || totalPagado >= precio25) {
        console.log("pago del 25%");
        if (pagosExistentes.length == 0) {
          $q("#porciento").innerHTML =
            '<label for="" class="text-success"><small>Pago del 25%</small></label>';
          $q("#btnGuardar").hidden = false
        }
        $q("#btnGuardar").hidden = false

      } else if ($q("#montopagado").value == 0) {
        console.log("no hay ningun pago")
        $q("#porciento").innerHTML = ''
      } // este ultimo else if no funciona.
    } else {
      const tarifa = await obtenerTarifaArtistaPorPais(
        idartista,
        nacionalidadObtenida,
        tipoevento
      );

      const pagos = await obtenerPagosContratoPorIdContrato(idcontrato)
      console.log("pagos -> ", pagos)


      console.log("tarifa->", tarifa);
      console.log("tarifa[0]?.precio -> ", tarifa[0]?.precio);
      console.log("calcularDificultadPrecio?.costoDificultad -> ", tarifa[0]?.precioExtranjero);
      if (igv == 0) {
        precioFinal = parseFloat(tarifa[0]?.precio) + parseFloat(tarifa[0]?.precioExtranjero);
      } else if (igv == 1) {
        precioFinal = (parseFloat(tarifa[0]?.precio) + parseFloat(tarifa[0]?.precioExtranjero)) * 1.18; // Se multiplica por 1.18 para agregar IGV
      }
      console.log("precioFinal -> ", precioFinal);
      precio25 = parseFloat(precioFinal) * 0.25;
      precio50 = parseFloat(precioFinal) * 0.5;

      if (parseFloat($q("#montopagado").value) >= precio50 || totalPagado >= precio50) {
        console.log("pago del 50%");
        if (pagosExistentes.length == 0) {
          $q("#porciento").innerHTML =
            '<label for="" class="text-success"><small>Pago del 50%</small></label>';
          $q("#btnGuardar").hidden = false
        }
        $q("#btnGuardar").hidden = false
      } else if (parseFloat($q("#montopagado").value) >= precio25 || totalPagado >= precio25) {
        console.log("pago del 25%");
        if (pagosExistentes.length == 0) {
          $q("#porciento").innerHTML =
            '<label for="" class="text-success"><small>Pago del 25%</small></label>';
          $q("#btnGuardar").hidden = false
        }
        $q("#btnGuardar").hidden = false

      } else if ($q("#montopagado").value == 0) {
        console.log("no hay ningun pago")
        $q("#porciento").innerHTML = ''
      } // este ultimo else if no funciona.
    }

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
    let tarifa;
    let precioBase;
    let precioExtra;

    console.log("adasddadsadds");
    console.log("el tipo de evento al guardarse el monto a pagar : ", tipoevento);

    if (nacionalidadObtenida == "31") {
      tarifa = await obtenerTarifaArtistaPorProvincia(idprovincia, idartista, tipoevento);
      precioExtra = calcularDificultadPrecio?.costoDificultad || 0;
    } else {
      tarifa = await obtenerTarifaArtistaPorPais(idartista, nacionalidadObtenida, tipoevento);
      precioExtra = parseFloat(tarifa[0]?.precioExtranjero) || 0;
    }

    console.log("tarifa ->", tarifa);

    precioBase = parseFloat(tarifa[0]?.precio) || 0;

    if (igv == 0) {
      precioFinal = precioBase + precioExtra;
    } else {
      precioFinal = (precioBase + precioExtra) * 1.18;
    }

    /*     console.log("tarifa->", tarifa);
    
        if (igv == 0) {
          precioFinal = parseFloat(tarifa[0]?.precio) + calcularDificultadPrecio?.costoDificultad;
        } else if (igv == 1) {
          precioFinal = (parseFloat(tarifa[0]?.precio) + calcularDificultadPrecio?.costoDificultad) * 1.18; // Se multiplica por 1.18 para agregar IGV
        } */

    precio25 = precioFinal * 0.25;
    precio50 = precioFinal * 0.5;
    console.log("totalPagado hasta ahora -> ", totalPagado);
    console.log("monto pagaado valor -> ", totalPagado);
    console.log("precio 25 -> ", precio25);
    console.log("precio 50 -> ", precio50);
    console.log("el monto valor pagado + el total pagado es IGUAL o MAYOR al precio50 ? ", (parseFloat($q("#montopagado").value) + totalPagado) >= precio50);
    console.log("el monto valor pagado + el total pagado es IGUAL o MAYOR al precio25 ? ", (parseFloat($q("#montopagado").value) + totalPagado) >= precio25);
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
                    const agendaEdicionRegistrada = await registrarAgendaEdicion(iddetallepresentacion)
                    console.log("agendaEdicionRegistrada->", agendaEdicionRegistrada);
                    /* const usuario = await obtenerUsuarioPorId(idusuarioLogeado)
                    mensaje = `${usuario[0]?.dato} Te ha asignado a un nuevo evento para el ${formatDate(fechapresentacion)}!, revisa tu agenda.`
                    const notificacionRegistrada = await registrarNotificacion(idusuarioArtDest, idusuarioLogeado, 2, null, mensaje)
                    console.log("notificacion registrada ? -> ", notificacionRegistrada) */
                    modalDatosContrato?.hide()
                    await dataFilters()
                    showToast("Pago guardado, ya puede generar el contrato.", "SUCCESS", 3000);
                  }
                }
              } else if (dp[0]?.pagado50 == 1) {
                if (pagoContrato.idpagocontrato) {
                  const agendaEdicionRegistrada = await registrarAgendaEdicion(iddetallepresentacion)
                  console.log("agendaEdicionRegistrada->", agendaEdicionRegistrada);
                  /* const usuario = await obtenerUsuarioPorId(idusuarioLogeado)
                  mensaje = `${usuario[0]?.dato} Te ha asignado a un nuevo evento para el ${formatDate(fechapresentacion)}!, revisa tu agenda.`
                  const notificacionRegistrada = await registrarNotificacion(idusuarioArtDest, idusuarioLogeado, 2, null, mensaje)
                  console.log("notificacion registrada ? -> ", notificacionRegistrada) */
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
                const estadoContratoActualizado = await actualizarEstadoContrato(idcontrato, 2)
                console.log("estadoContratoActualizado a pagado completamente -> ", estadoContratoActualizado)

                if (pagado50DP) {
                  const agendaEdicionRegistrada = await registrarAgendaEdicion(iddetallepresentacion)
                  console.log("agendaEdicionRegistrada->", agendaEdicionRegistrada);
                  /* const usuario = await obtenerUsuarioPorId(idusuarioLogeado)
                  mensaje = `${usuario[0]?.dato} Te ha asignado a un nuevo evento para el ${formatDate(fechapresentacion)}!, revisa tu agenda.`
                  const notificacionRegistrada = await registrarNotificacion(idusuarioArtDest, idusuarioLogeado, 2, null, mensaje)
                  console.log("notificacion registrada ? -> ", notificacionRegistrada) */
                  await dataFilters()
                  modalDatosContrato?.hide()
                  showToast("Pago guardado, ya puede generar el contrato.", "SUCCESS", 3000);
                }
              }
            } else if (dp[0]?.pagado50 == 1) {
              if (pagoContrato.idpagocontrato) {
                const estadoContratoActualizado = await actualizarEstadoContrato(idcontrato, 2)
                console.log("estadoContratoActualizado a pagado completamente -> ", estadoContratoActualizado)
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

                if (dpExiste[0]?.reserva == 0) {
                  const estadoReserva = await actualizarEstadoReservaDp(iddetallepresentacion, 1)
                  console.log("Estado reserva actualizado", estadoReserva)
                  await dataFilters()
                } else if (dpExiste[0]?.reserva == 1) {
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
              if (dpExiste[0]?.reserva == 0) {
                const estadoReserva = await actualizarEstadoReservaDp(iddetallepresentacion, 1)
                console.log("Estado reserva actualizado", estadoReserva)
                await dataFilters()
              } else if (dpExiste[0]?.reserva == 1) {

                return
              }
            }
          } else {
            showToast("Eliga una opcion de pago", "ERROR");
          }

          /* const idcontrato = await registrarContrato(iddetallepresentacion, 1);
          console.log("idcontrato > ", idcontrato)
           */

        } else {
          console.log("adelanto..");
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

                if (dpExiste[0]?.reserva == 0) {
                  const estadoReserva = await actualizarEstadoReservaDp(iddetallepresentacion, 1)
                  console.log("Estado reserva actualizado", estadoReserva)
                  await dataFilters()
                } else if (dpExiste[0]?.reserva == 1) {
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
              if (dpExiste[0]?.reserva == 0) {
                const estadoReserva = await actualizarEstadoReservaDp(iddetallepresentacion, 1)
                console.log("Estado reserva actualizado", estadoReserva)
                await dataFilters()
              } else if (dpExiste[0]?.reserva == 1) {

                return
              }
            }
          } else {
            showToast("Eliga una opcion de pago", "ERROR");
          }
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

  // *****************************************************************************************
  // *********************************** EVENTOS PARA RENDERIZAR UBIGEOS **********************************************************

  $q("#nacionalidad").addEventListener("change", async () => {
    console.log("wdasdlksadlksakldaldsakldnoasndksadlknsandasdsad")
    const departamentos = await obtenerDepartamentos($q("#nacionalidad").value);
    console.log("DEPARTAMENTOS OBTENIDOS : ", departamentos)
    $q("#departamento").innerHTML = "<option value=''>Selecciona</option>";
    departamentos.forEach(dpa => {
      $q("#departamento").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
    });
  });

  $q("#departamento").addEventListener("change", async () => {
    const provincias = await obtenerProvincias($q("#departamento").value);
    $q("#provincia").innerHTML = "<option value=''>Selecciona</option>";
    provincias.forEach(prv => {
      $q("#provincia").innerHTML += `<option value="${prv.idprovincia}">${prv.provincia}</option>`;
    });
  });

  $q("#provincia").addEventListener("change", async () => {
    const distritos = await obtenerDistritos($q("#provincia").value);
    $q("#distrito").innerHTML = "<option value=''>Selecciona</option>";
    distritos.forEach(dst => {
      $q("#distrito").innerHTML += `<option value="${dst.iddistrito}">${dst.distrito}</option>`;
    });
  });

});

