document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let idcolaborador
    let idnomina
    let colaboradorObt = []
    let salarioObt = []
    let tiempocalculado
<<<<<<< HEAD
    let modalNuevoCargo = new bootstrap.Modal($q("#modal-nuevocargo"))
    let totalAcumulado = 0
    let idpersonacolaboradorObt = -1
    let idcolaboradorObt = -1
=======
    let totalAcumulado = 0
>>>>>>> 6547466ed9a558a8c204afd89554b4da58b2d656
    /*     let modalNuevoProvedor = new bootstrap.Modal($q("#modal-nuevo-proveedor"))
        let modalActualizarProveedor = new bootstrap.Modal($q("#modal-actualizar-proveedor"))
     */
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

<<<<<<< HEAD
    await obtenerCargos()
    bloquearCamposDatosFisicos(true)
    bloquearCamposInformacionPago(true)
    // *************************************** SECCION DE BLOQUEAR CAMPOS ****************************

    async function registrarCargo() {
        //const perfilData = await getPerfil(parseInt(selector("perfil").value));
        const params = new FormData();
        params.append("operation", "registrarCargo");
        params.append("cargo", $q("#cargonuevo").value.trim());

        const resp = await fetch(`${host}colaborador.controller.php`, {
            method: 'POST',
            body: params
        });
        const data = await resp.json();
        return data;
    }


    function bloquearDatosGenerales(isblock) {
        $q("#nombreapellido").disabled = isblock;
        $q("#dni").disabled = isblock;
        $q("#fnacimiento").disabled = isblock;
        $q("#estadocivil").disabled = isblock
        $q("#sexo").disabled = isblock
        $q("#domicilio").disabled = isblock
        $q("#correo").disabled = isblock
        $q("#nivelestudio").disabled = isblock
        $q("#contactoemergencia").disabled = isblock
        $q("#discapacidad").disabled = isblock
        $q("#btnDatosGenerales").disabled = isblock
    }

    function bloquearCamposDatosFisicos(isblock) {
        $q("#camisa").disabled = isblock;
        $q("#pantalon").disabled = isblock;
        $q("#zapatos").disabled = isblock;
        $q("#btnDatosFisicos").disabled = isblock
    }

    function bloquearCamposInformacionPago(isblock) {
        $q("#tipo").disabled = isblock;
        $q("#fechaingresonomina").disabled = isblock;
        $q("#cargo").disabled = isblock;
        $q("#ruc").disabled = isblock;
        $q("#clavesol").disabled = isblock;
        $q("#ncuenta").disabled = isblock;
        $q("#btnInformacionPago").disabled = isblock
    }

=======
    await obtenerAreas()
>>>>>>> 6547466ed9a558a8c204afd89554b4da58b2d656
    // ************************************ REGISTRAR DATOS ********************************

    async function obtenerColaboradores() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarColaboradores");
        params.append("numdoc", "");
        params.append("idarea", "");

        const data = await getDatos(`${host}nomina.controller.php`, params);
        console.log("data -> ", data);
        $q("#colaborador").innerHTML = `<option value="">Seleccione</option>`;
        data.forEach(nomina => {
            $q("#colaborador").innerHTML += `
            <option value="${nomina.idcolaborador}">${nomina.nombres} ${nomina.apellidos}</option>
        `;
        });
    }

<<<<<<< HEAD

    async function obtenerCargos() {
        const data = await getDatos(`${host}colaborador.controller.php`, "operation=obtenerCargos");
        console.log(data);
        $q("#cargo").innerHTML = "<option value=''>Selecciona</option>";
        data.forEach(cargo => {
            $q("#cargo").innerHTML += `<option value="${cargo.idcargo}">${cargo.cargo}</option>`;
=======
    async function obtenerAreas() {
        const data = await getDatos(`${host}nomina.controller.php`, "operation=obtenerAreas");
        console.log(data);
        $q("#cargo").innerHTML = "<option value=''>Selecciona</option>";

        data.forEach(niveles => {
            $q("#cargo").innerHTML += `<option value="${niveles.idarea}">${niveles.area}</option>`;
>>>>>>> 6547466ed9a558a8c204afd89554b4da58b2d656
        });

    }

    async function obtenerColaboradorPorId(idcolaborador) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerColaboradorPorId");
        params.append("idcolaborador", idcolaborador);
        const data = await getDatos(`${host}nomina.controller.php`, params);
        return data
    }

    async function obtenerAcumuladosNomina(idnomina) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerAcumuladosNomina");
        params.append("idnomina", idnomina);
        const data = await getDatos(`${host}nomina.controller.php`, params);
        return data
    }

    async function obtenerUltimoSalarioColaborador(idcolaborador) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUltimoSalarioPorColaborador");
        params.append("idcolaborador", idcolaborador);
        const data = await getDatos(`${host}nomina.controller.php`, params);
        return data
    }

