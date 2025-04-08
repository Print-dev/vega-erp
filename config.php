<?php
/* use Greenter\Ws\Services\SunatEndpoints;
use Greenter\See;

$see = new See();
$see->setCertificate(file_get_contents(__DIR__.'/certificado/certificado.pem'));
$see->setService(SunatEndpoints::FE_PRODUCCION);
$see->setClaveSOL('20608627422', 'ROYER777', 'Royeralexis1');

return $see;
 */

use Greenter\Ws\Services\SunatEndpoints;
use Greenter\See;

$see = new See();
$see->setCertificate(file_get_contents(__DIR__ . '/certificadodemo/certificadodemo.pem'));
$see->setService(SunatEndpoints::FE_BETA);
$see->setClaveSOL('20000000001', 'MODDATOS', 'moddatos');

return $see;
