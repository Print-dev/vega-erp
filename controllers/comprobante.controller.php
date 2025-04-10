

<?php
require_once '../models/Comprobante.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$comprobante = new Comprobante();
// ag order by
/* if(isset($_GET['operation'])){
  switch($_GET['operation']){
    case 'filtrarTarifas':
        $cleanData = [
          'nomusuario' => $_GET['nomusuario'] === "" ? null : $tarifa->limpiarCadena($_GET['nomusuario'])
        ];
        echo json_encode($tarifa->filtrarTarifas($cleanData));
        break;

    case 'obtenerTarifasPorProvincia':
        $cleanData = [
          'iddepartamento' => $tarifa->limpiarCadena($_GET['iddepartamento']), 
          'idusuario' => $tarifa->limpiarCadena($_GET['idusuario']) 
        ];
        echo json_encode($tarifa->obtenerTarifasPorProvincia($cleanData));
        break;
        
    case 'obtenerTarifaArtistaPorProvincia':
        $cleanData = [
          'idprovincia' => $tarifa->limpiarCadena($_GET['idprovincia']),
          'idusuario' => $tarifa->limpiarCadena($_GET['idusuario']),
        ];
        echo json_encode($tarifa->obtenerTarifaArtistaPorProvincia($cleanData));
        break;
    
  }
} */

if (isset($_POST['operation'])) {
    switch ($_POST['operation']) {
        case 'registrarTarifa':
            $cleanData = [
                'idsucursal'   => $comprobante->limpiarCadena($_POST['idsucursal']),
                'idcliente' => $comprobante->limpiarCadena($_POST['idcliente']),
                'idtipodoc'   => $comprobante->limpiarCadena($_POST['idtipodoc']),
                'nserie'   => $comprobante->limpiarCadena($_POST['nserie']),
                'correlativo'   => $comprobante->limpiarCadena($_POST['correlativo']),
                'tipomoneda'   => $comprobante->limpiarCadena($_POST['tipomoneda']),
                'monto'   => $comprobante->limpiarCadena($_POST['monto']),
            ];

            $respuesta = ['idcomprobante' => -1];

            $idcomprobante = $comprobante->registrarComprobante($cleanData);

            if ($idcomprobante > 0) {
                $respuesta['idcomprobante'] = $idcomprobante;
            }

            echo json_encode($respuesta);
            break;

        case 'registrarItemComprobante':
            $cleanData = [
                'idcomprobante'   => $comprobante->limpiarCadena($_POST['idcomprobante']),
                'cantidad ' => $comprobante->limpiarCadena($_POST['cantidad ']),
                'descripcion'   => $comprobante->limpiarCadena($_POST['descripcion']),
                'valorunitario'   => $comprobante->limpiarCadena($_POST['valorunitario']),
                'valortotal'   => $comprobante->limpiarCadena($_POST['valortotal'])
            ];

            $rpt = $comprobante->registrarItemComprobante($cleanData);

            echo json_encode($rpt);
            break;

        case 'registrarDetalleComprobante':
            $cleanData = [
                'idcomprobante'   => $comprobante->limpiarCadena($_POST['idcomprobante']),
                'estado ' => $comprobante->limpiarCadena($_POST['estado ']),
                'info'   => $comprobante->limpiarCadena($_POST['info'])
            ];

            $rpt = $comprobante->registrarItemComprobante($cleanData);

            echo json_encode($rpt);
            break;
    }
}
