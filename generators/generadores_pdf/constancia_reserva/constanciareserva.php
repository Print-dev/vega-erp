<?php
require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '../../../../models/DetalleEvento.php';
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

$detalleevento = new DetalleEvento();
$contrato = new Contrato();
$sucursal = new Sucursal();

//$tarifario = new Tarifario();


//PROCESAR LLEGADA DE DATOS
$iddetallepresentacion = isset($_GET['iddetallepresentacion']) && $_GET['iddetallepresentacion'] !== "" ? $detalleevento->limpiarCadena($_GET['iddetallepresentacion']) : null;
$idpagocontrato = isset($_GET['idpagocontrato']) && $_GET['idpagocontrato'] !== "" ? $detalleevento->limpiarCadena($_GET['idpagocontrato']) : null;
//$idprovincia = isset($_GET['idprovincia']) && $_GET['idprovincia'] !== "" ? $detalleevento->limpiarCadena($_GET['idprovincia']) : null;
//$idusuario = isset($_GET['idusuario']) && $_GET['idusuario'] !== "" ? $detalleevento->limpiarCadena($_GET['idusuario']) : null;
//$provincia = isset($_GET['provincia']) && $_GET['provincia'] !== "" ? $detalleevento->limpiarCadena($_GET['provincia']) : null;
//$precio = isset($_GET['precio']) && $_GET['precio'] !== "" ? $detalleevento->limpiarCadena($_GET['precio']) : null;

//EJECUTAR FUNCION
$cotizacion = $detalleevento->obtenerCotizacion(['iddetallepresentacion' => $iddetallepresentacion]);
$reserva = $contrato->obtenerReservaPorPagoContrato(['idpagocontrato' => $idpagocontrato]);
$representante = $sucursal->obtenerRepresentanteEmpresa(['idsucursal' => $sucursal->limpiarCadena($_GET['idsucursal'])]); // OBTENER EL REPRESENTANTES DESDE LA TABLA SUCURSALES

//$tarifaArtista = $tarifario->obtenerTarifaArtistaPorProvincia(['idprovincia' => $idprovincia, 'idusuario' => $idusuario]);
//$igv = ($tarifaArtista[0]['precio'] + $precio) * 0.18;

//die(var_dump($cotizacion[0]['igv']));

require_once __DIR__ . '/../../estructura_pdf/constancia_reserva/contenido.php';
$html = ob_get_clean();

$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("cotizacion.pdf", ["Attachment" => false]);
