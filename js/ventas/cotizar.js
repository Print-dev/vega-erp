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

  // MODAL
  let modalAgendaFechas

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
    $q("#artista").innerHTML = "<option value='-1'>Selecciona</option>";
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

  async function buscarCliente(ndocumento, telefono, razonsocial) {
    const params = new URLSearchParams();
    params.append("operation", "buscarCliente");
    params.append("ndocumento", ndocumento ? ndocumento : '');
    params.append("telefono", telefono ? telefono : '');
    params.append("razonsocial", razonsocial ? razonsocial : '');
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



  async function obtenerCotizacionesPorModalidad() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerCotizacionesPorModalidad");
    params.append("modalidad", 2);
    const fpersona = await getDatos(`${host}detalleevento.controller.php`, params)
    console.log(fpersona);
    return fpersona
  }

  async function obtenerDpPorFecha(idusuario, fechapresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerDpPorFecha");
    params.append("idusuario", idusuario);
    params.append("fechapresentacion", fechapresentacion);
    const dpfecha = await getDatos(`${host}detalleevento.controller.php`, params)
    console.log(dpfecha);
    return dpfecha
  }

  async function obtenerAgendaArtista(idusuario, iddetalle_presentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerAgendaArtista");
    params.append("idusuario", idusuario ? idusuario : "");
    params.append(
      "iddetallepresentacion",
      iddetalle_presentacion ? iddetalle_presentacion : ""
    );
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
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
    const ndocumento = $q("#ndocumento").value.trim();

    // Determinar el tipo de documento
    let tipodocu = "";
    if (ndocumento.length == 8) {
      tipodocu = 1;
    } else if (ndocumento.length == 11) {
      tipodocu = 2;
    }
    console.log("tipodocu -> ", tipodocu);
    console.log("tipodocu typeof -> ", typeof tipodocu);

    const cliente = new FormData();
    cliente.append("operation", "registrarCliente");
    cliente.append("tipodoc", tipodocu);
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

  async function registrarReparticion(iddetallepresentacion) {
    const reparticion = new FormData();
    reparticion.append("operation", "registrarReparticion");
    reparticion.append("iddetallepresentacion", iddetallepresentacion);

    const freparticion = await fetch(`${host}reparticion.controller.php`, {
        method: "POST",
        body: reparticion,
    });
    const rreparticion = await freparticion.json();
    return rreparticion;
}

  async function registrarDetalleEvento(idcliente, ncotizacion) {
    const horainicio = $q("#horainicio").value.trim();
    const horafinal = $q("#horafinal").value.trim();
    const fechapresentacion = $q("#fechapresentacion").value.trim();
    const iddistrito2 = $q("#distrito2").value.trim();
    const establecimiento = $q("#establecimiento").value.trim();
    const referencia = $q("#referencia").value.trim();
    const tipoevento = $q("#tipoevento").value.trim();
    const modalidad = $q("#modalidad").value.trim();
    const validez = parseInt($q("#validez").value, 10) || 0;

    // Si alguno de los campos clave tiene valor, se activan las validaciones
    if (horainicio || horafinal || iddistrito2 || establecimiento || referencia || tipoevento || modalidad || validez) {
      /* if (!horainicio || !horafinal) {
        showToast("Debe ingresar la hora de inicio y la hora final.", "ERROR");
        return null;
      }

      // Convertir la fecha de presentación a un objeto Date
      const fechaEvento = new Date(fechapresentacion);
      const [horaInicioHoras, horaInicioMinutos] = horainicio.split(":").map(Number);
      const [horaFinalHoras, horaFinalMinutos] = horafinal.split(":").map(Number);

      const fechaInicio = new Date(fechaEvento);
      fechaInicio.setHours(horaInicioHoras, horaInicioMinutos, 0);

      const fechaFinal = new Date(fechaEvento);
      fechaFinal.setHours(horaFinalHoras, horaFinalMinutos, 0);

      if (fechaFinal <= fechaInicio) {
        fechaFinal.setDate(fechaFinal.getDate() + 1);
      }

      if (fechaFinal <= fechaInicio) {
        showToast("La hora final no puede ser menor o igual a la hora de inicio.", "ERROR");
        return null;
      }

      const fechaHoy = new Date();
      const diferenciaDias = Math.floor((fechaEvento - fechaHoy) / (1000 * 60 * 60 * 24));
      if (validez > diferenciaDias) {
        showToast("La validez no puede ser mayor a la cantidad de días restantes hasta la fecha de presentación.", "ERROR");
        return null;
      } */
    }

    // Si pasa las validaciones, proceder con el registro
    const detalle = new FormData();
    detalle.append("operation", "registrarDetallePresentacion");
    detalle.append("idusuario", $q("#artista").value);
    detalle.append("filmmaker", null);
    detalle.append("idcliente", idcliente);
    detalle.append("iddistrito", iddistrito2);
    detalle.append("ncotizacion", ncotizacion || '');
    detalle.append("fechapresentacion", fechapresentacion);
    detalle.append("horainicio", horainicio);
    detalle.append("horafinal", horafinal);
    detalle.append("establecimiento", establecimiento);
    detalle.append("referencia", referencia);
    detalle.append("acuerdo", $q("#acuerdo")?.value || '');
    detalle.append("tipoevento", tipoevento);
    detalle.append("modalidad", modalidad);
    detalle.append("validez", validez || '');
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
    //$q("#razonsocial").disabled = isblock;
    //$q("#telefono").disabled = isblock;
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
    $q("#btnConsultarFecha").disabled = isblock;

    //selector("externo").disabled = isblock
  }

  //Muestra los datos en los campos
  async function showDatos(data) {
    console.log(data)
    $q("#ndocumento").value = data.ndocumento;
    $q("#razonsocial").value = data.razonsocial;
    $q("#representantelegal").value = data.representantelegal ? data.representantelegal : '';
    $q("#telefono").value = data.telefono;
    $q("#correo").value = data.correo;
    $q("#direccion").value = data.direccion;
    if (data.iddistrito) {
      await cargarUbigeoDesdeDistrito(data.iddistrito);
    }
  }

  async function cargarUbigeoDesdeDistrito(idDistrito) {
    try {
      // 1️⃣ Obtener datos del distrito
      let distrito = await fetch(`${host}recurso.controller.php?operation=obtenerDistritoPorId&iddistrito=${idDistrito}`).then(res => res.json());
      console.log("TODAS LAS DISTRTITOS OBTENIDOAS  -> ", distrito)

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
        `<option value="${d.iddistrito}" ${d.iddistrito === idDistrito ? "selected" : ""}>${d.distrito}</option>`
      ).join("");

    } catch (error) {
      console.error("Error cargando ubigeo:", error);
    }
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

  /* async function buscarClienteParams() {
    //Validaciones del num doc, guarda en una variable si es valido o no (boolean)
    const isNumeric = /^[0-9]+$/.test($q("#ndocumento").value.trim());
    const minLength = ($q("#ndocumento").value.trim().length >= 8);
    console.log($q("#ndocumento").value.trim().length)
    const validaNumDoc = $q("#ndocumento").value.trim().length === 8 || $q("#ndocumento").value.trim().length === 11 ? true : false;
    const isRUC = $q("#ndocumento").value.trim().length === 11
    const isDNI = $q("#ndocumento").value.trim().length === 8

    //if ($q("#ndocumento").value !== "" && isNumeric && minLength && validaNumDoc) {
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
            //$q("#nacionalidad").value = 31 ? 31 : '';
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
  } */

  async function buscarClienteParams() {
    // Obtener valores de los inputs
    const ndocumento = $q("#ndocumento").value.trim();
    const telefono = $q("#telefono").value.trim();
    const razonsocial = $q("#razonsocial").value.trim();

    // Validaciones básicas para el número de documento
    const isNumeric = /^[0-9]+$/.test(ndocumento);
    const minLength = ndocumento.length >= 8;
    const validaNumDoc = ndocumento.length === 8 || ndocumento.length === 11;
    const isRUC = ndocumento.length === 11;
    const isDNI = ndocumento.length === 8;

    // 🔎 **Llamar a la función `buscarCliente` con los 3 parámetros**
    const data = await buscarCliente(ndocumento || null, telefono || null, razonsocial || null);

    const isblock = data.length > 0; // Si hay datos, bloquear campos
    bloquearCampos(isblock);

    console.log("Cliente encontrado:", data);

    if (isblock) {
      showToast("El cliente ya existe", "WARNING");

      if (data[0].representantelegal) {
        $q("#container-representantelegal").hidden = false;
      } else {
        $q("#container-representantelegal").hidden = true;
      }

      idcliente = data[0].idcliente;
      showDatos(data[0]);
      bloquearCampos(false);
    } else {
      // Si no existe, intentar buscar en la SUNAT (solo si es nuevo y no se está reseteando)
      if (!isReset) {
        if (isRUC) {
          const dataCliente = await obtenerDataClienteRUC();
          $q("#container-representantelegal").hidden = false;
          $q("#razonsocial").value = dataCliente.razonSocial;
          $q("#direccion").value = dataCliente.direccion;
        }
        if (isDNI) {
          const dataCliente = await obtenerDataClienteDNI();
          $q("#container-representantelegal").hidden = true;
          $q("#razonsocial").value = `${dataCliente.nombre} ${dataCliente.apellidoPaterno} ${dataCliente.apellidoMaterno}`;
          $q("#direccion").value = dataCliente.direccion;
        }
      }
      $q("#btnGuardarAC").disabled = false;
    }
  }




  // ************************************* EVENTOS ************************************* //

  $q("#btnConsultarFecha").addEventListener("click", async () => {
    modalAgendaFechas = new bootstrap.Modal($q("#modal-fechasagenda"))
    modalAgendaFechas.show()
    console.log("artista value -> ", $q("#artista").value)
    const agenda = await obtenerAgendaArtista($q("#artista").value, null)
    console.log("AGENDAAAA-> ", agenda)
    $q(".contenedor-fechasocupadas").innerHTML = ''
    // ACA PRIMERO OBTENER SI LA FECHA SELCCIONADA ES IGUAL A UUNA FECHA YA OCUPADA
    if (agenda.length > 0) {
      agenda.forEach((age, x) => {
        if (age.estadoContrato == 2 || age.estado_convenio == 2) {
          if (age.estado == 1) {
            $q(".contenedor-fechasocupadas").innerHTML += `
          <div class="row mb-3">
              <div class="col-md-6">
                  <strong>Lugar Presentacion N° ${x + 1}</strong>
                  <p id="evento-establecimiento">${age.establecimiento}</p>
              </div>
              <div class="col-md-6">
                  <strong>Fecha:</strong>
                  <p id="evento-referencia">${formatDate(age.fecha_presentacion)}</p>
                  <strong>Hora:</strong>
                  <p id="evento-referencia">${formatHour(age.horainicio)} - ${formatHour(age.horafinal)}</p>
              </div>
              <hr>
          </div>
        `
          }
        }
      });
    } else {
      $q(".contenedor-fechasocupadas").innerHTML = '<strong>Sin fechas proximas</strong>'
    }
  })

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

  /* $q("#search").addEventListener("click", async () => {
    idcliente = -1
    await buscarClienteParams();
  }); */

  $q("#btnBuscarCliente").addEventListener("click", async () => {
    idcliente = -1
    await buscarClienteParams();
  });

  $q("#fechapresentacion").addEventListener("change", async () => {

  })


  $q("#form-atencion-clientes").addEventListener("submit", async (e) => {
    try {
      e.preventDefault();
      isReset = true;
      let permitirRegistrar = false;

      //await buscarClienteParams(); // Validar número de caracteres y otras reglas

      const fechaSeleccionada = $q("#fechapresentacion").value;
      const horaInicioSeleccionada = $q("#horainicio").value;
      const horaFinalSeleccionada = $q("#horafinal").value; // Nueva variable para comparar rangos

      console.log("Artista -> ", $q("#artista").value);
      console.log("Fecha presentación ->", fechaSeleccionada);
      console.log("Hora inicio ->", horaInicioSeleccionada);
      console.log("Hora final ->", horaFinalSeleccionada);

      const fechaOcupada = await obtenerDpPorFecha($q("#artista").value, fechaSeleccionada);
      console.log("Fechas ocupadas recibidas: ", fechaOcupada);

      if (await ask("¿Estás seguro de registrar?")) {
        if (!fechaOcupada || !Array.isArray(fechaOcupada)) {
          showToast("Error: No se obtuvo información de la fecha ocupada.", "ERROR");
          return;
        }

        // 1️⃣ Verificar si hay al menos un evento vencido (estado == 2)
        const hayEventoVencido = fechaOcupada.some(evento => evento.estado === 2);
        console.log("¿Hay eventos vencidos?", hayEventoVencido);

        // 2️⃣ Verificar si hay un evento con la **misma fecha y superposición de horario**
        const horarioSuperpuesto = fechaOcupada.some(evento => {
          return evento.fecha_presentacion === fechaSeleccionada &&
            !(
              horaFinalSeleccionada <= evento.horainicio || // Nuevo evento termina antes del inicio del existente
              horaInicioSeleccionada >= evento.horafinal  // Nuevo evento inicia después de que el existente terminó
            );
        });

        console.log("¿Existe superposición de horarios?", horarioSuperpuesto);

        // ❌ Si hay otro evento en la misma fecha y se superpone en el horario, NO permitir registrar
        if (horarioSuperpuesto) {
          showToast("No se puede registrar el evento: ya existe otro en la misma fecha y horario.", "ERROR");
          return;
        }

        // ✅ Si hay al menos un evento vencido (estado == 2) o no hay conflicto de horarios, permitir registrar
        if (hayEventoVencido || fechaOcupada.length === 0 || !horarioSuperpuesto) {
          permitirRegistrar = true;
        } else {
          showToast("Esta fecha ya está tomada por otro evento.", "ERROR");
          return;
        }
        console.log("idcliente -> ", idcliente);
        if (idcliente == -1) {
          if (permitirRegistrar) {
            console.log("✅ SE PERMITIÓ REGISTRAR: Evento vencido o sin conflicto de horario. Cliente nuevo.");
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
                const repaRegistrado = await registrarReparticion(detalleevento.iddetalleevento)
                console.log("repa registrado -> ", repaRegistrado);
                console.log(detalleevento);
              }else{
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
        } else {
          if (permitirRegistrar) {
            console.log("✅ SE PERMITIÓ REGISTRAR: Evento vencido o sin conflicto de horario. Cliente existente.");
            const cotizaciones = await obtenerCotizacionesPorModalidad()
            console.log("cotizaciones -> ", cotizaciones.at(-1))
            const ultimaCotizacion = cotizaciones.at(-1); // Última cotización registrada

            const nuevoNCotizacion = generarNuevoNCotizacion(ultimaCotizacion);
            console.log("Nuevo número de cotización ->", nuevoNCotizacion);
            ncotizacion = nuevoNCotizacion

            if ($q("#modalidad").value == 1) {
              console.log("idcliente-> en valor 1 ", idcliente);
              detalleevento = await registrarDetalleEvento(idcliente);
              console.log(detalleevento);
            } else if ($q("#modalidad").value == 2) {
              console.log("idcliente-> en valor 2 ", idcliente);
              detalleevento = await registrarDetalleEvento(idcliente, ncotizacion);
              const repaRegistrado = await registrarReparticion(detalleevento.iddetalleevento)
                console.log("repa registrado -> ", repaRegistrado);
              console.log(detalleevento);
            }else if ($q("#modalidad").value == -1){
              console.log("idcliente-> en valor -1 ", idcliente);
              console.log("entrando a cuando no se selecciona ningun valor");
              detalleevento = await registrarDetalleEvento(idcliente, ncotizacion);
              console.log(detalleevento);
            }
            console.log("detalle evento ->>>>>>", detalleevento);
            if (detalleevento.iddetalleevento > 0) {
              window.location = 'http://localhost/vega-erp/views/ventas/listar-atencion-cliente'
            } else {
              showToast("Hubo un error al registrar la atencion", "ERROR");
            }
          }
        }
      }
    } catch (error) {
      console.error("Error capturado:", error);
      showToast("Un error ha ocurrido", "ERROR");
    }
  });



  $q("#modalidad").addEventListener("change", function (e) {
    const modalidad = parseInt(e.target.value);
    console.log(modalidad); 3
    if (modalidad === 1) {
      $q("#container-validez").hidden = true
      $q("#validez").value = null
    } else {
      $q("#container-validez").hidden = false
    }
  })

  
});