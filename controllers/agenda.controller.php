<?php
require_once '../models/Agenda.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos

$agenda = new Agenda();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {

    case 'obtenerAgendaArtista':
      $cleanData = [
        'idusuario' => $_GET['idusuario'] === "" ? null : $agenda->limpiarCadena($_GET['idusuario']),
        'iddetallepresentacion' => $_GET['iddetallepresentacion'] === "" ? null : $agenda->limpiarCadena($_GET['iddetallepresentacion'])
      ];
      echo json_encode($agenda->obtenerAgendaArtista($cleanData));
      break;

    case 'obtenerAgenda':
      $cleanData = [
        'idusuario' => $_GET['idusuario'] === "" ? null : $agenda->limpiarCadena($_GET['idusuario']),
        'iddetallepresentacion' => $_GET['iddetallepresentacion'] === "" ? null : $agenda->limpiarCadena($_GET['iddetallepresentacion']),
        'idnivelacceso' => $_GET['idnivelacceso'] === "" ? null : $agenda->limpiarCadena($_GET['idnivelacceso']),
      ];
      echo json_encode($agenda->obtenerAgenda($cleanData));
      break;

    case 'obtenerFilmmakerAsignado':
      $cleanData = [
        'iddetallepresentacion' => $_GET['iddetallepresentacion'] === "" ? null : $agenda->limpiarCadena($_GET['iddetallepresentacion']),
      ];
      echo json_encode($agenda->obtenerFilmmakerAsignado($cleanData));
      break;
      
    case 'obtenerAgendaEdicionPorEditorYGeneral':
      $cleanData = [
        'idusuario' => $_GET['idusuario'] === "" ? null : $agenda->limpiarCadena($_GET['idusuario']),
      ];
      echo json_encode($agenda->obtenerAgendaEdicionPorEditorYGeneral($cleanData));
      break;

    case 'obtenerTodasLasAgendasEdicion':
      echo json_encode($agenda->obtenerTodasLasAgendasEdicion());
      break;
  }
}
//asignarAgendaEditor
if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'asignarAgendaEditor':
      $cleanData = [
        'idagendaedicion'   =>  $agenda->limpiarCadena($_POST['idagendaedicion']),
        'idusuario'   => $agenda->limpiarCadena($_POST['idusuario']),
        'tipotarea'   => $agenda->limpiarCadena($_POST['tipotarea']),
        'fechaentrega' => $agenda->limpiarCadena($_POST['fechaentrega'])
      ];

      $respuesta = ['idagendaeditor' => -1];

      $idagendaeditor = $agenda->asignarAgendaEditor($cleanData);

      if ($idagendaeditor > 0) {
        $respuesta['idagendaeditor'] = $idagendaeditor;
      }

      echo json_encode($respuesta);
      break;

    case 'registrarAgendaEdicion':
      $cleanData = [
        'iddetallepresentacion'   =>  $agenda->limpiarCadena($_POST['iddetallepresentacion'])
      ];

      $idagendaeditor = $agenda->registrarAgendaEdicion($cleanData);
      echo json_encode($idagendaeditor);
      break;


    case 'actualizarAgendaEditor':
      $cleanData = [
        'idagendaeditor' => $agenda->limpiarCadena($_POST['idagendaeditor']),
        'urlimagen' => $agenda->limpiarCadena($_POST['urlimagen']),
        'urlvideo' => $agenda->limpiarCadena($_POST['urlvideo']),
      ];

      $update = $agenda->actualizarAgendaEditor($cleanData);

      echo json_encode($update);
      break;
  }
}
