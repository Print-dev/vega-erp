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
                //'idarea' => empty($_GET['idarea']) ? null : $nomina->limpiarCadena($_GET['idarea']),
            ];
            echo json_encode($nomina->filtrarColaboradores($cleanData));
            break;

        case 'obtnerNominaPorId':
            $cleanData = [
                'idnomina' => empty($_GET['idnomina']) ? null : $nomina->limpiarCadena($_GET['idnomina']),
                //'idarea' => empty($_GET['idarea']) ? null : $nomina->limpiarCadena($_GET['idarea']),
            ];
            echo json_encode($nomina->obtnerNominaPorId($cleanData));
            break;

        case 'filtrarNominas':
            $cleanData = [
                'mesindividual' => empty($_GET['mesindividual']) ? null : $nomina->limpiarCadena($_GET['mesindividual']),
                'anoindividual' => empty($_GET['anoindividual']) ? null : $nomina->limpiarCadena($_GET['anoindividual']),
                'mesrangoinicio' => empty($_GET['mesrangoinicio']) ? null : $nomina->limpiarCadena($_GET['mesrangoinicio']),
                'anorangoinicio' => empty($_GET['anorangoinicio']) ? null : $nomina->limpiarCadena($_GET['anorangoinicio']),
                'mesrangofin' => empty($_GET['mesrangofin']) ? null : $nomina->limpiarCadena($_GET['mesrangofin']),
                'anorangofin' => empty($_GET['anorangofin']) ? null : $nomina->limpiarCadena($_GET['anorangofin']),
                'idcolaborador' => empty($_GET['idcolaborador']) ? null : $nomina->limpiarCadena($_GET['idcolaborador']),
            ];
            echo json_encode($nomina->filtrarNominas($cleanData));
            break;

        case 'filtrarSalarios':
            $cleanData = [
                'idcolaborador' => empty($_GET['idcolaborador']) ? null : $nomina->limpiarCadena($_GET['idcolaborador'])
            ];
            echo json_encode($nomina->filtrarSalarios($cleanData));
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
                'idsucursal'   => $nomina->limpiarCadena($_POST['idsucursal']),
                'fechaingreso'   => $nomina->limpiarCadena($_POST['fechaingreso']),
                'area' => $nomina->limpiarCadena($_POST['area']),
                'idresponsable' => $nomina->limpiarCadena($_POST['idresponsable']),
                'banco' => $nomina->limpiarCadena($_POST['banco']),
                'ncuenta' => $nomina->limpiarCadena($_POST['ncuenta']),
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
                'idcolaborador'   => $nomina->limpiarCadena($_POST['idcolaborador']),
                'salario'   => $nomina->limpiarCadena($_POST['salario']),
                'periodo'   => $nomina->limpiarCadena($_POST['periodo']),
                'horas'   => $nomina->limpiarCadena($_POST['horas']),
                'costohora'   => $nomina->limpiarCadena($_POST['costohora']),
            ];

            $respuesta = ['idsalario' => -1];

            $idsalario = $nomina->registrarSalario($cleanData);

            if ($idsalario > 0) {
                $respuesta['idsalario'] = $idsalario;
            }

            echo json_encode($respuesta);
            break;

        case 'registrarGastoNomina':
            $cleanData = [
                'idnomina'   => $nomina->limpiarCadena($_POST['idnomina']),
                'descripcion'   => $nomina->limpiarCadena($_POST['descripcion']),
                'monto'   => $nomina->limpiarCadena($_POST['monto'])
            ];

            $respuesta = ['idgastosalario' => -1];

            $idgastosalario = $nomina->registrarGastoNomina($cleanData);

            if ($idgastosalario > 0) {
                $respuesta['idgastosalario'] = $idgastosalario;
            }

            echo json_encode($respuesta);
            break;

        case 'actualizarColaborador':
            $cleanData = [
                'idcolaborador'   => $nomina->limpiarCadena($_POST['idcolaborador']) ? $nomina->limpiarCadena($_POST['idcolaborador']) : '',
                'idsucursal'   => $nomina->limpiarCadena($_POST['idsucursal']) ? $nomina->limpiarCadena($_POST['idsucursal']) : '',
                'fechaingreso' => $nomina->limpiarCadena($_POST['fechaingreso']) ? $nomina->limpiarCadena($_POST['fechaingreso']) : '',
                'idarea'   => $nomina->limpiarCadena($_POST['idarea']) ? $nomina->limpiarCadena($_POST['idarea']) : '',
                'idresponsable'   => $nomina->limpiarCadena($_POST['idresponsable']) ? $nomina->limpiarCadena($_POST['idresponsable']) : '',
                'banco'   => $nomina->limpiarCadena($_POST['banco']) ? $nomina->limpiarCadena($_POST['banco']) : '',
                'ncuenta'   => $nomina->limpiarCadena($_POST['ncuenta']) ? $nomina->limpiarCadena($_POST['ncuenta']) : '',
            ];

            $rpt = $nomina->actualizarColaborador($cleanData);

            echo json_encode($rpt);
            break;

        case 'actualizarSalario':
            $cleanData = [
                'idsalario'   => $nomina->limpiarCadena($_POST['idsalario']) ? $nomina->limpiarCadena($_POST['idsalario']) : '',
                'salario'   => $nomina->limpiarCadena($_POST['salario']) ? $nomina->limpiarCadena($_POST['salario']) : '',
                'periodo'   => $nomina->limpiarCadena($_POST['periodo']) ? $nomina->limpiarCadena($_POST['periodo']) : '',
                'horas'   => $nomina->limpiarCadena($_POST['horas']) ? $nomina->limpiarCadena($_POST['horas']) : '',
                'costohora' => $nomina->limpiarCadena($_POST['costohora']) ? $nomina->limpiarCadena($_POST['costohora']) : '',
                'fechainicio'   => $nomina->limpiarCadena($_POST['fechainicio']) ? $nomina->limpiarCadena($_POST['fechainicio']) : '',
            ];

            $rpt = $nomina->actualizarSalario($cleanData);

            echo json_encode($rpt);
            break;

        /*         case 'registrarNomina':
            $cleanData = [
                'idcolaborador'   => $nomina->limpiarCadena($_POST['idcolaborador']),
                'salariousado'   => $nomina->limpiarCadena($_POST['salariousado']),
                'periodo'   => $nomina->limpiarCadena($_POST['periodo']),
                'idarea'   => $nomina->limpiarCadena($_POST['idarea']),
                'tiempo'   => $nomina->limpiarCadena($_POST['tiempo']),
                'horas'   => $nomina->limpiarCadena($_POST['horas']),
                'rendimiento' => $nomina->limpiarCadena($_POST['rendimiento']) ? $nomina->limpiarCadena($_POST['rendimiento']) : '',
                'proporcion' => $nomina->limpiarCadena($_POST['proporcion']) ? $nomina->limpiarCadena($_POST['proporcion']) : '',
                'acumulado' => $nomina->limpiarCadena($_POST['acumulado']) ? $nomina->limpiarCadena($_POST['acumulado']) : '',
            ];

            $respuesta = ['idnomina' => -1];

            $idnomina = $nomina->registrarNomina($cleanData);

            if ($idnomina > 0) {
                $respuesta['idnomina'] = $idnomina;
            }

            echo json_encode($respuesta);
            break; */

        /*         case 'registrarNomina':
            $cleanData = [
                'tipo'               => $nomina->limpiarCadena($_POST['tipo']) ? $nomina->limpiarCadena($_POST['tipo']) : '',
                'nombreapellido'     => $nomina->limpiarCadena($_POST['nombreapellido']) ? $nomina->limpiarCadena($_POST['nombreapellido']) : '',
                'dni'                => $nomina->limpiarCadena($_POST['dni']) ? $nomina->limpiarCadena($_POST['dni']) : '',
                'idarea'             => $nomina->limpiarCadena($_POST['idarea']) ? $nomina->limpiarCadena($_POST['idarea']) : '',
                'fnacimiento'        => $nomina->limpiarCadena($_POST['fnacimiento']) ? $nomina->limpiarCadena($_POST['fnacimiento']) : '',
                'estadocivil'        => $nomina->limpiarCadena($_POST['estadocivil']) ? $nomina->limpiarCadena($_POST['estadocivil']) : '',
                'sexo'               => $nomina->limpiarCadena($_POST['sexo']) ? $nomina->limpiarCadena($_POST['sexo']) : '',
                'domicilio'          => $nomina->limpiarCadena($_POST['domicilio']) ? $nomina->limpiarCadena($_POST['domicilio']) : '',
                'correo'             => $nomina->limpiarCadena($_POST['correo']) ? $nomina->limpiarCadena($_POST['correo']) : '',
                'nivelestudio'       => $nomina->limpiarCadena($_POST['nivelestudio']) ? $nomina->limpiarCadena($_POST['nivelestudio']) : '',
                'contactoemergencia' => $nomina->limpiarCadena($_POST['contactoemergencia']) ? $nomina->limpiarCadena($_POST['contactoemergencia']) : '',
                'discapacidad'       => $nomina->limpiarCadena($_POST['discapacidad']) ? $nomina->limpiarCadena($_POST['discapacidad']) : '',
                'camisa'             => $nomina->limpiarCadena($_POST['camisa']) ? $nomina->limpiarCadena($_POST['camisa']) : '',
                'pantalon'           => $nomina->limpiarCadena($_POST['pantalon']) ? $nomina->limpiarCadena($_POST['pantalon']) : '',
                'ruc'                => $nomina->limpiarCadena($_POST['ruc']) ? $nomina->limpiarCadena($_POST['ruc']) : '',
                'clavesol'           => $nomina->limpiarCadena($_POST['clavesol']) ? $nomina->limpiarCadena($_POST['clavesol']) : '',
                'ncuenta'            => $nomina->limpiarCadena($_POST['ncuenta']) ? $nomina->limpiarCadena($_POST['ncuenta']) : '',
            ];

            $respuesta = ['idnomina' => -1];

            $idnomina = $nomina->registrarNomina($cleanData);

            if ($idnomina > 0) {
                $respuesta['idnomina'] = $idnomina;
            }

            echo json_encode($respuesta);
            break; */

        case 'registrarNomina':
            $cleanData = [
                'idpersonacolaborador'               => $nomina->limpiarCadena($_POST['idpersonacolaborador']) ? $nomina->limpiarCadena($_POST['idpersonacolaborador']) : '',
                'tipo'     => $nomina->limpiarCadena($_POST['tipo']) ? $nomina->limpiarCadena($_POST['tipo']) : '',
                'fechaingreso'                => $nomina->limpiarCadena($_POST['fechaingreso']) ? $nomina->limpiarCadena($_POST['fechaingreso']) : '',
                'ruc'        => $nomina->limpiarCadena($_POST['ruc']) ? $nomina->limpiarCadena($_POST['ruc']) : '',
                'clavesol'        => $nomina->limpiarCadena($_POST['clavesol']) ? $nomina->limpiarCadena($_POST['clavesol']) : '',
                'ncuenta'               => $nomina->limpiarCadena($_POST['ncuenta']) ? $nomina->limpiarCadena($_POST['ncuenta']) : '',

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
