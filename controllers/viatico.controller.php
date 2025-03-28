

<?php
require_once '../models/Viatico.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$viatico = new Viatico();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerViatico':
      $cleanData = [
        'iddetallepresentacion' => $_GET['iddetallepresentacion'] === "" ? null : $viatico->limpiarCadena($_GET['iddetallepresentacion'])
      ];
      echo json_encode($viatico->obtenerViatico($cleanData));
      break;

    case 'obtenerInfoViatico':
      $cleanData = [
        'iddetallepresentacion' => $_GET['iddetallepresentacion'] === "" ? null : $viatico->limpiarCadena($_GET['iddetallepresentacion']),
        'idusuario' => $_GET['idusuario'] === "" ? null : $viatico->limpiarCadena($_GET['idusuario']),
      ];
      echo json_encode($viatico->obtenerInfoViatico($cleanData));
      break;

    case 'obtenerInfoViaticoNotificacion':
      $cleanData = [
        'idusuario' => $_GET['idusuario'] === "" ? null : $viatico->limpiarCadena($_GET['idusuario']),
        'idviatico' => $_GET['idviatico'] === "" ? null : $viatico->limpiarCadena($_GET['idviatico']),
      ];
      echo json_encode($viatico->obtenerInfoViaticoNotificacion($cleanData));
      break;
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarViatico':
      $cleanData = [
        'iddetallepresentacion'   => $viatico->limpiarCadena($_POST['iddetallepresentacion']),
        'idusuario'   => $viatico->limpiarCadena($_POST['idusuario']),
        'pasaje' => $viatico->limpiarCadena($_POST['pasaje']) ? $viatico->limpiarCadena($_POST['pasaje']) : '',
        'hospedaje'   => $viatico->limpiarCadena($_POST['hospedaje']),
        'desayuno'   => $viatico->limpiarCadena($_POST['desayuno']) ? $viatico->limpiarCadena($_POST['desayuno']) : '',
        'almuerzo'   => $viatico->limpiarCadena($_POST['almuerzo']) ?  $viatico->limpiarCadena($_POST['almuerzo']) : '',
        'cena'   => $viatico->limpiarCadena($_POST['cena']) ?  $viatico->limpiarCadena($_POST['cena']) : '',
        'viaje'   => $viatico->limpiarCadena($_POST['viaje']) ? $viatico->limpiarCadena($_POST['viaje']) : '',
      ];

      $respuesta = ['idviatico' => -1];

      $idviatico = $viatico->registrarViatico($cleanData);

      if ($idviatico > 0) {
        $respuesta['idviatico'] = $idviatico;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarViatico':
      $cleanData = [
        'idviatico' => $viatico->limpiarCadena($_POST['idviatico']),
        'pasaje' => $viatico->limpiarCadena($_POST['pasaje']),
        'comida' => $viatico->limpiarCadena($_POST['comida']),
        'viaje' => $viatico->limpiarCadena($_POST['viaje']) ? $viatico->limpiarCadena($_POST['viaje']) : ''
      ];

      $respuesta = ['update' => false];

      $update = $viatico->actualizarViatico($cleanData);

      if ($update) {
        $respuesta['update'] = true;
      }
      echo json_encode($respuesta);
      break;
  }
}
