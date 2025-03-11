document.addEventListener("DOMContentLoaded", async () => {
  //VARIABLES
  let agenda = [];

  //MODALES

  let modalInfoAgenda;

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

  // ****************************************** OBTENER DATOS **********************************************************

  (async () => {
    const niveles = await obtenerNiveles();
    $q("#nivelacceso").innerHTML = `<option value="">Selecciona</option>`;
    niveles.forEach((nivel) => {
      $q(
        "#nivelacceso"
      ).innerHTML += `<option value="${nivel.idnivelacceso}">${nivel.nivelacceso}</option>`;
    });
  })();

  async function obtenerAgendaArtista(idusuario, iddetalle_presentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerAgendaArtista");
    params.append("idusuario", idusuario ? idusuario : "");
    params.append(
      "iddetallepresentacion",
      iddetalle_presentacion ? iddetalle_presentacion : ""
    );
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
  }

  async function obtenerNiveles() {
    const data = await getDatos(
      `${host}recurso.controller.php`,
      "operation=obtenerNiveles"
    );
    console.log(data);
    return data;
  }

  async function obtenerArtistas() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorNivel");
    params.append("idnivelacceso", $q("#nivelacceso").value);
    const data = await getDatos(`${host}usuario.controller.php`, params);
    console.log(data);
    $q("#usuario").innerHTML = "<option value='-1'>Selecciona</option>";
    data.forEach((artista) => {
      $q(
        "#usuario"
      ).innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
    });
  }

  calendarEl = document.getElementById("calendar");
  const calendar = new FullCalendar.Calendar(calendarEl, {
    height: 700,
    initialView: "dayGridMonth", // Vista inicial (mes, semana, día)
    events: [],
    eventClick: async function (evento) {
      const idDetalle = evento.event.extendedProps.iddetalle_presentacion;
      await renderizarInfoAgenda(idDetalle);
      // Evento al hacer clic en una tarea
      modalInfoAgenda = new bootstrap.Modal($q("#modal-infoagendaartista"));
      modalInfoAgenda.show();
    },
  });
  calendar.render();
  calendar.setOption('locale', 'es');



  // ******************************************* EVENTOS *************************************************************

  $q("#nivelacceso").addEventListener("change", async () => {
    console.log("nivel ccceso escogido: ", $q("#nivelacceso").value);
    await obtenerArtistas();
  });

  $q("#usuario").addEventListener("change", async (e) => {
    const idUsuario = e.target.value;

    if (idUsuario === "-1") {
      return; // Si no se selecciona un usuario, no hacer nada
    }

    const agendaUsuario = await obtenerAgendaArtista(idUsuario);
    console.log("agendaUsuario todo obtenido ->",agendaUsuario)

    // Vaciar la lista de eventos
    agenda = [];

    // Convertir los datos de la agenda en eventos para FullCalendar
    agendaUsuario.forEach((evento) => {
      const esContratoValido = parseInt(evento.modalidad) === 2 && parseInt(evento.estadoContrato) === 2;
      const esConvenioValido = parseInt(evento.modalidad) === 1 && parseInt(evento.estado_convenio) === 2;
    
      let estadoBadge = {
        text: "No Confirmado",
        class: "badge bg-danger"
      };
    
      if (esContratoValido || esConvenioValido) {
        estadoBadge = {
          text: "Confirmado",
          class: "badge bg-success"
        };
      }
      agenda.push({
        title: evento.establecimiento, // Solo el nombre del lugar
        start: evento.fecha_presentacion, // Fecha de presentación
        iddetalle_presentacion: evento.iddetalle_presentacion, // Guardar el ID
        backgroundColor: "#ffcc00", // Color del fondo del evento (Naranja-Rojo)
        borderColor: "#ffcc00",
        textColor: "black",
        extendedProps: { estadoBadge } // Guardamos el estado como propiedad extra
      });
      // Si cumple con alguna de las condiciones, se agrega al calendario
      
    });
    
    // Limpiar eventos previos y agregar los nuevos al calendario
    calendar.removeAllEvents();
    calendar.addEventSource(agenda);
    
    // Personalizar la apariencia de los eventos para mostrar el badge
    calendar.setOption("eventContent", function(arg) {
      let estado = arg.event.extendedProps.estadoBadge;
      let badgeHtml = `<span class="${estado.class}">${estado.text}</span>`;
      
      return { html: `<div>${arg.event.title} ${badgeHtml}</div>` };
    });
  });

  async function renderizarInfoAgenda(iddp) {
    const dp = await obtenerAgendaArtista(null, iddp)
    console.log("dpppp-> ", dp)
    $q(".contenedor-info-agenda").innerHTML = ''
    dp.forEach(detp => {
      let formattedStart = formatHour(detp.horainicio);
      let formattedEnd = formatHour(detp.horafinal);
      $q(".contenedor-info-agenda").innerHTML += `
        <!-- Establecimiento -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <strong>Establecimiento/Lugar:</strong>
                            <p id="evento-establecimiento">${detp.establecimiento}</p>
                        </div>
                        <div class="col-md-6">
                            <strong>Referencia:</strong>
                            <p id="evento-referencia">${detp.referencia ? detp.referencia : 'Sin referencias'}</p>
                        </div>
                        
                    </div>

                    <hr>

                    <!-- Horario -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <strong>Tiempo:</strong>
                            <p id="evento-tiempo">${calculateDuration(detp.horainicio, detp.horafinal)}</p>
                        </div>
                        <div class="col-md-6">
                            <strong>Desde - Hasta:</strong>
                            <p id="evento-horario">${formattedStart} - ${formattedEnd}</p>
                        </div>
                        
                    </div>

                    <hr>

                    <!-- Ubicación y Referencia -->
                    <div class="row">
                        <div class="col-md-6">
                            <strong>Fecha de Presentación:</strong>
                            <p id="evento-fecha">${formatDate(detp.fecha_presentacion)}</p>
                        </div>
                        <div class="col-md-6">
                            <strong>Ubicación:</strong>
                            <p id="evento-ubicacion">${detp.departamento}/${detp.provincia}/${detp.distrito}</p>
                        </div>
                        
                    </div>
      `
    });
    
  }
});
