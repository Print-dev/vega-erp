<?php
date_default_timezone_set('America/Lima'); // o tu zona horaria correcta

$hostOnlyHeader = "http://localhost/vega-erp";
session_start();
if (!isset($_SESSION['login']) || $_SESSION['login']['estado'] == false) {
  header('location:' . $hostOnlyHeader);
} else {
  //El usuario logeado, solo se le permitira acceso a las vistas indicadores por su PERFIL
  $url = $_SERVER['REQUEST_URI']; //obtener url
  $rutaCompleta = explode("/", $url); //url ->array()
  $rutaCompleta = array_filter($rutaCompleta);
  $totalElementos = count($rutaCompleta);
  //Buscar la vista actual en la lista de acceso
  $vistaActual = $rutaCompleta[$totalElementos];
  //die(var_dump($vistaActual));
  $listaAcceso = $_SESSION['login']['accesos'];

  //die(var_dump($totalElementos));

  //Verificando el permiso

  $encontrado = false;
  $i = 0;

  while (($i < count($listaAcceso)) && !$encontrado) {
    if ($listaAcceso[$i]['ruta'] == $vistaActual) {
      $encontrado = true;
    }
    $i++;
  }

  //  die(print_r($listaAcceso));

  if (!$encontrado) {
    header('location:' . $hostOnlyHeader);
  }
}
$usuario = $_SESSION['login']['nom_usuario'];

$rol = "";
switch ($_SESSION['login']['nivelacceso']) {
  case 'Administrador':
    $rol = "Administrador";
    break;
  case 'Filmmaker':
    $rol = "Filmmaker";
    break;
  case 'Artista':
    $rol = "Artista";
    break;
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= $_SESSION['login']['nombreapp'] ?></title>
  <link rel="icon" id="link-meta" type="image/png" href="https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/<?= $_SESSION['login']['logoempresa'] ?>">

  <!-- Bootstrap -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
    crossorigin="anonymous" />
  <!-- Font API GOOGLE -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

  <!-- Volt CSS -->
  <link type="text/css" href="<?= $hostOnlyHeader ?>/css/dashboard/volt.css" rel="stylesheet" />
  <!-- Estilos personalizados -->
  <link rel="stylesheet" href="<?= $hostOnlyHeader ?>/css/global.css">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

  <!-- jKanban CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jkanban@1.2.0/dist/jkanban.min.css">

  <!-- list-usuario -->
  <link rel="stylesheet" href="<?= $hostOnlyHeader ?>/css/usuarios/list-usuario.css">
  <link rel="stylesheet" href="<?= $hostOnlyHeader ?>/css/usuarios/registrar-usuario.css">

  <!-- activo -->
  <!-- <link rel="stylesheet" href="<?= $hostOnlyHeader ?>/css/activos/lista-activo.css">
  <link rel="stylesheet" href="<?= $hostOnlyHeader ?>/css/activos/registrar-activo.css"> -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Archivo+Black&display=swap" rel="stylesheet">

  <!-- JQUERY DATATABLES -->
  <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

  <!-- Bajas -->
  <!-- <link rel="stylesheet" href="<?= $hostOnlyHeader ?>/css/baja-activo.css"> -->

  <!-- JQUERY -->

  <script
    src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
    integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
    crossorigin="anonymous"
    referrerpolicy="no-referrer"></script>
  <link
    rel="stylesheet"
    href="//cdn.datatables.net/2.1.8/css/dataTables.dataTables.min.css" />
  <link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
  <link rel="stylesheet" href="<?= $hostOnlyHeader ?>/css/global.css">


</head>
<style>
  #encabezado-titulo {
    font-family: "Outfit", serif;
    font-weight: 400;
    font-style: normal;

  }


  #links {
    color: rgb(66, 66, 66);
    display: flex;
    align-items: center;
    /* Mantener tamaño fijo */
    padding: 10px;
    /* Ajuste uniforme */
    transition: background-color 0.1s, color 0.1s;
  }

  #links:hover {
    background-color: #ffcc00;
    color: black;
    font-weight: bold;
  }

  .sidebar-text {
    flex-grow: 1;
    /* Hace que el texto ocupe el espacio disponible */
    white-space: nowrap;
    /* Evita que el texto se mueva de línea */
  }

  .toggle-icon {
    transition: transform 0.1s ease;
    margin-left: auto;
    /* Empuja el icono a la derecha */
  }

  /* Evitar desplazamiento al abrir dropdown */
  .sidebar-item .collapse {
    transition: none !important;
    /* Evita movimientos raros */
    margin-left: 0 !important;
    padding-left: 0 !important;
  }

  .beta-banner {
    width: 100%;
    background-color: #ffcc00;
    color: #000;
    text-align: center;
    padding: 10px;
    font-weight: bold;
  }

  .notificacion-item {
    background: #f8f9fa;
    padding: 10px;
    margin: 5px 0;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s;
  }

  .notificacion-item:hover {
    background: #e9ecef;
  }

  #options-sidebar {
    max-height: 400px;
    /* Ajusta la altura máxima */
    overflow-y: auto;
    /* Agrega scroll vertical */
    overflow-x: hidden;
    /* Oculta el scroll horizontal */
    scrollbar-width: thin;
    scrollbar-color: #888 #f1f1f1;
  }

  /* Evitar que los elementos internos causen desbordamiento */
  #options-sidebar li {
    white-space: nowrap;
    /* Evita que los elementos se expandan horizontalmente */
    overflow: hidden;
    text-overflow: ellipsis;
    /* Opcional: agrega "..." si el texto es muy largo */
  }

  /* Para navegadores basados en WebKit (Chrome, Safari, Edge) */
  #options-sidebar::-webkit-scrollbar {
    width: 8px;
  }

  #options-sidebar::-webkit-scrollbar-track {
    background: #f1f1f1;
  }

  #options-sidebar::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 4px;
  }

  #options-sidebar::-webkit-scrollbar-thumb:hover {
    background: #555;
  }

  #sidebarMenu {
    transition: all 0.3s ease;
  }

  .nav-link.active {
    background-color: #ffcc00;
    /* Amarillo suave */
    color: rgb(255, 0, 0);
    /* Letras blancas */
    font-weight: bold;

    /* Sombra sutil */
  }

