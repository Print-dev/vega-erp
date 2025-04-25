document.addEventListener("DOMContentLoaded", async () => {
    let contadorCuotas = 1;
    let cuotas = []
    let nuevaCuota
    let igvObtenido
    let iddp


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

    let razonsocialClienteObtenido
    let ndocumentoClienteObtenido
    //SELECTS 
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
    let calcularDificultadPrecio = []

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
        params.append("operation", "obtenerDetallesPresentacionPorModalidad");
        params.append("modalidad", 2);

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

    /*  async function emitirFactura(direccion_emisor, departamento, provincia, distrito, ubigeo, ndocumento, razon_social_cliente, serie, correlativo, monto_gravado, igv, total, detalle, monto_letras, tipo_pago, cuotas, tieneigv) {
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
         comprobante.append("tieneigv", tieneigv);
         //comprobante.append("totalMontoCuotas", totalMontoCuotas);
 
         const fcomprobante = await fetch(`${host}comprobante.controller.php`, {
             method: "POST",
             body: comprobante,
         });
         const rcomprobante = await fcomprobante.json();
         //console.log("rivatico . ", rcomprobante)
         return rcomprobante;
     } */



    async function registrarComprobante(iddetallepresentacion, idsucursal, idcliente, idtipodoc, tipopago, nserie, correlativo, tipomoneda, monto, tieneigv, noperacion) {
        const comprobante = new FormData();
        comprobante.append("operation", "registrarComprobante");
        comprobante.append("iddetallepresentacion", iddetallepresentacion);
        comprobante.append("idsucursal", idsucursal);
        comprobante.append("idcliente", idcliente);
        comprobante.append("idtipodoc", idtipodoc);
        comprobante.append("tipopago", tipopago);
        comprobante.append("nserie", nserie);
        comprobante.append("correlativo", correlativo);
        comprobante.append("tipomoneda", tipomoneda);
        comprobante.append("monto", monto);
        comprobante.append("tieneigv", tieneigv);
        comprobante.append("noperacion", noperacion ? noperacion : '');

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

    // *************************************** EVENTOS ******************************************

    eventosSelect.addEventListener("change", async (e) => {
        $q("#tablaProductos tbody").innerHTML = `
        <div class="col-md-12">
            <div class="row text-center">
                <label class="form-label text-center">Cargando...</label>              
            </div>
        </div>
        
            `

        eventosSelect.disabled = true
        iddp = e.target.value
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

        console.log("totalGravado -> antes de pintar lo de pintar -> ", totalGravado);

        // Calcular el total con IGV
        if (dp[0]?.igv == 1) {
            /* igvTotal = totalGravado * 0.18; // ESTO SOLO SERA EL TOTAL DE AMBOS IGV PERO ESTA MAS RESUMIDO
totalConIgv = totalGravado + igvTotal; */
            /* totalConIgv = totalGravado
            igvTotal = 0; */

            showToast("Los contratos con IGV deben emitirse mediante una factura", "INFO")
            limpiarContenidoDetalleProducto()
            // Calcular el IGV (18%)
        } else if (dp[0]?.igv == 0) {
            totalConIgv = totalGravado
            igvTotal = 0;
            /*             alert("NO TIENE IGV")
                        console.log("NO TIENE UIGV!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                        showToast("Los contratos sin IGV deben emitirse mediante una nota de venta", "INFO")
                        limpiarContenidoDetalleProducto() */
        }

        console.log("totalConIgv antes de pintar -> ", totalConIgv);
        //$q("#txtOperacionGravada").innerHTML = `S/ ${totalGravado.toFixed(2)}`
        //$q("#txtIGV").innerHTML = `S/ ${igvTotal == 0 ? 'No incluye' : igvTotal.toFixed(2)}`
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

        igvObtenido = dp[0]?.igv
        const incluyeIGV = igvObtenido == 1; // o según el campo real que uses


        // Presentación artística
        detalle.push({
            descripcion: `Presentación artística de ${dp[0]?.nom_usuario}`,
            valorunitario: valorUnitarioTarifa,
            igvproducto: igvTarifa,
            preciounitario: incluyeIGV
                ? parseFloat((valorUnitarioTarifa + igvTarifa).toFixed(2))
                : valorUnitarioTarifa
        });

        // -> precio por viaje
        const valorUnitarioViaje = parseFloat(costoDificultad);
        const igvViaje = parseFloat((valorUnitarioViaje * 0.18).toFixed(2));

        /*         const detalleViaje = {
                    descripcion: `Puesto en la locación de ${provinciaDestino}`,
                    valorunitario: valorUnitarioViaje,
                    igvproducto: igvViaje
                };
        
                if (incluyeIGV) {
                    detalleViaje.preciounitario = parseFloat((valorUnitarioViaje + igvViaje).toFixed(2));
                }
        
                detalle.push(detalleViaje); */
        detalle.push({
            descripcion: `Puesto en la locación de ${dp[0]?.provincia}`,
            valorunitario: valorUnitarioViaje,
            igvproducto: igvViaje,
            preciounitario: incluyeIGV
                ? parseFloat((valorUnitarioViaje + igvViaje).toFixed(2))
                : valorUnitarioViaje
        });
    })

    function limpiarContenidoDetalleProducto() {
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
    }

    $q("#btnDeseleccionarEvento").addEventListener("click", async () => {
        limpiarContenidoDetalleProducto()
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
        if (
            $q("#sucursal").value == "" ||
            $q("#cliente").value == "" ||
            $q("#tipooperacion").value == "" ||
            $q("#tipomoneda").value == "" ||
            $q("#ubigeo").value == "" ||
            $q("#evento").value == ""
        ) {
            showToast("Por favor, completa todos los campos obligatorios.", "ERROR")
            return
        }
        let cuotasFormateadas = []
        //totalMontoCuotasCalculado = 0



        const serie = await obtenerSeriePorTipoDoc('02') // cambiarlo luego a boleta en el otro archivo papra boletas
        console.log("serie -> ", serie);
        if (serie.length == 0) {
            /* showToast("No hay series disponibles para el tipo de documento seleccionado.", "ERROR")
            return */
            const nuevoNNotaVenta = generarCorrelativoNotaVenta() // esto servira para generar el nuevo correlativo de la nota de venta
            console.log("Nuevo número de cotización ->", nuevoNNotaVenta);

            const nuevoComprobante = await registrarComprobante(iddp, idsucursalObtenido, idclienteObtenido, '02', $q("#tipopago").value, '2025', '00000001', $q("#tipomoneda").value, totalConIgv, igvObtenido, $q("#noperacion").value)
            console.log("nuevo comprobante -> ", nuevoComprobante);
            console.log("detalle > ", detalle);
            if (nuevoComprobante?.idcomprobante) {
                detalle.forEach(async item => {
                    const itemRegistrado = await registrarItemComprobante(nuevoComprobante?.idcomprobante, item?.descripcion, item?.valorunitario, item?.preciounitario)
                    console.log("item registrado -> ", itemRegistrado);

                });

            }
            return
        } else {
            console.log("ultima posicion de serie .> ", serie.at(-1));
            const nuevoCorrelativo = generarCorrelativoNotaVenta(serie.at(-1).correlativo, serie.at(-1).nserie)
            console.log("nuevo correlativo -> ", nuevoCorrelativo);
            console.log("ya tiene mas e 1 serie");
            console.log("noperacion ->", $q("#noperacion").value);
            const nuevoComprobante = await registrarComprobante(iddp, idsucursalObtenido, idclienteObtenido, '02', $q("#tipopago").value, nuevoCorrelativo.nserie, nuevoCorrelativo.nuevoCorrelativo, $q("#tipomoneda").value, totalConIgv, igvObtenido, $q("#noperacion").value)
            console.log("nuevo comprobante -> ", nuevoComprobante);
            console.log("detalle > ", detalle);
            if (nuevoComprobante?.idcomprobante) {
                detalle.forEach(async item => {
                    const itemRegistrado = await registrarItemComprobante(nuevoComprobante?.idcomprobante, item?.descripcion, item?.valorunitario, item?.preciounitario)
                    console.log("item registrado -> ", itemRegistrado);

                });

            }
        }
        /*         if (serie.length == 0) {
                    //generarCorrelativo('01', '00000000')
                    console.log("detalles array-> ", detalle);
                    console.log("tiene igv -> ", igvObtenido);
        
        
                        showToast(`¡${rptFactura?.estado}!, ${rptFactura?.descripcion}`, "SUCCESS", 6000, `${hostOnly}/views/comprobantes/facturas/listar-facturas`)
                        const nuevoComprobante = await registrarComprobante(iddp,idsucursalObtenido, idclienteObtenido, '01', $q("#tipopago").value, 'F001', '00000001', $q("#tipomoneda").value, totalConIgv, igvObtenido)
                        console.log("nuevo comprobante -> ", nuevoComprobante);
                        console.log("detalle > ", detalle);
                        if (nuevoComprobante?.idcomprobante) {
                            detalle.forEach(async item => {
                                const itemRegistrado = await registrarItemComprobante(nuevoComprobante?.idcomprobante, item?.descripcion, item?.valorunitario, item?.preciounitario)
                                console.log("item registrado -> ", itemRegistrado);
        
                            });
                            
                        }
                        return
                    
                }
                else {
                    const nuevoCorrelativo = generarCorrelativo(serie.at(-1).nserie, serie.at(-1).correlativo)
                    console.log("nuevo correlativo -> ", nuevoCorrelativo);
                    console.log("Tipo de pago:", $q("#tipopago").value);
                    console.log("Cuotas formateadas:", cuotasFormateadas);
                    console.log("detalles array-> ", detalle);
                    console.log("igvTotal -> ", igvTotal);
                    console.log("tiene igv -> ", igvObtenido);
                    
                        //showToast(`¡${rptFactura?.estado}!, ${rptFactura?.descripcion}`, "SUCCESS", 6000, `${hostOnly}/views/comprobantes/facturas/listar-facturas`)
                        const nuevoComprobante = await registrarComprobante(idsucursalObtenido, idclienteObtenido, '01', $q("#tipopago").value, nuevoCorrelativo.serie, nuevoCorrelativo.nuevoCorrelativo, $q("#tipomoneda").value, totalConIgv, igvObtenido)
                        console.log("nuevo comprobante -> ", nuevoComprobante);
                        console.log("detalle > ", detalle);
                        if (nuevoComprobante?.idcomprobante) {
                            detalle.forEach(async item => {
                                const itemRegistrado = await registrarItemComprobante(nuevoComprobante?.idcomprobante, item?.descripcion, item?.valorunitario, item?.preciounitario)
                                console.log("item registrado -> ", itemRegistrado);
        
                            });
                            const detalleRegistado = await registrarDetalleComprobante(nuevoComprobante?.idcomprobante, rptFactura?.estado, rptFactura?.descripcion)
                            console.log("detalle registdaod -> ", detalleRegistado);
        
                            if ($q("#tipopago").value == 2) {
                                cuotasFormateadas.forEach(async cuota => {
                                    const cuotaRegistrada = await registrarCuotaFactura(nuevoComprobante?.idcomprobante, cuota.fecha, cuota.monto)
                                    console.log("cuota registrada -> ", cuotaRegistrada);
                                })
                            }
                        }
                        return
                    
                } */

    })

    $q("#tipopago").addEventListener("change", async (e) => {
        const tipo = e.target.value
        console.log(tipo);
        if (parseInt(tipo) == 3) {
            $q("#contenedor-btn-agregar-cuota").hidden = false
            $q("#noperacion").value = ''
        } else if (parseInt(tipo) == 1) {
            $q("#contenedor-btn-agregar-cuota").hidden = true
            $q("#noperacion").value = ''
            console.log("cambiando .zzzz");
        }
        document.querySelectorAll(".cuota-dinamica").forEach(tr => tr.remove());
        cuotas = [];
        contadorCuotas = 1;
    })
})

