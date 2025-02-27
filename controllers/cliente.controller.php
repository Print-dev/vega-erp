<?php
require_once '../models/Cliente.php';

$cliente = new Cliente();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerClientePorDoc':
      echo json_encode($cliente->obtenerClientePorDoc(['ndocumento' => $_GET['ndocumento']]));
      break;
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarCliente':
      $cleanData = [
        'iddistrito'   => $cliente->limpiarCadena($_POST['iddistrito']),
        'ndocumento' => $cliente->limpiarCadena($_POST['ndocumento']),
        'razonsocial'   => $cliente->limpiarCadena($_POST['razonsocial']),
        'telefono'    => $cliente->limpiarCadena($_POST['telefono']),
        'correo' => $cliente->limpiarCadena($_POST['correo']),
        'direccion'  => $cliente->limpiarCadena($_POST['direccion'])
      ];

      $respuesta = ['idcliente' => -1];

      $idcliente = $cliente->registrarCliente($cleanData);

      if ($idcliente > 0) {
        $respuesta['idcliente'] = $idcliente;
      }

      echo json_encode($respuesta);
      break;
    
  }
}