</style>
<!-- <div class="beta-banner">Vega Producciones V.1.0</div>
 -->

<body style="background-color:rgb(250, 250, 251); ">

  <!-- BOTON HAMBURGUESA EN RESPONSIVE -->
  <nav class="navbar navbar-light bg-white px-4 col-12 d-lg-none" style="box-shadow: 0px 2px 17px -8px rgba(0,0,0,0.27);
    -webkit-box-shadow: 0px 2px 17px -8px rgba(0,0,0,0.27);
    -moz-box-shadow: 0px 2px 17px -8px rgba(0,0,0,0.27);">
    <div class="d-flex align-items-center ms-auto">
      <button
        class="navbar-toggler d-lg-none collapsed"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#sidebarMenu"
        aria-controls="sidebarMenu"
        aria-expanded="false"
        aria-label="Toggle navigation"
        style=" border: 1px solid black;">
        <span class="navbar-toggler-icon" style="background-color: white;"></span>
      </button>
    </div>
  </nav>
  <!-- BOTON HAMBURGUESA EN RESPONSIVE-->

  <!-- SIDEBAR -->
  <nav id="sidebarMenu" class="sidebar bg-white text-white sidebar-visible border-primary" data-simplebar>

    <div class=" px-4 pt-3"> <!-- sidebar-inner -->
      <div
        class="d-flex d-md-none align-items-center justify-content-between justify-content-md-center pb-4">
        <div class="collapse-close d-md-none">
          <a
            href="#sidebarMenu"
            data-bs-toggle="collapse"
            data-bs-target="#sidebarMenu"
            aria-controls="sidebarMenu"
            aria-expanded="true"
            aria-label="Toggle navigation">
            <svg
              class="icon icon-xs"
              fill="dark"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg">
              <path
                fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"></path>
            </svg>
          </a>
        </div>
      </div>
      <!-- OPCIONES SIDEBAR -->
      <ul class="nav flex-column pt-3 pt-md-0" id="options-sidebar" style="height: auto; max-height: 1500px; overflow-y: auto;">
        <li class="nav-item mb-3">
          <a class="nav-link bg-white d-flex align-items-center" href="<?= $hostOnlyHeader ?>/views/ventas/listar-atencion-cliente">
            <span class="sidebar-icon me-2">
              <img
                src="https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/<?= $_SESSION['login']['logoempresa'] ?>"
                alt="Logo"
                class="rounded"
                style="width: 40px; object-fit: cover;">
            </span>
            <span class="sidebar-text text-dark" id="encabezado-titulo"><?= $_SESSION['login']['nombreapp'] ?></span>
          </a>
        </li>
        <?php
        foreach ($listaAcceso as $access) {
          $activeClass = ($vistaActual == $access['ruta']) ? 'active' : '';
          $showClass = ($vistaActual == $access['ruta']) ? 'show' : '';
          //die($subAccess['ruta']);

          if ($access['visible'] && $access['modulo'] !== "ventas" && $access['modulo'] !== "utilitario" && $access['modulo'] !== "pyp" && $access['modulo'] !== "contabilidad" && $access['modulo'] !== "agenda" && $access['modulo'] !== "comprobantes" && $access['modulo'] !== "colaboradores" && $access['modulo'] !== "gtxp" && $access['modulo'] !== "nominas") {

            echo "
              <li class='nav-item' >
                <a href='{$hostOnlyHeader}/views/{$access['modulo']}/{$access['ruta']}' class='nav-link {$activeClass}' id='links'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                </a>
              </li>";
          } else if ($access['modulo'] === "ventas" && $access['visible']) {
            echo "
              <li class='sidebar-item nav-item'>
                <a href='#' class='sidebar-link collapsed active sidebar-text d-flex align-items-center' data-bs-toggle='collapse' id='links' data-bs-target='#ventas'
                  aria-expanded='false' aria-controls='ventas'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                  <i class='fa-solid fa-angle-down ms-auto mt-2 toggle-icon'></i>
                </a>              
              </li> 
              <ul id='ventas' class='sidebar-dropdown list-unstyled collapse' data-bs-parent='#ventas'>";

            foreach ($listaAcceso as $subAccess) {
              if (!$subAccess['visible'] && $subAccess['modulo'] === "ventas" && !empty($subAccess['texto']) && !empty($subAccess['icono'])) {
                echo "
                <li class='sidebar-item nav-item list-ventas'>
                  <a href='{$hostOnlyHeader}/views/{$subAccess['modulo']}/{$subAccess['ruta']}' class='sidebar-link nav-link {$activeClass} sidebar-text ms-4' id='links'>
                    <i class='{$subAccess['icono']}'></i>
                    <span class='sidebar-text mx-2'>{$subAccess['texto']}</span>
                  </a>
                </li>";
              }
            }
            echo "</ul>";
          } else if ($access['modulo'] === "utilitario" && $access['visible']) {

            if ((isset($access['only']) && $access['only'])) {
              /* die(print_r("hola")); */
              echo "
              <li class='nav-item' >
                <a href='{$hostOnlyHeader}/views/{$access['modulo']}/{$access['subruta']}/{$access['ruta']}' class='nav-link' id='links'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                </a>
              </li>";
              break;
            }
            echo "
              <li class='sidebar-item nav-item'>
                <a href='#' class='sidebar-link collapsed nav-link sidebar-text d-flex align-items-center' data-bs-toggle='collapse' id='links' data-bs-target='#utilitario'
                  aria-expanded='false' aria-controls='utilitario'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                  <i class='fa-solid fa-angle-down ms-auto mt-2 toggle-icon'></i>
                </a>              
              </li> 
              <ul id='utilitario' class='sidebar-dropdown list-unstyled collapse' data-bs-parent='#utilitario'>";

            foreach ($listaAcceso as $subAccess) {
              $rutaCompleta = "{$hostOnlyHeader}/views/{$subAccess['modulo']}/";
              if (!empty($subAccess['subruta'])) {
                $rutaCompleta .= "{$subAccess['subruta']}/";
              }
              $rutaCompleta .= "{$subAccess['ruta']}";
              if (!$subAccess['visible'] && $subAccess['modulo'] === "utilitario" && !empty($subAccess['texto']) && !empty($subAccess['icono'])) {
                echo "
                <li class='sidebar-item nav-item list-utilitario'>
                  <a href='{$rutaCompleta}' class='sidebar-link nav-link sidebar-text ms-4' id='links'>
                    <i class='{$subAccess['icono']}'></i>
                    <span class='sidebar-text mx-2'>{$subAccess['texto']}</span>
                  </a>
                </li>";
              }
            }
            echo "</ul>";
          } else if ($access['modulo'] === "pyp" && $access['visible']) {
            echo "
              <li class='sidebar-item nav-item'>
                <a href='#' class='sidebar-link collapsed nav-link sidebar-text d-flex align-items-center' data-bs-toggle='collapse' id='links' data-bs-target='#pyp'
                  aria-expanded='false' aria-controls='pyp'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                  <i class='fa-solid fa-angle-down ms-auto mt-2 toggle-icon'></i>
                </a>              
              </li> 
              <ul id='pyp' class='sidebar-dropdown list-unstyled collapse' data-bs-parent='#pyp'>";

            foreach ($listaAcceso as $subAccess) {
              $rutaCompleta = "{$hostOnlyHeader}/views/{$subAccess['modulo']}/";
              if (!empty($subAccess['subruta'])) {
                $rutaCompleta .= "{$subAccess['subruta']}/";
              }
              $rutaCompleta .= "{$subAccess['ruta']}";
              if (!$subAccess['visible'] && $subAccess['modulo'] === "pyp" && !empty($subAccess['texto']) && !empty($subAccess['icono'])) {
                echo "
                <li class='sidebar-item nav-item list-pyp'>
                  <a href='{$rutaCompleta}' class='sidebar-link nav-link sidebar-text ms-4' id='links'>
                    <i class='{$subAccess['icono']}'></i>
                    <span class='sidebar-text mx-2'>{$subAccess['texto']}</span>
                  </a>
                </li>";
              }
            }
            echo "</ul>";
          } else if ($access['modulo'] === "contabilidad" && $access['visible']) {
            echo "
              <li class='sidebar-item nav-item'>
                <a href='#' class='sidebar-link collapsed nav-link sidebar-text d-flex align-items-center' data-bs-toggle='collapse' id='links' data-bs-target='#contabilidad'
                  aria-expanded='false' aria-controls='contabilidad'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                  <i class='fa-solid fa-angle-down ms-auto mt-2 toggle-icon'></i>
                </a>              
              </li> 
              <ul id='contabilidad' class='sidebar-dropdown list-unstyled collapse' data-bs-parent='#contabilidad'>";

            foreach ($listaAcceso as $subAccess) {
              $rutaCompleta = "{$hostOnlyHeader}/views/{$subAccess['modulo']}/";
              if (!empty($subAccess['subruta'])) {
                $rutaCompleta .= "{$subAccess['subruta']}/";
              }
              $rutaCompleta .= "{$subAccess['ruta']}";
              if (!$subAccess['visible'] && $subAccess['modulo'] === "contabilidad" && !empty($subAccess['texto']) && !empty($subAccess['icono'])) {
                echo "
                <li class='sidebar-item nav-item list-contabilidad'>
                  <a href='{$rutaCompleta}' class='sidebar-link nav-link sidebar-text ms-4' id='links'>
                    <i class='{$subAccess['icono']}'></i>
                    <span class='sidebar-text mx-2'>{$subAccess['texto']}</span>
                  </a>
                </li>";
              }
            }
            echo "</ul>";
          } else if ($access['modulo'] === "agenda" && $access['visible']) {
            echo "
              <li class='sidebar-item nav-item'>
                <a href='#' class='sidebar-link collapsed nav-link sidebar-text d-flex align-items-center' data-bs-toggle='collapse' id='links' data-bs-target='#agenda'
                  aria-expanded='false' aria-controls='agenda'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                  <i class='fa-solid fa-angle-down ms-auto mt-2 toggle-icon'></i>
                </a>              
              </li> 
              <ul id='agenda' class='sidebar-dropdown list-unstyled collapse' data-bs-parent='#agenda'>";

            foreach ($listaAcceso as $subAccess) {
              if (!$subAccess['visible'] && $subAccess['modulo'] === "agenda" && !empty($subAccess['texto']) && !empty($subAccess['icono'])) {
                echo "
                <li class='sidebar-item nav-item list-agenda'>
                  <a href='{$hostOnlyHeader}/views/{$subAccess['modulo']}/{$subAccess['ruta']}' class='sidebar-link nav-link sidebar-text ms-4' id='links'>
                    <i class='{$subAccess['icono']}'></i>
                    <span class='sidebar-text mx-2'>{$subAccess['texto']}</span>
                  </a>
                </li>";
              }
            }
            echo "</ul>";
          } else if ($access['modulo'] === "comprobantes" && $access['visible']) {
            echo "
              <li class='sidebar-item nav-item'>
                <a href='#' class='sidebar-link collapsed nav-link sidebar-text d-flex align-items-center' data-bs-toggle='collapse' id='links' data-bs-target='#comprobantes'
                  aria-expanded='false' aria-controls='comprobantes'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                  <i class='fa-solid fa-angle-down ms-auto mt-2 toggle-icon'></i>
                </a>              
              </li> 
              <ul id='comprobantes' class='sidebar-dropdown list-unstyled collapse' data-bs-parent='#comprobantes'>";

            foreach ($listaAcceso as $subAccess) {
              $rutaCompleta = "{$hostOnlyHeader}/views/{$subAccess['modulo']}/";
              if (!empty($subAccess['subruta'])) {
                $rutaCompleta .= "{$subAccess['subruta']}/";
              }
              $rutaCompleta .= "{$subAccess['ruta']}";
              if (!$subAccess['visible'] && $subAccess['modulo'] === "comprobantes" && !empty($subAccess['texto']) && !empty($subAccess['icono'])) {
                echo "
                <li class='sidebar-item nav-item list-comprobantes'>
                  <a href='{$rutaCompleta}' class='sidebar-link nav-link sidebar-text ms-4' id='links'>
                    <i class='{$subAccess['icono']}'></i>
                    <span class='sidebar-text mx-2'>{$subAccess['texto']}</span>
                  </a>
                </li>";
              }
            }
            echo "</ul>";
          } else if ($access['modulo'] === "colaboradores" && $access['visible']) {
            echo "
              <li class='sidebar-item nav-item'>
                <a href='#' class='sidebar-link collapsed nav-link sidebar-text d-flex align-items-center' data-bs-toggle='collapse' id='links' data-bs-target='#colaboradores'
                  aria-expanded='false' aria-controls='colaboradores'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                  <i class='fa-solid fa-angle-down ms-auto mt-2 toggle-icon'></i>
                </a>              
              </li> 
              <ul id='colaboradores' class='sidebar-dropdown list-unstyled collapse' data-bs-parent='#colaboradores'>";

            foreach ($listaAcceso as $subAccess) {
              if (!$subAccess['visible'] && $subAccess['modulo'] === "colaboradores" && !empty($subAccess['texto']) && !empty($subAccess['icono'])) {
                echo "
                <li class='sidebar-item nav-item list-colaboradores'>
                  <a href='{$hostOnlyHeader}/views/{$subAccess['modulo']}/{$subAccess['ruta']}' class='sidebar-link nav-link sidebar-text ms-4' id='links'>
                    <i class='{$subAccess['icono']}'></i>
                    <span class='sidebar-text mx-2'>{$subAccess['texto']}</span>
                  </a>
                </li>";
              }
            }
            echo "</ul>";
          } else if ($access['modulo'] === "gtxp" && $access['visible']) {
            echo "
              <li class='sidebar-item nav-item'>
                <a href='#' class='sidebar-link collapsed nav-link sidebar-text d-flex align-items-center' data-bs-toggle='collapse' id='links' data-bs-target='#gtxp'
                  aria-expanded='false' aria-controls='gtxp'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                  <i class='fa-solid fa-angle-down ms-auto mt-2 toggle-icon'></i>
                </a>              
              </li> 
              <ul id='gtxp' class='sidebar-dropdown list-unstyled collapse' data-bs-parent='#gtxp'>";

            foreach ($listaAcceso as $subAccess) {
              if (!$subAccess['visible'] && $subAccess['modulo'] === "gtxp" && !empty($subAccess['texto']) && !empty($subAccess['icono'])) {
                echo "
                <li class='sidebar-item nav-item list-gtxp'>
                  <a href='{$hostOnlyHeader}/views/{$subAccess['modulo']}/{$subAccess['ruta']}' class='sidebar-link nav-link sidebar-text ms-4' id='links'>
                    <i class='{$subAccess['icono']}'></i>
                    <span class='sidebar-text mx-2'>{$subAccess['texto']}</span>
                  </a>
                </li>";
              }
            }
            echo "</ul>";
          } else if ($access['modulo'] === "nominas" && $access['visible']) {
            echo "
              <li class='sidebar-item nav-item'>
                <a href='#' class='sidebar-link collapsed nav-link sidebar-text d-flex align-items-center' data-bs-toggle='collapse' id='links' data-bs-target='#nominas'
                  aria-expanded='false' aria-controls='nominas'>
                  <i class='{$access['icono']}'></i>
                  <span class='sidebar-text mx-2'>{$access['texto']}</span>
                  <i class='fa-solid fa-angle-down ms-auto mt-2 toggle-icon'></i>
                </a>              
              </li> 
              <ul id='nominas' class='sidebar-dropdown list-unstyled collapse' data-bs-parent='#nominas'>";

            foreach ($listaAcceso as $subAccess) {
              if (!$subAccess['visible'] && $subAccess['modulo'] === "nominas" && !empty($subAccess['texto']) && !empty($subAccess['icono'])) {
                echo "
                <li class='sidebar-item nav-item list-nominas'>
                  <a href='{$hostOnlyHeader}/views/{$subAccess['modulo']}/{$subAccess['ruta']}' class='sidebar-link nav-link sidebar-text ms-4' id='links'>
                    <i class='{$subAccess['icono']}'></i>
                    <span class='sidebar-text mx-2'>{$subAccess['texto']}</span>
                  </a>
                </li>";
              }
            }
            echo "</ul>";
          }
        }
        ?>


      </ul>
      <!--/ OPCIONES SIDEBAR -->
    </div>
  </nav>
  <!-- FIN SIDEBAR -->

  <main class="content">
    <!-- NAVBAR-HEADER -->
    <nav
      class="navbar navbar-top navbar-expand ps-0 pb-0">
      <div class="container-fluid px-0">
        <div
          class="d-flex justify-content-between w-100"
          id="navbarSupportedContent">
          <div class="d-flex align-items-center">
            <!-- Botón para colapsar sidebar en escritorio -->
            <button id="toggleSidebar" class="btn btn-sm btn-outline-dark d-none d-lg-inline-block me-2">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-sm" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12h18M3 6h18M3 18h18" />
              </svg>
            </button>
            <div id="sidebar-toggle" class="sidebar-toggle me-3 btn btn-icon-only d-none d-lg-inline-block align-items-center justify-content-center">

            </div>
          </div>
          <!-- Navbar links (PERFIL USUARIO) -->
          <ul class="navbar-nav align-items-center">
            <!-- LOGO ACTUALIZACIONES -->
            <!-- <li class="nav-item dropdown" id="not-actualizaciones">
              <a
                class="nav-link text-dark notification-bell unread dropdown-toggle"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false">
                <i class="fa-solid fa-circle-exclamation"></i>
              </a>

            </li> -->

            <!-- LOGO NOTIFICACION -->
            <li class="nav-item dropdown">
              <a
                class="nav-link text-dark notification-bell unread dropdown-toggle"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false">
                <svg
                  class="icon icon-sm text-gray-900"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                  xmlns="http://www.w3.org/2000/svg">
                  <path
                    d="M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z"></path>
                </svg>
              </a>

              <div class="dropdown-menu dropdown-menu-lg dropdown-menu-center mt-2 py-0 ml-3">
                <div class="list-group list-group-flush">
                  <a href="#" class="text-center text-primary fw-bold border-bottom border-light py-3">
                    Notificaciones
                  </a>
                  <div id="list-notificaciones" class="px-3" style="max-height: 500px; min-height: 100px; overflow-y: auto;">
                    <!-- Aquí se cargarán las notificaciones -->
                  </div>
                  <a href="#" class="dropdown-item text-center fw-bold rounded-bottom py-3" id="show-all-notificaciones">
                    <svg class="icon icon-xxs text-gray-400 me-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                      <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"></path>
                      <path fill-rule="evenodd"
                        d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10z"
                        clip-rule="evenodd"></path>
                    </svg>
                    Ver anteriores
                  </a>
                </div>
              </div>

            </li>
            <!-- FIN LOGO NOTIFICACION -->

            <!-- USER - LOGOUT -->
            <li class="nav-item dropdown ms-lg-3 me-2">
              <a
                class="nav-link dropdown-toggle pt-1 px-0"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false">
                <div class="media d-flex align-items-center">
                  <img class="avatar rounded-circle" alt="Image placeholder" src="https://cdn-icons-png.flaticon.com/512/9797/9797558.png" />
                  <div class="media-body ms-2 text-dark align-items-center d-none d-lg-block">
                    <span class="mb-0 font-small fw-bold text-gray-900" id="nomuser"><?= $usuario ?></span>
                  </div>
                </div>
              </a>
              <!-- Menú desplegable unificado -->
              <ul class="dropdown-menu dropdown-menu-end mt-2 py-1">
                <!-- Opción de rol de usuario -->
                <li>
                  <a class="dropdown-item d-flex align-items-center" id="rolUser">
                    Eres: <?= $rol ?>
                  </a>
                  <a class="dropdown-item d-flex align-items-center" id="configurar-perfil">
                    Configuracion
                  </a>
                </li>
                <!-- Separador -->
                <li>
                  <hr class="dropdown-divider">
                </li>
                <!-- Opción de logout -->
                <li>
                  <a class="dropdown-item d-flex align-items-center" href="<?= $hostOnlyHeader ?>/controllers/usuario.controller.php?operation=destroy">
                    <svg
                      class="dropdown-icon text-danger me-2"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                      xmlns="http://www.w3.org/2000/svg">
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                    </svg>
                    Cerrar Sesión
                  </a>
                </li>
              </ul>
            </li>
            <!-- FIN USER - LOGOUT -->
          </ul>

        </div>
      </div>
    </nav>

    <div class="modal fade" id="modal-notificacion" tabindex="-1" aria-labelledby="modalnotificacion" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="modalnotificacion">Detalles</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="contenedor-notificacion p-3">

            </div>
          </div>

        </div>
      </div>
    </div>

    <!-- /NAVBAR-HEADER -->
    <!-- <script>
      document.addEventListener("DOMContentLoaded", function() {
        const toggleBtn = document.getElementById("toggleSidebar");
        const sidebar = document.getElementById("sidebarMenu");

        toggleBtn.addEventListener("click", function() {
          sidebar.classList.toggle("d-none");
        });
      });
    </script>
 -->
    <script>
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
      const links = document.querySelectorAll('#options-sidebar .nav-link');
      const sidebarToggleDesktop = document.getElementById('sidebar-toggle');
      const sidebarmenu = $q("#sidebarMenu")


      links.forEach(link => {
        link.addEventListener('click', function(e) {
          links.forEach(el => el.classList.remove('active')); // Quitar "active" de todos
          this.classList.add('active'); // Agregarlo al clickeado
        });
      });

      /* $q("#sidebarToggleDesktop").addEventListener("click", async (e) => {
        sidebarmenu.classList.
      }) */


      /* 
            function toggleSidebar() {
              if (window.innerWidth >= 992) {
                // Desktop: alternar entre contracted y sidebar-visible
                if (sidebar.classList.contains('contracted')) {
                  sidebar.classList.remove('contracted', 'collapse');
                  sidebar.classList.add('sidebar-visible');
                } else {
                  sidebar.classList.remove('sidebar-visible');
                  sidebar.classList.add('contracted', 'collapse');
                }
              } else {
                // Mobile: funcionalidad diferente
                // ... código para mobile
              }
            } */
    </script>

    <script>
      document.addEventListener("DOMContentLoaded", function() {
        const sidebar = document.getElementById("sidebarMenu");
        const toggleBtn = document.getElementById("toggleSidebar");

        // Restaurar el estado contraído desde localStorage
        const isContracted = localStorage.getItem("sidebarContracted") === "true";
        if (isContracted) sidebar.classList.add("contracted");

        // Botón de toggle manual (fijo)
        toggleBtn.addEventListener("click", function() {
          sidebar.classList.toggle("contracted");
          localStorage.setItem("sidebarContracted", sidebar.classList.contains("contracted"));
        });

        // Solo aplicar hover dinámico si está contraído
        sidebar.addEventListener("mouseenter", function() {
          if (sidebar.classList.contains("contracted")) {
            sidebar.classList.remove("contracted");
          }
        });

        sidebar.addEventListener("mouseleave", function() {
          sidebar.classList.add("contracted");
        });
      });
    </script>


    <script>
      const idusuarioLogeado = "<?php echo $_SESSION['login']['idusuario']; ?>"
      const nivelacceso = "<?php echo $_SESSION['login']['nivelacceso']; ?>"
      const rucEmpresa = "<?php echo $_SESSION['login']['ruc']; ?>"
      const razonsocialEmpresa = "<?php echo $_SESSION['login']['razonsocial']; ?>"
    </script>
    <script>
      document.querySelectorAll('.sidebar-item').forEach(item => {
        item.addEventListener('click', function() {
          const icon = this.querySelector('.toggle-icon'); // Selecciona el ícono dentro del <li>
          if (icon?.classList.contains('fa-angle-down')) {
            icon?.classList.remove('fa-angle-down');
            icon?.classList.add('fa-angle-up');
          } else {
            icon?.classList.remove('fa-angle-up');
            icon?.classList.add('fa-angle-down');
          }
        });
      });

      document.querySelector("#configurar-perfil").addEventListener("click", () => {
        window.localStorage.clear()
        window.localStorage.setItem("idusuario", idusuarioLogeado)
        window.location.href = `${hostOnly}/views/utilitario/usuarios/actualizar-usuario`
        return
      })

      if (Notification.permission === "granted") {
        console.log("Permiso ya concedido.");
      } else if (Notification.permission !== "denied") {
        Notification.requestPermission().then(permission => {
          if (permission === "granted") {
            console.log("Permiso concedido.");
          }
        });
      }

      /*       $q("#not-actualizaciones").addEventListener("click", async () => {
              
            })
             */
      /* function mostrarNotificacionViatico() {
        if (Notification.permission === "granted") {
          new Notification("¡Nueva Notificación!", {
            body: "Permiso Concedido (Mnesaje de prueba).",
            icon: "https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/esawybumfjhhujupw5pa.png", // Puedes cambiar el icono
          });
        } else {
          console.log("El usuario no concedió permisos.");
        }
      } */

      /* mostrarNotificacion() */
      /* document.querySelector("#show-all-notificaciones").addEventListener("click", ()=>{

      }) */
    </script>