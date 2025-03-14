document.addEventListener("DOMContentLoaded", async function () {
  let modalRegistrarCaja;
  let idcajachicaOld = -1;
  let idcajachicaNew = -1;

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
    modalRegistrarCaja = new bootstrap.Modal($q("#modal-registrarcaja"));
    modalRegistrarCaja.show();
  });

  // ***************************************** OBTENER DATOS **********************************************
  const ccfinal = await obtenerUltimaCCFinal();
  const gastos = await obtenerGastosPorCaja(ccfinal[0].idcajachica);
  console.log("ccfinal", ccfinal);
  idcajachicaOld = ccfinal[0].idcajachica;
  $q("#ccinicial").value = ccfinal[0].ccfinal;
  $q("#incremento").value = 0;

  console.log("gastos ->", gastos);
  if (ccfinal[0].estado == 2) {
    $q(".tbody-gastos").innerHTML = "";
  } else {
    $q(".tbody-gastos").innerHTML = "";
    gastos.forEach((gasto) => {
      $q(".tbody-gastos").innerHTML += `
            <tr>
                <td>${gasto.fecha_gasto}</td>
                <td>${gasto.concepto}</td>
                <td>S/. ${gasto.monto}</td>
            </tr>
        `;
    });
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

  // ************************************** EVENTOS *******************************************
  $q("#btnGuardarIncremento").addEventListener("click", async function () {
    const ccinicial = parseFloat($q("#ccinicial").value);
    const incremento = parseFloat($q("#incremento").value) || 0;
    const operacion = $q("#operacionCC").value;

    // Determinar si se suma o se resta según la opción seleccionada
    let ccfinal = operacion === "agregar" ? ccinicial + incremento : ccinicial - incremento;

    if (ccfinal < 0) {
        alert("El monto final no puede ser negativo.");
        return;
    }

    const cajaChicaExiste = await obtenerCajaChicaPorId(idcajachicaOld);
    if (cajaChicaExiste?.length > 0) {
        await actualizarCCfinal(idcajachicaOld, ccfinal);
        $q("#nuevoMonto").innerText = `Nuevo monto S/. ${ccfinal}`;
        return;
    }

    const rcajachica = await registrarCajaChica(ccinicial, incremento, ccfinal);
    console.log("rcajachica -> ", rcajachica);
    idcajachicaOld = rcajachica.idcajachica;
    $q("#nuevoMonto").innerText = `Nuevo monto S/. ${ccfinal}`;
}); // ME QUEDE ACA, YA FUNCIONA EL INCREMENTAR O QUITAR, AHORA AGREGARE UN BOTON PARA QUITAR GASTOS (PENSARLO)

  $q("#btnRegistrarGasto").addEventListener("click", async function () {
    const ccinicial = $q("#ccinicial").value;
    const incremento = $q("#incremento").value;
    const ccfinal = parseInt(ccinicial) + parseInt(incremento);

    const cajaChicaExiste = await obtenerCajaChicaPorId(idcajachicaOld);
    if (cajaChicaExiste?.length > 0) {
      console.log("cajaChicaExiste -> ", cajaChicaExiste);
      const nuevoGasto = await registrarGasto(idcajachicaOld);
      console.log("nuevoGasto ->", nuevoGasto);
      showToast("Gasto registrado correctamente", "SUCCESS");
      return;
    }
    const rcajachica = await registrarCajaChica(ccinicial, incremento, ccfinal); // RGISTRAR CON 0 AL PRINCIPIO Y LUEO SE ACTUALIZARA EN EL CASO DEN CLICK AL btnGenerarCierre

    console.log("rcajachica -> ", rcajachica);
    $q("#nuevoMonto").innerText = ccfinal;

    idcajachicaNew = rcajachica.idcajachica;
    const nuevoGasto = await registrarGasto(idcajachicaNew);
    console.log("nuevoGasto -> ", nuevoGasto);
    if (rcajachica) {
      alert("Caja chica registrada correctamente");
      modalRegistrarCaja.hide();
    } else {
      alert("Error al registrar caja chica");
    }
  });
});
