<?php
require_once '../models/Agenda.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos

$agenda = new Agenda();
// ag order by
if(isset($_GET['operation'])){
  switch($_GET['operation']){

    case 'obtenerAgendaArtista':
        $cleanData = [
          'idusuario' => $_GET['idusuario'] === "" ? null : $agenda->limpiarCadena($_GET['idusuario']),
          'iddetallepresentacion' => $_GET['iddetallepresentacion'] === "" ? null : $agenda->limpiarCadena($_GET['iddetallepresentacion'])
        ];
        echo json_encode($agenda->obtenerAgendaArtista($cleanData));
        break;
        
    
  }
}
