<?php
session_start();

$hostOnly = "http://localhost/vega-erp";

if (isset($_SESSION['login']) && $_SESSION['login']['estado']) {
  header('Location:'.$hostOnly.'/views/ventas/listar-atencion-cliente');
}
?>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="<?= $hostOnly ?>/css/login.css">
  <link rel="icon" type="image/png" href="https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/esawybumfjhhujupw5pa.png">

  <title>Inicia Sesion en Vega Producciones</title>
  <script>
    const hostOnly = "<?= $hostOnly ?>"; // Definir variable para JS
  </script>
</head>

<style>
  #access {
    background: #F2CC0F;
    transition: 0.3s;
    font-weight: bold;
  }

  /* Hover para el botón */
  #access:hover {
    /* Invertir los colores del degradado */
    color: white;
    background: black;
  }
</style>

<body>
  <div class="container-fluid d-flex flex-column align-items-center mt-5">
    <!-- Imagen -->
    <img
      src="https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/esawybumfjhhujupw5pa.png"
      alt="Logo"
      class=" mb-4"
      style="width: 105px; object-fit: cover;">

    <!-- Formulario -->
    <form
      action=""
      id="form-login"
      class="form-group bg-light p-4 border rounded shadow"
      style="width: 100%; max-width: 400px;"
      autocomplete="off">
      <h2 class="text-center mb-4">Iniciar sesión</h2>
      <div class="mb-3">
        <label for="usuario" class="form-label">Nombre de Usuario</label>
        <input type="text" class="form-control" id="usuario" required>
      </div>
      <div class="mb-3">
        <label for="claveacceso" class="form-label">Contraseña</label>
        <input type="password" class="form-control" id="claveacceso" required>
      </div>
      <button type="submit" id="access" class="btn w-100" style="">Acceder</button>
      <!-- <p class="text-center mt-3" style="cursor: pointer;" id="btnContrasenaOlvidadaModal" data-bs-toggle="modal" data-bs-target="#staticBackdrop">¿Has olvidado tu contraseña?</p> -->
    </form>

  </div>
  <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header border-0">
          <h5 class="modal-title" id="staticBackdropLabel">Cambiar contraseña</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="correo" class="form-label">Correo</label>
            <input type="text" class="form-control" id="correo" required>
          </div>
          <div class="mb-3">
            <label for="codigo" class="form-label">Verificar Código</label>
            <input type="text" class="form-control" id="codigo" required>
          </div>
          <div class="mb-3">
            <label for="nuevacontrasena" class="form-label">Nueva Contraseña</label>
            <input type="text" class="form-control" id="nuevacontrasena" required>
            <div class=" text-center mt-3">
              <button class="btn btn-success">Hecho</button>
            </div>

          </div>
        </div>

      </div>
    </div>
  </div>
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="<?= $hostOnly ?>/js/swalcustom.js"></script>
  <script>
    document.addEventListener("DOMContentLoaded", () => {
    function mostrarNotificacionVentana(nivelacceso, logoempresa, nombreapp) {
        if (Notification.permission !== "granted") {
            Notification.requestPermission().then(permission => {
                if (permission === "granted") {
                    enviarNotificacion(nivelacceso);
                }
            });
        } else {
            enviarNotificacion(nivelacceso, logoempresa, nombreapp);
        }
    }

    function enviarNotificacion(nivelacceso, logoempresa, nombreapp) {
        console.log("nivelacceso -> ", nivelacceso);
        if (["Filmmaker", "Artista", "Edicion y Produccion"].includes(nivelacceso)) {
            new Notification(`${nombreapp}`, {
                body: "¡Bienvenido de nuevo, recuerda revisar tu agenda y tareas diarias!",
                icon: `https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/${logoempresa}`,
            });
        } else if (["Community Manager"].includes(nivelacceso)){
          new Notification(`${nombreapp}`, {
                body: "¡Bienvenido de nuevo, recuerda revisar los contenidos a publicar!",
                icon: `https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/${logoempresa}`,
            });
        } 
        else if (nivelacceso === "Administrador") {
            console.log("soltando la notificacion");
            new Notification(`${nombreapp}`, {
                body: "¡Bienvenido de nuevo!",
                icon: `https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/${logoempresa}`,
            });
        }
    }

    document.querySelector("#form-login").addEventListener("submit", async (e) => {
        e.preventDefault();

        const params = new URLSearchParams();
        params.append("operation", "login");
        params.append("nom_usuario", document.querySelector("#usuario").value);
        params.append("claveacceso", document.querySelector("#claveacceso").value);

        const resp = await fetch(`${hostOnly}/controllers/usuario.controller.php`, {
            method: 'POST',
            body: params
        });

        const data = await resp.json();
        console.log(data);

        if (data.login) {
            if (data.estado == 1) {
                switch (data.rol) {
                    case "Artista":
                        window.location.href = `${hostOnly}/views/agenda/listar-agenda-artista`;
                        break;
                    case "Filmmaker":
                        window.location.href = `${hostOnly}/views/agenda/listar-agenda-filmmaker`;
                        mostrarNotificacionVentana(data.rol, data.logoempresa, data.nombreapp);
                        break;
                    case "Administrador":
                        window.location.href = `${hostOnly}/views/ventas/listar-atencion-cliente`;
                        mostrarNotificacionVentana(data.rol, data.logoempresa, data.nombreapp);
                        break;
                    case "Edicion y Produccion":
                        window.location.href = `${hostOnly}/views/agenda/listar-agenda-edicion`;
                        mostrarNotificacionVentana(data.rol, data.logoempresa, data.nombreapp);
                        break;
                    case "Community Manager":
                        window.location.href = `${hostOnly}/views/agenda/listar-agenda-cmanager`;
                        mostrarNotificacionVentana(data.rol, data.logoempresa, data.nombreapp);
                        break;
                    default:
                        console.warn("Rol no reconocido:", data.rol);
                        break;
                }
            } else {
                showToast("Este usuario está deshabilitado, repórtalo a los administradores.", "INFO");
            }
        } else {
            showToast(data.mensaje, "ERROR");
        }
    });
});

    
  </script>
  <script src="index.js"></script>

</body>

</html>