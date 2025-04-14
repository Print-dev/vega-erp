<?php

require __DIR__ . '/vendor/autoload.php';

use Greenter\Model\Client\Client;
use Greenter\Model\Company\Company;
use Greenter\Model\Company\Address;
use Greenter\Model\Sale\FormaPagos\FormaPagoContado;
use Greenter\Model\Sale\Invoice;
use Greenter\Model\Sale\Legend;
use Greenter\Model\Sale\SaleDetail;

$see = require __DIR__ . '/config.php';


$client = (new Client())
    ->setTipoDoc('6')
    ->setNumDoc('10727547521')
    ->setRznSocial('AVALOS ROMERO ROYER ALEXIS');

$address = (new Address());
$address->setUbigueo('150101')
    ->setDepartamento('LIMA')
    ->setProvincia('LIMA')
    ->setDistrito('LIMA')
    ->setUrbanizacion('-')
    ->setDireccion('AV LOS GERUNDIOS');

$company = new Company();
$company->setRuc('20000000001')
    ->setRazonSocial('EMPRESA SAC')
    ->setNombreComercial('EMPRESA')
    ->setAddress($address);

$invoice = new Invoice();
$invoice->setFecVencimiento(new \DateTime())
    ->setUblVersion('2.1')
    ->setTipoOperacion('0101')
    ->setTipoDoc('01')
    ->setSerie('F001')
    ->setCorrelativo('123')
    ->setFechaEmision(new \DateTime())
    ->setFormaPago(new FormaPagoContado())
    ->setTipoMoneda('PEN')
    ->setClient($client)
    ->setCompany($company)
    ->setMtoOperExoneradas(200)
    ->setMtoIGV(0)
    ->setTotalImpuestos(0)
    ->setValorVenta(200)
    ->setSubTotal(200)
    ->setMtoImpVenta(200);

$detail = new SaleDetail();
$detail->setCodProducto('P001')
    ->setUnidad('NIU')
    ->setDescripcion('PROD 1')
    ->setCantidad(2)
    ->setMtoValorUnitario(100)
    ->setMtoValorVenta(200)
    ->setMtoBaseIgv(200)
    ->setPorcentajeIgv(18)
    ->setIgv(0)
    ->setTipAfeIgv('20')
    ->setTotalImpuestos(0)
    ->setMtoPrecioUnitario(100)
;

/* 
echo "<pre>";
var_export($detail);
echo "</pre>";
 */

$invoice->setDetails([$detail])
    ->setLegends([
        (new Legend())
            ->setCode('1000')
            ->setValue('SON DOSCIENTOS CON OO/100 SOLES')
    ]);

$result = $see->send($invoice);
file_put_contents($invoice->getName() . '.xml', $see->getFactory()->getLastXml());

if (!$result->isSuccess()) {
    echo 'Codigo Error: ' . $result->getError()->getCode() . PHP_EOL;
    echo 'Mensaje Error: ' . $result->getError()->getMessage() . PHP_EOL;
    exit();
}

// Guardar CDR
file_put_contents('R-' . $invoice->getName() . '.zip', $result->getCdrZip());

$cdr = $result->getCdrResponse();

echo 'ESTADO: ' . ($cdr->isAccepted() ? 'ACEPTADA' : 'RECHAZADA') . PHP_EOL;
echo $cdr->getDescription() . PHP_EOL;

if (count($cdr->getNotes()) > 0) {
    echo 'OBSERVACIONES:' . PHP_EOL;
    var_dump($cdr->getNotes());
}
