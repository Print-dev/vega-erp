

document.addEventListener("DOMContentLoaded", async () => {
    console.log("rucEmpresa -> ", rucEmpresa);
    console.log("razonsocialEmpresa -> ", razonsocialEmpresa);
    // variables glob
    const contenedorCuotas = $q("#contenedor-cuotas");
    let contadorCuotas = 1;
    let cuotas = []
    let nuevaCuota
    //let totalMontoCuotasCalculado

    let costoDificultad
    let provinciaDestino
    let montoLetra
    let idsucursalObtenido
    let idclienteObtenido
    // empresa
    let direccionEmisorObtenido
    let distritoEmisorObtenido
    let departamentoEmisorObtenido
    let provinciaEmisorObtenido
    // cliente
    let razonsocialClienteObtenido
    let ndocumentoClienteObtenido
    let sucursalSelect = $q("#sucursal")
    let clienteSelect = $q("#cliente")
    let eventosSelect = $q("#evento")
    // calculos de productos
    let totalGravado
    let igvTotal
    let totalConIgv
    let detalle = []

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

    async function obtenerSucursalPorId(idsucursal) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerSucursalPorId");
        params.append("idsucursal", idsucursal);
        const fpersona = await getDatos(`${host}sucursal.controller.php`, params)
        return fpersona
    }

    async function obtenerClientePorId(idcliente) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerClientePorId");
        params.append("idcliente", idcliente);
        const fpersona = await getDatos(`${host}cliente.controller.php`, params)
        return fpersona
    }

    async function obtenerSeriePorTipoDoc(idtipodoc) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerSeriePorTipoDoc");
        params.append("idtipodoc", idtipodoc);
        const fpersona = await getDatos(`${host}comprobante.controller.php`, params)
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

        $q("#tablaProductos tbody").innerHTML = `
            <tr>
                <td></td>
                <td>Puesto en la locación de ${dp[0]?.provincia}</td>
                <td>S/ ${calcularDificultadPrecio?.costoDificultad}</td>
                <td>S/ ${calcularDificultadPrecio?.costoDificultad}</td>
            </tr>
        `

        costoDificultad = calcularDificultadPrecio?.costoDificultad
        provinciaDestino = dp[0]?.provincia
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

    // ************************************************** REGISTRO DE DATA *******************************************************

    async function emitirFactura(direccion_emisor, departamento, provincia, distrito, ubigeo, ndocumento, razon_social_cliente, serie, correlativo, monto_gravado, igv, total, detalle, monto_letras, tipo_pago, cuotas) {
        const comprobante = new FormData();
        comprobante.append("operation", "emitirFactura");
        // DATOS DE EMPRESA
        comprobante.append("ruc_emisor", rucEmpresa); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
        comprobante.append("razon_social_emisor", razonsocialEmpresa); // id usuario envia la notificacion
        comprobante.append("direccion_emisor", direccion_emisor);
        comprobante.append("departamento", departamento);
        comprobante.append("provincia", provincia);
        comprobante.append("distrito", distrito);
        comprobante.append("ubigeo", ubigeo);
        //DATOS DE CLIENTE
        comprobante.append("ndocumento", ndocumento);
        comprobante.append("razon_social_cliente", razon_social_cliente);

        // DATOS DE Invoice y PRODUCTOS (EVENTO)
        comprobante.append("serie", serie);
        comprobante.append("correlativo", correlativo); //generarCorrelativo()
        comprobante.append("moneda", $q("#tipomoneda").value);
        comprobante.append("monto_gravado", monto_gravado); // calculado 
        comprobante.append("igv", igv) // calculado;
        comprobante.append("total", total);
        comprobante.append("detalle", JSON.stringify(detalle));
        comprobante.append("monto_letras", monto_letras);
        comprobante.append("tipo_pago", tipo_pago);
        comprobante.append("cuotas", JSON.stringify(cuotas));
        //comprobante.append("totalMontoCuotas", totalMontoCuotas);

        const fcomprobante = await fetch(`${host}comprobante.controller.php`, {
            method: "POST",
            body: comprobante,
        });
        const rcomprobante = await fcomprobante.json();
        //console.log("rivatico . ", rcomprobante)
        return rcomprobante;
    }

    async function registrarComprobante(idsucursal, idcliente, idtipodoc, tipopago, nserie, correlativo, tipomoneda, monto) {
        const comprobante = new FormData();
        comprobante.append("operation", "registrarComprobante");
        comprobante.append("idsucursal", idsucursal); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
        comprobante.append("idcliente", idcliente); // id usuario envia la notificacion
        comprobante.append("idtipodoc", idtipodoc);
        comprobante.append("tipopago", tipopago);
        comprobante.append("nserie", nserie);
        comprobante.append("correlativo", correlativo);
        comprobante.append("tipomoneda", tipomoneda);
        comprobante.append("monto", monto);

        const fcomprobante = await fetch(`${host}comprobante.controller.php`, {
            method: "POST",
            body: comprobante,
        });
        const rcomprobante = await fcomprobante.json();
        //console.log("rivatico . ", rcomprobante)
        return rcomprobante;
    }

    async function registrarItemComprobante(idcomprobante, descripcion, valorunitario, valortotal) {
        const comprobante = new FormData();
        comprobante.append("operation", "registrarItemComprobante");
        comprobante.append("idcomprobante", idcomprobante); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
        comprobante.append("cantidad", 1); // id usuario envia la notificacion
        comprobante.append("descripcion", descripcion);
        comprobante.append("valorunitario", valorunitario);
        comprobante.append("valortotal", valortotal);

        const fcomprobante = await fetch(`${host}comprobante.controller.php`, {
            method: "POST",
            body: comprobante,
        });
        const rcomprobante = await fcomprobante.json();
        //console.log("rivatico . ", rcomprobante)
        return rcomprobante;
    }

    async function registrarDetalleComprobante(idcomprobante, estado, info) {
        const comprobante = new FormData();
        comprobante.append("operation", "registrarDetalleComprobante");
        comprobante.append("idcomprobante", idcomprobante); // id usuario recibe la notificacion , ahorita es uno pero luego se cambiara a que sean elegibles
        comprobante.append("estado", estado);
        comprobante.append("info", info);

        const fcomprobante = await fetch(`${host}comprobante.controller.php`, {
            method: "POST",
            body: comprobante,
        });
        const rcomprobante = await fcomprobante.json();
        //console.log("rivatico . ", rcomprobante)
        return rcomprobante;
    }


    // *************************************************** EVENTOS ****************************************************************

    eventosSelect.addEventListener("change", async (e) => {
        $q("#tablaProductos tbody").innerHTML = `
        <div class="col-md-12">
            <div class="row text-center">
                <label class="form-label text-center">Cargando...</label>              
            </div>
        </div>
        
            `

        eventosSelect.disabled = true
        const iddp = e.target.value
        const dp = await obtenerDPporId(iddp)
        await renderizarUbigeoPresentacion(iddp)
        const tarifaArtista = await obtenerTarifaArtistaPorProvincia(dp[0]?.idprovincia, dp[0]?.idusuario)
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
        totalGravado = parseFloat(precioTarifa) + parseFloat(precioViaje);

        // Calcular el IGV (18%)
        igvTotal = totalGravado * 0.18; // ESTO SOLO SERA EL TOTAL DE AMBOS IGV PERO ESTA MAS RESUMIDO

        // Calcular el total con IGV
        totalConIgv = totalGravado + igvTotal;

        $q("#txtOperacionGravada").innerHTML = `S/ ${totalGravado.toFixed(2)}`
        $q("#txtIGV").innerHTML = `S/ ${igvTotal.toFixed(2)}`
        $q("#txtImporteTotal").innerHTML = `S/ ${totalConIgv.toFixed(2)}`

        $q("#importeletra").value = n2words(totalConIgv, {
            lang: 'es'
        });

        montoLetra = $q("#importeletra").value

        console.log("igv de presentacion artista -> ", parseFloat((tarifaArtista[0]?.precio * 0.18).toFixed(2)));
        console.log("puesto en la loccacion (precio) -> ", parseFloat((parseFloat(costoDificultad) * 0.18).toFixed(2)));
        // RELLENAR LA LISTA DETALLES (DE PRODUCTOS)
        // -> tarifa de artista
        // ****************************** PARA LA TARIFA DE ARTISTA **************************
        const valorUnitarioTarifa = parseFloat(tarifaArtista[0]?.precio); // sin IGV
        const igvTarifa = parseFloat((valorUnitarioTarifa * 0.18).toFixed(2));  // IGV 18%
        const precioUnitarioTarifa = parseFloat((valorUnitarioTarifa + igvTarifa).toFixed(2)); // con IGV

        detalle.push({
            descripcion: `Presentación artística de ${dp[0]?.nom_usuario}`,
            valorunitario: valorUnitarioTarifa,
            igvproducto: igvTarifa,
            preciounitario: precioUnitarioTarifa
        });

        // -> precio por viaje
        const valorUnitarioViaje = parseFloat(costoDificultad);
        const igvViaje = parseFloat((valorUnitarioViaje * 0.18).toFixed(2));
        const precioUnitarioViaje = parseFloat((valorUnitarioViaje + igvViaje).toFixed(2));

        detalle.push({
            descripcion: `Puesto en la locación de ${provinciaDestino}`,
            valorunitario: valorUnitarioViaje,
            igvproducto: igvViaje,
            preciounitario: precioUnitarioViaje
        });
    })

    $q("#btnDeseleccionarEvento").addEventListener("click", async () => {
        $q("#tablaProductos tbody").innerHTML = ''
        eventosSelect.disabled = false
        eventosSelect.value = ''
        $q("#txtOperacionGravada").innerHTML = 'S/ 0.00'
        $q("#txtIGV").innerHTML = 'S/ 0.00'
        $q("#txtImporteTotal").innerHTML = 'S/ 0.00'
        $q("#importeletra").value = ''
        totalGravado = 0
        igvTotal = 0
        totalConIgv = 0
        detalle = []
    })

    $q("#sucursal").addEventListener("change", async (e) => {
        const sucursalObt = await obtenerSucursalPorId(e.target.value)
        console.log("sucursa ovt- > ", sucursalObt);
        idsucursalObtenido = sucursalObt[0]?.idsucursal
        direccionEmisorObtenido = sucursalObt[0]?.direccion
        departamentoEmisorObtenido = sucursalObt[0]?.departamento
        provinciaEmisorObtenido = sucursalObt[0]?.provincia
        distritoEmisorObtenido = sucursalObt[0]?.distrito
    })

    $q("#cliente").addEventListener("change", async (e) => {
        const clienteObt = await obtenerClientePorId(e.target.value)
        console.log("cliente obt -> ", clienteObt);
        idclienteObtenido = clienteObt[0]?.idcliente
        ndocumentoClienteObtenido = clienteObt[0]?.ndocumento
        razonsocialClienteObtenido = clienteObt[0]?.razonsocial
    })

    $q("#btnEmitirComprobante").addEventListener("click", async () => {
        let cuotasFormateadas = []
        //totalMontoCuotasCalculado = 0
        if ($q("#tipopago").value == 2) {
            cuotasFormateadas = cuotas.map(({ inputMonto, inputFecha }) => {
                return {
                    monto: inputMonto.value,
                    fecha: inputFecha.value
                };
            });

            // Validación: si algún campo está vacío
            const algunaIncompleta = cuotasFormateadas.some(cuota => !cuota.monto || !cuota.fecha);

            if (algunaIncompleta) {
                showToast("Por favor, completa todos los campos de monto y fecha en las cuotas.", "ERROR");
                return;
            }

            if (cuotasFormateadas.length == 0) {
                showToast("Por favor, agregue cuotas.", "ERROR");
                return;
            }

            /* totalMontoCuotasCalculado = cuotasFormateadas.reduce((total, cuota) => {
                return total + parseFloat(cuota.monto || 0);
            }, 0); */

            //console.log("totalMontoCuotas _> ", totalMontoCuotasCalculado);
            // Si todo está bien
            const sumaCuotas = cuotasFormateadas.reduce((acum, cuota) => {
                return acum + parseFloat(cuota.monto || 0);
            }, 0);

            // Verificar igualdad con totalConIgv (usás ese como total final, ¿no?)
            if (parseFloat(sumaCuotas.toFixed(2)) !== parseFloat(totalConIgv.toFixed(2))) {
                alert(`La suma de las cuotas (${sumaCuotas.toFixed(2)}) no coincide con el total a pagar (${totalConIgv.toFixed(2)}).`);
                return;
            }

            console.log("cuotas -> ", cuotasFormateadas);
        }


        const serie = await obtenerSeriePorTipoDoc('01') // cambiarlo luego a boleta en el otro archivo papra boletas
        console.log("serie -> ", serie);
        if (serie.length == 0) {
            //generarCorrelativo('01', '00000000')

            const rptFactura = await emitirFactura(
                direccionEmisorObtenido,
                departamentoEmisorObtenido,
                provinciaEmisorObtenido,
                distritoEmisorObtenido,
                $q("#ubigeo").value,
                ndocumentoClienteObtenido,
                razonsocialClienteObtenido,
                'F001',
                '00000001',
                totalGravado,
                igvTotal,
                totalConIgv,
                detalle,
                montoLetra,
                $q("#tipopago").value,
                cuotasFormateadas ? cuotasFormateadas : [],
                //totalMontoCuotasCalculado
            )
            console.log("rpt factura -> ", rptFactura);
            if (rptFactura?.success == false) {
                showToast(rptFactura.error, "ERROR")
                return
            }
            else if (rptFactura?.success == true) {
                showToast(`¡${rptFactura?.estado}!, ${rptFactura?.descripcion}`, "SUCCESS", 6000)
                const nuevoComprobante = await registrarComprobante(idsucursalObtenido, idclienteObtenido, '01', $q("#tipopago").value, 'F001', '00000001', $q("#tipomoneda").value, totalConIgv)
                console.log("nuevo comprobante -> ", nuevoComprobante);
                console.log("detalle > ", detalle);
                if (nuevoComprobante?.idcomprobante) {
                    detalle.forEach(async item => {
                        const itemRegistrado = await registrarItemComprobante(nuevoComprobante?.idcomprobante, item?.descripcion, item?.valorunitario, item?.preciounitario)
                        console.log("item registrado -> ", itemRegistrado);

                    });
                    const detalleRegistado = await registrarDetalleComprobante(nuevoComprobante?.idcomprobante, rptFactura?.estado, rptFactura?.descripcion)
                    console.log("detalle registdaod -> ", detalleRegistado);
                }
                return
            }
        }
        else {
            const nuevoCorrelativo = generarCorrelativo(serie.at(-1).nserie, serie.at(-1).correlativo)
            console.log("nuevo correlativo -> ", nuevoCorrelativo);
            console.log("Tipo de pago:", $q("#tipopago").value);
            console.log("Cuotas formateadas:", cuotasFormateadas);
            const rptFactura = await emitirFactura(
                direccionEmisorObtenido,
                departamentoEmisorObtenido,
                provinciaEmisorObtenido,
                distritoEmisorObtenido,
                $q("#ubigeo").value,
                ndocumentoClienteObtenido,
                razonsocialClienteObtenido,
                nuevoCorrelativo.serie,
                nuevoCorrelativo.nuevoCorrelativo,
                totalGravado,
                igvTotal,
                totalConIgv,
                detalle,
                montoLetra,
                $q("#tipopago").value,
                cuotasFormateadas ? cuotasFormateadas : [],
                //totalMontoCuotasCalculado
            )
            console.log("rpt factura -> ", rptFactura);
            if (rptFactura?.success == false) {
                showToast(rptFactura.error, "ERROR")
                return
            }
            else if (rptFactura?.success == true) {
                showToast(`¡${rptFactura?.estado}!, ${rptFactura?.descripcion}`, "SUCCESS", 6000)
                const nuevoComprobante = await registrarComprobante(idsucursalObtenido, idclienteObtenido, '01', $q("#tipopago").value, nuevoCorrelativo.serie, nuevoCorrelativo.nuevoCorrelativo, $q("#tipomoneda").value, totalConIgv)
                console.log("nuevo comprobante -> ", nuevoComprobante);
                console.log("detalle > ", detalle);
                if (nuevoComprobante?.idcomprobante) {
                    detalle.forEach(async item => {
                        const itemRegistrado = await registrarItemComprobante(nuevoComprobante?.idcomprobante, item?.descripcion, item?.valorunitario, item?.preciounitario)
                        console.log("item registrado -> ", itemRegistrado);

                    });
                    const detalleRegistado = await registrarDetalleComprobante(nuevoComprobante?.idcomprobante, rptFactura?.estado, rptFactura?.descripcion)
                    console.log("detalle registdaod -> ", detalleRegistado);
                }
                return
            }
        }

    })


    $q("#tipopago").addEventListener("change", async (e) => {
        const tipo = e.target.value
        console.log(tipo);
        if (parseInt(tipo) == 2) {
            $q("#contenedor-btn-agregar-cuota").hidden = false
            $q(".contenedor-cuotas").innerHTML = ''
        } else if (parseInt(tipo) == 1) {
            $q("#contenedor-btn-agregar-cuota").hidden = true
            $q(".contenedor-cuotas").innerHTML = ''
        }
        document.querySelectorAll(".cuota-dinamica").forEach(tr => tr.remove());
        cuotas = [];
        contadorCuotas = 1;
    })

    $q("#btnAgregarCuota").addEventListener("click", () => {
        nuevaCuota = document.createElement("tr");
        nuevaCuota.classList.add("cuota-dinamica");

        nuevaCuota.innerHTML = `
            <td colspan="2" class="no-border"></td>
            <td class="no-border">
                <input type="text" class="form-control input-monto" placeholder="0.00 (Cuota ${contadorCuotas})">
            </td>
            <td class="no-border">
                <div class="d-flex gap-2 align-items-center">
                    <input type="date" class="form-control form-control-sm input-fecha" style="min-width: 120px;">
                    <button class="btn btn-danger btn-sm btnQuitarCuota">X</button>
                </div>
            </td>
        `;


        // Inserta la nueva cuota justo antes del botón
        const botonAgregar = $q("#contenedor-btn-agregar-cuota");
        botonAgregar.parentNode.insertBefore(nuevaCuota, botonAgregar);

        contadorCuotas++;
        // Guardamos una referencia a los inputs para leerlos luego
        const inputMonto = nuevaCuota.querySelector(".input-monto");
        const inputFecha = nuevaCuota.querySelector(".input-fecha");

        cuotas.push({ inputMonto, inputFecha }); // guardamos los elementos DOM
    });
    // *****************************************************************************************************************************
})