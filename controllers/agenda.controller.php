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

    case 'obtenerAgendaFilmmakers':
      $cleanData = [
        'idusuario' => $_GET['idusuario'] === "" ? null : $agenda->limpiarCadena($_GET['idusuario']),
        'iddetallepresentacion' => $_GET['iddetallepresentacion'] === "" ? null : $agenda->limpiarCadena($_GET['iddetallepresentacion']),
        'idnivelacceso' => $_GET['idnivelacceso'] === "" ? null : $agenda->limpiarCadena($_GET['idnivelacceso']),
      ];
      echo json_encode($agenda->obtenerAgendaFilmmakers($cleanData));
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

    case 'obtenerContenidoHistorialEdicion':
      $cleanData = [
        'idagendaeditor' => $_GET['idagendaeditor'] === "" ? null : $agenda->limpiarCadena($_GET['idagendaeditor']),
      ];
      echo json_encode($agenda->obtenerContenidoHistorialEdicion($cleanData));
      break;

    case 'obtenerEditoresAsignados':
      $cleanData = [
        'idagendaedicion' => $_GET['idagendaedicion'] === "" ? null : $agenda->limpiarCadena($_GET['idagendaedicion']),
      ];
      echo json_encode($agenda->obtenerEditoresAsignados($cleanData));
      break;

    case 'obtenerUsuarioAsignado':
      $cleanData = [
        'idagendaedicion' => $_GET['idagendaedicion'] === "" ? null : $agenda->limpiarCadena($_GET['idagendaedicion']),
        'idtipotarea' => $_GET['idtipotarea'] === "" ? null : $agenda->limpiarCadena($_GET['idtipotarea']),
      ];
      echo json_encode($agenda->obtenerUsuarioAsignado($cleanData));
      break;

    /* case 'obtenerTareaPorUsuario':
      $cleanData = [
        'idusuario' => $_GET['idusuario'] === "" ? null : $agenda->limpiarCadena($_GET['idusuario']),
      ];
      echo json_encode($agenda->obtenerTareaPorUsuario($cleanData));
      break; */

    case 'obtenerTareaPorUsuarioYagenda':
      $cleanData = [
        'idusuario' => $_GET['idusuario'] === "" ? null : $agenda->limpiarCadena($_GET['idusuario']),
        'idagendaedicion' => $_GET['idagendaedicion'] === "" ? null : $agenda->limpiarCadena($_GET['idagendaedicion']),
      ];
      echo json_encode($agenda->obtenerTareaPorUsuarioYagenda($cleanData));
      break;

    case 'obtenerTodasLasTareasEnLaAgenda':
      $cleanData = [
        'idagendaedicion' => $_GET['idagendaedicion'] === "" ? null : $agenda->limpiarCadena($_GET['idagendaedicion']),
      ];
      echo json_encode($agenda->obtenerTodasLasTareasEnLaAgenda($cleanData));
      break;

    case 'obtenerTareasEditor':
      $cleanData = [
        'idusuario' => $_GET['idusuario'] === "" ? null : $agenda->limpiarCadena($_GET['idusuario']),
      ];
      echo json_encode($agenda->obtenerTareasEditor($cleanData));
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
        'idtipotarea'   => $agenda->limpiarCadena($_POST['idtipotarea']),
        'fechaentrega' => $agenda->limpiarCadena($_POST['fechaentrega']),
        'horaentrega' => $agenda->limpiarCadena($_POST['horaentrega']),
      ];

      $respuesta = ['idagendaeditor' => -1];

      $idagendaeditor = $agenda->asignarAgendaEditor($cleanData);

      if ($idagendaeditor > 0) {
        $respuesta['idagendaeditor'] = $idagendaeditor;
      }

      echo json_encode($respuesta);
      break;

    case 'subirContenidoEditor':
      $cleanData = [
        'idagendaeditor'   =>  $agenda->limpiarCadena($_POST['idagendaeditor']) ? $agenda->limpiarCadena($_POST['idagendaeditor']) : '',
        'url'   => $agenda->limpiarCadena($_POST['url']) ?  $agenda->limpiarCadena($_POST['url']) :''
      ];

      $respuesta = ['idsubida' => -1];

      $idsubida = $agenda->subirContenidoEditor($cleanData);

      if ($idsubida > 0) {
        $respuesta['idsubida'] = $idsubida;
      }

      echo json_encode($respuesta);
      break;
      
    case 'registrarNuevoTipoTarea':
      $cleanData = [
        'tipotarea'   =>  $agenda->limpiarCadena($_POST['tipotarea']) ? $agenda->limpiarCadena($_POST['tipotarea']) : ''
      ];

      $respuesta = ['idtipotarea' => -1];

      $idtipotarea = $agenda->registrarNuevoTipoTarea($cleanData);

      if ($idtipotarea > 0) {
        $respuesta['idtipotarea'] = $idtipotarea;
      }

      echo json_encode($respuesta);
      break;

    case 'reportarSalidaRetornoArtista':
      $cleanData = [
        'iddetallepresentacion'   =>  $agenda->limpiarCadena($_POST['iddetallepresentacion']) ? $agenda->limpiarCadena($_POST['iddetallepresentacion']) : '',
        'tipo'   =>  $agenda->limpiarCadena($_POST['tipo']) ? $agenda->limpiarCadena($_POST['tipo']) : '',
        'fecha'   =>  $agenda->limpiarCadena($_POST['fecha']) ? $agenda->limpiarCadena($_POST['fecha']) : '',
        'hora'   =>  $agenda->limpiarCadena($_POST['hora']) ? $agenda->limpiarCadena($_POST['hora']) : '',
      ];

      $respuesta = ['idreporte' => -1];

      $idreporte = $agenda->reportarSalidaRetornoArtista($cleanData);

      if ($idreporte > 0) {
        $respuesta['idreporte'] = $idreporte;
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


/*     case 'actualizarAgendaEditor':
      $cleanData = [
        'idagendaeditor' => $agenda->limpiarCadena($_POST['idagendaeditor']),
        'urlimagen' => $agenda->limpiarCadena($_POST['urlimagen']),
        'urlvideo' => $agenda->limpiarCadena($_POST['urlvideo']),
      ];

      $update = $agenda->actualizarAgendaEditor($cleanData);

      echo json_encode($update);
      break;
 */
    case 'comentarContenido':
      $cleanData = [
        'idsubida' => $agenda->limpiarCadena($_POST['idsubida']),
        'observaciones' => $agenda->limpiarCadena($_POST['observaciones'])
      ];

      $update = $agenda->comentarContenido($cleanData);

      echo json_encode($update);
      break;

    case 'actualizarEstadoTareaEdicion':
      $cleanData = [
        'idagendaeditor' => $agenda->limpiarCadena($_POST['idagendaeditor']),
        'estado' => $agenda->limpiarCadena($_POST['estado'])
      ];

      $update = $agenda->actualizarEstadoTareaEdicion($cleanData);

      echo json_encode($update);
      break;

    case 'actualizarEstadoAltoketicket':
      $cleanData = [
        'idagendaeditor' => $agenda->limpiarCadena($_POST['idagendaeditor']),
        'altoketicket' => $agenda->limpiarCadena($_POST['altoketicket'])
      ];

      $update = $agenda->actualizarEstadoAltoketicket($cleanData);

      echo json_encode($update);
      break;

    case 'actualizarAgendaEditor':
      $cleanData = [
        'idagendaeditor' => $agenda->limpiarCadena($_POST['idagendaeditor']),
        'idusuario' => $agenda->limpiarCadena($_POST['idusuario']),
        'idtipoentrega' => $agenda->limpiarCadena($_POST['idtipoentrega']),
        'fechaentrega' => $agenda->limpiarCadena($_POST['fechaentrega']),
        'horaentrega' => $agenda->limpiarCadena($_POST['horaentrega'])
      ];

      $update = $agenda->actualizarAgendaEditor($cleanData);

      echo json_encode($update);
      break;

    case 'eliminarTareaUsuario':
      $cleanData = [
        'idagendaeditor' => $agenda->limpiarCadena($_POST['idagendaeditor'])
      ];

      $eliminado = $agenda->eliminarTareaUsuario($cleanData);

      echo json_encode($eliminado);
      break;
  }
}
