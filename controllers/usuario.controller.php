<?php

session_start();
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos

$hostOnly  = "http://localhost/vega-erp";
// cuando se pone en visible true se pone como dropdown
$accesos = [
  'Administrador' => [
    ['modulo' => 'ventas', 'ruta' => '', 'texto' => 'Ventas', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-chart-simple'],

    ['modulo' => 'ventas', 'ruta' => 'listar-atencion-cliente', 'subruta' => '', 'texto' => 'Atención cliente', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'ventas', 'ruta' => 'actualizar-atencion-cliente', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'ventas', 'ruta' => 'registrar-atencion-cliente', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],



    ['modulo' => 'utilitario', 'ruta' => '', 'texto' => 'Utilitario', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-folder'],

    ['modulo' => 'utilitario', 'ruta' => 'listar-usuarios', 'subruta' => 'usuarios', 'texto' => 'Usuarios', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'utilitario', 'ruta' => 'registrar-usuario', 'subruta' => 'usuarios', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'actualizar-usuario', 'subruta' => 'usuarios', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'listar-tarifas', 'subruta' => 'tarifas', 'texto' => 'Tarifario', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'utilitario', 'ruta' => 'registrar-tarifa', 'subruta' => 'tarifas', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'listar-tareasdiarias', 'subruta' => 'tareasdiarias', 'texto' => 'Tareas Diarias', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'utilitario', 'ruta' => 'registrar-tareadiaria', 'subruta' => 'tareasdiarias', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'actualizar-usuario', 'subruta' => 'usuarios', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'listar-sucursales', 'subruta' => 'sucursales', 'texto' => 'Sucursales', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'utilitario', 'ruta' => 'registrar-sucursal', 'subruta' => 'sucursales', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'actualizar-sucursal', 'subruta' => 'sucursales', 'texto' => '', 'visible' => false, 'icono' => ''],

    /* ['modulo' => 'pyp', 'ruta' => '', 'texto' => 'Planeamiento', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-lightbulb'],

    ['modulo' => 'pyp', 'ruta' => 'listar-planeamientos', 'subruta' => 'planeamientos', 'texto' => 'Planeamientos', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'pyp', 'ruta' => 'registrar-planeamiento', 'subruta' => 'planeamientos', 'visible' => false],
    ['modulo' => 'pyp', 'ruta' => 'listar-presupuestos', 'subruta' => 'presupuestos', 'texto' => 'Presupuestos', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'pyp', 'ruta' => 'registrar-presupuesto', 'subruta' => 'presupuestos', 'visible' => false], */


    ['modulo' => 'contabilidad', 'ruta' => '', 'texto' => 'Contabilidad', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-calculator'],

    ['modulo' => 'contabilidad', 'ruta' => 'caja-chica', 'subruta' => 'caja-chica', 'texto' => 'Caja Chica', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'contabilidad', 'ruta' => 'registrar-caja', 'subruta' => 'caja-chica', 'texto' => '', 'visible' => false, 'icono' => ''],

    ['modulo' => 'contabilidad', 'ruta' => 'listar-reparticion', 'subruta' => 'reparticion', 'texto' => 'Reparticion', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'contabilidad', 'ruta' => 'registrar-ingresos', 'subruta' => 'reparticion', 'texto' => '',  'visible' => false, 'icono' => ''],
    ['modulo' => 'contabilidad', 'ruta' => 'registrar-egresos', 'subruta' => 'reparticion', 'texto' => '', 'visible' => false, 'icono' => ''],

    /* ['modulo' => 'contabilidad', 'ruta' => 'listar-ingresos', 'subruta' => 'ingresos', 'texto' => 'Ingresos', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'contabilidad', 'ruta' => 'registrar-ingreso', 'subruta' => 'ingresos', 'visible' => false], */


    ['modulo' => 'agenda', 'ruta' => '', 'texto' => 'Agenda', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],

    //['modulo' => 'agenda', 'ruta' => 'listar-agenda', 'subruta' => '', 'texto' => 'Agenda', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-artista', 'subruta' => '', 'texto' => 'Artista', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-edicion', 'subruta' => '', 'texto' => 'Edicion', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-filmmaker', 'subruta' => '', 'texto' => 'Filmmaker', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'agenda', 'ruta' => 'subir-contenido-edicion', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-cmanager', 'subruta' => '', 'texto' => 'Com. Manager', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],


  ],
  "Artista" => [
    ['modulo' => 'agenda', 'ruta' => '', 'texto' => 'Agenda', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],

    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-artista', 'subruta' => '', 'texto' => 'Artista', 'visible' => false, 'icono' => 'fa-solid fa-clipboard'],
    ['modulo' => 'utilitario', 'ruta' => 'actualizar-usuario', 'subruta' => 'usuarios', 'texto' => '', 'visible' => false, 'icono' => ''],

  ],
  "Filmmaker" => [
    ['modulo' => 'agenda', 'ruta' => '', 'texto' => 'Agenda', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-filmmaker', 'subruta' => '', 'texto' => 'Filmmaker', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-edicion', 'subruta' => '', 'texto' => 'Edicion', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'agenda', 'ruta' => 'subir-contenido-edicion', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],

    ['modulo' => 'utilitario', 'ruta' => 'actualizar-usuario', 'subruta' => 'usuarios', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'listar-tareasdiarias', 'subruta' => 'tareasdiarias', 'texto' => 'Tareas Diarias', 'visible' => true, 'icono' => 'fa-solid fa-note-sticky', 'only' => true],
    /*     ['modulo' => 'utilitario', 'ruta' => 'registrar-tareadiaria', 'subruta' => 'tareasdiarias', 'texto' => '', 'visible' => false, 'icono' => ''],
 */
  ],
  "Edicion y Produccion" => [
    ['modulo' => 'agenda', 'ruta' => '', 'texto' => 'Agenda', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],

    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-edicion', 'subruta' => '', 'texto' => 'Edicion', 'visible' => false, 'icono' => 'fa-solid fa-clipboard'],
    ['modulo' => 'agenda', 'ruta' => 'subir-contenido-edicion', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'actualizar-usuario', 'subruta' => 'usuarios', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'listar-tareasdiarias', 'subruta' => 'tareasdiarias', 'texto' => 'Tareas Diarias', 'visible' => true, 'icono' => 'fa-solid fa-note-sticky', 'only' => true],
    /* ['modulo' => 'utilitario', 'ruta' => 'registrar-tareadiaria', 'subruta' => 'tareasdiarias', 'texto' => '', 'visible' => false, 'icono' => ''], */
  ],
  "Community Manager" => [
    /* ['modulo' => 'agenda', 'ruta' => 'listar-agenda-edicion', 'subruta' => '', 'texto' => 'Agenda', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],
    ['modulo' => 'agenda', 'ruta' => 'subir-contenido-edicion', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''], */
    ['modulo' => 'agenda', 'ruta' => '', 'texto' => 'Agenda', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-edicion', 'subruta' => '', 'texto' => 'Edicion', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'agenda', 'ruta' => 'subir-contenido-edicion', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],

    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-cmanager', 'subruta' => '', 'texto' => 'Com. Manager', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'utilitario', 'ruta' => 'actualizar-usuario', 'subruta' => 'usuarios', 'texto' => '', 'visible' => false, 'icono' => ''],
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
      header("location:".$hostOnly);
      break;

    case 'obtenerUsuarioPorId':
      echo json_encode($usuario->obtenerUsuarioPorId(['idusuario' => $_GET['idusuario']]));
      break;

    case 'obtenerUsuarioCompletoPorId':
      echo json_encode($usuario->obtenerUsuarioCompletoPorId(['idusuario' => $_GET['idusuario']]));
      break;

    case 'obtenerPersonaCompletoPorId':
      echo json_encode($usuario->obtenerPersonaCompletoPorId(['idpersona' => $_GET['idpersona']]));
      break;

    case 'obtenerPersonaPorDoc':
      echo json_encode($usuario->obtenerPersonaPorDoc(['num_doc' => $_GET['num_doc']]));
      break;

    case 'obtenerUsuarioPorNivel':
      echo json_encode($usuario->obtenerUsuarioPorNivel(['idnivelacceso' => $_GET['idnivelacceso']]));
      break;

/*     case 'obtenerRepresentanteEmpresa':
      echo json_encode($usuario->obtenerRepresentanteEmpresa());
      break; */

    /* case 'obtenerMarcaAguaPorUsuario':
      echo json_encode($usuario->obtenerMarcaAguaPorUsuario(['idusuario' => $_GET['idusuario']]));
      break; */

    case 'filtrarUsuarios':
      $cleanData = [
        'nivelacceso' => $_GET['nivelacceso'] === "" ? null : $usuario->limpiarCadena($_GET['nivelacceso']),
        'numdoc' => $_GET['numdoc'] === "" ? null : $usuario->limpiarCadena($_GET['numdoc']),
        'nombres' => $_GET['nombres'] === "" ? null : $usuario->limpiarCadena($_GET['nombres']),
        'apellidos' => $_GET['apellidos'] === "" ? null : $usuario->limpiarCadena($_GET['apellidos']),
        'telefono' => $_GET['telefono'] === "" ? null : $usuario->limpiarCadena($_GET['telefono']),
        'nomusuario' => $_GET['nomusuario'] === "" ? null : $usuario->limpiarCadena($_GET['nomusuario']),
        'idsucursal' => $_GET['idsucursal'] === "" ? null : $usuario->limpiarCadena($_GET['idsucursal']),
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
          $resultados['estado'] = $registro[0]['estado'];

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
        'idsucursal' => $usuario->limpiarCadena($_POST['idsucursal']),
        'idpersona' => $usuario->limpiarCadena($_POST['idpersona']),
        'nom_usuario' => $usuario->limpiarCadena($_POST['nom_usuario']),
        'claveacceso' => password_hash($clave, PASSWORD_BCRYPT),
        'color' =>  $usuario->limpiarCadena($_POST['color']) ? $usuario->limpiarCadena($_POST['color']) : '',
        'porcentaje' =>  $usuario->limpiarCadena($_POST['porcentaje']) ? $usuario->limpiarCadena($_POST['porcentaje']) : '',
        'marcaagua' =>  $usuario->limpiarCadena($_POST['marcaagua']) ? $usuario->limpiarCadena($_POST['marcaagua']) : '',
        'firma' =>  $usuario->limpiarCadena($_POST['firma']) ? $usuario->limpiarCadena($_POST['firma']) : '',
        //'esRepresentante' =>  $usuario->limpiarCadena($_POST['esRepresentante']) ? $usuario->limpiarCadena($_POST['esRepresentante']) : '',
        'idnivelacceso' =>  $usuario->limpiarCadena($_POST['idnivelacceso']) ? $usuario->limpiarCadena($_POST['idnivelacceso']) : '',
      ];

      $respuesta = ['idusuario' => -1];
      $idusuario = $usuario->registrarUsuario($cleanData);

      if ($idusuario > 0) {
        $respuesta['idusuario'] = $idusuario;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarUsuario':
      $clave = $usuario->limpiarCadena($_POST['claveacceso']);
      $cleanData = [
        'idsucursal' => $usuario->limpiarCadena($_POST['idsucursal']) ?  $usuario->limpiarCadena($_POST['idsucursal']) : '',
        'idusuario' => $usuario->limpiarCadena($_POST['idusuario']) ?  $usuario->limpiarCadena($_POST['idusuario']) : '',
        'nomusuario' => $usuario->limpiarCadena($_POST['nomusuario']) ? $usuario->limpiarCadena($_POST['nomusuario']) : '',
        'claveacceso' => $clave ? password_hash($clave, PASSWORD_BCRYPT) : '',
        'color' => $usuario->limpiarCadena($_POST['color']) ? $usuario->limpiarCadena($_POST['color']) : '',
        'porcentaje' => $usuario->limpiarCadena($_POST['porcentaje']) ? $usuario->limpiarCadena($_POST['porcentaje']) : '',
        'marcaagua' => $usuario->limpiarCadena($_POST['marcaagua']) ? $usuario->limpiarCadena($_POST['marcaagua']) : '',
        'firma' =>  $usuario->limpiarCadena($_POST['firma']) ? $usuario->limpiarCadena($_POST['firma']) : '',
        //'esRepresentante' =>  $usuario->limpiarCadena($_POST['esRepresentante']) ? $usuario->limpiarCadena($_POST['esRepresentante']) : '',
      ];

      $update = $usuario->actualizarUsuario($cleanData);

      echo json_encode($update);
      break;

    case 'deshabilitarUsuario':
      $cleanData = [
        'idusuario' => $usuario->limpiarCadena($_POST['idusuario']) ?  $usuario->limpiarCadena($_POST['idusuario']) : '',
        'estado' => $usuario->limpiarCadena($_POST['estado']) ? $usuario->limpiarCadena($_POST['estado']) : ''
      ];

      $update = $usuario->deshabilitarUsuario($cleanData);

      echo json_encode($update);
      break;

    case 'actualizarPersona':
      $cleanData = [
        'idpersona' => $usuario->limpiarCadena($_POST['idpersona']) ? $usuario->limpiarCadena($_POST['idpersona']) : '',
        'numdoc' => $usuario->limpiarCadena($_POST['numdoc']) ? $usuario->limpiarCadena($_POST['numdoc']) : '',
        'apellidos' => $usuario->limpiarCadena($_POST['apellidos']) ? $usuario->limpiarCadena($_POST['apellidos']) : '',
        'nombres' => $usuario->limpiarCadena($_POST['nombres']) ? $usuario->limpiarCadena($_POST['nombres']) : '',
        'genero' => $usuario->limpiarCadena($_POST['genero']) ? $usuario->limpiarCadena($_POST['genero']) : '',
        'direccion' => $usuario->limpiarCadena($_POST['direccion']) ?  $usuario->limpiarCadena($_POST['direccion']) : '',
        'telefono' => $usuario->limpiarCadena($_POST['telefono']) ? $usuario->limpiarCadena($_POST['telefono']) : '',
        'telefono2' => $usuario->limpiarCadena($_POST['telefono2']) ? $usuario->limpiarCadena($_POST['telefono2']) : '',
        'correo' => $usuario->limpiarCadena($_POST['correo']) ? $usuario->limpiarCadena($_POST['correo']) : '',
        'iddistrito' => $usuario->limpiarCadena($_POST['iddistrito']) ? $usuario->limpiarCadena($_POST['iddistrito']) : '',
      ];

      $update = $usuario->actualizarPersona($cleanData);

      echo json_encode($update);
      break;
  }
}
