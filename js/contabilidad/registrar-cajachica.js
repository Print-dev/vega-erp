document.addEventListener("DOMContentLoaded", async function () {
  let modalRegistrarCaja;
  let idcajachicaOld = -1;
  let idcajachicaNew = -1;
  let totalGastos = 0;
  let incrementoActual = 0;
  let ccfinalGlobal = 0;
  let ccfinalMonto = 0;
  let ccinicial = 0;
  let decrementoActual = 0

  let idcajachicaObtenida = window.localStorage.getItem("idcajachica");
  let iddp = window.localStorage.getItem("iddp")

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

  $q("#btnRegistrarNuevoGasto").addEventListener("click", async function () {
    const montoCaja = await obtenerMontoCajaChica();
    console.log("obtenerMontoCajaChica -> ", montoCaja);
    if(parseFloat(montoCaja[0]?.monto) < 10.00){
      showToast("Se recomienda aumentar el monto de la caja chica", "INFO") 
    }
    $q("#concepto").value = "";
    $q("#monto").value = "";
    modalRegistrarCaja = new bootstrap.Modal($q("#modal-registrarcaja"));
    modalRegistrarCaja.show();
  });

  // *********************************** VALIDACION DE INICIO *********************************************
  /* async function verificarOCrearCajaChica() {
    // Obtener la última caja chica con estado 1
    const montoCaja = await obtenerMontoCajaChica()
  console.log("obtenerMontoCajaChica -> ", montoCaja)

    const cajaChicaActiva = await obtenerUltimaCCFinal();
    console.log("caja chica activa -> ", cajaChicaActiva);

    if (cajaChicaActiva?.length > 0 && cajaChicaActiva[0].estado == 1) {
      // Si existe, asignamos su ID e incremento actual
      idcajachicaOld = cajaChicaActiva[0].idcajachica;
      incrementoActual = parseFloat(cajaChicaActiva[0].incremento) || 0;
      ccfinalMonto  = parseFloat(cajaChicaActiva[0].ccfinal) || 0;
      console.log("Caja chica activa encontrada:", idcajachicaOld, "Incremento:", incrementoActual);
    } else {
      // Si no existe, creamos una nueva caja chica
      const ccfinal = await obtenerUltimaCCFinal();
      ccinicial = parseFloat(montoCaja[0].monto)
      const nuevaCaja = await registrarCajaChica(null,1,ccinicial, 0, 0);
      ccfinalMonto = parseFloat(ccfinal[0].ccfinal) || 0;

      if (nuevaCaja?.idcajachica) {
        idcajachicaNew = nuevaCaja.idcajachica;
        incrementoActual = 0; // Nuevo incremento inicia en 0
        console.log("Nueva caja chica creada:", idcajachicaNew);
      } else {
        console.error("Error al crear la caja chica.");
      }
    }
  } */ //TESTEAR ACA SOLO FALTA REVISAR ESTO PQ YA TERMINE EL DE CUANDO YA EXISTE UNA CAJA CHICA, AHORA SOLO FALTA CUANDO RECIEN SE CREA

  //await verificarOCrearCajaChica(); // Ejecutar la validación inicial al cargar la página

  // ***************************************** OBTENER DATOS **********************************************
  const montoCaja = await obtenerMontoCajaChica();
  console.log("obtenerMontoCajaChica -> ", montoCaja);
  //const ccfinal = await obtenerUltimaCCFinal();

  //const gastos = await obtenerGastosPorCaja(ccfinal[0].idcajachica); // cambiar por el variable del idcajachica obtenida desde el localstorage
  console.log("caja chica id existe ->", idcajachicaObtenida);
  const gastos = await obtenerGastosPorCaja(idcajachicaObtenida);
  console.log("gastos otenidos por caja chica -> ", gastos);
  if (idcajachicaObtenida) {
    if (gastos.length > 0 || gastos.length == 0) {
      $q("#ccinicial").innerHTML = `C.C.Inicial: ${montoCaja[0].monto}`;
      ccinicial = parseFloat(montoCaja[0].monto);
      $q("#incremento").value = 0; //me quede acaaaaaaaaaaaaaaaa DONDE TERMINE FUE QUE RENDERIZO SI HAY GASTOS Y PONGO EL MONTO GENERAL EN EL INPUT DE CCINICIAL, Y EN EL CASO DE QUE NO EXISTA ENTONCES REMUEVE EL LOCALSTROAGE Y TODO ESTA VACIO SOLAMENTE SE PONE EL MONTO GENERAL EN EL CCINICIAL, FALTA IMPLEMENTAR DE QUE PUEDA REGISTRAR CUANDO RECIEN SE ABRA UNA NUEVA CAJA Y SE REGISTRE EL CCINICIAL CON EL MONTO GENERAL ACTUAL Q EXISTE;
      $q(".tbody-gastos").innerHTML = "";
      gastos.forEach((gasto) => {
        totalGastos += parseFloat(gasto.monto);
        $q(".tbody-gastos").innerHTML += `
          <tr>
            <td>${gasto.fecha_gasto}</td>
            <td>${gasto.concepto}</td>
            <td>S/. ${parseFloat(gasto.monto).toFixed(2)}</td>
          </tr>
        `;
      });
    }
    $q("#totalGastos").innerText = `S/. ${totalGastos.toFixed(2)}`;
  } else if (montoCaja.length > 0) {
    $q("#ccinicial").innerHTML = `C.C.Inicial: ${montoCaja[0].monto}`;
    ccinicial = parseFloat(montoCaja[0].monto);
    $q("#incremento").value = 0;

    const nuevaCaja = await registrarCajaChica(
      iddp != null ? iddp : null,
      1,
      ccinicial,
      0,
      0,
      0);

    if (nuevaCaja?.idcajachica) {
      idcajachicaNew = nuevaCaja.idcajachica;
      incrementoActual = 0; // Nuevo incremento inicia en 0
      console.log("Nueva caja chica creada:", idcajachicaNew);
    } else {
      console.error("Error al crear la caja chica.");
    }
  }

  async function obtenerMontoCajaChica() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerMontoCajaChica");
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  }

  /* async function obtenerUltimaCCFinal() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUltimaCCFinal");
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  } */


  async function obtenerIncrementoDecrementoPorIdCaja(idcajachica) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerIncrementoDecrementoPorIdCaja");
    params.append("idcajachica", idcajachica);
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  }

  async function obtenerCajaChicaPorId(idcajachica) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerCajaChicaPorId");
    params.append("idcajachica", idcajachica);
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  }

  async function obtenerGastosPorCaja(idcajachica) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerGastosPorCaja");
    params.append("idcajachica", idcajachica);
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  }

  async function obtenerGastoPorId(idgasto) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerGastoPorId");
    params.append("idgasto", idgasto);
    const data = await getDatos(`${host}cajachica.controller.php`, params);
    return data;
  }

  async function actualizarCCfinal(idcajachica, ccfinal) {
    const cajaestado = new FormData();
    cajaestado.append("operation", "actualizarCCfinal");
    cajaestado.append("idcajachica", idcajachica);
    cajaestado.append("ccfinal", ccfinal);

    const fcajaestado = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: cajaestado,
    });
    const rcajaestado = await fcajaestado.json();
    return rcajaestado;
  }

  async function actualizarMontoCajaChica(idmonto, monto) {
    const cajaestado = new FormData();
    cajaestado.append("operation", "actualizarMontoCajaChica");
    cajaestado.append("idmonto", idmonto);
    cajaestado.append("monto", monto);

    const fcajaestado = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: cajaestado,
    });
    const rcajaestado = await fcajaestado.json();
    return rcajaestado;
  }

  // ***************************************** REGISTRAR DATOS ********************************************
  async function registrarCajaChica(
    iddetallepresentacion,
    idmonto,
    ccinicial,
    incremento,
    decremento,
    ccfinal
  ) {
    const cajachica = new FormData();
    cajachica.append("operation", "registrarCajaChica");
    cajachica.append(
      "iddetallepresentacion",
      iddetallepresentacion ? iddetallepresentacion : ""
    );
    cajachica.append("idmonto", idmonto);
    cajachica.append("ccinicial", ccinicial);
    cajachica.append("incremento", incremento); // id artista
    cajachica.append("decremento", decremento); // id artista
    cajachica.append("ccfinal", ccfinal);

    const fcajachica = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: cajachica,
    });
    const rcajachica = await fcajachica.json();
    return rcajachica;
  }

  async function registrarGasto(idcajachica) {
    const gasto = new FormData();
    gasto.append("operation", "registrarGasto");
    gasto.append("idcajachica", idcajachica);
    gasto.append("concepto", $q("#concepto").value); // id artista
    gasto.append("monto", $q("#monto").value);

    const fgasto = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: gasto,
    });
    const rgasto = await fgasto.json();
    return rgasto;
  }

  async function actualizarEstadoCaja(idcajachica, estado) {
    const cajaestado = new FormData();
    cajaestado.append("operation", "actualizarEstadoCaja");
    cajaestado.append("idcajachica", idcajachica);
    cajaestado.append("estado", estado);

    const fcajaestado = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: cajaestado,
    });
    const rcajaestado = await fcajaestado.json();
    return rcajaestado;
  }

  async function actualizarIncremento(idcajachica, incremento) {
    const cajaestado = new FormData();
    cajaestado.append("operation", "actualizarIncremento");
    cajaestado.append("idcajachica", idcajachica);
    cajaestado.append("incremento", incremento);

    const fcajaestado = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: cajaestado,
    });
    const rcajaestado = await fcajaestado.json();
    return rcajaestado;
  }

  async function actualizarDecremento(idcajachica, decremento) {
    const cajaestado = new FormData();
    cajaestado.append("operation", "actualizarDecremento");
    cajaestado.append("idcajachica", idcajachica);
    cajaestado.append("decremento", decremento);

    const fcajaestado = await fetch(`${host}cajachica.controller.php`, {
      method: "POST",
      body: cajaestado,
    });
    const rcajaestado = await fcajaestado.json();
    return rcajaestado;
  }

  // ************************************** EVENTOS *******************************************
  $q("#btnGenerarCierre").addEventListener("click", async function () {
    // Obtener todos los gastos de la caja chica activa
    const montoCaja = await obtenerMontoCajaChica();
    console.log("obtenerMontoCajaChica -> ", montoCaja);

    const idcajachicaUsada =
      idcajachicaObtenida != null ? idcajachicaObtenida : idcajachicaNew;
    const listaGastos = await obtenerGastosPorCaja(idcajachicaUsada);
    console.log("listaGastos -> ", listaGastos);
    // Sumar el total de los gastos
    let totalGastos = listaGastos.reduce(
      (sum, gasto) => sum + parseFloat(gasto.monto),
      0
    );

    // Obtener el monto inicial actualizado
    let montoInicial = montoCaja[0]?.monto ? montoCaja[0]?.monto : ccfinalMonto;
    console.log("Monto inicial al generar cierre -> ", montoInicial);
    console.log("Total gastos al generar cierre -> ", totalGastos);

    // Validar si los gastos superan el monto inicial
    /* if (totalGastos > montoInicial) {
      showToast("El total de gastos supera al monto inicial.", "ERROR");
      return;
    } */

    // Calcular el nuevo monto final
    let nuevoMontoFinal = montoInicial - totalGastos;
    console.log("Nuevo monto final al generar cierre -> ", nuevoMontoFinal);

    // Actualizar el monto final en la BD
    await actualizarCCfinal(idcajachicaUsada, nuevoMontoFinal);
    const montoCajaActualizado = await actualizarMontoCajaChica(
      1,
      nuevoMontoFinal
    );
    console.log("montoCajaActualizado -> ", montoCajaActualizado);
    // Cerrar la caja chica (estado = 2)
    const cajaCerrada = await actualizarEstadoCaja(idcajachicaUsada, 2);
    if (cajaCerrada) {
      showToast(
        "Caja chica cerrada correctamente",
        "SUCCESS",
        2000,
        `${host}/views/contabilidad/caja-chica/caja-chica`
      );
    } else {
      showToast("Error al cerrar la caja chica", "ERROR");
    }
  });

  // PRIMERO VER ESTO
  /* $q("#btnGuardarIncremento").addEventListener("click", async function () {
    const incremento = parseFloat($q("#incremento").value) || 0;
    const operacion = $q("#operacionCC").value;

    // Validaciones
    if (isNaN(ccinicial) || ccinicial < 0) {
      alert("El monto inicial debe ser un número válido y mayor o igual a 0.");
      return;
    }

    if (isNaN(incremento) || incremento <= 0) {
      alert("El incremento debe ser un número válido y mayor a 0.");
      return;
    }

    // Determinar si se suma o se resta según la opción seleccionada
    ccfinalGlobal =
      operacion === "agregar" ? ccinicial + incremento : ccinicial - incremento;
    if (ccfinalGlobal < 0) {
      showToast("El monto final no puede ser negativo.", "ERROR");
      return;
    }

    // Calcular el nuevo incremento total
    let nuevoIncremento =
  operacion === "agregar"
    ? incrementoActual + incremento
    : incrementoActual - incremento;

    console.log("nuevoIncremento -> ", nuevoIncremento);

    if (nuevoIncremento < 0) {
      showToast("El incremento no puede ser negativo.", "ERROR");
      return;
    }

    console.log("ccfinalGlobal despues del calculo: ", ccfinalGlobal);
    // Verificar si existe una caja chica activa
    const cajaChicaExiste = await obtenerCajaChicaPorId(
      idcajachicaObtenida || idcajachicaNew
    );
    console.log("cajaChicaExiste -> ", cajaChicaExiste);
    if (cajaChicaExiste?.length > 0) {
      console.log("entrrando");
      const incrementoAct = await actualizarIncremento(
        idcajachicaObtenida || idcajachicaNew,
        nuevoIncremento
      ); // Actualizar el incremento
      console.log("incremento actualizado : ", incrementoAct);
      console.log("ccfinalGlobal -> ", ccfinalGlobal);
      const montoFinalActualizado = await actualizarCCfinal(
        idcajachicaObtenida || idcajachicaNew,
        ccfinalGlobal
      );
      console.log("monto final actualizado : ", montoFinalActualizado);
      const montoCajaActualizado = await actualizarMontoCajaChica(
        1,
        ccfinalGlobal
      );
      console.log("montoCajaActualizado -> ", montoCajaActualizado);
      incrementoActual = nuevoIncremento; // Guardar el nuevo incremento globalmente
      console.log("incrementoActual -> ", incrementoActual);
      $q("#nuevoMonto").innerText = `Nuevo monto S/. ${parseFloat(
        ccfinalGlobal.toFixed(2)
      )}`;
      return;
    }
  }); */

  $q("#btnGuardarIncremento").addEventListener("click", async function () {
    // Obtener el incremento y decremento actual desde la BD
    const incrementoDecremento = await obtenerIncrementoDecrementoPorIdCaja(idcajachicaObtenida || idcajachicaNew);
    console.log("incrementoDecremento -> ", incrementoDecremento);

    // Extraer valores actuales de incremento y decremento
    let incrementoActual = incrementoDecremento[0]?.incremento || 0;
    let decrementoActual = incrementoDecremento[0]?.decremento || 0;

    // Obtener el valor ingresado por el usuario
    const incremento = parseFloat($q("#incremento").value) || 0;
    const operacion = $q("#operacionCC").value; // "agregar" o "quitar"

    // Validaciones
    if (isNaN(incremento) || incremento <= 0) {
      alert("El monto ingresado debe ser un número válido y mayor a 0.");
      return;
    }

    // Calcular el nuevo monto según la operación
    let nuevoIncremento = incrementoActual;
    let nuevoDecremento = decrementoActual;
    let ccfinalGlobal;

    if (operacion === "agregar") {
      nuevoIncremento += incremento; // Sumar al incremento existente
      ccfinalGlobal = ccinicial + incremento;
    } else if (operacion === "quitar") {
      nuevoDecremento += incremento; // Sumar al decremento existente
      ccfinalGlobal = ccinicial - incremento;
    }

    if (ccfinalGlobal < 0) {
      showToast("El monto final no puede ser negativo.", "ERROR");
      return;
    }

    console.log("Nuevo incremento: ", nuevoIncremento);
    console.log("Nuevo decremento: ", nuevoDecremento);
    console.log("ccfinalGlobal después del cálculo: ", ccfinalGlobal);

    // Verificar si la caja chica existe
    const cajaChicaExiste = await obtenerCajaChicaPorId(idcajachicaObtenida || idcajachicaNew);
    console.log("cajaChicaExiste -> ", cajaChicaExiste);

    if (cajaChicaExiste?.length > 0) {
      console.log("Actualizando valores...");

      if (operacion === "agregar") {
        const incrementoAct = await actualizarIncremento(idcajachicaObtenida || idcajachicaNew, nuevoIncremento);
        console.log("Incremento actualizado: ", incrementoAct);
      } else if (operacion === "quitar") {
        const decrementoAct = await actualizarDecremento(idcajachicaObtenida || idcajachicaNew, nuevoDecremento);
        console.log("Decremento actualizado: ", decrementoAct);
      }

      // Actualizar el monto final
      const montoFinalActualizado = await actualizarCCfinal(idcajachicaObtenida || idcajachicaNew, ccfinalGlobal);
      console.log("Monto final actualizado: ", montoFinalActualizado);

      // Actualizar el monto en caja chica
      const montoCajaActualizado = await actualizarMontoCajaChica(1, ccfinalGlobal);
      console.log("Monto en caja chica actualizado: ", montoCajaActualizado);

      $q("#nuevoMonto").innerText = `Nuevo monto S/. ${parseFloat(ccfinalGlobal.toFixed(2))}`;
    }
  });
  // verificar esta nueva funcion, supuestamente hace de que se actualize tanto el incfrdmento como el decremento y tambien actualiza de acuerdo a eso el monto Caja chica


  $q("#btnRegistrarGasto").addEventListener("click", async function () {
    // Obtener valores de los inputs
    const concepto = $q("#concepto").value.trim();
    const monto = parseFloat($q("#monto").value);

    // Validaciones de campos
    /* if (isNaN(ccinicial) || ccinicial < 0) {
      showToast(
        "El monto inicial debe ser un número válido y mayor o igual a 0.",
        "ERROR"
      );
      return;
    } */

    if (concepto === "") {
      showToast("El concepto del gasto no puede estar vacío.", "ERROR");
      return;
    }

    if (isNaN(monto) || monto <= 0) {
      showToast(
        "El monto del gasto debe ser un número válido y mayor a 0.",
        "ERROR"
      );
      return;
    }

    // Determinar cuál ID de caja chica usar
    const idcajachicaUsada = idcajachicaObtenida != null ? idcajachicaObtenida : idcajachicaNew;
    console.log("idcajachicaObtenida -> ", idcajachicaObtenida);
    console.log("idcajachicaNew -> ", idcajachicaNew);
    console.log("idcajachicaUsada -> ", idcajachicaUsada);
    console.log("concepto -> ", concepto);
    console.log("monto -> ", monto);
    // Registrar el gasto en la caja activa
    const nuevoGasto = await registrarGasto(idcajachicaUsada, concepto, monto);
    console.log("nuevoGasto ->", nuevoGasto);
    if (!nuevoGasto || !nuevoGasto.idgasto) {
      showToast("Error al registrar gasto.", "ERROR");
      return;
    }

    // Obtener los datos del gasto recién agregado
    const gastoObtenido = await obtenerGastoPorId(nuevoGasto.idgasto);
    if (!gastoObtenido || gastoObtenido.length === 0) {
      showToast("Error al obtener gasto registrado.", "ERROR");
      return;
    }

    // Actualizar el total de gastos
    totalGastos += parseFloat(gastoObtenido[0].monto);
    $q("#totalGastos").innerText = `S/. ${totalGastos.toFixed(2)}`;

    // Agregar el gasto a la tabla
    $q(".tbody-gastos").innerHTML += `
      <tr>
        <td>${gastoObtenido[0]?.fecha_gasto}</td>
        <td>${gastoObtenido[0]?.concepto}</td>
        <td>S/. ${parseFloat(gastoObtenido[0]?.monto).toFixed(2)}</td>
      </tr>
    `;

    showToast("Gasto registrado correctamente", "SUCCESS");
    modalRegistrarCaja.hide();
  });
});
