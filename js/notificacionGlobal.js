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
    obtenerNotificacionesViatico();
  }

  async function obtenerNotificacionesViatico() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerNotificacionesViatico");
    const notificaciones = await getDatos(
      `${host}notificacion.controller.php`,
      params
    );
    mostrarNotificaciones(notificaciones);
  }

  function mostrarNotificaciones(notificaciones) {
    const contenedor = document.getElementById("list-notificaciones");
    contenedor.innerHTML = ""; // Limpiar el contenedor antes de agregar nuevas notificaciones

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
      notificacionElemento.addEventListener("click", () => {
        modalNotificacion = new bootstrap.Modal($q("#modal-notificacion"))
        modalNotificacion.show()
      });

      contenedor.appendChild(notificacionElemento);
    });
  }

 
});
