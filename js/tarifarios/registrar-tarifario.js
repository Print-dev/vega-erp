document.addEventListener("DOMContentLoaded", async () => {
    let idartista = -1
    let idnacionalidad
    let resultado

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

    await obtenerArtistas()
    await obtenerTodosNacionalidades();


    /* ************************************* OBTENER RECURSOS ******************************************************* */

    async function obtenerArtistas() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", 6);
        const data = await getDatos(`${host}usuario.controller.php`, params)
        console.log(data);
        $q("#artista").innerHTML = "<option value='-1'>Selecciona</option>";
        data.forEach(artista => {
            $q("#artista").innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
        });
    }

    async function obtenerTodosNacionalidades() { // EN REALIDAD ES OBTENER TODOS LOS PAISES
        const params = new URLSearchParams();
        params.append("operation", "obtenerTodosNacionalidades");
        const data = await getDatos(`${host}recurso.controller.php`, params);
        $q("#nacionalidad").innerHTML = "<option value=''>Selecciona</option>";
        data.forEach(paises => {
            $q("#nacionalidad").innerHTML += `<option value="${paises.idnacionalidad}">${paises.pais}</option>`;
        });
        return data;
    }

    async function obtenerNacionalidadPorId(idnacionalidad) { // EN REALIDAD ES OBTENER TODOS LOS PAISES
        const params = new URLSearchParams();
        params.append("operation", "obtenerNacionalidadPorId");
        params.append("idnacionalidad", idnacionalidad);
        const data = await getDatos(`${host}recurso.controller.php`, params);

        return data;
    }


    async function obtenerDepartamentos() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDepartamentos");
        params.append("idnacionalidad", $q("#nacionalidad").value);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    async function obtenerProvincias() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerProvincias");
        params.append("iddepartamento", $q("#departamento").value);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    async function obtenerTarifasPorProvinciaYTipo() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTarifasPorProvinciaYTipo");
        params.append("iddepartamento", $q("#departamento").value);
        params.append("idusuario", $q("#artista").value);
        params.append("tipoevento", $q("#tipo").value);
        const data = await getDatos(`${host}tarifa.controller.php`, params);
        return data
    }

    async function obtenerTarifaArtistaPorPais() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTarifaArtistaPorPais");
        params.append("idusuario", $q("#artista").value);
        params.append("idnacionalidad", $q("#nacionalidad").value);
        params.append("tipoevento", $q("#tipo").value);
        const data = await getDatos(`${host}tarifa.controller.php`, params);
        return data
    }

    async function registrarTarifa(idartista, idprovincia, precio, tipo_evento, idnacionalidad, precioextranjero) {
        const tarifa = new FormData();
        tarifa.append("operation", "registrarTarifa");
        tarifa.append("idusuario", idartista);
        tarifa.append("idprovincia", idprovincia || '');
        tarifa.append("precio", precio);
        tarifa.append("tipoevento", tipo_evento);
        tarifa.append("idnacionalidad", idnacionalidad || '');
        tarifa.append("precioextranjero", precioextranjero || '');

        const ftarifa = await fetch(`${host}tarifa.controller.php`, {
            method: "POST",
            body: tarifa,
        });
        const rtarifa = await ftarifa.json();
        return rtarifa;
    }

    async function actualizarTarifa(idtarifario, precio) {
        const tarifa = new FormData();
        tarifa.append("operation", "actualizarTarifa");
        tarifa.append("idtarifario", idtarifario);
        tarifa.append("precio", precio);

        const ftarifa = await fetch(`${host}tarifa.controller.php`, {
            method: "POST",
            body: tarifa,
        });
        const rtarifa = await ftarifa.json();
        return rtarifa;
    }

    async function actualizarTarifaPrecioExtranjero(idtarifario, precioextranjero) {
        const tarifa = new FormData();
        tarifa.append("operation", "actualizarTarifaPrecioExtranjero");
        tarifa.append("idtarifario", idtarifario);
        tarifa.append("precioextranjero", precioextranjero);

        const ftarifa = await fetch(`${host}tarifa.controller.php`, {
            method: "POST",
            body: tarifa,
        });
        const rtarifa = await ftarifa.json();
        return rtarifa;
    }


    // ********************************* EVENTOS Y CARGA DE DATOS *********************************

    $q("#artista").addEventListener("change", async () => {
        if ($q("#artista").value == -1 || $q("#artista").value == "-1") { idartista = $q("#artista").value }
        idartista = $q("#artista").value

        console.log("idartista selccionado", idartista)
        $q("#departamento").value = ''
        $q("#nacionalidad").value = ''
        $q("#tb-body-tarifario").innerHTML = ''
    })

    $q("#nacionalidad").addEventListener("change", async (e) => {
        $q("#tb-body-tarifario-pais").innerHTML = ''
        idnacionalidad = e.target.value
        const departamentos = await obtenerDepartamentos();
        $q("#departamento").innerHTML = "<option value=''>Selecciona</option>";
        departamentos.forEach(dpa => {
            $q("#departamento").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
        });


    });

    /* $q("#departamento").addEventListener("change", async () => {
        
    }); */

    $q("#tipo").addEventListener("change", async () => {
        const provincias = await obtenerProvincias();
        const tarifas = await obtenerTarifasPorProvinciaYTipo();
        console.log("tarifas-> ", tarifas)

        $q("#tb-body-tarifario").innerHTML = ''

        provincias.forEach(pro => {
            const tarifaExistente = tarifas.find(t => t.idprovincia === pro.idprovincia);
            //console.log("tarifario existente : ", tarifaExistente)
            const precio = tarifaExistente ? tarifaExistente.precio : ""; // Si hay tarifa, usar el precio, si no, dejar vacío
            $q("#tb-body-tarifario").innerHTML += `
            <tr>
                <td>${pro.provincia}</td>
                <td>
                    <input type="number" id="precio" class="form-control input-precio" value="${precio ? precio : '0.00'}">
                </td>
                
                <td>
                    <button type="button" data-idprovincia="${pro.idprovincia}" data-idtarifario="${tarifaExistente?.idtarifario}" class="btn btn-primary btnGuardarPrecioProvincia"><i class="fa-solid fa-floppy-disk"></i></button>
                </td>
            </tr>
        `;
        });

        const btnsGuardarPrecio = $all(".btnGuardarPrecioProvincia")
        btnsGuardarPrecio.forEach(btn => {
            btn.addEventListener("click", async () => {
                if (idartista != -1) {
                    const idprovincia = btn.getAttribute("data-idprovincia")
                    const idtarifario = btn.getAttribute("data-idtarifario")
                    console.log("idtarifario -> ", idtarifario)

                    const fila = btn.closest("tr");
                    const precio = fila.querySelector(`#precio`).value;
                    console.log("precio -> ", precio)
                    //console.log("precio: ", precio)
                    resultado = -1;

                    if (idtarifario && idtarifario !== "undefined" && idtarifario.trim() !== "") {
                        console.log(idtarifario)
                        console.log("idartista ->", idartista)
                        // Si existe un idtarifario válido, actualizarlo
                        resultado = await actualizarTarifa(idtarifario, precio);
                        console.log("Tarifa actualizada:", resultado);
                        showToast("Tarifa actualizada", "SUCCESS");
                    } else {
                        console.log(idtarifario)
                        console.log("idartista ->", idartista)
                        // Si no hay idtarifario, registrar una nueva tarifa
                        resultado = await registrarTarifa(idartista, idprovincia, precio, $q("#tipo").value);
                        console.log("Tarifa registrada:", resultado);
                        showToast("Tarifa registrada", "SUCCESS");

                        if (resultado.idtarifa) {
                            btn.setAttribute("data-idtarifario", resultado.idtarifa);
                            const idtarifario = btn.getAttribute("data-idtarifario")
                            console.log("idtarifario -> ", idtarifario)
                        }
                    }
                }
                else {
                    showToast("Seleccione un artista", 'ERROR')
                }

            })
        })

        if (idnacionalidad !== "31") {
            const nacionalidad = await obtenerNacionalidadPorId(idnacionalidad);
            const tarifas = await obtenerTarifaArtistaPorPais();
            // AGREGAR UNA FUNCION PARA OBTNER TARIFAS POR pAIS 
            console.log("tarifas pais -> ", tarifas);
            $q("#contenedor-tarifario-pais").classList.remove("d-none");
            $q("#contenedor-tarifario-pais").classList.add("block");
            $q("#contenedor-tarifario").classList.add("d-none")

            if (tarifas.length == 0) {

            }
            nacionalidad.forEach(nacionalidad => {
                const tarifaExistente = tarifas.find(n => n.idnacionalidad === nacionalidad.idnacionalidad);
                if (nacionalidad.idnacionalidad == parseInt(idnacionalidad)) {
                    const precio = tarifaExistente ? tarifaExistente.precio : ""; // Si hay tarifa, usar el precio, si no, dejar vacío
                    const precioextranjero = tarifaExistente ? tarifaExistente.precioExtranjero : ""; // Si hay tarifa, usar el precio, si no, dejar vacío

                    $q("#tb-body-tarifario-pais").innerHTML = `
                    <tr>
                        <td>${nacionalidad?.pais}</td>

                        <td>
                            <div class="d-flex align-items-center">
                                <input type="number" id="precio" class="form-control input-precio me-2" value="${precio ? precio : '0.00'}">
                                <button type="button" data-idnacionalidad="${tarifas.idnacionalidad}" data-idtarifario="${tarifaExistente?.idtarifario}" class="btn btn-primary btnGuardarPrecio">
                                    <i class="fa-solid fa-floppy-disk"></i>
                                </button>
                            </div>
                        </td>                                            

                        <td>
                            <div class="d-flex align-items-center">
                                <input type="number" id="precioextranjero" class="form-control input-precioextranjero me-2" value="${precioextranjero ? precioextranjero : '0.00'}"  ${tarifas.length == 0 ? "disabled" : ""}>
                                <button type="button" data-idnacionalidad="${tarifas.idnacionalidad}" data-idtarifario="${tarifaExistente?.idtarifario}" class="btn btn-primary btnGuardarPrecioExtranjero"  ${tarifas.length == 0 ? "disabled" : ""}>
                                    <i class="fa-solid fa-floppy-disk"></i>
                                </button>
                            </div>
                        </td>
                    </tr>

                `;
                }
            });

            const btnsGuardarPrecio = $all(".btnGuardarPrecio")
            const btnsGuardarPrecioExtranjero = $all(".btnGuardarPrecioExtranjero")
            btnsGuardarPrecio.forEach(btn => {
                btn.addEventListener("click", async () => {
                    if (idartista != -1) {
                        const idprovincia = btn.getAttribute("data-idprovincia")
                        const idtarifario = btn.getAttribute("data-idtarifario")
                        console.log("idtarifario -> ", idtarifario)

                        const fila = btn.closest("tr");
                        const precio = fila.querySelector(`#precio`).value;
                        console.log("precio -> ", precio)
                        resultado = -1
                        //console.log("precio: ", precio)

                        if (idtarifario && idtarifario !== "undefined" && idtarifario.trim() !== "") {
                            console.log(idtarifario)
                            console.log("idartista ->", idartista)
                            // Si existe un idtarifario válido, actualizarlo
                            resultado = await actualizarTarifa(idtarifario, precio);
                            console.log("Tarifa actualizada:", resultado);
                            showToast("Tarifa actualizada", "SUCCESS");
                        } else {
                            console.log(idtarifario)
                            console.log("idartista ->", idartista)
                            // Si no hay idtarifario, registrar una nueva tarifa
                            resultado = await registrarTarifa(idartista, idprovincia, precio, $q("#tipo").value, idnacionalidad);
                            console.log("resultado ->", resultado);

                            const inputExtranjero = fila.querySelector(".input-precioextranjero");
                            const btnExtranjero = fila.querySelector(".btnGuardarPrecioExtranjero");

                            inputExtranjero?.removeAttribute("disabled");
                            btnExtranjero?.removeAttribute("disabled");
                            console.log("Tarifa registrada:", resultado);
                            showToast("Tarifa registrada", "SUCCESS");

                            if (resultado.idtarifa) {
                                btn.setAttribute("data-idtarifario", resultado.idtarifa);
                                const idtarifario = btn.getAttribute("data-idtarifario")
                                console.log("idtarifario -> ", idtarifario)
                            }
                        }
                    }
                    else {
                        showToast("Seleccione un artista", 'ERROR')
                    }

                })
            })
            btnsGuardarPrecioExtranjero.forEach(btn => {
                btn.addEventListener("click", async () => {
                    if (idartista != -1) {
                        const idprovincia = btn.getAttribute("data-idprovincia")
                        const idtarifario = btn.getAttribute("data-idtarifario")
                        console.log("idtarifario -> ", resultado.idtarifa)

                        const fila = btn.closest("tr");
                        const precio = fila.querySelector(`#precioextranjero`).value;
                        console.log("precio -> ", precio)
                        //console.log("precio: ", precio)


                        if (idtarifario && idtarifario !== "undefined" && idtarifario.trim() !== "") {
                            console.log(idtarifario)
                            console.log("idartista ->", idartista)
                            // Si existe un idtarifario válido, actualizarlo
                            resultado = await actualizarTarifaPrecioExtranjero(idtarifario, precio);
                            console.log("Tarifa actualizada:", resultado);
                            showToast("Precio actualizado", "SUCCESS");
                        } else {
                            console.log(idtarifario)
                            console.log("idartista ->", idartista)
                            // Si existe un idtarifario válido, actualizarlo
                            resultado = await actualizarTarifaPrecioExtranjero(resultado.idtarifa, precio);
                            console.log("Tarifa actualizada:", resultado);
                            showToast("Precio actualizado", "SUCCESS");
                            /* console.log(idtarifario)
                            console.log("idartista ->", idartista)
                            // Si no hay idtarifario, registrar una nueva tarifa
                            resultado = await registrarTarifa(idartista, idprovincia, precio, $q("#tipo").value, idnacionalidad, );
                            console.log("Tarifa registrada:", resultado);
                            showToast("Precio registrado", "SUCCESS");

                            if (resultado.idtarifa) {
                                btn.setAttribute("data-idtarifario", resultado.idtarifa);
                                const idtarifario = btn.getAttribute("data-idtarifario")
                                console.log("idtarifario -> ", idtarifario)
                            } */
                        }
                    }
                    else {
                        showToast("Seleccione un artista", 'ERROR')
                    }

                })
            })
        } else if (idnacionalidad == "31") {
            $q("#contenedor-tarifario-pais").classList.add("d-none");
            $q("#contenedor-tarifario").classList.remove("d-none");
            $q("#contenedor-tarifario").classList.add("block")
        }
    })

});