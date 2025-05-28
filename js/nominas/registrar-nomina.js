document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let idcolaborador
    let idnomina
    let colaboradorObt = []
    let salarioObt = []
    let tiempocalculado
    let totalAcumulado = 0
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

    await obtenerAreas()
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

    async function obtenerAreas() {
        const data = await getDatos(`${host}nomina.controller.php`, "operation=obtenerAreas");
        console.log(data);
        $q("#cargo").innerHTML = "<option value=''>Selecciona</option>";

        data.forEach(niveles => {
            $q("#cargo").innerHTML += `<option value="${niveles.idarea}">${niveles.area}</option>`;
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

    async function registrarNomina() {
        const colaborador = new FormData();
        colaborador.append("operation", "registrarNomina");
        colaborador.append("tipo", $q("#tipo").value || '');
        colaborador.append("nombreapellido", $q("#nombreapellido").value || '');
        colaborador.append("dni", $q("#dni").value || '');
        colaborador.append("idarea", $q("#cargo").value || '');
        colaborador.append("fnacimiento", $q("#fnacimiento").value || '');
        colaborador.append("estadocivil", $q("#estadocivil").value);
        colaborador.append("sexo", $q("#sexo").value || '');
        colaborador.append("domicilio", $q("#domicilio").value || '');
        colaborador.append("correo", $q("#correo").value || '');
        colaborador.append("nivelestudio", $q("#nivelestudio").value || '');
        colaborador.append("contactoemergencia", $q("#contactoemergencia").value || '');
        colaborador.append("discapacidad", $q("#discapacidad").value || '');
        colaborador.append("camisa", $q("#camisa").value || '');
        colaborador.append("pantalon", $q("#pantalon").value || '');
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
})