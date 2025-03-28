document.addEventListener("DOMContentLoaded", async () => {
    // VARAIBELS  
    let calendarEl
    let calendar
    let selectnivelacceso = $q("#nivelacceso")
    let selectusuario = $q("#usuario")
    let tareasDiariasRender = []
    //let contenedorBtnAsignarTareaDiaria = $q(".contenedor-btnasignar-tareadiaria")

    // MODALES
    let modalVerProgreso

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


    // HACER UNA ACTUALIZACION DE ESTADO AUTOMATICAMENTE APENAS ENTRE SI ES QUE ESTA VENCIDO
    const tareasObtenidas = await obtenerTareasDiariasPorUsuario(idusuarioLogeado)
    console.log("tarea sobtenidos diarai > ", tareasObtenidas);
    for (const tarea of tareasObtenidas) {
        if (tarea.estado == 1) {
            const fechaEntregaObt = new Date(`${tarea.fecha_entrega}T${tarea.hora_entrega}`);
            const ahoraObt = new Date();
            if (ahoraObt > fechaEntregaObt) {
                console.log("se vencio...");
                const estadoActVenc = await actualizarEstadoTareaDiariaAsignacion(tarea.idtaradiariaasig, 2)
                console.log("la tarea cambio de estado a vencido? > ", estadoActVenc);
            }
        }

    }


    // ***************************************** OBTENCION DE DATAS ******************************************************************


    async function obtenerTareasDiariasPorUsuario(idusuario) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTareasDiariasPorUsuario");
        params.append("idusuario", idusuario);
        const data = await getDatos(`${host}tareadiaria.controller.php`, params);
        return data
    }

    async function obtenerUsuarios(idnivelacceso) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", idnivelacceso);
        const data = await getDatos(`${host}usuario.controller.php`, params);
        console.log(data);
        //return data
        selectusuario.innerHTML = "<option value=''>Seleccione</option>"
        data.forEach((tarea) => {
            selectusuario.innerHTML += `<option value="${tarea.idusuario}">${tarea.nombres}</option>`;

        });

    }


    // ************************************************ ACTUALIZACION DE DATAS *********************************************************

    async function actualizarEstadoTareaDiariaAsignacion(idtaradiariaasig, estado) {
        const body = new FormData();
        body.append("operation", "actualizarEstadoTareaDiariaAsignacion");
        body.append("idtaradiariaasig", idtaradiariaasig); // id artista
        body.append("estado", estado);

        const fbody = await fetch(`${host}tareadiaria.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
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
        eventClick: async function (arg) {
            //const idtaradiariaasig = e.target.getAttribute("data-idtaradiariaasig");
            if (nivelacceso == "Administrador") {
                return
            }
            if (nivelacceso == "Filmmaker" || nivelacceso == "Edicion y Produccion") {
                const idtaradiariaasig = arg.event.extendedProps.idtaradiariaasig
                const estadoActual = arg.event.extendedProps.estado;

                // Validar si la tarea ya venció
                const fechaEntrega = new Date(`${arg.event.extendedProps.fecha_entrega}T${arg.event.extendedProps.hora_entrega}`);
                const ahora = new Date();
                let nuevoEstado;

                if (estadoActual === 1 || estadoActual === 2) {
                    // Si está en pendiente y se marca, decidir si es completado o completado con atraso
                    nuevoEstado = ahora > fechaEntrega ? 4 : 3; // 4 = Completado con atraso, 3 = Completado a tiempo
                } else {
                    // Si ya estaba marcado, volver a estado pendiente (1)
                    nuevoEstado = ahora > fechaEntrega ? 2 : 1; // 2 = Atrasado, 1 = Pendiente
                }

                console.log(`✅ Tarea ID ${idtaradiariaasig} cambiando a estado ${nuevoEstado}`);

                // Actualizar en la base de datos
                await actualizarEstadoTareaDiariaAsignacion(idtaradiariaasig, nuevoEstado);

                // Actualizar visualmente en el calendario
                let color;
                switch (nuevoEstado) {
                    case 4: color = "#FFA500"; break; // Naranja (Completado con atraso)
                    case 3: color = "#28a745"; break; // Verde (Completado a tiempo)
                    case 2: color = "#c64b4b"; break; // Rojo (Atrasado)
                    default: color = "#007bff"; // Azul (Pendiente)
                }

                arg.event.setExtendedProp("estado", nuevoEstado);
                arg.event.setProp("backgroundColor", color);

                // Forzar actualización del calendario
                calendar.refetchEvents();
            }
        } //ME QUEDE ACA CHECKPOUNT, RECIEN TERMINE DE PEGARLO, NO PROBE SI FUNCIONA AAA
    });
    calendar.render();
    calendar.setOption("locale", "es");
    ajustarEventos(); // Aplicar ajuste inicial

    // Detectar cambios de tamaño de pantalla y ajustar eventos
    window.addEventListener("resize", ajustarEventos);

    // **************************************************************** INICIALICZACION EN CASO DE USUARIOS INDEPENDIENTES (NO ADMIN) ***************************************************

    let nivelaccesoObtenido = nivelacceso == "Edicion y Produccion" ? 10 : nivelacceso == "Filmmaker" ? 11 : 0


    if (nivelaccesoObtenido) {
        $q("#btnAsignarTareaDiaria").remove()
        $q(".contenedor-select-tipo-filtro-edicion").remove()
        $q(".contenedor-select-usuario").remove()
        //await obtenerUsuarios(nivelaccesoObtenido)
        const tareasdiarias = await obtenerTareasDiariasPorUsuario(idusuarioLogeado)
        console.log("tareas diarias -> ", tareasdiarias);
        await configurarAgendaTareasDiarias(tareasdiarias)
        //console.log("usuarioso obtenidos > ",);
    }


    // *************************************************** CONFIGURACION DE CALENDARIO PARA EDITORES *****************************************************************************

    async function configurarAgendaTareasDiarias(tareasDiarias) {
        console.log("tareasDiarias recibidas -> ", tareasDiarias);

        if (!tareasDiarias || tareasDiarias.length === 0) {
            console.log("No hay tareas para mostrar.");
            calendar.removeAllEvents();
            return;
        }

        let tareasDiariasRender = []; // Asegurar que esté definido

        for (const evento of tareasDiarias) {
            if (!evento.fecha_entrega || !evento.hora_entrega) {
                console.warn("Evento con datos incompletos:", evento);
                continue; // Saltar eventos sin fecha u hora
            }

            // Combinar fecha y hora correctamente
            const fechaHoraEntrega = `${evento.fecha_entrega}T${evento.hora_entrega}`;

            tareasDiariasRender.push({
                title: evento.tarea,
                start: fechaHoraEntrega, // Corrección aquí                
                textColor: "black",
                extendedProps: {
                    fecha_entrega: evento.fecha_entrega,
                    hora_entrega: evento.hora_entrega,
                    idtareadiaria: evento.idtareadiaria,
                    idtaradiariaasig: evento.idtaradiariaasig,
                    estado: evento.estado
                },
            });
        }

        console.log("Eventos listos para agregar:", tareasDiariasRender);

        // Eliminar eventos previos antes de agregar nuevos
        calendar.removeAllEvents();
        calendar.addEventSource(tareasDiariasRender);

        console.log("Eventos agregados al calendario:", calendar.getEvents());
        console.log("Cantidad de eventos en el calendario:", calendar.getEvents().length);

        // Personalizar contenido del evento
        calendar.setOption("eventContent", function (arg) {
            const idtaradiariaasig = arg.event.extendedProps.idtaradiariaasig; // ID de la tarea
            const estado = arg.event.extendedProps.estado; // Estado de la tarea
            const fechaEntrega = arg.event.extendedProps.fecha_entrega;
            const horaEntrega = arg.event.extendedProps.hora_entrega;

            // Determinar si el checkbox debe estar marcado (estados 3 y 4 son completados)
            const isChecked = estado === 3 || estado === 4 ? "checked" : "";
            let colorCirculo = "#eae6e6";
            if (estado === 2) colorCirculo = "#c64b4b"; // Rojo
            if (estado === 3) colorCirculo = "#28a745";
            if (estado === 4) colorCirculo = "#ff9800"; // Naranja

            return {
                html: `
                    <div style="padding: 8px; border-radius: 10px; display: flex; align-items: center; gap: 10px;">
                        ${colorCirculo ? `<div style="width: 12px; height: 12px; background-color: ${colorCirculo}; border-radius: 50%;"></div>` : ""}
                        <div>${formatHour(horaEntrega)}</div>
                        <div>- ${arg.event.title}</div>
                        ${nivelacceso == "Administrador" ? '' : nivelacceso == "Filmmaker" || nivelacceso == "Edicion y Produccion" ? `<input type="checkbox" name="estado" class="checkbox-tarea" data-idtaradiariaasig="${idtaradiariaasig}" ${isChecked}>` : ''}
                    </div>
                `,
            };
        });
    }
    console.log("idusuarioLogeado ->>>>", idusuarioLogeado);
    const tarDiaRender = await obtenerTareasDiariasPorUsuario(idusuarioLogeado)
    console.log("tarDiaRender ->>>", tarDiaRender);
    await configurarAgendaTareasDiarias(tarDiaRender)

    //********************************************* EVENTOS ************************************************************************* */

    selectnivelacceso.addEventListener("change", async (e) => {
        await obtenerUsuarios(e.target.value)

    })

    selectusuario.addEventListener("change", async (e) => {
        console.log("valor select usuarios -> ", e.target.value);
        const tareasdiarias = await obtenerTareasDiariasPorUsuario(e.target.value)
        console.log("tareas diarias -> ", tareasdiarias);
        await configurarAgendaTareasDiarias(tareasdiarias)
    })

})