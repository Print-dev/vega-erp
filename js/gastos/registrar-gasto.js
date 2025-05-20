document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let idcolaborador
    let idnomina
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

    function toggleVisibility(selector, show) {
        const el = $q(selector);
        if (!el) return;
        el.classList.toggle("d-none", !show);
    }

    // CARGAS POR DEFECTO 
    // DATOS DE FACTURACION
    $q("#foliofactura").disabled = true
    $q("#descripcion").disabled = true

    // FORMAS DE PAGO
    $q("#formapago").disabled = true
    $q("#cuenta").disabled = true

    // PRODUCTO O SERVICIO
    $q("#cantidad").disabled = true
    $q("#nombre").disabled = true
    $q("#unidades").disabled = true

    // GENERAL
    $q("#div-colaborador").classList.add("d-none")

    // DETALLES DE FACTURACION 

    $q("#emision").disabled = true
    //$q("#tasafactura").disabled = true

    await obtenerProveedores()
    await obtenerConceptos()
    await obtenerColaboradores()

    async function obtenerProveedores() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarProveedores");
        params.append("nombre", "");
        params.append("dni", "");

        const data = await getDatos(`${host}proveedor.controller.php`, params);
        console.log("data -> ", data);
        $q("#proveedor").innerHTML = `
            <option value="">Seleccione un proveedor</option>
        `;
        data.forEach(proveedor => {
            $q("#proveedor").innerHTML += `
                <option value="${proveedor.idproveedor}">${proveedor.nombre}</option>
            `;
        });
    }

    async function obtenerConceptos() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerConceptos");

        const data = await getDatos(`${host}recurso.controller.php`, params);
        console.log("data -> ", data);
        $q("#concepto").innerHTML = `
            <option value="">Seleccione un concepto</option>
        `;
        data.forEach(concepto => {
            $q("#concepto").innerHTML += `
                <option value="${concepto.idconcepto}">${concepto.concepto}</option>
            `;
        });
    }

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

    async function obtenerSubTipoPorIdConcepto(idconcepto) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerSubTipoPorIdConcepto");
        params.append("idconcepto", idconcepto);

        const data = await getDatos(`${host}recurso.controller.php`, params);
        console.log("data -> ", data);
        $q("#subtipo").innerHTML = `
            <option value="">Seleccione un subtipo</option>
        `;
        data.forEach(subtipo => {
            $q("#subtipo").innerHTML += `
                <option value="${subtipo.idsubtipo}">${subtipo.subtipo}</option>
            `;
        });
    }

    $q("#concepto").addEventListener("change", async (e) => {
        console.log("cambiando -< ", e.target.value);
        await obtenerSubTipoPorIdConcepto(e.target.value)
    })


    async function registrarGastoEntrada() {
        const gasto = new FormData();
        gasto.append("operation", "registrarGastoEntrada");

        gasto.append("estadopago", $q("#estado").value || null);
        gasto.append("fgasto", $q("#fechagasto").value || null);
        gasto.append("fvencimiento", $q("#fechavencimiento").value || null);
        gasto.append("tipo", $q("#tipo").value || null);
        gasto.append("concepto", $q("#concepto").value || null);
        gasto.append("subtipo", $q("#subtipo").value || null);
        gasto.append("idproveedor", $q("#proveedor").value || null);
        gasto.append("idcolaborador", $q("#colaborador").value || null);
        gasto.append("gasto", $q("#gasto").value || null);
        gasto.append("cunitario", $q("#costounitario").value || null);
        gasto.append("pagado", $q("#pagadoanticipo").value || null);
        gasto.append("idproducto", $q("#nombre").value || null);
        gasto.append("cantidad", $q("#cantidad").value || null);
        gasto.append("unidades", $q("#unidades").value || null);
        gasto.append("formapago", $q("#formapago").value || null);
        gasto.append("cuenta", $q("#cuenta").value || null);
        gasto.append("foliofactura", $q("#foliofactura").value || null);
        //gasto.append("tasafactura", $q("#tasafactura").value || null);
        gasto.append("emision", $q("#emision").value || null);
        gasto.append("descripcion", $q("#descripcion").value || null);
        gasto.append("costofinal", $q("#costofinal").value || null);
        gasto.append("egreso", $q("#egreso").value || null);
        gasto.append("montopdte", $q("#montopdte").value || null);
        gasto.append("impuestos", $q("#impuestos").value || null);
        gasto.append("costofinalunit", $q("#costofinalunit").value || null);


        const response = await fetch(`${host}gastoentrada.controller.php`, {
            method: "POST",
            body: gasto,
        });

        const result = await response.json();
        return result;
    }



    $q("#form-registro-gasto").addEventListener("submit", async (e) => {
        e.preventDefault()

        const gastoentradaRegis = await registrarGastoEntrada()
        console.log("gastoentradaRegis", gastoentradaRegis);
        if (gastoentradaRegis.idgastoentrada) {
            showToast("Gasto registrado correctamente", "SUCCESS")
            $q("#form-registro-gasto").reset()
            $q("#div-estadopago").classList.add("d-none")
        }
    })

    $q("#concepto").addEventListener("change", async (e) => {
        const concepto = e.target.value
        console.log("target", e.target.value);
        switch (concepto) {
            case "1": // oficina
                $q("#div-subtipo").classList.remove("d-none")
                $q("#div-colaborador").classList.add("d-none")
                $q("#div-cunitario").classList.add("d-none")
                $q("#div-pagadoanticipo").classList.remove("d-none")

                // DISABLES
                $q("#cantidad").disabled = true
                $q("#nombre").disabled = true
                $q("#unidades").disabled = true

                break;

            case "2": // Venta
                $q("#div-subtipo").classList.remove("d-none")
                $q("#div-colaborador").classList.add("d-none")
                $q("#div-cunitario").classList.add("d-none")
                $q("#div-pagadoanticipo").classList.remove("d-none")

                //DISABLES
                $q("#cantidad").disabled = true
                $q("#nombre").disabled = true
                $q("#unidades").disabled = true

                break;

            case "3": // Costos
                $q("#div-subtipo").classList.remove("d-none")
                $q("#div-colaborador").classList.add("d-none")
                $q("#div-cunitario").classList.add("d-none")
                $q("#div-pagadoanticipo").classList.remove("d-none")

                // DISABLES
                $q("#cantidad").disabled = true
                $q("#nombre").disabled = true
                $q("#unidades").disabled = true
                break;

            case "4": // Produccion
                $q("#div-subtipo").classList.remove("d-none")
                $q("#div-colaborador").classList.add("d-none")
                $q("#div-cunitario").classList.add("d-none")
                $q("#div-pagadoanticipo").classList.remove("d-none")

                // DISABLES
                $q("#cantidad").disabled = true
                $q("#nombre").disabled = true
                $q("#unidades").disabled = true
                break;

            case "5": // proyecto 
                $q("#div-subtipo").classList.remove("d-none")
                $q("#div-colaborador").classList.add("d-none")
                $q("#div-cunitario").classList.add("d-none")
                $q("#div-pagadoanticipo").classList.remove("d-none")

                // DISABLES
                $q("#cantidad").disabled = true
                $q("#nombre").disabled = true
                $q("#unidades").disabled = true
                break;

            case "6": // fiscal
                $q("#div-subtipo").classList.remove("d-none")
                $q("#div-colaborador").classList.add("d-none")
                $q("#div-cunitario").classList.add("d-none")
                $q("#div-pagadoanticipo").classList.remove("d-none")

                // DISABLES
                $q("#cantidad").disabled = true
                $q("#nombre").disabled = true
                $q("#unidades").disabled = true
                break;

            case "7": // Otros
                $q("#div-subtipo").classList.remove("d-none")
                $q("#div-colaborador").classList.add("d-none")
                $q("#div-cunitario").classList.add("d-none")
                $q("#div-pagadoanticipo").classList.remove("d-none")

                // DISABLES
                $q("#cantidad").disabled = true
                $q("#nombre").disabled = true
                $q("#unidades").disabled = true
                break;

            case "8": // inventario
                $q("#div-cunitario").classList.remove("d-none")
                $q("#div-subtipo").classList.add("d-none")
                $q("#div-colaborador").classList.remove("d-none")
                $q("#div-pagadoanticipo").classList.add("d-none")

                $q("#div-formapago").classList.add("d-none")
                $q("#div-cuenta").classList.add("d-none")
                //$q("#div-tasafactura").hidden = true
                $q("#div-emision").hidden = true

                $q("#cantidad").disabled = false
                $q("#nombre").disabled = false
                $q("#unidades").disabled = false

                console.log("cambiando...");
                break;

            default:
                break;
        }
    })

    $q("#subtipo").addEventListener("change", async (e) => {
        const subtipo = e.target.value
        console.log("target", e.target.value);
        if (subtipo == "2") {
            $q("#div-colaborador").classList.remove("d-none")
            $q("#div-proveedor").classList.add("d-none")

        } else {
            $q("#div-colaborador").classList.add("d-none")
            $q("#div-proveedor").classList.remove("d-none")


        }
    })

    $q("#gasto").addEventListener("input", async (e) => {
        const gasto = e.target.value
        console.log("gasto value ", gasto);
        if (gasto != "") {
            $q("#foliofactura").disabled = false
            $q("#descripcion").disabled = false
            $q("#formapago").disabled = false
            $q("#cuenta").disabled = false

        }
        else {
            $q("#foliofactura").disabled = true
            $q("#descripcion").disabled = true
            $q("#formapago").disabled = true
            $q("#cuenta").disabled = true
        }

        const impuesto = parseFloat(gasto) * 0.18
        const costofinal = parseFloat(gasto) + parseFloat(impuesto)

        $q("#impuestos").value = parseFloat(impuesto).toFixed(2)
        $q("#costofinal").value = parseFloat(costofinal).toFixed(2)
        $q("#egreso").value = parseFloat(costofinal).toFixed(2)
    })

    $q("#pagadoanticipo").addEventListener("input", async (e) => {
        const pagoanticipado = e.target.value
        console.log("pagoanticipado value ", pagoanticipado);
        /* if (pagoanticipado != "") {
            $q("#formapago").disabled = false
            $q("#cuenta").disabled = false
        }
        else {
            $q("#formapago").disabled = true
            $q("#cuenta").disabled = true
        } */
        if (parseFloat(pagoanticipado) >= parseFloat($q("#gasto").value)) {
            $q("#div-estadopago").classList.remove("d-none")
            $q("#montopdte").value = 0
            $q("#div-estadopago").innerHTML = `
                <div class="bg-success h-100 w-100 text-white text-center d-flex align-items-center justify-content-center">
                    Pagado
                </div>
            `
        } else {
            $q("#div-estadopago").classList.remove("d-none")

            $q("#montopdte").value = parseFloat($q("#gasto").value) - parseFloat(pagoanticipado)
            $q("#div-estadopago").innerHTML = `
                <div class="bg-danger h-100 w-100 text-white text-center d-flex align-items-center justify-content-center" >
                    Pendiente
                </div >
                `
        }

    })


    $q("#foliofactura").addEventListener("input", async (e) => {
        const gasto = e.target.value
        console.log("gasto value ", gasto);
        if (gasto != "") {
            $q("#emision").disabled = false
            //$q("#tasafactura").disabled = false

        }
        else {
            $q("#emision").disabled = true
            //$q("#tasafactura").disabled = true

        }
    })

    $q("#estado").addEventListener("change", async (e) => {
        const estado = e.target.value
        switch (estado) {
            case "1":
                $q("#fechavencimiento").disabled = false

                break;

            case "2":
                $q("#fechavencimiento").disabled = true
                $q("#fechavencimiento").value = ""
                break;

            default:
                break;
        }
    })

})