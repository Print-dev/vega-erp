

<?php
require_once '../models/Reparticion.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$reparticion = new Reparticion();
// ag order by
if(isset($_GET['operation'])){
  switch($_GET['operation']){
    case 'filtrarReparticiones':
        $cleanData = [
          'evento' => $_GET['evento'] === "" ? null : $reparticion->limpiarCadena($_GET['evento'])
        ];
        echo json_encode($reparticion->filtrarReparticiones($cleanData));
        break;

    case 'obtenerIngresoPorId':
        $cleanData = [
          'idingreso' => $_GET['idingreso'] === "" ? null : $reparticion->limpiarCadena($_GET['idingreso'])
        ];
        echo json_encode($reparticion->obtenerIngresoPorId($cleanData));
        break;

    case 'obtenerIngresoPorIdReparticion':
        $cleanData = [
          'idreparticion' => $_GET['idreparticion'] === "" ? null : $reparticion->limpiarCadena($_GET['idreparticion'])
        ];
        echo json_encode($reparticion->obtenerIngresoPorIdReparticion($cleanData));
        break;

    
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarReparticion':
      $cleanData = [
        'iddetallepresentacion'   => $reparticion->limpiarCadena($_POST['iddetallepresentacion']) ?  $reparticion->limpiarCadena($_POST['iddetallepresentacion']) : '',
        'montototal' => $reparticion->limpiarCadena($_POST['montototal']) ? $reparticion->limpiarCadena($_POST['montototal']) : '',
        'montorepresentante'   => $reparticion->limpiarCadena($_POST['montorepresentante']) ? $reparticion->limpiarCadena($_POST['montorepresentante']) : '',
        'montopromotor'   => $reparticion->limpiarCadena($_POST['montopromotor']) ? $reparticion->limpiarCadena($_POST['montopromotor']) : '',
        'ingresototal'   => $reparticion->limpiarCadena($_POST['ingresototal']) ? $reparticion->limpiarCadena($_POST['ingresototal']) : '',
        'montoartista'   => $reparticion->limpiarCadena($_POST['montoartista']) ? $reparticion->limpiarCadena($_POST['montoartista']) : '',
        'montofinal'   => $reparticion->limpiarCadena($_POST['montofinal']) ? $reparticion->limpiarCadena($_POST['montofinal']) : '',
      ];

      $respuesta = ['idreparticion' => -1];

      $idreparticion = $reparticion->registrarReparticion($cleanData);

      if ($idreparticion > 0) {
        $respuesta['idreparticion'] = $idreparticion;
      }

      echo json_encode($respuesta);
      break;

    case 'registrarIngreso':
      $cleanData = [
        'idreparticion'   => $reparticion->limpiarCadena($_POST['idreparticion']) ?  $reparticion->limpiarCadena($_POST['idreparticion']) : '',
        'descripcion' => $reparticion->limpiarCadena($_POST['descripcion']) ? $reparticion->limpiarCadena($_POST['descripcion']) : '',
        'monto'   => $reparticion->limpiarCadena($_POST['monto']) ? $reparticion->limpiarCadena($_POST['monto']) : '',
        'tipopago'   => $reparticion->limpiarCadena($_POST['tipopago']) ? $reparticion->limpiarCadena($_POST['tipopago']) : '',
        'noperacion'   => $reparticion->limpiarCadena($_POST['noperacion']) ? $reparticion->limpiarCadena($_POST['noperacion']) : ''
      ];

      $respuesta = ['idingreso' => -1];

      $idingreso = $reparticion->registrarIngreso($cleanData);

      if ($idingreso > 0) {
        $respuesta['idingreso'] = $idingreso;
      }

      echo json_encode($respuesta);
      break;

    case 'registrarEgreso':
      $cleanData = [
        'idreparticion'   => $reparticion->limpiarCadena($_POST['idreparticion']) ?  $reparticion->limpiarCadena($_POST['idreparticion']) : '',
        'descripcion' => $reparticion->limpiarCadena($_POST['descripcion']) ? $reparticion->limpiarCadena($_POST['descripcion']) : '',
        'monto'   => $reparticion->limpiarCadena($_POST['monto']) ? $reparticion->limpiarCadena($_POST['monto']) : '',
        'tipopago'   => $reparticion->limpiarCadena($_POST['tipopago']) ? $reparticion->limpiarCadena($_POST['tipopago']) : '',
        'noperacion'   => $reparticion->limpiarCadena($_POST['noperacion']) ? $reparticion->limpiarCadena($_POST['noperacion']) : ''
      ];

      $respuesta = ['idegreso' => -1];

      $idegreso = $reparticion->registrarEgreso($cleanData);

      if ($idegreso > 0) {
        $respuesta['idegreso'] = $idegreso;
      }

      echo json_encode($respuesta);
      break;

  
  }
}
