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

        case 'obtenerItemsPorIdComprobante':
            echo json_encode($comprobante->obtenerItemsPorIdComprobante(['idcomprobante' => $_GET['idcomprobante']]));
            break;

        case 'obtenerDetallesComprobante':
            echo json_encode($comprobante->obtenerDetallesComprobante(['idcomprobante' => $_GET['idcomprobante']]));
            break;

        case 'obtenerComprobantePorTipoDoc':
            echo json_encode($comprobante->obtenerComprobantePorTipoDoc(['idcomprobante' => $_GET['idcomprobante'], 'idtipodoc' => $_GET['idtipodoc']]));
            break;

        case 'obtenerPagosCuotasPorIdCuota':
            echo json_encode($comprobante->obtenerPagosCuotasPorIdCuota(['idcuotacomprobante' => $_GET['idcuotacomprobante']]));
            break;

        case 'obtenerCuotasFacturaPorIdComprobante':
            echo json_encode($comprobante->obtenerCuotasFacturaPorIdComprobante(['idcomprobante' => $_GET['idcomprobante']]));
            break;

        case 'filtrarFacturas':
            $cleanData = [
                'fechaemision' => $_GET['fechaemision'] === "" ? null : $comprobante->limpiarCadena($_GET['fechaemision']),
                'horaemision' => $_GET['horaemision'] === "" ? null : $comprobante->limpiarCadena($_GET['horaemision']),
                'numerocomprobante' => $_GET['numerocomprobante'] === "" ? null : $comprobante->limpiarCadena($_GET['numerocomprobante'])
            ];
            echo json_encode($comprobante->filtrarFacturas($cleanData));
            break;

        case 'filtrarCuotas':
            $cleanData = [
                'fecha' => $_GET['fecha'] === "" ? null : $comprobante->limpiarCadena($_GET['fecha']),
                'numerocomprobante' => $_GET['numerocomprobante'] === "" ? null : $comprobante->limpiarCadena($_GET['numerocomprobante']),
                'idcliente' => $_GET['idcliente'] === "" ? null : $comprobante->limpiarCadena($_GET['idcliente'])
            ];
            echo json_encode($comprobante->filtrarCuotas($cleanData));
            break;


        case 'descargarXML':
            $basePath = __DIR__ . '/../sunat/cpe/xml/'; // Ruta real en el servidor (no URL)

            if (!isset($_GET['archivo'])) {
                http_response_code(400);
                exit('Archivo no especificado.');
            }

            $archivo = basename($_GET['archivo']);
            $ruta = $basePath . $archivo . '.xml';

            if (!file_exists($ruta)) {
                http_response_code(404);
                exit('Archivo no encontrado.');
            }

            // Forzar descarga
            header('Content-Type: application/xml');
            header('Content-Disposition: attachment; filename="' . $archivo . '.xml"');
            header('Content-Length: ' . filesize($ruta));
            readfile($ruta);
            break;

        case 'descargarCDR':
            $basePath = __DIR__ . '/../sunat/cpe/cdr/'; // Ruta real en el servidor (no URL)

            if (!isset($_GET['archivo'])) {
                http_response_code(400);
                exit('Archivo no especificado.');
            }

            $archivo = basename($_GET['archivo']);
            $ruta = $basePath . $archivo . '.zip';

            if (!file_exists($ruta)) {
                http_response_code(404);
                exit('Archivo no encontrado.');
            }

            // Forzar descarga
            header('Content-Type: application/xml');
            header('Content-Disposition: attachment; filename="' . $archivo . '.zip"');
            header('Content-Length: ' . filesize($ruta));
            readfile($ruta);
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
                'tipopago'   => $comprobante->limpiarCadena($_POST['tipopago']),
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
                'cantidad' => $comprobante->limpiarCadena($_POST['cantidad']),
                'descripcion'   => $comprobante->limpiarCadena($_POST['descripcion']),
                'valorunitario'   => $comprobante->limpiarCadena($_POST['valorunitario']),
                'valortotal'   => $comprobante->limpiarCadena($_POST['valortotal'])
            ];

            $rpt = $comprobante->registrarItemComprobante($cleanData);

            echo json_encode($rpt);
            break;

        case 'registrarCuotaFactura':
            $cleanData = [
                'idcomprobante'   => $comprobante->limpiarCadena($_POST['idcomprobante']),
                'fecha' => $comprobante->limpiarCadena($_POST['fecha']),
                'monto'   => $comprobante->limpiarCadena($_POST['monto'])
            ];

            $rpt = $comprobante->registrarCuotaFactura($cleanData);

            echo json_encode($rpt);
            break;
            
        case 'registrarPagoCuota':
            $cleanData = [
                'idcuotacomprobante'   => $comprobante->limpiarCadena($_POST['idcuotacomprobante']),
                'montopagado' => $comprobante->limpiarCadena($_POST['montopagado']),
                'tipopago'   => $comprobante->limpiarCadena($_POST['tipopago']),
                'noperacion'   => $comprobante->limpiarCadena($_POST['noperacion']) ? $comprobante->limpiarCadena($_POST['noperacion']) : null,
            ];

            $rpt = $comprobante->registrarPagoCuota($cleanData);

            echo json_encode($rpt);
            break;

        case 'registrarDetalleComprobante':
            $cleanData = [
                'idcomprobante'   => $comprobante->limpiarCadena($_POST['idcomprobante']),
                'estado' => $comprobante->limpiarCadena($_POST['estado']),
                'info'   => $comprobante->limpiarCadena($_POST['info'])
            ];

            $rpt = $comprobante->registrarDetalleComprobante($cleanData);

            echo json_encode($rpt);
            break;

        case 'actualizarEstadoCuotaComprobante':
            $cleanData = [
                'idcuotacomprobante'   => $comprobante->limpiarCadena($_POST['idcuotacomprobante']),
                'estado'   => $comprobante->limpiarCadena($_POST['estado']),
            ];

            $rpt = $comprobante->actualizarEstadoCuotaComprobante($cleanData);

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
                'ubigeo' => $comprobante->limpiarCadena($_POST['ubigeo']),


                'ndocumento' => $comprobante->limpiarCadena($_POST['ndocumento']),
                'razon_social_cliente' => $comprobante->limpiarCadena($_POST['razon_social_cliente']),

                'serie' => $comprobante->limpiarCadena($_POST['serie']),
                'correlativo' => $comprobante->limpiarCadena($_POST['correlativo']),
                'moneda' => $comprobante->limpiarCadena($_POST['moneda']),
                'monto_gravado' => (float)$_POST['monto_gravado'],
                'igv' => (float)$_POST['igv'],
                'total' => (float)$_POST['total'],
                'detalle' => json_decode($_POST['detalle'], true), // Recibe lista de ítems
                'monto_letras' => $comprobante->limpiarCadena($_POST['monto_letras']),
                'tipo_pago' => $comprobante->limpiarCadena($_POST['tipo_pago']),
                'cuotas' => json_decode($_POST['cuotas'], true),
                'tieneigv' => $comprobante->limpiarCadena($_POST['tieneigv']),
                //'totalMontoCuotas' => $comprobante->limpiarCadena($_POST['totalMontoCuotas']),
            ];

            $rpt = generarFactura($data);
            echo json_encode($rpt);
            break;
    }
}
