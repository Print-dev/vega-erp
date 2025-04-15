document.addEventListener("DOMContentLoaded", async () => {
    let iddp = window.localStorage.getItem("iddp")
    let idartista = -1

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

    // *************************************** OBTENCION DE DATOS **************************************
    async function obtenerInfoDPporId(iddp) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerInfoDPporId");
        params.append("iddetallepresentacion", iddp);
        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        return data;
    }

    async function obtenerDpPorFecha(idusuario, fechapresentacion) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDpPorFecha");
        params.append("idusuario", idusuario);
        params.append("fechapresentacion", fechapresentacion);
        const dpfecha = await getDatos(`${host}detalleevento.controller.php`, params)
        console.log(dpfecha);
        return dpfecha
    }

    async function actualizarDetallePresentacion(iddetallepresentacion) {
        const dp = new FormData();
        dp.append("operation", "actualizarDetallePresentacion");
        dp.append("iddetallepresentacion", iddetallepresentacion); // id artista
        dp.append("fechapresentacion", $q("#fechapresentacion").value ? $q("#fechapresentacion").value : '');
        dp.append("horainicio", $q("#horainicio").value ? $q("#horainicio").value : '');
        dp.append("horafinal", $q("#horafinal").value ? $q("#horafinal").value : '');
        dp.append("establecimiento", $q("#establecimiento").value ? $q("#establecimiento").value : '');
        dp.append("referencia", $q("#referencia").value ? $q("#referencia").value : '');
        dp.append("tipoevento", $q("#tipoevento").value ? $q("#tipoevento").value : '');
        dp.append("modotransporte", $q("#modotransporte").value ? $q("#modotransporte").value : '');
        dp.append("validez", $q("#validez").value ? $q("#validez").value : '');
        dp.append("igv", $q("#igv").checked ? 1 : 0);
        dp.append("iddistrito", $q("#distrito2").value ? $q("#distrito2").value : '');

        const fdp = await fetch(`${host}detalleevento.controller.php`, {
            method: "POST",
            body: dp,
        });
        const rdp = await fdp.json();
        return rdp;
    }

    async function renderizarDetalleEvento() {
        $q("#container-validez").hidden = true

        const infoDp = await obtenerInfoDPporId(iddp)
        console.log("info dp -> ", infoDp);
        idartista = infoDp[0]?.idusuario
        $q("#fechapresentacion").value = infoDp[0]?.fecha_presentacion
        $q("#horainicio").value = infoDp[0]?.horainicio
        $q("#horafinal").value = infoDp[0]?.horafinal
        $q("#establecimiento").value = infoDp[0]?.establecimiento
        $q("#referencia").value = infoDp[0]?.referencia
        $q("#tipoevento").value = infoDp[0]?.tipo_evento
        $q("#modotransporte").value = infoDp[0]?.modotransporte
        $q("#validez").value = infoDp[0]?.validez
        $q("#igv").checked = infoDp[0]?.igv == 1 ? true : 0
        if (infoDp[0]?.modalidad == 1) {
            $q("#container-validez").hidden = true
        } else {
            $q("#container-validez").hidden = false
        }

        if (infoDp[0]?.iddistrito) {
            await cargarUbigeoDesdeDistrito(infoDp[0]?.iddistrito);
        }
    }

    async function cargarUbigeoDesdeDistrito(idDistrito) {
        try {
            // 1️⃣ Obtener datos del distrito
            let distrito = await fetch(`${host}recurso.controller.php?operation=obtenerDistritoPorId&iddistrito=${idDistrito}`).then(res => res.json());
            console.log("TODAS LAS DISTRTITOS OBTENIDOAS  -> ", distrito)

            // 2️⃣ Obtener todas las provincias y marcar la seleccionada
            let provincias = await fetch(`${host}recurso.controller.php?operation=obtenerTodosProvincias`).then(res => res.json());
            console.log("TODAS LAS PROVINCIAS OBTENIDOAS  -> ", provincias)
            let provinciaSeleccionada = provincias.find(p => p.idprovincia == distrito[0].idprovincia);
            console.log("LA PROVINCIA SELCCIONADA - ", provinciaSeleccionada)

            $q("#provincia2").innerHTML = provincias.map(p =>
                `<option value="${p.idprovincia}" ${p.idprovincia === distrito[0].idprovincia ? "selected" : ""}>${p.provincia}</option>`
            ).join("");

            // 3️⃣ Obtener todas los departamentos y marcar el correcto
            let departamentos = await fetch(`${host}recurso.controller.php?operation=obtenerTodosDepartamentos`).then(res => res.json());
            console.log("TODOS LOS DEPARTAMENTOS OBTENIDOS -> ", departamentos)
            console.log("LA PROVINCIA SELCCIONADA - ", provinciaSeleccionada)
            let departamentoSeleccionado = departamentos.find(d => d.iddepartamento === provinciaSeleccionada.iddepartamento);
            console.log("DEPARTAMENTO SELCCIONADO -> ", departamentoSeleccionado)
            $q("#departamento2").innerHTML = departamentos.map(d =>
                `<option value="${d.iddepartamento}" ${d.iddepartamento === provinciaSeleccionada.iddepartamento ? "selected" : ""}>${d.departamento}</option>`
            ).join("");

            // 4️⃣ Obtener todas las nacionalidades y marcar la correcta
            let nacionalidades = await fetch(`${host}recurso.controller.php?operation=obtenerTodosNacionalidades`).then(res => res.json());
            console.log("NACIONALIDADES TODAS OBTENIDAS : ", nacionalidades)
            let nacionalidadSeleccionada = nacionalidades.find(n => n.idnacionalidad === departamentoSeleccionado.idnacionalidad);
            $q("#nacionalidad2").innerHTML = nacionalidades.map(n =>
                `<option value="${n.idnacionalidad}" ${n.idnacionalidad === departamentoSeleccionado.idnacionalidad ? "selected" : ""}>${n.nacionalidad}</option>`
            ).join("");

            // 5️⃣ Obtener todos los distritos y seleccionar el correcto
            let distritos = await fetch(`${host}recurso.controller.php?operation=obtenerTodosDistritos`).then(res => res.json());
            $q("#distrito2").innerHTML = distritos.map(d =>
                `<option value="${d.iddistrito}" ${d.iddistrito === idDistrito ? "selected" : ""}>${d.distrito}</option>`
            ).join("");

        } catch (error) {
            console.error("Error cargando ubigeo:", error);
        }
    }

    await renderizarDetalleEvento()
    // *********************************** ACTUALIZACION DE DATOS **************************************

    // **************************************** EVENTOS ***********************************************

    $q("#btnActualizarEvento").addEventListener("click", async () => {
        try {
            const fechaSeleccionada = $q("#fechapresentacion").value;
            const horaInicioSeleccionada = $q("#horainicio").value;
            const horaFinalSeleccionada = $q("#horafinal").value;

            const fechaOcupada = await obtenerDpPorFecha(idartista, fechaSeleccionada);
            console.log("Fechas ocupadas recibidas: ", fechaOcupada);

            if (!fechaOcupada || !Array.isArray(fechaOcupada)) {
                showToast("Error: No se obtuvo información de la fecha ocupada.", "ERROR");
                return;
            }

            // 1️⃣ Verificar si hay al menos un evento vencido (estado == 2)
            const hayEventoVencido = fechaOcupada.some(evento => evento.estado === 2);
            console.log("¿Hay eventos vencidos?", hayEventoVencido);

            // 2️⃣ Verificar si hay un evento con la **misma fecha y superposición de horario**
            const horarioSuperpuesto = fechaOcupada.some(evento => {
                // Si el evento no tiene hora de inicio o fin, no hay superposición posible
                if (!evento.horainicio || !evento.horafinal) {
                    console.log("Evento sin horarios asignados, no se considera como superposición.");
                    return false;
                }

                console.log("evento horainicio -> ", evento.horainicio);
                console.log("evento horafinal -> ", evento.horafinal);

                const eventoInicio = convertirAHorasTotales(evento.horainicio);
                let eventoFinal = convertirAHorasTotales(evento.horafinal);
                let inicioNuevo = convertirAHorasTotales(horaInicioSeleccionada);
                let finalNuevo = convertirAHorasTotales(horaFinalSeleccionada);

                // Ajustamos si el evento pasa de medianoche
                if (eventoFinal < eventoInicio) eventoFinal += 1440;
                if (finalNuevo < inicioNuevo) finalNuevo += 1440;

                return evento.fecha_presentacion === fechaSeleccionada &&
                    !(
                        finalNuevo <= eventoInicio ||
                        inicioNuevo >= eventoFinal
                    );
            });

            console.log("horaFinalSeleccionada -> ", horaFinalSeleccionada);
            console.log("horaInicioSeleccionada -> ", horaInicioSeleccionada);
            console.log("¿Existe superposición de horarios?", horarioSuperpuesto);

            // ❌ Si hay otro evento en la misma fecha y se superpone en el horario, NO permitir registrar
            if (horarioSuperpuesto) {
                if (!(iddp == fechaOcupada[0].iddetalle_presentacion)) {
                    showToast("No se puede registrar el evento: ya existe otro en la misma fecha y horario.", "ERROR");
                    return;
                }
            }

            // ✅ Si hay al menos un evento vencido (estado == 2) o no hay conflicto de horarios, permitir registrar
            if (hayEventoVencido || fechaOcupada.length === 0 || !horarioSuperpuesto) {
                permitirRegistrar = true;
            } else {
                if (!(iddp == fechaOcupada[0].iddetalle_presentacion)) {
                    showToast("Esta fecha ya está tomada por otro evento.", "ERROR");
                    return;
                }

            }

            const dpActualizado = await actualizarDetallePresentacion(iddp);
            console.log("dp actualizado ? -> ", dpActualizado);

            if (dpActualizado) {
                showToast("Actualizado Correctamente.", "SUCCESS");
                return;
            }

        } catch (error) {
            console.error("Error capturado:", error);
            showToast("Un error ha ocurrido", "ERROR");
        }
    });

})