

<?php
require_once '../models/Sucursal.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$sucursal = new Sucursal();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'filtrarSucursales':
      $cleanData = [
        'nombre' => $_GET['nombre'] === "" ? null : $sucursal->limpiarCadena($_GET['nombre']),
        'iddepartamento' => $_GET['iddepartamento'] === "" ? null : $sucursal->limpiarCadena($_GET['iddepartamento']),
        'idprovincia' => $_GET['idprovincia'] === "" ? null : $sucursal->limpiarCadena($_GET['idprovincia']),
        'iddistrito' => $_GET['iddistrito'] === "" ? null : $sucursal->limpiarCadena($_GET['iddistrito']),
      ];
      echo json_encode($sucursal->filtrarSucursales($cleanData));
      break;

    case 'obtenerSucursalPorId':
      $cleanData = [
        'idsucursal' => $_GET['idsucursal'] === "" ? null : $sucursal->limpiarCadena($_GET['idsucursal']),
      ];
      echo json_encode($sucursal->obtenerSucursalPorId($cleanData));
      break;

    case 'obtenerSucursales':
      echo json_encode($sucursal->obtenerSucursales());
      break;

    case 'obtenerRepresentanteEmpresa':
      $cleanData = [
        'idsucursal' => $_GET['idsucursal'] === "" ? null : $sucursal->limpiarCadena($_GET['idsucursal']),
      ];
      echo json_encode($sucursal->obtenerRepresentanteEmpresa($cleanData));
      break;

    case 'obtenerSucursalesPorEmpresa':
      $cleanData = [
        'idempresa' => $_GET['idempresa'] === "" ? null : $sucursal->limpiarCadena($_GET['idempresa']),
      ];
      echo json_encode($sucursal->obtenerSucursalesPorEmpresa($cleanData));
      break;
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarSucursal':
      $cleanData = [
        'idempresa'   => $sucursal->limpiarCadena($_POST['idempresa']) ?  $sucursal->limpiarCadena($_POST['idempresa']) : '',
        'iddistrito'   => $sucursal->limpiarCadena($_POST['iddistrito']) ?  $sucursal->limpiarCadena($_POST['iddistrito']) : '',
        'idresponsable'   => $sucursal->limpiarCadena($_POST['idresponsable']) ?  $sucursal->limpiarCadena($_POST['idresponsable']) : '',
        'nombre'   => $sucursal->limpiarCadena($_POST['nombre']) ?  $sucursal->limpiarCadena($_POST['nombre']) : '',
        'ruc'   => $sucursal->limpiarCadena($_POST['ruc']) ?  $sucursal->limpiarCadena($_POST['ruc']) : '',
        'telefono'   => $sucursal->limpiarCadena($_POST['telefono']) ?  $sucursal->limpiarCadena($_POST['telefono']) : '',
        'direccion'   => $sucursal->limpiarCadena($_POST['direccion']) ?  $sucursal->limpiarCadena($_POST['direccion']) : '',
        'email'   => $sucursal->limpiarCadena($_POST['email']) ?  $sucursal->limpiarCadena($_POST['email']) : '',
        'ubigeo'   => $sucursal->limpiarCadena($_POST['ubigeo']) ?  $sucursal->limpiarCadena($_POST['ubigeo']) : '',
      ];

      $rpt = $sucursal->registrarSucursal($cleanData);

      echo json_encode($rpt);
      break;

    case 'actualizarSucursal':
      $cleanData = [
        'idsucursal'   => $sucursal->limpiarCadena($_POST['idsucursal']) ?  $sucursal->limpiarCadena($_POST['idsucursal']) : '',
        'idempresa'   => $sucursal->limpiarCadena($_POST['idempresa']) ?  $sucursal->limpiarCadena($_POST['idempresa']) : '',
        'iddistrito'   => $sucursal->limpiarCadena($_POST['iddistrito']) ?  $sucursal->limpiarCadena($_POST['iddistrito']) : '',
        'idresponsable'   => $sucursal->limpiarCadena($_POST['idresponsable']) ?  $sucursal->limpiarCadena($_POST['idresponsable']) : '',
        'nombre'   => $sucursal->limpiarCadena($_POST['nombre']) ?  $sucursal->limpiarCadena($_POST['nombre']) : '',
        'ruc'   => $sucursal->limpiarCadena($_POST['ruc']) ?  $sucursal->limpiarCadena($_POST['ruc']) : '',
        'telefono'   => $sucursal->limpiarCadena($_POST['telefono']) ?  $sucursal->limpiarCadena($_POST['telefono']) : '',
        'direccion'   => $sucursal->limpiarCadena($_POST['direccion']) ?  $sucursal->limpiarCadena($_POST['direccion']) : '',
        'email'   => $sucursal->limpiarCadena($_POST['email']) ?  $sucursal->limpiarCadena($_POST['email']) : '',
        'ubigeo'   => $sucursal->limpiarCadena($_POST['ubigeo']) ?  $sucursal->limpiarCadena($_POST['ubigeo']) : '',
      ];

      $rpt = $sucursal->actualizarSucursal($cleanData);

      echo json_encode($rpt);
      break;
  }
}
