document.addEventListener("DOMContentLoaded", async () => {
  let ws
  // Mantiene un indicador para saber si el WebSocket está listo para enviar
  let wsReady = false;

  let modalNotificacion
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

  // Inicializar Pusher
  const pusher = new Pusher('a42e1daecb05c59ee961', {
    cluster: 'us2',
    encrypted: true
  });

  // Suscribirte a un canal general
  const channel = pusher.subscribe('canal-notificaciones');

  // Lista de tipos de eventos que quieres escuchar
  const tiposEventos = [
    'evento',
    'viatico',
    'asignacion filmmaker',
    'notificacion',
    'propuesta',
    'entradas',
    ''
  ];
  /*   (async () => {
      ws = new WebSocket(`ws://localhost:8000`);
  
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



  console.log("NIVEL ACCESO USER LOGEADO --> ", nivelacceso);
  if (nivelacceso == "Administrador" || nivelacceso == "Artista" || nivelacceso == "Filmmaker") {
    obtenerNotificaciones();
  }

  $q("#show-all-notificaciones").addEventListener("click", async () => {
    obtenerTodasLasNotificaciones()
  })

  console.log("idusuarioLogeado desde el notify globsal -> ", idusuarioLogeado);

  // ****************************************** CONFIGURACION DE NOTIFICACIONE S*********************************

  function recibirNotificacionAPI(idusuario, body, type) {
    console.log("Notification.permission-> ", Notification.permission);
    console.log("idusuario desde recibir notificacion de api -> ", idusuario);
    console.log("idusuarioLogeado desde recibir notifacion de api -> ", idusuarioLogeado);
    if (Notification.permission === "granted") {
      if (idusuarioLogeado == idusuario) {
        new Notification(`¡Nueva ${type}!`, {
          body: body,
          icon: "https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/esawybumfjhhujupw5pa.png", // Puedes cambiar el icono
        });
        return
      }
    } else {
      console.log("El usuario no concedió permisos.");
    }
  }

  // ********************************************* WEBSCOKETS (AHORA PUSHER) **********************************************************
  console.log("antes de entrar al webscoekt!!!!!!!!!!!!!!!!!");

  tiposEventos.forEach(tipo => {
    channel.bind(tipo, async function (data) {
      console.log(`📢 Nueva notificación tipo ${tipo}:`, data);
      recibirNotificacionAPI(data?.idusuario, data?.mensaje, tipo);
      $q(".contenedor-notificacion").innerHTML = '';
      await obtenerNotificaciones();
      // alert(`🔔 ${data.mensaje}`); // si deseas notificar con popup
    });
  });
  /* ws.onmessage = async (event) => {
    try {
      console.log("antes de obtener la noti");
      //console.log("data solo con event -< ", JSON.parse(event));
      const data = JSON.parse(event.data);
      console.log("data -> ", data);

      if (data.type === "notificacion") {
        console.log("antes de recibir la notificacion api");
        recibirNotificacionAPI(data?.idusuario, data?.mensaje, data?.type)
        console.log("📢 Nueva notificación recibida:", data);
        $q(".contenedor-notificacion").innerHTML = ''
        await obtenerNotificaciones()
        // Aquí puedes mostrar la notificación en la UI
        //alert(`🔔 Nueva notificación: ${data.mensaje}`);
      }
      else if (data.type === "evento") {
        console.log("antes de recibir la notificacion api");
        recibirNotificacionAPI(data?.idusuario, data?.mensaje, data?.type)
        console.log("📢 Nueva notificación recibida:", data);
        $q(".contenedor-notificacion").innerHTML = ''
        await obtenerNotificaciones()
        // Aquí puedes mostrar la notificación en la UI
        //alert(`🔔 Nueva notificación: ${data.mensaje}`);
      }
      else if (data.type === "asignacion filmmaker") {
        console.log("antes de recibir la notificacion api");
        recibirNotificacionAPI(data?.idusuario, data?.mensaje, data?.type)
        console.log("📢 Nueva notificación recibida:", data);
        $q(".contenedor-notificacion").innerHTML = ''
        await obtenerNotificaciones()
        // Aquí puedes mostrar la notificación en la UI
        //alert(`🔔 Nueva notificación: ${data.mensaje}`);
      }
      else if (data.type === "viatico") {
        console.log("antes de recibir la notificacion api");
        recibirNotificacionAPI(data?.idusuario, data?.mensaje, data?.type)
        console.log("📢 Nueva notificación recibida:", data);
        $q(".contenedor-notificacion").innerHTML = ''
        await obtenerNotificaciones()
        // Aquí puedes mostrar la notificación en la UI
        //alert(`🔔 Nueva notificación: ${data.mensaje}`);
      }
      else if (data.type === "propuesta") {
        console.log("antes de recibir la notificacion api");
        recibirNotificacionAPI(data?.idusuario, data?.mensaje, data?.type)
        console.log("📢 Nueva notificación recibida:", data);
        $q(".contenedor-notificacion").innerHTML = ''
        await obtenerNotificaciones()
        // Aquí puedes mostrar la notificación en la UI
        //alert(`🔔 Nueva notificación: ${data.mensaje}`);
      }
      else if (data.type === "entradas") {
        console.log("antes de recibir la notificacion api");
        recibirNotificacionAPI(data?.idusuario, data?.mensaje, data?.type)
        console.log("📢 Nueva notificación recibida:", data);
        $q(".contenedor-notificacion").innerHTML = ''
        await obtenerNotificaciones()
        // Aquí puedes mostrar la notificación en la UI
        //alert(`🔔 Nueva notificación: ${data.mensaje}`);
      }
    } catch (error) {
      console.error("Error al procesar el mensaje WebSocket:", error);
    }
  }; */

  // ******************************************* ACTUALIZACION DE DATO **********************************************

  async function actualizarEstadoConvenio(idconvenio, estado) {
    const convenioupdate = new FormData();
    convenioupdate.append("operation", "actualizarEstadoConvenio");
    convenioupdate.append("idconvenio", idconvenio);
    convenioupdate.append("estado", estado);

    const fconvenioupdate = await fetch(`${host}convenio.controller.php`, {
      method: "POST",
      body: convenioupdate,
    });
    const rconvenioupdate = await fconvenioupdate.json();
    return rconvenioupdate;
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

  // ******************************************* OBTENER DATOS *****************************************

  async function obtenerNotificaciones() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerNotificaciones");
    params.append("idusuariodest", idusuarioLogeado);
    const notificaciones = await getDatos(
      `${host}notificacion.controller.php`,
      params
    );
    console.log("notificaciones -A> ", notificaciones);
    mostrarNotificaciones(notificaciones, idusuarioLogeado); // cambiar esto luego  (actualziacion hoy: ya se cambio)

  }

  async function obtenerTodasLasNotificaciones() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerTodasLasNotificaciones");
    params.append("idusuariodest", idusuarioLogeado);
    const notificaciones = await getDatos(
      `${host}notificacion.controller.php`,
      params
    );
    mostrarNotificaciones(notificaciones, idusuarioLogeado); // cambiar esto luego

  }

  async function obtenerUsuarioPorId(idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorId");
    params.append("idusuario", idusuario);
    const fpersona = await getDatos(`${host}usuario.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerInfoViaticoNotificacion(idusuario, idviatico) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerInfoViaticoNotificacion");
    params.append("idusuario", idusuario ? idusuario : '');
    params.append("idviatico", idviatico ? idviatico : '');
    const fpersona = await getDatos(`${host}viatico.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerNotificacionDP(idreferencia) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerNotificacionDP");
    params.append("idreferencia", idreferencia ? idreferencia : '');
    const fpersona = await getDatos(`${host}detalleevento.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerNotificacionDPIndividual(idreferencia) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerNotificacionDPIndividual");
    params.append("idreferencia", idreferencia ? idreferencia : '');
    const fpersona = await getDatos(`${host}detalleevento.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerNotificacionPropuesta(idreferencia) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerNotificacionPropuesta");
    params.append("idreferencia", idreferencia ? idreferencia : '');
    const fpersona = await getDatos(`${host}notificacion.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerNotificacionPorNivel(idreferencia) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerNotificacionPorNivel");
    params.append("idreferencia", idreferencia ? idreferencia : '');
    const fpersona = await getDatos(`${host}detalleevento.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  //* *********************************** RENDERIZACIONES *************************************************

  function mostrarNotificaciones(notificaciones, idusuario) {
    console.log("TODAS LAS NOTIFICACIONES ->", notificaciones);
    const contenedor = document.getElementById("list-notificaciones");
    contenedor.innerHTML = ""; // Limpiar el contenedor antes de agregar nuevas notificaciones
    console.log("notificaciinessss ->", notificaciones);
    if (notificaciones.length === 0) {
      contenedor.innerHTML = "<p>No hay notificaciones</p>";
      return;
    }

    notificaciones.forEach((notificacion) => {
      const tiempoTranscurrido = calcularTiempoTranscurrido(notificacion.fecha);

      const notificacionElemento = document.createElement("div");
      notificacionElemento.classList.add("notificacion-item"); // Puedes añadir estilos CSS
      notificacionElemento.innerHTML = `
            <p>${notificacion.mensaje}</p> 
            <span>${tiempoTranscurrido}</span>
        `;
      notificacionElemento.setAttribute("data-idreferencia", notificacion.idreferencia);

      // AQUI SE LE HACE CLICK PARA ABRIR EL MODAL
      notificacionElemento.addEventListener("click", async (e) => {
        const idNotificacion = parseInt(e.currentTarget.getAttribute("data-idreferencia"))

        if (notificacion.tipo == 1) { // esto sera para viaticos
          console.log("ID de la notificación:", idNotificacion);
          modalNotificacion = new bootstrap.Modal($q("#modal-notificacion"))
          modalNotificacion.show() // AQUI ABRE EL MODAL 
          const usuario = await obtenerUsuarioPorId(notificacion.idusuariorem)
          const infoViatico = await obtenerInfoViaticoNotificacion(null, idNotificacion) // ESTO ES UN SPU QUE SOLO BUSCA NOTIFICACIONES DE VIATICOSS
          // ACA AGREGAR LA FUNCION QUE OBTIENE LA DP POR SU ID, aca usamos la idreferencia de la notificacion
          console.log("infoviatico -< ", infoViatico);
          const viaticoEncontrado = infoViatico.find(v => v.idviatico === idNotificacion);

          if (viaticoEncontrado) {
            cargarNotificacionEnModal(notificacion, usuario[0], viaticoEncontrado);
            console.log("usuario -> ", usuario);
          } else {
            console.warn("No se encontró un viático para la notificación:", idNotificacion);
          }
        }

        else if (notificacion.tipo == 2) { // esto sera para eventos / detalles_presentacion
          console.log("id referencia .> ", idNotificacion);
          modalNotificacion = new bootstrap.Modal($q("#modal-notificacion"))
          modalNotificacion.show() // AQUI ABRE EL MODAL 
          const notificacionDP = await obtenerNotificacionDPIndividual(idNotificacion)
          //const notificacionDP = await obtenerNotificacionDP(idNotificacion)
          console.log("notiifacion dp clickeada -> ", notificacionDP);
          cargarNotificacionDpIndividualEnModal(notificacionDP[0])

        }
        else if (notificacion.tipo == 4) { // esto sera para propuestas
          console.log("mostrando modales de tipo 4");
          console.log("id referencia .> ", idNotificacion);
          modalNotificacion = new bootstrap.Modal($q("#modal-notificacion"))
          modalNotificacion.show() // AQUI ABRE EL MODAL 

          const notificacionPropuesta = await obtenerNotificacionPropuesta(idNotificacion)
          console.log("notiifacion dp clickeada -> ", notificacionPropuesta);
          cargarNotificacionPropuestaEnModal(notificacionPropuesta[0])

        }
        else if (notificacion.tipo == 6) { // esto sera para eventos / detalles_presentacion
          console.log("id referencia .> ", idNotificacion);
          modalNotificacion = new bootstrap.Modal($q("#modal-notificacion"))
          modalNotificacion.show() // AQUI ABRE EL MODAL 

          const notificacionDP = await obtenerNotificacionDP(idNotificacion)
          console.log("notiifacion dp clickeada -> ", notificacionDP);
          cargarNotificacionDpEnModal(notificacionDP[0])

        } // ME QUEDE ACA FALTA LISTAR LA S NOTIFICACIOINES PARA ASIGNACIONS FILMMAKER
      });

      contenedor.appendChild(notificacionElemento);
    });
  }

  function cargarNotificacionEnModal(notificacion, usuario, viatico) { // VIATICOS
    const fechahoraSeparada = notificacion?.fecha.split(" ")
    const contenedorModal = $q(".contenedor-notificacion");
    contenedorModal.innerHTML = `
      <p class="text-muted mb-2"><strong>${formatDate(fechahoraSeparada[0] + " " + formatHour(fechahoraSeparada[1]))}</strong></p>
      <p class="fw-bold">${usuario.dato} ${usuario.apellidos} - ${usuario.nivelacceso}</p>
      <hr>
      <div class="mt-3">
        <h4 class="fw-bold">Detalles evento:</h4><br>
        <label class="fw-bold">Artista:</label> <span id="noti-pasaje">${viatico.nom_usuario?.toUpperCase()}</span> <br>
        <label class="fw-bold">Local:</label> <span id="noti-comida">${viatico.establecimiento.toUpperCase()}</span> <br>
        <label class="fw-bold">Fecha:</label> <span id="noti-viaje">${formatDate(viatico.fecha_presentacion)}</span> <br>
        <label class="fw-bold">Desde - hasta:</label> <span id="noti-viaje">${formatHour(viatico.horainicio)} - ${formatHour(viatico.horafinal)}</span> <br>
        <label class="fw-bold">Tiempo:</label> <span id="noti-viaje">${calculateDuration(viatico.horainicio, viatico.horafinal)}</span> <br>
        <label class="fw-bold">Ubicacion:</label> <span id="noti-viaje">${viatico.departamento}/${viatico.provincia}/${viatico.distrito}</span>
      </div>
      <hr>
      <div class="mt-3">
        <h4 class="fw-bold">Detalles Viatico:</h4><br>
        <label class="fw-bold">Pasaje:</label> <span id="noti-pasaje">S/. ${viatico.pasaje ? viatico.pasaje : '0.00'}</span> <br>
        <label class="fw-bold">Hospedaje:</label> <span id="noti-hospedaje">S/. ${viatico.hospedaje ? viatico.hospedaje : '0.00'}</span> <br>
       
        <label class="fw-bold">Desayuno:</label> <span id="noti-desayuno"> ${viatico.desayuno ? 'Si (S/. 13.30)' : 'No'}</span> <br>
        <label class="fw-bold">Almuerzo:</label> <span id="noti-almuerzo">${viatico.almuerzo ? 'Si (S/. 13.30)' : 'No'}</span> <br>
        <label class="fw-bold">Cena:</label> <span id="noti-cena">${viatico.cena ? 'Si (S/. 13.30)' : 'No'}</span> <br>
        <label class="fw-bold">Total Viatico:</label> 
    <span id="noti-total">S/. ${redondear(
      (parseFloat(viatico.pasaje) || 0) +
      (parseFloat(viatico.hospedaje) || 0) +
      (viatico.desayuno ? 13.30 : 0) +
      (viatico.almuerzo ? 13.30 : 0) +
      (viatico.cena ? 13.30 : 0)
    )}</span> <br>

      </div>
    `;
  }

  function redondear(valor) {
    return parseFloat(valor || 0).toFixed(2);
  }

  function cargarNotificacionDpIndividualEnModal(notificacion) {
    const ubicacion = notificacion?.esExtranjero == 0 ? notificacion?.departamento +"/"+ notificacion?.provincia +"/"+ notificacion?.distrito : notificacion?.establecimiento +"/"+ notificacion?.pais
    console.log("notificacion en dp modal _> ", notificacion);
    const contenedorModal = $q(".contenedor-notificacion");
    contenedorModal.innerHTML = `
      <div class="mt-3">
            <h4 class="fw-bold">Detalles evento:</h4><br>
            <label class="fw-bold">Artista:</label> <span id="noti-pasaje">${notificacion.nom_usuario?.toUpperCase() ? notificacion.nom_usuario?.toUpperCase() : ''}</span> <br>
            <label class="fw-bold">Lugar:</label> <span id="noti-comida">${notificacion.establecimiento?.toUpperCase() ? notificacion.establecimiento?.toUpperCase() : ''}</span> <br>
            <label class="fw-bold">Fecha:</label> <span id="noti-viaje">${formatDate(notificacion?.fecha_presentacion) ? formatDate(notificacion?.fecha_presentacion) : ''}</span> <br>
            <label class="fw-bold">Desde - hasta:</label> <span id="noti-viaje">${formatHour(notificacion?.horainicio) ?? "0:00"} - ${formatHour(notificacion?.horafinal) ?? "0:00"}</span> <br>
            <label class="fw-bold">Tiempo:</label> <span id="noti-viaje">${calculateDuration(notificacion?.horainicio ?? "0:00", notificacion?.horafinal ?? "0:00")}</span> <br>
            <label class="fw-bold">Ubicacion:</label> <span id="noti-viaje">${ubicacion}</span>
          </div>    
    `;
  }
  function cargarNotificacionDpEnModal(notificacion) { // PARA SALIDAS Y RETORNO DE ARTISTAS
    console.log("notificacion en dp modal _> ", notificacion);
    const contenedorModal = $q(".contenedor-notificacion");
    contenedorModal.innerHTML = `
      <p class="text-muted mb-2"><strong>Fecha y hora de ${notificacion.tipo == 1 ? 'Salida' : 'Retorno'} - ${formatDate(notificacion.fecha)} - ${formatHour(notificacion.hora)})</strong></p>
      <p class="fw-bold">${notificacion.nom_usuario}</p>
      <hr>
      <div class="mt-3">
        <h4 class="fw-bold">Detalles evento:</h4><br>
        <label class="fw-bold">Artista:</label> <span id="noti-pasaje">${notificacion.nom_usuario?.toUpperCase()}</span> <br>
        <label class="fw-bold">Local:</label> <span id="noti-comida">${notificacion.establecimiento.toUpperCase()}</span> <br>
        <label class="fw-bold">Fecha:</label> <span id="noti-viaje">${formatDate(notificacion.fecha_presentacion)}</span> <br>
        <label class="fw-bold">Desde - hasta:</label> <span id="noti-viaje">${formatHour(notificacion.horainicio)} - ${formatHour(notificacion.horafinal)}</span> <br>
        <label class="fw-bold">Tiempo:</label> <span id="noti-viaje">${calculateDuration(notificacion.horainicio, notificacion.horafinal)}</span> <br>
        <label class="fw-bold">Ubicacion:</label> <span id="noti-viaje">${notificacion.departamento}/${notificacion.provincia}/${notificacion.distrito}</span>
      </div>      
    `;
  }

  function cargarNotificacionPropuestaEnModal(notificacion) {
    console.log("notificacion -> ", notificacion);
    const fechahoraSeparada = notificacion.fecha?.split(" ")
    console.log("fechahoraSeparada > ", fechahoraSeparada);
    const contenedorModal = $q(".contenedor-notificacion");
    contenedorModal.innerHTML = `
      <div class="card">
        <div class="card-body">
          <p class="text-muted mb-2"><strong>${formatDate(fechahoraSeparada[0] + " " + formatHour(fechahoraSeparada[1]))}</strong></p>
          <p class="fw-bold">Cliente: ${notificacion?.razonsocial}</p>
          <p class="fw-bold">Telefono: ${notificacion?.telefono ? notificacion?.telefono : 'Sin telefono'}</p>
          <hr>
          <div class="mt-3">
            <h4 class="fw-bold">Detalles evento:</h4><br>
            <label class="fw-bold">Artista:</label> <span id="noti-pasaje">${notificacion.nom_usuario?.toUpperCase() ? notificacion.nom_usuario?.toUpperCase() : ''}</span> <br>
            <label class="fw-bold">Local:</label> <span id="noti-comida">${notificacion.establecimiento?.toUpperCase() ? notificacion.establecimiento?.toUpperCase() : ''}</span> <br>
            <label class="fw-bold">Fecha:</label> <span id="noti-viaje">${formatDate(notificacion?.fecha_presentacion) ? formatDate(notificacion?.fecha_presentacion) : ''}</span> <br>
            <label class="fw-bold">Desde - hasta:</label> <span id="noti-viaje">${formatHour(notificacion?.horainicio) ?? "0:00"} - ${formatHour(notificacion?.horafinal) ?? "0:00"}</span> <br>
            <label class="fw-bold">Tiempo:</label> <span id="noti-viaje">${calculateDuration(notificacion?.horainicio ?? "0:00", notificacion?.horafinal ?? "0:00")}</span> <br>
            <label class="fw-bold">Ubicacion:</label> <span id="noti-viaje">${notificacion?.departamento}'${notificacion?.provincia}/${notificacion?.distrito}</span>
          </div>
          <hr>
          <div class="mt-3">
            <h4 class="fw-bold">Detalles Propuesta:</h4><br>
            <label class="fw-bold">Abono de garantia: </label> <span id="noti-pasaje">S/ ${notificacion?.abono_garantia ? notificacion?.abono_garantia : ''}</span> <br>
            <label class="fw-bold">Abono de publicidad:</label> <span id="noti-comida">S/ ${notificacion?.abono_publicidad ? notificacion?.abono_publicidad : ''}</span> <br>
            <h5><strong>Acuerdo (%): </strong></h5>
            <label class="fw-bold">Vega: </label> <span id="noti-pasaje">${notificacion?.porcentaje_vega ? notificacion?.porcentaje_vega : ''}%</span> <br>
            <label class="fw-bold">Promotor: </label> <span id="noti-pasaje">${notificacion?.porcentaje_promotor ? notificacion?.porcentaje_promotor : ''}%</span> <br>
            <h5><strong>Detalles: </strong></h5>
            <span>${notificacion?.propuesta_cliente ? notificacion?.propuesta_cliente : "Sin detalles."}</span>
          </div>      
        </div>
        <div class="card-footer">
        ${notificacion.estado == 1 ? `
          <button class="btn btn-secondary" data-bs-dismiss="modal" id="btnDesaprobar" >Desaprobar</button>
          <button class="btn btn-secondary" data-bs-dismiss="modal" id="btnAprobar">Aprobar</button>
          ` : notificacion.estado == 2 ? "Aprobada" : notificacion.estado == 3 ? "Desaprobado" : ''}
          
        </div>
      </div>
      
    `;

    $q("#btnAprobar")?.addEventListener("click", async () => {
      const convenioEstadoActualizado = await actualizarEstadoConvenio(notificacion.idconvenio, 2)
      console.log("estado convenio actualizdao ? -> ", convenioEstadoActualizado);

      // POSIBLEMENTE LUEGO SE DESCOMENTE LA PARTE DE REGISTRAR AGENDA EDICION CUANDO SE APRUEBE LA PROPUESTA 
      /* const agendaEdicionRegistrada = await registrarAgendaEdicion(notificacion.iddetalle_presentacion)
      console.log("agendaEdicionRegistrada->", agendaEdicionRegistrada); */

      /* const params = new URLSearchParams();
      params.append("operation", "aprobarPropuesta");
      params.append("idreferencia", idreferencia ? idreferencia : '');
      const fpersona = await getDatos(`${host}notificacion.controller.php`, params)
      console.log(fpersona);
      modalNotificacion.hide() */
      console.log("aprobando");
      showToast("Se aprobó la propuesta correctamente", "error")

      return
    })
    $q("#btnDesaprobar")?.addEventListener("click", async () => {
      const convenioEstadoActualizado = await actualizarEstadoConvenio(notificacion.idconvenio, 3)
      console.log("estado convenio actualizdao ? -> ", convenioEstadoActualizado);
      /* const params = new URLSearchParams();
      params.append("operation", "aprobarPropuesta");
      params.append("idreferencia", idreferencia ? idreferencia : '');
      const fpersona = await getDatos(`${host}notificacion.controller.php`, params)
      console.log(fpersona);
      modalNotificacion.hide() */
      console.log("desaprobando");
      showToast("Se desaprobó la propuesta correctamente", "error")
      return
    })

  }
});