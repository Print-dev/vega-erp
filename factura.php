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
    ->setMtoOperGravadas(0.85) // Monto base sin IGV
    ->setMtoIGV(0.15) // IGV 18%
    ->setTotalImpuestos(0.15)
    ->setValorVenta(0.85)
    ->setSubTotal(1.00)
    ->setMtoImpVenta(1.00);

$item = (new SaleDetail())
    ->setCodProducto('P001')
    ->setUnidad('NIU')
    ->setCantidad(1)
    ->setDescripcion('Producto de prueba')
    ->setMtoValorUnitario(0.85) // Precio sin IGV
    ->setMtoBaseIgv(0.85)
    ->setPorcentajeIgv(18.00)
    ->setIgv(0.15)
    ->setTipAfeIgv('10') // Gravado - Oneroso
    ->setTotalImpuestos(0.15)
    ->setMtoValorVenta(0.85)
    ->setMtoPrecioUnitario(1.00); // Precio con IGV

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
