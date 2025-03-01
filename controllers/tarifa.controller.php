

<?php
require_once '../models/Tarifario.php';
header("Access-Control-Allow-Origin: http://localhost:80");
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
    
  }
}
