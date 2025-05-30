<?php
require_once '../models/Recurso.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$recurso = new Recurso();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerNiveles':
      echo json_encode($recurso->obtenerNiveles());
      break;

    case 'obtenerDepartamentos':
      echo json_encode($recurso->obtenerDepartamentos(["idnacionalidad" => $recurso->limpiarCadena($_GET['idnacionalidad'])]));
      break;

    case 'obtenerDepartamentoPorId':
      echo json_encode($recurso->obtenerDepartamentoPorId(["iddepartamento" => $recurso->limpiarCadena($_GET['iddepartamento'])]));
      break;

    case 'obtenerProvincias':
      echo json_encode($recurso->obtenerProvincias(["iddepartamento" => $recurso->limpiarCadena($_GET['iddepartamento'])]));
      break;

    case 'obtenerDistritos':
      echo json_encode($recurso->obtenerDistritos(["idprovincia" => $recurso->limpiarCadena($_GET['idprovincia'])]));
      break;
      
    case 'obtenerDistritoPorId':
      echo json_encode($recurso->obtenerDistritoPorId(["iddistrito" => $recurso->limpiarCadena($_GET['iddistrito'])]));
      break;

    case 'obtenerDistritoPorNombre':
      echo json_encode($recurso->obtenerDistritoPorNombre(["distrito" => $recurso->limpiarCadena($_GET['distrito'])]));
      break;

    case 'buscarCorreo':
      echo json_encode($recurso->buscarCorreo(["correo" => $recurso->limpiarCadena($_GET['correo'])]));
      break;

    case 'buscarCorreoCliente':
      echo json_encode($recurso->buscarCorreoCliente(["correo" => $recurso->limpiarCadena($_GET['correo'])]));
      break;

    case 'obtenerFilmmakers':
      echo json_encode($recurso->obtenerFilmmakers());
      break;

    // OBTENER TODOS LOS UBIGEOS
    case 'obtenerTodosDepartamentos':
      echo json_encode($recurso->obtenerTodosDepartamentos());
      break;
    case 'obtenerTodosProvincias':
      echo json_encode($recurso->obtenerTodosProvincias());
      break;
    case 'obtenerTodosDistritos':
      echo json_encode($recurso->obtenerTodosDistritos());
      break;
    case 'obtenerTodosNacionalidades':
      echo json_encode($recurso->obtenerTodosNacionalidades());
      break;
    case 'obtenerNacionalidadPorId':
      echo json_encode($recurso->obtenerNacionalidadPorId(["idnacionalidad" => $recurso->limpiarCadena($_GET['idnacionalidad'])]));
      break;
    case 'obtenerConceptos':
      echo json_encode($recurso->obtenerConceptos());
      break;
    case 'obtenerSubTipoPorIdConcepto':
      echo json_encode($recurso->obtenerSubTipoPorIdConcepto(["idconcepto" => $recurso->limpiarCadena($_GET['idconcepto'])]));
      break;

    
  }
}
