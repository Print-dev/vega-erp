<?php
require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '../../../../models/DetalleEvento.php';
require_once __DIR__ . '../../../../models/Tarifario.php';

use Dompdf\Dompdf;
use Dompdf\Options;

$options = new Options();
$options->set('isRemoteEnabled', true);
$options->set('defaultFont', 'Arial');
$options->set('isHtml5ParserEnabled', true);

$dompdf = new Dompdf($options);

// Capturar HTML desde otro archivo
ob_start();

$detalleevento = new DetalleEvento();
$tarifario = new Tarifario();


//PROCESAR LLEGADA DE DATOS
$iddetallepresentacion = isset($_GET['iddetallepresentacion']) && $_GET['iddetallepresentacion'] !== "" ? $detalleevento->limpiarCadena($_GET['iddetallepresentacion']) : null;
$idprovincia = isset($_GET['idprovincia']) && $_GET['idprovincia'] !== "" ? $detalleevento->limpiarCadena($_GET['idprovincia']) : null;
$idusuario = isset($_GET['idusuario']) && $_GET['idusuario'] !== "" ? $detalleevento->limpiarCadena($_GET['idusuario']) : null;
$provincia = isset($_GET['provincia']) && $_GET['provincia'] !== "" ? $detalleevento->limpiarCadena($_GET['provincia']) : null;
$precio = isset($_GET['precio']) && $_GET['precio'] !== "" ? $detalleevento->limpiarCadena($_GET['precio']) : null;

//EJECUTAR FUNCION
$cotizacion = $detalleevento->obtenerCotizacion(['iddetallepresentacion' => $iddetallepresentacion]);
$tarifaArtista = $tarifario->obtenerTarifaArtistaPorProvincia(['idprovincia' => $idprovincia, 'idusuario' => $idusuario]);
$igv = ($tarifaArtista[0]['precio'] + $precio) * 0.18;

//die(var_dump($cotizacion[0]['igv']));

require_once __DIR__ . '/../../estructura_pdf/cotizacion/contenido.php';
$html = ob_get_clean();

$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("cotizacion.pdf", ["Attachment" => false]);
