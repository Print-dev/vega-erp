<?php
require_once '../models/Persona.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$persona = new Persona();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerPersonas':
      echo json_encode($persona->obtenerPersonas());
      break;
    case 'obtenerPersonaPorId':
      echo json_encode($persona->obtenerPersonaPorId(['idpersona' => $_GET['idpersona']]));
      break;
      /* case 'searchPersonaNumDoc':
      echo json_encode($persona->searchPersonaNumDoc(['numdoc'=>$_GET['numdoc']]));
      break;
    case 'searchTelefono':
      echo json_encode($persona->searchTelf(['telefono'=>$_GET['telefono']]));
      break;
    case 'searchEmail':
      echo json_encode($persona->searchEmail(['email'=>$_GET['email']]));
      break; */
  }
}
if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarPersona':
      $cleanData = [
        'num_doc'   => $persona->limpiarCadena($_POST['num_doc']),
        'apellidos' => $persona->limpiarCadena($_POST['apellidos']),
        'nombres'   => $persona->limpiarCadena($_POST['nombres']),
        'genero'    => $persona->limpiarCadena($_POST['genero']),
        'direccion' => $persona->limpiarCadena($_POST['direccion']),
        'telefono'  => $persona->limpiarCadena($_POST['telefono']),
        'telefono2' => $persona->limpiarCadena($_POST['telefono2']),
        'correo'    => $persona->limpiarCadena($_POST['correo']),
        'iddistrito' => $persona->limpiarCadena($_POST['iddistrito'])
      ];

      $respuesta = ['idpersona' => -1];

      $idpersona = $persona->registrarPersona($cleanData);

      if ($idpersona > 0) {
        $respuesta['idpersona'] = $idpersona;
      }

      echo json_encode($respuesta);
      break;

      /* case 'updatePersona':
      $cleanData = [
        'idpersona'=>$persona->limpiarCadena($_POST['idpersona']),
        'apellidos'=>$persona->limpiarCadena($_POST['apellidos']),
        'nombres'=>$persona->limpiarCadena($_POST['nombres']),
        'telefono'=>$persona->limpiarCadena($_POST['telefono']),
        'direccion'=>$persona->limpiarCadena($_POST['direccion']),
        'email'=>$persona->limpiarCadena($_POST['email'])
      ];

      $respuesta=['update'=>false];

      $update = $persona->updatePersona($cleanData);

      if($update){
        $respuesta['update']=true;
      }
      echo json_encode($respuesta);
      break;
  } */
  }
}
