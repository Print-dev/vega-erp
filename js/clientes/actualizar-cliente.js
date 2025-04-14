document.addEventListener("DOMContentLoaded", async () => {
    const idcliente = window.localStorage.getItem("idcliente");
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

    // ************************************* OBTENER UBIGEOS ******************************
    async function obtenerDepartamentos(iddepartamento) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDepartamentos");
        params.append("idnacionalidad", iddepartamento);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    async function obtenerProvincias(iddepartamento) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerProvincias");
        params.append("iddepartamento", iddepartamento);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    async function obtenerDistritos(idprovincia) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDistritos");
        params.append("idprovincia", idprovincia);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    $q("#nacionalidad").addEventListener("change", async () => {
        const departamentos = await obtenerDepartamentos($q("#nacionalidad").value);
        $q("#departamento").innerHTML = "<option value=''>Selecciona</option>";
        departamentos.forEach(dpa => {
            $q("#departamento").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
        });
    });


    $q("#departamento").addEventListener("change", async () => {
        const provincias = await obtenerProvincias($q("#departamento").value);
        $q("#provincia").innerHTML = "<option value=''>Selecciona</option>";
        provincias.forEach(prv => {
            $q("#provincia").innerHTML += `<option value="${prv.idprovincia}">${prv.provincia}</option>`;
        });
    });

    $q("#provincia").addEventListener("change", async () => {
        const distritos = await obtenerDistritos($q("#provincia").value);
        $q("#distrito").innerHTML = "<option value=''>Selecciona</option>";
        distritos.forEach(dst => {
            $q("#distrito").innerHTML += `<option value="${dst.iddistrito}">${dst.distrito}</option>`;
        });
    });

    // *********************************** OBTENER DATOS ********************************
    async function obtenerClientePorId(idcliente) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerClientePorId");
        params.append("idcliente", idcliente);
        const fpersona = await getDatos(`${host}cliente.controller.php`, params)
        mostrarDatos(fpersona[0])
        return fpersona
    }

    async function mostrarDatos(data) {
        $q("#ndocumento").value = data.ndocumento;
        $q("#razonsocial").value = data.razonsocial;
        $q("#representantelegal").value = data.representantelegal ?? "";
        $q("#telefono").value = data.telefono;
        $q("#correo").value = data.correo;
        $q("#direccion").value = data.direccion;
        if ($q("#ndocumento").value.length == 8) {
            $q("#container-representantelegal").hidden = true;
        } else if ($q("#ndocumento").value.length == 11) {
            $q("#container-representantelegal").hidden = false;
        } else {
            $q("#container-representantelegal").hidden = true;
        }
        if (data.iddistrito) {
            await cargarUbigeoDesdeDistrito(data.iddistrito);
        }
    }
    /* 
        async function showDatos(data) {
            console.log(data)
            $q("#ndocumento").value = data.ndocumento;
            $q("#razonsocial").value = data.razonsocial;
            $q("#representantelegal").value = data.representantelegal ? data.representantelegal : '';
            $q("#telefono").value = data.telefono;
            $q("#correo").value = data.correo;
            $q("#direccion").value = data.direccion;
            if (data.iddistrito) {
                await cargarUbigeoDesdeDistrito(data.iddistrito);
            }
        }
     */
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

            $q("#provincia").innerHTML = provincias.map(p =>
                `<option value="${p.idprovincia}" ${p.idprovincia === distrito[0].idprovincia ? "selected" : ""}>${p.provincia}</option>`
            ).join("");

            // 3️⃣ Obtener todas los departamentos y marcar el correcto
            let departamentos = await fetch(`${host}recurso.controller.php?operation=obtenerTodosDepartamentos`).then(res => res.json());
            console.log("TODOS LOS DEPARTAMENTOS OBTENIDOS -> ", departamentos)
            console.log("LA PROVINCIA SELCCIONADA - ", provinciaSeleccionada)
            let departamentoSeleccionado = departamentos.find(d => d.iddepartamento === provinciaSeleccionada.iddepartamento);
            console.log("DEPARTAMENTO SELCCIONADO -> ", departamentoSeleccionado)
            $q("#departamento").innerHTML = departamentos.map(d =>
                `<option value="${d.iddepartamento}" ${d.iddepartamento === provinciaSeleccionada.iddepartamento ? "selected" : ""}>${d.departamento}</option>`
            ).join("");

            // 4️⃣ Obtener todas las nacionalidades y marcar la correcta
            let nacionalidades = await fetch(`${host}recurso.controller.php?operation=obtenerTodosNacionalidades`).then(res => res.json());
            console.log("NACIONALIDADES TODAS OBTENIDAS : ", nacionalidades)
            let nacionalidadSeleccionada = nacionalidades.find(n => n.idnacionalidad === departamentoSeleccionado.idnacionalidad);
            $q("#nacionalidad").innerHTML = nacionalidades.map(n =>
                `<option value="${n.idnacionalidad}" ${n.idnacionalidad === departamentoSeleccionado.idnacionalidad ? "selected" : ""}>${n.nacionalidad}</option>`
            ).join("");

            // 5️⃣ Obtener todos los distritos y seleccionar el correcto
            let distritos = await fetch(`${host}recurso.controller.php?operation=obtenerTodosDistritos`).then(res => res.json());
            $q("#distrito").innerHTML = distritos.map(d =>
                `<option value="${d.iddistrito}" ${d.iddistrito === idDistrito ? "selected" : ""}>${d.distrito}</option>`
            ).join("");

        } catch (error) {
            console.error("Error cargando ubigeo:", error);
        }
    }


    await obtenerClientePorId(idcliente)

    // ********************************************** ACTUALIZAR DATOS ************************************

    async function actualizarCliente(idcliente) {

        const ndocumento = $q("#ndocumento").value.trim();

        // Determinar el tipo de documento
        let tipodocu = "";
        if (ndocumento.length == 8) {
            tipodocu = 1;
        } else if (ndocumento.length == 11) {
            tipodocu = 2;
        }
        console.log("tipodocu -> ", tipodocu);

        const clienteAct = new FormData();
        clienteAct.append("operation", "actualizarCliente");
        clienteAct.append("idcliente", idcliente);
        clienteAct.append("tipodoc", tipodocu);
        clienteAct.append("iddistrito", $q("#distrito").value ? $q("#distrito").value : '');
        clienteAct.append("ndocumento", $q("#ndocumento").value ? $q("#ndocumento").value : '');
        clienteAct.append("razonsocial", $q("#razonsocial").value ? $q("#razonsocial").value : '');
        clienteAct.append("representantelegal", $q("#representantelegal").value ? $q("#representantelegal").value : '');
        clienteAct.append("telefono", $q("#telefono").value ? $q("#telefono").value : '');
        clienteAct.append("correo", $q("#correo").value ? $q("#correo").value : '');
        clienteAct.append("direccion", $q("#direccion").value ? $q("#direccion").value : '');

        const fclienteAct = await fetch(`${host}cliente.controller.php`, {
            method: "POST",
            body: clienteAct,
        });
        const rclienteAct = await fclienteAct.json();
        return rclienteAct;
    }

    $q("#form-cliente").addEventListener("submit", async (e) => {
        e.preventDefault();
        const rclienteAct = await actualizarCliente(idcliente);
        console.log("rclienteAct -> ", rclienteAct);
        if (rclienteAct) {
            showToast("Cliente actualizado correctamente", "SUCCESS", 3000, `${hostOnly}/views/utilitario/clientes/listar-clientes`);
            return
        } else {
            alert("Error al actualizar el cliente: " + rclienteAct.message);
        }
    })

    // **************************************** EVENTOS ****************************************

    $q("#ndocumento").addEventListener("input", async () => {
        const ndocumento = $q("#ndocumento").value.trim();
        if (ndocumento.length == 8) {
            //$q("#tipodoc").value = 1;
            $q("#container-representantelegal").hidden = true;
        } else if (ndocumento.length == 11) {
            //$q("#tipodoc").value = 2;
            $q("#container-representantelegal").hidden = false;
        } else {
            //$q("#tipodoc").value = "";
        }
    })

})