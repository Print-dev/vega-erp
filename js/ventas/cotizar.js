document.addEventListener('DOMContentLoaded', function() {
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

    $q("#btnGuardarAC").addEventListener("click", async function() {
        /* let id_producto = $q("#id_producto").value;
        let cantidad = $q("#cantidad").value; */
        let modalCotizacion = new bootstrap.Modal($q("#modal-previacotizacion"));
        modalCotizacion.show();

    });

    $q("#btnGenerarCotizacion").addEventListener("click", async ()=> {
        alert("generando pdf...")
    })

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

      async function obtenerDataClienteRUC() {
        const Fdata = await fetch(`https://app.minam.gob.pe/TransparenciaWSREST/tramites/transparencia/sunat?ruc=${$q("#ndocumento").value}`)
        const data = await Fdata.json()
        return data.data
      }

      async function obtenerClientePorDoc(ndocumento) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerClientePorDoc");
        params.append("num_doc", ndocumento);
        const fpersona = await getDatos(`${host}cliente.controller.php`, params)
        console.log(fpersona);
        return fpersona
      }
    
      // ****************************** LLENAR COMBOS ****************************** //

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
        cliente.append("iddistrito", $q("#iddistrito").value);
        cliente.append("ndocumento", $q("#ndocumento").value);
        cliente.append("razonsocial", $q("#razonsocial").value);
        cliente.append("telefono", $q("#telefono").value);
        cliente.append("correo", $q("#correo").value);
        cliente.append("direccion", $q("#direccion").value);        
    
        const fcliente = await fetch(`${host}cliente.controller.php`, {
          method: "POST",
          body: cliente,
        });
        const rcliente = await fcliente.json();
        return rcliente;
      }

      async function registrarDetalleEvento(idcliente) {
        const detalle = new FormData();
        detalle.append("operation", "registrarDetalleEvento");
        detalle.append("idusuario", $q("#artista").value); // id artista
        detalle.append("idcliente", idcliente);
        detalle.append("fechapresentacion", $q("#fechapresentacion").value);
        detalle.append("horapresentacion", $q("#horapresentacion").value);
        detalle.append("tiempopresentacion", $q("#tiempopresentacion").value);
        detalle.append("establecimiento", $q("#establecimiento").value);        
        detalle.append("tipoevento", $q("#tipoevento").value);        
        detalle.append("modalidad", $q("#modalidad").value);        
        detalle.append("validez", $q("#validez").value);        
        detalle.append("igv", $q("#igv").value);        
        detalle.append("tipopago", $q("#tipopago").value);        
    
        const fdetalle = await fetch(`${host}detalleevento.controller.php`, {
          method: "POST",
          body: detalle,
        });
        const rdetalle = await fdetalle.json();
        return rdetalle;
      }

      // ************************************* FUNCIONES DE VALIDACION ************************************* //

      function bloquearCampos(isblock) {
        $q("#ndocumento").disabled = isblock;
        $q("#razonsocial").disabled = isblock;
        $q("#telefono").disabled = isblock;
        $q("#correo").disabled = isblock;
        $q("#nacionalidad").disabled = isblock;
        $q("#departamento").disabled = isblock;
        $q("#provincia").disabled = isblock;
        $q("#distrito").disabled = isblock;
        $q("#direccion").disabled = isblock;
        $q("#artista").disabled = isblock;
        $q("#fechaevento").disabled = isblock;
        $q("#horapresentacion").disabled = isblock;
        $q("#tiempopresentacion").disabled = isblock;
        $q("#establecimiento").disabled = isblock;
        $q("#tipoevento").disabled = isblock;
        $q("#modalidad").disabled = isblock;
        $q("#validez").disabled = isblock;
        $q("#nacionalidad2").disabled = isblock;
        $q("#departamento2").disabled = isblock;
        $q("#provincia2").disabled = isblock;
        $q("#distrito2").disabled = isblock;
        $q("#igv").disabled = isblock;
        //selector("externo").disabled = isblock
      }
    
      //Muestra los datos en los campos
/*       function showDatos(data) {
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
      } */
    
      //resetea los campos
      function resetUI() {
        $q("#ndocumento").value = '';
        $q("#razonsocial").value = '';
        $q("#telefono").value = '';
        $q("#correo").value = '';
        $q("#nacionalidad").value = '';
        $q("#departamento").value = '';
        $q("#provincia").value = '';
        $q("#distrito").value = '';
        $q("#direccion").value = '';
        $q("#artista").value = '';
        $q("#fechaevento").value = '';
        $q("#horapresentacion").value = '';
        $q("#tiempopresentacion").value = '';
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

        function showDataCliente(data) {
            //console.log("data persona reniec: ", data);
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

        async function validateNumDoc() {
            //Validaciones del num doc, guarda en una variable si es valido o no (boolean)
            const isNumeric = /^[0-9]+$/.test($q("#ndocumento").value);
            const minLength = ($q("#ndocumento").value.length >= 8);
            const validaNumDoc = $q("#ndocumento").value.length === 8 || $q("#ndocumento").value.length === 20 ? true : false;
        
            if ($q("#ndocumento").value !== "" && isNumeric && minLength && validaNumDoc) {
              const data = await obtenerClientePorDoc( $q("#ndocumento").value.trim());
              const isblock = (data.length > 0); // confirma si la persona ya existe y bloquea los campos 
              bloquearCampos(isblock);
        
              console.log(isblock);
              console.log(data);
        
        
              if (isblock) {
                showToast("El cliente ya existe", "WARNING");
                $q("#btnEnviar").disabled = true;
                showDatos(data[0]);
              } else {
                if (!isReset) {
                  resetUI();
                  const dataCliente = await obtenerDataClienteRUC()
                  console.log("data cliente sunat: ", dataCliente);
                  //showDataCliente(dataCliente)
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

      $q("#search").addEventListener("click", async () => {
        await validateNumDoc();
      });

      $q("#form-atencion-clientes").addEventListener("submit", async (e) => {
        e.preventDefault();
        isReset = true;
        //await validateNumDoc(); //valida que el numero de caracteres y otras validaciones sean correctas
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
            const data = await registrarCliente();
            console.log(data);
            //alert("registrando persona")
            if (data.idcliente > 0) {
              const detalleevento = await registrarDetalleEvento(data.idcliente);
              console.log(detalleevento);
    
              if (detalleevento.iddetalleevento > 0) {
                showToast("Se ha registrado correctamente la atencion", "SUCCESS", 1000, '');
                isReset = false;
                resetUI();
                $q("#ndocumento").value = "";
                bloquearCampos(true);
                $q("#btnGuardarAC").disabled = true;
                $q("#ndocumento").focus();
              } else {
                showToast("Hubo un error al registrar la atencion", "ERROR");
              }
            } else {
              showToast("Hubo un error al registrar los datos del cliente", "ERROR");
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
      });
});