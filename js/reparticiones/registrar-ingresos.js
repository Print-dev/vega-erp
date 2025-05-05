document.addEventListener("DOMContentLoaded", async () => {
  // VARIABLES GLOBALES
  let iddp = window.localStorage.getItem("iddp");
  let idreparticion = window.localStorage.getItem("idreparticion")
  let porcentajeVega = 0;
  let porcentajePromotor = 0;
  let totalIngresos = 0

  // MODALES
  let modalIngreso

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

  async function obtenerIngresoPorId(idingreso) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerIngresoPorId");
    params.append("idingreso", idingreso);
    const data = await getDatos(`${host}reparticion.controller.php`, params);
    return data;
  }

  async function obtenerIngresoPorIdReparticion(idreparticion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerIngresoPorIdReparticion");
    params.append("idreparticion", idreparticion);
    const data = await getDatos(`${host}reparticion.controller.php`, params);
    return data;
  }


  const ingresos = await obtenerIngresoPorIdReparticion(idreparticion)
  console.log("ingresos -> ", ingresos);
  if (ingresos.length > 0) {
    $q(".tbody-ingresos").innerHTML = "";
    ingresos.forEach((ingreso) => {
      totalIngresos += parseFloat(ingreso.monto);
      $q(".tbody-ingresos").innerHTML += `
        <tr>
          <td>${ingreso.tipopago == 1 ? "Transferencia" : 'Contado'}</td>
          <td>${ingreso.medio}</td>
          <td>${ingreso.noperacion != null ? ingreso.noperacion : 'No aplica'}</td>
          <td>${ingreso.descripcion}</td>
          <td>S/. ${parseFloat(ingreso.monto).toFixed(2)}</td>
        </tr>
      `;
    });
  }
  $q("#totalIngresos").innerText = `S/. ${totalIngresos.toFixed(2)}`;

  /*   async function obtenerConvenioPorId(idconvenio) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerConvenioPorId");
    params.append("idconvenio", idconvenio);
    const data = await getDatos(`${host}convenio.controller.php`, params);
    return data;
  } */

  /*   async function obtenerConvenioPorIdDP(iddetallepresentacion) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerConvenioPorIdDP");
    params.append("iddetallepresentacion", iddetallepresentacion);
    const data = await getDatos(`${host}convenio.controller.php`, params);
    const convenioPropuesta = await obtenerConvenioPorId(data[0].idconvenio)
    return convenioPropuesta;
  }
 */
  /*   const convenioPropuesta = await obtenerConvenioPorIdDP(iddp)
  console.log("convenio propuesta -> ", convenioPropuesta);
  porcentajeVega = convenioPropuesta[0]?.porcentaje_vega
  porcentajePromotor = convenioPropuesta[0]?.porcentaje_promotor */

  // ************************************* REGISTROS DATOS ***************************************************

  async function registrarIngreso(
    idreparticion,
  ) {
    const ingreso = new FormData();
    ingreso.append("operation", "registrarIngreso");
    ingreso.append(
      "idreparticion",
      idreparticion ? idreparticion : ""
    );
    ingreso.append("descripcion", $q("#descripcion").value);
    ingreso.append("monto", $q("#monto").value);
    ingreso.append("tipopago", $q("#tipopago").value); // id artista
    ingreso.append("noperacion", $q("#noperacion").value ? $q("#noperacion").value : ''); // id artista
    ingreso.append("medio", $q("#medio").value ? $q("#medio").value : ''); // id artista

    const fingreso = await fetch(`${host}reparticion.controller.php`, {
      method: "POST",
      body: ingreso,
    });
    const ringreso = await fingreso.json();
    return ringreso;
  }

  // ************************************* EVENTOS ***********************************

  $q("#btnRegistrarNuevoIngreso").addEventListener("click", () => {
    $q("#descripcion").value = ''
    $q("#monto").value = ''
    $q("#tipopago").value = ''
    $q("#noperacion").value = ''
    $q("#medio").value = ''
    modalIngreso = new bootstrap.Modal($q("#modal-ingreso"))
    modalIngreso.show()
  })

  $q("#btnRegistrarIngreso").addEventListener("click", async () => {
    const descripcion = $q("#descripcion").value.trim();
    const monto = parseFloat($q("#monto").value);
    const tipopago = $q("#tipopago").value; // Obtiene el valor del select

    // Validaciones de campos
    if (descripcion === "") {
      showToast("La descripción del ingreso no puede estar vacía.", "ERROR");
      return;
    }

    if (isNaN(monto) || monto <= 0) {
      showToast("El monto del ingreso debe ser un número válido y mayor a 0.", "ERROR");
      return;
    }

    if (tipopago === "" || isNaN(parseInt(tipopago))) {
      showToast("Elija una opción de pago válida.", "ERROR");
      return;
    }

    // Convertir a número para asegurar validación correcta
    const tipoPagoInt = parseInt(tipopago);

    // Validar que el tipo de pago sea 1 o 2
    if (![1, 2].includes(tipoPagoInt)) {
      showToast("Opción de pago inválida.", "ERROR");
      return;
    }

    // Llamada a la función de registro
    const ingresoRegistrado = await registrarIngreso(idreparticion);
    if (!ingresoRegistrado || !ingresoRegistrado.idingreso) {
      showToast("Error al registrar el ingreso.", "ERROR");
      return;
    }

    // Obtener los datos del ingreso recién agregado
    const ingresoObtenido = await obtenerIngresoPorId(ingresoRegistrado.idingreso);
    if (!ingresoObtenido || ingresoObtenido.length === 0) {
      showToast("Error al obtener ingreso registrado.", "ERROR");
      return;
    }

    // Actualizar el total de ingresos
    totalIngresos += parseFloat(ingresoObtenido[0]?.monto);
    $q("#totalIngresos").innerText = `S/. ${totalIngresos.toFixed(2)}`;

    // Agregar el ingreso a la tabla
    $q(".tbody-ingresos").innerHTML += `
        <tr>
          <td>${ingresoObtenido[0]?.tipopago == 1 ? "Transferencia" : 'Contado'}</td>
          <td>${ingresoObtenido[0]?.medio}</td>
          <td>${ingresoObtenido[0]?.noperacion != null ? ingresoObtenido[0]?.noperacion : 'No aplica'}</td>
          <td>${ingresoObtenido[0]?.descripcion}</td>
          <td>S/. ${parseFloat(ingresoObtenido[0]?.monto).toFixed(2)}</td>
        </tr>
    `;

    showToast("Ingreso registrado correctamente", "SUCCESS");
    modalIngreso.hide();
  });

});
