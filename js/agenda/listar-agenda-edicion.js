document.addEventListener("DOMContentLoaded", async () => {

    // VARIABLES 
    let agenda = []

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
    const usuarios = await obtenerUsuarios()
    $q("#usuario").innerHTML = "<option value=''>Todos</option>";
    usuarios.forEach((editor) => {
        $q(
            "#usuario"
        ).innerHTML += `<option value="${editor.idusuario}">${editor.nombres}</option>`;
        
    });
    

    // ******************************************** OBTENER DATOS **********************************************************

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

    /*     async function eliminarTareaUsuario(idagendaeditor) {
            const viatico = new FormData();
            viatico.append("operation", "eliminarTareaUsuario");
            viatico.append("idagendaeditor", idagendaeditor);
    
            const fviatico = await fetch(`${host}agenda.controller.php`, {
                method: "POST",
                body: viatico,
            });
            const rviatico = await fviatico.json();
            return rviatico;
        } */

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
        height: 700,
        initialView: "dayGridMonth", // Vista inicial: mes
        headerToolbar: {
            left: "prev,next today",
            center: "title",
            right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth", // Filtros de vista
        },
        events: [], // Aquí se cargarán los eventos dinámicamente
        locale: "es",
        dayMaxEvents: 1, // Muestra hasta 3 eventos antes de colapsar
        eventLimitClick: "popover", // Muestra un popover con los eventos restantes
        eventClick: async function (evento) {
            console.log("evento -> ", evento)
            //
            const btnSubirTarea = evento.jsEvent.target.closest("#btnSubirTarea");
            if (btnSubirTarea) {
                const idagendaeditor = btnSubirTarea.getAttribute("data-idagendaeditor");
                window.localStorage.clear()
                window.localStorage.setItem("idagendaeditor", idagendaeditor)
                window.location.href = `http://localhost/vega-erp/views/agenda/subir-contenido-edicion` //me quede acaaaa
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
                    if (editor.idusuario == idusuarioEdicion) {
                        $q(".contenedor-tareas-edicion-pendientes").innerHTML += `
            <tr>
                <td>${editor.fecha_entrega}</td>
                <td>${editor.nombres}</td>
                <td>${editor.tipotarea == 1 ? 'Flayer' : editor.tipotarea == 2 ? 'Saludos' : editor.tipotarea == 3 ? 'Reels' : editor.tipotarea == 4 ? 'Fotos' : editor.tipotarea == 5 ? 'Contenido' : 'No especificado'}</td>
                <td>
                  <select name="estado" class="form-select select-estado" data-idagendaeditor="${editor.idagendaeditor}">
                      <option value="1" ${editor.estado == 1 ? 'selected' : ''}>Pendiente</option>
                      <option value="2" ${editor.estado == 2 ? 'selected' : ''}>Completado</option>
                  </select>
                </td>
                <td>
                    <button type="button" class="btn btn-primary" id="btnAbrirModalSubir" data-idagendaeditor="${editor.idagendaeditor}">Ver</button>
                </td>        
            </tr>       
            `
                    }

                });
                $all("#btnAbrirModalSubir").forEach(btn => {
                    btn.addEventListener("click", (e) => {
                        idagendaeditor = e.target.getAttribute("data-idagendaeditor")
                        console.log("id agenda edicion -> ", idagendaeditor);
                        window.localStorage.clear()
                        window.localStorage.setItem("idagendaeditor", idagendaeditor)
                        window.location.href = `http://localhost/vega-erp/views/agenda/subir-contenido-edicion`
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
            }
            /* if (evento.event.extendedProps.estadoBadge?.text == "Incompleto") {
                window.localStorage.clear()
                window.localStorage.setItem("iddp", evento.event.extendedProps.iddetalle_presentacion)
                window.location.href = `http://localhost/vega-erp/views/ventas/actualizar-atencion-cliente`
            } */
        },
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
                  ${arg.event.extendedProps.estadoBadge?.text == "Incompleto" ?
                        `
                    <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
                      <div>00:00 - 00:00</div>
                      <div>${badgeHtml}</div>
                    </div>
                    <div style="padding: 8px; word-wrap: break-word; 
                  overflow-wrap: break-word;
                  white-space: normal;">
                    <div style="font-size: 20px; font-weight: bold;">${arg.event.title
                        }</div>
                  <div><strong>Click aqui para editar</strong>
                  </div>
                    ` :
                        arg.event.extendedProps.estado == 3 || arg.event.extendedProps.estado == 2 ? `
                    <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
                    <div>${horaInicio} - ${horaFinal}</div>
                    <div>${badgeHtml}</div>
                  </div>
                  <div style="padding: 8px; word-wrap: break-word; 
                  overflow-wrap: break-word;
                  white-space: normal;">
                    <div style="font-size: 20px; font-weight: bold;">${arg.event.title
                            }</div>
                      <div><strong>Local:</strong> ${arg.event.extendedProps.establecimiento || "No definido"
                            }</div>
                      <div><strong>Tiempo:</strong> ${calculateDuration(
                                arg.event.extendedProps.horainicio,
                                arg.event.extendedProps.horafinal
                            )}</div>` : arg.event.extendedProps.idagendaedicion !== null ? `
                    <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between; ">
                    <div>${horaInicio} - ${horaFinal}</div>
                    <div>${badgeHtml}</div>
                  </div>
                  <div style="padding: 8px; word-wrap: break-word; 
                  overflow-wrap: break-word;
                  white-space: normal;">
                    <div style="font-size: 20px; font-weight: bold;">${arg.event.title
                                }</div>
                      <div><strong>Local:</strong> ${arg.event.extendedProps.establecimiento || "No definido"
                                }</div>
                      <div><strong>Tiempo:</strong> ${calculateDuration(
                                    arg.event.extendedProps.horainicio,
                                    arg.event.extendedProps.horafinal
                                )}</div>
                    <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px;">
                      <button class="btn btn-primary" id="btnAsignarEditor" style="flex: 1;" data-idagendaeditor="${arg.event.extendedProps?.idagendaeditor}" data-idagendaedicion="${arg.event.extendedProps?.idagendaedicion}">Asignar</button>
                      <button class="btn btn-primary" id="btnVerProgreso" style="flex: 1;" data-idagendaedicion="${arg.event.extendedProps?.idagendaedicion}">Ver progreso</button>
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
                    <div style="font-size: 20px; font-weight: bold;">${arg.event.title
                            }</div>
                      <div><strong>Local:</strong> ${arg.event.extendedProps.establecimiento || "No definido"
                            }</div>
                      <div><strong>Tiempo:</strong> ${calculateDuration(
                                arg.event.extendedProps.horainicio,
                                arg.event.extendedProps.horafinal
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
                  ${arg.event.extendedProps.acuerdo ||
                                "Sin acuerdos registrados"
                                }
                </div>
                    ` : ''}                    
              
                    <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px;">                                                
              
                      ${nivelacceso == "Artista" ? `
                        <button class="btn btn-primary" id="btnVerMontos" style="flex: 1;" data-idcontrato="${arg.event.extendedProps?.idcontrato}" data-idconvenio="${arg.event.extendedProps?.idconvenio}">Ver Monto</button>
                      ` : ''}
                    </div>
                    `}
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
                    idusuario: evento.idusuarioEdicion
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
                    <div style="font-size: 20px; font-weight: bold;">${arg.event.title
                    }</div>
                      <div><strong>Local:</strong> ${arg.event.extendedProps.establecimiento || "No definido"
                    }</div>
                      <div><strong>Tiempo:</strong> ${calculateDuration(
                        arg.event.extendedProps.horainicio,
                        arg.event.extendedProps.horafinal
                    )}</div>
                  ${nivelacceso == "Administrador" ? `
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

    $q("#btnGuardarAsignacion").addEventListener("click", async () => {
        const idUsuarioSeleccionado = $q("#asignacioneditor").value;
        console.log("Editor elegido -> ", idUsuarioSeleccionado);

        // Obtener todas las tareas en la agenda
        const tareasRestantes = await obtenerTodasLasTareasEnLaAgenda(idagendaedicion);
        console.log("Tareas restantes -> ", tareasRestantes);

        // Verificar si todas las tareas ya están asignadas
        const totalTareas = 5; // Cambia este número si tienes más tipos de tareas
        const tareasAsignadas = new Set(tareasRestantes.map(tarea => tarea.tipotarea));

        if (tareasAsignadas.size >= totalTareas) {
            showToast("Todas las tareas ya han sido asignadas.", "ERROR");
            return;
        }

        // Verificar si el usuario ya tiene una tarea asignada
        console.log("idagendaeditorConsultar -> ", idagendaeditorConsultar);
        const tareaUsuario = await obtenerTareaPorUsuarioYagenda(idUsuarioSeleccionado, idagendaEdicionConsultar);
        console.log("¿Este usuario ya tiene una tarea? ->", tareaUsuario);

        if (tareaUsuario.length > 0) {
            showToast("Este Editor ya está asignado a una tarea.", "ERROR");
            return;
        }

        // Asignar la nueva tarea
        if ($q("#asignacioneditor").value.trim() == "" || $q("#tipotarea").value.trim() == "" || $q("#fechaentrega").value.trim() == "") {
            showToast("Faltan llenar algunos campos", "ERROR")
            return
        }

        const agendaEditorRegis = await asignarAgendaEditor(idagendaedicion);
        console.log("Agenda Editor Registrado -> ", agendaEditorRegis);
        modalAsignarEditor.hide()
        showToast("Tarea asignada correctamente", "SUCCESS");
        return //ME QUE DE ACAAAAA
    });

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
            await manejadorAgendaPorNivel("10")
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
            window.location.href = `http://localhost/vega-erp/views/agenda/asignar-agenda-edicion` */
            idagendaedicion = e.target.getAttribute("data-idagendaedicion");

            modalProgresoEdicion = new bootstrap.Modal($q("#modal-progresoedicion"));
            modalProgresoEdicion.show();

            const editoresAsignados = await obtenerEditoresAsignados(idagendaedicion)
            console.log("editoresAsignados ->", editoresAsignados);
            $q(".contenedor-tareas-edicion-pendientes").innerHTML = ``
            editoresAsignados.forEach(editor => {

                $q(".contenedor-tareas-edicion-pendientes").innerHTML += `
                <tr>
                    <td>${editor.fecha_entrega}</td>
                    <td>${editor.nombres}</td>
                    <td>${editor.tipotarea == 1 ? 'Flayer' : editor.tipotarea == 2 ? 'Saludos' : editor.tipotarea == 3 ? 'Reels' : editor.tipotarea == 4 ? 'Fotos' : editor.tipotarea == 5 ? 'Contenido' : 'No especificado'}</td>
                    <td>
                      <select name="estado" class="form-select select-estado" data-idagendaeditor="${editor.idagendaeditor}">
                          <option value="1" ${editor.estado == 1 ? 'selected' : ''}>Pendiente</option>
                          <option value="2" ${editor.estado == 2 ? 'selected' : ''}>Completado</option>
                      </select>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" id="btnAbrirModalSubir" data-idagendaeditor="${editor.idagendaeditor}">Ver</button>
                    </td>        
                </tr>       
                `
            });
            $all("#btnAbrirModalSubir").forEach(btn => {
                btn.addEventListener("click", (e) => {
                    idagendaeditor = e.target.getAttribute("data-idagendaeditor")
                    console.log("id agenda edicion -> ", idagendaeditor);
                    window.localStorage.clear()
                    window.localStorage.setItem("idagendaeditor", idagendaeditor)
                    window.location.href = `http://localhost/vega-erp/views/agenda/subir-contenido-edicion`
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

        }
        if (e.target && e.target.id === "btnAsignarEditor") {
            idagendaedicion = e.target.getAttribute("data-idagendaedicion");
            idagendaeditorConsultar = e.target.getAttribute("data-idagendaeditor");
            //idagendaEdicionConsultar = e.target.getAttribute("data-idagendaedicion")

            modalAsignarEditor = new bootstrap.Modal($q("#modal-asignareditor"));
            modalAsignarEditor.show();

            const tipotarea = await obtenerTodosTipoTarea()
            const usuariosEditores = await obtenerUsuarios(10) // edicion 
            const usuariosCManager = await obtenerUsuarios(8) // edicion 
            console.log("usuariosCManager ->",usuariosCManager);
            console.log("tipotarea -> ", tipotarea);
            $q(".contenedor-asignados").innerHTML = ''
            tipotarea.forEach(tipo => {
                $q(".contenedor-asignados").innerHTML += `
                <tr>
                    <td>${tipo.tipotarea}</td>
                    <td>
                        <select name="asignacioneditor" class="form-select" id="asignacioneditor" data-idtipotarea="${tipo.idtipotarea}">
                            <option value="1">Andres</option>
                        </select>
                    </td>
                    <td>
                        <input type="date" class="form-control" name="fechaentrega" id="fechaentrega">
                    </td>
                    <td>
                        <input type="time" class="form-control" name="horaentrega" id="horaentrega">
                    </td>
                    <td>
                        <select name="responsablepost" class="form-select" id="responsablepost">
                            <option value="1">Jasmin</option>
                        </select>
                    </td>
                </tr>
                `
            });
            
            document.querySelectorAll("select[name='asignacioneditor']").forEach(async select => {
                select.innerHTML = "<option value='-1'>Seleccione</option>"; // Opción predeterminada
                usuariosEditores.forEach(editor => {
                    select.innerHTML += `<option value="${editor.idusuario}">${editor.nombres}</option>`;
                });
                let idtipotarea = select.getAttribute("data-idtipotarea");
                console.log("ID Tipo de Tarea: ", idtipotarea);

                // Llamar la función asignarAgendaEditor cuando se seleccione un editor
                select.addEventListener("change", async (e) => {
                    let idusuario = e.target.value;
                    const tareaUsuario = await obtenerTareaPorUsuarioYagenda(idusuario, idagendaedicion);
                    //console.log("este usuario ya esta asignado a esta taraea");
                    
                    if(tareaUsuario.length > 0){
                        //console.log("¿Este usuario ya tiene una tarea? ->", tareaUsuario);
                        showToast("Este usuaruio ya fue asignado a una tarea", "ERROR")
                        return
                    }
                    if (idusuario !== "-1") {
                        let fechaentrega = $q("#fechaentrega").value;
                        let horaentrega = $q("#horaentrega").value;
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
                        if(response.idagendaeditor){
                            showToast("Editor asignado correctamente", "SUCCESS")
                            return
                        }
                    }
                });
            });
            
            document.querySelectorAll("select[name='responsablepost']").forEach(select => {
                select.innerHTML = "<option value='-1'>Seleccione</option>"; // Opción predeterminada
                usuariosCManager.forEach(editor => {
                    select.innerHTML += `<option value="${editor.idusuario}">${editor.nombres}</option>`;
                });
            });
            
            /* const editoresAsignados = await obtenerEditoresAsignados(idagendaedicion);
            console.log("editoresAsignados ->", editoresAsignados);
      
            const tareas = {
              1: null, 2: null, 3: null, 4: null, 5: null
            };
      
            // Mapear editores a sus respectivas tareas
            editoresAsignados.forEach(editor => {
              tareas[editor.tipotarea] = editor; // Ahora almacena el objeto completo
            });
      
            // Generar una sola fila con los editores en sus respectivas columnas
            $q(".contenedor-asignados").innerHTML = `
            <tr>
                <td>${tareas[1] ? tareas[1].nombres : "No asignado"} 
                    ${tareas[1] ? `<i class="fa-solid fa-trash btnQuitarUsuarioTarea" data-idagendaeditor="${tareas[1].idagendaeditor}"></i>` : ""}
                </td>
                <td>${tareas[2] ? tareas[2].nombres : "No asignado"} 
                    ${tareas[2] ? `<i class="fa-solid fa-trash btnQuitarUsuarioTarea" data-idagendaeditor="${tareas[2].idagendaeditor}"></i>` : ""}
                </td>
                <td>${tareas[3] ? tareas[3].nombres : "No asignado"} 
                    ${tareas[3] ? `<i class="fa-solid fa-trash btnQuitarUsuarioTarea" data-idagendaeditor="${tareas[3].idagendaeditor}"></i>` : ""}
                </td>
                <td>${tareas[4] ? tareas[4].nombres : "No asignado"} 
                    ${tareas[4] ? `<i class="fa-solid fa-trash btnQuitarUsuarioTarea" data-idagendaeditor="${tareas[4].idagendaeditor}"></i>` : ""}
                </td>
                <td>${tareas[5] ? tareas[5].nombres : "No asignado"} 
                    ${tareas[5] ? `<i class="fa-solid fa-trash btnQuitarUsuarioTarea" data-idagendaeditor="${tareas[5].idagendaeditor}"></i>` : ""}
                </td>
            </tr>
            `; */


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
})