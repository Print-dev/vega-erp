document.addEventListener("DOMContentLoaded", async () => {
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

    bloquearCampos(true); // bloquear campos de llenar persona por defecto


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

    // **************************************** obtener dato s ******************************

    async function buscarCliente(ndocumento, telefono, razonsocial) {
        const params = new URLSearchParams();
        params.append("operation", "buscarCliente");
        params.append("ndocumento", ndocumento ? ndocumento : '');
        params.append("telefono", telefono ? telefono : '');
        params.append("razonsocial", razonsocial ? razonsocial : '');
        const fpersona = await getDatos(`${host}cliente.controller.php`, params)
        console.log(fpersona);
        return fpersona
    }

    async function obtenerDataClienteDNI() {
        const Fdata = await fetch(`https://app.minam.gob.pe/TransparenciaWSREST/tramites/transparencia/persona?dni=${$q("#ndocumento").value}`)
        const data = await Fdata.json()
        return data.data
    }


    async function obtenerDataClienteRUC() {
        console.log($q("#ndocumento").value)
        const Fdata = await fetch(`${host}cliente.controller.php?operation=consultarRUC&ndocumento=${$q("#ndocumento").value}`)
        const data = await Fdata.json()
        console.log("data sunat: ", data)
        return data
    }

    async function showDataPersonaNR(data) {
        console.log("data persona reniec: ", data);
        const ubig = data.ubigeo.split("/")
        console.log("departamento-> ", ubig[2]);
        //        $q("#apellidos").value = data.apellidoMaterno + " " + data.apellidoPaterno;
        $q("#razonsocial").value = data.nombre + " " + data.apellidoMaterno + " " + data.apellidoPaterno;
        $q("#direccion").value = data.direccion;
        /*         $q("#departamento").value = ubig[0];
                $q("#provincia").value = ubig[1];
                $q("#distrito").value = ubig[2]; */
        ubig[2] = ubig[2].charAt(0).toUpperCase() + ubig[2].slice(1).toLowerCase();
        console.log("ubigeo distrito -> ", ubig[2]);
        if (ubig[2]) {
            await cargarUbigeoDesdeDistrito(ubig[2]);
        }
        //selector("externo").disabled = isblock
    }

    async function cargarUbigeoDesdeDistrito(idDistrito) {
        try {
            // 1️⃣ Obtener datos del distrito
            let distrito = await fetch(`${host}recurso.controller.php?operation=obtenerDistritoPorNombre&distrito=${idDistrito}`).then(res => res.json());
            console.log("TODAS LAS DISTRTITOS OBTENIDOAS  -> ", distrito)
            let iddistritoObtenido = distrito[0]?.idprovincia

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
                `<option value="${d.iddistrito}" ${d.iddistrito === iddistritoObtenido ? "selected" : ""}>${d.distrito}</option>`
            ).join("");

        } catch (error) {
            console.error("Error cargando ubigeo:", error);
        }
    }

    function bloquearCampos(isblock) {
        $q("#representantelegal").disabled = isblock;
        $q("#correo").disabled = isblock;
        $q("#nacionalidad").disabled = isblock;
        $q("#departamento").disabled = isblock;
        $q("#provincia").disabled = isblock;
        $q("#distrito").disabled = isblock;
        $q("#direccion").disabled = isblock;
        //selector("externo").disabled = isblock
    }

    async function existeCorreo(correo) {
        const params = new URLSearchParams();
        params.append("operation", "buscarCorreo");
        params.append("correo", correo.trim());

        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data;
    }

    async function existeCorreoCliente(correo) {
        const params = new URLSearchParams();
        params.append("operation", "buscarCorreoCliente");
        params.append("correo", correo.trim());

        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data;
    }

    //********************************* REGISTOR DE DATOS ************************************* */
    async function registrarCliente() {
        const ndocumento = $q("#ndocumento").value.trim();

        // Determinar el tipo de documento
        let tipodocu = "";
        if (ndocumento.length == 8) {
            tipodocu = 1;
        } else if (ndocumento.length == 11) {
            tipodocu = 2;
        }
        console.log("tipodocu -> ", tipodocu);
        console.log("tipodocu typeof -> ", typeof tipodocu);

        const cliente = new FormData();
        cliente.append("operation", "registrarCliente");
        cliente.append("tipodoc", tipodocu);
        cliente.append("iddistrito", $q("#distrito").value ? $q("#distrito").value : '');
        cliente.append("ndocumento", $q("#ndocumento").value ? $q("#ndocumento").value : '');
        cliente.append("razonsocial", $q("#razonsocial").value ? $q("#razonsocial").value : '');
        cliente.append("representantelegal", $q("#representantelegal").value ? $q("#representantelegal").value : '');
        cliente.append("telefono", $q("#telefono").value ? $q("#telefono").value : '');
        cliente.append("correo", $q("#correo").value ? $q("#correo").value : '');
        cliente.append("direccion", $q("#direccion").value ? $q("#direccion").value : '');

        console.log($q("#distrito").value);
        console.log($q("#ndocumento").value);
        console.log($q("#razonsocial").value);
        console.log($q("#telefono").value);
        console.log($q("#correo").value);
        console.log($q("#direccion").value);


        const fcliente = await fetch(`${host}cliente.controller.php`, {
            method: "POST",
            body: cliente,
        });
        const rcliente = await fcliente.json();
        return rcliente;
    }

    // ************************************** eventos *********************************

    async function buscarClienteParams() {
        // Obtener valores de los inputs
        const ndocumento = $q("#ndocumento").value.trim();
        const telefono = $q("#telefono").value.trim();
        const razonsocial = $q("#razonsocial").value.trim();

        // Validaciones básicas para el número de documento
        const isNumeric = /^[0-9]+$/.test(ndocumento);
        const minLength = ndocumento.length >= 8;
        const validaNumDoc = ndocumento.length === 8 || ndocumento.length === 11;
        const isRUC = ndocumento.length === 11;
        const isDNI = ndocumento.length === 8;

        // 🔎 **Llamar a la función `buscarCliente` con los 3 parámetros**
        const data = await buscarCliente(ndocumento || null, telefono || null, razonsocial || null);

        const isblock = data.length > 0; // Si hay datos, bloquear campos
        bloquearCampos(isblock);

        console.log("Cliente encontrado:", data);

        if (isblock) {
            showToast("El cliente ya existe", "INFO");
            /*             if (data[0].representantelegal) {
                            $q("#container-representantelegal").hidden = false;
                        } else {
                            $q("#container-representantelegal").hidden = true;
                        }
                        idcliente = data[0].idcliente;
                        showDatos(data[0]);
                        bloquearCampos(false); */
        } else {
            // Si no existe, intentar buscar en la SUNAT (solo si es nuevo y no se está reseteando)
            //if (!isReset) {
            if (isRUC) {
                const dataCliente = await obtenerDataClienteRUC();
                $q("#container-representantelegal").hidden = false;
                $q("#razonsocial").value = dataCliente.razonSocial;
                $q("#direccion").value = dataCliente.direccion;
            }
            if (isDNI) {
                const dataCliente = await obtenerDataClienteDNI();
                $q("#container-representantelegal").hidden = true;
                await showDataPersonaNR(dataCliente);
            }
            //}
            $q("#btnEnviar").disabled = false;
        }
    }
    $q("#btnBuscarCliente").addEventListener("click", async () => {
        await buscarClienteParams();
    });

    $q("#form-cliente").addEventListener("submit", async (e) => {
        e.preventDefault();
        const unikeEmail = await existeCorreo($q("#correo").value.trim());
        const unikeEmailCliente = await existeCorreoCliente($q("#correo").value.trim());
        console.log("email encontrado -> ", unikeEmail);
        console.log("email cliente encontrado -> ", unikeEmailCliente);
        if (unikeEmail.length > 0 || unikeEmailCliente.length > 0) {
            //console.log($q("#apellidos").value.toUpperCase());
            //console.log($q("#nombres").value.toUpperCase());
            let message = "";
            console.log("gaaaaaaa");
            //if (!validateFields) { message = "Completa los campos"; }
            //if (!numericTelefono) { message = "Solo numeros en el Telfono"; }
            //if (!validarClaveAcceso) { message = "el minimo de caracteres para la clave de acceso es de 8"; }
            //if (unikeUser.length > 0) { message = "El nombre de usuario ya existe"; }
            if (unikeEmail.length > 0) { message = "El correo electronico ya está en uso"; }
            if (unikeEmailCliente.length > 0) { message = "El correo electronico ya está en uso"; }
            showToast(message, "ERROR");
            return

        } else {
            if (await ask("¿Estas seguro de registrar?")) {
                const data = await registrarCliente();
                console.log(data);
                showToast("Cliente registrado correctamente", "SUCCESS", `${hostOnly}/views/utilitario/clientes/listar-clientes`);
                bloquearCampos(true);

                return

            }
            else {
                showToast("Hubo un error al registrar los datos del cliente", "ERROR");
            }
        }
    })

})