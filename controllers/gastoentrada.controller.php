<?php

require '../vendor/autoload.php';

use Cloudinary\Cloudinary;
use Cloudinary\Configuration\Configuration;

require_once '../models/Gastos.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$gastos = new Gastos();


if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {

        /* case 'obtenerAreas':
            echo json_encode($nomina->obtenerAreas());
            break;

        case 'obtenerPersonaNumDocColaborador':
            $cleanData = [
                'numdoc'   => $nomina->limpiarCadena($_GET['numdoc']),
            ];
            echo json_encode($nomina->obtenerPersonaNumDocColaborador($cleanData));
            break;
            */
        case 'obtenerGastoEntradaPorId':
            $cleanData = [
                'idgastoentrada'   => $gastos->limpiarCadena($_GET['idgastoentrada']),
            ];
            echo json_encode($gastos->obtenerGastoEntradaPorId($cleanData));
            break;

        case 'filtrarGastos':
            $cleanData = [
                'idusuario' => empty($_GET['idusuario']) ? null : $gastos->limpiarCadena($_GET['idusuario']),
                'iddetallepresentacion' => empty($_GET['iddetallepresentacion']) ? null : $gastos->limpiarCadena($_GET['iddetallepresentacion']),
                'fechagasto' => empty($_GET['fechagasto']) ? null : $gastos->limpiarCadena($_GET['fechagasto']),
                'estado' => empty($_GET['estado']) ? null : $gastos->limpiarCadena($_GET['estado']),
            ];
            echo json_encode($gastos->filtrarGastos($cleanData));
            break;
    }
}


