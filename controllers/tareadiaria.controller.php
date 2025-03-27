
<?php
require_once '../models/TareaDiaria.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$tareadiaria = new TareaDiaria();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerTareas':
      echo json_encode($tareadiaria->obtenerTareas());
      break;

    case 'obtenerTareasDiariasPorUsuario':
      $cleanData = [
        'idusuario' => $_GET['idusuario'] === "" ? null : $tareadiaria->limpiarCadena($_GET['idusuario'])
      ];
      echo json_encode($tareadiaria->obtenerTareasDiariasPorUsuario($cleanData));
      break;
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'asignarTareaDiaria':
      $cleanData = [
        'idusuario'   => $tareadiaria->limpiarCadena($_POST['idusuario']),
        'idtareadiaria'   => $tareadiaria->limpiarCadena($_POST['idtareadiaria']),
        'fechaentrega'   => $tareadiaria->limpiarCadena($_POST['fechaentrega']),
        'horaentrega'   => $tareadiaria->limpiarCadena($_POST['horaentrega'])
      ];

      $respuesta = ['idtaradiariaasig' => -1];

      $idtaradiariaasig = $tareadiaria->asignarTareaDiaria($cleanData);

      if ($idtaradiariaasig > 0) {
        $respuesta['idtaradiariaasig'] = $idtaradiariaasig;
      }

      echo json_encode($respuesta);
      break;

    case 'registrarTareaDiaria':
      $cleanData = [
        'tarea'   => $tareadiaria->limpiarCadena($_POST['tarea'])
      ];

      $respuesta = ['idtareadiaria' => -1];

      $idtareadiaria = $tareadiaria->registrarTareaDiaria($cleanData);

      if ($idtareadiaria > 0) {
        $respuesta['idtareadiaria'] = $idtareadiaria;
      }

      echo json_encode($respuesta);
      break;

      
    case 'actualizarEstadoTareaDiariaAsignacion':
      $cleanData = [
        'idtaradiariaasig'=>$tareadiaria->limpiarCadena($_POST['idtaradiariaasig']),
        'estado'=>$tareadiaria->limpiarCadena($_POST['estado'])
      ];

      $update = $tareadiaria->actualizarEstadoTareaDiariaAsignacion($cleanData);
      echo json_encode($update);
      break;

      
  }
}