<<<<<<< HEAD
    async function registrarPersonaColaborador() {
        const colaborador = new FormData();
        colaborador.append("operation", "registrarPersonaColaborador");
        colaborador.append("nombreapellidos", $q("#nombreapellido").value || "");
        colaborador.append("dni", $q("#dni").value || '');
        colaborador.append("fnacimiento", $q("#fnacimiento").value || '');
        colaborador.append("estadocivil", $q("#estadocivil").value || '');
=======
    async function registrarNomina() {
        const colaborador = new FormData();
        colaborador.append("operation", "registrarNomina");
        colaborador.append("tipo", $q("#tipo").value || '');
        colaborador.append("nombreapellido", $q("#nombreapellido").value || '');
        colaborador.append("dni", $q("#dni").value || '');
        colaborador.append("idarea", $q("#cargo").value || '');
        colaborador.append("fnacimiento", $q("#fnacimiento").value || '');
        colaborador.append("estadocivil", $q("#estadocivil").value);
>>>>>>> 6547466ed9a558a8c204afd89554b4da58b2d656
        colaborador.append("sexo", $q("#sexo").value || '');
        colaborador.append("domicilio", $q("#domicilio").value || '');
        colaborador.append("correo", $q("#correo").value || '');
        colaborador.append("nivelestudio", $q("#nivelestudio").value || '');
        colaborador.append("contactoemergencia", $q("#contactoemergencia").value || '');
        colaborador.append("discapacidad", $q("#discapacidad").value || '');
<<<<<<< HEAD

        const fcolaborador = await fetch(`${host}colaborador.controller.php`, {
            method: "POST",
            body: colaborador
        });
        const rcolaborador = await fcolaborador.json();
        return rcolaborador;
    }

    async function registrarColaborador(idpersonacolaborador) {
        const colaborador = new FormData();
        colaborador.append("operation", "registrarColaborador");
        colaborador.append("idpersonacolaborador", idpersonacolaborador || "");
        colaborador.append("camisa", $q("#camisa").value || '');
        colaborador.append("pantalon", $q("#pantalon").value || '');
        colaborador.append("zapatos", $q("#zapatos").value || '');

        const fcolaborador = await fetch(`${host}colaborador.controller.php`, {
            method: "POST",
            body: colaborador
        });
        const rcolaborador = await fcolaborador.json();
        return rcolaborador;
    }

    /*     async function registrarNomina(idcolaborador, salariousado, periodo, idarea, horas, tiempo) {
            const colaborador = new FormData();
            colaborador.append("operation", "registrarNomina");
            colaborador.append("idcolaborador", idcolaborador);
            colaborador.append("salariousado", salariousado);
            colaborador.append("periodo", periodo);
            colaborador.append("idarea", idarea);
            colaborador.append("horas", horas);
            colaborador.append("tiempo", tiempo);
            colaborador.append("rendimiento", $q("#rendimiento").value || '');
            colaborador.append("proporcion", $q("#proporcion").value || '');
            colaborador.append("acumulado", $q("#acumulado").value || '');
    
            const fcolaborador = await fetch(`${host}nomina.controller.php`, {
                method: "POST",
                body: colaborador,
            });
            const rcolaborador = await fcolaborador.json();
            return rcolaborador;
        } */

    async function registrarNomina(idcolaborador) {
        const colaborador = new FormData();
        colaborador.append("operation", "registrarNomina");
        colaborador.append("idcolaborador", idcolaborador);
        colaborador.append("tipo", $q("#tipo").value || '');
        colaborador.append("fechaingreso", $q("#fechaingresonomina").value || '');
        colaborador.append("idcargo", $q("#cargo").value || '');
=======
        colaborador.append("camisa", $q("#camisa").value || '');
        colaborador.append("pantalon", $q("#pantalon").value || '');
>>>>>>> 6547466ed9a558a8c204afd89554b4da58b2d656
        colaborador.append("ruc", $q("#ruc").value || '');
        colaborador.append("clavesol", $q("#clavesol").value || '');
        colaborador.append("ncuenta", $q("#ncuenta").value || '');

        const fcolaborador = await fetch(`${host}nomina.controller.php`, {
            method: "POST",
            body: colaborador,
        });
        const rcolaborador = await fcolaborador.json();
        return rcolaborador;
    }

<<<<<<< HEAD
    // ******************** EVENTOS DE BOTONES **********************************************
    $q("#btnDatosGenerales").addEventListener("click", async () => {
        //console.log("butttoooon");
        const personacolaborador = await registrarPersonaColaborador();
        console.log("personacolaborador -> ", personacolaborador);
        if (personacolaborador.idpersonacolaborador) {
            idpersonacolaboradorObt = personacolaborador.idpersonacolaborador
            bloquearDatosGenerales(true) // BLOQUEAR ESTO Y DESBLOQUEAR LOS DATOS FISICOS
            bloquearCamposDatosFisicos(false)
            $q("#collapseDatosFisicos").classList.add("show")
            $q("#collapseDatosGenerales").classList.remove("show")
        }
    })

    $q("#btnDatosFisicos").addEventListener("click", async () => {
        const colaboradorRegis = await registrarColaborador(idpersonacolaboradorObt)
        console.log("colaboradorRegis -> ", colaboradorRegis);
        if (colaboradorRegis.idcolaborador) {
            idcolaboradorObt = colaboradorRegis.idcolaborador
            bloquearCamposDatosFisicos(true)
            bloquearCamposInformacionPago(false)
            $q("#collapseInformacionPago").classList.add("show")
            $q("#collapseDatosFisicos").classList.remove("show")
        }
    })

    $q("#btnInformacionPago").addEventListener("click", async () => {
        const nominaRegis = await registrarNomina(idcolaboradorObt)
        console.log("nominaRegis -> " , nominaRegis);
        if(nominaRegis.idnomina){
            bloquearCamposDatosFisicos(true)
            bloquearCamposInformacionPago(true)
            showToast("Nomina Registrada", "SUCCESS", 3000, `${hostOnly}/views/nominas/listar-nominas`)
            
        }
    })

    $q("#btnGuardarNuevoCargo").addEventListener("click", async () => {
        const arearegistrada = await registrarCargo()
        console.log("area registrada -> ", arearegistrada);
        if ($q("#cargonuevo").value.trim() == "") {
            showToast("El campo area no puede estar vacio", "ERROR");
            return
        }
        if (arearegistrada) {
            showToast("Area registrada correctamente", "SUCCESS");
            $q("#cargo").value = '';
            await obtenerCargos()
            modalNuevoCargo.hide()
        } else {
            showToast("Error al registrar el area", "ERROR");
        }
    })

    /*     $q("#colaborador").addEventListener("change", async (e) => {
            idcolaborador = e.target.value;
            colaboradorObt = await obtenerColaboradorPorId(idcolaborador)
            salarioObt = await obtenerUltimoSalarioColaborador(idcolaborador)
            console.log("salarioObt -> ", salarioObt);
            console.log("colaboradorObt -> ", colaboradorObt);
            tiempocalculado = calcularDiasTrabajados(colaboradorObt[0].fechaingreso)
            console.log("tiempocalculado >", tiempocalculado);
            $q("#tiempo").value = tiempocalculado ?? '';
        })
     */
    /*     $q("#formNomina").addEventListener("submit", async (e) => {
            e.preventDefault()
            console.log("formNomina");
            console.log("oj de colaborador -> ", colaboradorObt[0]);
            console.log("idarea de colaborador -> ", colaboradorObt[0]?.idarea);
            const nominaRegistrada = await registrarNomina(idcolaborador, salarioObt[0]?.salario, salarioObt[0]?.periodo, colaboradorObt[0]?.idarea, salarioObt[0]?.horas, tiempocalculado);
            console.log("nominaRegistrada -> ", nominaRegistrada);
            if (nominaRegistrada) {
                showToast("Nomina registrada correctamente", "SUCCESS");
                $q("#formNomina").reset();
                await dataFilters();
            }
    
        }) */
=======


    /*     async function actualizarProveedor(idproveedor) {
            const proveedor = new FormData();
            proveedor.append("operation", "actualizarProveedor");
            proveedor.append("idproveedor", idproveedor);
            proveedor.append("empresa", $q("#empresaactualizar").value || '');
            proveedor.append("nombre", $q("#nombreempresaactualizar").value || '');
            proveedor.append("contacto", $q("#contactoactualizar").value || '');
            proveedor.append("correo", $q("#correoactualizar").value || '');
            proveedor.append("dni", $q("#dniempresaactualizar").value || '');
            proveedor.append("banco", $q("#bancoactualizar").value || '');
            proveedor.append("ctabancaria", $q("#ctabancariaactualizar").value || '');
            proveedor.append("servicio", $q("#servicioactualizar").value || '');
            proveedor.append("nproveedor", $q("#nproveedoractualizar").value || '');
    
            const fproveedor = await fetch(`${host}proveedor.controller.php`, {
                method: "POST",
                body: proveedor,
            });
            const rproveedor = await fproveedor.json();
            return rproveedor;
        } */

    // *********************************** OBTENER DATOS ********************************

    /*     async function obtenerProveedorPorId(idproveedor) {
            const params = new URLSearchParams();
            params.append("operation", "obtenerProveedorPorId");
            params.append("idproveedor", idproveedor);
            const data = await getDatos(`${host}proveedor.controller.php`, params);
            return data;
        } */


    $q("#form-registro-nomina").addEventListener("submit", async (e) => {
        e.preventDefault()
        console.log("form-registro-nomina");
        /*         console.log("oj de colaborador -> ", colaboradorObt[0]);
                console.log("idarea de colaborador -> ", colaboradorObt[0]?.idarea); */
        const nominaRegistrada = await registrarNomina();
        console.log("nominaRegistrada -> ", nominaRegistrada);
        if (nominaRegistrada) {
            showToast("Nomina registrada correctamente", "SUCCESS", 2000, `${hostOnly}/views/nominas/listar-nominas`);
            $q("#form-registro-nomina").reset();
            await dataFilters();
        }

    })
>>>>>>> 6547466ed9a558a8c204afd89554b4da58b2d656
})