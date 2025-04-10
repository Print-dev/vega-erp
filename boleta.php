<?php

use Greenter\Model\Client\Client;
use Greenter\Model\Company\Company;
use Greenter\Model\Company\Address;
use Greenter\Model\Sale\Invoice;
use Greenter\Model\Sale\SaleDetail;
use Greenter\Model\Sale\Legend;

require __DIR__ . '/vendor/autoload.php';

$see = require __DIR__ . '/config.php';

// Cliente
$client = new Client();
$client->setTipoDoc('1')
    ->setNumDoc('46712369')
    ->setRznSocial('MARIA RAMOS ARTEAGA');

// Emisor
$address = new Address();
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

// Venta
$invoice = (new Invoice())
    ->setUblVersion('2.1')
    ->setTipoOperacion('0101') // Catalog. 51
    ->setTipoDoc('03')
    ->setSerie('B001')
    ->setCorrelativo('1')
    ->setFechaEmision(new DateTime())
    ->setTipoMoneda('PEN')
    ->setClient($client)
    ->setMtoOperGravadas(100.00)
    ->setMtoIGV(18.00)
    ->setTotalImpuestos(18.00)
    ->setValorVenta(100.00)
    ->setSubTotal(118.00)
    ->setMtoImpVenta(118.00)
    ->setCompany($company);

$item = (new SaleDetail())
    ->setCodProducto('P001')
    ->setUnidad('NIU')
    ->setCantidad(2)
    ->setDescripcion('PRODUCTO 1')
    ->setMtoBaseIgv(100)
    ->setPorcentajeIgv(18.00) // 18%
    ->setIgv(18.00)
    ->setTipAfeIgv('10')
    ->setTotalImpuestos(18.00)
    ->setMtoValorVenta(100.00)
    ->setMtoValorUnitario(50.00)
    ->setMtoPrecioUnitario(59.00);

$legend = (new Legend())
    ->setCode('1000')
    ->setValue('SON CIENTO DIECIOCHO CON 00/100 SOLES');

$invoice->setDetails([$item])
    ->setLegends([$legend]);

$xml = $see->getXmlSigned($invoice);

// Guardar XML
file_put_contents($invoice->getName() . '.xml', $xml);

// Enviar boleta a SUNAT (esto es lo que te falta)
$result = $see->send($invoice);

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
