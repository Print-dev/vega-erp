<?php
require_once __DIR__ . '/../../vendor/autoload.php';
//require_once __DIR__ . '../../../../models/DetalleEvento.php';
require_once __DIR__ . '../../../../models/Tarifario.php';
//require_once __DIR__ .'../../../../models/Convenio.php';
require_once __DIR__ . '../../../../models/Contrato.php';
require_once __DIR__ .'../../../../models/Sucursal.php';


use Dompdf\Dompdf;
use Dompdf\Options;

$options = new Options();
$options->set('isRemoteEnabled', true);
$options->set('defaultFont', 'Arial');
$options->set('isHtml5ParserEnabled', true);


$dompdf = new Dompdf($options);

// Capturar HTML desde otro archivo
ob_start();

//$convenio = new Convenio();
$tarifario = new Tarifario();
$contrato = new Contrato();
$sucursal = new Sucursal();


//PROCESAR LLEGADA DE DATOS
$idcontrato = isset($_GET['idcontrato']) && $_GET['idcontrato'] !== "" ? $contrato->limpiarCadena($_GET['idcontrato']) : null;
/* $iddetallepresentacion = isset($_GET['iddetallepresentacion']) && $_GET['iddetallepresentacion'] !== "" ? $detalleevento->limpiarCadena($_GET['iddetallepresentacion']) : null;
$idprovincia = isset($_GET['idprovincia']) && $_GET['idprovincia'] !== "" ? $detalleevento->limpiarCadena($_GET['idprovincia']) : null;
$idusuario = isset($_GET['idusuario']) && $_GET['idusuario'] !== "" ? $detalleevento->limpiarCadena($_GET['idusuario']) : null;
$provincia = isset($_GET['provincia']) && $_GET['provincia'] !== "" ? $detalleevento->limpiarCadena($_GET['provincia']) : null;
$precio = isset($_GET['precio']) && $_GET['precio'] !== "" ? $detalleevento->limpiarCadena($_GET['precio']) : null; */

$idusuario = isset($_GET['idusuario']) && $_GET['idusuario'] !== "" ? $contrato->limpiarCadena($_GET['idusuario']) : null;
$idprovincia = isset($_GET['idprovincia']) && $_GET['idprovincia'] !== "" ? $contrato->limpiarCadena($_GET['idprovincia']) : null;
$precio = isset($_GET['precio']) && $_GET['precio'] !== "" ? $contrato->limpiarCadena($_GET['precio']) : null;

//EJECUTAR FUNCION
$contratoPresentacion = $contrato->obtenerContrato(['idcontrato' => $idcontrato]);
$tarifaArtista = $tarifario->obtenerTarifaArtistaPorProvincia(['idprovincia' => $idprovincia, 'idusuario' => $idusuario]);
$igv = ($tarifaArtista[0]['precio'] + $precio) * 0.18;
$representante = $sucursal->obtenerRepresentanteEmpresa(['idsucursal' => $sucursal->limpiarCadena($_GET['idsucursal'])]); // OBTENER EL REPRESENTANTES DESDE LA TABLA SUCURSALES

/* $cotizacion = $detalleevento->obtenerCotizacion(['iddetallepresentacion' => $iddetallepresentacion]);
$tarifaArtista = $tarifario->obtenerTarifaArtistaPorProvincia(['idprovincia' => $idprovincia, 'idusuario' => $idusuario]);
$igv = ($tarifaArtista[0]['precio'] + $precio) * 0.18; */

//die(var_dump($tarifaArtista[0]));

//die(var_dump($contratoPresentacion[0]));

require_once __DIR__ . '/../../estructura_pdf/contrato_presentacion/contenido.php';
$html = ob_get_clean();

$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("cotizacion.pdf", ["Attachment" => false]);
