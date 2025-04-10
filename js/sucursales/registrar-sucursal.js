document.addEventListener("DOMContentLoaded", async () => {
    // VARIABLES 
    let selectResponsables = $q("#idresponsable")

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

    // ************************************** RENDER PREVIEW *****************************************
    console.log("aagagagagag");
    await obtenerUsuarios("3")

    async function obtenerDepartamentos() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDepartamentos");
        params.append("idnacionalidad", $q("#nacionalidad").value);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    async function obtenerProvincias() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerProvincias");
        params.append("iddepartamento", $q("#departamento").value);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    async function obtenerDistritos() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDistritos");
        params.append("idprovincia", $q("#provincia").value);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    $q("#nacionalidad").addEventListener("change", async () => {
        const departamentos = await obtenerDepartamentos();
        $q("#departamento").innerHTML = "<option value=''>Selecciona</option>";
        departamentos.forEach(dpa => {
            $q("#departamento").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
        });
    });

    $q("#departamento").addEventListener("change", async () => {
        const provincias = await obtenerProvincias();
        $q("#provincia").innerHTML = "<option value=''>Selecciona</option>";
        provincias.forEach(prv => {
            $q("#provincia").innerHTML += `<option value="${prv.idprovincia}">${prv.provincia}</option>`;
        });
    });

    $q("#provincia").addEventListener("change", async () => {
        const distritos = await obtenerDistritos();
        $q("#iddistrito").innerHTML = "<option value=''>Selecciona</option>";
        distritos.forEach(dst => {
            $q("#iddistrito").innerHTML += `<option value="${dst.iddistrito}">${dst.distrito}</option>`;
        });
    });



    // ************************************ OBTENCION DATA *********************************************************

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

    async function registrarSucursal() {

        const body = new FormData();
        body.append("operation", "registrarSucursal");
        body.append("idempresa", 1);
        body.append("iddistrito", $q("#iddistrito").value ? $q("#iddistrito").value.trim() : '');
        body.append("idresponsable", $q("#idresponsable").value ? $q("#idresponsable").value.trim() : '');
        body.append("nombre", $q("#nombre").value ? $q("#nombre").value.trim() : '');
        body.append("ruc", $q("#ruc").value ? $q("#ruc").value.trim() : '');
        body.append("telefono", $q("#telefono").value ? $q("#telefono").value.trim() : '');
        body.append("direccion", $q("#direccion").value     ? $q("#direccion").value.trim() : '');
        body.append("web", $q("#web").value ? $q("#web").value.trim() : '');
        body.append("email", $q("#email").value ? $q("#email").value.trim() : '');

        const fbody = await fetch(`${host}sucursal.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    $q("#form-sucursal").addEventListener("submit", async (e) => {
        e.preventDefault();
        const data = await registrarSucursal();
        console.log(data);
        if (data) {
            showToast("Sucursal registrado correctamente", "SUCCESS", 2500, `${hostOnly}/views/utilitario/sucursales/listar-sucursales`);	

        } else {
            alert("Error al registrar la sucursal");
        }
    })

})