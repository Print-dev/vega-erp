document.addEventListener("DOMContentLoaded", async () => {
    let selectResponsables = $q("#idresponsable")

    const idsucursal = window.localStorage.getItem("idsucursal")
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

    // ************************************** OBTENER DATA *****************************************

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

    await obtenerUsuarios("3")

    async function obtenerSucursalPorId(idsucursal) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerSucursalPorId");
        params.append("idsucursal", idsucursal);
        const data = await getDatos(`${host}sucursal.controller.php`, params);
        return data;
    }

    async function renderizarDetalleEvento() {
        //$q("#container-validez").hidden = true

        const sucursalInfo = await obtenerSucursalPorId(idsucursal)
        console.log("info dp -> ", sucursalInfo);
        idartista = sucursalInfo[0]?.idusuario
        $q("#idresponsable").value = sucursalInfo[0]?.idresponsable
        $q("#nombre").value = sucursalInfo[0]?.nombre
        $q("#ruc").value = sucursalInfo[0]?.ruc
        $q("#telefono").value = sucursalInfo[0]?.telefono
        $q("#web").value = sucursalInfo[0]?.web
        $q("#email").value = sucursalInfo[0]?.email
        $q("#direccion").value = sucursalInfo[0]?.direccion
        $q("#ubigeo").value = sucursalInfo[0]?.ubigeo

        if (sucursalInfo[0]?.iddistrito) {
            await cargarUbigeoDesdeDistrito(sucursalInfo[0]?.iddistrito);
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
            $q("#iddistrito").innerHTML = distritos.map(d =>
                `<option value="${d.iddistrito}" ${d.iddistrito === idDistrito ? "selected" : ""}>${d.distrito}</option>`
            ).join("");

        } catch (error) {
            console.error("Error cargando ubigeo:", error);
        }
    }

    await renderizarDetalleEvento()

    async function actualizarSucursal(idsucursal) {

        const body = new FormData();
        body.append("operation", "actualizarSucursal");
        body.append("idsucursal", idsucursal);
        body.append("idempresa", 1);
        body.append("iddistrito", $q("#iddistrito").value ? $q("#iddistrito").value.trim() : '');
        body.append("idresponsable", $q("#idresponsable").value ? $q("#idresponsable").value.trim() : '');
        body.append("nombre", $q("#nombre").value ? $q("#nombre").value.trim() : '');
        body.append("ruc", $q("#ruc").value ? $q("#ruc").value.trim() : '');
        body.append("telefono", $q("#telefono").value ? $q("#telefono").value.trim() : '');
        body.append("direccion", $q("#direccion").value ? $q("#direccion").value.trim() : '');
        body.append("web", $q("#web").value ? $q("#web").value.trim() : '');
        body.append("email", $q("#email").value ? $q("#email").value.trim() : '');
        body.append("ubigeo", $q("#ubigeo").value ? $q("#ubigeo").value.trim() : '');

        const fbody = await fetch(`${host}sucursal.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    $q("#form-sucursal").addEventListener("submit", async (e) => {
        e.preventDefault();
        const data = await actualizarSucursal(idsucursal);
        console.log(data);
        if (data) {
            showToast("Sucursal actualizado correctamente", "SUCCESS", 2500, `${hostOnly}/views/utilitario/sucursales/listar-sucursales`);	
            //window.location.href = `${hostOnly}/views/utilitario/sucursales/listar-sucursales`
        } else {
            alert("Error al registrar la sucursal");
        }
    })

})