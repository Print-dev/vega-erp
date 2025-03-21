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
  if (nivelacceso == "Administrador") {
    obtenerNotificaciones();
  }

  // ******************************************* OBTENER DATOS *****************************************

  async function obtenerNotificaciones() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerNotificaciones");
    params.append("idusuariodest", 1);
    const notificaciones = await getDatos(
      `${host}notificacion.controller.php`,
      params
    );
    mostrarNotificaciones(notificaciones, 1); // cambiar esto luego
    
  }// ME QUEDE ACA

  async function obtenerUsuarioPorId(idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorId");
    params.append("idusuario", idusuario);
    const fpersona = await getDatos(`${host}usuario.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerInfoViatico(idviatico) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerInfoViatico");
    params.append("idviatico", idviatico);
    const fpersona = await getDatos(`${host}viatico.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  //* *********************************** RENDERIZACIONES *************************************************

  function mostrarNotificaciones(notificaciones, idusuario) {
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
      notificacionElemento.addEventListener("click", async () => {
        modalNotificacion = new bootstrap.Modal($q("#modal-notificacion"))
        modalNotificacion.show()
        const usuario = await obtenerUsuarioPorId(idusuario)
        const infoViatico = await obtenerInfoViatico(notificacion.idreferencia)
        console.log("infoviatico -< ", infoViatico);
        cargarNotificacionEnModal(notificacion, usuario[0], infoViatico[0]);
        console.log("usuario -> ", usuario)
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
        <label class="fw-bold">Artista:</label> <span id="noti-pasaje">${viatico.nom_usuario.toUpperCase()}</span> <br>
        <label class="fw-bold">Local:</label> <span id="noti-comida">${viatico.establecimiento.toUpperCase()}</span> <br>
        <label class="fw-bold">Fecha:</label> <span id="noti-viaje">${formatDate(viatico.fecha_presentacion)}</span> <br>
        <label class="fw-bold">Desde - hasta:</label> <span id="noti-viaje">${formatHour(viatico.horainicio)} - ${formatHour(viatico.horafinal)}</span> <br>
        <label class="fw-bold">Tiempo:</label> <span id="noti-viaje">${calculateDuration(viatico.horainicio, viatico.horafinal)}</span> <br>
        <label class="fw-bold">Ubicacion:</label> <span id="noti-viaje">${viatico.departamento}/${viatico.provincia}/${viatico.distrito}</span>
      </div>
      <hr>
      <div class="mt-3">
        <h4 class="fw-bold">Detalles Viatico:</h4><br>
        <label class="fw-bold">Pasaje:</label> <span id="noti-pasaje">${viatico.pasaje}</span> <br>
        <label class="fw-bold">Comida:</label> <span id="noti-comida">${viatico.comida}</span> <br>
        ${viatico.iddepartamento == 15 ? `` : `<label class="fw-bold">Viaje:</label> <span id="noti-viaje">${viatico.viaje}</span>`}
      </div>
    `;
  }


});
