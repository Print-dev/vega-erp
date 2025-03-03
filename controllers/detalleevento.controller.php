<?php
require_once '../models/DetalleEvento.php';
header("Access-Control-Allow-Origin: http://localhost:80");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$detalleevento = new DetalleEvento();
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerCotizacionPorNcot':
      echo json_encode($detalleevento->obtenerCotizacionPorNcot(['ncotizacion' => $_GET['ncotizacion']]));
      break;

    case 'obtenerDPporId':
      echo json_encode($detalleevento->obtenerDPporId(['iddetallepresentacion' => $_GET['iddetallepresentacion']]));
      break;

    case 'obtenerCotizacion':
      echo json_encode($detalleevento->obtenerCotizacion(['iddetallepresentacion' => $_GET['iddetallepresentacion']]));
      break;

    case 'filtrarAtenciones':
      $cleanData = [
        'ncotizacion' => $_GET['ncotizacion'] === "" ? null : $detalleevento->limpiarCadena($_GET['ncotizacion']),
        'ndocumento' => $_GET['ndocumento'] === "" ? null : $detalleevento->limpiarCadena($_GET['ndocumento'])
      ];
      echo json_encode($detalleevento->filtrarAtenciones($cleanData));
      break;
  }
}
if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarDetallePresentacion':
      $cleanData = [
        'idusuario'   => $detalleevento->limpiarCadena($_POST['idusuario']),
        'idcliente' => $detalleevento->limpiarCadena($_POST['idcliente']),
        'iddistrito' => $detalleevento->limpiarCadena($_POST['iddistrito']),
        'ncotizacion' => $detalleevento->limpiarCadena($_POST['ncotizacion']) ? $detalleevento->limpiarCadena($_POST['ncotizacion']) : '',
        'fechapresentacion'   => $detalleevento->limpiarCadena($_POST['fechapresentacion']),
        'horapresentacion'    => $detalleevento->limpiarCadena($_POST['horapresentacion']),
        'tiempopresentacion' => $detalleevento->limpiarCadena($_POST['tiempopresentacion']),
        'establecimiento'  => $detalleevento->limpiarCadena($_POST['establecimiento']),
        'tipoevento'  => $detalleevento->limpiarCadena($_POST['tipoevento']),
        'modalidad'  => $detalleevento->limpiarCadena($_POST['modalidad']),
        'validez'  => $detalleevento->limpiarCadena($_POST['validez']) ? $detalleevento->limpiarCadena($_POST['validez']) : '',
        'igv'  => $detalleevento->limpiarCadena($_POST['igv']),
        'tipopago'  => $detalleevento->limpiarCadena($_POST['tipopago']),
      ];

      $respuesta = ['iddetalleevento' => -1];

      $iddetalleevento = $detalleevento->registrarDetallePresentacion($cleanData);

      if ($iddetalleevento > 0) {
        $respuesta['iddetalleevento'] = $iddetalleevento;
      }

      echo json_encode($respuesta);
      break;
    
  }
}
