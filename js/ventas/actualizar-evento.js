document.addEventListener("DOMContentLoaded", async () => {
    let iddp = window.localStorage.getItem("iddp")

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

    // *************************************** OBTENCION DE DATOS **************************************
    async function obtenerInfoDPporId(iddp) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerInfoDPporId");
        params.append("iddetallepresentacion", iddp);
        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        return data;
    }

    async function renderizarDetalleEvento() {
        const infoDp = await obtenerInfoDPporId(iddp)
        console.log("info dp -> ", infoDp);
    }

    await renderizarDetalleEvento() ME QUEDE ACAAAAAAAAAAAAAAAAAA
    // *********************************** ACTUALIZACION DE DATOS **************************************

    // **************************************** EVENTOS ***********************************************
})