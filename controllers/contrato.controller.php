<?php
require_once '../models/Contrato.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$contrato = new Contrato();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerContrato':
      echo json_encode($contrato->obtenerContrato(['idcontrato' => $_GET['idcontrato']]));
      break;

    case 'obtenerContratoPorDP':
      echo json_encode($contrato->obtenerContratoPorDP(['iddetallepresentacion' => $_GET['iddetallepresentacion']]));
      break;

    case 'obtenerPagosContratoPorIdContrato':
      echo json_encode($contrato->obtenerPagosContratoPorIdContrato(['idcontrato' => $_GET['idcontrato']]));
      break;

    case 'obtenerReservaPorPagoContrato':
      echo json_encode($contrato->obtenerReservaPorPagoContrato(['idpagocontrato' => $_GET['idpagocontrato']]));
      break;

    case 'obtenerPagosContrato':
      $cleanData = [
        'idcliente' => $_GET['idcliente'] === "" ? null : $contrato->limpiarCadena($_GET['idcliente']),
      ];
      echo json_encode($contrato->obtenerPagosContrato($cleanData));
      break;
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarContrato':
      $cleanData = [
        'iddetallepresentacion'   => $contrato->limpiarCadena($_POST['iddetallepresentacion']),
        //'montopagado' => $contrato->limpiarCadena($_POST['montopagado']),
        'estado' => $contrato->limpiarCadena($_POST['estado'])
      ];

      $respuesta = ['idcontrato' => -1];

      $idcontrato = $contrato->registrarContrato($cleanData);

      if ($idcontrato > 0) {
        $respuesta['idcontrato'] = $idcontrato;
      }

      echo json_encode($respuesta);
      break;

    case 'registrarPagoContrato':
      $cleanData = [
        'idcontrato'   => $contrato->limpiarCadena($_POST['idcontrato']),
        'monto' => $contrato->limpiarCadena($_POST['monto']),
        'tipopago' => $contrato->limpiarCadena($_POST['tipopago']),
        'noperacion' => $_POST['noperacion'] === "" ? null : $contrato->limpiarCadena($_POST['noperacion']),
        'fechapago' => $contrato->limpiarCadena($_POST['fechapago']),
        'horapago' => $contrato->limpiarCadena($_POST['horapago']),
        'estado' => $contrato->limpiarCadena($_POST['estado'])
      ];

      $respuesta = ['idpagocontrato' => -1];

      $idpagocontrato = $contrato->registrarPagoContrato($cleanData);

      if ($idpagocontrato > 0) {
        $respuesta['idpagocontrato'] = $idpagocontrato;
      }

      echo json_encode($respuesta);
      break;

    case 'registrarReserva':
      $cleanData = [
        'idcontrato'   => $contrato->limpiarCadena($_POST['idcontrato']),
        'vigencia' => $contrato->limpiarCadena($_POST['vigencia']),
        'fechacreada' => $contrato->limpiarCadena($_POST['fechacreada'])
      ];

      $rpt = $contrato->registrarReserva($cleanData);
      echo json_encode($rpt);
      break;

    case 'actualizarEstadoContrato':
      $cleanData = [
        'idcontrato' => $contrato->limpiarCadena($_POST['idcontrato']),
        'estado' => $contrato->limpiarCadena($_POST['estado'])
      ];

      $respuesta = ['update' => false];

      $update = $contrato->actualizarEstadoContrato($cleanData);

      if ($update) {
        $respuesta['update'] = true;
      }
      echo json_encode($respuesta);
      break;
  }
}
