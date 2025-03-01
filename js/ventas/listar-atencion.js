document.addEventListener("DOMContentLoaded", async ()=> {

    const host = "http://localhost/vega-erp/controllers/";
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

      function createTable(data) {
        let rows = $("#tb-body-atencion").find("tr");
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
            myTable = $("#table-atenciones").DataTable({
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

      changeByFilters()

      function changeByFilters(){
        const filters = $all(".filter");
        $q("#table-atenciones tbody").innerHTML = "";
        filters.forEach((x) => {
          /* x.addEventListener("change", async () => {
            await dataFilters();
          }); */
          if (x.id==="ncotizacion") {
            x.addEventListener("input", async () => {
              await dataFilters();
            });
          }
        });
      }

      chargerEventsButton();

      async function dataFilters(){
        const params = new URLSearchParams();
        params.append("operation", "filtrarAtenciones");
        params.append("ncotizacion", $q("#ncotizacion").value ? $q("#ncotizacion").value : '');
        //alert("asdasdd")
        const data = await getDatos(`${host}detalleevento.controller.php`, params);
        //console.log(data);
        console.log("data -> ", data)
        $q("#table-atenciones tbody").innerHTML="";
    
        if(data.length===0){
          $q("#table-atenciones tbody").innerHTML= `
          <tr>
            <td colspan="9">No encontrado</td>
          </tr>
          `;
        }
        
        data.forEach((x,i)=>{
          $q("#table-atenciones tbody").innerHTML+=`
          <tr>
            <td>${x.iddetalle_presentacion}</td>
            <td>${x.ncotizacion}</td>
            <td>${x.nom_usuario}</td>
            <td>${x.razonsocial}</td>
            <td>${x.tipo_evento==1?"Público":
                  x.tipo_evento==2?"Privado":
                  ``}</td>
            <td>${x.modalidad==1?"Convenio":
                  x.modalidad==2?"Contrato":
                  ``}</td>
            <td>${x.fecha_presentacion}</td>                        
            <td>
              ${
                parseInt(x.modalidad)==1?
                `<button type="button" class="btn btn-sm btn-warning btn-convenio" data-id=${x.iddetalle_presentacion} title="Generar Convenio">
                  Convenio
                </button>`
                :
                parseInt(x.modalidad)==2?`
                <button type="button" class="btn btn-sm btn-success change-cotizar" data-id=${x.iddetalle_presentacion} 
                  data-estado=${x.condicion} title="Cotizar">Cotizar</button>`
                :``
              }
              ${
                parseInt(x.modalidad)===2?`
                <button type="button" class="btn btn-sm btn-secondary btn-contrato" data-id=${x.iddetalle_presentacion} title="Generar contrato">
                  Generar Contrato
                </button>`:``
              }
              
              <button type="button" class="btn btn-sm btn-danger btn-cancelar" data-id=${x.iddetalle_presentacion} title="Cancelar">
                Cancelar
              </button>
            </td>
          </tr>
          `;
        });
        //disabledBtnArea();
        createTable(data);
        
      }

    function createTable(data) {
        let rows = $("#tb-body-atencion").find("tr");
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
            myTable = $("#table-atenciones").DataTable({
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
        idactivo =0;
        if (e.target.classList.contains("btn-convenio")) {
          buttonConvenio(e);
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
  function buttonConvenio(e){
    idconvenio = e.target.getAttribute("data-id");

    const modalImg = new bootstrap.Modal($q("#modal-convenio"));
    modalImg.show();
  }

})


// *****************************************************************************************

