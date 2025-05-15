document.addEventListener("DOMContentLoaded", async () => {

    let idcolaborador = window.localStorage.getItem("idcolaborador") ? window.localStorage.getItem("idcolaborador") : -1
    let idpersona = -1
    //let urlMarca = `https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/`

    /*    let imagen_public_id = "";
       let imagen_public_id_firma = ""; */
    let imagenUrlMarcaAgua = ""
    let imagenUrlFirma = ""

    if (nivelacceso !== "Administrador") {
        $q("#btnRegresarActualizarUsuario").remove()
    }

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

    await obtenerSucursales()
    await obtenerAreas()

    async function obtenerAreas() {
        const data = await getDatos(`${host}nomina.controller.php`, "operation=obtenerAreas");
        console.log(data);
        $q("#area").innerHTML = "<option value=''>Selecciona</option>";
        data.forEach(niveles => {
            $q("#area").innerHTML += `<option value="${niveles.idarea}">${niveles.area}</option>`;
        });

        return data
    }

    async function obtenerSucursales() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerSucursales");
        const data = await getDatos(`${host}sucursal.controller.php`, params);
        console.log("data de succursales -> ", data);
        $q("#sucursal").innerHTML = "<option value=''>Seleccione</option>"
        data.forEach((sucursal) => {
            $q("#sucursal").innerHTML += `<option value="${sucursal.idsucursal}">${sucursal.nombre}</option>`;
        });
        //return data;
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

    async function obtenerDistritos() {
        const params = new URLSearchParams();
        params.append("operation", "obtenerDistritos");
        params.append("idprovincia", $q("#provincia").value);
        const data = await getDatos(`${host}recurso.controller.php`, params);
        return data
    }

    $q("#nacionalidad").addEventListener("change", async () => {
        const departamentos = await obtenerDepartamentos();
        $q("#departamento").innerHTML = "<option value=''>Selecciona</option>";
        departamentos.forEach(dpa => {
            $q("#departamento").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
        });
    });

    $q("#departamento").addEventListener("change", async () => {
        const provincias = await obtenerProvincias();
        $q("#provincia").innerHTML = "<option value=''>Selecciona</option>";
        provincias.forEach(prv => {
            $q("#provincia").innerHTML += `<option value="${prv.idprovincia}">${prv.provincia}</option>`;
        });
    });

    $q("#provincia").addEventListener("change", async () => {
        const distritos = await obtenerDistritos();
        $q("#distrito").innerHTML = "<option value=''>Selecciona</option>";
        distritos.forEach(dst => {
            $q("#distrito").innerHTML += `<option value="${dst.iddistrito}">${dst.distrito}</option>`;
        });
    });


    async function obtenerColaboradorPorId(idcolaborador) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerColaboradorPorId");
        params.append("idcolaborador", idcolaborador);
        const data = await getDatos(`${host}nomina.controller.php`, params);
        return data
    }

    async function obtenerPersonaCompletoPorId(idpersona) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerPersonaCompletoPorId");
        params.append("idpersona", idpersona);
        const data = await getDatos(`${host}usuario.controller.php`, params);
        return data
    }

    async function obtenerAreas() {
        const data = await getDatos(`${host}nomina.controller.php`, "operation=obtenerAreas");
        console.log(data);
        $q("#area").innerHTML = "<option value=''>Selecciona</option>";
        data.forEach(niveles => {
            $q("#area").innerHTML += `<option value="${niveles.idarea}">${niveles.area}</option>`;
        });
        return data
    }

    await obtenerAreas()

    const colaborador = await obtenerColaboradorPorId(idcolaborador)
    console.log("colaborador -> ", colaborador);
    $q("#fechaingreso").value = colaborador[0]?.fechaingreso
    $q("#area").value = colaborador[0]?.idarea
    $q("#sucursal").value = colaborador[0]?.idsucursal
    /* if (usuario[0]?.idnivelacceso == 6) {
        $q(".contenedor-color").hidden = false
        $q(".contenedor-porcentaje").hidden = false
        $q(".contenedor-marcaagua").hidden = false
        //$q(".contenedor-representante").hidden = true
    }
    else if (usuario[0]?.idnivelacceso == 3) {
        //$q(".contenedor-representante").hidden = false
        $q(".contenedor-color").hidden = true
        $q(".contenedor-porcentaje").hidden = true
        $q(".contenedor-marcaagua").hidden = true
    }
    else {
        // $q(".contenedor-representante").hidden = true
        $q(".contenedor-color").hidden = true
        $q(".contenedor-porcentaje").hidden = true
        // $q(".contenedor-representante").hidden = true
        $q(".contenedor-marcaagua").hidden = true
    } */

    /*     imagenUrlMarcaAgua = usuario[0]?.marcaagua
        imagenUrlFirma = usuario[0]?.firma
        renderizarDatosUsuario(usuario[0]) */

    const persona = await obtenerPersonaCompletoPorId(colaborador[0]?.idpersona)
    console.log("persona->", persona);
    idpersona = persona[0]?.idpersona
    renderizarDatosPersona(persona[0])

    // ***************************************************** CLOUDINARY *****************************************************************************
    /* let myWidget = cloudinary.createUploadWidget(
      {
        cloudName: "dynpy0r4v",
        uploadPreset: "vegaimagenes",
        folder: "vegaimagenes",
      },
      async (error, result) => {
        if (!error && result && result.event === "success") {
          console.log("result -> ", result);
  
          let previewImagen = document.getElementById("previewImagen");
          previewImagen.src = result.info.secure_url;
          //previewImagen.classList.remove("d-none");
          imagen_public_id = result.info?.public_id;
          //$q("#btnGuardarContenido").disabled = false;
        }
      }
    );
  
    let myWidgetFirma = cloudinary.createUploadWidget(
      {
        cloudName: "dynpy0r4v",
        uploadPreset: "vegaimagenes",
        folder: "vegaimagenes",
      },
      async (error, result) => {
        if (!error && result && result.event === "success") {
          console.log("result -> ", result);
  
          let previewImagen = document.getElementById("previewImagenFirma");
          previewImagen.src = result.info.secure_url;
          previewImagen.classList.remove("d-none");
          imagen_public_id_firma = result.info?.public_id;
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
  
    $q("#upload_widget_firma")?.addEventListener(
      "click",
      function () {
        myWidgetFirma.open();
      },
      false
    ); */

    function renderizarDatosPersona(persona) {
        $q("#num_doc").value = persona.num_doc
        $q("#apellidos").value = persona.apellidos
        $q("#nombres").value = persona.nombres
        $q("#genero").value = persona.genero
        $q("#direccion").value = persona.direccion
        $q("#telefono1").value = persona.telefono
        $q("#telefono2").value = persona.telefono2
        $q("#correo").value = persona.correo
        $q("#distrito").value = persona.distrito
    }

    function renderizarDatosUsuario(usuario) {
        $q("#nom_usuario").value = usuario.nom_usuario
        $q("#claveacceso").value = ""
        $q("#color").value = usuario.color
        // $q("#esrepresentante").checked = usuario.esRepresentante == 1 ? true : false
        $q("#porcentaje").value = usuario.porcentaje
        $q("#sucursal").value = usuario.idsucursal
        $q("#previewImagenMarcaAgua").src = `https://res.cloudinary.com/dynpy0r4v/image/upload/v1746321637/${usuario?.marcaagua}`
        $q("#previewImagenFirma").src = `https://res.cloudinary.com/dynpy0r4v/image/upload/v1746321640/${usuario?.firma}`
    }

    async function actualizarColaborador(idcolaborador) {
        const body = new FormData();
        body.append("operation", "actualizarColaborador");
        body.append("idcolaborador", idcolaborador);
        body.append("idsucursal", $q("#sucursal").value ? $q("#sucursal").value : '');
        body.append("fechaingreso", $q("#fechaingreso").value ? $q("#fechaingreso").value : '');
        body.append("idarea", $q("#area").value ? $q("#area").value : '');
        // body.append("esRepresentante", $q("#esrepresentante").checked ? 1 : 0);

        const fbody = await fetch(`${host}nomina.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function actualizarPersona(idpersona) {
        const body = new FormData();
        body.append("operation", "actualizarPersona");
        body.append("idpersona", idpersona);
        body.append("numdoc", $q("#num_doc").value ? $q("#num_doc").value : '');
        body.append("apellidos", $q("#apellidos").value ? $q("#apellidos").value : '');
        body.append("nombres", $q("#nombres").value ? $q("#nombres").value : '');
        body.append("genero", $q("#genero").value ? $q("#genero").value : '');
        body.append("direccion", $q("#direccion").value ? $q("#direccion").value : '');
        body.append("telefono", $q("#telefono1").value ? $q("#telefono1").value : '');
        body.append("telefono2", $q("#telefono2").value ? $q("#telefono2").value : '');
        body.append("correo", $q("#correo").value ? $q("#correo").value : '');
        body.append("iddistrito", $q("#distrito").value ? $q("#distrito").value : '');

        const fbody = await fetch(`${host}usuario.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function registrarArea() {
        //const perfilData = await getPerfil(parseInt(selector("perfil").value));
        const params = new FormData();
        params.append("operation", "registrarArea");
        params.append("area", $q("#areanueva").value.trim());

        const resp = await fetch(`${host}nomina.controller.php`, {
            method: 'POST',
            body: params
        });
        const data = await resp.json();
        return data;
    }

    $q("#btnActualizarPersona").addEventListener("click", async () => {
        try {
            const btn = $q("#btnActualizarPersona")
            console.log("idpersona -> ", idpersona);
            btn.disabled = true
            btn.textContent = "Actualizando..."
            const persona = await actualizarPersona(idpersona)
            console.log("eprsona actualizad? ", persona);
            if (persona) {
                showToast("Datos de la persona actualizadas.", "SUCCESS")
                btn.disabled = false;
                btn.textContent = "Actualizar Datos Persona";
                return
            }
        } catch (error) {
            showToast("Un error ha ocurrido", "ERROR")
            btn.disabled = false;
            btn.textContent = "Actualizar Datos Persona";
            return
        }
    })

    $q("#btnGuardarNuevaArea").addEventListener("click", async () => {
        const arearegistrada = await registrarArea()
        console.log("area registrada -> ", arearegistrada);
        if($q("#areanueva").value.trim() == "") {
            showToast("El campo area no puede estar vacio", "ERROR");
            return
        }

        if (arearegistrada) {
            showToast("Area registrada correctamente", "SUCCESS");
            $q("#area").value = '';
            await obtenerAreas()
        } else {
            showToast("Error al registrar el area", "ERROR");
        }
    })


    $q("#btnActualizarColaborador").addEventListener("click", async () => {
        let btn
        try {
            btn = $q("#btnActualizarColaborador")
            /* onst imagenInputMarcaAgua = $q("#upload_widget_marcaagua");
            const fileMarcaAgua = imagenInputMarcaAgua.files[0];
            const imagenInputFirma = $q("#upload_widget_firma");
            const fileFirma = imagenInputFirma.files[0]; */
            //const nuevaUrlMarca = urlMarca + imagen_public_id
            //console.log("nueva url marca -> ", nuevaUrlMarca);
            /* console.log("marca de agua antigguio:", imagenUrlMarcaAgua);
            console.log("firma antigguio:", imagenUrlFirma); */
            btn.disabled = true
            btn.textContent = "Actualizando..."
            console.log("idcolaborador -> ", idcolaborador);
            const colaborador = await actualizarColaborador(idcolaborador)
            console.log("colaborador actualizad? ", colaborador);
            if (colaborador) {
                showToast("Datos del colaborador actualizadas.", "SUCCESS")
                btn.disabled = false;
                btn.textContent = "Actualizar Datos colaborador";
                return
            }
        } catch (error) {
            console.log("error ->", error);
            showToast("Un error ha ocurrido", "ERROR")
            btn.disabled = false;
            btn.textContent = "Actualizar Datos colaborador";
            return
        }
    })

    $q("#btnRegresarActualizarUsuario").addEventListener("click", () => {
        window.location.href = `${hostOnly}/views/colaboradores/listar-colaboradores`
    })

    /*  $q("#upload_widget_marcaagua").addEventListener("change", function (e) {
         console.log("cambiando...");
         const file = e.target.files[0];
         console.log("file de imagen event -> ", file);
         const preview = $q("#previewImagenMarcaAgua");
 
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
 
 
     $q("#upload_widget_firma").addEventListener("change", function (e) {
         const file = e.target.files[0];
         console.log("file de imagen event -> ", file);
         const preview = $q("#previewImagenFirma");
 
         if (file && file.type.startsWith("image/")) {
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
     }); */

})