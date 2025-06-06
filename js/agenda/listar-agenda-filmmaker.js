document.addEventListener("DOMContentLoaded", async () => {
    // variables 
    let ws
    // Mantiene un indicador para saber si el WebSocket está listo para enviar
    let wsReady = false;
    let usuarioSelect = $q("#usuario")
    let agenda = []
    let calendar
    let listaSeleccionados = [];


    //CALENDARIO
    let calendarEl;

    // MODAL
    let modalAdmin

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

    /*     (async () => {
            ws = new WebSocket("ws://localhost:8000");
    
            ws.onopen = () => {
                wsReady = true;
                console.log("WebSocket abierto pe");
            };
    
            ws.onclose = () => {
                wsReady = false;
                console.log("WebSocket cerrado pe");
            };
        })(); */

    /*     function enviarPusher(idusuario, type, mensaje) {
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



    const usuariosAdmin = await obtenerUsuariosPorNivel("3")
    await renderizarAdmins(usuariosAdmin)



    // ************************************************ OBTENER DATOS *********************************************************************** */
    async function obtenerUsuarios(idnivelacceso) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", idnivelacceso);
        const data = await getDatos(`${host}usuario.controller.php`, params);
        console.log(data);
        usuarioSelect.innerHTML = "<option value=''>Todos</option>";
        data.forEach((artista) => {
            usuarioSelect.innerHTML += `<option value="${artista.idusuario}">${artista.nombres} (${artista.nom_usuario})</option>`;

        });

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

    function renderizarAdmins(usuarios) {
        const contenedor = document.querySelector(".contenedor-admins");
        contenedor.innerHTML = `<h5 class="mb-3">Notificar a</h5>`; // Limpia el contenido previo

        usuarios.forEach(usuario => {

            contenedor.innerHTML += `
            <div class="form-check">
                <input class="form-check-input chkAdmin" type="checkbox" id="admin-${usuario.idusuario}" data-idusuario="${usuario.idusuario}">
                <label class="form-check-label" for="admin-${usuario.idusuario}">${usuario.nombres}</label>
            </div>
            `;
        });

        $all(".chkAdmin").forEach(checkbox => {
            checkbox.addEventListener("change", function () {
                const idUsuario = this.getAttribute("data-idusuario");

                if (this.checked) {
                    if (!listaSeleccionados.includes(idUsuario)) {
                        listaSeleccionados.push(idUsuario);
                    }
                } else {
                    listaSeleccionados = listaSeleccionados.filter(id => id !== idUsuario);
                }
            });
        });
    }

    async function obtenerInfoViatico(iddetallepresentacion, idusuario) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerInfoViatico");
        params.append("iddetallepresentacion", iddetallepresentacion ? iddetallepresentacion : '');
        params.append("idusuario", idusuario ? idusuario : '');
        const fpersona = await getDatos(`${host}viatico.controller.php`, params)
        console.log(fpersona);
        return fpersona
    }


    async function obtenerDepartamentoPorId(iddepartamento) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDepartamentoPorId");
        params.append("iddepartamento", iddepartamento);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    async function obtenerViatico(idusuario) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerViatico");
        params.append("idusuario", idusuario);
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

    async function obtenerFilmmakers() { // PARA OBTENER DATOS DE CLIENTE Y DE EVENTO (NO INCLUYE TARIFARIO NI COSTO EN PRESENTACION DE TAL LOCAL)
        const params = new URLSearchParams();
        params.append("operation", "obtenerFilmmakers");
        const data = await getDatos(`${host}recurso.controller.php`, params);
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

    async function obtenerDPporId(iddp) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDPporId");
        params.append("iddetallepresentacion", iddp);
        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        return data;
    }

    async function obtenerEditoresAsignados(idagendaedicion) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerEditoresAsignados");
        params.append("idagendaedicion", idagendaedicion);
        const data = await getDatos(`${host}agenda.controller.php`, params);
        return data;
    }

    async function obtenerCajaChicaPorDP(iddetallepresentacion) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerCajaChicaPorDP");
        params.append("iddetallepresentacion", iddetallepresentacion);
        const data = await getDatos(`${host}cajachica.controller.php`, params);
        return data;
    }


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

    async function registrarGasto(idcajachica, concepto, monto) {
        const gasto = new FormData();
        gasto.append("operation", "registrarGasto");
        gasto.append("idcajachica", idcajachica);
        gasto.append("concepto", concepto); // id artista
        gasto.append("monto", monto);

        const fgasto = await fetch(`${host}cajachica.controller.php`, {
            method: "POST",
            body: gasto,
        });
        const rgasto = await fgasto.json();
        return rgasto;
    }

    async function registrarViatico(iddetallepresentacion, idusuario, desayuno, almuerzo, cena) {

        const viatico = new FormData();
        viatico.append("operation", "registrarViatico");
        viatico.append("iddetallepresentacion", iddetallepresentacion); // id artista
        viatico.append("idusuario", idusuario); // id artista
        viatico.append("pasaje", $q("#pasaje").value);
        viatico.append("hospedaje", $q("#hospedaje").value);
        viatico.append("desayuno", desayuno ? 1 : 0);
        viatico.append("almuerzo", almuerzo ? 1 : 0);
        viatico.append("cena", cena ? 1 : 0);

        const fviatico = await fetch(`${host}viatico.controller.php`, {
            method: "POST",
            body: viatico,
        });
        const rviatico = await fviatico.json();
        return rviatico;
    }

    async function registrarNotificacion(idusuariodest, filmmaker, tipo, idviatico, mensaje) {
        const viatico = new FormData();
        viatico.append("operation", "registrarNotificacion");
        viatico.append("idusuariodest", idusuariodest); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
        viatico.append("idusuariorem", filmmaker); // id usuario envia la notificacion
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

    async function actualizarViatico(idviatico) {
        const viatico = new FormData();
        viatico.append("operation", "actualizarViatico");
        viatico.append("idviatico", idviatico);
        viatico.append("pasaje", $q("#pasaje").value);
        viatico.append("comida", $q("#comida").value);
        //viatico.append("viaje", /* $q("#viaje").value ? $q("#viaje").value : ''); */

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

    async function renderizarInfoAgenda(idusuario, iddepartamento) {
        $q("#btnActualizarViatico").hidden = true
        $q("#btnGuardarViatico").hidden = false
        $q("#pasaje").value = ""
        $q("#comida").value = ""
        /* $q("#viaje").value = "" */
        let isLima = false;
        //console.log("iddp existe  ee -> ", iddp)
        console.log("idusuario filmmaker ->>>>>>>>>>>>>>>", idusuario);
        const viaticoExiste = await obtenerViatico(idusuario)
        console.log("viaticoExiste ._< ", viaticoExiste)
        if (viaticoExiste.length > 0) {
            $q("#pasaje").value = viaticoExiste[0]?.pasaje
            $q("#comida").value = viaticoExiste[0]?.comida
            /* $q("#viaje").value = viaticoExiste[0]?.viaje */
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
        /* if (isLima) {
            $q(".contenedor-viatico-viaje").hidden = true
        } else {
            $q(".contenedor-viatico-viaje").hidden = false
        } */

    }

    /* function mostrarNotificacionViatico(usuario) {
        if (Notification.permission === "granted") {
            new Notification("¡Nueva Notificación!", {
                body: "Permiso Concedido (Mnesaje de prueba).",
                icon: "https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/esawybumfjhhujupw5pa.png", // Puedes cambiar el icono
            });
        } else {
            console.log("El usuario no concedió permisos.");
        }
    } */

    function redondear(valor) {
        return parseFloat(valor || 0).toFixed(2);
    }

    async function guardarViatico() {
        if ($q("#hospedaje").value == "") {
            showToast("Por favor, complete los campos obligatorios", "ERROR");
            return;
        }

        const chkdesayuno = $q("#chkdesayuno").checked ? 1 : 0
        const chkalmuerzo = $q("#chkalmuerzo").checked ? 1 : 0
        const chkcena = $q("#chkcena").checked ? 1 : 0

        console.log("check desauno? .> ", chkdesayuno);
        console.log("check chkalmuerzo? .> ", chkalmuerzo);
        console.log("check chkcena? .> ", chkcena);

        if (listaSeleccionados.length == 0) {
            showToast("Eliga a quienes notificar su viatico", "INFO")
            return
        }
        const viaticoRegistrado = await registrarViatico(iddp, idusuarioLogeado, chkdesayuno, chkalmuerzo, chkcena);
        console.log("viaticoRegistrado -> ", viaticoRegistrado);

        const pasaje = $q("#pasaje").value ? $q("#pasaje").value : 0
        const hospedaje = $q("#hospedaje").value ? $q("#hospedaje").value : 0
        const montoDesayuno = $q("#chkdesayuno").checked ? 13.30 : 0
        const montoAlmuerzo = $q("#chkalmuerzo").checked ? 13.30 : 0
        const montoCena = $q("#chkcena").checked ? 13.30 : 0
        const totalViatico = redondear(parseFloat(pasaje) + parseFloat(hospedaje) + parseFloat(montoDesayuno) + parseFloat(montoAlmuerzo) + parseFloat(montoCena))

        const usuarioFilmmaker = await obtenerUsuarioPorId(idusuarioLogeado);
        console.log("usuarioFilmmaker -> ", usuarioFilmmaker)
        if (viaticoRegistrado.idviatico) {
            // Construir descripción del gasto dinámicamente
            let conceptos = [];
            if (parseFloat(pasaje) > 0) conceptos.push(`Pasaje: S/. ${parseFloat(pasaje).toFixed(2)}`);
            if (parseFloat(hospedaje) > 0) conceptos.push(`Hospedaje: S/. ${parseFloat(hospedaje).toFixed(2)}`);
            if (chkdesayuno) conceptos.push(`Desayuno: S/. 13.30`);
            if (chkalmuerzo) conceptos.push(`Almuerzo: S/. 13.30`);
            if (chkcena) conceptos.push(`Cena: S/. 13.30`);

            const nombreUsuario = `${usuarioFilmmaker[0]?.dato} ${usuarioFilmmaker[0]?.apellidos}`;
            const descripcionGasto = `Viático de Filmmaker ${nombreUsuario}:\n${conceptos.join("\n")}`;

            console.log("id detalle presentacion para registrarlo con la nueva caja chica .> ", iddp);
            const cajaChicaExistente = await obtenerCajaChicaPorDP(iddp)
            console.log("caja chica existente -> ", cajaChicaExistente);
            if (cajaChicaExistente.length > 0) {

                if (cajaChicaExistente[0].idcajachica) {
                    console.log("Caja chica registrada correctamente.");
                    const viaticoGasto = await registrarGasto(cajaChicaExistente[0]?.idcajachica, descripcionGasto, totalViatico)
                    console.log("viatico gasto -> ", viaticoGasto);
                }
            } else {
                const viaticoCaja = await registrarCajaChica(iddp, 1, 0, 0, 0, 0)
                console.log("viaticoCaja -> ", viaticoCaja);
                if (viaticoCaja.idcajachica) {
                    console.log("Caja chica registrada correctamente.");
                    const viaticoGasto = await registrarGasto(viaticoCaja.idcajachica, descripcionGasto, totalViatico)
                    console.log("viatico gasto -> ", viaticoGasto);
                }
            }

            console.log("Entrando a la validación...");

            const mensaje = `${usuarioFilmmaker[0]?.dato} ha reportado un viático, haz click para ver`;
            console.log("admins seleccionados -> ", listaSeleccionados);
            // Enviar notificación a cada administrador seleccionado
            for (const idAdmin of listaSeleccionados) {
                console.log("registrando viatic..");
                const notificacionRegistrada = await registrarNotificacion(idAdmin, idusuarioLogeado, 1, viaticoRegistrado.idviatico, mensaje);
                console.log(`Notificación enviada a ${idAdmin}:`, notificacionRegistrada);
                enviarPusher(idAdmin, "viatico", mensaje)
            }

            document.querySelectorAll(".chkAdmin").forEach(checkbox => {
                checkbox.checked = false;
            });
            showToast("Viático registrado correctamente", "SUCCESS");
            listaSeleccionados = []
            $q("#pasaje").value = ""
            $q("#hospedaje").value = ""
            /* $q("#viaje").value = "" */
            $q("#chkdesayuno").checked = false
            $q("#chkalmuerzo").checked = false
            $q("#chkcena").checked = false
            modalViatico.hide();

        }
    }



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
            left: "today",
            center: "prev title next",
            right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth", // Filtros de vista
        },
        events: [], // Aquí se cargarán los eventos dinámicamente
        locale: "es",
        dayMaxEvents: 1, // Muestra hasta 3 eventos antes de colapsar
        eventLimitClick: "popover", // Muestra un popover con los eventos restantes
        eventClick: async function (evento) {
            const btnVerViatico = evento.jsEvent.target.closest("#btnVerViatico");
            const btnViatico = evento.jsEvent.target.closest("#btnViatico");

            if (btnVerViatico) {
                console.log("clbikc a btn");

                idusuarioFilmmaker = parseInt(btnVerViatico.getAttribute("data-idusuarioFilmmaker"))
                iddp = parseInt(btnVerViatico.getAttribute("data-iddp"))
                //const viaticoExiste = await obtenerViatico(idusuarioFilmmaker)
                //console.log("viaticoExiste ->",viaticoExiste);
                modalNotificacion = new bootstrap.Modal($q("#modal-notificacion")); //
                modalNotificacion.show();
                console.log("idusuarioFilmmaker -> ", idusuarioFilmmaker);
                const infoViatico = await obtenerInfoViatico(iddp, idusuarioFilmmaker)
                console.log("infoviatico -< ", infoViatico);
                const usuarioFilmmakerObtenido = await obtenerUsuarioPorId(idusuarioFilmmaker)
                console.log("usuarioFilmmakerObtenido -> ", usuarioFilmmakerObtenido);
                cargarViaticoFilmmaker(null, usuarioFilmmakerObtenido[0], infoViatico.at(-1))

            }
            if (btnViatico) {
                iddp = btnViatico.getAttribute("data-iddp");
                iddepartamento = btnViatico.getAttribute("data-iddepartamento");
                idusuarioFilmmaker = btnViatico.getAttribute("data-idusuarioFilmmaker");
                console.log("ID DEPARTAMENTO ELEGIDO -> ", iddepartamento)
                console.log("iddetalle_repsentacion elegida -> ", iddp)

                let isLima = false;
                const departamento = await obtenerDepartamentoPorId(iddepartamento)
                console.log("departamento -> ", departamento)
                if (departamento[0].iddepartamento == 15) { // LIMA
                    isLima = true;
                }

                console.log("isLima ??", isLima)
                if (isLima) {
/*                     $q(".contenedor-viatico-viaje").hidden = true
 */                    showToast("No se puede reportar viatico para eventos en lima", "ERROR")
                    return
                } else {
/*                     $q(".contenedor-viatico-viaje").hidden = false
 */                    modalViatico = new bootstrap.Modal($q("#modal-viatico"));
                    modalViatico.show()
                }
                //await renderizarInfoAgenda(idusuarioFilmmaker, iddepartamento)

            }
            /* $q("#btnActualizarViatico").addEventListener("click", async () => {
                const viaticoActualizado = await actualizarViatico(idviatico)
                console.log("viaticoActualizado -> ", viaticoActualizado)
                if (viaticoActualizado.update) {
                    showToast("Viático actualizado correctamente", "SUCCESS")
                    return
                }
            })
 */
            $q("#btnGuardarViatico").removeEventListener("click", guardarViatico); // Elimina listeners previos
            $q("#btnGuardarViatico").addEventListener("click", guardarViatico);




            console.log("evento -> ", evento)

            if (evento.event.extendedProps.estadoBadge.text == "Incompleto") {
                if (nivelacceso == "Artista" || nivelacceso == "Filmmaker") {
                    return

                }
                window.localStorage.clear()
                window.localStorage.setItem("iddp", evento.event.extendedProps.iddetalle_presentacion)
                window.location.href = `${hostOnly}/views/ventas/actualizar-atencion-cliente`
            }
            /* const idDetalle = evento.event.extendedProps.iddetalle_presentacion;
            await renderizarInfoAgenda(idDetalle);
            // Evento al hacer clic en una tarea
            modalInfoAgenda = new bootstrap.Modal($q("#modal-infoagendaartista"));
            modalInfoAgenda.show(); */
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
            //if(nivelacceso == "Edicion ")
            content.innerHTML = `
                <div style="padding: 8px; border-radius: 10px; display: flex; justify-content: space-between;">
                      <div>${horaInicio} - ${horaFinal}</div>
                      <div>${badgeHtml}</div>
                    </div>
        <div style="padding: 8px; word-wrap: break-word; 
                    overflow-wrap: break-word;
                    white-space: normal;">
            <div style="font-size: 20px; font-weight: bold;">${info.event.extendedProps?.title
                }</div>
            <div><strong>Local:</strong> ${info.event.extendedProps?.establecimiento || "No definido"
                }</div>
            <div><strong>Tiempo:</strong> ${calculateDuration(
                    info.event.extendedProps?.horainicio,
                    info.event.extendedProps?.horafinal
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
                    ${info.event.extendedProps?.acuerdo ||
                    "Sin acuerdos registrados"
                    }
                  </div>
                      ` : ''}
            ${nivelacceso == "Administrador" ? `
                        <div class="mt-2"><strong>FILMMAKER:</strong> ${info.event.extendedProps?.filmmaker ? info.event.extendedProps?.filmmaker : 'No asignado'}</div>
                      ` : ''}

            <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px;">
                ${nivelacceso == "Administrador" ? `
                          <button class="btn btn-primary" id="btnVerViatico" style="flex: 1;" data-iddp="${info.event.extendedProps?.iddetalle_presentacion}" data-idusuarioFilmmaker="${info.event.extendedProps?.idusuariofilmmaker}" data-iddp="${info.event.extendedProps?.iddetalle_presentacion}" data-idviatico="${info.event.extendedProps?.idviatico}">Ver Viatico</button>
                        ` : ``}

                ${info.event.extendedProps?.estadoBadge.text == "Incompleto" || info.event.extendedProps?.estadoBadge.text == "No Confirmado" ? '<div class="mt-2 bg-white"><strong>Pendiente a ser aprobado</strong></div>' : nivelacceso == "Filmmaker" ? `
                          <button class="btn btn-primary" id="btnViatico" style="flex: 1;" data-iddp="${info.event.extendedProps?.iddetalle_presentacion}" data-idviatico="${info.event.extendedProps?.idviatico}" data-iddepartamento="${info.event.extendedProps?.iddepartamento}">Reportar Viático</button>
                        ` : ''}

                ${nivelacceso == "Artista" ? `
                          <button class="btn btn-primary" id="btnVerMontos" style="flex: 1;" data-idcontrato="${info.event.extendedProps?.idcontrato}" data-idconvenio="${info.event.extendedProps?.idconvenio}">Ver Monto</button>
                        ` : ''}
            </div>
              `;

            const instance = tippy(info.el, {
                content: content,
                interactive: true,
                trigger: "click",
                allowHTML: true,
                theme: "custom", // usamos tema personalizado
                placement: "auto",
                onShow(instance) {
                    // Espera un pequeño tiempo para que el DOM esté listo
                    setTimeout(() => {
                        const btnViatico = $q("#btnViatico");
                        const btnVerViatico = $q("#btnVerViatico");
                        if (btnViatico) {
                            btnViatico.addEventListener("click", async (e) => {
                                iddp = btnViatico.getAttribute("data-iddp");
                                iddepartamento = btnViatico.getAttribute("data-iddepartamento");
                                idusuarioFilmmaker = btnViatico.getAttribute("data-idusuarioFilmmaker");
                                console.log("ID DEPARTAMENTO ELEGIDO -> ", iddepartamento)
                                console.log("iddetalle_repsentacion elegida -> ", iddp)

                                let isLima = false;
                                const departamento = await obtenerDepartamentoPorId(iddepartamento)
                                console.log("departamento -> ", departamento)
                                if (departamento[0].iddepartamento == 15) { // LIMA
                                    isLima = true;
                                }

                                console.log("isLima ??", isLima)
                                if (isLima) {
/*                     $q(".contenedor-viatico-viaje").hidden = true
 */                    showToast("No se puede reportar viatico para eventos en lima", "ERROR")
                                    return
                                } else {
/*                     $q(".contenedor-viatico-viaje").hidden = false
 */                    modalViatico = new bootstrap.Modal($q("#modal-viatico"));
                                    modalViatico.show()
                                }
                            });
                        }
                        if (btnVerViatico) {
                            btnVerViatico.addEventListener("click", async (e) => {
                                console.log("clbikc a btn");

                                idusuarioFilmmaker = parseInt(btnVerViatico.getAttribute("data-idusuarioFilmmaker"))
                                iddp = parseInt(btnVerViatico.getAttribute("data-iddp"))
                                //const viaticoExiste = await obtenerViatico(idusuarioFilmmaker)
                                //console.log("viaticoExiste ->",viaticoExiste);
                                modalNotificacion = new bootstrap.Modal($q("#modal-notificacion")); //
                                modalNotificacion.show();
                                console.log("idusuarioFilmmaker -> ", idusuarioFilmmaker);
                                const infoViatico = await obtenerInfoViatico(iddp, idusuarioFilmmaker)
                                console.log("infoviatico -< ", infoViatico);
                                const usuarioFilmmakerObtenido = await obtenerUsuarioPorId(idusuarioFilmmaker)
                                console.log("usuarioFilmmakerObtenido -> ", usuarioFilmmakerObtenido);
                                cargarViaticoFilmmaker(null, usuarioFilmmakerObtenido[0], infoViatico.at(-1))
                            });
                        }
                    }, 10);
                },
            });
        }



    });

    calendar.render();
    calendar.setOption("locale", "es");
    ajustarEventos(); // Aplicar ajuste inicial

    // Detectar cambios de tamaño de pantalla y ajustar eventos
    window.addEventListener("resize", ajustarEventos);

    if (nivelacceso == "Filmmaker") {
        agenda = []
        //$q("#nivelacceso").remove()
        $q("#usuario").remove()
        $q(".contenedor-filtros-agenda").remove()
        const agendaUsuario = await obtenerAgendaFilmmakers(idusuarioLogeado, null, 11);
        console.log("agendaUsuario todo obtenido ->", agendaUsuario);

        await configurarCalendario(agendaUsuario)
        return
    }

    // ********************************************* RENDERIZAR USUARIOS EN EL SELECT *******************************************************
    await obtenerUsuarios("11");
    const agendaUsuario = await obtenerAgendaFilmmakers(null, null, 11);
    console.log("agendaUsuario todo obtenido ->", agendaUsuario);
    await configurarCalendario(agendaUsuario) // ESTO SE RENDERIZARA APENAS ABRA ESTA VENTANA DE


    async function configurarCalendario(agendaUsuario) {
        //        agenda = [];  // Resetear la lista para evitar duplicados

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

            if (evento.estado == 2) {
                estadoBadge = {
                    text: "Caducado",
                    class: "badge bg-danger",
                };
            }
            else if (incompleto) {
                estadoBadge = {
                    text: "Incompleto",
                    class: "badge bg-danger",
                };
            } else if (evento.estado == 3) {
                estadoBadge = {
                    text: "Cancelado",
                    class: "badge bg-danger",
                };
            } else {
                if (esContratoValido || esConvenioValido) {
                    estadoBadge = {
                        text: "Confirmado",
                        class: "badge bg-success",
                    };
                }
            }

            // Ahora podemos esperar la obtención del filmmaker
            //const filmmakerObtenido = await obtenerFilmmakerAsignado(evento.iddetalle_presentacion);
            //console.log("filmmakerObtenido -> ", filmmakerObtenido);

            if (nivelacceso) { //evento?.estado == 1 &&  evento?.idusuario == idusuarioLogeado || filmmakerObtenido[0]?.idusuario == idusuarioLogeado || 
                //console.log("entre pq soy admin");
                console.log("Evento agregado a la agenda:", evento);

                agenda.push({
                    title: evento.nom_usuario,
                    start: evento.fecha_presentacion,
                    iddetalle_presentacion: evento.iddetalle_presentacion,
                    backgroundColor: `rgb(252, 249, 246)`,
                    borderColor: `rgb(252, 249, 246)`,
                    textColor: "black",
                    extendedProps: {
                        estadoBadge,
                        horainicio: evento.horainicio,
                        horafinal: evento.horafinal,
                        backgroundColor: evento.color,
                        title: evento.nom_usuario,
                        establecimiento: evento.establecimiento,
                        iddepartamento: evento.iddepartamento,
                        idusuario: evento.idusuario,
                        acuerdo: evento.acuerdo,
                        idcontrato: evento.idcontrato,
                        idconvenio: evento.idconvenio,
                        estado: evento.estado,
                        idviatico: evento.idviatico,
                        idusuariofilmmaker: evento.idusuarioAgenda,
                        filmmaker: evento.filmmaker || "No asignado",

                        //idagendaedicion: evento.idagendaedicion
                    },
                });
            }
        }
        // Limpiar eventos previos y agregar los nuevos al calendario
        calendar.removeAllEvents();
        calendar.addEventSource(agenda);

        console.log("Eventos agregados al calendario:", calendar.getEvents());
        console.log("Cantidad de eventos en el calendario:", calendar.getEvents().length);

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
            let establecimiento = arg.event.extendedProps.establecimiento || '';
            let maxLength = 5;

            if (establecimiento.length > maxLength) {
                establecimiento = establecimiento.substring(0, maxLength) + '...';
            }
            return {
                html:
                    `
                     <div style="
            ${arg.event.extendedProps.estadoBadge.text == "Incompleto" ? `background-color: rgb(255, 83, 83);` : ''}
            padding: 4px 6px; 
            word-wrap: break-word; 
            overflow-wrap: break-word; 
            white-space: normal; 
            max-width: 220px; 
            font-size: 12px; 
            display: flex; 
            align-items: center;
            gap: 6px;
            ">
            <div style="
                width: 10px; 
                height: 10px; 
                border-radius: 50%; 
                background-color: ${arg.event.extendedProps.backgroundColor || '#28a745'};
                flex-shrink: 0;
            "></div>
            <span class="titulo-card">
                ${arg.event.title}
                - ${establecimiento || "No definido"}
            </span>
            </div>
            `,
            };
        });
    }

    // ************************************* EVENTOS **********************************************************************

    usuarioSelect.addEventListener("change", async (e) => {
        agenda = [] // cada que se cambia de filtro de usuario se limpia el calendario para renderizarlo con nuevos datos
        idUsuario = e.target.value;
        console.log("idUsuario  ->>>>", idUsuario);


        if (idUsuario === "" || idUsuario == -1) {
            const agendaUsuario = await obtenerAgendaFilmmakers(null, null, 11);
            console.log("agendaUsuario todo obtenido ->", agendaUsuario);

            await configurarCalendario(agendaUsuario)
            return;
        }
        const agendaUsuario = await obtenerAgendaFilmmakers(idUsuario, null, 11);
        console.log("agendaUsuario todo obtenido ->", agendaUsuario);

        if (agendaUsuario.length > 0) {
            await configurarCalendario(agendaUsuario)
        } else {
            await configurarCalendario([])
        }
        await configurarCalendario([])

    });


    // ***************************************** FUNCIONES UTILES *************************************************************

    function cargarViaticoFilmmaker(notificacion, usuario, viatico) {
        const fechahoraSeparada = notificacion?.fecha.split(" ")
        const contenedorModal = $q(".contenedor-notificacion");
        if (viatico) {
            contenedorModal.innerHTML = `
          ${fechahoraSeparada ? `<p class="text-muted mb-2"><strong>${formatDate(fechahoraSeparada[0] + " " + formatHour(fechahoraSeparada[1]))}</strong></p>` : ''}
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
        else {
            contenedorModal.innerHTML = `<label class="fw-bold">Aun no hay viatico</label></span>`
        }
    }
})