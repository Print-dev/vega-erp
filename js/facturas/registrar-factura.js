document.addEventListener("DOMContentLoaded", async () => {
    // variables glob
    let costoDificultad
    let sucursalSelect = $q("#sucursal")
    let clienteSelect = $q("#cliente")
    let eventosSelect = $q("#evento")

    // OBTENER CORDENADAS
    let latOrigen
    let lonOrigen
    let calcularDificultadPrecio = [] // ESTO SERVIRAR PARA PONERLO EN LA TABLA DE FACTURA

    navigator.geolocation.getCurrentPosition(function (position) {
        latOrigen = position.coords.latitude;
        lonOrigen = position.coords.longitude;
        console.log(`Tu ubicación: ${latOrigen},${lonOrigen}`);
    });


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

    // **************************** OBTENER DATA PARA CALCULAR VIAJES Y COSTOS DE VIAJE *****************************

    async function obtenerLongLatPorCiudad(provincia) {
        const Fdata = await fetch(`https://nominatim.openstreetmap.org/search?q=${provincia}&format=json`)
        const data = await Fdata.json()
        return data
    }

    async function obtenerDuracionDeViaje(lon_origen, lat_origen, lon_destino, lat_destino) {
        const Fdata = await fetch(`https://router.project-osrm.org/route/v1/driving/${lon_origen},${lat_origen};${lon_destino},${lat_destino}?overview=false`)
        const data = await Fdata.json()
        return data
    }

    // ************************* OBTENER DATA **********************************

    async function obtenerDatosEmpresa() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDatosEmpresa");
        const data = await getDatos(`${host}empresa.controller.php`, params);
        console.log("data .> ", data);
        return data
    }

    async function obtenerDPporId(iddp) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDPporId");
        params.append("iddetallepresentacion", iddp);
        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        return data;
    }

    async function obtenerSucursalesPorEmpresa() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerSucursalesPorEmpresa");
        params.append("idempresa", 1);
        const data = await getDatos(`${host}sucursal.controller.php`, params);
        console.log("data .> ", data);
        sucursalSelect.innerHTML = '<option value="">Selecciona</option>'
        data.forEach(sucursal => {
            sucursalSelect.innerHTML += `<option value="${sucursal.idsucursal}">${sucursal.nombre} (${sucursal.departamento}/${sucursal.provincia}/${sucursal.distrito})</option>`
        });
        return data
    }

    async function obtenerClientes() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerClientes");
        const data = await getDatos(`${host}cliente.controller.php`, params);
        console.log("data .> ", data);
        clienteSelect.innerHTML = '<option value="">Selecciona</option>'
        data.forEach(cliente => {
            clienteSelect.innerHTML += `<option value="${cliente.idcliente}">${cliente.razonsocial} - ${cliente.ndocumento}</option>`
        });
        return data
    }

    async function obtenerTarifaArtistaPorProvincia(idprovincia, idusuario) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTarifaArtistaPorProvincia");
        params.append("idprovincia", idprovincia);
        params.append("idusuario", idusuario);
        const fpersona = await getDatos(`${host}tarifa.controller.php`, params)
        return fpersona
    }

    async function dataFilters() {
        const params = new URLSearchParams();
        params.append("operation", "filtrarAtenciones");
        params.append("ncotizacion", '');
        params.append("ndocumento", '');
        params.append("nomusuario", "")
        params.append("establecimiento", "")
        params.append("fechapresentacion", "")

        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        console.log("data -> ", data);
        eventosSelect.innerHTML = `<option value="">Selecciona</option>`
        data.forEach(evento => {
            eventosSelect.innerHTML += `<option value="${evento.iddetalle_presentacion}">${evento.nom_usuario} - ${evento.establecimiento} (${evento.departamento} | ${evento.provincia} | ${evento.distrito}) [${evento.fecha_presentacion}]</option>`
        });
    }

    async function renderizarUbigeoPresentacion(iddp) {
        const dp = await obtenerDPporId(iddp);
        console.log(dp);
        //alert("asdasdd")
        idprovincia = dp[0]?.idprovincia;
        idartista = dp[0]?.idusuario;
        provincia = dp[0]?.provincia;
        iddetalleevento = dp[0]?.iddetalle_presentacion;


        const longlatCiudad = await obtenerLongLatPorCiudad(dp[0]?.departamento + ',' + dp[0]?.provincia)
        console.log("longlatCiudad->>>", longlatCiudad)
        const infoRecorrido = await obtenerDuracionDeViaje(lonOrigen, latOrigen, longlatCiudad[0]?.lon, longlatCiudad[0]?.lat)
        const duracionTiempoCrudo = infoRecorrido.routes[0]?.duration
        calcularDificultadPrecio = calcularPrecio(duracionTiempoCrudo)

        $q("#tablaProductos tbody").innerHTML += `
            <tr>
                <td></td>
                <td>Puesto en la locación de ${dp[0]?.provincia}</td>
                <td>S/ ${calcularDificultadPrecio?.costoDificultad}</td>
                <td>S/ ${calcularDificultadPrecio?.costoDificultad}</td>
            </tr>
        `

        costoDificultad = calcularDificultadPrecio?.costoDificultad
        /* $q("#tInfoCotizacion").innerHTML = "";
        $q("#tInfoCotizacion").innerHTML = `
            <tr>
              <td>${dp[0]?.departamento}</td>
              <td>${dp[0]?.provincia}</td>
              <td>${calcularDificultadPrecio?.horasEstimadas}</td>
              <td>${calcularDificultadPrecio?.dificultad}</td>
              <td>${calcularDificultadPrecio?.costoDificultad}</td>
            </tr>
          `; */
    }

    await obtenerDatosEmpresa()
    await obtenerSucursalesPorEmpresa()
    await obtenerClientes()
    await dataFilters()

    eventosSelect.addEventListener("change", async (e) => {
        eventosSelect.disabled = true
        const iddp = e.target.value
        const dp = await obtenerDPporId(iddp)
        const tarifaArtista = await obtenerTarifaArtistaPorProvincia(dp[0]?.idprovincia, dp[0]?.idusuario)
        await renderizarUbigeoPresentacion(iddp)
        console.log("tarifaartista-> ", tarifaArtista);
        console.log("dp info -> ", dp);
        $q("#tablaProductos tbody").innerHTML += `
            <tr>
                <td></td>
                <td>Presentación artística de ${dp[0]?.nom_usuario}</td>
                <td>S/ ${tarifaArtista[0]?.precio}</td>
                <td>S/ ${tarifaArtista[0]?.precio}</td>
            </tr>
        `
        // CALCULOS
        let precioTarifa = tarifaArtista[0]?.precio
        let precioViaje = costoDificultad
        // Calcular el total gravado (sin IGV)
        let totalGravado = parseFloat(precioTarifa) + parseFloat(precioViaje);

        // Calcular el IGV (18%)
        let igv = totalGravado * 0.18;

        // Calcular el total con IGV
        let totalConIgv = totalGravado + igv;

        $q("#txtOperacionGravada").innerHTML = `S/ ${totalGravado.toFixed(2)}`
        $q("#txtIGV").innerHTML = `S/ ${igv.toFixed(2)}`
        $q("#txtImporteTotal").innerHTML = `S/ ${totalConIgv.toFixed(2)}`
    })
})