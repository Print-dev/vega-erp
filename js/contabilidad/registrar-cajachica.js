document.addEventListener("DOMContentLoaded", async function () {
  let modalRegistrarCaja;
  let idcajachicaOld = -1;
  let idcajachicaNew = -1;
  let totalGastos = 0;
  let incrementoActual = 0;
  let ccfinalGlobal = 0;
  let ccfinalMonto = 0


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

  $q("#btnRegistrarNuevoGasto").addEventListener("click", function () {
    $q("#concepto").value = "";
    $q("#monto").value = "";
    modalRegistrarCaja = new bootstrap.Modal($q("#modal-registrarcaja"));
    modalRegistrarCaja.show();
  });

  // *********************************** VALIDACION DE INICIO *********************************************
  async function verificarOCrearCajaChica() {
    // Obtener la última caja chica con estado 1
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
      const ccinicial = ccfinal.length > 0 ? parseFloat(ccfinal[0].ccfinal) : 0;
      const nuevaCaja = await registrarCajaChica(ccinicial, 0, ccinicial);
      ccfinalMonto = parseFloat(ccfinal[0].ccfinal) || 0;

      if (nuevaCaja?.idcajachica) {
        idcajachicaNew = nuevaCaja.idcajachica;
        incrementoActual = 0; // Nuevo incremento inicia en 0
        console.log("Nueva caja chica creada:", idcajachicaNew);
      } else {
        console.error("Error al crear la caja chica.");
      }
    }
  }

  await verificarOCrearCajaChica(); // Ejecutar la validación inicial al cargar la página

  // ***************************************** OBTENER DATOS **********************************************
  const ccfinal = await obtenerUltimaCCFinal();
  if (ccfinal.length > 0) {
    $q("#ccinicial").value = ccfinal[0].ccfinal;
    $q("#incremento").value = 0;

    const gastos = await obtenerGastosPorCaja(ccfinal[0].idcajachica);
    if (ccfinal[0].estado == 2) {
      $q(".tbody-gastos").innerHTML = "";
    } else {
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
  }




  async function obtenerUltimaCCFinal() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerUltimaCCFinal");
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


  // ***************************************** REGISTRAR DATOS ********************************************
  async function registrarCajaChica(ccinicial, incremento, ccfinal) {
    const cajachica = new FormData();
    cajachica.append("operation", "registrarCajaChica");
    cajachica.append("ccinicial", ccinicial);
    cajachica.append("incremento", incremento); // id artista
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

  // ************************************** EVENTOS *******************************************
  $q("#btnGenerarCierre").addEventListener("click", async function () {
    // Obtener todos los gastos de la caja chica activa
    const idcajachicaUsada = idcajachicaOld !== -1 ? idcajachicaOld : idcajachicaNew;
    const listaGastos = await obtenerGastosPorCaja(idcajachicaUsada);

    // Sumar el total de los gastos
    let totalGastos = listaGastos.reduce((sum, gasto) => sum + parseFloat(gasto.monto), 0);

    // Obtener el monto inicial actualizado
    let montoInicial = ccfinalGlobal ? ccfinalGlobal : ccfinalMonto;
    console.log("Monto inicial al generar cierre -> ", montoInicial);
    console.log("Total gastos al generar cierre -> ", totalGastos);

    // Validar si los gastos superan el monto inicial
    if (totalGastos > montoInicial) {
      showToast("El total de gastos supera al monto inicial.", "ERROR");
      return;
    }

    // Calcular el nuevo monto final
    let nuevoMontoFinal = montoInicial - totalGastos;
    console.log("Nuevo monto final al generar cierre -> ", nuevoMontoFinal);

    // Actualizar el monto final en la BD
    await actualizarCCfinal(idcajachicaUsada, nuevoMontoFinal);

    // Cerrar la caja chica (estado = 2)
    const cajaCerrada = await actualizarEstadoCaja(idcajachicaUsada, 2);
    if (cajaCerrada) {
      showToast("Caja chica cerrada correctamente", "SUCCESS", 2000, 'http://localhost/vega-erp/views/contabilidad/caja-chica/caja-chica');
    } else {
      showToast("Error al cerrar la caja chica", "ERROR");
    }
});


  $q("#btnGuardarIncremento").addEventListener("click", async function () {
    const ccinicial = parseFloat($q("#ccinicial").value);
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
    ccfinalGlobal = operacion === "agregar" ? ccinicial + incremento : ccinicial - incremento;
    if (ccfinalGlobal < 0) {
      showToast("El monto final no puede ser negativo.", "ERROR");
      return;
    }

    // Calcular el nuevo incremento total
    let nuevoIncremento = operacion === "agregar" 
    ? incrementoActual + incremento 
    : Math.max(incrementoActual - incremento, 0);    console.log("nuevoIncremento -> ", nuevoIncremento)
    if (nuevoIncremento < 0) {
      showToast("El incremento no puede ser negativo.", "ERROR");
      return;
    }

    // Verificar si existe una caja chica activa
    const cajaChicaExiste = await obtenerCajaChicaPorId(idcajachicaOld);
    console.log("cajaChicaExiste -> ",cajaChicaExiste)
    if (cajaChicaExiste?.length > 0) {
      console.log("entrrando")
      const incrementoAct = await actualizarIncremento(idcajachicaOld, nuevoIncremento); // Actualizar el incremento
      console.log("incremento actualizado : ", incrementoAct)
      console.log("ccfinalGlobal -> ", ccfinalGlobal)
      const montoFinalActualizado = await actualizarCCfinal(idcajachicaOld, ccfinalGlobal);
      console.log("monto final actualizado : ", montoFinalActualizado)

      incrementoActual = nuevoIncremento; // Guardar el nuevo incremento globalmente
      $q("#nuevoMonto").innerText = `Nuevo monto S/. ${parseFloat(ccfinalGlobal.toFixed(2))}`;
      return;
    }
  });

  $q("#btnRegistrarGasto").addEventListener("click", async function () {
    // Obtener valores de los inputs
    const ccinicial = parseFloat($q("#ccinicial").value);
    const concepto = $q("#concepto").value.trim();
    const monto = parseFloat($q("#monto").value);

    // Validaciones de campos
    if (isNaN(ccinicial) || ccinicial < 0) {
      showToast("El monto inicial debe ser un número válido y mayor o igual a 0.", "ERROR");
      return;
    }


    if (concepto === "") {
      showToast("El concepto del gasto no puede estar vacío.", "ERROR");
      return;
    }

    if (isNaN(monto) || monto <= 0) {
      showToast("El monto del gasto debe ser un número válido y mayor a 0.", "ERROR");
      return;
    }

    // Determinar cuál ID de caja chica usar
    const idcajachicaUsada = idcajachicaOld !== -1 ? idcajachicaOld : idcajachicaNew;

    // Registrar el gasto en la caja activa
    const nuevoGasto = await registrarGasto(idcajachicaUsada, concepto, monto);
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
