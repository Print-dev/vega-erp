document.addEventListener("DOMContentLoaded", async () => {
  $q("#btnGuardarContenido").disabled = true;
  // varaibles
  let idagendaeditor = window.localStorage.getItem("idagendaeditor")
    ? window.localStorage.getItem("idagendaeditor")
    : -1;
  let imagen_public_id = "";
  const BASE_CLOUDINARY_URL =
    "https://res.cloudinary.com/dynpy0r4v/image/upload/v1742531227/";

  // MODALES
  let modalHistorial;
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

  //subirContenidoEditor
  // ************************************************************* OBTENER DATOS **************************************************************
  async function obtenerContenidoHistorialEdicion(idagendaeditor) {
    const params = new URLSearchParams();
    params.append("operation", "obtenerContenidoHistorialEdicion");
    params.append("idagendaeditor", idagendaeditor);
    const data = await getDatos(`${host}agenda.controller.php`, params);
    return data;
  }
  // ******************************************************** REGISTRO DE DATOS ****************************************************************

  async function subirContenidoEditor(idagendaeditor, urlimagen, urlvideo) {
    const body = new FormData();
    body.append("operation", "subirContenidoEditor");
    body.append("idagendaeditor", idagendaeditor); // id artista
    body.append("urlimagen", urlimagen ? urlimagen : "");
    body.append("urlvideo", urlvideo ? urlvideo : "");

    const fbody = await fetch(`${host}agenda.controller.php`, {
      method: "POST",
      body: body,
    });
    const rbody = await fbody.json();
    return rbody;
  }

  async function comentarContenido(idsubida, observaciones) {
    const body = new FormData();
    body.append("operation", "comentarContenido");
    body.append("idsubida", idsubida); // id artista
    body.append("observaciones", observaciones ? observaciones : "");

    const fbody = await fetch(`${host}agenda.controller.php`, {
      method: "POST",
      body: body,
    });
    const rbody = await fbody.json();
    return rbody;
  }

  let myWidget = cloudinary.createUploadWidget(
    {
      cloudName: "dynpy0r4v",
      uploadPreset: "vegaimagenes",
      folder: "vegaimagenes",
    },
    async (error, result) => {
      if (!error && result && result.event === "success") {
        console.log("result -> ", result);
        /* $q("#preview-container").innerHTML = `
                  <img src="${result.info?.public_id}" alt="" srcset="">
              `; */
        let previewImagen = document.getElementById("previewImagen");
        previewImagen.src = result.info.secure_url;
        previewImagen.classList.remove("d-none");
        imagen_public_id = result.info?.public_id;
        $q("#btnGuardarContenido").disabled = false;
      }
    }
  );

  $q("#upload_widget")?.addEventListener(
    "click",
    function () {
      myWidget.open();
    },
    false
  );

  $q("#btnGuardarContenido").addEventListener("click", async () => {
    const subido = await subirContenidoEditor(
        idagendaeditor,
      imagen_public_id
    );
    console.log("subido ??", subido);
    if (subido?.idsubida) {
      showToast("Contenido Subido Exitosamente", "SUCCESS");
      $q("#btnGuardarContenido").disabled = true;
      return;
    }
    showToast("Ocurrio un error al subir la imagen", "ERROR");
    return;
  });

  $q("#btnVerHistorial").addEventListener("click", async () => {
    const modal = new bootstrap.Modal(document.getElementById("modal-historial"));
    modal.show();
    
    const historialContenido = await obtenerContenidoHistorialEdicion(idagendaeditor);
    console.log("historial ->", historialContenido);

    const contenedorHistorial = document.querySelector(".contenedor-historial");
    contenedorHistorial.innerHTML = ""; // Limpiar contenido previo

    if (historialContenido.length === 0) {
        contenedorHistorial.innerHTML = "<p class='text-center text-muted'>No hay historial disponible.</p>";
        return;
    }

    historialContenido.forEach((item) => {
        const urlImagen = item.url_imagen ? `${BASE_CLOUDINARY_URL}${item.url_imagen}` : "https://via.placeholder.com/250";
        const comentario = item.observaciones || "Sin observaciones";

        const historialItem = `
            <div class="row align-items-center mb-3 p-2 border rounded shadow-sm">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Observaciones</label>
                    <textarea class="form-control observacion-caja" rows="3" data-idsubida="${item.idsubida}">${comentario}</textarea>
                    <button type="button" class="btn btn-primary mt-2 btnGuardarObservacion" data-idsubida="${item.idsubida}">Guardar <i class="fa-solid fa-paper-plane"></i></button>
                </div>
                <div class="col-md-6 text-center">
                    <img src="${urlImagen}" alt="Imagen Historial" class="img-fluid rounded shadow">
                </div>
            </div>
        `;

        contenedorHistorial.innerHTML += historialItem;
    });

    // Mostrar el modal después de cargar los datos
    
});

// Delegación de eventos
document.addEventListener("click", async (e) => {
    if (e.target.classList.contains("btnGuardarObservacion")) {
        console.log("Click en Guardar Observación");

        let idsubida = e.target.getAttribute("data-idsubida");
        let textarea = e.target.parentElement.querySelector(".observacion-caja");
        let observacion = textarea.value.trim();

        if (observacion === "") {
            alert("Por favor ingresa una observación.");
            return;
        }

        const observacionRegistrada = await comentarContenido(idsubida, observacion);
        console.log("Observación registrada -> ", observacionRegistrada);
        showToast("Observación guardada con éxito", "SUCCESS");
    }
});
});
