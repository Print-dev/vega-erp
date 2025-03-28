document.addEventListener("DOMContentLoaded", async () => {
    // modales 
    let selectTareas = $q("#tarea")
    let selectResponsables = $q("#responsable")
    let selectNivelAcceso = $q("#nivelacceso")

    let modalNuevaTarea

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

    //let idnivelacceso = nivelacceso == "Filmmaker" ? 11 : nivelacceso == "Edicion y Publicidad" ? 10 : ''

    await obtenerTareas()

    // *********************************** OBTENCION DE DATAS **************************************************
    async function obtenerTareas() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTareas");
        const data = await getDatos(`${host}tareadiaria.controller.php`, params);
        console.log(data);
        selectTareas.innerHTML = "<option value=''>Seleccione</option>"
        data.forEach((tarea) => {
            selectTareas.innerHTML += `<option value="${tarea.idtareadiaria}">${tarea.tarea}</option>`;

        });
    }


    async function obtenerUsuarios(idnivelacceso) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", idnivelacceso);
        const data = await getDatos(`${host}usuario.controller.php`, params);
        console.log(data);
        //return data
        selectResponsables.innerHTML = "<option value=''>Seleccione</option>"
        data.forEach((tarea) => {
            selectResponsables.innerHTML += `<option value="${tarea.idusuario}">${tarea.nombres}</option>`;

        });

    }


    // ************************************* REGISTROS DE DATAS ************************************************
    async function asignarTareaDiaria(idusuario, idtareadiaria) {

        const body = new FormData();
        body.append("operation", "asignarTareaDiaria");
        body.append("idusuario", idusuario);
        body.append("idtareadiaria", idtareadiaria);
        body.append("fechaentrega", $q("#fechaentrega").value);
        body.append("horaentrega", $q("#horaentrega").value);

        const fbody = await fetch(`${host}tareadiaria.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function registrarTareaDiaria() {
        const body = new FormData();
        body.append("operation", "registrarTareaDiaria");
        body.append("tarea", $q("#txtNuevaTarea").value)

        const fbody = await fetch(`${host}tareadiaria.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    // *********************************** EVENTOS  **************************************************
    $q("#btnNuevaTarea").addEventListener("click", () => {
        modalNuevaTarea = new bootstrap.Modal($q("#modal-nuevatarea"))
        modalNuevaTarea.show()
    })

    $q("#btnGuardarNuevaTarea").addEventListener("click", async () => {
        try {
            console.log("vaor txt nueva tarea -> ", $q("#txtNuevaTarea").value);
            const tareaDIariaRegis = await registrarTareaDiaria()
            console.log("tareaDIariaRegis -> ", tareaDIariaRegis);
            if ($q("#txtNuevaTarea").value.trim() == "") {
                showToast("El campo tarea no puede ir vacio", "ERROR")
                return
            }
            if (tareaDIariaRegis.idtareadiaria) {
                showToast("Nueva Tarea Añadida!", "SUCCESS")
                $q("#txtNuevaTarea").value = ''
                //                selectTareas.innerHTML += `<option value="${tarea.idtareadiaria}">${tarea.tarea}</option>`;
                await obtenerTareas()
                modalNuevaTarea.hide()
                return
            }

        } catch (error) {
            showToast("Un error ha ocurrido!", "ERROR")
            return
        }
    })



    selectNivelAcceso.addEventListener("change", async (e) => {
        await obtenerUsuarios(e.target.value)
    })

    $q("#btnAgregarTarea").addEventListener("click", async () => {
        try {
            if ($q("#fechaentrega").value == "") {
                showToast("Seleccione fecha de entrega", "ERROR");
                return;
            }
            if ($q("#horaentrega").value == "") {
                showToast("Seleccione hora de entrega", "ERROR");
                return;
            }

            // Deshabilitar el botón y mostrar el icono de disquete
            const btn = $q("#btnAgregarTarea");
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-save"></i> Guardando...'; // Cambia al icono de disquete o uno similar

            const tareaDAsignada = await asignarTareaDiaria(selectResponsables.value, selectTareas.value);

            if (tareaDAsignada.idtaradiariaasig) {
                showToast("Tarea Asignada!", "SUCCESS", 1000);
            }

            // Rehabilitar el botón después de 3 segundos
            setTimeout(() => {
                btn.disabled = false;
                btn.innerHTML = 'Agregar Tarea'; // Reemplaza con el texto original
            }, 1000);

            window.location.href = `http://localhost/vega-erp/views/utilitario/tareasdiarias/listar-tareasdiarias`

        } catch (error) {
            showToast("Un error ha ocurrido!", "ERROR");

            // Rehabilitar el botón en caso de error
            const btn = $q("#btnAgregarTarea");
            btn.disabled = false;
            btn.innerHTML = 'Agregar Tarea'; // Reemplaza con el texto original
        }
    });

})