<?php
require_once '../models/Nomina.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$nomina = new Nomina();


if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {

        case 'obtenerAreas':
            echo json_encode($nomina->obtenerAreas());
            break;

        case 'obtenerPersonaNumDocColaborador':
            $cleanData = [
                'numdoc'   => $nomina->limpiarCadena($_GET['numdoc']),
            ];
            echo json_encode($nomina->obtenerPersonaNumDocColaborador($cleanData));
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
        case 'registrarColaborador':
            $cleanData = [
                'idpersona'   => $nomina->limpiarCadena($_POST['idpersona']),
                'fechaingreso'   => $nomina->limpiarCadena($_POST['fechaingreso']),
                'area' => $nomina->limpiarCadena($_POST['area']),
            ];

            $respuesta = ['idcolaborador' => -1];

            $idcolaborador = $nomina->registrarColaborador($cleanData);

            if ($idcolaborador > 0) {
                $respuesta['idcolaborador'] = $idcolaborador;
            }

            echo json_encode($respuesta);
            break;
        case 'registrarArea':
            $cleanData = [
                'area'   => $nomina->limpiarCadena($_POST['area']),
            ];

            $rpt = $nomina->registrarArea($cleanData);

            echo json_encode($rpt);
            break;

        case 'registrarSalario':
            $cleanData = [
                'idpersona'   => $nomina->limpiarCadena($_POST['idpersona']),
                'fechaingreso'   => $nomina->limpiarCadena($_POST['fechaingreso']),
                'area' => $nomina->limpiarCadena($_POST['area']),
                'nivel'   => $nomina->limpiarCadena($_POST['nivel']) ? $nomina->limpiarCadena($_POST['idreferencia']) : '',
                'mensaje'   => $nomina->limpiarCadena($_POST['mensaje']),
            ];

            $respuesta = ['idsalario' => -1];

            $idsalario = $salario->registrarSalario($cleanData);

            if ($idsalario > 0) {
                $respuesta['idsalario'] = $idsalario;
            }

            echo json_encode($respuesta);
            break;

        case 'registrarNomina':
            $cleanData = [
                'idcolaborador'   => $nomina->limpiarCadena($_POST['idcolaborador']),
                'periodo'   => $nomina->limpiarCadena($_POST['periodo']),
                'fechainicio' => $nomina->limpiarCadena($_POST['fechainicio']),
                'fechafin' => $nomina->limpiarCadena($_POST['fechafin']),
                'horas' => $nomina->limpiarCadena($_POST['horas']),
                'rendimiento' => $nomina->limpiarCadena($_POST['rendimiento']),
                'proporcion' => $nomina->limpiarCadena($_POST['proporcion']),
                'acumulado'   => $nomina->limpiarCadena($_POST['acumulado']),
            ];

            $respuesta = ['idnomina' => -1];

            $idnomina = $nomina->registrarNomina($cleanData);

            if ($idnomina > 0) {
                $respuesta['idnomina'] = $idnomina;
            }

            echo json_encode($respuesta);
            break;
    }
}
