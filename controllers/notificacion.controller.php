<?php
require_once '../models/Notificacion.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$notificacion = new Notificacion();


if(isset($_GET['operation'])){
  switch($_GET['operation']){
    /* case 'obtenerNotificacionesViatico':
        echo json_encode($notificacion->obtenerNotificacionesViatico());
        break; */
    case 'obtenerNotificaciones':
        $cleanData = [
          'idusuariodest'   => $notificacion->limpiarCadena($_GET['idusuariodest']),
        ];
        echo json_encode($notificacion->obtenerNotificaciones($cleanData));
        break;

    case 'obtenerTodasLasNotificaciones':
        $cleanData = [
          'idusuariodest'   => $notificacion->limpiarCadena($_GET['idusuariodest']),
        ];
        echo json_encode($notificacion->obtenerTodasLasNotificaciones($cleanData));
        break;

    case 'obtenerNotificacionPorNivel':
        $cleanData = [
          'idnivelacceso'   => $notificacion->limpiarCadena($_GET['idnivelacceso']),
          'idusuario'   => $notificacion->limpiarCadena($_GET['idusuario']),
        ];
        echo json_encode($notificacion->obtenerNotificacionPorNivel($cleanData));
        break;
  }
}


if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    /* case 'registrarNotificacionViatico':
      $cleanData = [
        'idviatico'   => $notificacion->limpiarCadena($_POST['idviatico']),
        'filmmaker' => $notificacion->limpiarCadena($_POST['filmmaker']),
        'mensaje'   => $notificacion->limpiarCadena($_POST['mensaje']),
      ];

      $respuesta = ['idnotificacion' => -1];

      $idnotificacion = $notificacion->registrarNotificacionViatico($cleanData);

      if ($idnotificacion > 0) {
        $respuesta['idnotificacion'] = $idnotificacion;
      }

      echo json_encode($respuesta);
      break; */
    case 'registrarNotificacion':
      $cleanData = [
        'idusuariodest'   => $notificacion->limpiarCadena($_POST['idusuariodest']),
        'idusuariorem'   => $notificacion->limpiarCadena($_POST['idusuariorem']),
        'tipo' => $notificacion->limpiarCadena($_POST['tipo']),
        'idreferencia'   => $notificacion->limpiarCadena($_POST['idreferencia']) ? $notificacion->limpiarCadena($_POST['idreferencia']) : '' ,
        'mensaje'   => $notificacion->limpiarCadena($_POST['mensaje']),
      ];

      $respuesta = ['idnotificacion' => -1];

      $idnotificacion = $notificacion->registrarNotificacion($cleanData);

      if ($idnotificacion > 0) {
        $respuesta['idnotificacion'] = $idnotificacion;
      }

      echo json_encode($respuesta);
      break;

    
  }
}
