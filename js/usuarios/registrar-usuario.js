document.addEventListener("DOMContentLoaded", () => {
    const host = "http://localhost/SIGEMAPRE/controllers/";
    let isReset = false;
    let mensaje = "";
    let nomPerfil = "";
    blockCamps(true);
    function selector(value) {
      return document.querySelector(`#${value}`);
    }
  
    /**
     * Obtiene datos desde la DB
     * @param {*} link el nombre del controlador
     * @param {*} params parametros que necesites pasar para obtener los datos
     * @returns un array de objetos con datos de la DB
     */
    async function getDatos(link, params) {
      let data = await fetch(`${host}${link}?${params}`);
      return data.json();
    }
  
    //Sedes
    (async () => {
      const params = new URLSearchParams();
      params.append("operation", "listSedesByOrg");
      params.append("idorganizacion", localStorage.getItem("idorg") == undefined ? 1 : localStorage.getItem("idorg"));
      const data = await getDatos("sede.controller.php", params);
  
      data.forEach(x => {
        const option = document.createElement("option");
        option.value = x.idsede;
        option.textContent = `${x.distrito} - ${x.direccion}`;
        selector("sede").appendChild(option);
      });
    })();
  
    selector("sede").addEventListener("change", async () => {
      const params = new URLSearchParams();
      params.append("operation", "listAreas");
      params.append("idsede", selector("sede").value);
  
      const data = await getDatos("area.controller.php", params);
  
      const elementsSelect = selector("area");
      for (let i = elementsSelect.childElementCount - 1; i > 0; i--) {
        elementsSelect.remove(i);
      }
  
      data.forEach(x => {
        const option = document.createElement("option");
        option.textContent = x.nombre;
        option.value = x.idarea;
        selector("area").appendChild(option);
      });
    });
  
    //Evento al tipear el campo numero documento
    selector("numDoc").addEventListener("keyup", () => {
      const spanTipoDoc = selector("showTipoDoc");
      const cantNumDoc = selector("numDoc");
  
      if (cantNumDoc.value.length === 8) {
        spanTipoDoc.textContent = "DNI";
      }
      else if (cantNumDoc.value.length === 20) {
        spanTipoDoc.textContent = "Carnet De extranjeria";
      } else { spanTipoDoc.textContent = ""; }
    });
  
    //Niveles de Acceso
    (async () => {
      const data = await getDatos("nivelAcceso.controller.php", "operation=getAll");
      console.log(data);
  
      data.forEach(x => {
        const option = document.createElement("option");
        option.textContent = reNameRol(x.nivelacceso);
        option.value = x.idnivelacceso;
  
        selector("nivel").appendChild(option);
      });
    })();
  
    function reNameRol(rol) {
      let rename = "";
      switch (rol) {
        case 'RES':
          rename = "Responsable";
          break;
        case 'TNC':
          rename = "Tecnico";
          break;
        case 'ADM':
          rename = "Administrador";
          break;
      }
      return rename;
    }
  
    //TIPO DOC
    (async () => {
      const data = await getDatos("tipodoc.controller.php", "operation=getAll");
      data.forEach(x => {
        const element = document.createElement("option");
        element.textContent = x.tipodoc;
        element.value = x.idtipodoc;
        selector("tipodoc").appendChild(element);
      });
    })();
  
  
    //obtiene los datos de la persona segun su numDoc
    async function searchPersonaByNumDoc() {
      const params = new URLSearchParams();
      params.append("operation", "searchPersonaNumDoc");
      params.append("numdoc", selector("numDoc").value.trim());
  
      const data = await getDatos(`persona.controller.php`, params);
      return data;
    }
  
    async function obtenerDataPersonaNoRegistrada() {
      const Fdata = await fetch(`https://app.minam.gob.pe/TransparenciaWSREST/tramites/transparencia/persona?dni=${selector("numDoc").value}`)
      const data = await Fdata.json()
      return data.data
    }
  
  
    //Valida que el num. doc sea unico y cumpla ciertos parametros
    async function validateNumDoc() {
      //Validaciones del num doc
      const isNumeric = /^[0-9]+$/.test(selector("numDoc").value);
      const minLength = (selector("numDoc").value.length >= 8);
      const validaNumDoc = selector("numDoc").value.length === 8 || selector("numDoc").value.length === 20 ? true : false;
  
      if (selector("numDoc").value !== "" && isNumeric && minLength && validaNumDoc) {
        const data = await searchPersonaByNumDoc();
        const isblock = (data.length > 0);
        blockCamps(isblock);
        
        //console.log(isblock);
        console.log(data);
  
  
        if (isblock) {
          showToast("La persona ya existe", "WARNING");
          selector("btnEnviar").disabled = true;
          showDatos(data[0]);
        } else {
          if (!isReset) {
            resetUI();
            const dataPersonaNR = await obtenerDataPersonaNoRegistrada()
            showDataPersonaNR(dataPersonaNR)
          }
          selector("btnEnviar").disabled = false;
        }
      }
      else {
        //console.log(isNumeric);
        if (selector("numDoc").value === "") { showToast("Escribe un Num de Doc.", "WARNING"); }
        else if (!isNumeric) { showToast("Ingresa solo Numeros", "WARNING"); }
        else if (!minLength) { showToast("El minimo es de 8 caracteres", "WARNING"); }
        else if (!validaNumDoc) { showToast("La cantidad de digitos debe ser de 8 o 20", "WARNING"); }
      }
      //return isValid;
    }
  
    //Buscar persona por num. doc.
    selector("search").addEventListener("click", async () => {
      await validateNumDoc();
    });
  
    //Buscar persona por num. doc. (Enter)
    selector("numDoc").addEventListener("keydown", async (e) => {
      if (e.key === "Enter") {
        await validateNumDoc();
      }
    });
  
    //Funcion que muestra datos de la persona aun no registrada pero trae datos desde la api reniec
    function showDataPersonaNR(data) {
      console.log("data persona reniec: ", data);
      
      selector("apellidos").value = data.apellidoPaterno + ' '+ data.apellidoMaterno;
      selector("nombres").value = data.nombre;
      selector("direccion").value = data.direccion;
      //selector("externo").disabled = isblock
    }
  
    //Funcion que agg disabled a los campos
    function blockCamps(isblock) {
      selector("tipodoc").disabled = isblock;
      selector("apellidos").disabled = isblock;
      selector("nombres").disabled = isblock;
      selector("telefono").disabled = isblock;
      selector("genero").disabled = isblock;
      selector("direccion").disabled = isblock;
      selector("correo").disabled = isblock;
      selector("usuario").disabled = isblock;
      selector("password").disabled = isblock;
      selector("nivel").disabled = isblock;
      //selector("externo").disabled = isblock
    }
  
    //Muestra los datos en los campos
    function showDatos(data) {
      console.log(data);
  
      selector("tipodoc").value = data.idtipodoc;
      selector("apellidos").value = data.apellidos;
      selector("nombres").value = data.nombres;
      selector("telefono").value = data.telefono;
      selector("genero").value = data.genero;
      selector("direccion").value = data.direccion;
      selector("correo").value = data.email;
      selector("password").value = data.claveacceso;
      selector("nivel").value = data.idnivelacceso;
      selector("usuario").value = data.nom_usuario;
      selector("externo").checked = data.es_externo === 1 ? true : false;
    }
  
    //Valida que no tenga espacios en blanco
    function validateData() {
      const data = [
        selector("tipodoc").value,
        selector("numDoc").value,
        selector("apellidos").value,
        selector("nombres").value,
        selector("telefono").value,
        selector("genero").value,
        selector("direccion").value,
        //selector("correo").value,
        selector("usuario").value,
        selector("password").value,
        selector("nivel").value,
      ];
  
      const dataNumber = [];
  
      let isValidate = data.every(x => x.trim().length > 0);
      let isValidateN = dataNumber.every(x => x >= 1);
  
      return (isValidate);
    }
  
    //Registrar Persona
    selector("form-person-user").addEventListener("submit", async (e) => {
      e.preventDefault();
  
      isReset = true;
      await validateNumDoc(); //valida que el numero de caracteres y otras validaciones sean correctas
      const validateFields = validateData(); //Valida que los campos no esten vacios
  
      const numericTelefono = /^[0-9]+$/.test(selector("telefono").value); //valida que sean numeros
      const isUnikeTelf = await searchTelf(selector("telefono").value); //Valida que el telefono sea unico
      //console.log(isUnikeTelf);
      const validarClaveAcceso = validarClave(selector("password").value); //valida la clave de acceso
      //console.log(validarClaveAcceso);
      const validarTipoNumDoc = validateTipoDocNumDoc(); //valida la cantidad de num doc con el tipodoc
      //console.log(validarTipoNumDoc);
      //console.log(selector("tipodoc").value);
      const unikeUser = await searchNomUser(selector("usuario").value);// valida que el nom usuario sea unico
      //console.log(unikeUser);
  
      const unikeEmail = await existeCorreo(selector("correo").value);
  
      const existResp = await existeResponsable(parseInt(selector("area").value)); //valida que no exista un responsable en el area elegida
      let selectArea = true;
      if (parseInt(selector("nivel").value) === 2 && isNaN(parseInt(selector("area").value))) { selectArea = false; }
  
      if (validateFields && isUnikeTelf.length === 0 && unikeUser.length === 0 &&
        validarClaveAcceso && validarTipoNumDoc && numericTelefono && unikeEmail.length === 0 &&
        parseInt(existResp[0].cantidad) === 0 && selectArea) {
        console.log(selector("apellidos").value.toUpperCase());
        console.log(selector("nombres").value.toUpperCase());
        
        if (await ask("¿Estas seguro de registrar?")) {
          const params = new FormData();
          params.append("operation", "addPersona");
          params.append("idtipodoc", selector("tipodoc").value);
          params.append("num_doc", selector("numDoc").value.trim());
          params.append("apellidos", selector("apellidos").value.trim().toUpperCase());
          params.append("nombres", selector("nombres").value.trim().toUpperCase());
          params.append("genero", selector("genero").value);
          params.append("direccion", selector("direccion").value.trim());
          params.append("telefono", selector("telefono").value.trim());
          params.append("email", selector("correo").value.trim());
  
          const resp = await fetch(`${host}persona.controller.php`, {
            method: 'POST',
            body: params
          });
          const data = await resp.json();
          console.log(data);
  
          if (data.idpersona > 0) {
            const usuario = await addUser(data.idpersona);
            console.log(usuario);
  
            if (usuario.idusuario > 0) {
  
              if (parseInt(selector("nivel").value) === 2) {
                const isOkey = await addResponsable(usuario.idusuario);
                if (isOkey.idresponsable < 0) {
                  showToast("Hubo un error al registrar como responsable", "ERROR");
                  return;
                }
              }
              showToast("Se ha registrado correctamente al usuario", "SUCCESS", 1000, 'http://localhost/SIGEMAPRE/views/usuarios/listar-usuario');
              selector("area").value = "";
              selector("area").hidden = true;
              isReset = false;
              resetUI();
              selector("numDoc").value = "";
              blockCamps(true);
              selector("externo").disabled = true;
              selector("btnEnviar").disabled = true;
              selector("numDoc").focus();
            } else {
              showToast("Hubo un error al registrar los datos del usuario", "ERROR");
            }
          } else {
            showToast("Hubo un error al registrar los datos de la persona", "ERROR");
          }
        }
      } else {
        let message = "";
        if (!validateFields) { message = "Completa los campos"; }
        if (!numericTelefono) { message = "Solo numeros en el Telfono"; }
        if (isUnikeTelf.length > 0) { message = "El numero de telefono ya existe"; }
        if (!validarClaveAcceso) { message = "el minimo de caracteres para la clave de acceso es de 8"; }
        if (!validarTipoNumDoc) { message = "El tipo de documento elegido no coincide con los caracteres de tu numero de doc."; }
        if (unikeUser.length > 0) { message = "El nombre de usuario ya existe"; }
        if (unikeEmail.length > 0) { message = "El correo electronico ya existe"; }
        if (existResp[0].cantidad > 0) { message = "Ya existe un responsable en el area seleccionada"; }
        if (!selectArea) { message = "Selecciona un area"; }
        showToast(message, "ERROR");
      }
    });
  
    async function showModalBaja() {
      const modalImg = new bootstrap.Modal(selector("modal-baja"));
      modalImg.show();
    }
  
    //registrar al usuario 
    async function addUser(idpersona) {
      //const perfilData = await getPerfil(parseInt(selector("perfil").value));
      const params = new FormData();
      params.append("operation", "addUser");
      params.append("idpersona", idpersona);
      params.append("nom_usuario", selector("usuario").value.trim());
      params.append("claveacceso", selector("password").value);
      params.append("idnivelacceso", selector("nivel").value);
      params.append("es_externo", selector("externo").checked == true ? 1 : 0)
      console.log("externo value = ", selector("externo").checked)
      const resp = await fetch(`${host}usuario.controller.php`, {
        method: 'POST',
        body: params
      });
      const data = await resp.json();
      return data;
    }
  
    //Valida que la cantidad de digitos del num doc sea validado segun el tipo doc
    function validateTipoDocNumDoc() {
      let isvalidate = false;
      if (selector("numDoc").value.length === 8 && parseInt(selector("tipodoc").value) === 1) {
        isvalidate = true;
      }
      if (selector("numDoc").value.length === 20 && parseInt(selector("tipodoc").value) === 2) {
        isvalidate = true;
      }
      return isvalidate;
    }
  
    //Verificar que el numero de telefono sea unico
    async function searchTelf(telf) {
      const params = new URLSearchParams();
      params.append("operation", "searchTelefono");
      params.append("telefono", telf.trim());
      const data = await getDatos(`persona.controller.php`, params);
      return data;
    }
  
    //Valida que la clave de acceso tengo un minimo de 8 caracteres
    function validarClave(clave) {
      if (clave.length >= 8) {
        return true;
      } else {
        return false;
      }
    }
  
    //Valida si ya existe el correo
    async function existeCorreo(email) {
      const params = new URLSearchParams();
      params.append("operation", "searchEmail");
      params.append("email", email.trim());
  
      const data = await getDatos("persona.controller.php", params);
      return data;
    }
  
    //Valida si existe el nombre de usuario
    async function searchNomUser(user) {
      const params = new URLSearchParams();
      params.append("operation", "searchNomUsuario");
      params.append("nom_usuario", user.trim());
  
      const data = await getDatos("usuario.controller.php", params);
      return data;
    }
  
    //habilita el checkbox siempre y cuando sea tecnico - muestra no esconde la lista de areas siempre y cuando sea responsable 
    selector("nivel").addEventListener("change", () => {
      let validateResp = true;
      if (parseInt(selector("nivel").value) === 3) {
        validateResp = false;
      }
      selector("externo").checked = false;
      selector("externo").disabled = validateResp;
  
      let selectResp = true;
      if (parseInt(selector("nivel").value) === 2) {
        selectResp = false;
      }
      showSelectArea(selectResp);
    });
  
    function showSelectArea(isSelectResp) {
      selector("area").hidden = isSelectResp;
      selector("sede").hidden = isSelectResp;
    }
  
    async function addResponsable(idusuario) {
      const userLoged = await getIdUserLoged();
      const params = new FormData();
      params.append("operation", "addResponsable");
      params.append("idarea", parseInt(selector("area").value));
      params.append("idusuario_responsable", idusuario);
      params.append("idusuario_asigna", userLoged[0].idusuario);
  
      const resp = await fetch(`${host}responsable.controller.php`, {
        method: 'POST',
        body: params
      });
  
      const data = await resp.json();
      return data;
    }
  
    //Verifica que no exista un responsable del area elegido
    async function existeResponsable(idarea) {
      const params = new URLSearchParams();
      params.append("operation", "existeResponsableArea");
      params.append("idarea", idarea);
  
      const data = await getDatos(`usuario.controller.php`, params);// validar el campo area
      return data;
    }
  
    //Funcion que obtiene el id del usuario logeado
    async function getIdUserLoged() {
      const params = new URLSearchParams();
      params.append("operation", "searchNomUsuario");
      params.append("nom_usuario", selector("nomuser").textContent);
  
      const data = await getDatos("usuario.controller.php", params);
      return data;
    }
  
    //resetea los campos
    function resetUI() {
      selector("tipodoc").value = "";
      selector("apellidos").value = "";
      selector("nombres").value = "";
      selector("telefono").value = "";
      selector("genero").value = "";
      selector("direccion").value = "";
      selector("correo").value = "";
      selector("usuario").value = "";
      selector("password").value = "";
      selector("nivel").value = "";
      selector("externo").checked = false;
      selector("showTipoDoc").textContent = "";
    }
  });