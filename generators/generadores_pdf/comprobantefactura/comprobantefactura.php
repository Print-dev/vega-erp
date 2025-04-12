<?php
require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ .'../../../../models/Comprobante.php';
require_once __DIR__ .'../../../../models/Empresa.php';

use Dompdf\Dompdf;
use Dompdf\Options;
use Symfony\Component\Intl\Currencies;


$options = new Options();
$options->set('isRemoteEnabled', true);
$options->set('defaultFont', 'Arial');
$options->set('isHtml5ParserEnabled', true);

$dompdf = new Dompdf($options);

// Capturar HTML desde otro archivo
ob_start();

$comprobante = new Comprobante();
$empresa = new Empresa();

//$tarifario = new Tarifario();


//PROCESAR LLEGADA DE DATOS
$idcomprobante = isset($_GET['idcomprobante']) && $_GET['idcomprobante'] !== "" ? $comprobante->limpiarCadena($_GET['idcomprobante']) : null;
$idtipodoc = isset($_GET['idtipodoc']) && $_GET['idtipodoc'] !== "" ? $comprobante->limpiarCadena($_GET['idtipodoc']) : null;

$infocomprobante = $comprobante->obtenerComprobantePorTipoDoc(['idcomprobante' => $idcomprobante, 'idtipodoc' => $idtipodoc]);
$cuotasComprobante = $comprobante->obtenerCuotasFacturaPorIdComprobante(['idcomprobante' => $idcomprobante]);
//die(print_r($cuotasComprobante));
$infoEmpresa = $empresa->obtenerDatosEmpresa();
$itemsComprobante = $comprobante->obtenerItemsPorIdComprobante(['idcomprobante' => $idcomprobante]);

$codigoMoneda = $infocomprobante[0]['tipomoneda'];
/* if (!class_exists(\Symfony\Component\Intl\Currencies::class)) {
    die('La clase Currencies no está disponible. ¿Seguro que el autoload fue cargado?');
} */
$nombreMoneda = \Symfony\Component\Intl\Currencies::getName($codigoMoneda, 'es');

//$igv = ($tarifaArtista[0]['precio'] + $precio) * 0.18;

//die(var_dump($cotizacion[0]['igv']));

require_once __DIR__ . '/../../estructura_pdf/comprobantefactura/contenido.php';
$html = ob_get_clean();

$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("cotizacion.pdf", ["Attachment" => false]);