document.addEventListener("DOMContentLoaded", async function() {
    let modalRegistrarCaja
    let idcajachicaOld = -1
    let idcajachicaNew = -1


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

    $q("#btnRegistrarNuevoGasto").addEventListener("click", function() {
        modalRegistrarCaja =  new bootstrap.Modal($q("#modal-registrarcaja"));
        modalRegistrarCaja.show()
    })

    // ***************************************** OBTENER DATOS **********************************************
    const ccfinal = await obtenerUltimaCCFinal()
    console.log("ccfinal", ccfinal)
    idcajachicaOld = ccfinal[0].idcajachica
    $q("#ccinicial").value = ccfinal[0].ccfinal
    $q("#incremento").value = 0
    

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
    // ***************************************** REGISTRAR DATOS ********************************************
    async function registrarCajaChica(ccinicial, incremento, ccfinal) {
 
      const cajachica = new FormData();
      cajachica.append("operation", "registrarCajaChica");
      cajachica.append("ccinicial", ccinicial);
      cajachica.append("incremento", incremento); // id artista
      cajachica.append("ccfinal", ccfinal)
  
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
      gasto.append("monto", $q("#monto").value)
  
      const fgasto = await fetch(`${host}cajachica.controller.php`, {
        method: "POST",
        body: gasto,
      });
      const rgasto = await fgasto.json();
      return rgasto;
    }

    // ************************************** EVENTOS *******************************************

    $q("#btnRegistrarGasto").addEventListener("click", async function() {
        const ccinicial = $q("#ccinicial").value
        const incremento = $q("#incremento").value
        
        const cajaChicaExiste = await obtenerCajaChicaPorId (idcajachicaNew)
        if(cajaChicaExiste?.length > 0){
          const nuevoGasto = await registrarGasto(idcajachicaNew)
          console.log("nuevoGasto ->",  nuevoGasto)
          alert("Gasto registrado correctamente")
          return
        }
        const rcajachica = await registrarCajaChica(ccinicial, incremento, 0) // RGISTRAR CON 0 AL PRINCIPIO Y LUEO SE ACTUALIZARA EN EL CASO DEN CLICK AL btnGenerarCierre
        console.log("rcajachica -> ", rcajachica)
        idcajachicaNew = rcajachica.idcajachica
        const nuevoGasto = await registrarGasto(idcajachicaNew)
        console.log("nuevoGasto -> ", nuevoGasto)
        if(rcajachica) {
            alert("Caja chica registrada correctamente")
            modalRegistrarCaja.hide()
        } else {
            alert("Error al registrar caja chica")
        }
    })
})