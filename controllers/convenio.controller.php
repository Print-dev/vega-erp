<?php
require_once '../models/Convenio.php';
header("Access-Control-Allow-Origin: http://localhost:80");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$convenio = new Convenio();
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
    case 'registrarConvenio':
      $cleanData = [
        'iddetallepresentacion'   => $convenio->limpiarCadena($_POST['iddetallepresentacion']),
        'abonogarantia' => $convenio->limpiarCadena($_POST['abonogarantia']),
        'abonopublicidad'   => $convenio->limpiarCadena($_POST['abonopublicidad']),
        'propuestacliente'    => $convenio->limpiarCadena($_POST['propuestacliente']),
        'estado' => $convenio->limpiarCadena($_POST['estado'])
      ];

      $respuesta = ['idconvenio' => -1];

      $idconvenio = $convenio->registrarConvenio($cleanData);

      if ($idconvenio > 0) {
        $respuesta['idconvenio'] = $idconvenio;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarEstadoConvenio':
      $cleanData = [
        'idconvenio'=>$convenio->limpiarCadena($_POST['idconvenio']),
        'estado'=>$convenio->limpiarCadena($_POST['estado'])
      ];

      $respuesta=['update'=>false];

      $update = $convenio->actualizarEstadoConvenio($cleanData);

      if($update){
        $respuesta['update']=true;
      }
      echo json_encode($respuesta);
      break;
  
  }
}
