document.addEventListener("DOMContentLoaded", async () => {
  const host = "http://localhost/vega-erp/controllers/";
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


  /* ************************************* OBTENER RECURSOS ******************************************************* */

  async function obtenerNiveles() {
    const data = await getDatos(`${host}recurso.controller.php`, "operation=obtenerNiveles");
    console.log(data);

    return data
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

  async function registrarPersona() {
    const persona = new FormData();
    persona.append("operation", "registrarPersona");
    persona.append("num_doc", $q("#num_doc").value);
    persona.append("apellidos", $q("#apellidos").value);
    persona.append("nombres", $q("#nombres").value);
    persona.append("genero", $q("#genero").value);
    persona.append("direccion", $q("#direccion").value);
    persona.append("telefono", $q("#telefono1").value);
    persona.append("telefono2", $q("#telefono2").value);
    persona.append("correo", $q("#correo").value);
    persona.append("iddistrito", $q("#distrito").value);

    const fpersonas = await fetch(`${host}persona.controller.php`, {
      method: "POST",
      body: persona,
    });
    const rpersonas = await fpersonas.json();
    return rpersonas;
  }

  // ME QUEDE ACA, FALTA IMPLEMENTAR EL USUARIO, SOLO LO COPIE DE OTRO CODIGO por el momento
  async function registrarUsuario(idpersona) {
    //const perfilData = await getPerfil(parseInt(selector("perfil").value));
    const params = new FormData();
    params.append("operation", "registrarUsuario");
    params.append("idpersona", idpersona);
    params.append("nom_usuario", $q("#nom_usuario").value.trim());
    params.append("claveacceso", $q("#claveacceso").value);
    params.append("idnivelacceso", $q("#idnivelacceso").value);
    const resp = await fetch(`${host}usuario.controller.php`, {
      method: 'POST',
      body: params
    });
    const data = await resp.json();
    return data;
  }


  async function obtenerPersonaPorDoc() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerPersonaPorDoc");
    params.append("num_doc", $q("#num_doc").value.trim());
    const fpersona = await getDatos(`${host}usuario.controller.php`, params)
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
    $q("#nom_usuario").disabled = isblock;
    $q("#claveacceso").disabled = isblock;
    $q("#idnivelacceso").disabled = isblock;
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
    $q("#nom_usuario").value = data.nom_usuario;
    $q("#claveacceso").value = 'no visible';
    $q("#idnivelacceso").value = data.idnivelacceso;
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
    $q("#nom_usuario").value = '';
    $q("#claveacceso").value = '';
    $q("#idnivelacceso").value = '';
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
      $q("#nom_usuario").value = '',
      $q("#claveacceso").value = '',
      $q("#idnivelacceso").value = '',
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

    if ($q("#num_doc").value !== "" && isNumeric && minLength && validaNumDoc) {
      const data = await obtenerPersonaPorDoc();
      const isblock = (data.length > 0); // confirma si la persona ya existe y bloquea los campos 
      bloquearCampos(isblock);

      console.log(isblock);
      console.log(data);


      if (isblock) {
        showToast("La persona ya existe", "WARNING");
        $q("#btnEnviar").disabled = true;
        showDatos(data[0]);
      } else {
        if (!isReset) {
          resetUI();
          const dataPersonaNR = await obtenerDataPersonaNoRegistrada()
          showDataPersonaNR(dataPersonaNR)
        }
        $q("#btnEnviar").disabled = false;
      }
    }
    else {
      //console.log(isNumeric);
      if ($q("num_doc").value === "") { showToast("Escribe un Num de Doc.", "WARNING"); }
      else if (!isNumeric) { showToast("Ingresa solo Numeros", "WARNING"); }
      else if (!minLength) { showToast("El minimo es de 8 caracteres", "WARNING"); }
      else if (!validaNumDoc) { showToast("La cantidad de digitos debe ser de 8 o 20", "WARNING"); }
    }
    //return isValid;
  }

  //Funcion que muestra datos de la persona aun no registrada pero trae datos desde la api reniec
  function showDataPersonaNR(data) {
    console.log("data persona reniec: ", data);
    const ubig = data.ubigeo.split("/")
    console.log("departamento-> ", ubig[0]);
    $q("#apellidos").value = data.apellidoMaterno + " " + data.apellidoPaterno;
    $q("#nombres").value = data.nombre;
    $q("#direccion").value = data.direccion;
    $q("#departamento").value = ubig[0];
    $q("#provincia").value = ubig[1];
    $q("#distrito").value = ubig[2];
    //selector("externo").disabled = isblock
  }

  await obtenerNiveles()


  // ********************************* EVENTOS Y CARGA DE DATOS *********************************

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
    const data = await obtenerNiveles()
    $q("#idnivelacceso").innerHTML = "<option value=''>Selecciona</option>";
    data.forEach(niveles => {
      $q("#idnivelacceso").innerHTML += `<option value="${niveles.idnivelacceso}">${niveles.nivelacceso}</option>`;
    });
  }


  // ********************************* REGISTROS *********************************

  $q("#form-person-user").addEventListener("submit", async (e) => {
    e.preventDefault();
    alert("entrando")
    isReset = true;
    await validateNumDoc(); //valida que el numero de caracteres y otras validaciones sean correctas
    //const validateFields = validateData(); //Valida que los campos no esten vacios
    //const validarClaveAcceso = validarClave($q("#claveacceso").value); //valida la clave de acceso

    //const numericTelefono = /^[0-9]+$/.test($q("#telefono1").value); //valida que sean numeros
    //    const unikeUser = await searchNomUser($q("#usuario").value);// valida que el nom usuario sea unico
    const unikeEmail = await existeCorreo($q("#correo").value);
    console.log("email encontrado -> ", unikeEmail);
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
          const usuario = await registrarUsuario(data.idpersona);
          console.log(usuario);

          if (usuario.idusuario > 0) {
            showToast("Se ha registrado correctamente al usuario", "SUCCESS", 1000, '');
            isReset = false;
            resetUI();
            $q("#num_doc").value = "";
            bloquearCampos(true);
            $q("#btnEnviar").disabled = true;
            $q("#num_doc").focus();
          } else {
            showToast("Hubo un error al registrar los datos del usuario", "ERROR");
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
  });
});