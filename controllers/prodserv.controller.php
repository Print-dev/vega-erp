<?php
require_once '../models/Prodserv.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$prodserv = new Prodserv();


if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {

        /*         case 'obtenerAreas':
            echo json_encode($nomina->obtenerAreas());
            break;

        case 'obtenerPersonaNumDocColaborador':
            $cleanData = [
                'numdoc'   => $nomina->limpiarCadena($_GET['numdoc']),
            ];
            echo json_encode($nomina->obtenerPersonaNumDocColaborador($cleanData));
            break;

        case 'obtenerUltimaNominaPorColaborador':
            $cleanData = [
                'idcolaborador'   => $nomina->limpiarCadena($_GET['idcolaborador']),
            ];
            echo json_encode($nomina->obtenerUltimaNominaPorColaborador($cleanData));
            break;

        case 'obtenerAcumuladosNomina':
            $cleanData = [
                'idnomina'   => $nomina->limpiarCadena($_GET['idnomina']),
            ];
            echo json_encode($nomina->obtenerAcumuladosNomina($cleanData));
            break;

        case 'obtenerUltimoSalarioPorColaborador':
            $cleanData = [
                'idcolaborador'   => $nomina->limpiarCadena($_GET['idcolaborador']),
            ];
            echo json_encode($nomina->obtenerUltimoSalarioPorColaborador($cleanData));
            break;

        case 'obtenerColaboradorPorId':
            $cleanData = [
                'idcolaborador'   => $nomina->limpiarCadena($_GET['idcolaborador']),
            ];
            echo json_encode($nomina->obtenerColaboradorPorId($cleanData));
            break;

        case 'obtenerSalarioPorId':
            $cleanData = [
                'idsalario'   => $nomina->limpiarCadena($_GET['idsalario']),
            ];
            echo json_encode($nomina->obtenerSalarioPorId($cleanData));
            break;


        case 'filtrarColaboradores':
            $cleanData = [
                'numdoc' => empty($_GET['numdoc']) ? null : $nomina->limpiarCadena($_GET['numdoc']),
                'idarea' => empty($_GET['idarea']) ? null : $nomina->limpiarCadena($_GET['idarea']),
            ];
            echo json_encode($nomina->filtrarColaboradores($cleanData));
            break;

        case 'filtrarNominas':

            echo json_encode($nomina->filtrarNominas());
            break;
 */
        case 'filtrarProdserv':
            /* $cleanData = [
                'idcolaborador' => empty($_GET['idcolaborador']) ? null : $nomina->limpiarCadena($_GET['idcolaborador'])
            ]; */
            echo json_encode($prodserv->filtrarProdserv());
            break;

            /* case 'obtenerNotificacionPropuesta':
            $cleanData = [
                'idreferencia'   => $notificacion->limpiarCadena($_GET['idreferencia']),
            ];
            echo json_encode($notificacion->obtenerNotificacionPropuesta($cleanData));
            break;

        case 'obtenerNotificacionPorNivel':
            $cleanData = [
                'idnivelacceso'   => $notificacion->limpiarCadena($_GET['idnivelacceso']),
                'idusuario'   => $notificacion->limpiarCadena($_GET['idusuario']),
            ];
            echo json_encode($notificacion->obtenerNotificacionPorNivel($cleanData));
            break; */
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
        case 'registrarProdserv':
            $cleanData = [
                'nombre'   => $prodserv->limpiarCadena($_POST['nombre']),
                'tipo'   => $prodserv->limpiarCadena($_POST['tipo']),
                'codigo'   => $prodserv->limpiarCadena($_POST['codigo']),
                'idproveedor' => $prodserv->limpiarCadena($_POST['idproveedor']) ?  $prodserv->limpiarCadena($_POST['idproveedor']) : "",
                'precio' => $prodserv->limpiarCadena($_POST['precio']),
            ];

            $respuesta = ['idprodserv' => -1];

            $idprodserv = $prodserv->registrarProdserv($cleanData);

            if ($idprodserv > 0) {
                $respuesta['idprodserv'] = $idprodserv;
            }

            echo json_encode($respuesta);
            break;
    }
}
