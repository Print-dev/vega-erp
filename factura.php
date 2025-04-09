<?php

require __DIR__ . '/vendor/autoload.php';

use Greenter\Model\Client\Client;
use Greenter\Model\Company\Company;
use Greenter\Model\Company\Address;
use Greenter\Model\Sale\FormaPagos\FormaPagoContado;
use Greenter\Model\Sale\Invoice;
use Greenter\Model\Sale\SaleDetail;
use Greenter\Model\Sale\Legend;


$see = require __DIR__ . '/config.php';

// Cliente
$client = (new Client())
    ->setTipoDoc('6') // RUC
    ->setNumDoc('10727547521')
    ->setRznSocial('AVALOS ROMERO ROYER ALEXIS');


// Dirección del emisor
$address = (new Address())
    ->setUbigueo('150135')
    ->setDepartamento('LIMA')
    ->setProvincia('LIMA')
    ->setDistrito('SAN MARTIN DE PORRES')
    ->setUrbanizacion('-')
    ->setDireccion('Av. Alfredo Mendiola N° 2139')
    ->setCodLocal('0000');


// Emisor (empresa)
$company = (new Company())
    ->setRuc('20608627422')
    ->setRazonSocial('NEGOCIACIONES Y PRODUCCIONES VEGA S.A.C.')
    ->setNombreComercial('')
    ->setAddress($address);

// Venta
// Instancia principal del comprobante
$invoice = (new Invoice())
    ->setUblVersion('2.1')
    ->setTipoOperacion('0101') // Venta interna
    ->setTipoDoc('01') // Factura
    ->setSerie('F001')
    ->setCorrelativo('00000999')
    ->setFechaEmision(new DateTime('now', new DateTimeZone('America/Lima')))
    ->setFormaPago(new FormaPagoContado())
    ->setTipoMoneda('PEN')
    ->setCompany($company)
    ->setClient($client)
    ->setMtoOperGravadas(75.00)  // 50 + 25
    ->setMtoIGV(13.50)           // 9 + 4.5
    ->setTotalImpuestos(13.50)
    ->setValorVenta(75.00)
    ->setSubTotal(88.50)         // Con IGV
    ->setMtoImpVenta(88.50);     // Importe total


$item1 = (new SaleDetail())
    ->setCodProducto('P001')
    ->setUnidad('NIU')
    ->setCantidad(1)
    ->setDescripcion('PRODUCTO GRAVADO 1')
    ->setMtoValorUnitario(50.00)   // sin IGV
    ->setIgv(9.00)
    ->setTipAfeIgv('10')
    ->setTotalImpuestos(9.00)
    ->setMtoPrecioUnitario(59.00)  // con IGV
    ->setMtoValorVenta(50.00)
    ->setMtoBaseIgv(50.00);

$item2 = (new SaleDetail())
    ->setCodProducto('P002')
    ->setUnidad('NIU')
    ->setCantidad(1)
    ->setDescripcion('PRODUCTO GRAVADO 2')
    ->setMtoValorUnitario(25.00)
    ->setIgv(4.50)
    ->setTipAfeIgv('10')
    ->setTotalImpuestos(4.50)
    ->setMtoPrecioUnitario(29.50)
    ->setMtoValorVenta(25.00)
    ->setMtoBaseIgv(25.00);

$invoice->setDetails([$item]);

// Leyenda del monto en letras (opcional)
$invoice->setLegends([
    (new Legend())
        ->setCode('1000')
        ->setValue('SON UN SOL CON 00/100 SOLES')
]);

// Enviar a SUNAT
$result = $see->send($invoice);

// Guardar XML
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
