<?php
require_once '../models/DetalleEvento.php';

$detalleevento = new DetalleEvento();
// ag order by
/* if (isset($_GET['operation'])) {
  switch ($_GET['operation']) {
    case 'obtenerPersonaPorDoc':
      echo json_encode($detalleevento->obtenerPersonaPorDoc(['num_doc' => $_GET['num_doc']]));
      break;
  }
} */
if (isset($_POST['operation'])) {
  switch ($_POST['operation']) {
    case 'registrarDetalleEvento':
      $cleanData = [
        'idusuario'   => $detalleevento->limpiarCadena($_POST['idusuario']),
        'idcliente' => $detalleevento->limpiarCadena($_POST['idcliente']),
        'fechapresentacion'   => $detalleevento->limpiarCadena($_POST['fechapresentacion']),
        'horapresentacion'    => $detalleevento->limpiarCadena($_POST['horapresentacion']),
        'tiempopresentacion' => $detalleevento->limpiarCadena($_POST['tiempopresentacion']),
        'establecimiento'  => $detalleevento->limpiarCadena($_POST['establecimiento']),
        'tipoevento'  => $detalleevento->limpiarCadena($_POST['tipoevento']),
        'modalidad'  => $detalleevento->limpiarCadena($_POST['modalidad']),
        'validez'  => $detalleevento->limpiarCadena($_POST['validez']),
        'igv'  => $detalleevento->limpiarCadena($_POST['igv']),
        'tipopago'  => $detalleevento->limpiarCadena($_POST['tipopago']),
      ];

      $respuesta = ['iddetalleevento' => -1];

      $iddetalleevento = $detalleevento->registrarDetalleEvento($cleanData);

      if ($iddetalleevento > 0) {
        $respuesta['iddetalleevento'] = $iddetalleevento;
      }

      echo json_encode($respuesta);
      break;
    
  }
}
