document.addEventListener("DOMContentLoaded", async () => {
    // modales
    let modalPendientes
    let myTable
    let artistaSelect = $q("#artista")
    let editorSelect = $q("#usuarioeditor")

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

    await obtenerUsuariosArtistas(6)
    await obtenerUsuariosEditores(8)

    

    async function obtenerUsuariosArtistas(idnivelacceso) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", idnivelacceso);
        const data = await getDatos(`${host}usuario.controller.php`, params);
        console.log(data);
        artistaSelect.innerHTML = "<option value=''>Todos</option>";
        data.forEach((artista) => {
          artistaSelect.innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
        });
    
      }

    async function obtenerUsuariosEditores(idnivelacceso) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerUsuarioPorNivel");
        params.append("idnivelacceso", idnivelacceso);
        const data = await getDatos(`${host}usuario.controller.php`, params);
        console.log(data);
        editorSelect.innerHTML = "<option value=''>Todos</option>";
        data.forEach((artista) => {
          editorSelect.innerHTML += `<option value="${artista.idusuario}">${artista.nom_usuario}</option>`;
        });
    
      }

    // ******************************************** DATATABLE ************************************************

    function createTable(data) {
        let rows = $("#tb-body-contenido").find("tr");
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
                myTable = $("#table-contenidos").DataTable({
                    processing: true, // Muestra un indicador de carga
                    serverSide: true, // Activa la paginación en el servidor                           
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
                    }
                });
                // if (rows.length > 0) {
                //   myTable.rows.add(rows).draw(); // Si hay filas, agrégalas.
                // }
            }
        }
    }

    (async () => {
        if(nivelacceso == "Community Manager"){
            $q(".contenedor-select-editor").hidden = true
            console.log("usuario de cmmnaager- Z> ", idusuarioLogeado);
            await dataFilters(idusuarioLogeado)
        }
        else{
            await dataFilters()
        }
    })();

    changeByFilters();

    function changeByFilters() {
        const filters = $all(".filter");
        $q("#table-contenidos tbody").innerHTML = "";
        filters.forEach((x) => {
            /* x.addEventListener("change", async () => {
              await dataFilters();
            }); */
            if (x.id === "establecimiento") {
                x.addEventListener("input", async () => {
                    if(nivelacceso == "Community Manager"){
            $q(".contenedor-select-editor").hidden = true
            console.log("usuario de cmmnaager- Z> ", idusuarioLogeado);
            await dataFilters(idusuarioLogeado)
        }
        else{
            await dataFilters()
        }
                });
            }
            if (x.id === "fechapresentacion") {
                x.addEventListener("change", async () => {
                    if(nivelacceso == "Community Manager"){
            $q(".contenedor-select-editor").hidden = true
            console.log("usuario de cmmnaager- Z> ", idusuarioLogeado);
            await dataFilters(idusuarioLogeado)
        }
        else{
            await dataFilters()
        }
                });
            }
            if (x.id === "artista") {
                x.addEventListener("change", async () => {
                    if(nivelacceso == "Community Manager"){
            $q(".contenedor-select-editor").hidden = true
            console.log("usuario de cmmnaager- Z> ", idusuarioLogeado);
            await dataFilters(idusuarioLogeado)
        }
        else{
            await dataFilters()
        }
                });
            }
            if (x.id === "usuarioeditor") {
                x.addEventListener("change", async () => {
                    await dataFilters();
                });
            }
        });
    }


    chargerEventsButton();

    async function dataFilters(idusuarioEditor) {
        const params = new URLSearchParams();
        params.append("operation", "obtenerTareasParaPublicar");
        params.append("establecimiento", $q("#establecimiento").value ? $q("#establecimiento").value : "");
        params.append("fechapresentacion", $q("#fechapresentacion").value ? $q("#fechapresentacion").value : "");
        params.append("idusuario", $q("#artista").value ? $q("#artista").value : "");
        params.append("idusuarioeditor", idusuarioEditor ? idusuarioEditor : $q("#usuarioeditor").value ? $q("#usuarioeditor").value : "");
        const data = await getDatos(`${host}agendacmanager.controller.php`, params);
        
        console.log("data -> ", data);

        const tbody = $q("#table-contenidos tbody");
        tbody.innerHTML = "";

        if (data.length === 0) {
            tbody.innerHTML = `
            <tr>
                <td colspan="9">Sin resultados</td>
            </tr>
        `;
            return; // Salimos de la función si no hay datos
        }

        for (const x of data) {

            tbody.innerHTML += `
            <tr>
                <td>${x.establecimiento ? x.establecimiento : 'no aplica'}</td>
                <td>${x.fecha_presentacion ? x.fecha_presentacion : ''}</td>
                <td>${x.nom_usuario ? x.nom_usuario : ''}</td>                   
                <td>${x.nombres ? x.nombres : ''}</td>                   
                <td>${x.tipotarea ? x.tipotarea : ''}</td>           
                <td>
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <input type="text" class="form-control" name="txtportalweb" id="txtportalweb" value="${x.portalpublicar ? x.portalpublicar : ''}">
                        <i class="fa-solid fa-floppy-disk btnGuardarPortalWeb" data-idagendacommanager="${x.idagendacommanager}" style="cursor: pointer; color: blue;"></i>
                    </div>
                </td>                        
                <td>
                    <div style="display: flex; align-items: center; gap: 8px;" >
                        <textarea type="text" class="form-control col-md-6" name="txtcopy" id="txtcopy">${x.copy ? x.copy : ''}</textarea>
                        <i class="fa-solid fa-floppy-disk btnGuardarCopy" data-idagendacommanager="${x.idagendacommanager}" style="cursor: pointer; color: blue;"></i>
                    </div>
                </td>                        
                <td>
                    <input type="checkbox" class="btn-estado" name="estado" id="estado" data-idagendacommanager="${x.idagendacommanager}" ${x.estado == 2 ? 'checked' : ''}>
                </td>
            </tr>
        `;            
        }
        createTable(data);

        $all(".btnGuardarPortalWeb").forEach(btn => {
            btn.addEventListener("click", async (e) => {
                try {                    
                    const idagendacommanager = e.target.getAttribute("data-idagendacommanager")
                    let fila = e.target.closest("tr"); // Encuentra la fila actual
                    let inputportalweb = fila.querySelector("input[name='txtportalweb']").value;
                    console.log("portal web a publicar", inputportalweb);
                    
                    const portalwebasignado = await asignarPortalWebContenido(idagendacommanager, inputportalweb)
                    console.log("portalweb asignado ? -> ", portalwebasignado);
                    if (portalwebasignado) {
                        showToast("Hecho!", "SUCCESS")                        
                        return
                    }
                } catch (error) {
                    showToast("Un error ha ocurrido!", "ERROR")
                    return
                }
            })
        })
        $all(".btnGuardarCopy").forEach(btn => {
            btn.addEventListener("click", async (e) => {
                try {                    
                    const idagendacommanager = e.target.getAttribute("data-idagendacommanager")
                    let fila = e.target.closest("tr"); // Encuentra la fila actual
                    let inputcopy = fila.querySelector("textarea[name='txtcopy']").value;
                    console.log("texto copy", inputcopy);
                    
                    const copyContenido = await actualizarCopyContenido(idagendacommanager, inputcopy)
                    console.log("copy contenido actualizado? ? -> ", copyContenido);
                    if (copyContenido) {
                        showToast("Hecho!", "SUCCESS")                        
                        return
                    }
                } catch (error) {
                    showToast("Un error ha ocurrido!", "ERROR")
                    return
                }
            })
        })
    }

    function createTable(data) {
        let rows = $("#tb-body-contenido").find("tr");
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
                myTable = $("#table-contenidos").DataTable({
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
        document
            .querySelector(".table-responsive")
            .addEventListener("click", async (e) => {
                if (e.target) {
                    idactivo = 0;
                    if (e.target.classList.contains("btn-estado")) {
                        await buttonCambiarEstado(e);
                    }
                    /* if(e.target.classList.contains("show-espec")){//abre el sidebar
                    await btnSBUpdateActivo(e);
                  }
                  if (e.target.classList.contains("change-area")) {
                    buttonCambiarArea(e);
                  } */
                }
            });
    }

        // ********************************************* RENDERIZACION DE DATA ****************************************************************
async function buttonCambiarEstado(e) {
    /* idagendacommanager = e.target.getAttribute("data-idagendacommanager");
    modalPendientes = new bootstrap.Modal($q("#modal-pendientes"))
    modalPendientes.show() */
    try {
        const idagendacommanager = e.target.getAttribute("data-idagendacommanager")
        console.log("valor -> ", e.target.checked);    
        let estadoNuevo = e.target.checked ? 2 : 1
        console.log("estado neuevo -> ", estadoNuevo);
        const contenidoPublicado = await actualizarEstadoPublicarContenido(idagendacommanager, estadoNuevo)
        console.log("contniod publicado- > ", contenidoPublicado);
        if(contenidoPublicado){
            showToast("Contenido Publicado!", "SUCCESS")                        
            return
        }
    } catch (error) {
        showToast("Un error ha ocurrido!", "ERROR")
        return
    }
}


    // ********************************************* OBTENCION DE DATASA ****************************************************************


    // ********************************************* REGISTROS Y ACTUALIZACION DE DATASA ****************************************************************

    async function asignarPortalWebContenido(idagendacommanager, portalpublicar) {
        const body = new FormData();
        body.append("operation", "asignarPortalWebContenido");
        body.append("idagendacommanager", idagendacommanager); // id artista
        body.append("portalpublicar", portalpublicar);

        const fbody = await fetch(`${host}agendacmanager.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    async function actualizarEstadoPublicarContenido(idagendacommanager, estado) {
        const body = new FormData();
        body.append("operation", "actualizarEstadoPublicarContenido");
        body.append("idagendacommanager", idagendacommanager); // id artista
        body.append("estado", estado);

        const fbody = await fetch(`${host}agendacmanager.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }
    
    async function actualizarCopyContenido(idagendacommanager, copy) {
        const body = new FormData();
        body.append("operation", "actualizarCopyContenido");
        body.append("idagendacommanager", idagendacommanager); // id artista
        body.append("copy", copy);

        const fbody = await fetch(`${host}agendacmanager.controller.php`, {
            method: "POST",
            body: body,
        });
        const rbody = await fbody.json();
        return rbody;
    }

    
    // ********************************************* EVENTOS  ****************************************************************
})