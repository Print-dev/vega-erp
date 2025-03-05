</main>
<!-- Modal de crear especificaciones -->
<div class="modal fade" id="mdl-crear-espec" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable"  style="max-width: 650px;">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Crear Especificacion</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-12">
            <div class="form-floating">
              <input type="text" class="form-control" id="new_especificacion">
              <label for="new_especificacion" class="form-label">Nueva Especificacion</label>
            </div>
            <div class="d-flex mt-2">
              <button type="button" class="btn btn-sm btn-success ms-auto" id="add_espec">Registrar</button>
            </div>
          </div>
        </div>
        <hr>
        <div class="row mt-2">
          <div class="table-responsive">
            <table class="" id="tb-especificaciones">
              <thead>
                <tr>
                  <th class="text-center">Id</th>
                  <th class="text-center">Especificacion</th>
                </tr>
              </thead>
              <tbody id="tbody-espec"></tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>
<!-- ./Modal de crear especificaciones -->

<script>
  const host = "http://localhost/vega-erp/controllers/";
</script>
<!-- Core -->
<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
  crossorigin="anonymous"></script>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- Script personzalizado -->

<!-- <script src="http://localhost/CMMS/js/dashboard/select-option.js"></script> -->
<!-- SWEET ALERT -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Libreria que simplifica sweet alert -->
<script src="http://localhost/vega-erp/js/swalcustom.js"></script>
<!-- Archivo para obtener fecha y hora de peru -->
<script src="http://localhost/vega-erp/js/fechahoraperu.js"></script>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<!-- JQUERY -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//cdn.datatables.net/2.1.8/js/dataTables.min.js"></script>

<!-- <script src="http://localhost/vega-erp/js/calcularFechaProgramadaTarea.js"></script> -->
<script>

  // Manejo de la apertura/cierre del dropdown
  const dropdownButton = document.getElementById('drop-sb');
  dropdownButton?.addEventListener('click', () => {
    const dropdown = dropdownButton?.closest('.drop-sb');
    dropdown?.classList.toggle('show');
  });

  // Cerrar el dropdown cuando se hace clic fuera
  document?.addEventListener('click', (e) => {
    const dropdown = document.querySelector('.drop-sb');
    if (!dropdown?.contains(e.target)) {
      dropdown?.classList.remove('show');
    }
  });
  //--------------------------------------------------------------------------------------------//

  document.addEventListener("DOMContentLoaded", () => {
    const host = "http://localhost/vega-erp/controllers/";
    let myTable = null;

    //Eliminar el idorg del LOCAL Storage
    /* (async()=>{
      const params = new URLSearchParams();
      params.append("operation", "listSedesByOrg");
      params.append("idorganizacion", localStorage.getItem("idorg")==undefined?1:localStorage.getItem("idorg"));
      const data = await fetch(`http://localhost/vega-erp/controllers/sede.controller.php?${params}`);
      const resp = await data.json();
  
      if(resp.length===0){
        localStorage.removeItem("idorg");
      }
    })(); */

    /* function selector(value) {
      return document.querySelector(`#${value}`);
    } */

    /**
     * Resumen el procedimiento de obtener los datos de la DB (solo GET)
     * @param {*} link nombre del controlador (Solo el nombre antes del primer punto)
     * @param {*} params Parametros que se necesitan enviar para obtener los datos (UrlSearchParams)
     * @returns Un array de JSON
     */
    /* async function getDatos(link, params) {
      let data = await fetch(`${host}${link}.controller.php?${params}`);
      return data.json();
    } */

    /* async function renderTable(){
      const data = await getDatos("especificacion", "operation=getAll");
      //console.log(data);
      
      selector("tbody-espec").innerHTML = "";
      data.forEach((x,i) => {
        selector("tbody-espec").innerHTML += `
        <tr>
          <td class="text-center">${i+1}</td>
          <td>${x.especificacion}</td>
        </tr>
      `;
      });
      createTable(data);
    } */

    /* (async () => {
      await renderTable();
    })(); */

    //DataTable
    /* function createTable(data) {
      let rows = $("#tbody-espec").find("tr");
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
          myTable = $("#tb-especificaciones").DataTable({
            paging: true,
            searching: true,
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
    } */

    /* (() => {
      const allGestion = document.querySelectorAll(".list-gestion");
      allGestion.forEach(x => {
        const dropParent = x.children;
        ////console.log(dropParent[0].children[1].innerText);
        if (dropParent[0].children[1].innerText === "Especificaciones") {
          ////console.log(x.children);
          x.addEventListener("click", (e) => {
            e.preventDefault();
            x.children[0].removeAttribute("href");
            ////console.log("click");
            
            const modalImg = new bootstrap.Modal(selector("mdl-crear-espec"));
            modalImg.show();
          });
        }
      });
    })(); */

    /* selector("add_espec").addEventListener("click", async () => {
      const existeEspec = await existeEspecificacion();

      if(!selector("new_especificacion").value){
        showToast("Escribe una especificacion", "WARNING");
        selector("new_especificacion").focus();
        return;
      }

      if (parseInt(existeEspec[0].cantidad) === 0) {
        if (await ask("¿Estas seguro de registrar una especificacion?")) {
          const isAdd = await addEspecificacion();
          if (isAdd.id > 0) {
            showToast("Se ha registrado correctamente", "SUCCESS");
            await renderTable();
            selector("new_especificacion").value = "";
          } else {
            showToast("Hubo un error al registrar la especificacion", "ERROR");
          }
        }
      } else {
        let msg = "";
        if (parseInt(existeEspec[0].cantidad) === 1) {msg = "Ya existe una especificacion con el mismo nombre";}
        showToast(msg, "WARNING");
      }
    }); */

    /* async function addEspecificacion() {
      const params = new FormData();
      params.append("operation", "addEspec");
      params.append("especificacion", selector("new_especificacion").value);

      const respuesta = await fetch(`${host}especificacion.controller.php`, {
        method: 'POST',
        body: params
      });

      return await respuesta.json();
    } */

    /* async function existeEspecificacion() {
      const params = new URLSearchParams();
      params.append("operation", "existeEspecificacion");
      params.append("especificacion", selector("new_especificacion").value);

      const data = await getDatos("especificacion", params);
      return data;
    } */
  });
</script>