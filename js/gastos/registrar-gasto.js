document.addEventListener("DOMContentLoaded", async () => {
    let myTable = null;

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

    $q("#div-detalles").hidden = true
    $q("#div-comprobante-pago").hidden = true
    $q("#div-artista").hidden = true
    $q("#div-evento").hidden = true

    // ********************************* OBTENER DATOS **********************************

    async function obtenerUsuariosPorNivel() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", 6);

        try {
            const data = await getDatos(`${host}usuario.controller.php`, params);

            console.log(data);
            $q("#artista").innerHTML = '<option value="">Selecciona</option>'
            data.forEach(artista => {
                $q("#artista").innerHTML += `
                    <option value="${artista.idusuario}">${artista.nom_usuario}</option>
                `
            });
            //return data // Verifica la estructura de los datos en la consola
        } catch (error) {
            console.error("Error al obtener los usuarios:", error);
        }
    }

    async function obtenerEventos() { // PARA OBTENER DATOS DE CLIENTE Y DE EVENTO (NO INCLUYE TARIFARIO NI COSTO EN PRESENTACION DE TAL LOCAL)
        const params = new URLSearchParams();
        params.append("operation", "filtrarAtenciones");
        params.append("ncotizacion", "");
        params.append("ndocumento", "");
        params.append("nomusuario", "")
        params.append("establecimiento", "")
        params.append("fechapresentacion", "")
        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        $q("#evento").innerHTML = ``
        data.forEach(evento => {
            $q("#evento").innerHTML += `<option value="${evento.iddetalle_presentacion}">${evento.nom_usuario} - ${evento.establecimiento} (${evento.departamento} | ${evento.provincia} | ${evento.distrito}) [${evento.fecha_presentacion}]</option>`

        });
        //        return data
    }


    $q("#mediopago").addEventListener("change", async (e) => {
        const tipopago = e.target.value
        if (tipopago == "1") {
            $q("#div-comprobante-pago").hidden = false
            $q("#div-detalles").hidden = true

        } else {
            $q("#div-comprobante-pago").hidden = true
            $q("#div-detalles").hidden = false

        }
    })

    $q("#upload_widget_pago").addEventListener("change", function (e) {
        console.log("cambiando...");
        const file = e.target.files[0];
        console.log("file de imagen event -> ", file);
        const preview = $q("#previewImagenPago");

        if (file && file.type.startsWith("image/")) {
            console.log("renderizando ,,,,");
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = "block";
            };
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
            preview.style.display = "none";
        }
    });

    $q("#upload_widget_facturaboleta").addEventListener("change", function (e) {
        console.log("cambiando...");
        const file = e.target.files[0];
        console.log("file de imagen event -> ", file);
        const preview = $q("#previewImagenFacturaBoleta");

        if (file && file.type.startsWith("image/")) {
            console.log("renderizando ,,,,");
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = "block";
            };
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
            preview.style.display = "none";
        }
    });

    // ****************************** REGISTRAR GASTO ********************************

    async function registrarGastoYEntrada(comprobanteurl, comprobantefacbol) {
        const gasto = new FormData();
        gasto.append("operation", "registrarGastoYEntrada");

        gasto.append("concepto", $q("#concepto").value || "");
        gasto.append("fechagasto", $q("#fechagasto").value || "");
        gasto.append("monto", $q("#monto").value || "");
        gasto.append("tipo", $q("#tipo").value || "");
        gasto.append("iddetallepresentacion", $q("#evento").value || "");
        gasto.append("idusuario", $q("#artista").value || "");
        gasto.append("mediopago", $q("#mediopago").value || "");
        gasto.append("detalles", $q("#detalles").value || "");
        gasto.append("comprobanteurl", comprobanteurl ? comprobanteurl : '');
        gasto.append("comprobantefacbol", comprobantefacbol ? comprobantefacbol : '');

        const response = await fetch(`${host}gastoentrada.controller.php`, {
            method: "POST",
            body: gasto,
        });

        const result = await response.json();
        return result;
    }

    $q("#form-registro-gasto").addEventListener("submit", async (e) => {
        e.preventDefault()

        const imagenInputPago = $q("#upload_widget_pago");
        const filePago = imagenInputPago.files[0];
        const imagenInputFacturaBoleta = $q("#upload_widget_facturaboleta");
        const fileFacturaBoleta = imagenInputFacturaBoleta.files[0];
        console.log("filePago -> ", filePago);
        console.log("fileFacturaBoleta -> ", fileFacturaBoleta);

        const gastoentradaRegis = await registrarGastoYEntrada(filePago, fileFacturaBoleta)
        console.log("gasto o entrada registrada -> ", gastoentradaRegis);
        if (gastoentradaRegis.idgastoentrada) {
            showToast("Se ha registrado correctamente", "SUCCESS", 1000);
            return
        }
    })

    $q("#referido").addEventListener("change", async (e) => {
        const referido = e.target.value
        if (referido == "1") {
            await obtenerUsuariosPorNivel() // SOLO ARTISTAS
            $q("#div-artista").hidden = false
            $q("#div-evento").hidden = true
        } else if (referido == "2") {
            await obtenerEventos()
            $q("#div-artista").hidden = true
            $q("#div-evento").hidden = false
        }
    })

})