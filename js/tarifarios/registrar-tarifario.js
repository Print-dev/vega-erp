document.addEventListener("DOMContentLoaded", async () => {
    let idartista = -1

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

    async function obtenerTarifasPorProvincia() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTarifasPorProvincia");
        params.append("iddepartamento", $q("#departamento").value);
        params.append("idusuario", $q("#artista").value);
        const data = await getDatos(`${host}tarifa.controller.php`, params);
        return data
    }

    async function registrarTarifa(idartista, idprovincia, precio) {
        const tarifa = new FormData();
        tarifa.append("operation", "registrarTarifa");
        tarifa.append("idusuario", idartista);
        tarifa.append("idprovincia", idprovincia);
        tarifa.append("precio", precio);

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


    // ********************************* EVENTOS Y CARGA DE DATOS *********************************

    $q("#artista").addEventListener("change", async ()=> {
        if($q("#artista").value == -1 || $q("#artista").value == "-1"){idartista = $q("#artista").value}
        idartista = $q("#artista").value
        
        console.log("idartista selccionado", idartista)
        $q("#departamento").value = ''
        $q("#nacionalidad").value = ''
        $q("#tb-body-tarifario").innerHTML = ''
    })

    $q("#nacionalidad").addEventListener("change", async () => {
        const departamentos = await obtenerDepartamentos();
        $q("#departamento").innerHTML = "<option value=''>Selecciona</option>";
        departamentos.forEach(dpa => {
            $q("#departamento").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
        });
    });

    $q("#departamento").addEventListener("change", async () => {
        const provincias = await obtenerProvincias();
        const tarifas = await obtenerTarifasPorProvincia();
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
                    <button type="button" data-idprovincia="${pro.idprovincia}" data-idtarifario="${tarifaExistente?.idtarifario}" class="btn btn-primary btnGuardarPrecio"><i class="fa-solid fa-floppy-disk"></i></button>
                </td>
            </tr>
        `;
        });

        const btnsGuardarPrecio = $all(".btnGuardarPrecio")
          btnsGuardarPrecio.forEach(btn => {
            btn.addEventListener("click", async () => {
              if(idartista != -1){
                const idprovincia = btn.getAttribute("data-idprovincia")
                const idtarifario = btn.getAttribute("data-idtarifario")
                console.log("idtarifario -> ", idtarifario)
              
                const fila = btn.closest("tr");
                const precio = fila.querySelector(`#precio`).value;
                console.log("precio -> ", precio)
                //console.log("precio: ", precio)
                let resultado;

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
                    resultado = await registrarTarifa(idartista, idprovincia, precio);
                    console.log("Tarifa registrada:", resultado);
                    showToast("Tarifa registrada", "SUCCESS");

                    if (resultado.idtarifa) {  
                        btn.setAttribute("data-idtarifario", resultado.idtarifa);
                        const idtarifario = btn.getAttribute("data-idtarifario")
                        console.log("idtarifario -> ", idtarifario)
                    }
                }
              }
              else{
                showToast("Seleccione un artista", 'ERROR')
              }

            })
          })

    });


});