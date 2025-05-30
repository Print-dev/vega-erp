<?php

session_start();
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
require '../vendor/autoload.php';

use Cloudinary\Cloudinary;
use Cloudinary\Configuration\Configuration;

$hostOnly  = "http://localhost/vega-erp";
// cuando se pone en visible true se pone como dropdown
$accesos = [
  'Administrador' => [
    ['modulo' => 'ventas', 'ruta' => '', 'texto' => 'Ventas', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-chart-simple'],

    ['modulo' => 'ventas', 'ruta' => 'registrar-atencion-cliente', 'subruta' => '', 'texto' => 'Nueva Atencion', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'ventas', 'ruta' => 'listar-atencion-cliente', 'subruta' => '', 'texto' => 'Opciones de venta', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'ventas', 'ruta' => 'actualizar-atencion-cliente', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],

    // COMPROBANTES 
    ['modulo' => 'comprobantes', 'ruta' => '', 'texto' => 'Comprobantes', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-chart-simple'],

    ['modulo' => 'comprobantes', 'ruta' => 'listar-facturas', 'subruta' => 'facturas', 'texto' => 'Facturas', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'comprobantes', 'ruta' => 'registrar-factura', 'subruta' => 'facturas', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'comprobantes', 'ruta' => 'listar-notasdeventa', 'subruta' => 'notasdeventa', 'texto' => 'Notas de venta', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'comprobantes', 'ruta' => 'registrar-notadeventa', 'subruta' => 'notasdeventa', 'texto' => '', 'visible' => false, 'icono' => ''],



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
    ['modulo' => 'utilitario', 'ruta' => 'listar-clientes', 'subruta' => 'clientes', 'texto' => 'Clientes', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'utilitario', 'ruta' => 'registrar-cliente', 'subruta' => 'clientes', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'utilitario', 'ruta' => 'actualizar-cliente', 'subruta' => 'clientes', 'texto' => '', 'visible' => false, 'icono' => ''],

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

    //['modulo' => 'contabilidad', 'ruta' => 'listar-cuotas', 'subruta' => 'cuotas', 'texto' => 'Cuotas', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'contabilidad', 'ruta' => 'listar-pagos', 'subruta' => 'pagos', 'texto' => 'Pagos', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],

    ['modulo' => 'contabilidad', 'ruta' => 'listar-gastos', 'subruta' => 'gastos', 'texto' => 'Gastos', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'contabilidad', 'ruta' => 'registrar-gasto', 'subruta' => 'gastos', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'contabilidad', 'ruta' => 'actualizar-gasto', 'subruta' => 'gastos', 'texto' => '', 'visible' => false, 'icono' => ''],

    ['modulo' => 'contabilidad', 'ruta' => 'listar-gtxp', 'subruta' => 'gtxp', 'texto' => 'Gastos Por Pagar', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'contabilidad', 'ruta' => 'registrar-gtxp', 'subruta' => 'gtxp', 'texto' => '', 'visible' => false, 'icono' => ''],


    ['modulo' => 'nominas', 'ruta' => '', 'texto' => 'Nominas', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-calculator'],

    ['modulo' => 'nominas', 'ruta' => 'listar-nominas', 'subruta' => 'nomina', 'texto' => 'Registrados', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'nominas', 'ruta' => 'registrar-nomina', 'subruta' => 'nomina', 'texto' => 'Registrar', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'nominas', 'ruta' => 'actualizar-nomina', 'subruta' => 'nomina', 'texto' => '', 'visible' => false, 'icono' => ''],
    /* ['modulo' => 'contabilidad', 'ruta' => 'listar-ingresos', 'subruta' => 'ingresos', 'texto' => 'Ingresos', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'contabilidad', 'ruta' => 'registrar-ingreso', 'subruta' => 'ingresos', 'visible' => false], */


    ['modulo' => 'agenda', 'ruta' => '', 'texto' => 'Agenda', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],

    //['modulo' => 'agenda', 'ruta' => 'listar-agenda', 'subruta' => '', 'texto' => 'Agenda', 'visible' => true, 'icono' => 'fa-solid fa-clipboard'],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-artista', 'subruta' => '', 'texto' => 'Artista', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-edicion', 'subruta' => '', 'texto' => 'Edicion', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-filmmaker', 'subruta' => '', 'texto' => 'Filmmaker', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'agenda', 'ruta' => 'subir-contenido-edicion', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => ''],
    ['modulo' => 'agenda', 'ruta' => 'listar-agenda-cmanager', 'subruta' => '', 'texto' => 'Com. Manager', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],

    // DATOS DE EMPRESA
    ['modulo' => 'empresa', 'ruta' => 'datos-empresa', 'subruta' => '', 'texto' => 'Datos de empresa', 'visible' => true, 'icono' => 'fa-solid fa-building'],

    // REGISTRO DE PROVEEDORES
    ['modulo' => 'proveedores', 'ruta' => 'proveedores', 'subruta' => '', 'texto' => 'Proveedores', 'visible' => true, 'icono' => 'fa-solid fa-building'],

    // REGISTRO DE NOMINAS
    //['modulo' => 'nominas', 'ruta' => 'listar-nominas', 'subruta' => '', 'texto' => 'Nóminas', 'visible' => true, 'icono' => 'fa-solid fa-building'],

    // REGISTRO DE COLABORADORES
    ['modulo' => 'colaboradores', 'ruta' => '', 'texto' => 'Colaboradores', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-users'],

    ['modulo' => 'colaboradores', 'ruta' => 'listar-colaboradores', 'subruta' => '', 'texto' => 'Registrados', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'colaboradores', 'ruta' => 'registrar-colaborador', 'subruta' => '', 'texto' => 'Nuevo Colaborador', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'colaboradores', 'ruta' => 'actualizar-colaborador', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'colaboradores', 'ruta' => 'salarios-colaborador', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'colaboradores', 'ruta' => 'cargos-colaborador', 'subruta' => '', 'texto' => '', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],

    // REGISTRO DE GASTOS
    /*     ['modulo' => 'gastos', 'ruta' => '', 'texto' => 'Gastos', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-users'],

    ['modulo' => 'gastos', 'ruta' => 'listar-gastos', 'subruta' => '', 'texto' => 'Registrados', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'gastos', 'ruta' => 'registrar-gasto', 'subruta' => '', 'texto' => 'Nuevo Registro', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true], */

    // REGISTRO DE GASTOS POR PAGAR
    /*     ['modulo' => 'gastosporpagar', 'ruta' => '', 'texto' => 'Gastos Por Pagar', 'subruta' => '', 'visible' => true, 'icono' => 'fa-solid fa-users'],

    ['modulo' => 'gastosporpagar', 'ruta' => 'listar-gtxp', 'subruta' => '', 'texto' => 'Registrados', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true],
    ['modulo' => 'gastosporpagar', 'ruta' => 'registrar-gtxp', 'subruta' => '', 'texto' => 'Nuevo Registro', 'visible' => false, 'icono' => 'fa-solid fa-list', 'only' => true], */

    // REGISTRO DE PRODUCTOS/SERVICIOS
    ['modulo' => 'prodserv', 'ruta' => 'prodserv', 'subruta' => '', 'texto' => 'Prod. Serv', 'visible' => true, 'icono' => 'fa-solid fa-building'],
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
require_once '../models/Empresa.php';

$usuario = new Usuario();
$empresa = new Empresa();

if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'destroy':
      session_destroy();
      session_unset();
      header("location:" . $hostOnly);
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

    case 'obtenerPersonaCorreo':
      echo json_encode($usuario->obtenerPersonaCorreo(['correo' => $_GET['correo']]));
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
      $empresaDato = $empresa->obtenerDatosEmpresa();
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
          $resultados['nombreapp'] = $empresaDato[0]['nombreapp']; // ESTO PARA MOSTRARLO EN LASN OTIFICACIONES
          $resultados['logoempresa'] = $empresaDato[0]['logoempresa']; // ESTO PARA MOSTRARLO EN LOGO DE LA EMPRESA

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
          $session['nombreapp'] = $empresaDato[0]['nombreapp'];
          $session['razonsocial'] = $empresaDato[0]['razonsocial'];
          $session['ruc'] = $empresaDato[0]['ruc'];
          $session['logoempresa'] = $empresaDato[0]['logoempresa'];

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
      $cloudinary = new Cloudinary([
        'cloud' => [
          'cloud_name' => 'dynpy0r4v',
          'api_key'    => '722279687758731',
          'api_secret' => 'KsLk7dNUAAjRYEBNUsv2JAV7cPI'
        ],
        'url' => [
          'secure' => true
        ]
      ]);

      // Variables por defecto
      $secureUrlMarcaAgua = '';
      $secureUrlFirma = '';

      // Subir marca de agua si existe
      if (isset($_FILES['marcaagua']) && $_FILES['marcaagua']['error'] === UPLOAD_ERR_OK) {
        $uploadResultMarcaAgua = $cloudinary->uploadApi()->upload(
          $_FILES['marcaagua']['tmp_name'],
          ['folder' => 'marcadeagua_vegaproducciones']
        );
        $secureUrlMarcaAgua = $uploadResultMarcaAgua['public_id'] ?? '';
      }

      // Subir firma si existe
      if (isset($_FILES['firma']) && $_FILES['firma']['error'] === UPLOAD_ERR_OK) {
        $uploadResultFirma = $cloudinary->uploadApi()->upload(
          $_FILES['firma']['tmp_name'],
          ['folder' => 'firmas_vegaproducciones']
        );
        $secureUrlFirma = $uploadResultFirma['public_id'] ?? '';
      }

      $clave = $usuario->limpiarCadena($_POST['claveacceso']);
      $cleanData = [
        'idsucursal' => $usuario->limpiarCadena($_POST['idsucursal']),
        'idpersona' => $usuario->limpiarCadena($_POST['idpersona']),
        'nom_usuario' => $usuario->limpiarCadena($_POST['nom_usuario']),
        'claveacceso' => password_hash($clave, PASSWORD_BCRYPT),
        'color' => $usuario->limpiarCadena($_POST['color'] ?? ''),
        'porcentaje' => $usuario->limpiarCadena($_POST['porcentaje'] ?? ''),
        'marcaagua' => $secureUrlMarcaAgua,
        'firma' => $secureUrlFirma,
        'idnivelacceso' => $usuario->limpiarCadena($_POST['idnivelacceso'] ?? ''),
      ];

      $respuesta = ['idusuario' => -1];
      $idusuario = $usuario->registrarUsuario($cleanData);

      if ($idusuario > 0) {
        $respuesta['idusuario'] = $idusuario;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarUsuario':
      $cloudinary = new Cloudinary([
        'cloud' => [
          'cloud_name' => 'dynpy0r4v',
          'api_key'    => '722279687758731',
          'api_secret' => 'KsLk7dNUAAjRYEBNUsv2JAV7cPI'
        ],
        'url' => ['secure' => true]
      ]);

      // PUBLIC_ID actuales
      $marcaaguaActual = $_POST['publicIdMarcaAguaAnterior'] ?? '';
      $firmaActual = $_POST['publicIdFirmaAnterior'] ?? '';

      $secureUrlMarcaAgua = $marcaaguaActual;
      $secureUrlFirma = $firmaActual;

      // Si se sube nueva marca de agua
      if (isset($_FILES['marcaagua']) && $_FILES['marcaagua']['error'] === UPLOAD_ERR_OK) {
        if (!empty($marcaaguaActual)) {
          $cloudinary->uploadApi()->destroy($marcaaguaActual);
        }
        $uploadResultMarcaAgua = $cloudinary->uploadApi()->upload(
          $_FILES['marcaagua']['tmp_name'],
          ['folder' => 'marcadeagua_vegaproducciones']
        );
        $secureUrlMarcaAgua = $uploadResultMarcaAgua['public_id'] ?? '';
      }

      // Si se sube nueva firma
      if (isset($_FILES['firma']) && $_FILES['firma']['error'] === UPLOAD_ERR_OK) {
        if (!empty($firmaActual)) {
          $cloudinary->uploadApi()->destroy($firmaActual);
        }
        $uploadResultFirma = $cloudinary->uploadApi()->upload(
          $_FILES['firma']['tmp_name'],
          ['folder' => 'firmas_vegaproducciones']
        );
        $secureUrlFirma = $uploadResultFirma['public_id'] ?? '';
      }

      $clave = $usuario->limpiarCadena($_POST['claveacceso']);
      $cleanData = [
        'idsucursal' => $usuario->limpiarCadena($_POST['idsucursal']) ?  $usuario->limpiarCadena($_POST['idsucursal']) : '',
        'idusuario' => $usuario->limpiarCadena($_POST['idusuario']) ?  $usuario->limpiarCadena($_POST['idusuario']) : '',
        'nomusuario' => $usuario->limpiarCadena($_POST['nomusuario']) ? $usuario->limpiarCadena($_POST['nomusuario']) : '',
        'claveacceso' => $clave ? password_hash($clave, PASSWORD_BCRYPT) : '',
        'color' => $usuario->limpiarCadena($_POST['color']) ? $usuario->limpiarCadena($_POST['color']) : '',
        'porcentaje' => $usuario->limpiarCadena($_POST['porcentaje']) ? $usuario->limpiarCadena($_POST['porcentaje']) : '',
        'marcaagua' => $secureUrlMarcaAgua,
        'firma' => $secureUrlFirma,
        //'esRepresentante' =>  $usuario->limpiarCadena($_POST['esRepresentante']) ? $usuario->limpiarCadena($_POST['esRepresentante']) : '',
      ];

      $update = $usuario->actualizarUsuario($cleanData);

      echo json_encode($update);
      break;

    case 'actualizarContrasenaUsuario':
      $clave = $usuario->limpiarCadena($_POST['claveacceso']);
      $cleanData = [
        'idpersona' => $usuario->limpiarCadena($_POST['idpersona']) ?  $usuario->limpiarCadena($_POST['idpersona']) : '',
        'claveacceso' => $clave ? password_hash($clave, PASSWORD_BCRYPT) : ''
      ];

      $update = $usuario->actualizarContrasenaUsuario($cleanData);

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
