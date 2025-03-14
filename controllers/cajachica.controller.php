

<?php
require_once '../models/CajaChica.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$cajachica = new CajaChica();
// ag order by
if(isset($_GET['operation'])){
  switch($_GET['operation']){
    case 'obtenerUltimaCCFinal':
        echo json_encode($cajachica->obtenerUltimaCCFinal());
        break;
    
    case 'obtenerCajaChicaPorId':
        echo json_encode($cajachica->obtenerCajaChicaPorId(['idcajachica'=>$cajachica->limpiarCadena($_GET['idcajachica'])]));
        break;
    
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarCajaChica':
      $cleanData = [
        'ccinicial'   => $cajachica->limpiarCadena($_POST['ccinicial']),
        'incremento' => $cajachica->limpiarCadena($_POST['incremento']),
        'ccfinal'   => $cajachica->limpiarCadena($_POST['ccfinal']),
      ];

      $respuesta = ['idcajachica' => -1];

      $idcajachica = $cajachica->registrarCajaChica($cleanData);

      if ($idcajachica > 0) {
        $respuesta['idcajachica'] = $idcajachica;
      }

      echo json_encode($respuesta);
      break;
      
    case 'registrarGasto':
      $cleanData = [
        'idcajachica'   => $cajachica->limpiarCadena($_POST['idcajachica']),
        'concepto' => $cajachica->limpiarCadena($_POST['concepto']),
        'monto'   => $cajachica->limpiarCadena($_POST['monto']),
      ];

      $respuesta = ['idcaja' => -1];

      $idcaja = $cajachica->registrarGasto($cleanData);

      if ($idcaja > 0) {
        $respuesta['idcaja'] = $idcaja;
      }

      echo json_encode($respuesta);
      break;

   /*  case 'actualizarViatico':
      $cleanData = [
        'idviatico'=>$viatico->limpiarCadena($_POST['idviatico']),
        'pasaje'=>$viatico->limpiarCadena($_POST['pasaje']),
        'comida'=>$viatico->limpiarCadena($_POST['comida']),
        'viaje'=>$viatico->limpiarCadena($_POST['viaje']) ? $viatico->limpiarCadena($_POST['viaje']) : ''
      ];

      $respuesta=['update'=>false];

      $update = $viatico->actualizarViatico($cleanData);

      if($update){
        $respuesta['update']=true;
      }
      echo json_encode($respuesta);
      break; */
  
  }
}
