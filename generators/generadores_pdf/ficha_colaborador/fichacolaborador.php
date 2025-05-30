<?php
require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '../../../../models/Colaborador.php';
require_once __DIR__ . '../../../../models/Tarifario.php';
require_once __DIR__ . '../../../../models/Sucursal.php';
require_once __DIR__ . '../../../../models/Empresa.php';


use Dompdf\Dompdf;
use Dompdf\Options;

$options = new Options();
$options->set('isRemoteEnabled', true);
$options->set('defaultFont', 'Arial');
$options->set('isHtml5ParserEnabled', true);

$dompdf = new Dompdf($options);

// Capturar HTML desde otro archivo
ob_start();

$colaborador = new Colaborador();
$empresa = new Empresa();
/* $tarifario = new Tarifario();
$sucursal = new Sucursal();
$empresa = new Empresa(); */

//PROCESAR LLEGADA DE DATOS4
$idnomina = isset($_GET['idnomina']) && $_GET['idnomina'] !== "" ? $colaborador->limpiarCadena($_GET['idnomina']) : null;

/* $iddetallepresentacion = isset($_GET['iddetallepresentacion']) && $_GET['iddetallepresentacion'] !== "" ? $detalleevento->limpiarCadena($_GET['iddetallepresentacion']) : null;
$idprovincia = isset($_GET['idprovincia']) && $_GET['idprovincia'] !== "" ? $detalleevento->limpiarCadena($_GET['idprovincia']) : null;
$idusuario = isset($_GET['idusuario']) && $_GET['idusuario'] !== "" ? $detalleevento->limpiarCadena($_GET['idusuario']) : null;
$provincia = isset($_GET['provincia']) && $_GET['provincia'] !== "" ? $detalleevento->limpiarCadena($_GET['provincia']) : null;
$tipoevento = isset($_GET['tipoevento']) && $_GET['tipoevento'] !== "" ? $detalleevento->limpiarCadena($_GET['tipoevento']) : null;
$idnacionalidad = isset($_GET['idnacionalidad']) && $_GET['idnacionalidad'] !== "" ? $detalleevento->limpiarCadena($_GET['idnacionalidad']) : null;
$precio = isset($_GET['precio']) && $_GET['precio'] !== "" ? $detalleevento->limpiarCadena($_GET['precio']) : null;  */

//EJECUTAR FUNCION
$fichaColaborador = $colaborador->obtenerFichaColaborador(['idnomina' => $idnomina]);

//die(print_r($fichaColaborador));

/* if ($cotizacion[0]['esExtranjero'] == 1) {
    $tarifaArtista = $tarifario->obtenerTarifaArtistaPorPais(['idusuario' => $idusuario, 'idnacionalidad' => $idnacionalidad, 'tipoevento' => $tipoevento]);
    //die(print_r($tarifaArtista));
    $igv = ($tarifaArtista[0]['precio'] + $tarifaArtista[0]['precioExtranjero']) * 0.18;
} else {
    $tarifaArtista = $tarifario->obtenerTarifaArtistaPorProvincia(['idprovincia' => $idprovincia, 'idusuario' => $idusuario, 'tipoevento' => $tipoevento]);
    $igv = ($tarifaArtista[0]['precio'] + $precio) * 0.18;
} */

//$igv = ($tarifaArtista[0]['precio'] + $precio) + $igv_total;
$infoEmpresa = $empresa->obtenerDatosEmpresa();

//die(print_r($igv));


//die(var_dump($cotizacion[0]['igv']));

require_once __DIR__ . '/../../estructura_pdf/ficha_colaborador/contenido.php';
$html = ob_get_clean();

$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("cotizacion.pdf", ["Attachment" => false]);
