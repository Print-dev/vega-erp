

<?php
require_once '../models/AgendaCManager.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$agendacmanager = new AgendaCManager();
// ag order by
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerCmanagerPorIdAgendaEditor':
      $cleanData = [
        'idagendaeditor' => $_GET['idagendaeditor'] === "" ? null : $agendacmanager->limpiarCadena($_GET['idagendaeditor'])
      ];
      echo json_encode($agendacmanager->obtenerCmanagerPorIdAgendaEditor($cleanData));
      break;

    
  }
}

if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarAgendaCManager':
      $cleanData = [
        'idagendaeditor'   => $agendacmanager->limpiarCadena($_POST['idagendaeditor']),
        'idusuariocmanager'   => $agendacmanager->limpiarCadena($_POST['idusuariocmanager']),
      ];

      $respuesta = ['idagendacmanager' => -1];

      $idagendacmanager = $agendacmanager->registrarAgendaCManager($cleanData);

      if ($idagendacmanager > 0) {
        $respuesta['idagendacmanager'] = $idagendacmanager;
      }

      echo json_encode($respuesta);
      break;

      case 'quitarResponsablePosteo':
        $cleanData = [
          'idagendaeditor' => $agendacmanager->limpiarCadena($_POST['idagendaeditor'])
        ];
  
        $eliminado = $agendacmanager->quitarResponsablePosteo($cleanData);
  
        echo json_encode($eliminado);
        break; 

      case 'asignarPortalWebContenido':
        $cleanData = [
          'idagendacommanager' => $agendacmanager->limpiarCadena($_POST['idagendacommanager']),
          'portalpublicar' => $agendacmanager->limpiarCadena($_POST['portalpublicar']),
        ];
  
        $update = $agendacmanager->asignarPortalWebContenido($cleanData);
  
        echo json_encode($update);
        break; 

      case 'actualizarEstadoPublicarContenido':
        $cleanData = [
          'idagendacommanager' => $agendacmanager->limpiarCadena($_POST['idagendacommanager']),
          'estado' => $agendacmanager->limpiarCadena($_POST['estado']),
        ];
  
        $update = $agendacmanager->actualizarEstadoPublicarContenido($cleanData);
  
        echo json_encode($update);
        break; 
  }
}
