document.addEventListener("DOMContentLoaded", async () => {
  //VARIABLES
  let agenda = [];
  let iddp = -1
  let idviatico = -1
  let iddepartamento = -1;
  let idprovincia = -1;
  let iddistrito = -1;

  console.log("idusuario logeado", idusuarioLogeado)

  console.log("NIVEL ACCESO DE USUARIO -> ",nivelacceso)
  //MODALES

  let modalInfoAgenda;
  let modalViatico;
  let modalAcuerdo
  let modalMonto;

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
    if(nivelacceso != "Artista"){
      const niveles = await obtenerNiveles();
      $q("#nivelacceso").innerHTML = `<option value="">Selecciona</option>`;
      niveles.forEach((nivel) => {
        $q(
          "#nivelacceso"
        ).innerHTML += `<option value="${nivel.idnivelacceso}">${nivel.nivelacceso}</option>`;
      });
    }
    

    
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

  async function obtenerTarifaArtistaPorProvincia(idprovincia, idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerTarifaArtistaPorProvincia");
    params.append("idprovincia", idprovincia);
    params.append("idusuario", idusuario);
    const fpersona = await getDatos(`${host}tarifa.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  // *************************************** REGISTRAR DATOS ***************************************************************

  async function registrarViatico(iddetallepresentacion) {

    const viatico = new FormData();
    viatico.append("operation", "registrarViatico");
    viatico.append("iddetallepresentacion", iddetallepresentacion); // id artista
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

  // ****************************************** CONFIGURACION DE CALENDARIO **********************************************************
  calendarEl = document.getElementById("calendar");
  const calendar = new FullCalendar.Calendar(calendarEl, {
    height: 700,
    initialView: "dayGridMonth", // Vista inicial (mes, semana, día)
    events: [],
    /* eventClick: async function (evento) {
      console.log("evento -> ", evento)
      const idDetalle = evento.event.extendedProps.iddetalle_presentacion;
      await renderizarInfoAgenda(idDetalle);
      // Evento al hacer clic en una tarea
      modalInfoAgenda = new bootstrap.Modal($q("#modal-infoagendaartista"));
      modalInfoAgenda.show();
    }, */
  });
  calendar.render();
  calendar.setOption("locale", "es");

  
  if(nivelacceso == "Artista"){
    $q("#nivelacceso").remove()
    $q("#usuario").remove()
    $q(".contenedor-filtros-agenda").remove()
    const agendaUsuario = await obtenerAgendaArtista(idusuarioLogeado);
    console.log("agendaUsuario todo obtenido ->", agendaUsuario);

    await configurarCalendario(agendaUsuario)
  }


  // **************************************** CONFIGURACION AGENDA **********************************************************

  async function configurarCalendario(agendaUsuario) {
    agenda = [];

    // Convertir los datos de la agenda en eventos para FullCalendar
    agendaUsuario.forEach((evento) => {
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

      if (esContratoValido || esConvenioValido) {
        estadoBadge = {
          text: "Confirmado",
          class: "badge bg-success",
        };
      }
      if (evento.estado == 1 && evento.idusuario == idusuarioLogeado || evento.idusuariofilmmaker == idusuarioLogeado || nivelacceso == "Administrador") {
        agenda.push({
          title: evento.nom_usuario, // Solo el nombre del lugar
          start: evento.fecha_presentacion, // Fecha de presentación
          iddetalle_presentacion: evento.iddetalle_presentacion, // Guardar el ID
          backgroundColor: "#ffcc00", // Color del fondo del evento (Naranja-Rojo)
          borderColor: "#ffcc00",
          textColor: "black",
          extendedProps: {
            estadoBadge,
            horainicio: evento.horainicio, // Asegurar que se pase
            horafinal: evento.horafinal,
            establecimiento: evento.establecimiento,
            iddepartamento: evento.iddepartamento,
            nombres: evento.nombres,
            idusuario: evento.idusuario,
            acuerdo: evento.acuerdo,
            idusuariofilmmaker: evento.idusuariofilmmaker,
            idcontrato: evento.idcontrato,
            idconvenio: evento.idconvenio,
          }, // Guardamos el estado como propiedad extra
        });
      }
      // Si cumple con alguna de las condiciones, se agrega al calendario
    });

    // Limpiar eventos previos y agregar los nuevos al calendario
    calendar.removeAllEvents();
    calendar.addEventSource(agenda);

    // Personalizar la apariencia de los eventos para mostrar el badge
    calendar.setOption("eventContent", function (arg) {
      console.log("Evento extendido:", arg.event.extendedProps); // Verificar los datos

      let horaInicio = arg.event.extendedProps.horainicio
        ? formatHour(arg.event.extendedProps.horainicio)
        : "Hora no definida";
      let horaFinal = arg.event.extendedProps.horafinal
        ? formatHour(arg.event.extendedProps.horafinal)
        : "Hora no definida";

      let estado = arg.event.extendedProps.estadoBadge;
      let badgeHtml = `<span class="${estado.class}">${estado.text}</span>`;

      return {
        html: `
          <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between;">
            <div>${horaInicio} - ${horaFinal}</div>
            <div>${badgeHtml}</div>
          </div>
          <div style="padding: 8px; word-wrap: break-word; 
          overflow-wrap: break-word;
          white-space: normal;">
            <div style="font-size: 20px; font-weight: bold;" class="mb-3">${arg.event.title
          }</div>
              <div><strong>Local:</strong> ${arg.event.extendedProps.establecimiento || "No definido"
          }</div>
              <div><strong>Tiempo:</strong> ${calculateDuration(
            arg.event.extendedProps.horainicio,
            arg.event.extendedProps.horafinal
          )}</div>
          ${nivelacceso == "Administrador" || arg.event.extendedProps.idusuariofilmmaker == idusuarioLogeado ? `
            <label class="mt-3"><strong>Acuerdos:</strong></label>
            <hr>
            <div style="
          background: #fff; 
          padding: 5px; 
          border-radius: 5px; 
          min-height: 100px;
          max-width: 100%; 
          word-wrap: break-word; 
          overflow-wrap: break-word;
          white-space: normal;
        ">
          ${arg.event.extendedProps.acuerdo ||
          "Sin acuerdos registrados"
          }
        </div>
            ` : ''}
              
        <hr>
            <div><strong>FILMMAKER:</strong> ${arg.event.extendedProps.nombres ? arg.event.extendedProps.nombres : 'No asignado'}</div>
            ${arg.event.extendedProps.idusuariofilmmaker == idusuarioLogeado ? `<button class="btn btn-primary mt-2" id="btnViatico" style="width: 100%;" data-iddp="${arg.event.extendedProps.iddetalle_presentacion}" data-iddepartamento="${arg.event.extendedProps.iddepartamento}">Reportar Viático</button>` : ''}          
            ${nivelacceso == "Administrador" ? `<button class="btn btn-primary mt-2" id="btnEditarAcuerdo" style="width: 100%;" data-iddp="${arg.event.extendedProps.iddetalle_presentacion}">Editar Acuerdo</button>` : ''}
            ${nivelacceso == "Artista" ? `<button class="btn btn-primary mt-2" id="btnVerMontos" style="width: 100%;" data-idcontrato="${arg.event.extendedProps?.idcontrato}" data-idconvenio="${arg.event.extendedProps?.idconvenio}">Ver Monto</button>` : ''}
          </div>
        `,
      };
    });
  }

  // ******************************************* EVENTOS *************************************************************

  $q("#nivelacceso")?.addEventListener("change", async () => {
    console.log("nivel ccceso escogido: ", $q("#nivelacceso").value);
    await obtenerArtistas();
  });

  $q("#usuario")?.addEventListener("change", async (e) => {
    const idUsuario = e.target.value;

    if (idUsuario === "-1") {
      return; // Si no se selecciona un usuario, no hacer nada
    }

    const agendaUsuario = await obtenerAgendaArtista(idUsuario);
    console.log("agendaUsuario todo obtenido ->", agendaUsuario);

    await configurarCalendario(agendaUsuario)

    // Vaciar la lista de eventos
    
  });

  document.addEventListener("click", async (e) => {
    if (e.target && e.target.id === "btnViatico") {
      iddp = e.target.getAttribute("data-iddp");
      iddepartamento = e.target.getAttribute("data-iddepartamento");
      console.log("ID DEPARTAMENTO ELEGIDO -> ", iddepartamento)
      console.log("iddetalle_repsentacion elegida -> ", iddp)

      modalViatico = new bootstrap.Modal($q("#modal-viatico"));
      modalViatico.show();
      await renderizarInfoAgenda(iddp, iddepartamento)
    }
    if(e.target && e.target.id === "btnEditarAcuerdo"){
      iddp = e.target.getAttribute("data-iddp");
      modalAcuerdo = new bootstrap.Modal($q("#modal-acuerdo"));
      modalAcuerdo.show();
      $q("#acuerdo").value = ""
      const acuerdoObtenido = await obtenerAcuerdo(iddp)
      console.log("acuerdoObtenido -> ", acuerdoObtenido)
      if(acuerdoObtenido.length > 0){
        $q("#acuerdo").value = acuerdoObtenido[0].acuerdo
      }
    }
    if(e.target && e.target.id === "btnVerMontos"){
      const idcontrato = e.target.getAttribute("data-idcontrato")
      const idconvenio = e.target.getAttribute("data-idconvenio")
      modalAcuerdo = new bootstrap.Modal($q("#modal-monto"));
      modalAcuerdo.show();
      
      console.log("idcontrato -> ", idcontrato)
      console.log("idconvenio -> ", idconvenio)
      //let monto = 0;
      if(idcontrato){
        $q(".contenedor-monto").innerHTML = ''
        const contrato = await obtenerContrato(idcontrato)
        console.log("contrato -> ", contrato)

        const tarifaArtista = await obtenerTarifaArtistaPorProvincia(contrato[0].idprovincia_evento, contrato[0].idusuario)
        console.log("tarifaArtista -> ", tarifaArtista)
        //monto = contrato[0].monto
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
                                <td>S/. ${tarifaArtista[0].precio}</td>
                                <td>S/. ${tarifaArtista[0].precio}</td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div> // ME QUEDA AAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA VERIFICAR pq no tenderiza en el htmlll
        `
      }
      if(idconvenio){
        $q(".contenedor-monto").innerHTML = ''
        const convenio = await obtenerContratoConvenio(idconvenio)
        console.log("convenio -> ", convenio)
        $q(".contenedor-monto").innerHTML = `
          <label class="form-label"><strong>Porcentaje promotor:</strong> ${convenio[0]?.porcentaje_promotor}%</label>
          </br>?
          <label class="form-label"><strong>Porcentaje Vega:</strong> ${convenio[0]?.porcentaje_vega}%</label>
        `
        //monto = convenio[0].monto
      }
//      showToast(`El monto a pagar es de S/. ${monto}`, "INFO")
    }
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
    if (isLima) {
      $q(".contenedor-viatico-viaje").hidden = true
    } else {
      $q(".contenedor-viatico-viaje").hidden = false
    }

  }

  $q("#btnGuardarAcuerdo").addEventListener("click", async () => {

    const acuerdoEditado = await editarAcuerdoEvento(iddp)
    console.log("ACUERDO EDITADO -> ", acuerdoEditado)
    if (acuerdoEditado) {
      showToast("Acuerdo editado correctamente", "SUCCESS")
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
    if (viaticoRegistrado.idviatico) {
      // PONER UNA SECCION ACA PARA NOTIFICAR QUE SE REGISTRO CORRECTAMENTE
      showToast("Viático registrado correctamente", "SUCCESS")
      modalViatico.hide()
    }
  })

  $q("#btnActualizarViatico").addEventListener("click", async () => {
    const viaticoActualizado = await actualizarViatico(idviatico)
    console.log("viaticoActualizado -> ", viaticoActualizado)
    if(viaticoActualizado.update){
      showToast("Viático actualizado correctamente", "SUCCESS")
      return
    }
  })
  


});
