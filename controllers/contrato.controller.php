<?php
require_once '../models/Contrato.php';
header("Access-Control-Allow-Origin: http://localhost:80");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$contrato = new Contrato();
// ag order by
/* if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerPersonaPorId':
      echo json_encode($convenio->obtenerPersonaPorId(['idpersona' => $_GET['idpersona']]));
      break;
      case 'searchPersonaNumDoc':
      echo json_encode($persona->searchPersonaNumDoc(['numdoc'=>$_GET['numdoc']]));
      break;
    case 'searchTelefono':
      echo json_encode($persona->searchTelf(['telefono'=>$_GET['telefono']]));
      break;
    case 'searchEmail':
      echo json_encode($persona->searchEmail(['email'=>$_GET['email']]));
      break;
  }
} */
if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarContrato':
      $cleanData = [
        'iddetallepresentacion'   => $contrato->limpiarCadena($_POST['iddetallepresentacion']),
        'montopagado' => $contrato->limpiarCadena($_POST['montopagado']),
        'estado' => $contrato->limpiarCadena($_POST['estado'])
      ];

      $respuesta = ['idcontrato' => -1];

      $idcontrato = $contrato->registrarContrato($cleanData);

      if ($idcontrato > 0) {
        $respuesta['idcontrato'] = $idcontrato;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarEstadoContrato':
      $cleanData = [
        'idcontrato'=>$contrato->limpiarCadena($_POST['idcontrato']),
        'estado'=>$contrato->limpiarCadena($_POST['estado'])
      ];

      $respuesta=['update'=>false];

      $update = $contrato->actualizarEstadoContrato($cleanData);

      if($update){
        $respuesta['update']=true;
      }
      echo json_encode($respuesta);
      break;
  
  }
}
