document.addEventListener("DOMContentLoaded", async () => {

  let idusuario = window.localStorage.getItem("idusuario") ? window.localStorage.getItem("idusuario") : -1
  let idpersona = -1
  let urlMarca = `https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/`

  let imagen_public_id = "";
  let imagen_public_id_firma = "";
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


  async function obtenerUsuarioCompletoPorId(idusuario) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioCompletoPorId");
    params.append("idusuario", idusuario);
    const data = await getDatos(`${host}usuario.controller.php`, params);
    return data
  }

  async function obtenerPersonaCompletoPorId(idpersona) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerPersonaCompletoPorId");
    params.append("idpersona", idpersona);
    const data = await getDatos(`${host}usuario.controller.php`, params);
    return data
  }

  const usuario = await obtenerUsuarioCompletoPorId(idusuario)
  console.log("usuario -> ", usuario);
  if (usuario[0]?.idnivelacceso == 6) {
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
  }

  imagenUrlMarcaAgua = usuario[0]?.marcaagua
  imagenUrlFirma = usuario[0]?.firma
  renderizarDatosUsuario(usuario[0])

  const persona = await obtenerPersonaCompletoPorId(usuario[0]?.idpersona)
  console.log("persona->", persona);
  idpersona = persona[0]?.idpersona
  renderizarDatosPersona(persona[0])

  // ***************************************************** CLOUDINARY *****************************************************************************
  let myWidget = cloudinary.createUploadWidget(
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
  );

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
    $q("#previewImagen").src = `https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/${usuario?.marcaagua}`
    $q("#previewImagenFirma").src = `https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/${usuario?.firma}`
  }

  async function actualizarUsuario(idsucursal, idusuario, marcaagua, firma) {
    const body = new FormData();
    body.append("operation", "actualizarUsuario");
    body.append("idsucursal", idsucursal);
    body.append("idusuario", idusuario);
    body.append("nomusuario", $q("#nom_usuario").value ? $q("#nom_usuario").value : '');
    body.append("claveacceso", $q("#claveacceso").value ? $q("#claveacceso").value : '');
    body.append("color", $q("#color").value ? $q("#color").value : '');
    body.append("porcentaje", $q("#porcentaje").value ? $q("#porcentaje").value : '');
    body.append("marcaagua", marcaagua ? marcaagua : imagenUrlMarcaAgua);
    body.append("firma", firma ? firma : imagenUrlFirma);
    // body.append("esRepresentante", $q("#esrepresentante").checked ? 1 : 0);

    const fbody = await fetch(`${host}usuario.controller.php`, {
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

  $q("#btnActualizarPersona").addEventListener("click", async () => {
    try {
      console.log("idpersona -> ", idpersona);
      const persona = await actualizarPersona(idpersona)
      console.log("eprsona actualizad? ", persona);
      if (persona) {
        showToast("Datos de la persona actualizadas.", "SUCCESS")
        return
      }
    } catch (error) {
      showToast("Un error ha ocurrido", "ERROR")
      return
    }
  })

  $q("#btnActualizarUsuario").addEventListener("click", async () => {
    try {
      //const nuevaUrlMarca = urlMarca + imagen_public_id
      //console.log("nueva url marca -> ", nuevaUrlMarca);
      const usuario = await actualizarUsuario($q("#sucursal").value, idusuario, imagen_public_id, imagen_public_id_firma)
      console.log("usuario actualizad? ", usuario);
      if (usuario) {
        showToast("Datos del usuario actualizadas.", "SUCCESS")
        return
      }
    } catch (error) {
      showToast("Un error ha ocurrido", "ERROR")
      return
    }
  })

  $q("#btnRegresarActualizarUsuario").addEventListener("click", () => {
    window.location.href = `${hostOnly}/views/utilitario/usuarios/listar-usuarios`
  })

})