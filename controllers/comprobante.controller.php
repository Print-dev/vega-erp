<?php
require_once '../models/Comprobante.php';
require_once '../factura.php';

header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$comprobante = new Comprobante();



if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {
        case 'obtenerSeriePorTipoDoc':
            echo json_encode($comprobante->obtenerSeriePorTipoDoc(['idtipodoc' => $_GET['idtipodoc']]));
            break;
       
    }
}

if (isset($_POST['operation'])) {
    switch ($_POST['operation']) {
        case 'registrarComprobante':
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

        case 'emitirFactura':
            // Recolectar y limpiar los datos POST
            $data = [
                'ruc_emisor' => $comprobante->limpiarCadena($_POST['ruc_emisor']),
                'razon_social_emisor' => $comprobante->limpiarCadena($_POST['razon_social_emisor']),
                'direccion_emisor' => $comprobante->limpiarCadena($_POST['direccion_emisor']),
                'departamento' => $comprobante->limpiarCadena($_POST['departamento']),
                'provincia' => $comprobante->limpiarCadena($_POST['provincia']),
                'distrito' => $comprobante->limpiarCadena($_POST['distrito']),

                'ndocumento' => $comprobante->limpiarCadena($_POST['ndocumento']),
                'razon_social_cliente' => $comprobante->limpiarCadena($_POST['razon_social_cliente']),

                'serie' => $comprobante->limpiarCadena($_POST['serie']),
                'correlativo' => $comprobante->limpiarCadena($_POST['correlativo']),
                'moneda' => $comprobante->limpiarCadena($_POST['moneda']),
                'monto_gravado' => (float)$_POST['monto_gravado'],
                'igv' => (float)$_POST['igv'],
                'total' => (float)$_POST['total'],
                'detalle' => json_decode($_POST['detalle'], true), // Recibe lista de ítems
                'monto_letras' => $comprobante->limpiarCadena($_POST['monto_letras'])
            ];

            $rpt = generarFactura($data);
            echo json_encode($rpt);
            break;
    }
}
