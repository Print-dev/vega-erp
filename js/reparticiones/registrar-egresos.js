document.addEventListener("DOMContentLoaded", async () => {
    // VARIABLES GLOBALES
    let iddp = window.localStorage.getItem("iddp");
    let idreparticion = window.localStorage.getItem("idreparticion")
    let porcentajeVega = 0;
    let porcentajePromotor = 0;
    let totalEgresos = 0
  
    // MODALES
    let modalEgreso
  
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
  
    async function obtenerEgresoPorId(idegreso) { /// modificar
      const params = new URLSearchParams();
      params.append("operation", "obtenerEgresoPorId");
      params.append("idegreso", idegreso);
      const data = await getDatos(`${host}reparticion.controller.php`, params);
      return data;
    }
  
    async function obtenerEgresoPorIdReparticion(idreparticion) { // modificar
      const params = new URLSearchParams();
      params.append("operation", "obtenerEgresoPorIdReparticion");
      params.append("idreparticion", idreparticion);
      const data = await getDatos(`${host}reparticion.controller.php`, params);
      return data;
    }
  
    const egresos = await obtenerEgresoPorIdReparticion(idreparticion)
    console.log("egresos -> ", egresos);
    if(egresos.length > 0){ 
      $q(".tbody-egresos").innerHTML = "";
      egresos.forEach((egreso) => {
        totalEgresos += parseFloat(egreso.monto);
        $q(".tbody-egresos").innerHTML += `
          <tr>
            <td>${egreso.tipopago == 1 ? "Transferencia" : 'Contado'}</td>
            <td>${egreso.noperacion != null ? egreso.noperacion : 'No aplica'}</td>
            <td>${egreso.descripcion}</td>
            <td>S/. ${parseFloat(egreso.monto).toFixed(2)}</td>
          </tr>
        `;
      });
    }
    $q("#totalEgresos").innerText = `S/. ${totalEgresos.toFixed(2)}`;
  
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
  
    async function registrarEgreso(
      idreparticion,
    ) {
      const egreso = new FormData();
      egreso.append("operation", "registrarEgreso");
      egreso.append(
        "idreparticion",
        idreparticion ? idreparticion : ""
      );
      egreso.append("descripcion", $q("#descripcion").value);
      egreso.append("monto", $q("#monto").value);
      egreso.append("tipopago", $q("#tipopago").value); // id artista
      egreso.append("noperacion", $q("#noperacion").value ? $q("#noperacion").value : ''); // id artista
  
      const fegreso = await fetch(`${host}reparticion.controller.php`, {
        method: "POST",
        body: egreso,
      });
      const regreso = await fegreso.json();
      return regreso;
    }
  
    // ************************************* EVENTOS ***********************************
  
    $q("#btnRegistrarNuevoEgreso").addEventListener("click", ()=>{
      $q("#descripcion").value = ''
      $q("#monto").value = ''
      $q("#tipopago").value = ''
      $q("#noperacion").value = ''
      modalEgreso = new bootstrap.Modal($q("#modal-egreso"))
      modalEgreso.show()
    })
  
    $q("#btnRegistrarEgreso").addEventListener("click", async () => {
      const descripcion = $q("#descripcion").value.trim();
      const monto = parseFloat($q("#monto").value);
      const tipopago = $q("#tipopago").value; // Obtiene el valor del select
  
      // Validaciones de campos
      if (descripcion === "") {
          showToast("La descripción del egreso no puede estar vacía.", "ERROR");
          return;
      }
  
      if (isNaN(monto) || monto <= 0) {
          showToast("El monto del egreso debe ser un número válido y mayor a 0.", "ERROR");
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
      const egresoRegistrado = await registrarEgreso(idreparticion);
      console.log("egreso registrado -> ", egresoRegistrado);
      if (!egresoRegistrado || !egresoRegistrado.idegreso) {
          showToast("Error al registrar el egreso.", "ERROR");
          return;
      }
  
      // Obtener los datos del egreso recién agregado
      const egresoObtenido = await obtenerEgresoPorId(egresoRegistrado.idegreso);
      console.log("egresoObtenido -> ", egresoObtenido);
      if (!egresoObtenido || egresoObtenido.length === 0) {
          showToast("Error al obtener egreso registrado.", "ERROR");
          return;
      }
  
      // Actualizar el total de egresos
      totalEgresos += parseFloat(egresoObtenido[0]?.monto);
      $q("#totalEgresos").innerText = `S/. ${totalEgresos.toFixed(2)}`;
  
      // Agregar el egreso a la tabla
      $q(".tbody-egresos").innerHTML += `
          <tr>
            <td>${egresoObtenido[0]?.tipopago == 1 ? "Transferencia" : 'Contado'}</td>
            <td>${egresoObtenido[0]?.noperacion != null ? egresoObtenido[0]?.noperacion : 'No aplica'}</td>
            <td>${egresoObtenido[0]?.descripcion}</td>
            <td>S/. ${parseFloat(egresoObtenido[0]?.monto).toFixed(2)}</td>
          </tr>
      `;
  
      showToast("Egreso registrado correctamente", "SUCCESS");
      modalEgreso.hide();
    });
  
  });
  