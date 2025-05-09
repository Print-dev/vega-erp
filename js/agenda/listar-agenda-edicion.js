document.addEventListener("DOMContentLoaded", async () => {

    // VARIABLES 
    let agenda = []
    let idagendaeditor
    //let idagendaeditorFinal = -1

    //CALENDARIO
    let calendar
    let calendarEl;

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


    // ************************************** RENDERIZACION ************************************************************
    const usuarios = await obtenerUsuarios(10)
    console.log("usuarios editores- > ", usuarios);
    const usuariosFilmmaker = await obtenerUsuarios(11) // RAZON: LOS FILMMAKERS TMB SON EDITORES EN LA VIDA REAL POR LO QUE ASUMEN ESE ROL 
    console.log("usuariso filmmaker. >", usuariosFilmmaker);
    $q("#usuario").innerHTML = "<option value=''>Todos</option>";
    console.log("usuarios ->>>", usuarios);
    usuarios.forEach((editor) => {
        $q("#usuario").innerHTML += `<option value="${editor.idusuario}">${editor.nombres} (${editor.nom_usuario})</option>`;
    });
    usuariosFilmmaker.forEach((filmaker) => {
        $q("#usuario").innerHTML += `<option value="${filmaker.idusuario}">${filmaker.nombres} (${filmaker.nom_usuario})</option>`;
    });


    // ******************************************** OBTENER DATOS **********************************************************

    async function obtenerTareaVinculadaCManager(idagendaeditor) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTareaVinculadaCManager");
        params.append("idagendaeditor", idagendaeditor);
        const data = await getDatos(`${host}agendacmanager.controller.php`, params);
        console.log(data);
        return data

    }

    async function obtenerUsuarios(idnivelacceso) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", idnivelacceso);
        const data = await getDatos(`${host}usuario.controller.php`, params);
        console.log(data);
        return data

    }

    async function obtenerTareasEditor(idusuario) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTareasEditor");
        params.append("idusuario", idusuario ? idusuario : '');
        const data = await getDatos(`${host}agenda.controller.php`, params);
        return data
    }
    async function obtenerTodasLasTareasEnLaAgenda(idagendaedicion) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTodasLasTareasEnLaAgenda");
        params.append("idagendaedicion", idagendaedicion);
        const data = await getDatos(`${host}agenda.controller.php`, params);
        return data
    }

    async function obtenerUsuarioPorId(idusuario) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorId");
        params.append("idusuario", idusuario);
        const fpersona = await getDatos(`${host}usuario.controller.php`, params)
        console.log(fpersona);
        return fpersona
    }

    async function obtenerTareaPorUsuarioYagenda(idusuario, idagendaedicion) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTareaPorUsuarioYagenda");
        params.append("idusuario", idusuario);
        params.append("idagendaedicion", idagendaedicion);
        const data = await getDatos(`${host}agenda.controller.php`, params);
        return data;
    }

    async function obtenerUsuarioAsignado(idagendaedicion, idtipotarea) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioAsignado");
        params.append("idagendaedicion", idagendaedicion);
        params.append("idtipotarea", idtipotarea);
        const data = await getDatos(`${host}agenda.controller.php`, params);
        return data;
    }

    async function obtenerCmanagerPorIdAgendaEditor(idagendaeditor) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerCmanagerPorIdAgendaEditor");
        params.append("idagendaeditor", idagendaeditor);
        const data = await getDatos(`${host}agendacmanager.controller.php`, params);
        return data;
    }

    async function obtenerTodosTipoTarea() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTodosTipoTarea");
        const data = await getDatos(`${host}tipotarea.controller.php`, params);
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

    async function registrarTipoTarea(tipotarea) {
        const body = new FormData();
        body.append("operation", "registrarTipoTarea");
        body.append("tipotarea", tipotarea);

        const fbody = await fetch(`${host}tipotarea.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function asignarAgendaEditor(idagendaedicion, idusuario, idtipotarea, fechaentrega, horaentrega) { // CAMBIAR EL PARAMETRO TIPO TAREA
        const body = new FormData();
        body.append("operation", "asignarAgendaEditor");
        body.append("idagendaedicion", idagendaedicion); // id artista
        body.append("idusuario", idusuario);
        body.append("idtipotarea", idtipotarea);
        body.append("fechaentrega", fechaentrega);
        body.append("horaentrega", horaentrega);

        const fbody = await fetch(`${host}agenda.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function asignarAgendaEditor(idagendaedicion, idusuario, idtipotarea, fechaentrega, horaentrega) { // CAMBIAR EL PARAMETRO TIPO TAREA
        const body = new FormData();
        body.append("operation", "asignarAgendaEditor");
        body.append("idagendaedicion", idagendaedicion); // id artista
        body.append("idusuario", idusuario);
        body.append("idtipotarea", idtipotarea);
        body.append("fechaentrega", fechaentrega);
        body.append("horaentrega", horaentrega);

        const fbody = await fetch(`${host}agenda.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function registrarNuevoTipoTarea(tipotarea) { // CAMBIAR EL PARAMETRO TIPO TAREA
        const body = new FormData();
        body.append("operation", "registrarNuevoTipoTarea");
        body.append("tipotarea", tipotarea);

        const fbody = await fetch(`${host}agenda.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function actualizarEstadoTareaEdicion(idagendaeditor, estado) {
        const body = new FormData();
        body.append("operation", "actualizarEstadoTareaEdicion");
        body.append("idagendaeditor", idagendaeditor); // id artista
        body.append("estado", estado);

        const fbody = await fetch(`${host}agenda.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function actualizarEstadoAltoketicket(idagendaeditor, altoketicket) {
        const body = new FormData();
        body.append("operation", "actualizarEstadoAltoketicket");
        body.append("idagendaeditor", idagendaeditor); // id artista
        body.append("altoketicket", altoketicket);

        const fbody = await fetch(`${host}agenda.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function actualizarNombreTipoTarea(idtipotarea, tipotarea) {
        const body = new FormData();
        body.append("operation", "actualizarNombreTipoTarea");
        body.append("idtipotarea", idtipotarea); // id artista
        body.append("tipotarea", tipotarea);

        const fbody = await fetch(`${host}tipotarea.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function removerTipoTarea(idtipotarea) {
        const body = new FormData();
        body.append("operation", "removerTipoTarea");
        body.append("idtipotarea", idtipotarea); // id artista

        const fbody = await fetch(`${host}tipotarea.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function actualizarAgendaEditor(idagendaeditor, idusuario, idtipoentrega, fechaentrega, horaentrega) {
        const body = new FormData();
        body.append("operation", "actualizarAgendaEditor");
        body.append("idagendaeditor", idagendaeditor); // id artista
        body.append("idusuario", idusuario);
        body.append("idtipoentrega", idtipoentrega);
        body.append("fechaentrega", fechaentrega);
        body.append("horaentrega", horaentrega);

        const fbody = await fetch(`${host}agenda.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function eliminarTareaUsuario(idagendaeditor) {
        const viatico = new FormData();
        viatico.append("operation", "eliminarTareaUsuario");
        viatico.append("idagendaeditor", idagendaeditor);

        const fviatico = await fetch(`${host}agenda.controller.php`, {
            method: "POST",
            body: viatico,
        });
        const rviatico = await fviatico.json();
        return rviatico;
    }

    async function quitarResponsablePosteo(idagendaeditor) {
        const viatico = new FormData();
        viatico.append("operation", "quitarResponsablePosteo");
        viatico.append("idagendaeditor", idagendaeditor);

        const fviatico = await fetch(`${host}agendacmanager.controller.php`, {
            method: "POST",
            body: viatico,
        });
        const rviatico = await fviatico.json();
        return rviatico;
    }

    async function registrarNotificacion(idusuariorem, tipo, idviatico, mensaje) {
        const viatico = new FormData();
        viatico.append("operation", "registrarNotificacion");
        viatico.append("idusuariodest", 1); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
        viatico.append("idusuariorem", idusuariorem); // id usuario envia la notificacion
        viatico.append("tipo", tipo);
        viatico.append("idreferencia", idviatico);
        viatico.append("mensaje", mensaje);

        const fviatico = await fetch(`${host}notificacion.controller.php`, {
            method: "POST",
            body: viatico,
        });
        const rviatico = await fviatico.json();
        console.log("rivatico . ", rviatico)
        return rviatico;
    }

    async function registrarAgendaCManager(idagendaeditor, idusuariocmanager) {
        const body = new FormData();
        body.append("operation", "registrarAgendaCManager");
        body.append("idagendaeditor", idagendaeditor); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegible
        body.append("idusuariocmanager", idusuariocmanager);

        const fbody = await fetch(`${host}agendacmanager.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        console.log("body . ", rbody)
        return rbody;
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

    calendar = new FullCalendar.Calendar(calendarEl, {
        height: "99%",
        aspectRatio: 2,
        initialView: "dayGridMonth", // Vista inicial: mes
        dayMaxEvents: 5,
        headerToolbar: {
            left: "prev,next today",
            center: "title",
            right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth", // Filtros de vista
        },
        events: [], // Aquí se cargarán los eventos dinámicamente
        locale: "es",
        eventLimitClick: "popover", // Muestra un popover con los eventos restantes
        eventClick: async function (evento) {
            console.log("evento -> ", evento)
            //
            const btnSubirTarea = evento.jsEvent.target.closest("#btnSubirTarea");
            if (btnSubirTarea) {
                const idagendaeditor = btnSubirTarea.getAttribute("data-idagendaeditor");
                window.localStorage.clear()
                window.localStorage.setItem("idagendaeditor", idagendaeditor)
                window.location.href = `${hostOnly}/views/agenda/subir-contenido-edicion` //me quede acaaaa
                return
            }
            const btnVerProgresoIndividual = evento.jsEvent.target.closest("#btnVerProgresoIndividual")
            if (btnVerProgresoIndividual) {
                //const idagendaeditor = btnSubirTarea.getAttribute("data-idagendaeditor");
                const idagendaedicion = btnVerProgresoIndividual.getAttribute("data-idagendaedicion");
                const idusuarioEdicion = btnVerProgresoIndividual.getAttribute("data-idusuario");
                console.log("idusuario --> ", idusuarioEdicion);
                modalProgresoEdicion = new bootstrap.Modal($q("#modal-progresoedicion"));
                modalProgresoEdicion.show();

                const editoresAsignados = await obtenerEditoresAsignados(idagendaedicion)
                console.log("editoresAsignados ->", editoresAsignados);

                $q(".contenedor-tareas-edicion-pendientes").innerHTML = ``
                editoresAsignados.forEach(editor => {
                    const [fechaActual, horaActual] = obtenerFechaHoraPeru();
                    const fechaHoraString = `${fechaActual} ${horaActual.trim().replace('a.m.', 'AM').replace('p.m.', 'PM')}`;
                    const fechaHoraActual = new Date(fechaHoraString);
                    console.log("fechaHoraActual -> ,", fechaHoraActual);

                    // Crear objeto Date de la hora de entrega
                    const fechaHoraEntrega = new Date(`${editor.fecha_entrega} ${editor.hora_entrega}`);
                    console.log("fechaHoraEntrega -> ,", fechaHoraEntrega);
                    // Verificar si la tarea está atrasada
                    const tareaAtrasada = fechaHoraActual > fechaHoraEntrega;
                    console.log("tarea atrasada -> ", tareaAtrasada);
                    // Agregar clase de fondo rojo si está atrasada
                    const claseAtraso = tareaAtrasada ? 'bg-danger text-white' : '';
                    if (editor.idusuario == idusuarioEdicion) {
                        console.log("tipo de tareas para los editores asignados-> ", editor.tipotarea);
                        $q(".contenedor-tareas-edicion-pendientes").innerHTML += `
            <tr class="${claseAtraso}">
                <td>${editor.fecha_entrega} - ${formatHour(editor.hora_entrega)}</td>
                <td>${editor.nombres}</td>
                <td>${editor.tipotarea ? editor.tipotarea : 'No especificado'}</td>

                ${nivelacceso == "Administrador" ? `
                    <td>
                        <select name="altoketicket" class="form-select select-altoketicket" data-idagendaeditor="${editor.idagendaeditor}">
                            <option value="1" ${editor.altoketicket == 1 ? 'selected' : ''}>Pendiente</option>
                            <option value="2" ${editor.altoketicket == 2 ? 'selected' : ''}>Completado</option>
                        </select>
                    </td>
                    <td>
                        <select name="estado" class="form-select select-estado" data-idagendaeditor="${editor.idagendaeditor}">
                            <option value="1" ${editor.estado == 1 ? 'selected' : ''}>Pendiente</option>
                            <option value="2" ${editor.estado == 2 ? 'selected' : ''}>Completado</option>
                        </select>
                    </td>
                        ` : `
                        <td>${editor.altoketicket == 1 ? 'Pendiente' : editor.altoketicket == 2 ? 'Completado' : ''}</td>
                        <td>${editor.estado == 1 ? 'Pendiente' : editor.estado == 2 ? 'Completado' : ''}</td>`}
                <td>
                    <button type="button" class="btn btn-primary" id="btnVerContenido" data-idagendaeditor="${editor.idagendaeditor}">Ver</button>
                </td>        
            </tr>       
            `
                    }

                });
                $all("#btnVerContenido").forEach(btn => {
                    btn.addEventListener("click", (e) => {
                        idagendaeditor = e.target.getAttribute("data-idagendaeditor")
                        console.log("id agenda edicion -> ", idagendaeditor);
                        window.localStorage.clear()
                        window.localStorage.setItem("idagendaeditor", idagendaeditor)
                        window.location.href = `${hostOnly}/views/agenda/subir-contenido-edicion`
                        return
                    })
                })
                document.querySelectorAll(".select-estado").forEach(select => {
                    select.addEventListener("change", async (e) => {
                        let idagendaeditor = e.target.getAttribute("data-idagendaeditor");
                        let nuevoEstado = e.target.value;

                        console.log(`Tarea ${idagendaeditor} cambió a estado ${nuevoEstado}`);

                        // Aquí puedes hacer una petición para actualizar el estado en la base de datos
                        const tareaActualizada = await actualizarEstadoTareaEdicion(idagendaeditor, nuevoEstado);
                        console.log("tarea actualizada =_", tareaActualizada);
                        if (tareaActualizada) {
                            showToast("Estado cambiado correctamente", "SUCCESS")
                            return
                        }
                    });
                });
                document.querySelectorAll(".select-altoketicket").forEach(select => {
                    select.addEventListener("change", async (e) => {
                        let idagendaeditor = e.target.getAttribute("data-idagendaeditor");
                        let nuevoEstado = e.target.value;

                        console.log(`altoketikcet id ${idagendaeditor} cambió a estado ${nuevoEstado}`);

                        // Aquí puedes hacer una petición para actualizar el estado en la base de datos
                        const tareaActualizada = await actualizarEstadoAltoketicket(idagendaeditor, nuevoEstado);
                        console.log("tarea actualizada =_", tareaActualizada);
                        if (tareaActualizada) {
                            showToast("Estado cambiado correctamente", "SUCCESS")
                            return
                        }
                    });
                });
            }
            /* if (evento.event.extendedProps.estadoBadge?.text == "Incompleto") {
                window.localStorage.clear()
                window.localStorage.setItem("iddp", evento.event.extendedProps.iddetalle_presentacion)
                window.location.href = `${host}/views/ventas/actualizar-atencion-cliente`
            } */


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
            content.innerHTML = `
            ${info.event.extendedProps.estadoBadge?.text == "Incompleto" ?
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
            ` :
                    info.event.extendedProps.estado == 3 || info.event.extendedProps.estado == 2 ? `
            <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
            <div>${horaInicio} - ${horaFinal}</div>
            <div>${badgeHtml}</div>
          </div>
          <div style="padding: 8px; word-wrap: break-word; 
          overflow-wrap: break-word;
          white-space: normal;">
            <div style="font-size: 20px; font-weight: bold;">${info.event.extendedProps?.title
                        }</div>
              <div><strong>Local:</strong> ${info.event.extendedProps.establecimiento || "No definido"
                        }</div>
              <div><strong>Tiempo:</strong> ${calculateDuration(
                            info.event.extendedProps.horainicio,
                            info.event.extendedProps.horafinal
                        )}</div>` : info.event.extendedProps.idagendaedicion !== null ? `
            <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
            <div>${horaInicio} - ${horaFinal}</div>
            <div>${badgeHtml}</div>
          </div>
          <div style="padding: 8px; word-wrap: break-word; 
          overflow-wrap: break-word;
          white-space: normal;">
            <div style="font-size: 20px; font-weight: bold;">${info.event.extendedProps?.title
                            }</div>
              <div><strong>Local:</strong> ${info.event.extendedProps.establecimiento || "No definido"
                            }</div>
              <div><strong>Tiempo:</strong> ${calculateDuration(
                                info.event.extendedProps.horainicio,
                                info.event.extendedProps.horafinal
                            )}</div>
            <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px;">
              <button class="btn btn-primary" id="btnAsignarEditor" style="flex: 1;" data-idagendaeditor="${info.event.extendedProps?.idagendaeditor}" data-idagendaedicion="${info.event.extendedProps?.idagendaedicion}" data-idagendaeditor="${info.event.extendedProps?.idagendaeditor}">Asignar</button>
              <button class="btn btn-primary" id="btnVerProgreso" style="flex: 1;" data-idagendaedicion="${info.event.extendedProps?.idagendaedicion}" data-idagendaeditor="${info.event.extendedProps?.idagendaeditor}">Ver progreso</button>
            </div>
            `
                        :
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
              <div><strong>Local:</strong> ${info.event.extendedProps.establecimiento || "No definido"
                        }</div>
              <div><strong>Tiempo:</strong> ${calculateDuration(
                            info.event.extendedProps.horainicio,
                            info.event.extendedProps.horafinal
                        )}</div>

          ${nivelacceso == "Administrador" ? `
            <label ><strong>Acuerdos:</strong></label>
            <div id="text-acuerdo" class="mt-1" style="
          background: #fff; 
          padding: 5px; 
          border-radius: 5px; 
          word-wrap: break-word; 
          overflow-wrap: break-word;
          white-space: normal;
        ">
          ${info.event.extendedProps.acuerdo ||
                            "Sin acuerdos registrados"
                            }
        </div>
            ` : ''}                    
      
            <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px;">                                                
      
              ${nivelacceso == "Artista" ? `
                <button class="btn btn-primary" id="btnVerMontos" style="flex: 1;" data-idcontrato="${info.event.extendedProps?.idcontrato}" data-idconvenio="${info.event.extendedProps?.idconvenio}">Ver Monto</button>
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
            });
        }

    });
    calendar.render();
    calendar.setOption("locale", "es");
    ajustarEventos(); // Aplicar ajuste inicial

    // Detectar cambios de tamaño de pantalla y ajustar eventos
    window.addEventListener("resize", ajustarEventos);

    if (nivelacceso == "Administrador") {
        const agendasEdicion = await obtenerTodasLasAgendasEdicion()
        console.log("todas las agendas edicion -> ", agendasEdicion);
        await configurarCalendario(agendasEdicion)
    } else {
        const agendasEdicion = await obtenerTareasEditor(idusuarioLogeado)
        console.log(`todas las agendas edicion para un editor en especifico osea -> ${idusuarioLogeado}`, agendasEdicion);
        await configurarCalendarioAgendaEditor(agendasEdicion)
    }

    // *************************************************** CONFIGURACION DE CALENDARIO PARA ADMINISTRADORES ************************************************************************

    async function configurarCalendario(agendaUsuario) {
        console.log("agendaUsuario -> ", agendaUsuario);
        let incompleto = false


        // Convertir los datos de la agenda en eventos para FullCalendar
        for (const evento of agendaUsuario) {
            incompleto =
                !evento.horainicio ||
                !evento.horafinal ||
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

            if (esContratoValido || esConvenioValido) {
                estadoBadge = {
                    text: "Confirmado",
                    class: "badge bg-success",
                };
            } else if (incompleto) {
                estadoBadge = {
                    text: "Incompleto",
                    class: "badge bg-danger",
                };
            } else if (evento.estado == 3) {
                estadoBadge = {
                    text: "Cancelado",
                    class: "badge bg-danger",
                };
            } else if (evento.estado == 2) {
                estadoBadge = {
                    text: "Caducado",
                    class: "badge bg-danger",
                };
            }


            if (nivelacceso) {
                console.log("Evento agregado a la agenda:", evento);

                agenda.push({
                    title: evento.nom_usuario,
                    start: evento.fecha_presentacion,
                    iddetalle_presentacion: evento.iddetalle_presentacion,
                    backgroundColor: `${evento.color}`,
                    borderColor: `${evento.color}`,
                    textColor: "black",
                    extendedProps: {
                        estadoBadge,
                        title: evento.nom_usuario,
                        horainicio: evento.horainicio,
                        horafinal: evento.horafinal,
                        establecimiento: evento.establecimiento,
                        iddepartamento: evento.iddepartamento,
                        idusuario: evento.idusuario,
                        acuerdo: evento.acuerdo,
                        idcontrato: evento.idcontrato,
                        idconvenio: evento.idconvenio,
                        estado: evento.estado,
                        idagendaedicion: evento.idagendaedicion,
                        idagendaeditor: evento.idagendaeditor
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

            let horaInicio = arg.event.extendedProps.horainicio
                ? formatHour(arg.event.extendedProps.horainicio)
                : "Hora no definida";
            let horaFinal = arg.event.extendedProps.horafinal
                ? formatHour(arg.event.extendedProps.horafinal)
                : "Hora no definida";

            let estado = arg.event.extendedProps?.estadoBadge;
            let badgeHtml = `<span class="${estado?.class}">${estado?.text}</span>`;
            console.log("ENTRANDO ANTES DE RENDERIZAR TODO");
            return {
                html: `
                  <div style="padding: 8px; word-wrap: break-word; 
                  overflow-wrap: break-word;
                  white-space: normal;">
                    <span class="titulo-card">${arg.event.title
                    } - ${arg.event.extendedProps.establecimiento || "No definido"
                    } ( ${calculateDuration(
                        arg.event.extendedProps.horainicio,
                        arg.event.extendedProps.horafinal
                    )} )</span>    
              `,
            };
        });
    }

    // *************************************************** CONFIGURACION DE CALENDARIO PARA EDITORES *****************************************************************************

    async function configurarCalendarioAgendaEditor(agendaEditor) {
        console.log("agendaEditor _> ", agendaEditor);
        agendaEdicion = []
        for (const evento of agendaEditor) {
            agendaEdicion.push({
                title: evento.nom_usuario,
                start: evento.fecha_presentacion,
                idagendaeditor: evento.idagendaeditor,
                backgroundColor: `${evento.color}`,
                borderColor: `${evento.color}`,
                textColor: "black",
                extendedProps: {
                    horainicio: evento.horainicio,
                    horafinal: evento.horafinal,
                    establecimiento: evento.establecimiento,
                    idagendaedicion: evento.idagendaedicion,
                    idusuario: evento.idusuarioEdicion,
                    tarea: evento.tipotarea
                },
            });
        }

        calendar.removeAllEvents();
        calendar.addEventSource(agendaEdicion);

        console.log("Eventos agregados al calendario:", calendar.getEvents());
        console.log("Cantidad de eventos en el calendario:", calendar.getEvents().length);
        // Personalizar la apariencia de los eventos para mostrar el badge
        calendar.setOption("eventContent", function (arg) {
            //      console.log("Evento extendido:", arg.event.extendedProps); // Verificar los datos

            let horaInicio = arg.event.extendedProps.horainicio
                ? formatHour(arg.event.extendedProps.horainicio)
                : "Hora no definida";
            let horaFinal = arg.event.extendedProps.horafinal
                ? formatHour(arg.event.extendedProps.horafinal)
                : "Hora no definida";

            return {
                html: `             
                    <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
                      <div>${horaInicio} - ${horaFinal}</div>
                    </div>
                  <div style="padding: 8px; word-wrap: break-word; 
                  overflow-wrap: break-word;
                  white-space: normal;">
                    <div style="font-size: 20px; font-weight: bold;">${arg.event.title}</div>
                    <div><strong>Local:</strong> ${arg.event.extendedProps.establecimiento || "No definido"}</div>
                    <div><strong>Tiempo:</strong> ${calculateDuration(
                    arg.event.extendedProps.horainicio,
                    arg.event.extendedProps.horafinal
                )}</div>
                    <div><strong>Tarea:</strong> ${arg.event.extendedProps.tarea || "No definido"}</div>
                  ${nivelacceso == "Administrador" || nivelacceso == "Community Manager" ? `
                    <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px;">
                   <button class="btn btn-primary" id="btnVerProgresoIndividual" style="flex: 1;" data-idusuario="${arg.event.extendedProps.idusuario}" data-idagendaedicion="${arg.event.extendedProps.idagendaedicion}">Ver Progreso</button>
                  </div>
                    ` : `<div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px;">
                   <button class="btn btn-primary" id="btnSubirTarea" style="flex: 1;" data-idagendaeditor="${arg.event.extendedProps.idagendaeditor}">Subir</button>
                  </div>`}
                  `


            };
        });
    }

    // *************************************************************** EVENTOS **************************************************************************************************

    $q("#tipofiltroedicion").addEventListener("change", async () => {
        console.log("valor del select filtro adentor- > ", $q("#tipofiltroedicion").value);
        if ($q("#tipofiltroedicion").value == 2) {
            $q(".contenedor-select-usuario").hidden = false
            console.log("entrando con solo usuarios");
            const tareasEdicionUsuario = await obtenerTareasEditor(null)
            console.log("tareasEdicionUsuario -> ", tareasEdicionUsuario);
            await configurarCalendarioAgendaEditor(tareasEdicionUsuario)
        }
        else if ($q("#tipofiltroedicion").value == 1) {
            console.log("obteniendo todas las agendas");
            $q(".contenedor-select-usuario").hidden = true
            //await manejadorAgendaPorNivel("10")
        }
    })

    $q("#usuario")?.addEventListener("change", async (e) => {
        idUsuario = e.target.value ? e.target.value : e.target.value == "-1" ? null : '';
        //await manejadorAgendaPorNivel("10")
        const tareasEditor = await obtenerTareasEditor(idUsuario)
        console.log("tareas editor filtafo por idusuario -> ", tareasEditor);
        await configurarCalendarioAgendaEditor(tareasEditor)

    });

    document.addEventListener("click", async (e) => {
        if (e.target && e.target.id === "btnVerProgreso") {
            /* window.localStorage.clear()
            window.localStorage.setItem("idagendaedicion", idagendaedicion)
            window.location.href = `${host}/views/agenda/asignar-agenda-edicion` */
            idagendaedicion = e.target.getAttribute("data-idagendaedicion");
            idagendaeditor = e.target.getAttribute("data-idagendaeditor");
            let tareasEdicionHtml = ''
            modalProgresoEdicion = new bootstrap.Modal($q("#modal-progresoedicion"));
            modalProgresoEdicion.show();

            const editoresAsignados = await obtenerEditoresAsignados(idagendaedicion)
            console.log("editoresAsignados ->", editoresAsignados);
            $q(".contenedor-tareas-edicion-pendientes").innerHTML = ``
            for (const editor of editoresAsignados) {
                const [fechaActual, horaActual] = obtenerFechaHoraPeru();
                const fechaHoraString = `${fechaActual} ${horaActual.trim().replace('a.m.', 'AM').replace('p.m.', 'PM')}`;
                const fechaHoraActual = new Date(fechaHoraString);
                const fechaHoraEntrega = new Date(`${editor.fecha_entrega} ${editor.hora_entrega}`);
                const tareaAtrasada = fechaHoraActual > fechaHoraEntrega;
                const claseAtraso = tareaAtrasada && editor.estado == 1 || tareaAtrasada && editor.estado == 3 || tareaAtrasada && editor.estado == 4 ? 'bg-danger text-white' : '';
                console.log("tareaAtrasada -> ", tareaAtrasada);
                if (tareaAtrasada) {
                    console.log("entranodox");
                    if (editor.estado == 1) {
                        console.log("la tarea atrasada y como esta en pendiente se marca COMO ATRASADO");
                        const estadoTareaActualizado = await actualizarEstadoTareaEdicion(editor.idagendaeditor, 3);
                        console.log("estado tarea actualizada -> ", estadoTareaActualizado);
                    } else if (editor.estado == 2) {
                        console.log("fecha actual sobrepasa entrega, pero ya completado");

                    } else if (editor.estado == 3) {
                        console.log("la tarea esta atrasada pero como eesta en pendiente entonces q");
                        const estadoTareaActualizado = await actualizarEstadoTareaEdicion(editor.idagendaeditor, 3);
                        console.log("estado tarea actualizada -> ", estadoTareaActualizado);
                    } else if (editor.estado == 4) {
                        console.log("la tarea esta atrasada pero como eesta en pendiente entonces q");
                        const estadoTareaActualizado = await actualizarEstadoTareaEdicion(editor.idagendaeditor, 4);
                        console.log("estado tarea actualizada -> ", estadoTareaActualizado);
                    }
                }
                console.log("aun no vence la tarea y NO SUCEDE NADA");


                tareasEdicionHtml += `
                    <tr class="${claseAtraso}">
                        <td>${editor.fecha_entrega} - ${formatHour(editor.hora_entrega)}</td>
                        <td>${editor.nombres}</td>
                        <td>${editor.tipotarea ? editor.tipotarea : 'No especificado'}</td>
                        ${nivelacceso == "Administrador" ? `
                            <td>
                                <select name="altoketicket" class="form-select select-altoketicket" data-idagendaeditor="${editor.idagendaeditor}">
                                    <option value="1" ${editor.altoketicket == 1 ? 'selected' : ''}>Pendiente</option>
                                    <option value="2" ${editor.altoketicket == 2 ? 'selected' : ''}>Completado</option>
                                </select>
                            </td>
                            <td>
                                <select name="estado" class="form-select select-estado" data-idagendaeditor="${editor.idagendaeditor}" data-fechaentrega="${editor.fecha_entrega}" data-horaentrega="${editor.hora_entrega}" data-estado="${editor.estado}">
                                    <option value="1" ${editor.estado == 1 || editor.estado == 3 ? 'selected' : ''}>Pendiente</option>
                                    <option value="2" ${editor.estado == 2 || editor.estado == 4 ? 'selected' : ''}>Completado</option>
                                </select>
                            </td>
                        ` : `
                            <td>${editor.altoketicket == 1 ? 'Pendiente' : editor.altoketicket == 2 ? 'Completado' : ''}</td>
                            <td>${editor.estado == 1 ? 'Pendiente' : editor.estado == 3 ? "Atrasado" : editor.estado == 2 ? 'Completado' : editor.estado == 4 ? "Completado con atraso" : ''}</td>`}
                        <td>
                            <button type="button" class="btn btn-primary" id="btnVerContenido" data-idagendaeditor="${editor.idagendaeditor}">Ver</button>
                        </td>        
                    </tr>       
                `;
            }
            $q(".contenedor-tareas-edicion-pendientes").innerHTML = tareasEdicionHtml
            $all("#btnVerContenido").forEach(btn => {
                btn.addEventListener("click", (e) => {
                    idagendaeditor = e.target.getAttribute("data-idagendaeditor")
                    console.log("id agenda edicion -> ", idagendaeditor);
                    window.localStorage.clear()
                    window.localStorage.setItem("idagendaeditor", idagendaeditor)
                    window.location.href = `${hostOnly}/views/agenda/subir-contenido-edicion`
                    return
                })
            })
            document.querySelectorAll(".select-estado").forEach(select => {
                select.addEventListener("change", async (e) => {
                    console.log("cambiando");
                    let idagendaeditor = e.target.getAttribute("data-idagendaeditor");
                    let fecha_entrega = e.target.getAttribute("data-fechaentrega");
                    let hora_entrega = e.target.getAttribute("data-horaentrega");
                    let estado = e.target.getAttribute("data-estado");
                    let nuevoEstado = e.target.value;

                    console.log(`Tarea ${idagendaeditor} cambió a estado ${nuevoEstado}`);

                    // Aquí puedes hacer una petición para actualizar el estado en la base de datos
                    /* const tareaActualizada = await actualizarEstadoTareaEdicion(idagendaeditor, nuevoEstado);
                    console.log("tarea actualizada =_", tareaActualizada); */
                    const [fechaActual, horaActual] = obtenerFechaHoraPeru();
                    const fechaHoraString = `${fechaActual} ${horaActual.trim().replace('a.m.', 'AM').replace('p.m.', 'PM')}`;
                    const fechaHoraActual = new Date(fechaHoraString);
                    console.log("fechaHoraActual -> ,", fechaHoraActual);

                    const fechaHoraEntrega = new Date(`${fecha_entrega} ${hora_entrega}`);
                    console.log("fechaHoraEntrega -> ,", fechaHoraEntrega);
                    const tareaAtrasada = fechaHoraActual > fechaHoraEntrega;
                    console.log("tarea atrasada -> ", tareaAtrasada);
                    /*  if (tareaActualizada) {
                         showToast("Estado cambiado correctamente", "SUCCESS")
                         return
                     } */
                    if (tareaAtrasada) {
                        console.log("entrando adento linea 899");
                        if (nuevoEstado == 1) {
                            if (estado == 2 || estado == 3 || estado == 4) {
                                console.log("la tarea atrasada y como esta en pendiente se marca COMO ATRASADO");
                                const estadoTareaActualizado = await actualizarEstadoTareaEdicion(idagendaeditor, 3)
                                console.log("estado tarea actualizada -> ", estadoTareaActualizado);
                                if (estadoTareaActualizado) {
                                    showToast("Estado cambiado correctamente", "SUCCESS")
                                    return
                                }
                            }
                        } else if (nuevoEstado == 2) {
                            console.log("id agenda editr._> ", idagendaeditor);
                            console.log("estado -> ", estado);
                            if (estado == 1 || estado == 2 || estado == 3 || estado == 4) {
                                console.log("la tarea atrasada y como esta en pendiente se marca COMO ATRASADO");
                                const estadoTareaActualizado = await actualizarEstadoTareaEdicion(idagendaeditor, 4)
                                console.log("estado tarea actualizada -> ", estadoTareaActualizado);
                                if (estadoTareaActualizado) {
                                    showToast("Estado cambiado correctamente", "SUCCESS")
                                    return
                                }
                            }
                        }
                    } else if (nuevoEstado == 1) {
                        const estadoTareaActualizado = await actualizarEstadoTareaEdicion(idagendaeditor, 1)
                        console.log("estado tarea actualizada -> ", estadoTareaActualizado);
                        if (estadoTareaActualizado) {
                            showToast("Estado cambiado correctamente", "SUCCESS")
                            return
                        }

                    } else if (nuevoEstado == 2) {
                        console.log("idagenda editor de q recien esta en pendiente _ > ", idagendaeditor);
                        console.log("estado en el q esta: ", estado);
                        const estadoTareaActualizado = await actualizarEstadoTareaEdicion(idagendaeditor, 2)
                        console.log("estado tarea actualizada -> ", estadoTareaActualizado);
                        if (estadoTareaActualizado) {
                            showToast("Estado cambiado correctamente", "SUCCESS")
                            return
                        }
                    }

                });
            });
            document.querySelectorAll(".select-altoketicket").forEach(select => {
                select.addEventListener("change", async (e) => {
                    let idagendaeditor = e.target.getAttribute("data-idagendaeditor");
                    let nuevoEstado = e.target.value;

                    console.log(`altoketikcet id ${idagendaeditor} cambió a estado ${nuevoEstado}`);

                    // Aquí puedes hacer una petición para actualizar el estado en la base de datos
                    const tareaActualizada = await actualizarEstadoAltoketicket(idagendaeditor, nuevoEstado);
                    console.log("tarea actualizada =_", tareaActualizada);
                    if (tareaActualizada) {
                        showToast("Estado cambiado correctamente", "SUCCESS")
                        return
                    }
                });
            });
        }
        if (e.target && e.target.id === "btnAsignarEditor") {
            idagendaedicion = e.target.getAttribute("data-idagendaedicion");
            idagendaeditor = e.target.getAttribute("data-idagendaeditor");
            //idagendaeditorConsultar = e.target.getAttribute("data-idagendaeditor");
            //idagendaEdicionConsultar = e.target.getAttribute("data-idagendaedicion")
            let opcionesEditores
            let opcionesResponsables
            modalAsignarEditor = new bootstrap.Modal($q("#modal-asignareditor"));
            modalAsignarEditor.show();

            const tipotarea = await obtenerTodosTipoTarea()
            const usuariosEditores = await obtenerUsuarios(10) // edicion 
            const usuariosFilmmakers = await obtenerUsuarios(11) // edicion  // RAZON : LOS FILMAKERS TMB SON EDITORES EN LA VIDA REAL PQ LO Q ASUMEN ESE ROL TMB
            const usuariosCManager = await obtenerUsuarios(8) // edicion 
            const tareasRestantes = await obtenerTodasLasTareasEnLaAgenda(idagendaedicion);
            console.log("usuariosCManager ->", usuariosCManager);
            console.log(" usuariosEditores >>", usuariosEditores);
            console.log("tipotarea -> ", tipotarea);
            $q(".contenedor-asignados").innerHTML = ""; // Limpia el contenedor antes de agregar nuevas filas

            for (const tipo of tipotarea) {
                console.log("tipo -> ", tipo);
                console.log("Tareas restantes -> ", tareasRestantes);
                const tareaAsignada = tareasRestantes.find(tarea => tarea.idtipotarea == tipo.idtipotarea);
                console.log("tareaAsignada -> ", tareaAsignada);
                console.log("idagendaeditor -> ", idagendaeditor);

                const cmanagersPosteadores = await obtenerCmanagerPorIdAgendaEditor(tareaAsignada?.idagendaeditor);
                console.log("cmanagersPosteadores ->>>> ", cmanagersPosteadores);

                let idUsuarioAsignado = tareaAsignada ? tareaAsignada.idusuario : "-1";
                let fechaEntrega = tareaAsignada ? tareaAsignada.fecha_entrega : "";
                let horaEntrega = tareaAsignada ? tareaAsignada.hora_entrega : "";

                console.log("tareaAsignada ->>>> ", tareaAsignada);
                console.log("tareaAsignada.idagendaeditor > ", tareaAsignada?.idagendaeditor);

                opcionesEditores = `<option value="-1">Seleccione</option>`;
                usuariosEditores.forEach(editor => {
                    opcionesEditores += `<option value="${editor.idusuario}" data-idagendaeditor="${tareaAsignada?.idagendaeditor}" 
                    ${editor.idusuario == idUsuarioAsignado ? "selected" : ""}>${editor.nombres}</option>`;
                });
                usuariosFilmmakers.forEach(editor => {
                    opcionesEditores += `<option value="${editor.idusuario}" data-idagendaeditor="${tareaAsignada?.idagendaeditor}" 
                    ${editor.idusuario == idUsuarioAsignado ? "selected" : ""}>${editor.nombres}</option>`;
                });

                opcionesResponsables = `<option value="-1">Seleccione</option>`;
                usuariosCManager.forEach(editor => {
                    opcionesResponsables += `<option value="${editor.idusuario}" data-idagendaeditor="${tareaAsignada?.idagendaeditor}" 
                    ${editor.idusuario == cmanagersPosteadores[0]?.idusuarioCmanager ? "selected" : ""}>${editor.nombres}</option>`;
                });

                $q(".contenedor-asignados").innerHTML += `
                    <tr>
                        <td>                            
                            <div style="display: flex; align-items: center; gap: 8px;">
                                <i class="fa-solid fa-square-xmark btnQuitarTipoTarea" data-idtipotarea="${tipo.idtipotarea}" title="Remover Contenido" style="cursor: pointer; color: red;"></i>
                                <input type="text" class="form-control" name="tipotarea" value="${tipo.tipotarea}">
                                <i class="fa-solid fa-pen-to-square btnActualizarNombreTipoTarea" data-idtipotarea="${tipo.idtipotarea}" style="cursor: pointer;" title="editar"></i>
                            </div>
                        </td>
                        
            
                        <td>
                            <input type="date" class="form-control" name="fechaentrega" value="${fechaEntrega}">
                        </td>
                        <td>
                            <input type="time" class="form-control" name="horaentrega" value="${horaEntrega}">
                        </td>
                        <td class="contenedor-asignados">
                            <div style="display: flex; align-items: center; gap: 8px;">
                                <select name="asignacioneditor" class="form-select" data-idtipotarea="${tipo.idtipotarea}">
                                    ${opcionesEditores}
                                </select>
                                <i class="fa-solid fa-trash btnQuitarUsuarioTarea" data-idagendaeditor="${tareaAsignada?.idagendaeditor}" title="Quitar Editor" style="cursor: pointer; color: red;"></i>
                            </div>
                        </td>
                        <td>
                            <div style="display: flex; align-items: center; gap: 8px;">
                                <select name="responsablepost" class="form-select">
                                    ${opcionesResponsables}
                                </select>
                                <i class="fa-solid fa-trash btnQuitarResponsablePosteo" data-idagendaeditor="${tareaAsignada?.idagendaeditor}" title="Quitar Responsable de publicar" style="cursor: pointer; color: red;"></i>
                            </div>
                        </td>
                    </tr>
                `;
            }


            $all(".btnQuitarUsuarioTarea").forEach(btn => {
                btn.addEventListener("click", async (e) => {
                    try {
                        let fila = e.target.closest("tr"); // Encuentra la fila actual
                        console.log("fila para remover conteindo-> ", fila);
                        let selectAsignacionEditor = fila.querySelector("select[name='asignacioneditor']");
                        let inputFechaEntrega = fila.querySelector("input[name='fechaentrega']");
                        let inputHoraEntrega = fila.querySelector("input[name='horaentrega']");
                        console.log("selectAsignacionEEDITOR -> ", selectAsignacionEditor);


                        const idagendaeditor = e.target.getAttribute("data-idagendaeditor")
                        console.log("idagenda editor ->", idagendaeditor);
                        const tareaQuitadaUsuario = await eliminarTareaUsuario(idagendaeditor)
                        console.log("tarea quitada usuario ? -> ", tareaQuitadaUsuario);
                        if (tareaQuitadaUsuario) {
                            showToast("Tarea removida!", "SUCCESS")
                            selectAsignacionEditor.value = -1
                            inputFechaEntrega.value = ""
                            inputHoraEntrega.value = ""
                            return
                        }
                    } catch (error) {
                        showToast("No puedes removerle la tarea por que se encuentra en desarollo", "ERROR")
                        return
                    }
                })
            })

            $all(".btnActualizarNombreTipoTarea").forEach(btn => {
                btn.addEventListener("click", async (e) => {
                    try {
                        let fila = e.target.closest("tr"); // Encuentra la fila actual
                        console.log("fila para remover conteindo-> ", fila);
                        let inputTipoTarea = fila.querySelector("input[name='tipotarea']").value;
                        console.log("selectAsignacionEEDITOR -> ", inputTipoTarea);


                        const idtipotarea = e.target.getAttribute("data-idtipotarea")
                        console.log("idtipotarea ->", idtipotarea);
                        const nombreTTactualizado = await actualizarNombreTipoTarea(idtipotarea, inputTipoTarea)
                        console.log("nombreTTactualizado ? -> ", nombreTTactualizado);
                        if (nombreTTactualizado) {
                            showToast("Nombre de contenido actualizado!", "SUCCESS")
                            return
                        }
                    } catch (error) {
                        showToast("Un error ha ocurrido", "ERROR")
                        return
                    }
                })
            })

            $all(".btnQuitarTipoTarea").forEach(btn => {
                btn.addEventListener("click", async (e) => {
                    try {
                        let fila = e.target.closest("tr"); // Encuentra la fila actual
                        console.log("fila para remover conteindo-> ", fila);

                        const idtipotarea = e.target.getAttribute("data-idtipotarea")
                        console.log("idtipotarea ->", idtipotarea);
                        const tareaRemovida = await removerTipoTarea(idtipotarea)
                        console.log("tareaRemovida ? -> ", tareaRemovida);
                        if (tareaRemovida) {
                            showToast("Contenido removido!", "SUCCESS")
                            fila.remove()
                            return
                        }
                    } catch (error) {
                        showToast("No puedes remover este contenido porque ya tiene registros historicos", "ERROR")
                        return
                    }
                })
            })

            $all(".btnQuitarResponsablePosteo").forEach(btn => {
                btn.addEventListener("click", async (e) => {
                    try {
                        let fila = e.target.closest("tr"); // Encuentra la fila actual
                        console.log("fila para remover conteindo-> ", fila);
                        let selectAsignacionEditor = fila.querySelector("select[name='responsablepost']");

                        console.log("selectAsignacionEEDITOR -> ", selectAsignacionEditor);


                        const idagendaeditor = e.target.getAttribute("data-idagendaeditor")
                        console.log("idagenda editor ->", idagendaeditor);
                        const tareaVinculadaCmanager = await obtenerTareaVinculadaCManager(idagendaeditor)
                        console.log("tarea vincuada cmanager -> ", tareaVinculadaCmanager);
                        if (tareaVinculadaCmanager.length > 0) {
                            if (tareaVinculadaCmanager[0]?.estado == 2) {
                                showToast("No puedes removerlo por que ya lo ha publicado", "ERROR")
                                return
                            }
                        }
                        const responsablePosteoQuitado = await quitarResponsablePosteo(idagendaeditor)
                        console.log("tarea quitada usuario ? -> ", responsablePosteoQuitado);
                        if (responsablePosteoQuitado) {
                            showToast("Responsable removido!", "SUCCESS")
                            selectAsignacionEditor.value = -1
                            return
                        }
                    } catch (error) {
                        console.log("erro -< ", error);
                        showToast("No puedes removerle la responsabilidad por que se encuentra en desarollo", "ERROR")
                        return
                    }
                })
            })

            document.querySelectorAll("select[name='asignacioneditor']").forEach(async select => {
                // Llamar la función asignarAgendaEditor cuando se seleccione un editor
                select.addEventListener("change", async (e) => {
                    console.log("adadasdasdad");
                    let idusuario = e.target.value;
                    let fila = e.target.closest("tr"); // Encuentra la fila actual
                    let fechaentrega = fila.querySelector("input[name='fechaentrega']").value;
                    let horaentrega = fila.querySelector("input[name='horaentrega']").value;
                    //let asignacioneditor = fila.querySelector("select[name='asignacioneditor']").value;
                    let idtipotarea = select.getAttribute("data-idtipotarea");
                    let idagendaeditor = e.target.options[e.target.selectedIndex].getAttribute("data-idagendaeditor");
                    console.log("idagendaeditor->>>>>>", idagendaeditor);
                    console.log("ID Tipo de Tarea: ", idtipotarea);
                    const tareaUsuario = await obtenerTareaPorUsuarioYagenda(idusuario, idagendaedicion);
                    console.log("este usuario ya esta asignado a esta taraea", tareaUsuario);

                    const tareaConUsuarioAsignado = await obtenerUsuarioAsignado(idagendaedicion, idtipotarea)
                    console.log("esta tarea ya tiene a un usuario asignado -> ", tareaConUsuarioAsignado);
                    //console.log("asignacioneditor -> ", asignacioneditor);
                    /* if (asignacioneditor == -2) {
                        //const = await eliminarTareaUsuario(idagendaeditor)
                        alert("deseleccionadno usuario")
                        return
                    } */

                    if (tareaConUsuarioAsignado.length > 0) {
                        showToast("Esta tarea ya tiene a un usuario asignado", "ERROR")
                        return
                    }

                    if (tareaUsuario.length > 0) {
                        console.log("ifecha entrega -> <<", fechaentrega);
                        console.log("hora entrega -> <<", horaentrega);

                        if (!fechaentrega) {
                            showToast("Debe seleccionar una fecha de entrega.", "INFO");
                            return;
                        }
                        if (!horaentrega) {
                            showToast("Debe seleccionar una hora de entrega.", "INFO");
                            return;
                        }

                        console.log("¿Este usuario ya tiene una tarea? ->", tareaUsuario);
                        /* const agendaActualizada = await actualizarAgendaEditor(tareaUsuario[0]?.idagendaeditor, tareaUsuario[0]?.idusuario, idtipotarea, fechaentrega, horaentrega)
                        console.log("agenda actualizad=?", agendaActualizada);
                        //showToast("Este usuaruio ya fue asignado a una tarea", "ERROR")
                        showToast("Editor asignado correctamente", "SUCCESS")
                        return */
                        let response = await asignarAgendaEditor(idagendaedicion, idusuario, idtipotarea, fechaentrega, horaentrega);
                        console.log("Respuesta de asignación:", response);
                        if (response.idagendaeditor) {
                            //idagendaeditorFinal = response.idagendaeditor
                            showToast("Editor asignado correctamente", "SUCCESS")
                            return
                        }
                    }
                    if (idusuario !== "-1") {

                        if (!fechaentrega) {
                            showToast("Debe seleccionar una fecha de entrega.", "INFO");
                            return;
                        }
                        if (!horaentrega) {
                            showToast("Debe seleccionar una hora de entrega.", "INFO");
                            return;
                        }

                        let response = await asignarAgendaEditor(idagendaedicion, idusuario, idtipotarea, fechaentrega, horaentrega);
                        console.log("Respuesta de asignación:", response);
                        if (response.idagendaeditor) {
                            //idagendaeditorFinal = response.idagendaeditor
                            showToast("Editor asignado correctamente", "SUCCESS")
                            return
                        }
                    }
                });
            });

            document.querySelectorAll("select[name='responsablepost']").forEach(select => {
                select.addEventListener("change", async (e) => {
                    try {
                        let fila = e.target.closest("tr"); // Encuentra la fila actual
                        console.log("fila -> ", fila);
                        let idagendaeditor = e.target.options[e.target.selectedIndex].getAttribute("data-idagendaeditor");
                        let idusuariocmanager = e.target.options[e.target.selectedIndex].value;
                        console.log("idusuario c manager value -> ", idusuariocmanager);

                        const cmanagerRespExistente = await obtenerCmanagerPorIdAgendaEditor(idagendaeditor)
                        console.log("cmanagerRespExistente -> ", cmanagerRespExistente);
                        if (cmanagerRespExistente.length > 0) {
                            showToast("Ya existe un responsable para esta tarea", "ERROR")
                            return
                        }
                        console.log("idagenda editor -> ", idagendaeditor);
                        if (idagendaeditor == "undefined") {
                            showToast("primero necesitas elegir un editor", "ERROR")
                            return
                        }
                        showToast("guardando posteador", "SUCCESS")
                        const idagenda = await registrarAgendaCManager(idagendaeditor, idusuariocmanager)
                        if (idagenda.idagendacmanager) {
                            showToast("Responsable de posteo asignado", "SUCCESS")
                            return
                        }
                    } catch (error) {
                        showToast("Un error ha ocurrido", "ERROR")
                        return
                    }
                })
            });

        }

        /* document.addEventListener("click", async function (e) {
            if (e.target && e.target.classList.contains("btnQuitarUsuarioTarea")) {
                try {
                    let idagendaeditor = e.target.getAttribute("data-idagendaeditor");
                    console.log("idagendaeditor -> ", idagendaeditor);
                    const tareaQuitadaUsuario = await eliminarTareaUsuario(idagendaeditor)
                    console.log("tarea quitada usuario ? -> ", tareaQuitadaUsuario);
                    if (tareaQuitadaUsuario) {
                        showToast("Se le ha removido la tarea correctamente", "SUCCESS")
                        return
                    }
                } catch (error) {
                    //console.error(error);
                    showToast("No puedes removerle la tarea por que se encuentra en desarollo", "ERROR")
                    return
                }
                // Aquí puedes llamar a una función para eliminar el editor
            }
        }); */


    })


    $q("#btnNuevaTipoTarea").addEventListener("click", async () => {
        $q(".contenedor-asignados").innerHTML += `
        <tr>
            <td>
                <div style="display: flex; align-items: center; gap: 8px;">
                    <input type="text" class="form-control" name="tipotarea" value="">
                    <i class="fa-solid fa-floppy-disk btnGuardarTipoTarea" style="cursor: pointer;"></i>
                </div>
            </td>
            <td class="contenedor-asignados">
                <div style="display: flex; align-items: center; gap: 8px;">
                    <select name="asignacioneditor" class="form-select">
                    
                    </select>
                    <i class="fa-solid fa-trash btnQuitarUsuarioTarea"style="cursor: pointer; color: red;"></i>
                </div>
            </td>

            <td>
                <input type="date" class="form-control" name="fechaentrega">
            </td>
            <td>
                <input type="time" class="form-control" name="horaentrega">
            </td>
            <td>
                <div style="display: flex; align-items: center; gap: 8px;">
                    <select name="responsablepost" class="form-select">
                    </select>
                    <i class="fa-solid fa-trash btnQuitarResponsablePosteo" style="cursor: pointer; color: red;"></i>
                </div>
            </td>
        </tr>
        `

        $all(".btnGuardarTipoTarea").forEach(btn => {
            btn.addEventListener("click", async (e) => {

                let fila = e.target.closest("tr"); // Encuentra la fila actual
                let inputNuevoTipoTarea = fila.querySelector("input[name='tipotarea']").value;
                console.log("nuevo tipo tarea ", inputNuevoTipoTarea);
                if (inputNuevoTipoTarea == "") {
                    showToast("Rellena el campo de la nueva tarea", "ERROR")
                    return
                }
                const tipoTareaRegis = await registrarNuevoTipoTarea(inputNuevoTipoTarea)
                console.log("tipoTareaRegis -> ", tipoTareaRegis);
                if (tipoTareaRegis.idtipotarea) {
                    showToast("Nueva Tarea Registrada", "SUCCESS")
                    modalAsignarEditor.hide()
                    return
                }
            })
        })
    })

    /*  $q("#btnAsignarTareaDiaria").addEventListener("click", async () => {
         window.location.href = `${host}/views/utilitario/tareasdiarias/registrar-tareadiaria`
     }) */
})