document.addEventListener("DOMContentLoaded", async () => {

  let myTable = null;

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

  // *********************************** OBTENER DATOS ********************************

  (async () => {
    const niveles = await obtenerNiveles()
    $q("#nivelacceso").innerHTML = `<option value="">Selecciona</option>`
    niveles.forEach(nivel => {
      $q("#nivelacceso").innerHTML += `<option value="${nivel.nivelacceso}">${nivel.nivelacceso}</option>`
    });
  })()

  await obtenerSucursales()

  async function obtenerSucursales() {
    const params = new URLSearchParams();
    params.append("operation", "obtenerSucursales");
    const data = await getDatos(`${host}sucursal.controller.php`, params);
    console.log("data de succursales -> ", data);
    $q("#sucursal").innerHTML = "<option value=''>Todos</option>"
    data.forEach((sucursal) => {
      $q("#sucursal").innerHTML += `<option value="${sucursal.idsucursal}">${sucursal.nombre}</option>`;
    });
    //return data;
  }


  async function obtenerNiveles() {
    const data = await getDatos(`${host}recurso.controller.php`, "operation=obtenerNiveles");
    console.log(data);
    return data
  }

  async function actualizarEstadoUsuario(idusuario, estado) {

    const body = new FormData();
    body.append("operation", "deshabilitarUsuario");
    body.append("idusuario", idusuario); // id artista
    body.append("estado", estado);

    const fbody = await fetch(`${host}usuario.controller.php`, {
      method: "POST",
      body: body,
    });
    const rbody = await fbody.json();
    return rbody;
  }


  function createTable(data) {
    let rows = $("#tb-body-usuario").find("tr");
    ////console.log(rows.length);
    if (data.length > 0) {
      if (myTable) {
        if (rows.length > 0) {
          myTable.clear().rows.add(rows).draw();
        } else if (rows.length === 1) {
          myTable.clear().draw(); // Limpia la tabla si no hay filas.
        }
      } else {
        // Inicializa DataTable si no ha sido inicializado antes
        myTable = $("#table-usuarios").DataTable({
          paging: true,
          searching: false,
          lengthMenu: [5, 10, 15, 20],
          pageLength: 5,
          language: {
            lengthMenu: "Mostrar _MENU_ filas por página",
            paginate: {
              previous: "Anterior",
              next: "Siguiente",
            },
            search: "Buscar:",
            info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
            emptyTable: "No se encontraron registros",
          },
        });
        // if (rows.length > 0) {
        //   myTable.rows.add(rows).draw(); // Si hay filas, agrégalas.
        // }
      }
    }
  }


  (async () => {
    await dataFilters();
  })();


  changeByFilters()

  function changeByFilters() {
    const filters = $all(".filter");
    $q("#table-usuarios tbody").innerHTML = "";
    filters.forEach((x) => {
      x.addEventListener("change", async () => {
        await dataFilters();
      });
      if (x.id === "ndocumento") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
      if (x.id === "nombres") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
      if (x.id === "apellidos") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
      if (x.id === "nomusuario") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
      if (x.id === "telefono") {
        x.addEventListener("input", async () => {
          await dataFilters();
        });
      }
      if (x.id === "sucursal") {
        x.addEventListener("change", async () => {
          await dataFilters();
        });
      }
    });
  }

  chargerEventsButton();

  async function dataFilters() {
    const params = new URLSearchParams();
    params.append("operation", "filtrarUsuarios");
    params.append("nivelacceso", $q("#nivelacceso").value ? $q("#nivelacceso").value : '');
    params.append("numdoc", $q("#ndocumento").value ? $q("#ndocumento").value : '');
    params.append("nombres", $q("#nombres").value ? $q("#nombres").value : '');
    params.append("apellidos", $q("#apellidos").value ? $q("#apellidos").value : '');
    params.append("telefono", $q("#telefono").value ? $q("#telefono").value : '');
    params.append("nomusuario", $q("#nomusuario").value ? $q("#nomusuario").value : '');
    params.append("idsucursal", $q("#sucursal").value ? $q("#sucursal").value : '');
    //alert("asdasdd")
    const data = await getDatos(`${host}usuario.controller.php`, params);
    //console.log(data);
    console.log("data -> ", data)
    $q("#table-usuarios tbody").innerHTML = "";

    if (data.length === 0) {
      $q("#table-usuarios tbody").innerHTML = `
          <tr>
            <td colspan="9">Sin resultados</td>
          </tr>
          `;
    }

    data.forEach((x, i) => {
      $q("#table-usuarios tbody").innerHTML += `
          <tr>
            <td>${x.idusuario}</td>
            <td>${x.nivelacceso}</td>
            <td>${x.num_doc}</td>
            <td>${x.nombres}</td>
            <td>${x.apellidos}</td>
            <td>${x.nom_usuario}</td>  
            <td>${x.telefono}</td>
            <td>${x.estado == 1 ? "Activo" :
          x.estado == 2 ? "Inhabilitado" :
            ``}</td>
                                                         
            <td>
              <button type="button" class="btn btn-sm btn-success btn-editar" data-id=${x.idusuario} title="Editar usuario">
                  Editar
                </button>
               ${x.estado == 1 ? ` <button type="button" class="btn btn-sm btn-danger btn-deshabilitar" data-id=${x.idusuario} title="Deshabilitar usuario">
                  Deshabilitar
                </button>` : x.estado == 2 ? `<button type="button" class="btn btn-sm btn-success btn-habilitar" data-id=${x.idusuario} title="Habilitar usuario">
                  Habilitar
                </button>` : ''}        
            </td>
          </tr>
          `;
    });
    //disabledBtnArea();
    createTable(data);

  }

  function createTable(data) {
    let rows = $("#tb-body-usuario").find("tr");
    ////console.log(rows.length);
    if (data.length > 0) {
      if (myTable) {
        if (rows.length > 0) {
          myTable.clear().rows.add(rows).draw();
        } else if (rows.length === 1) {
          myTable.clear().draw(); // Limpia la tabla si no hay filas.
        }
      } else {
        // Inicializa DataTable si no ha sido inicializado antes
        myTable = $("#table-usuarios").DataTable({
          paging: true,
          searching: false,
          lengthMenu: [5, 10, 15, 20],
          pageLength: 5,
          language: {
            lengthMenu: "Mostrar _MENU_ filas por página",
            paginate: {
              previous: "Anterior",
              next: "Siguiente",
            },
            search: "Buscar:",
            info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
            emptyTable: "No se encontraron registros",
          },
        });
        // if (rows.length > 0) {
        //   myTable.rows.add(rows).draw(); // Si hay filas, agrégalas.
        // }
      }
    }
  }

  /**
* Carga los botones que estan en la tabla
*/
  function chargerEventsButton() {
    document.querySelector(".table-responsive").addEventListener("click", async (e) => {
      if (e.target) {
        idactivo = 0;
        if (e.target.classList.contains("btn-editar")) {
          buttonEditar(e);
        }
        if (e.target.classList.contains("btn-deshabilitar")) {
          buttonDeshabilitar(e);
        }

        if (e.target.classList.contains("btn-habilitar")) {
          buttonHabilitar(e);
        }
        /* if(e.target.classList.contains("btn-info-baja")){
          await showReporte(e);
        }
        if(e.target.classList.contains("show-espec")){//abre el sidebar
          await btnSBUpdateActivo(e);
        }
        if (e.target.classList.contains("change-area")) {
          buttonCambiarArea(e);
        } */
      }
    });
  }

  /**
   * Abre el modal de asignar Area
   * @param {*} e evento del boton
   */
  function buttonEditar(e) {
    idusuario = e.target.getAttribute("data-id");

    console.log("id usuario", idusuario);
    window.localStorage.clear()
    window.localStorage.setItem("idusuario", idusuario)
    window.location.href = `${hostOnly}/views/utilitario/usuarios/actualizar-usuario`
    return
  }

  async function buttonDeshabilitar(e) {
    iddeshabilitar = e.target.getAttribute("data-id");

    if (await ask("¿Desea deshabilitar este usuario?")) {
      const deshabilitado = await actualizarEstadoUsuario(iddeshabilitar, 2)
      console.log("deshabilitado ? -< ", deshabilitado);
      await dataFilters()
      showToast("Usuario deshabilitado.", "INFO")
      return
    }
  }

  async function buttonHabilitar(e) {
    idhabilitar = e.target.getAttribute("data-id");

    if (await ask("¿Desea Habilitar este usuario?")) {
      const habilitar = await actualizarEstadoUsuario(idhabilitar, 1)
      console.log("habiilitado ? -< ", habilitar);
      await dataFilters()
      showToast("Usuario habilitado.", "INFO")
      return
    }
  }

})