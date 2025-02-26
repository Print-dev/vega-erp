<?php
require_once '../models/Recurso.php';

$recurso = new Recurso();
// ag order by
if(isset($_GET['operation'])){
  switch($_GET['operation']){
    case 'obtenerNiveles':
      echo json_encode($recurso->obtenerNiveles());
      break;

    case 'obtenerDepartamentos':
      echo json_encode($recurso->obtenerDepartamentos(["idnacionalidad" => $recurso->limpiarCadena($_GET['idnacionalidad'])]));
      break;

    case 'obtenerProvincias':
      echo json_encode($recurso->obtenerProvincias(["iddepartamento" => $recurso->limpiarCadena($_GET['iddepartamento'])]));
      break;

    case 'obtenerDistritos':
      echo json_encode($recurso->obtenerDistritos(["idprovincia" => $recurso->limpiarCadena($_GET['idprovincia'])]));
      break;

    case 'buscarCorreo':
      echo json_encode($recurso->buscarCorreo(["correo" => $recurso->limpiarCadena($_GET['correo'])]));
      break;
    
  }
}