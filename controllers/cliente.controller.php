<?php
require_once '../models/Cliente.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$cliente = new Cliente();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerClientePorDoc':
      echo json_encode($cliente->obtenerClientePorDoc(['ndocumento' => $_GET['ndocumento']]));
      break;

    case 'verificarDatosIncompletosCliente':
      echo json_encode($cliente->verificarDatosIncompletosCliente(['idcliente' => $_GET['idcliente']]));
      break;

    case 'consultarRUC':
      $numero = $_GET['ndocumento'] ?? '';

      if (empty($numero)) {
        echo json_encode(['error' => 'Número de documento requerido']);
        exit();
      }

      $api_url = "https://api.apis.net.pe/v2/sunat/ruc/full?numero={$numero}&token=apis-token-13404.T66vw10MJiiqMLEMgeODQI9kYuZinPSM";

      // Usar cURL para hacer la solicitud
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, $api_url);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
      curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // Desactivar validación SSL si es necesario
      $response = curl_exec($ch);
      curl_close($ch);

      // Devolver la respuesta al frontend
      echo $response;
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarCliente':
      $cleanData = [
        'tipodoc'   => $cliente->limpiarCadena($_POST['tipodoc']) ? $cliente->limpiarCadena($_POST['tipodoc']) : '',
        'iddistrito'   => $cliente->limpiarCadena($_POST['iddistrito']) ? $cliente->limpiarCadena($_POST['iddistrito']) : '',
        'ndocumento' => $cliente->limpiarCadena($_POST['ndocumento']) ? $cliente->limpiarCadena($_POST['ndocumento']) : '',
        'razonsocial'   => $cliente->limpiarCadena($_POST['razonsocial']) ? $cliente->limpiarCadena($_POST['razonsocial']) : '',
        'representantelegal'   => $cliente->limpiarCadena($_POST['representantelegal']) ? $cliente->limpiarCadena($_POST['representantelegal']) : '',
        'telefono'    => $cliente->limpiarCadena($_POST['telefono']) ? $cliente->limpiarCadena($_POST['telefono']) : '',
        'correo' => $cliente->limpiarCadena($_POST['correo']) ? $cliente->limpiarCadena($_POST['correo']) : '',
        'direccion'  => $cliente->limpiarCadena($_POST['direccion']) ? $cliente->limpiarCadena($_POST['direccion']) : ''
      ];

      $respuesta = ['idcliente' => -1];

      $idcliente = $cliente->registrarCliente($cleanData);

      if ($idcliente > 0) {
        $respuesta['idcliente'] = $idcliente;
      }

      echo json_encode($respuesta);
      break;

      case 'actualizarCliente':
        $cleanData = [
          'idcliente' => $cliente->limpiarCadena($_POST['idcliente']),
          'iddistrito' => $cliente->limpiarCadena($_POST['iddistrito']),
          'ndocumento' => $cliente->limpiarCadena($_POST['ndocumento']) ? $cliente->limpiarCadena($_POST['ndocumento']) : '',
          'razonsocial' => $cliente->limpiarCadena($_POST['razonsocial']),
          'representantelegal' => $cliente->limpiarCadena($_POST['representantelegal']) ? $cliente->limpiarCadena($_POST['representantelegal']) : '',
          'telefono' => $cliente->limpiarCadena($_POST['telefono']),
          'correo' => $cliente->limpiarCadena($_POST['correo']),
          'direccion' => $cliente->limpiarCadena($_POST['direccion']),
        ];
    
        $update = $cliente->actualizarCliente($cleanData);

        echo json_encode($update);
        break;
  }
}
