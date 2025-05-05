

<?php
require_once '../models/Tarifario.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$tarifa = new Tarifario();
// ag order by
if(isset($_GET['operation'])){
  switch($_GET['operation']){
    case 'filtrarTarifas':
        $cleanData = [
          'nomusuario' => $_GET['nomusuario'] === "" ? null : $tarifa->limpiarCadena($_GET['nomusuario'])
        ];
        echo json_encode($tarifa->filtrarTarifas($cleanData));
        break;

    case 'obtenerTarifasPorProvinciaYTipo':
        $cleanData = [
          'iddepartamento' => $tarifa->limpiarCadena($_GET['iddepartamento']), 
          'idusuario' => $tarifa->limpiarCadena($_GET['idusuario']),
          'tipoevento' => $tarifa->limpiarCadena($_GET['tipoevento']),
        ];
        echo json_encode($tarifa->obtenerTarifasPorProvinciaYTipo($cleanData));
        break;
        
    case 'obtenerTarifaArtistaPorProvincia':
        $cleanData = [
          'idprovincia' => $tarifa->limpiarCadena($_GET['idprovincia']),
          'idusuario' => $tarifa->limpiarCadena($_GET['idusuario']),
          'tipoevento' => $tarifa->limpiarCadena($_GET['tipoevento']),
        ];
        echo json_encode($tarifa->obtenerTarifaArtistaPorProvincia($cleanData));
        break;
    
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarTarifa':
      $cleanData = [
        'idusuario'   => $tarifa->limpiarCadena($_POST['idusuario']),
        'idprovincia' => $tarifa->limpiarCadena($_POST['idprovincia']),
        'precio'   => $tarifa->limpiarCadena($_POST['precio']),
        'tipoevento'   => $tarifa->limpiarCadena($_POST['tipoevento']),
      ];

      $respuesta = ['idtarifa' => -1];

      $idtarifa = $tarifa->registrarTarifa($cleanData);

      if ($idtarifa > 0) {
        $respuesta['idtarifa'] = $idtarifa;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarTarifa':
      $cleanData = [
        'idtarifario'=>$tarifa->limpiarCadena($_POST['idtarifario']),
        'precio'=>$tarifa->limpiarCadena($_POST['precio'])
      ];

      $respuesta=['update'=>false];

      $update = $tarifa->actualizarTarifa($cleanData);

      if($update){
        $respuesta['update']=true;
      }
      echo json_encode($respuesta);
      break;
  
  }
}
