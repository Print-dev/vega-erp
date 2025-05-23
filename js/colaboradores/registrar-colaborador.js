document.addEventListener("DOMContentLoaded", async () => {

  // VARIABLES
  /* let imagen_public_id = "";
  let imagen_public_id_firma = "";
  const BASE_CLOUDINARY_URL = "https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/"; */
  let sucursal = $q("#sucursal")

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

  isReset = false
  bloquearCampos(true); // bloquear campos de llenar persona por defecto

  await cargarDatosPorDefecto()
  await obtenerSucursales()

  // ******************************* CLODUINARY ********************************************************************

  /*   let myWidget = cloudinary.createUploadWidget(
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
          previewImagen.classList.remove("d-none");
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
   */
  /* ************************************* OBTENER RECURSOS ******************************************************* */

  await obtenerSucursales()
  await obtenerArtistas()
  await obtenerOrganizadores()

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



  async function obtenerAreas() {
    const data = await getDatos(`${host}nomina.controller.php`, "operation=obtenerAreas");
    console.log(data);

    return data
  }

  async function obtenerArtistas() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorNivel");
    params.append("idnivelacceso", 6);
    const data = await getDatos(`${host}usuario.controller.php`, params)
    console.log(data);
    $q("#responsable").innerHTML = "<option value='-1'>Selecciona</option>";
    data.forEach(artista => {
      $q("#responsable").innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
    });
  }

  async function obtenerOrganizadores() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorNivel");
    params.append("idnivelacceso", 12);
    const data = await getDatos(`${host}usuario.controller.php`, params)
    console.log(data);
    data.forEach(artista => {
      $q("#responsable").innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
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

  async function obtenerDistritos() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDistritos");
    params.append("idprovincia", $q("#provincia").value);
    const data = await getDatos(`${host}recurso.controller.php`, params);
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


  async function registrarPersona() {
    const persona = new FormData();
    persona.append("operation", "registrarPersona");
    persona.append("num_doc", $q("#num_doc").value ? $q("#num_doc").value : '');
    persona.append("apellidos", $q("#apellidos").value ? $q("#apellidos").value : '');
    persona.append("nombres", $q("#nombres").value ? $q("#nombres").value : '');
    persona.append("genero", $q("#genero").value ? $q("#genero").value : '');
    persona.append("direccion", $q("#direccion").value ? $q("#direccion").value : '');
    persona.append("telefono", $q("#telefono1").value ? $q("#telefono1").value : '');
    persona.append("telefono2", $q("#telefono2").value ? $q("#telefono2").value : '');
    persona.append("correo", $q("#correo").value ? $q("#correo").value : '');
    persona.append("iddistrito", $q("#distrito").value ? $q("#distrito").value : '');

    const fpersonas = await fetch(`${host}persona.controller.php`, {
      method: "POST",
      body: persona,
    });
    const rpersonas = await fpersonas.json();
    return rpersonas;
  }

  // ME QUEDE ACA, FALTA IMPLEMENTAR EL USUARIO, SOLO LO COPIE DE OTRO CODIGO por el momento
  async function registrarColaborador(idpersona) {
    //const perfilData = await getPerfil(parseInt(selector("perfil").value));
    const params = new FormData();
    params.append("operation", "registrarColaborador");
    params.append("idpersona", idpersona);
    params.append("idsucursal", $q("#sucursal").value);
    params.append("fechaingreso", $q("#fechaingreso").value);
    params.append("area", $q("#area").value);
    const resp = await fetch(`${host}nomina.controller.php`, {
      method: 'POST',
      body: params
    });
    const data = await resp.json();
    return data;
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


  async function obtenerPersonaNumDocColaborador() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerPersonaNumDocColaborador");
    params.append("numdoc", $q("#num_doc").value.trim());
    const fpersona = await getDatos(`${host}nomina.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerDataPersonaNoRegistrada() {
    const Fdata = await fetch(`https://app.minam.gob.pe/TransparenciaWSREST/tramites/transparencia/persona?dni=${$q("#num_doc").value}`)
    const data = await Fdata.json()
    return data.data
  }

  async function existeCorreo(correo) {
    const params = new URLSearchParams();
    params.append("operation", "buscarCorreo");
    params.append("correo", correo.trim());

    const data = await getDatos(`${host}recurso.controller.php`, params);
    return data;
  }

  // ********************************* FUNCIONES DE VALIDACION *********************************

  function validarClave(clave) {
    if (clave.length >= 8) {
      return true;
    } else {
      return false;
    }
  }
  //Funcion que agrega disabled a los campos
  function bloquearCampos(isblock) {
    $q("#apellidos").disabled = isblock;
    $q("#nombres").disabled = isblock;
    $q("#genero").disabled = isblock;
    $q("#direccion").disabled = isblock;
    $q("#telefono1").disabled = isblock;
    $q("#telefono2").disabled = isblock;
    $q("#correo").disabled = isblock;
    $q("#nacionalidad").disabled = isblock;
    $q("#departamento").disabled = isblock;
    $q("#provincia").disabled = isblock;
    $q("#distrito").disabled = isblock;
    $q("#fechaingreso").disabled = isblock;
    $q("#area").disabled = isblock;
    /* $q("#nom_usuario").disabled = isblock;
    $q("#sucursal").disabled = isblock;
    $q("#claveacceso").disabled = isblock;
    $q("#upload_widget_firma").disabled = isblock;
    $q("#idnivelacceso").disabled = isblock; */
    //selector("externo").disabled = isblock
  }

  //Muestra los datos en los campos
  function showDatos(data) {
    console.log(data);

    $q("#apellidos").value = data.apellidos;
    $q("#nombres").value = data.nombres;
    $q("#genero").value = data.genero;
    $q("#direccion").value = data.direccion;
    $q("#telefono1").value = data.telefono;
    $q("#telefono2").value = data.telefono2;
    $q("#correo").value = data.correo;
    $q("#nacionalidad").value = data.idnacionalidad;
    $q("#departamento").value = data.iddepartamento;
    $q("#provincia").value = data.idprovincia;
    $q("#distrito").value = data.iddistrito;
    /*     $q("#nom_usuario").value = data.nom_usuario;
        $q("#sucursal").value = data.idsucursal;
        $q("#claveacceso").value = 'no visible';
        $q("#idnivelacceso").value = data.idnivelacceso; */
  }

  //resetea los campos
  function resetUI() {
    $q("#apellidos").value = '';
    $q("#nombres").value = '';
    $q("#genero").value = '';
    $q("#direccion").value = '';
    $q("#telefono1").value = '';
    $q("#telefono2").value = '';
    $q("#correo").value = '';
    $q("#nacionalidad").value = '';
    $q("#departamento").value = '';
    $q("#provincia").value = '';
    $q("#distrito").value = '';
    $q("#fechaingreso").value = '';
    $q("#area").value = '';
    /*     $q("#sucursal").value = '';
        $q("#nom_usuario").value = '';
        $q("#claveacceso").value = '';
        $q("#idnivelacceso").value = ''; */
  }

  function validateData() {
    const data = [
      $q("#num_doc").value = '',
      $q("#apellidos").value = '',
      $q("#nombres").value = '',
      $q("#genero").value = '',
      $q("#direccion").value = '',
      $q("#telefono1").value = '',
      $q("#telefono2").value = '',
      $q("#correo").value = '',
      $q("#nacionalidad").value = '',
      $q("#departamento").value = '',
      $q("#provincia").value = '',
      $q("#distrito").value = '',

      /*       $q("#nom_usuario").value = '',
            $q("#claveacceso").value = '',
            $q("#idnivelacceso").value = '', */
    ];

    const dataNumber = [];

    let isValidate = data.every(x => x.trim().length > 0);

    return (isValidate);
  }

  //Valida que el num. doc sea unico y cumpla ciertos parametros
  async function validateNumDoc() {
    //Validaciones del num doc, guarda en una variable si es valido o no (boolean)
    const isNumeric = /^[0-9]+$/.test($q("#num_doc").value);
    const minLength = ($q("#num_doc").value.length >= 8);
    const validaNumDoc = $q("#num_doc").value.length === 8 || $q("#num_doc").value.length === 20 ? true : false;

    //if ($q("#num_doc").value !== "" && isNumeric && minLength && validaNumDoc) {
    const data = await obtenerPersonaNumDocColaborador(); // ESTO SOLO SERVIRA PARA colaboadores
    const isblock = (data.length > 0); // confirma si la persona ya existe y bloquea los campos 
    bloquearCampos(isblock);

    console.log(isblock);
    console.log("persona vinculada a colaborador -> ", data);

    $q("#btnEnviar").disabled = false;
    if (isblock) {
      showToast("La persona ya existe", "WARNING");
      $q("#btnEnviar").disabled = true;
      showDatos(data[0]);
    } else {
      if (!isReset) {
        resetUI();
        const dataPersonaNR = await obtenerDataPersonaNoRegistrada()
        await showDataPersonaNR(dataPersonaNR)
      }
      $q("#btnEnviar").disabled = false;

    }

    //}
    /* else {
      //console.log(isNumeric);
      if ($q("num_doc").value === "") { showToast("Escribe un Num de Doc.", "WARNING"); }
      else if (!isNumeric) { showToast("Ingresa solo Numeros", "WARNING"); }
      else if (!minLength) { showToast("El minimo es de 8 caracteres", "WARNING"); }
      else if (!validaNumDoc) { showToast("La cantidad de digitos debe ser de 8 o 20", "WARNING"); }
    } */
    //return isValid;
  }

  //Funcion que muestra datos de la persona aun no registrada pero trae datos desde la api reniec
  async function showDataPersonaNR(data) {
    console.log("data persona reniec: ", data);
    const ubig = data.ubigeo.split("/")
    console.log("departamento-> ", ubig[2]);
    $q("#apellidos").value = data.apellidoMaterno + " " + data.apellidoPaterno;
    $q("#nombres").value = data.nombre;
    $q("#direccion").value = data.direccion;
    $q("#departamento").value = ubig[0];
    $q("#provincia").value = ubig[1];
    $q("#distrito").value = ubig[2];
    ubig[2] = ubig[2].charAt(0).toUpperCase() + ubig[2].slice(1).toLowerCase();
    console.log("ubigeo distrito -> ", ubig[2]);
    if (ubig[2]) {
      await cargarUbigeoDesdeDistrito(ubig[2]);
    }
    //selector("externo").disabled = isblock
  }

  async function cargarUbigeoDesdeDistrito(idDistrito) {
    try {
      // 1️⃣ Obtener datos del distrito
      let distrito = await fetch(`${host}recurso.controller.php?operation=obtenerDistritoPorNombre&distrito=${idDistrito}`).then(res => res.json());
      console.log("TODAS LAS DISTRTITOS OBTENIDOAS  -> ", distrito)
      let iddistritoObtenido = distrito[0]?.idprovincia

      // 2️⃣ Obtener todas las provincias y marcar la seleccionada
      let provincias = await fetch(`${host}recurso.controller.php?operation=obtenerTodosProvincias`).then(res => res.json());
      console.log("TODAS LAS PROVINCIAS OBTENIDOAS  -> ", provincias)
      let provinciaSeleccionada = provincias.find(p => p.idprovincia == distrito[0].idprovincia);
      console.log("LA PROVINCIA SELCCIONADA - ", provinciaSeleccionada)

      $q("#provincia").innerHTML = provincias.map(p =>
        `<option value="${p.idprovincia}" ${p.idprovincia === distrito[0].idprovincia ? "selected" : ""}>${p.provincia}</option>`
      ).join("");

      // 3️⃣ Obtener todas los departamentos y marcar el correcto
      let departamentos = await fetch(`${host}recurso.controller.php?operation=obtenerTodosDepartamentos`).then(res => res.json());
      console.log("TODOS LOS DEPARTAMENTOS OBTENIDOS -> ", departamentos)
      console.log("LA PROVINCIA SELCCIONADA - ", provinciaSeleccionada)
      let departamentoSeleccionado = departamentos.find(d => d.iddepartamento === provinciaSeleccionada.iddepartamento);
      console.log("DEPARTAMENTO SELCCIONADO -> ", departamentoSeleccionado)
      $q("#departamento").innerHTML = departamentos.map(d =>
        `<option value="${d.iddepartamento}" ${d.iddepartamento === provinciaSeleccionada.iddepartamento ? "selected" : ""}>${d.departamento}</option>`
      ).join("");

      // 4️⃣ Obtener todas las nacionalidades y marcar la correcta
      let nacionalidades = await fetch(`${host}recurso.controller.php?operation=obtenerTodosNacionalidades`).then(res => res.json());
      console.log("NACIONALIDADES TODAS OBTENIDAS : ", nacionalidades)
      let nacionalidadSeleccionada = nacionalidades.find(n => n.idnacionalidad === departamentoSeleccionado.idnacionalidad);
      $q("#nacionalidad").innerHTML = nacionalidades.map(n =>
        `<option value="${n.idnacionalidad}" ${n.idnacionalidad === departamentoSeleccionado.idnacionalidad ? "selected" : ""}>${n.nacionalidad}</option>`
      ).join("");

      // 5️⃣ Obtener todos los distritos y seleccionar el correcto
      let distritos = await fetch(`${host}recurso.controller.php?operation=obtenerTodosDistritos`).then(res => res.json());
      $q("#distrito").innerHTML = distritos.map(d =>
        `<option value="${d.iddistrito}" ${d.iddistrito === iddistritoObtenido ? "selected" : ""}>${d.distrito}</option>`
      ).join("");

    } catch (error) {
      console.error("Error cargando ubigeo:", error);
    }
  }

  await obtenerAreas()


  // ********************************* EVENTOS Y CARGA DE DATOS *********************************

  /*   $q("#idnivelacceso").addEventListener("change", async (e) => {
      console.log("valor -> ", e.target.value);
      if (e.target.value == "6") {
        $q(".contenedor-color").hidden = false
        $q(".contenedor-porcentaje").hidden = false
        $q(".contenedor-marcaagua").hidden = false
        //$q(".contenedor-representante").hidden = true
      }
      else if (e.target.value == "3") {
        //$q(".contenedor-representante").hidden = false
        $q(".contenedor-color").hidden = true
        $q(".contenedor-porcentaje").hidden = true
        $q(".contenedor-marcaagua").hidden = true
      }
      else {
        // $q(".contenedor-representante").hidden = true
        $q(".contenedor-color").hidden = true
        $q(".contenedor-porcentaje").hidden = true
        //$q(".contenedor-representante").hidden = true
        $q(".contenedor-marcaagua").hidden = true
      }
    })
   */
  $q("#search").addEventListener("click", async () => {
    await validateNumDoc();
  });

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

  async function cargarDatosPorDefecto() {
    //niveles de acceso / rol
    const data = await obtenerAreas()
    console.log("data -> ", data);
    $q("#area").innerHTML = "<option value=''>Selecciona</option>";
    data.forEach(niveles => {
      $q("#area").innerHTML += `<option value="${niveles.idarea}">${niveles.area}</option>`;
    });
  }


  // ********************************* REGISTROS *********************************

  $q("#btnGuardarNuevaArea").addEventListener("click", async () => {
    const arearegistrada = await registrarArea()
    console.log("area registrada -> ", arearegistrada);
    if ($q("#areanueva").value.trim() == "") {
      showToast("El campo area no puede estar vacio", "ERROR");
      return
    }
    if (arearegistrada) {
      showToast("Area registrada correctamente", "SUCCESS");
      $q("#area").value = '';
      await cargarDatosPorDefecto()
    } else {
      showToast("Error al registrar el area", "ERROR");
    }
  })

  $q("#form-person-user").addEventListener("submit", async (e) => {
    e.preventDefault();
    isReset = true;
    await validateNumDoc(); //valida que el numero de caracteres y otras validaciones sean correctas
    //const validateFields = validateData(); //Valida que los campos no esten vacios
    //const validarClaveAcceso = validarClave($q("#claveacceso").value); //valida la clave de acceso

    //const numericTelefono = /^[0-9]+$/.test($q("#telefono1").value); //valida que sean numeros
    //    const unikeUser = await searchNomUser($q("#usuario").value);// valida que el nom usuario sea unico
    const unikeEmail = await existeCorreo($q("#correo").value);
    console.log("email encontrado -> ", unikeEmail);

    /*     const imagenInputMarcaAgua = $q("#upload_widget_marcaagua");
        const fileMarcaAgua = imagenInputMarcaAgua.files[0];
        const imagenInputFirma = $q("#upload_widget_firma");
        const fileFirma = imagenInputFirma.files[0]; */

    //const existResp = await existeResponsable(parseInt($q("#area").value)); //valida que no exista un responsable en el area elegida
    //if (parseInt($q("#nivel").value) === 2 && isNaN(parseInt($q("#area").value))) { selectArea = false; }

    if (unikeEmail.length === 0) {
      //console.log($q("#apellidos").value.toUpperCase());
      //console.log($q("#nombres").value.toUpperCase());

      if (await ask("¿Estas seguro de registrar?")) {
        const data = await registrarPersona();
        console.log(data);
        //alert("registrando persona")
        if (data.idpersona > 0) {
          console.log("persona registrada -> ", data);
          const colaborador = await registrarColaborador(data.idpersona);
          console.log(colaborador);

          if (colaborador.idcolaborador > 0) {
            showToast("Se ha registrado correctamente al colaborador", "SUCCESS", 1000, '');
            isReset = false;
            resetUI();
            $q("#num_doc").value = "";
            bloquearCampos(true);
            $q("#btnEnviar").disabled = true;
            $q("#num_doc").focus();
          } else {
            showToast("Hubo un error al registrar los datos del colaborador", "ERROR");
          }
        } else {
          showToast("Hubo un error al registrar los datos de la persona", "ERROR");
        }
      }
    } else {
      let message = "";
      //if (!validateFields) { message = "Completa los campos"; }
      //if (!numericTelefono) { message = "Solo numeros en el Telfono"; }
      //if (!validarClaveAcceso) { message = "el minimo de caracteres para la clave de acceso es de 8"; }
      //if (unikeUser.length > 0) { message = "El nombre de usuario ya existe"; }
      //if (unikeEmail.length > 0) { message = "El correo electronico ya existe"; }
      showToast(message, "ERROR");
    }
  })

});