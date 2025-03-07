document.addEventListener('DOMContentLoaded', async function () {
  const host = "http://localhost/vega-erp/controllers/";
  let isReset = false;
  bloquearCampos(true)
  let idcliente = -1
  let ncotizacion = ''
  let iddetalleevento = -1
  let idprovincia = -1
  let idartista = -1
  let provincia = ''

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

  /* $q("#btnGuardarAC").addEventListener("click", async function () {
    let modalCotizacion = new bootstrap.Modal($q("#modal-convenio"));
    modalCotizacion.show();
  }); */

  /*   $q("#btnGenerarCotizacion").addEventListener("click", async () => {
      alert("generando pdf...")
    })
   */
  // ****************************** OBTENER DATOS ****************************** //

  async function obtenerDepartamentos(iddepartamento) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDepartamentos");
    params.append("idnacionalidad", iddepartamento);
    const data = await getDatos(`${host}recurso.controller.php`, params);
    return data
  }

  async function obtenerProvincias(iddepartamento) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerProvincias");
    params.append("iddepartamento", iddepartamento);
    const data = await getDatos(`${host}recurso.controller.php`, params);
    return data
  }

  async function obtenerDistritos(idprovincia) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDistritos");
    params.append("idprovincia", idprovincia);
    const data = await getDatos(`${host}recurso.controller.php`, params);
    return data
  }

  async function obtenerDataClienteDNI() {
    const Fdata = await fetch(`https://app.minam.gob.pe/TransparenciaWSREST/tramites/transparencia/persona?dni=${$q("#ndocumento").value}`)
    const data = await Fdata.json()
    return data.data
  }

  async function obtenerCotizacionPorNcot(ncotizacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerCotizacionPorNcot");
    params.append("ncotizacion", ncotizacion);
    const data = await getDatos(`${host}detalleevento.controller.php`, params);
    return data
  }
  async function obtenerArtistas() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUsuarioPorNivel");
    params.append("idnivelacceso", 6);
    const data = await getDatos(`${host}usuario.controller.php`, params)
    console.log(data);
    $q("#artista").innerHTML = "<option value=''>Selecciona</option>";
    data.forEach(artista => {
      $q("#artista").innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
    });
  }

  //https://api.apis.net.pe/v2/sunat/ruc/full?numero=20611593881&token=apis-token-13404.T66vw10MJiiqMLEMgeODQI9kYuZinPSM
  //https://app.minam.gob.pe/TransparenciaWSREST/tramites/transparencia/sunat?ruc=${$q("#ndocumento").value}
  async function obtenerDataClienteRUC() {
    console.log($q("#ndocumento").value)
    const Fdata = await fetch(`${host}cliente.controller.php?operation=consultarRUC&ndocumento=${$q("#ndocumento").value}`)
    const data = await Fdata.json()
    console.log("data sunat: ", data)
    return data
  }

  async function obtenerClientePorDoc(ndocumento) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerClientePorDoc");
    params.append("ndocumento", ndocumento);
    const fpersona = await getDatos(`${host}cliente.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerDPporId(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDPporId");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const fpersona = await getDatos(`${host}detalleevento.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerTarifaArtistaPorProvincia(idprovincia) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerTarifaArtistaPorProvincia");
    params.append("idprovincia", idprovincia);
    const fpersona = await getDatos(`${host}tarifa.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerCotizacionesPorModalidad() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerCotizacionesPorModalidad");
    params.append("modalidad", 2);
    const fpersona = await getDatos(`${host}detalleevento.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  /* async function obtenerCotizacion(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerCotizacion");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const fpersona = await getDatos(`${host}detalleevento.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }
 */
  // ****************************** LLENAR COMBOS ****************************** //
  await obtenerArtistas()
  // ELEGIR NACIONALIDAD DE CLIENTE
  $q("#nacionalidad").addEventListener("change", async () => {
    const departamentos = await obtenerDepartamentos($q("#nacionalidad").value);
    $q("#departamento").innerHTML = "<option value=''>Selecciona</option>";
    departamentos.forEach(dpa => {
      $q("#departamento").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
    });
  });
  // ELEGIR NACIONALIDAD DE DETALLE EVENTO
  $q("#nacionalidad2").addEventListener("change", async () => {
    const departamentos = await obtenerDepartamentos($q("#nacionalidad2").value);
    $q("#departamento2").innerHTML = "<option value=''>Selecciona</option>";
    console.log("departamentos 2", departamentos);
    departamentos.forEach(dpa => {
      $q("#departamento2").innerHTML += `<option value="${dpa.iddepartamento}">${dpa.departamento}</option>`;
    });
  });

  $q("#departamento").addEventListener("change", async () => {
    const provincias = await obtenerProvincias($q("#departamento").value);
    $q("#provincia").innerHTML = "<option value=''>Selecciona</option>";
    provincias.forEach(prv => {
      $q("#provincia").innerHTML += `<option value="${prv.idprovincia}">${prv.provincia}</option>`;
    });
  });
  $q("#departamento2").addEventListener("change", async () => {
    const provincias = await obtenerProvincias($q("#departamento2").value);
    $q("#provincia2").innerHTML = "<option value=''>Selecciona</option>";
    provincias.forEach(prv => {
      $q("#provincia2").innerHTML += `<option value="${prv.idprovincia}">${prv.provincia}</option>`;
    });
  });

  $q("#provincia").addEventListener("change", async () => {
    const distritos = await obtenerDistritos($q("#provincia").value);
    $q("#distrito").innerHTML = "<option value=''>Selecciona</option>";
    distritos.forEach(dst => {
      $q("#distrito").innerHTML += `<option value="${dst.iddistrito}">${dst.distrito}</option>`;
    });
  });

  $q("#provincia2").addEventListener("change", async () => {
    const distritos = await obtenerDistritos($q("#provincia2").value);
    $q("#distrito2").innerHTML = "<option value=''>Selecciona</option>";
    distritos.forEach(dst => {
      $q("#distrito2").innerHTML += `<option value="${dst.iddistrito}">${dst.distrito}</option>`;
    });
  });

  // ****************************** REGISTRAR DATOS ****************************** //

  async function registrarCliente() {
    const cliente = new FormData();
    cliente.append("operation", "registrarCliente");
    cliente.append("iddistrito", $q("#distrito").value ? $q("#distrito").value : '');
    cliente.append("ndocumento", $q("#ndocumento").value ? $q("#ndocumento").value : '');
    cliente.append("razonsocial", $q("#razonsocial").value ? $q("#razonsocial").value : '');
    cliente.append("representantelegal", $q("#representantelegal").value ? $q("#representantelegal").value : '');
    cliente.append("telefono", $q("#telefono").value ? $q("#telefono").value : '');
    cliente.append("correo", $q("#correo").value ? $q("#correo").value : '');
    cliente.append("direccion", $q("#direccion").value ? $q("#direccion").value : '');

    console.log($q("#distrito").value);
    console.log($q("#ndocumento").value);
    console.log($q("#razonsocial").value);
    console.log($q("#telefono").value);
    console.log($q("#correo").value);
    console.log($q("#direccion").value);


    const fcliente = await fetch(`${host}cliente.controller.php`, {
      method: "POST",
      body: cliente,
    });
    const rcliente = await fcliente.json();
    return rcliente;
  }

  async function registrarDetalleEvento(idcliente, ncotizacion) {

    const detalle = new FormData();
    detalle.append("operation", "registrarDetallePresentacion");
    detalle.append("idusuario", $q("#artista").value); // id artista
    detalle.append("idcliente", idcliente);
    detalle.append("iddistrito", $q("#distrito2").value);
    detalle.append("ncotizacion", ncotizacion ? ncotizacion : '');
    detalle.append("fechapresentacion", $q("#fechapresentacion").value);
    detalle.append("horainicio", $q("#horainicio").value);
    detalle.append("horafinal", $q("#horafinal").value);
    detalle.append("establecimiento", $q("#establecimiento").value);
    detalle.append("referencia", $q("#referencia").value);
    detalle.append("tipoevento", $q("#tipoevento").value);
    detalle.append("modalidad", $q("#modalidad").value);
    detalle.append("validez", $q("#validez").value ? $q("#validez").value : '');
    detalle.append("igv", $q("#igv").checked ? 1 : 0);

    const fdetalle = await fetch(`${host}detalleevento.controller.php`, {
      method: "POST",
      body: detalle,
    });
    const rdetalle = await fdetalle.json();
    return rdetalle;
  }

 /*  async function registrarConvenio(iddetallepresentacion, estado) {

    const convenio = new FormData();
    convenio.append("operation", "registrarConvenio");
    convenio.append("iddetallepresentacion", iddetallepresentacion); // id artista
    convenio.append("abonogarantia", $q("#abonogarantia").value);
    convenio.append("abonopublicidad", $q("#abonopublicidad").value);
    convenio.append("propuestacliente", $q("#propuestacliente").value);
    convenio.append("estado", estado);

    const fconvenio = await fetch(`${host}convenio.controller.php`, {
      method: "POST",
      body: convenio,
    });
    const rconvenio = await fconvenio.json();
    return rconvenio;
  } */

  /* async function registrarContrato(iddetallepresentacion, estado) {

    const contrato = new FormData();
    contrato.append("operation", "registrarContrato");
    contrato.append("iddetallepresentacion", iddetallepresentacion); // id artista
    contrato.append("montopagado", $q("#montopagado").value);
    contrato.append("estado", estado);

    const fcontrato = await fetch(`${host}contrato.controller.php`, {
      method: "POST",
      body: contrato,
    });
    const rcontrato = await fcontrato.json();
    return rcontrato;
  } */

  // ************************************* FUNCIONES DE VALIDACION ************************************* //

  function bloquearCampos(isblock) {
    $q("#razonsocial").disabled = isblock;
    $q("#telefono").disabled = isblock;
    $q("#correo").disabled = isblock;
    $q("#nacionalidad").disabled = isblock;
    $q("#departamento").disabled = isblock;
    $q("#provincia").disabled = isblock;
    $q("#distrito").disabled = isblock;
    $q("#direccion").disabled = isblock;
    $q("#artista").disabled = isblock;
    $q("#fechapresentacion").disabled = isblock;
    $q("#horainicio").disabled = isblock;
    $q("#horafinal").disabled = isblock;
    $q("#establecimiento").disabled = isblock;
    $q("#tipoevento").disabled = isblock;
    $q("#modalidad").disabled = isblock;
    $q("#validez").disabled = isblock;
    $q("#nacionalidad2").disabled = isblock;
    $q("#departamento2").disabled = isblock;
    $q("#provincia2").disabled = isblock;
    $q("#distrito2").disabled = isblock;
    $q("#igv").disabled = isblock;
    $q("#referencia").disabled = isblock;
    $q("#btnGuardarAC").disabled = isblock;
    $q("#btnLimpiarAC").disabled = isblock;
    //selector("externo").disabled = isblock
  }

  //Muestra los datos en los campos
  function showDatos(data) {
    console.log(data)
    $q("#razonsocial").value = data.razonsocial;
    $q("#representantelegal").value = data.representantelegal ? data.representantelegal : '';
    $q("#telefono").value = data.telefono;
    $q("#correo").value = data.correo;
    $q("#nacionalidad").value = data.idnacionalidad;
    $q("#departamento").value = data.iddepartamento;
    $q("#provincia").value = data.idprovincia;
    $q("#distrito").value = data.iddistrito;
    $q("#direccion").value = data.direccion;
  }

  //resetea los campos
  function resetUI() {
    $q("#ndocumento").value = '';
    $q("#razonsocial").value = '';
    $q("#representantelegal").value = '';
    $q("#telefono").value = '';
    $q("#correo").value = '';
    $q("#nacionalidad").value = '';
    $q("#departamento").value = '';
    $q("#provincia").value = '';
    $q("#distrito").value = '';
    $q("#direccion").value = '';
    $q("#artista").value = '';
    $q("#fechapresentacion").value = '';
    $q("#horainicio").value = '';
    $q("#horafinal").value = '';
    $q("#establecimiento").value = '';
    $q("#tipoevento").value = '';
    $q("#modalidad").value = '';
    $q("#validez").value = '';
    $q("#nacionalidad2").value = '';
    $q("#departamento2").value = '';
    $q("#provincia2").value = '';
    $q("#distrito2").value = '';
    $q("#igv").value = '';
  }

  /* function validateData() {
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
  } */

  /*  function showDataCliente(data) {
     $q("#razonsocial").value = data.razonSocial;
   } */

  async function validateNumDoc() {
    //Validaciones del num doc, guarda en una variable si es valido o no (boolean)
    const isNumeric = /^[0-9]+$/.test($q("#ndocumento").value.trim());
    const minLength = ($q("#ndocumento").value.trim().length >= 8);
    console.log($q("#ndocumento").value.trim().length)
    const validaNumDoc = $q("#ndocumento").value.trim().length === 8 || $q("#ndocumento").value.trim().length === 11 ? true : false;
    const isRUC = $q("#ndocumento").value.trim().length === 11
    const isDNI = $q("#ndocumento").value.trim().length === 8

    if ($q("#ndocumento").value !== "" && isNumeric && minLength && validaNumDoc) {
      const data = await obtenerClientePorDoc($q("#ndocumento").value);
      const isblock = (data.length > 0); // confirma si la persona ya existe y bloquea los campos 
      bloquearCampos(isblock);

      console.log(isblock);
      console.log(data);


      if (isblock) {
        showToast("El cliente ya existe", "WARNING");
        //$q("#btnEnviar").disabled = true;
        if (data[0].representantelegal) {
          $q("#container-representantelegal").hidden = false
        }
        else {
          $q("#container-representantelegal").hidden = true

        }
        idcliente = data[0].idcliente
        showDatos(data[0]);
        bloquearCampos(false)
      } else {
        if (!isReset) {
          if (isRUC) {
            console.log($q("#ndocumento").value)
            const dataCliente = await obtenerDataClienteRUC()
            $q("#container-representantelegal").hidden = false
            console.log("data cliente sunat: ", dataCliente);
            //showDataCliente(dataCliente)
            $q("#razonsocial").value = dataCliente.razonSocial;
            $q("#direccion").value = dataCliente.direccion
          }
          //resetUI();
          if (isDNI) {
            console.log($q("#ndocumento").value)
            const dataCliente = await obtenerDataClienteDNI()
            console.log("data cliente sunat: ", dataCliente);
            $q("#container-representantelegal").hidden = true
            //showDataCliente(dataCliente)
            $q("#nacionalidad").value = 31 ? 31 : '';
            $q("#razonsocial").value = dataCliente.nombre + " " + dataCliente.apellidoPaterno + " " + dataCliente.apellidoMaterno;
            $q("#direccion").value = dataCliente.direccion;
          }

        }
        $q("#btnGuardarAC").disabled = false;
      }
    }
    else {
      //console.log(isNumeric);
      if ($q("#ndocumento").value === "") { showToast("Escribe un Num de Doc.", "WARNING"); }
      else if (!isNumeric) { showToast("Ingresa solo Numeros", "WARNING"); }
      else if (!minLength) { showToast("El minimo es de 8 caracteres", "WARNING"); }
      else if (!validaNumDoc) { showToast("La cantidad de digitos debe ser de 8 o 20", "WARNING"); }
    }
    //return isValid;
  }

  // ************************************* EVENTOS ************************************* //



  $q("#btnLimpiarAC").addEventListener("click", () => {
    $q("#form-atencion-clientes").reset();
    resetUI()
    bloquearCampos(true);
  })

  /* $q(".btnGuardarConvenio").addEventListener("click", () => {
    const convenio = registrarConvenio(iddetalleevento, 1)
    if (convenio) {
      showToast("Se ha guardado el convenio", "SUCCESS", 1000, 'http://localhost/vega-erp/views/ventas/listar-atencion-cliente');
    }
  }) */
/* 
  $q("#btnGenerarConvenio").addEventListener("click", async () => {
    if (await ask("Confirma la acción")) {
      const convenio = registrarConvenio(iddetalleevento, 2)
      if (convenio) {
        window.location = 'http://localhost/vega-erp/views/ventas/listar-atencion-cliente'
      }
    }
  })
 */

  $q("#search").addEventListener("click", async () => {
    idcliente = -1
    await validateNumDoc();
    

  });


  $q("#form-atencion-clientes").addEventListener("submit", async (e) => {
    e.preventDefault();
    isReset = true;
    await validateNumDoc(); //valida que el numero de caracteres y otras validaciones sean correctas
    //const validateFields = validateData(); //Valida que los campos no esten vacios
    //const validarClaveAcceso = validarClave($q("#claveacceso").value); //valida la clave de acceso

    //const numericTelefono = /^[0-9]+$/.test($q("#telefono1").value); //valida que sean numeros
    //    const unikeUser = await searchNomUser($q("#usuario").value);// valida que el nom usuario sea unico
    //const unikeEmail = await existeCorreo($q("#correo").value);
    //console.log("email encontrado -> ", unikeEmail);
    //const existResp = await existeResponsable(parseInt($q("#area").value)); //valida que no exista un responsable en el area elegida
    //if (parseInt($q("#nivel").value) === 2 && isNaN(parseInt($q("#area").value))) { selectArea = false; }

    //if (unikeEmail.length === 0) {
    //console.log($q("#apellidos").value.toUpperCase());
    //console.log($q("#nombres").value.toUpperCase());

    if (await ask("¿Estas seguro de registrar?")) {

      if (idcliente == -1) {
        //CONVENIO Y CONTRATO CUANDO NO EXISTE AUN EL CLIENTE
        const data = await registrarCliente();
        console.log(data);
        //alert("registrando persona")
        if (data.idcliente > 0) {
          //GENERAR NUMERO RANDOM ALEATORIO DE 9 DIGITOS
          const cotizaciones = await obtenerCotizacionesPorModalidad()
          console.log("cotizaciones -> ", cotizaciones.at(-1))
          const ultimaCotizacion = cotizaciones.at(-1); // Última cotización registrada

          const nuevoNCotizacion = generarNuevoNCotizacion(ultimaCotizacion);
          console.log("Nuevo número de cotización ->", nuevoNCotizacion);
          ncotizacion = nuevoNCotizacion

          if ($q("#modalidad").value == 1) {
            detalleevento = await registrarDetalleEvento(data.idcliente);
            console.log(detalleevento);
          } else if ($q("#modalidad").value == 2) {
            detalleevento = await registrarDetalleEvento(data.idcliente, ncotizacion);
            console.log(detalleevento);
          }

          if (detalleevento.iddetalleevento > 0) {
            window.location = 'http://localhost/vega-erp/views/ventas/listar-atencion-cliente'
          } else {
            showToast("Hubo un error al registrar la atencion", "ERROR");
          }
        } else {
          showToast("Hubo un error al registrar los datos del cliente", "ERROR");
        }
      }
      else {
        // CONVENIO Y CONTRATO CUANDO YA EXISTE EL CLIENTE
        //alert(`REGISTRANDO CON UN CLIENTE YA EXISTENE ${idcliente}`)
        //GENERAR NUMERO RANDOM ALEATORIO DE 9 DIGITOS

        const cotizaciones = await obtenerCotizacionesPorModalidad()
        console.log("cotizaciones -> ", cotizaciones.at(-1))
        const ultimaCotizacion = cotizaciones.at(-1); // Última cotización registrada

        const nuevoNCotizacion = generarNuevoNCotizacion(ultimaCotizacion);
        console.log("Nuevo número de cotización ->", nuevoNCotizacion);
        ncotizacion = nuevoNCotizacion

        if ($q("#modalidad").value == 1) {
          detalleevento = await registrarDetalleEvento(idcliente);
          console.log(detalleevento);
        } else if ($q("#modalidad").value == 2) {
          detalleevento = await registrarDetalleEvento(idcliente, ncotizacion);
          console.log(detalleevento);
        }

        if (detalleevento.iddetalleevento > 0) {
          window.location = 'http://localhost/vega-erp/views/ventas/listar-atencion-cliente'
        } else {
          showToast("Hubo un error al registrar la atencion", "ERROR");
        }
      }
    }
    /* } else {
      let message = "";
      //if (!validateFields) { message = "Completa los campos"; }
      //if (!numericTelefono) { message = "Solo numeros en el Telfono"; }
      //if (!validarClaveAcceso) { message = "el minimo de caracteres para la clave de acceso es de 8"; }
      //if (unikeUser.length > 0) { message = "El nombre de usuario ya existe"; }
      //if (unikeEmail.length > 0) { message = "El correo electronico ya existe"; }
      showToast(message, "ERROR");
    } */

  /*   if ($q("#modalidad").value == 2) {

    } */
  });


  $q("#modalidad").addEventListener("change", function (e) {
    const modalidad = parseInt(e.target.value);
    console.log(modalidad); 3
    if (modalidad === 1) {
      $q("#container-validez").hidden = true
    } else {
      $q("#container-validez").hidden = false
    }
  })

 /*  $q("#btnGenerarCotizacion").addEventListener("click", async (e) => {
    //const tarifaArtista = await obtenerTarifasPorProvincia()
    //    const cotizacion = await obtenerCotizacion(iddetalleevento)
    console.log("clickeando")
    window.open(`http://localhost/vega-erp/generators/generadores_pdf/cotizacion/cotizacion.php?iddetallepresentacion=${iddetalleevento}&idprovincia=${idprovincia}&idusuario=${idartista}&provincia=${provincia}&precio=${2500}`)
    return
  })
 */
  // ************************************* FUNCIONES AUTOMATICAS ************************************* //

  //async function
});