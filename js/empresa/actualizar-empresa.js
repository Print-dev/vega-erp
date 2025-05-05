document.addEventListener("DOMContentLoaded", async () => {

    // variables cloduinary
    let logoempresaOld
    //let imagen_public_id = "";
    //let urlMarca = `https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/`


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

    // ********************************** OBTENER DATOS **************************************************

    async function obtenerDatosEmpresa() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDatosEmpresa");
        const data = await getDatos(`${host}empresa.controller.php`, params);
        console.log("data .> ", data);
        return data
    }

    // ***************************** CLOUDINARY ********************************************************
    /* let myWidget = cloudinary.createUploadWidget(
        {
            cloudName: "dynpy0r4v",
            uploadPreset: "vegaimagenes",
            folder: "vegaimagenes",
        },
        async (error, result) => {
            if (!error && result && result.event === "success") {
                console.log("result -> ", result);

                let previewImagen = document.getElementById("logo-preview");
                previewImagen.src = result.info.secure_url;
                //previewImagen.classList.remove("d-none");
                imagen_public_id = result.info?.public_id;
                //$q("#btnGuardarContenido").disabled = false;
            }
        }
    );

    $q("#upload_widget")?.addEventListener(
        "click",
        function () {
            myWidget.open();
        },
        false
    );
 */
    // ******************************* ACTUALIZAR DATOS ************************************************

    async function actualizarDatosEmpresa(logoempresa) {
        const body = new FormData();
        body.append("operation", "actualizarDatosEmpresa");
        body.append("idempresa", 1); // uno por el momento
        body.append("ruc", $q("#ruc").value ? $q("#ruc").value : '');
        body.append("logoempresa", logoempresa ? logoempresa : logoempresaOld);
        body.append("logoempresaAntiguo", logoempresaOld);
        body.append("razonsocial", $q("#razonsocial").value ? $q("#razonsocial").value : '');
        body.append("nombrecomercial", $q("#nombrecomercial").value ? $q("#nombrecomercial").value : '');
        body.append("nombreapp", $q("#nombreapp").value ? $q("#nombreapp").value : '');
        body.append("direccion", $q("#direccion").value ? $q("#direccion").value : '');
        body.append("web", $q("#web").value ? $q("#web").value : '');
        /* body.append("usuariosol", $q("#usuariosol").value ? $q("#usuariosol").value : '');
        body.append("clavesol", $q("#clavesol").value ? $q("#clavesol").value : '');
        body.append("certificado", $q("#certificado").value ? $q("#certificado").value : ''); */
        body.append("correo", $q("#correoapp").value ? $q("#correoapp").value : '');
        body.append("contrasenagmailapp", $q("#contrasenagmailapp").value ? $q("#contrasenagmailapp").value : '');
        body.append("ncuenta", $q("#ncuenta").value ? $q("#ncuenta").value : '');
        body.append("ncci", $q("#ncci").value ? $q("#ncci").value : '');
        body.append("banco", $q("#banco").value ? $q("#banco").value : '');
        body.append("moneda", $q("#moneda").value ? $q("#moneda").value : '');
        // body.append("esRepresentante", $q("#esrepresentante").checked ? 1 : 0);

        const fbody = await fetch(`${host}empresa.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    const datosEmpresa = await obtenerDatosEmpresa()
    logoempresaOld = datosEmpresa[0]?.logoempresa

    renderData(datosEmpresa[0])

    function renderData(data) {
        $q("#ruc").value = data.ruc
        $q("#razonsocial").value = data.razonsocial
        $q("#nombrecomercial").value = data.nombrecomercial
        $q("#nombreapp").value = data.nombreapp
        $q("#direccion").value = data.direccion
        /* $q("#usuariosol").value = data.usuariosol
        $q("#clavesol").value = data.clavesol
        $q("#certificado").value = data.certificado */
        $q("#web").value = data.web
        $q("#correoapp").value = data.correo
        $q("#contrasenagmailapp").value = data.contrasenagmailapp
        $q("#ncuenta").value = data.ncuenta
        $q("#ncci").value = data.ncci
        $q("#banco").value = data.banco
        $q("#moneda").value = data.moneda
        $q("#previewImagenLogo").src = `https://res.cloudinary.com/dynpy0r4v/image/upload/v1746330530/${data.logoempresa}`
    }

    $q("#btnActualizarEmpresa").addEventListener("click", async () => {
        try {
            const btn = $q("#btnActualizarEmpresa")
            const imagenInputLogo = $q("#upload_widget_logo");
            const fileLogo = imagenInputLogo.files[0];
            btn.disabled = true
            btn.textContent = "Guardando..."
            const empresa = await actualizarDatosEmpresa(fileLogo)
            console.log("empresa actualizada?", empresa);
            if (empresa) {
                showToast("Datos de la empresa actualizados", "SUCCESS", 1000)
                await new Promise(r => setTimeout(r, 1000));
                showToast("Para ver cambios de imagen y nombre de aplicación vuelva a iniciar sesión.", "INFO", 3000);
                btn.disabled = false
                btn.textContent = "Actualizar"
                return
            }
        } catch (error) {
            showToast("Un error ha ocurrido", "ERROR")
            return
        }
    })


    $q("#upload_widget_logo").addEventListener("change", function (e) {
        console.log("cambiando...");
        const file = e.target.files[0];
        console.log("file de imagen event -> ", file);
        const preview = $q("#previewImagenLogo");

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
})