if (isset($_POST['operation'])) {
    switch ($_POST['operation']) {
        case 'eliminarGastoEntrada':
            $cleanData = [
                'idgastoentrada' => $gastos->limpiarCadena($_POST['idgastoentrada'])
            ];

            $rpt = $gastos->eliminarGastoEntrada($cleanData);

            echo json_encode($rpt);
            break;

        case 'registrarGastoEntrada':
            $cleanData = [
                'estadopago'      => $gastos->limpiarCadena($_POST['estadopago']) ? $gastos->limpiarCadena($_POST['estadopago']) : null,
                'fgasto'          => $gastos->limpiarCadena($_POST['fgasto']) ? $gastos->limpiarCadena($_POST['fgasto']) : null,
                'fvencimiento'    => $gastos->limpiarCadena($_POST['fvencimiento']) ? $gastos->limpiarCadena($_POST['fvencimiento']) : null,
                'tipo'            => $gastos->limpiarCadena($_POST['tipo']) ? $gastos->limpiarCadena($_POST['tipo']) : null,
                'concepto'        => $gastos->limpiarCadena($_POST['concepto']) ? $gastos->limpiarCadena($_POST['concepto']) : null,
                'subtipo'         => $gastos->limpiarCadena($_POST['subtipo']) ? $gastos->limpiarCadena($_POST['subtipo']) : null,
                'idproveedor'     => $gastos->limpiarCadena($_POST['idproveedor']) ? $gastos->limpiarCadena($_POST['idproveedor']) : null,
                'idcolaborador'   => $gastos->limpiarCadena($_POST['idcolaborador']) ? $gastos->limpiarCadena($_POST['idcolaborador']) : null,
                'gasto'           => $gastos->limpiarCadena($_POST['gasto']) ? $gastos->limpiarCadena($_POST['gasto']) : null,
                'cunitario'       => $gastos->limpiarCadena($_POST['cunitario']) ? $gastos->limpiarCadena($_POST['cunitario']) : null,
                'pagado'          => $gastos->limpiarCadena($_POST['pagado']) ? $gastos->limpiarCadena($_POST['pagado']) : null,
                'idproducto'      => $gastos->limpiarCadena($_POST['idproducto']) ? $gastos->limpiarCadena($_POST['idproducto']) : null,
                'cantidad'        => $gastos->limpiarCadena($_POST['cantidad']) ?  $gastos->limpiarCadena($_POST['cantidad']) : null,
                'unidades'        => $gastos->limpiarCadena($_POST['unidades']) ? $gastos->limpiarCadena($_POST['unidades']) : null,
                'formapago'       => $gastos->limpiarCadena($_POST['formapago']) ? $gastos->limpiarCadena($_POST['formapago']) : null,
                'cuenta'          => $gastos->limpiarCadena($_POST['cuenta']) ? $gastos->limpiarCadena($_POST['cuenta']) : null,
                'foliofactura'    => $gastos->limpiarCadena($_POST['foliofactura']) ? $gastos->limpiarCadena($_POST['foliofactura']) : null,
                'emision'         => $gastos->limpiarCadena($_POST['emision']) ? $gastos->limpiarCadena($_POST['emision']) : null,
                'descripcion'     => $gastos->limpiarCadena($_POST['descripcion']) ? $gastos->limpiarCadena($_POST['descripcion']) : null,
                'costofinal'      => $gastos->limpiarCadena($_POST['costofinal']) ? $gastos->limpiarCadena($_POST['costofinal']) : null,
                'egreso'          => $gastos->limpiarCadena($_POST['egreso']) ? $gastos->limpiarCadena($_POST['egreso']) : null,
                'montopdte'       => $gastos->limpiarCadena($_POST['montopdte']) ? $gastos->limpiarCadena($_POST['montopdte']) : null,
                'impuestos'       => $gastos->limpiarCadena($_POST['impuestos']) ? $gastos->limpiarCadena($_POST['impuestos']) : null,
                'costofinalunit'  => $gastos->limpiarCadena($_POST['costofinalunit']) ? $gastos->limpiarCadena($_POST['costofinalunit']) : null,
            ];

            $respuesta = ['idgastoentrada' => -1];

            $idgastoentrada = $gastos->registrarGastoEntrada($cleanData);

            if ($idgastoentrada > 0) {
                $respuesta['idgastoentrada'] = $idgastoentrada;
            }

            echo json_encode($respuesta);
            break;

        case 'registrarGastoYEntrada':
            $cloudinary = new Cloudinary([
                'cloud' => [
                    'cloud_name' => 'dynpy0r4v',
                    'api_key'    => '722279687758731',
                    'api_secret' => 'KsLk7dNUAAjRYEBNUsv2JAV7cPI'
                ],
                'url' => [
                    'secure' => true
                ]
            ]);

            // Variables por defecto
            $secureUrlComprobanteUrl = $_POST['publicIdComprobanteAnterior'] ?? '';
            $secureUrlComprobanteFacBol = $_POST['publicIdFacBolAnterior'] ?? '';

            // Subir marca de agua si existe
            if (isset($_FILES['comprobanteurl']) && $_FILES['comprobanteurl']['error'] === UPLOAD_ERR_OK) {
                $uploadResultComprobanteUrl = $cloudinary->uploadApi()->upload(
                    $_FILES['comprobanteurl']['tmp_name'],
                    ['folder' => 'comprobantes_vegaproducciones']
                );
                $secureUrlComprobanteUrl = $uploadResultComprobanteUrl['public_id'] ?? '';
            }

            // Subir firma si existe
            if (isset($_FILES['comprobantefacbol']) && $_FILES['comprobantefacbol']['error'] === UPLOAD_ERR_OK) {
                $uploadResultComprobanteFacBol = $cloudinary->uploadApi()->upload(
                    $_FILES['comprobantefacbol']['tmp_name'],
                    ['folder' => 'comprobantes_vegaproducciones']
                );
                $secureUrlComprobanteFacBol = $uploadResultComprobanteFacBol['public_id'] ?? '';
            }

            $cleanData = [
                'estado'      => $gastos->limpiarCadena($_POST['estado']) ? $gastos->limpiarCadena($_POST['estado']) : null,
                'concepto'      => $gastos->limpiarCadena($_POST['concepto']) ? $gastos->limpiarCadena($_POST['concepto']) : null,
                'fechagasto'          => $gastos->limpiarCadena($_POST['fechagasto']) ? $gastos->limpiarCadena($_POST['fechagasto']) : null,
                'monto'    => $gastos->limpiarCadena($_POST['monto']) ? $gastos->limpiarCadena($_POST['monto']) : null,
                'iddetallepresentacion'        => $gastos->limpiarCadena($_POST['iddetallepresentacion']) ? $gastos->limpiarCadena($_POST['iddetallepresentacion']) : null,
                'idusuario'         => $gastos->limpiarCadena($_POST['idusuario']) ? $gastos->limpiarCadena($_POST['idusuario']) : null,
                'mediopago'     => $gastos->limpiarCadena($_POST['mediopago']) ? $gastos->limpiarCadena($_POST['mediopago']) : null,
                'detalles'   => $gastos->limpiarCadena($_POST['detalles']) ? $gastos->limpiarCadena($_POST['detalles']) : null,
                'comprobanteurl'           => $secureUrlComprobanteUrl,
                'comprobantefacbol'       => $secureUrlComprobanteFacBol
            ];

            $respuesta = ['idgastoentrada' => -1];

            $idgastoentrada = $gastos->registrarGastoYEntrada($cleanData);

            if ($idgastoentrada > 0) {
                $respuesta['idgastoentrada'] = $idgastoentrada;
            }

            echo json_encode($respuesta);
            break;



        case 'pagarGastoEntrada':
            $cloudinary = new Cloudinary([
                'cloud' => [
                    'cloud_name' => 'dynpy0r4v',
                    'api_key'    => '722279687758731',
                    'api_secret' => 'KsLk7dNUAAjRYEBNUsv2JAV7cPI'
                ],
                'url' => ['secure' => true]
            ]);

            // PUBLIC_ID actuales
            $comprobanteurlActual = $_POST['publicIdComprobanteURLanterior'] ?? '';
            $comprobanteFacBolActual = $_POST['publicIdComprobanteFacBolanterior'] ?? '';

            $secureUrlComprobanteURL = $comprobanteurlActual;
            $secureUrlComprobanteFacBol = $comprobanteFacBolActual;

            // Si se sube nueva marca de agua
            if (isset($_FILES['comprobanteurl']) && $_FILES['comprobanteurl']['error'] === UPLOAD_ERR_OK) {
                if (!empty($comprobanteurlActual)) {
                    $cloudinary->uploadApi()->destroy($comprobanteurlActual);
                }
                $uploadResultComprobanteURL = $cloudinary->uploadApi()->upload(
                    $_FILES['comprobanteurl']['tmp_name'],
                    ['folder' => 'comprobantes_vegaproducciones']
                );
                $secureUrlComprobanteURL = $uploadResultComprobanteURL['public_id'] ?? '';
            }

            // Si se sube nueva firma
            if (isset($_FILES['comprobantefacbol']) && $_FILES['comprobantefacbol']['error'] === UPLOAD_ERR_OK) {
                if (!empty($comprobanteFacBolActual)) {
                    $cloudinary->uploadApi()->destroy($comprobanteFacBolActual);
                }
                $uploadResultComprobanteFacBol = $cloudinary->uploadApi()->upload(
                    $_FILES['comprobantefacbol']['tmp_name'],
                    ['folder' => 'comprobantes_vegaproducciones']
                );
                $secureUrlComprobanteFacBol = $uploadResultComprobanteFacBol['public_id'] ?? '';
            }

            $cleanData = [
                'idgastoentrada'   => $gastos->limpiarCadena($_POST['idgastoentrada']) ? $gastos->limpiarCadena($_POST['idgastoentrada']) : '',
                'estado'   => $gastos->limpiarCadena($_POST['estado']) ? $gastos->limpiarCadena($_POST['estado']) : '',
                'mediopago' => $gastos->limpiarCadena($_POST['mediopago']) ? $gastos->limpiarCadena($_POST['mediopago']) : '',
                'detalles'   => $gastos->limpiarCadena($_POST['detalles']) ? $gastos->limpiarCadena($_POST['detalles']) : '',
                'comprobanteurl' => $secureUrlComprobanteURL,
                'comprobantefacbol' => $secureUrlComprobanteFacBol,
            ];

            $rpt = $gastos->pagarGastoEntrada($cleanData);

            echo json_encode($rpt);
            break;

        case 'actualizarGastoEntrada':
            $cloudinary = new Cloudinary([
                'cloud' => [
                    'cloud_name' => 'dynpy0r4v',
                    'api_key'    => '722279687758731',
                    'api_secret' => 'KsLk7dNUAAjRYEBNUsv2JAV7cPI'
                ],
                'url' => ['secure' => true]
            ]);

            // PUBLIC_ID actuales
            $comprobanteurlActual = $_POST['publicIdComprobanteAnterior'] ?? '';
            $comprobanteFacBolActual = $_POST['publicIdFacBolAnterior'] ?? '';

            $secureUrlComprobanteURL = $comprobanteurlActual;
            $secureUrlComprobanteFacBol = $comprobanteFacBolActual;

            // Si se sube nueva marca de agua
            if (isset($_FILES['comprobanteurl']) && $_FILES['comprobanteurl']['error'] === UPLOAD_ERR_OK) {
                if (!empty($comprobanteurlActual)) {
                    $cloudinary->uploadApi()->destroy($comprobanteurlActual);
                }
                $uploadResultComprobanteURL = $cloudinary->uploadApi()->upload(
                    $_FILES['comprobanteurl']['tmp_name'],
                    ['folder' => 'comprobantes_vegaproducciones']
                );
                $secureUrlComprobanteURL = $uploadResultComprobanteURL['public_id'] ?? '';
            }

            // Si se sube nueva firma
            if (isset($_FILES['comprobantefacbol']) && $_FILES['comprobantefacbol']['error'] === UPLOAD_ERR_OK) {
                if (!empty($comprobanteFacBolActual)) {
                    $cloudinary->uploadApi()->destroy($comprobanteFacBolActual);
                }
                $uploadResultComprobanteFacBol = $cloudinary->uploadApi()->upload(
                    $_FILES['comprobantefacbol']['tmp_name'],
                    ['folder' => 'comprobantes_vegaproducciones']
                );
                $secureUrlComprobanteFacBol = $uploadResultComprobanteFacBol['public_id'] ?? '';
            }

            $cleanData = [
                'idgastoentrada'   => $gastos->limpiarCadena($_POST['idgastoentrada']) ? $gastos->limpiarCadena($_POST['idgastoentrada']) : '',
                'concepto'   => $gastos->limpiarCadena($_POST['concepto']) ? $gastos->limpiarCadena($_POST['concepto']) : '',
                'fechagasto' => $gastos->limpiarCadena($_POST['fechagasto']) ? $gastos->limpiarCadena($_POST['fechagasto']) : '',
                'monto'   => $gastos->limpiarCadena($_POST['monto']) ? $gastos->limpiarCadena($_POST['monto']) : '',
                'mediopago'   => $gastos->limpiarCadena($_POST['mediopago']) ? $gastos->limpiarCadena($_POST['mediopago']) : '',
                'detalles'   => $gastos->limpiarCadena($_POST['detalles']) ? $gastos->limpiarCadena($_POST['detalles']) : '',
                'comprobanteurl' => $secureUrlComprobanteURL,
                'comprobantefacbol' => $secureUrlComprobanteFacBol,
            ];

            $rpt = $gastos->actualizarGastoEntrada($cleanData);

            echo json_encode($rpt);
            break;
    }
}
