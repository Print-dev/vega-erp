document.addEventListener("DOMContentLoaded", async () => {
    const host = "http://localhost/vega-erp/controllers/";
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

    await obtenerArtistas()

    /* ************************************* OBTENER RECURSOS ******************************************************* */

    async function obtenerArtistas() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", 6);
        const data = await getDatos(`${host}usuario.controller.php`, params)
        console.log(data);
        $q("#artista").innerHTML = "<option value=''>Selecciona</option>";
        data.forEach(artista => {
            $q("#artista").innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
        });
    }


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

    /* async function registrarPersona() {
        const persona = new FormData();
        persona.append("operation", "registrarPersona");
        persona.append("num_doc", $q("#num_doc").value);
        persona.append("apellidos", $q("#apellidos").value);
        persona.append("nombres", $q("#nombres").value);
        persona.append("genero", $q("#genero").value);
        persona.append("direccion", $q("#direccion").value);
        persona.append("telefono", $q("#telefono1").value);
        persona.append("telefono2", $q("#telefono2").value);
        persona.append("correo", $q("#correo").value);
        persona.append("iddistrito", $q("#distrito").value);

        const fpersonas = await fetch(`${host}persona.controller.php`, {
            method: "POST",
            body: persona,
        });
        const rpersonas = await fpersonas.json();
        return rpersonas;
    } */

    // ********************************* FUNCIONES DE VALIDACION *********************************


    //Funcion que agrega disabled a los campos


    // ********************************* EVENTOS Y CARGA DE DATOS *********************************

    $q("#nacionalidad").addEventListener("change", async () => {
        const departamentos = await obtenerDepartamentos();
        $q("#departamento").innerHTML = "<option value=''>Selecciona</option>";
        departamentos.forEach(dpa => {
            $q("#departamento").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
        });
    });

    $q("#departamento").addEventListener("change", async () => {
        const provincias = await obtenerProvincias();
        $q("#tb-body-tarifario").innerHTML = ''
        provincias.forEach(pro => {
            $q("#tb-body-tarifario").innerHTML += `
            <tr>
                <td>${pro.provincia}</td>
                <td>
                    <input type="number" class="form-control">
                </td>
                <td>
                    <button type="button" class="btn btn-primary"><i class="fa-solid fa-floppy-disk"></i></button>
                </td>
            </tr>
        `;
        });


        /* $q("#provincia").innerHTML = "<option value=''>Selecciona</option>";
        provincias.forEach(prv => {
            $q("#provincia").innerHTML += `<option value="${prv.idprovincia}">${prv.provincia}</option>`;
        }); */
    });

    // ********************************* REGISTROS *********************************


});