document.addEventListener("DOMContentLoaded", async () => {
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

  console.log("NIVEL ACCESO USER LOGEADO --> ", nivelacceso);
  if (nivelacceso == "Administrador" || nivelacceso == "Artista") {
    obtenerNotificaciones();
  }

  $q("#show-all-notificaciones").addEventListener("click", async () => {
    obtenerTodasLasNotificaciones()
  })

  console.log("idusuarioLogeado desde el notify globsal -> ", idusuarioLogeado);

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

          const notificacionDP = await obtenerNotificacionDP(idNotificacion)
          console.log("notiifacion dp clickeada -> ", notificacionDP);
          cargarNotificacionDpEnModal(notificacionDP[0])

        }
      });

      contenedor.appendChild(notificacionElemento);
    });
  }

  function cargarNotificacionEnModal(notificacion, usuario, viatico) {
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

  function cargarNotificacionDpEnModal(notificacion) {
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


});
