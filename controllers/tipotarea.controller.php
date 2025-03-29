<?php
require_once '../models/TipoTarea.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$tipotarea = new TipoTarea();
// ag order by
if(isset($_GET['operation'])){
  switch($_GET['operation']){
    case 'obtenerTodosTipoTarea':
        echo json_encode($tipotarea->obtenerTodosTipoTarea());
        break;    
    
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarTipoTarea':
      $cleanData = [
        'tipotarea'   => $tipotarea->limpiarCadena($_POST['tipotarea'])
      ];

      $respuesta = ['idtipotarea' => -1];

      $idtipotarea = $tipotarea->registrarTipoTarea($cleanData);

      if ($idtipotarea > 0) {
        $respuesta['idtipotarea'] = $idtipotarea;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarNombreTipoTarea':
      $cleanData = [
        'idtipotarea'   => $tipotarea->limpiarCadena($_POST['idtipotarea']),
        'tipotarea'   => $tipotarea->limpiarCadena($_POST['tipotarea']),
      ];

      $tipotareaActualizado = $tipotarea->actualizarNombreTipoTarea($cleanData);

      echo json_encode($tipotareaActualizado);
      break;

    case 'removerTipoTarea':
      $cleanData = [
        'idtipotarea'   => $tipotarea->limpiarCadena($_POST['idtipotarea'])
      ];

      $tareaRemovida = $tipotarea->removerTipoTarea($cleanData);

      echo json_encode($tareaRemovida);
      break;

  }
}
