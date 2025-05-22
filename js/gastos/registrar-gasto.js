document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;
    let idproveedor
    let idcolaborador
    let idnomina
    let ngasto

    // REUTILIZABLE:
    let costo = 0
    let costofinal = 0
    let montopdte = 0
    let costofinalunit = 0
    let cantidad = 0
    let pagoAnticipado = 0
    let tasafactura = 0
    let impuestos
    let egreso = 0
    let acumuladoUltimo = 0

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


    // FORMAS DE PAGO
    $q("#formapago").disabled = true
    $q("#cuenta").disabled = true

    // PRODUCTO O SERVICIO
    $q("#cantidad").disabled = true
    $q("#nombre").disabled = true
    $q("#unidades").disabled = true

    // GENERAL
    $q("#div-colaborador").classList.add("d-none")
    $q("#div-costofinalunit").classList.add("d-none")

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

    async function obtenerUltimaNominaPorColaborador(idcolaborador) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUltimaNominaPorColaborador");
        params.append("idcolaborador", idcolaborador);

        const data = await getDatos(`${host}nomina.controller.php`, params);
        return data
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
        gasto.append("gasto", parseFloat($q("#gasto").value).toFixed(2) || null);
        gasto.append("cunitario", parseFloat($q("#costounitario").value).toFixed(2) || null);
        gasto.append("pagado", parseFloat($q("#pagadoanticipo").value).toFixed(2) || null);
        gasto.append("idproducto", $q("#nombre").value || null);
        gasto.append("cantidad", $q("#cantidad").value || null);
        gasto.append("unidades", $q("#unidades").value || null);
        gasto.append("formapago", $q("#formapago").value || null);
        gasto.append("cuenta", $q("#cuenta").value || null);
        gasto.append("foliofactura", $q("#foliofactura").value || null);
        //gasto.append("tasafactura", $q("#tasafactura").value || null);
        gasto.append("emision", $q("#emision").value || null);
        gasto.append("descripcion", $q("#descripcion").value || null);
        gasto.append("costofinal", parseFloat($q("#costofinal").value).toFixed(2) || null);
        gasto.append("egreso", parseFloat($q("#egreso").value).toFixed(2) || null);
        gasto.append("montopdte", parseFloat($q("#montopdte").value).toFixed(2) || null);
        gasto.append("impuestos", parseFloat($q("#impuestos").value).toFixed(2) || null);
        gasto.append("costofinalunit", parseFloat($q("#costofinalunit").value).toFixed(2) || null);


        const response = await fetch(`${host}gastoentrada.controller.php`, {
            method: "POST",
            body: gasto,
        });

        const result = await response.json();
        return result;
    }

    async function registrarGastoNomina(idnomina) {
        const gasto = new FormData();
        gasto.append("operation", "registrarGastoNomina");

        gasto.append("idnomina", idnomina);
        gasto.append("descripcion", $q("#descripcion").value || "");
        gasto.append("monto", $q("#monto").value || "");



        const response = await fetch(`${host}nomina.controller.php`, {
            method: "POST",
            body: gasto,
        });

        const result = await response.json();
        return result;
    }


    //ME QUEDE EN REGSITRAR GASTO NOMINA
    $q("#form-registro-gasto").addEventListener("submit", async (e) => {
        e.preventDefault()

        if ($q("#colaborador").value == "") {
            const gastoentradaRegis = await registrarGastoEntrada()
            console.log("gastoentradaRegis", gastoentradaRegis);
            if (gastoentradaRegis.idgastoentrada) {
                showToast("Gasto registrado correctamente", "SUCCESS")
                $q("#form-registro-gasto").reset()
                $q("#div-estadopago").classList.add("d-none")
            }
        } else {
            const gastoentradaRegis = await registrarGastoEntrada()
            const gastonomina = await registrarGastoNomina(idnomina)
            console.log("gastonomina -> ", gastonomina);
            console.log("gastoentradaRegis", gastoentradaRegis);
            if (gastoentradaRegis.idgastoentrada) {
                showToast("Gasto registrado correctamente", "SUCCESS")
                $q("#form-registro-gasto").reset()
                $q("#div-estadopago").classList.add("d-none")
            }
        }
    })

    $q("#costounitario").addEventListener("input", async (e) => {
        costo = e.target.value
        if ($q("#foliofactura").value != "") {
            if ($q("#concepto").value == "8" && $q("#estado").value == "2") {
                calcularImpuestosInventarioPagado()
                return
            }
        }

        /* console.log("costo > ,", costo);
        if ($q("#estado").value == "1" && $q("#concepto").value == "8") { // PENDIENTE
            costofinal = parseFloat(costo)
            montopdte = parseFloat(costo)
            costofinalunit = parseFloat(costo)
            $q("#costofinal").value = costofinal
            $q("#montopdte").value = montopdte
            $q("#costofinalunit").value = costofinalunit
        } */
    })

    $q("#colaborador").addEventListener("change", async (e) => {
        const ultimaNomina = await obtenerUltimaNominaPorColaborador($q("#colaborador").value)
        console.log("ultima nomina -> ", ultimaNomina);
        acumuladoUltimo = ultimaNomina[0]?.acumulado
        idnomina = ultimaNomina[0]?.idnomina
    })

    $q("#concepto").addEventListener("change", async (e) => {
        const concepto = e.target.value
        console.log("target", e.target.value);
        switch (concepto) {
            case "1": // oficina
                if ($q("#estado").value == "2") {
                    $q("#div-subtipo").classList.remove("d-none")
                    $q("#div-colaborador").classList.add("d-none")
                    $q("#div-cunitario").classList.add("d-none")
                    $q("#div-pagadoanticipo").classList.add("d-none")
                    $q("#div-costofinalunit").classList.add("d-none")
                    $q("#div-pendiente").classList.add("d-none")

                    // DISABLES
                    $q("#cantidad").disabled = true
                    $q("#nombre").disabled = true
                    $q("#unidades").disabled = true
                }
                else {
                    $q("#div-subtipo").classList.remove("d-none")
                    $q("#div-colaborador").classList.add("d-none")
                    $q("#div-cunitario").classList.add("d-none")
                    $q("#div-pagadoanticipo").classList.remove("d-none")
                    $q("#div-costofinalunit").classList.add("d-none")
                    $q("#div-pendiente").classList.remove("d-none")


                    // DISABLES
                    $q("#cantidad").disabled = true
                    $q("#nombre").disabled = true
                    $q("#unidades").disabled = true
                }
                break;

            case "2": // Venta
                $q("#div-subtipo").classList.remove("d-none")
                $q("#div-colaborador").classList.add("d-none")
                $q("#div-cunitario").classList.add("d-none")
                $q("#div-pagadoanticipo").classList.remove("d-none")
                $q("#div-costofinalunit").classList.add("d-none")
                $q("#div-pendiente").classList.remove("d-none")

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
                $q("#div-costofinalunit").classList.add("d-none")
                $q("#div-pendiente").classList.remove("d-none")

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
                $q("#div-costofinalunit").classList.add("d-none")
                $q("#div-pendiente").classList.remove("d-none")

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
                $q("#div-costofinalunit").classList.add("d-none")
                $q("#div-pendiente").classList.remove("d-none")

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
                $q("#div-costofinalunit").classList.add("d-none")
                $q("#div-pendiente").classList.remove("d-none")

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
                $q("#div-costofinalunit").classList.add("d-none")
                $q("#div-pendiente").classList.remove("d-none")

                // DISABLES
                $q("#cantidad").disabled = true
                $q("#nombre").disabled = true
                $q("#unidades").disabled = true
                break;

            case "8": // inventario
                if ($q("#estado").value == "1") { // ESTADO PENDIENTE
                    $q("#div-gasto").classList.add("d-none")
                    $q("#div-pagadoanticipo").classList.remove("d-none")
                    $q("#div-cunitario").classList.remove("d-none")
                    $q("#div-subtipo").classList.add("d-none")
                    $q("#div-colaborador").classList.add("d-none")
                    $q("#div-pendiente").classList.remove("d-none")

                    $q("#div-costofinalunit").classList.remove("d-none")

                    $q("#div-formapago").classList.add("d-none")
                    $q("#div-cuenta").classList.add("d-none")
                    $q("#div-emision").hidden = false

                    $q("#cantidad").disabled = false
                    $q("#nombre").disabled = false
                    $q("#unidades").disabled = false
                    $q("#foliofactura").disabled = false

                } else { // OTRO ESTADO 
                    $q("#div-pagadoanticipo").classList.add("d-none")
                    $q("#div-gasto").classList.add("d-none")
                    $q("#div-cunitario").classList.remove("d-none")
                    $q("#div-subtipo").classList.add("d-none")
                    $q("#div-colaborador").classList.add("d-none")
                    $q("#div-pendiente").classList.add("d-none") // QUITAR TODOS

                    $q("#div-costofinalunit").classList.remove("d-none")

                    $q("#div-formapago").classList.add("d-none")
                    $q("#div-cuenta").classList.add("d-none")
                    //$q("#div-tasafactura").hidden = true
                    //$q("#div-emision").hidden = true

                    $q("#cantidad").disabled = false
                    $q("#nombre").disabled = false
                    $q("#unidades").disabled = false
                    $q("#foliofactura").disabled = false

                }


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
        ngasto = e.target.value
        console.log("gasto value ", ngasto);
        if (ngasto != "") {
            $q("#foliofactura").disabled = false
            // /* $q("#descripcion").disabled = false */
            $q("#formapago").disabled = false
            $q("#cuenta").disabled = false

        }
        else {
            $q("#foliofactura").disabled = true

            $q("#formapago").disabled = true
            $q("#cuenta").disabled = true
        }

        if ($q("#estado").value == "2" && $q("#concepto").value == "1" && $q("#subtipo").value == "1") {
            calcularImpuestosOficinaPagadas()

            return
        }

        if ($q("#concepto").value == "1" && $q("#subtipo").value == "1" && $q("#estado").value == "2" && $q("#foliofactura").value != "") {
            impuestos = parseFloat(ngasto) * 0.18
            //impuestos = (parseFloat(pagoAnticipado) * 0.18).toFixed(2)
            $q("#impuestos").value = impuestos.toFixed(2)
            //DESHABILITAR ATRIBUTOS
            /* $q("#descripcion").disabled = false */
            $q("#descripcion").value = ''
            $q("#emision").disabled = false
            //$q("#tasafactura").disabled = true
            $q("#emision").value = ""

        }



        /* const impuesto = parseFloat(ngasto) * 0.18
        const costofinal = parseFloat(ngasto) + parseFloat(impuesto) */
        if ($q("#concepto").value == "1" && $q("#subtipo").value == "2" && $q("#estado").value == "2") {
            console.log("entrando");
            calcularImpuestosOficinaPagado()
            return

        }
        if ($q("#concepto").value == "1" && $q("#subtipo").value == "1") {
            console.log("entrando a concepto 1");
            costofinal = parseFloat(ngasto)

            //$q("#impuestos").value = parseFloat(impuesto).toFixed(2)
            $q("#costofinal").value = parseFloat(costofinal).toFixed(2)
            $q("#montopdte").value = parseFloat(costofinal).toFixed(2)
            if ($q("#pagadoanticipo").value != "") {
                montopdte = parseFloat(ngasto) - parseFloat(pagoAnticipado)
                $q("#montopdte").value = montopdte
            }
            calcularImpuestos()

            return
        }


    })

    function calcularImpuestosOficinaPagado() {
        $q("#egreso").value = parseFloat(ngasto).toFixed(2)
        $q("#costofinal").value = parseFloat(ngasto).toFixed(2)
        if ($q("#foliofactura").value != "") {
            console.log("adentro...");
            impuestos = parseFloat(ngasto) * 0.18
            costofinal = (parseFloat($q("#costofinal").value) * 1.18).toFixed(2)
            console.log("costo final -> ", calcularImpuestosOficinaPagado);
            egreso = costofinal
            $q("#egreso").value = egreso
            $q("#costofinal").value = costofinal me quede aca gaaaaaaaaaaaaaaaaaaaaa
            $q("#impuestos").value = impuestos.toFixed(2) // ME QUEDE ACA
        } else {
            costofinal = parseFloat($q("#costofinal").value).toFixed(2)
            egreso = parseFloat($q("#costofinal").value).toFixed(2)
            $q("#egreso").value = egreso
            $q("#costofinal").value = costofinal
        }

    }

    function calcularImpuestos() {
        if ($q("#foliofactura").value != "") {
            console.log("ENTRANOD A FOLIO FACTURA DESDE RAAA");
            impuestos = parseFloat(pagoAnticipado) - (parseFloat(pagoAnticipado) / 1.18)
            //impuestos = (parseFloat(pagoAnticipado) * 0.18).toFixed(2)
            $q("#impuestos").value = impuestos.toFixed(2)
            costofinal = (parseFloat(ngasto) * 1.18).toFixed(2)
            console.log("entrando -> ", costofinal);
            $q("#costofinal").value = costofinal
            montopdte = (costofinal - parseFloat(pagoAnticipado)).toFixed(2)
            $q("#montopdte").value = montopdte

            //DESHABILITAR ATRIBUTOS
            /* $q("#descripcion").disabled = false */
            $q("#descripcion").value = ''
            $q("#emision").disabled = false
            //$q("#tasafactura").disabled = true
            $q("#emision").value = ""
            return
        }
    }

    function calcularImpuestosInventario() { // PARA ESTADOS PENDIENTES
        if ($q("#foliofactura").value != "") {
            costofinalunit = (parseFloat($q("#costounitario").value) * 1.18).toFixed(2)
            costofinal = (costo * cantidad).toFixed(2)
            costofinal = (costofinal * 1.18).toFixed(2)
            impuestos = (parseFloat(pagoAnticipado) - (parseFloat(pagoAnticipado) / 1.18)).toFixed(2)
            console.log("impuestos -> ", impuestos);
            console.log("pagoAnticipado -> ", pagoAnticipado);
            montopdte = (costofinal - parseFloat(pagoAnticipado)).toFixed(2)
            //impuestos = (parseFloat($q("#pagadoanticipo").value * 0.18)).toFixed(2)
            console.log(" costofinalunit -> xd", costofinalunit);
            $q("#costofinalunit").value = costofinalunit
            $q("#costofinal").value = costofinal
            $q("#emision").disabled = false
            $q("#montopdte").value = montopdte
            /* $q("#descripcion").disabled = false */
            $q("#impuestos").value = impuestos
            console.log("impuestos value > ", $q("#impuestos").value);
            return
        }
    }

    function calcularImpuestosInventarioPagado() {
        if ($q("#foliofactura").value != "") {
            costofinalunit = (parseFloat($q("#costounitario").value) * 1.18).toFixed(2)

            costofinal = (costo * cantidad).toFixed(2)
            impuestos = (costofinal * 0.18).toFixed(2)
            $q("#impuestos").value = impuestos

            costofinal = (costofinal * 1.18).toFixed(2) // PARA EL COSTO FINAL SI SE USA 1.18 PERO PARA EL IMPUESTO SOLO SERIA EL 0.18
            console.log("costofinal -> ", costofinal);
            console.log("impuestos -> ", impuestos);
            console.log("pagoAnticipado -> ", pagoAnticipado);
            //montopdte = (costofinal - parseFloat(pagoAnticipado)).toFixed(2)
            //impuestos = (parseFloat($q("#pagadoanticipo").value * 0.18)).toFixed(2)
            console.log(" costofinalunit -> xd", costofinalunit);
            $q("#costofinalunit").value = costofinalunit
            $q("#costofinal").value = costofinal
            $q("#egreso").value = costofinal
            /* $q("#descripcion").disabled = false */
            console.log("impuestos value > ", $q("#impuestos").value);
            return
        }
    }

    function calcularImpuestosOficinaPagadas() {
        if ($q("#foliofactura").value != "") {
            impuestos = parseFloat(ngasto) * 0.18
            costofinal = parseFloat(ngasto) * 1.18
            $q("#impuestos").value = impuestos.toFixed(2)
            $q("#egreso").value = costofinal.toFixed(2)
            $q("#costofinal").value = costofinal.toFixed(2)
        } else {
            impuestos = 0
            costofinal = 0
            $q("#impuestos").value = impuestos
            $q("#egreso").value = parseFloat(ngasto).toFixed(2)
            $q("#costofinal").value = parseFloat(ngasto).toFixed(2)

        }
    }

    function calcularImpuestosOficina() { // ESTO ES PARA ESTADOS PENDIENTES
        // ME QUEDE ACA
        /* costofinalunit = (parseFloat($q("#costounitario").value) * 1.18).toFixed(2)
        costofinal = (costo * cantidad).toFixed(2) */
        impuestos = parseFloat(pagoAnticipado) - (parseFloat(pagoAnticipado) / 1.18)
        //impuestos = (parseFloat(pagoAnticipado) * 0.18).toFixed(2)
        $q("#impuestos").value = impuestos.toFixed(2)
        costofinal = (parseFloat(ngasto) * 1.18).toFixed(2)
        console.log("entrando -> ", costofinal);
        $q("#costofinal").value = costofinal
        console.log("costo final valor -> ", $q("#costofinal").value);
        montopdte = (costofinal - parseFloat(pagoAnticipado)).toFixed(2)
        $q("#montopdte").value = montopdte

        //DESHABILITAR ATRIBUTOS
        /* $q("#descripcion").disabled = false */
        $q("#descripcion").value = ''
        $q("#emision").disabled = false
        //$q("#tasafactura").disabled = true
        $q("#emision").value = ""
    }

    $q("#pagadoanticipo").addEventListener("input", e => {
        pagoAnticipado = parseFloat(e.target.value) || 0;
        gasto = parseFloat($q("#gasto").value) || 0;
        const concepto = $q("#concepto").value;           // id del concepto
        const estado = $q("#estado").value;             // id del estado

        /* --------------------------------------------------------------
           Habilitar / deshabilitar forma de pago y cuenta
        -------------------------------------------------------------- */
        const formaPagoEl = $q("#formapago");
        const cuentaEl = $q("#cuenta");

        const hayPago = e.target.value.trim() !== "";
        formaPagoEl.disabled = !hayPago;
        cuentaEl.disabled = !hayPago;


        if (concepto == "1" && $q("#subtipo").value == "1" && estado == "1") {
            egreso = parseFloat(pagoAnticipado).toFixed(2)
            $q("#egreso").value = egreso
            montopdte = parseFloat(ngasto) - parseFloat(pagoAnticipado)
            $q("#montopdte").value = montopdte
            if ($q("#foliofactura").value != "") {
                impuestos = (parseFloat(pagoAnticipado) * 0.18).toFixed(2)
                $q("#impuestos").value = impuestos
            }
            if (parseFloat($q("#pagadoanticipo").value) >= parseFloat($q("#gasto").value)) {
                mostrarEstadoPago("pagado");   // nada que mostrar
            } else {
                mostrarEstadoPago("pendiente");   // nada que mostrar
            }

            calcularImpuestos()

        }

        /* --------------------------------------------------------------
           Caso especial: concepto 8 (INVENTARIO) + estado 1 (PENDIENTE)  →  Anticipo interno
        -------------------------------------------------------------- */
        if (concepto === "8" && estado === "1") {
            if (cantidad <= 0) {
                $q("#montopdte").value = pagoAnticipado.toFixed(2);
                $q("#egreso").value = pagoAnticipado.toFixed(2);
                mostrarEstadoPago("oculto");   // nada que mostrar
                return;
            }
            $q("#montopdte").value = (costofinal - pagoAnticipado).toFixed(2);
            //$q("#egreso").value = pagoAnticipado.toFixed(2);
            //$q("#costofinal").value = (costofinal * cantidad).toFixed(2)
            mostrarEstadoPago("oculto");   // nada que mostrar
            return;
        }

        /* --------------------------------------------------------------
           Pago ≥ gasto  →  Pagado,   si no → Pendiente
        -------------------------------------------------------------- */
        if (pagoAnticipado >= gasto && gasto > 0) {
            mostrarEstadoPago("pagado");
        } else {
            mostrarEstadoPago("pendiente");
        }
    });

    $q("#cantidad").addEventListener("input", async (e) => {
        cantidad = e.target.value
        console.log("cantidd -> ", cantidad);
        if ($q("#estado").value == "1" && $q("#concepto").value == "8") { // ESTADO PENDIENTE Y CONCEPTO INVENTARIO
            costofinal = (costo * cantidad).toFixed(2)
            $q("#costofinal").value = costofinal
            console.log("costo final unit -> ", costofinal);
            montopdte = (costofinal - pagoAnticipado).toFixed(2)
            $q("#montopdte").value = montopdte
            valorescalculadospordefectoInventario()

            calcularImpuestosInventario()

            //$q("#costofinalunit").value = 
        }
        if ($q("#foliofactura").value != "") {
            costofinalunit = (parseFloat($q("#costounitario").value) * 1.18).toFixed(2)
            $q("#costofinalunit").value = costofinalunit
            if ($q("#concepto").value == "8" && $q("#estado").value == "2") {
                calcularImpuestosInventarioPagado()
                return
            }
        }
        if (cantidad <= 0) {
            $q("#montopdte").value = pagoAnticipado.toFixed(2);
            mostrarEstadoPago("oculto");   // nada que mostrar
            return;
        }

        mostrarEstadoPago("oculto");   // nada que mostrar
        return;
    })


    function mostrarEstadoPago(estado) {
        const wrapper = $q("#div-estadopago");
        wrapper.classList.remove("d-none");

        if (estado === "pagado") {
            wrapper.innerHTML = `
            <div class="bg-success h-100 w-100 text-white text-center
                        d-flex align-items-center justify-content-center">
                Pagado
            </div>`;
        } else if (estado === "pendiente") {
            wrapper.innerHTML = `
            <div class="bg-danger h-100 w-100 text-white text-center
                        d-flex align-items-center justify-content-center">
                Pendiente
            </div>`;
        } else {                    // "oculto"
            wrapper.classList.add("d-none");
            wrapper.innerHTML = "";
        }
    }

    function valorescalculadospordefectoInventario() {
        costofinal = 0
        $q("#costofinalunit").value = $q("#costounitario").value
        $q("#impuestos").value = 0
        $q("#costofinal").value = (cantidad * $q("#costounitario").value).toFixed(2)
        $q("#montopdte").value = (parseFloat($q("#costofinal").value) - parseFloat($q("#pagadoanticipo").value)).toFixed(2)
    }

    $q("#foliofactura").addEventListener("input", async (e) => {
        const gasto = e.target.value
        console.log("gasto value ", gasto);

        if ($q("#concepto").value == "1" && $q("#subtipo").value == "1" && $q("#estado").value == "2") {
            calcularImpuestosOficinaPagadas()
            //DESHABILITAR ATRIBUTOS
            /* $q("#descripcion").disabled = false */
            $q("#descripcion").value = ''
            $q("#emision").disabled = false
            //$q("#tasafactura").disabled = true
            $q("#emision").value = ""

            return
        }

        if ($q("#concepto").value == "1" && $q("#subtipo").value == "1" && $q("#estado").value == "1") {

            /* if ($q("#foliofactura").value == "") {
                console.log("ESTA VACIO");
                costofinal = parseFloat(ngasto)

                //$q("#impuestos").value = parseFloat(impuesto).toFixed(2)
                $q("#costofinal").value = parseFloat(costofinal).toFixed(2)
                $q("#montopdte").value = parseFloat(costofinal).toFixed(2)
                $q("#impuestos").value = ""

                if ($q("#pagadoanticipo").value != "") {
                    montopdte = parseFloat(ngasto) - parseFloat(pagoAnticipado)
                    $q("#montopdte").value = montopdte
                }
                return
            } */
            if ($q("#foliofactura").value.trim() != "") {
                console.log("NO ESTA VACIO");
                console.log("entrando ...");

                calcularImpuestosOficina()
                return

            } else {
                console.log("ESTA VACIO");
                costofinal = parseFloat(ngasto)

                //$q("#impuestos").value = parseFloat(impuesto).toFixed(2)
                $q("#costofinal").value = parseFloat(costofinal).toFixed(2)
                $q("#montopdte").value = parseFloat(costofinal).toFixed(2)
                $q("#impuestos").value = ""

                if ($q("#pagadoanticipo").value != "") {
                    montopdte = parseFloat(ngasto) - parseFloat(pagoAnticipado)
                    $q("#montopdte").value = montopdte
                }
                return
            }

        }

        if ($q("#concepto").value == "8" && $q("#estado").value == "2") {
            calcularImpuestosInventarioPagado()
            return
        }


        valorescalculadospordefectoInventario()

        calcularImpuestosInventario()


        if (gasto != "") {
            $q("#emision").disabled = false
            //$q("#tasafactura").disabled = false
        }
        else {
            $q("#emision").disabled = true
            //$q("#tasafactura").disabled = true
            $q("#emision").value = ""


            $q("#descripcion").value = ''

        }
    })

    $q("#btn-resetear").addEventListener("click", async () => {
        $q("#form-registro-gasto").reset()
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

    /* $q("#") */

})