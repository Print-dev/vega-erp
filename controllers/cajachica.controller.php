

<?php
require_once '../models/CajaChica.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$cajachica = new CajaChica();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerUltimaCCFinal':
      echo json_encode($cajachica->obtenerUltimaCCFinal());
      break;

    case 'obtenerCajaChicaPorId':
      echo json_encode($cajachica->obtenerCajaChicaPorId(['idcajachica' => $cajachica->limpiarCadena($_GET['idcajachica'])]));
      break;

    case 'obtenerGastoPorId':
      echo json_encode($cajachica->obtenerGastoPorId(['idgasto' => $cajachica->limpiarCadena($_GET['idgasto'])]));
      break;

    case 'obtenerGastosPorCaja':
      echo json_encode($cajachica->obtenerGastosPorCaja(['idcajachica' => $cajachica->limpiarCadena($_GET['idcajachica'])]));
      break;

    case 'filtrarCajasChicas':
      $cleanData = [
        'fechaapertura' => empty($_GET['fechaapertura']) ? null : $cajachica->limpiarCadena($_GET['fechaapertura']),
        'fechacierre' => empty($_GET['fechacierre']) ? null : $cajachica->limpiarCadena($_GET['fechacierre']),
        'mes' => empty($_GET['mes']) ? null : (int) $_GET['mes'],
        'año_semana' => empty($_GET['año_semana']) ? null : intval($_GET['año_semana'])
      ];
      echo json_encode($cajachica->filtrarCajasChicas($cleanData));
      break;
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarCajaChica':
      $cleanData = [
        'ccinicial'   => $cajachica->limpiarCadena($_POST['ccinicial']),
        'incremento' => $cajachica->limpiarCadena($_POST['incremento']),
        'ccfinal'   => $cajachica->limpiarCadena($_POST['ccfinal']),
      ];

      $respuesta = ['idcajachica' => -1];

      $idcajachica = $cajachica->registrarCajaChica($cleanData);

      if ($idcajachica > 0) {
        $respuesta['idcajachica'] = $idcajachica;
      }

      echo json_encode($respuesta);
      break;

    case 'registrarGasto':
      $cleanData = [
        'idcajachica'   => $cajachica->limpiarCadena($_POST['idcajachica']),
        'concepto' => $cajachica->limpiarCadena($_POST['concepto']),
        'monto'   => $cajachica->limpiarCadena($_POST['monto']),
      ];

      $respuesta = ['idgasto' => -1];

      $idgasto = $cajachica->registrarGasto($cleanData);

      if ($idgasto > 0) {
        $respuesta['idgasto'] = $idgasto;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarEstadoCaja':
      $cleanData = [
        'idcajachica' => $cajachica->limpiarCadena($_POST['idcajachica']),
        'estado' => $cajachica->limpiarCadena($_POST['estado']),
      ];

      $update = $cajachica->actualizarEstadoCaja($cleanData);

      echo json_encode($update);
      break;

    case 'actualizarCCfinal':
      $cleanData = [
        'idcajachica' => $cajachica->limpiarCadena($_POST['idcajachica']),
        'ccfinal' => $cajachica->limpiarCadena($_POST['ccfinal']),
      ];

      $update = $cajachica->actualizarCCfinal($cleanData);

      echo json_encode($update);
      break;

    case 'actualizarIncremento':
      $cleanData = [
        'idcajachica' => $cajachica->limpiarCadena($_POST['idcajachica']),
        'incremento' => $cajachica->limpiarCadena($_POST['incremento']),
      ];

      $update = $cajachica->actualizarIncremento($cleanData);

      echo json_encode($update);
      break;
  }
}
