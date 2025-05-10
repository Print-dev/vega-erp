<?php
require_once '../models/DetalleEvento.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$detalleevento = new DetalleEvento();
if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerCotizacionPorNcot':
      echo json_encode($detalleevento->obtenerCotizacionPorNcot(['ncotizacion' => $_GET['ncotizacion']]));
      break;

    case 'obtenerDPporId':
      echo json_encode($detalleevento->obtenerDPporId(['iddetallepresentacion' => $_GET['iddetallepresentacion']]));
      break;

    case 'obtenerInfoDPporId':
      echo json_encode($detalleevento->obtenerInfoDPporId(['iddetallepresentacion' => $_GET['iddetallepresentacion']]));
      break;

    case 'obtenerAcuerdo':
      echo json_encode($detalleevento->obtenerAcuerdo(['iddetallepresentacion' => $_GET['iddetallepresentacion']]));
      break;

    case 'obtenerCotizacion':
      echo json_encode($detalleevento->obtenerCotizacion(['iddetallepresentacion' => $_GET['iddetallepresentacion']]));
      break;

    case 'obtenerCotizacionesPorModalidad':
      echo json_encode($detalleevento->obtenerCotizacionesPorModalidad(['modalidad' => $_GET['modalidad']]));
      break;

    case 'obtenerDpPorFecha':
      echo json_encode($detalleevento->obtenerDpPorFecha(['idusuario' => $_GET['idusuario'], 'fechapresentacion' => $_GET['fechapresentacion']]));
      break;

    case 'obtenerFilmmakerAsociadoEvento':
      echo json_encode($detalleevento->obtenerFilmmakerAsociadoEvento(['idusuario' => $_GET['idusuario']]));
      break;

    case 'obtenerResponsableBoleteriaContrato':
      echo json_encode($detalleevento->obtenerResponsableBoleteriaContrato(['iddetallepresentacion' => $_GET['iddetallepresentacion']]));
      break;

    case 'obtenerPreciosEvento':
      echo json_encode($detalleevento->obtenerPreciosEvento(['iddetallepresentacion' => $_GET['iddetallepresentacion']]));
      break;

    case 'filtrarAtenciones':
      $cleanData = [
        'ncotizacion' => $_GET['ncotizacion'] === "" ? null : $detalleevento->limpiarCadena($_GET['ncotizacion']),
        'ndocumento' => $_GET['ndocumento'] === "" ? null : $detalleevento->limpiarCadena($_GET['ndocumento']),
        'nomusuario' => $_GET['nomusuario'] === "" ? null : $detalleevento->limpiarCadena($_GET['nomusuario']),
        'establecimiento' => $_GET['establecimiento'] === "" ? null : $detalleevento->limpiarCadena($_GET['establecimiento']),
        'fechapresentacion' => $_GET['fechapresentacion'] === "" ? null : $detalleevento->limpiarCadena($_GET['fechapresentacion']),
      ];
      echo json_encode($detalleevento->filtrarAtenciones($cleanData));
      break;

    case 'obtenerDetallesPresentacionPorModalidad':
      $cleanData = [
        'modalidad' => $_GET['modalidad'] === "" ? null : $detalleevento->limpiarCadena($_GET['modalidad']),
        'igv' => $_GET['igv'] === "" ? null : $detalleevento->limpiarCadena($_GET['igv']),
      ];
      echo json_encode($detalleevento->obtenerDetallesPresentacionPorModalidad($cleanData));
      break;

    case 'obtenerNotificacionDP':
      $cleanData = [
        'idreferencia' => $_GET['idreferencia'] === "" ? null : $detalleevento->limpiarCadena($_GET['idreferencia'])
      ];
      echo json_encode($detalleevento->obtenerNotificacionDP($cleanData));
      break;

    case 'obtenerNotificacionDPIndividual':
      $cleanData = [
        'idreferencia' => $_GET['idreferencia'] === "" ? null : $detalleevento->limpiarCadena($_GET['idreferencia'])
      ];
      echo json_encode($detalleevento->obtenerNotificacionDPIndividual($cleanData));
      break;
  }
}
if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarDetallePresentacion':
      $cleanData = [
        'idusuario'   => $detalleevento->limpiarCadena($_POST['idusuario']),
        'idcliente' => $detalleevento->limpiarCadena($_POST['idcliente']),
        'iddistrito' => $detalleevento->limpiarCadena($_POST['iddistrito']) ? $detalleevento->limpiarCadena($_POST['iddistrito']) : '',
        'ncotizacion' => $detalleevento->limpiarCadena($_POST['ncotizacion']) ? $detalleevento->limpiarCadena($_POST['ncotizacion']) : '',
        'fechapresentacion'   => $detalleevento->limpiarCadena($_POST['fechapresentacion']),
        'horainicio'    => $detalleevento->limpiarCadena($_POST['horainicio']) ? $detalleevento->limpiarCadena($_POST['horainicio']) : '',
        'horafinal'    => $detalleevento->limpiarCadena($_POST['horafinal']) ? $detalleevento->limpiarCadena($_POST['horafinal']) : '',
        'establecimiento'  => $detalleevento->limpiarCadena($_POST['establecimiento']) ? $detalleevento->limpiarCadena($_POST['establecimiento']) : '',
        'referencia'  => $detalleevento->limpiarCadena($_POST['referencia']) ? $detalleevento->limpiarCadena($_POST['referencia']) : '',
        'acuerdo'  => $detalleevento->limpiarCadena($_POST['acuerdo']) ? $detalleevento->limpiarCadena($_POST['acuerdo']) : '',
        'tipoevento'  => $detalleevento->limpiarCadena($_POST['tipoevento']) ? $detalleevento->limpiarCadena($_POST['tipoevento']) : '',
        'modotransporte'  => $detalleevento->limpiarCadena($_POST['modotransporte']) ? $detalleevento->limpiarCadena($_POST['modotransporte']) : '',
        'modalidad'  => $detalleevento->limpiarCadena($_POST['modalidad']) ? $detalleevento->limpiarCadena($_POST['modalidad']) : '',
        'validez'  => $detalleevento->limpiarCadena($_POST['validez']) ? $detalleevento->limpiarCadena($_POST['validez']) : '',
        'igv'  => $detalleevento->limpiarCadena($_POST['igv']),
        'esExtranjero'  => $detalleevento->limpiarCadena($_POST['esExtranjero']),
        'idnacionalidad'  => $detalleevento->limpiarCadena($_POST['idnacionalidad']) ? $detalleevento->limpiarCadena($_POST['idnacionalidad']) : '',
      ];

      $respuesta = ['iddetalleevento' => -1];

      $iddetalleevento = $detalleevento->registrarDetallePresentacion($cleanData);

      if ($iddetalleevento > 0) {
        $respuesta['iddetalleevento'] = $iddetalleevento;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarDetallePresentacion':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']) ? $detalleevento->limpiarCadena($_POST['iddetallepresentacion']) : '',
        'fechapresentacion'   => $detalleevento->limpiarCadena($_POST['fechapresentacion']) ? $detalleevento->limpiarCadena($_POST['fechapresentacion']) : '',
        'horainicio'   => $detalleevento->limpiarCadena($_POST['horainicio']) ? $detalleevento->limpiarCadena($_POST['horainicio']) : '',
        'horafinal'   => $detalleevento->limpiarCadena($_POST['horafinal']) ? $detalleevento->limpiarCadena($_POST['horafinal']) : '',
        'establecimiento'   => $detalleevento->limpiarCadena($_POST['establecimiento']) ? $detalleevento->limpiarCadena($_POST['establecimiento']) : '',
        'referencia'   => $detalleevento->limpiarCadena($_POST['referencia']) ? $detalleevento->limpiarCadena($_POST['referencia']) : '',
        'tipoevento'   => $detalleevento->limpiarCadena($_POST['tipoevento']) ? $detalleevento->limpiarCadena($_POST['tipoevento']) : '',
        'modotransporte'   => $detalleevento->limpiarCadena($_POST['modotransporte']) ? $detalleevento->limpiarCadena($_POST['modotransporte']) : '',
        'validez'   => $detalleevento->limpiarCadena($_POST['validez']) ? $detalleevento->limpiarCadena($_POST['validez']) : '',
        'iddistrito'   => $detalleevento->limpiarCadena($_POST['iddistrito']) ? $detalleevento->limpiarCadena($_POST['iddistrito']) : '',
        'igv'   => $detalleevento->limpiarCadena($_POST['igv']) ? $detalleevento->limpiarCadena($_POST['igv']) : '',
      ];

      $rpt = $detalleevento->actualizarDetallePresentacion($cleanData);

      echo json_encode($rpt);
      break;

    case 'actualizarEstadoReservaDp':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']),
        'reserva'   => $detalleevento->limpiarCadena($_POST['reserva']),
      ];

      $rpt = $detalleevento->actualizarEstadoReservaDp($cleanData);

      echo json_encode($rpt);
      break;

    case 'editarAcuerdoEvento':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']),
        'acuerdo'   => $detalleevento->limpiarCadena($_POST['acuerdo']),
      ];

      $rpt = $detalleevento->editarAcuerdoEvento($cleanData);

      echo json_encode($rpt);
      break;

    case 'registrarResponsableBoleteriaContrato':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']) ? $detalleevento->limpiarCadena($_POST['iddetallepresentacion']) : null,
        'idusuarioboleteria'   => $detalleevento->limpiarCadena($_POST['idusuarioboleteria']) ? $detalleevento->limpiarCadena($_POST['idusuarioboleteria']) : null,
        'idusuariocontrato'   => $detalleevento->limpiarCadena($_POST['idusuariocontrato']) ? $detalleevento->limpiarCadena($_POST['idusuariocontrato']) : null,
      ];

      $rpt = $detalleevento->registrarResponsableBoleteriaContrato($cleanData);

      echo json_encode($rpt);
      break;

    case 'registrarPrecioEvento':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']) ? $detalleevento->limpiarCadena($_POST['iddetallepresentacion']) : null,
        'entradas'   => $detalleevento->limpiarCadena($_POST['entradas']) ? $detalleevento->limpiarCadena($_POST['entradas']) : null,
      ];

      $rpt = $detalleevento->registrarPrecioEvento($cleanData);

      echo json_encode($rpt);
      break;

    case 'actualizarResponsableBoleteriaContrato':
      $cleanData = [
        'idresponsablecontrato'   => $detalleevento->limpiarCadena($_POST['idresponsablecontrato']) ? $detalleevento->limpiarCadena($_POST['idresponsablecontrato']) : null,
        'idusuarioboleteria'   => $detalleevento->limpiarCadena($_POST['idusuarioboleteria']) ? $detalleevento->limpiarCadena($_POST['idusuarioboleteria']) : null,
        'idusuariocontrato'   => $detalleevento->limpiarCadena($_POST['idusuariocontrato']) ? $detalleevento->limpiarCadena($_POST['idusuariocontrato']) : null,
      ];

      $rpt = $detalleevento->actualizarResponsableBoleteriaContrato($cleanData);

      echo json_encode($rpt);
      break;

    case 'actualizarPrecioEntradaEvento':
      $cleanData = [
        'idprecioentradaconvenio'   => $detalleevento->limpiarCadena($_POST['idprecioentradaconvenio']) ? $detalleevento->limpiarCadena($_POST['idprecioentradaconvenio']) : null,
        'entradas'   => $detalleevento->limpiarCadena($_POST['entradas']) ? $detalleevento->limpiarCadena($_POST['entradas']) : null,
      ];

      $rpt = $detalleevento->actualizarPrecioEntradaEvento($cleanData);

      echo json_encode($rpt);
      break;

    /* case 'asignarFilmmakerDP':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']),
        'filmmaker'   => $detalleevento->limpiarCadena($_POST['filmmaker']),
      ];

      $rpt = $detalleevento->asignarFilmmakerDP($cleanData);

      echo json_encode($rpt);
      break; */
    case 'asignarAgenda':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']),
        'idusuario'   => $detalleevento->limpiarCadena($_POST['idusuario']),
      ];

      $respuesta = ['idasignacion' => -1];

      $idasignacion = $detalleevento->asignarAgenda($cleanData);

      if ($idasignacion > 0) {
        $respuesta['idasignacion'] = $idasignacion;
      }

      echo json_encode($respuesta);
      break;

    case 'actualizarPagado50DP':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']),
        'pagado50'   => $detalleevento->limpiarCadena($_POST['pagado50']),
      ];

      $rpt = $detalleevento->actualizarPagado50DP($cleanData);

      echo json_encode($rpt);
      break;

    case 'actualizarCajaDP':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']),
        'tienecaja'   => $detalleevento->limpiarCadena($_POST['tienecaja']),
      ];

      $rpt = $detalleevento->actualizarCajaDP($cleanData);

      echo json_encode($rpt);
      break;

    case 'actualizarEstadoDp':
      $cleanData = [
        'iddetallepresentacion'   => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']),
        'estado'   => $detalleevento->limpiarCadena($_POST['estado']),
      ];

      $rpt = $detalleevento->actualizarEstadoDp($cleanData);

      echo json_encode($rpt);
      break;

      /* case 'asignarLugarDestinoBus':
      $cleanData = [
        'iddetallepresentacion' => $detalleevento->limpiarCadena($_POST['iddetallepresentacion']),
        'lugardestino' => $detalleevento->limpiarCadena($_POST['lugardestino']),
      ];

      $update = $detalleevento->asignarLugarDestinoBus($cleanData);

      echo json_encode($update);
      break; */
  }
}
