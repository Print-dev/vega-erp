<?php

session_start();
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
// cuando se pone en visible true se pone como dropdown
$accesos = [
  'Administrador' => [
    ['modulo' => 'ventas', 'ruta' => '', 'texto' => 'Ventas', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-chart-simple'],

    ['modulo' => 'ventas', 'ruta' => 'listar-atencion-cliente', 'subruta' => '', 'texto' => 'Atención cliente', 'visible' => false, 'icono' => 'fa-solid fa-list'],
    ['modulo' => 'ventas', 'ruta' => 'actualizar-atencion-cliente', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'ventas', 'ruta' => 'registrar-atencion-cliente', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],



    ['modulo' => 'utilitario', 'ruta' => '', 'texto' => 'Utilitario', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-folder'],

    ['modulo' => 'utilitario', 'ruta' => 'listar-usuarios', 'subruta' => 'usuarios', 'texto' => 'Usuarios', 'visible' => false, 'icono' => 'fa-solid fa-list'],
    ['modulo' => 'utilitario', 'ruta' => 'registrar-usuario', 'subruta' => 'usuarios', 'visible' => false],
    ['modulo' => 'utilitario', 'ruta' => 'listar-tarifas', 'subruta' => 'tarifas', 'texto' => 'Tarifario', 'visible' => false, 'icono' => 'fa-solid fa-list'],
    ['modulo' => 'utilitario', 'ruta' => 'registrar-tarifa', 'subruta' => 'tarifas', 'visible' => false],


    
    ['modulo' => 'pyp', 'ruta' => '', 'texto' => 'Planeamiento', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-lightbulb'],

    ['modulo' => 'pyp', 'ruta' => 'listar-planeamientos', 'subruta' => 'planeamientos', 'texto' => 'Planeamientos', 'visible' => false, 'icono' => 'fa-solid fa-list'],
    ['modulo' => 'pyp', 'ruta' => 'registrar-planeamiento', 'subruta' => 'planeamientos', 'visible' => false],
    ['modulo' => 'pyp', 'ruta' => 'listar-presupuestos', 'subruta' => 'presupuestos', 'texto' => 'Presupuestos', 'visible' => false, 'icono' => 'fa-solid fa-list'],
    ['modulo' => 'pyp', 'ruta' => 'registrar-presupuesto', 'subruta' => 'presupuestos', 'visible' => false],


    ['modulo' => 'agenda', 'ruta' => 'listar-agenda', 'subruta' => '', 'texto' => 'Agenda', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],

  ],
  "Artista" => [
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda', 'subruta' => '', 'texto' => 'Agenda', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],
  ],
  "Filmmaker" => [
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda', 'subruta' => '', 'texto' => 'Agenda', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],
  ],
];

if (!isset($_SESSION['login']) || $_SESSION['login']['estado'] == false) {
  $session = [
    "estado" => false,
    "inicio" => "",
    "idusuario" => -1,
    "apellidos" => "",
    "nombres" => "",
    "nom_usuario" => "",
    "claveacceso" => "",
    "nivelacceso" => "",
    "accesos" => [],
  ];
}

require_once '../models/Usuario.php';

$usuario = new Usuario();

if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'destroy':
      session_destroy();
      session_unset();
      header("location:http://localhost/vega-erp/");
      break;

    case 'obtenerUsuarioPorId':
      echo json_encode($usuario->obtenerUsuarioPorId(['idusuario' => $_GET['idusuario']]));
      break;

    case 'obtenerPersonaPorDoc':
      echo json_encode($usuario->obtenerPersonaPorDoc(['num_doc' => $_GET['num_doc']]));
      break;

    case 'obtenerUsuarioPorNivel':
      echo json_encode($usuario->obtenerUsuarioPorNivel(['idnivelacceso' => $_GET['idnivelacceso']]));
      break;

    case 'filtrarUsuarios':
      $cleanData = [
        'nivelacceso' => $_GET['nivelacceso'] === "" ? null : $usuario->limpiarCadena($_GET['nivelacceso']),
        'numdoc' => $_GET['numdoc'] === "" ? null : $usuario->limpiarCadena($_GET['numdoc']),
        'nombres' => $_GET['nombres'] === "" ? null : $usuario->limpiarCadena($_GET['nombres']),
        'apellidos' => $_GET['apellidos'] === "" ? null : $usuario->limpiarCadena($_GET['apellidos']),
        'telefono' => $_GET['telefono'] === "" ? null : $usuario->limpiarCadena($_GET['telefono']),
        'nomusuario' => $_GET['nomusuario'] === "" ? null : $usuario->limpiarCadena($_GET['nomusuario']),
      ];
      echo json_encode($usuario->filtrarUsuarios($cleanData));
      break;
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'login':
      $nomUser = $usuario->limpiarCadena($_POST['nom_usuario']);
      $registro = $usuario->login(['nom_usuario' => $nomUser]);

      $resultados = [
        "login" => false,
        "mensaje" => ""
      ];

      if ($registro && $registro[0]['estado'] > 0) {
        $claveEncriptada = $registro[0]['claveacceso']; //DB
        $claveIngresada = $usuario->limpiarCadena($_POST['claveacceso']);

        if (password_verify($claveIngresada, $claveEncriptada)) {
          $resultados['login'] = true;
          $resultados['mensaje'] = "Bienvenido";
          $resultados['rol'] = $registro[0]['nivelacceso'];

          //Ya esta validado
          $session['estado'] = true;
          $session['inicio'] = date('h:i:s d-m-Y');
          $session['idusuario'] = $registro[0]['idusuario'];
          $session['apellidos'] = $registro[0]['apellidos'];
          $session['nombres'] = $registro[0]['nombres'];
          $session['nom_usuario'] = $registro[0]['nom_usuario'];
          $session['claveacceso'] = $registro[0]['claveacceso'];
          $session['nivelacceso'] = $registro[0]['nivelacceso'];
          $session['idnivelacceso'] = $registro[0]['idnivelacceso'];

          //die(json_encode($accesos[$registro[0]['nivelacceso']]));
          //$accesos = $usuario->getPermisos(['idperfil' => $registro[0]['idperfil']]);
          $session['accesos'] = $accesos[$registro[0]['nivelacceso']]; //temporal

        } else {
          $resultados['mensaje'] = "Error en la contraseña";
          $session['estado'] = false;
          $session['apellidos'] = "";
          $session['nombres'] = "";
        }
      } else {
        if ($registro && $registro[0]['estado'] == 0) {
          $resultados['mensaje'] = "En el sistema estas como inactivo, solicita una reactivacion de la cuenta";
        } else if (!$registro) {
          $resultados['mensaje'] = "No existe el usuario";
        }
        $session['estado'] = false;
        $session['apellidos'] = "";
        $session['nombres'] = "";
      }

      $_SESSION['login'] = $session;
      //die(json_encode($_SESSION['login']));

      echo json_encode($resultados);
      break;

    case 'registrarUsuario':
      $clave = $usuario->limpiarCadena($_POST['claveacceso']);
      $cleanData = [
        'idpersona' => $usuario->limpiarCadena($_POST['idpersona']),
        'nom_usuario' => $usuario->limpiarCadena($_POST['nom_usuario']),
        'claveacceso' => password_hash($clave, PASSWORD_BCRYPT),
        'idnivelacceso' => $usuario->limpiarCadena($_POST['idnivelacceso'])
      ];

      $respuesta = ['idusuario' => -1];
      $idusuario = $usuario->registrarUsuario($cleanData);

      if ($idusuario > 0) {
        $respuesta['idusuario'] = $idusuario;
      }

      echo json_encode($respuesta);
      break;
  }
}
