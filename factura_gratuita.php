<?php
require __DIR__ . '/vendor/autoload.php';

use Greenter\Model\Company\Company;
use Greenter\Model\Company\Address;
use Greenter\Model\Client\Client;
use Greenter\Model\Sale\Invoice;
use Greenter\Model\Sale\SaleDetail;
use Greenter\Model\Sale\FormaPagos\FormaPagoContado;
use Greenter\Model\Sale\Legend;

// Configuración
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
    ->setRazonSocial('NEGOCIACIONES Y PRODUCCIONES VEGA S.A.C')
    ->setNombreComercial('')
    ->setAddress($address);



// Producto gratuito
$item = (new SaleDetail())
    ->setUnidad('NIU')
    ->setCantidad(2)
    ->setDescripcion('PRODUCTO GRATUITO')
    ->setMtoValorUnitario(0.00)
    ->setMtoValorGratuito(100.00)
    ->setMtoValorVenta(200.00)
    ->setMtoBaseIgv(200.00)
    ->setPorcentajeIgv(18.00)
    ->setIgv(36.00)
    ->setTipAfeIgv('11') // Transferencia gratuita
    ->setTotalImpuestos(36.00)
    ->setMtoPrecioUnitario(0.00);


$item2 = (new SaleDetail())
    ->setUnidad('NIU')
    ->setCantidad(1)
    ->setDescripcion('PRODUCTO GRATUITO 2')
    ->setMtoValorUnitario(0.00)
    ->setMtoValorGratuito(50.00)
    ->setMtoValorVenta(50.00)
    ->setMtoBaseIgv(50.00)
    ->setPorcentajeIgv(18.00)
    ->setIgv(9.00)
    ->setTipAfeIgv('11')
    ->setTotalImpuestos(9.00)
    ->setMtoPrecioUnitario(0.00);

// Comprobante (Factura gratuita)
$invoice = (new Invoice())
    ->setUblVersion('2.1')
    ->setTipoOperacion('0101') // Venta interna
    ->setTipoDoc('01') // Factura
    ->setSerie('F001')
    ->setCorrelativo('00000124') // Puedes generar uno dinámico
    ->setFechaEmision(new DateTime())
    ->setFormaPago(new FormaPagoContado())
    ->setTipoMoneda('PEN')
    ->setClient($client)
    ->setCompany($company)
    ->setMtoOperGratuitas(250.00) // 200 + 50
    ->setMtoIGVGratuitas(45.00)   // 36 + 9
    ->setTotalImpuestos(0.00)
    ->setValorVenta(0.00)
    ->setSubTotal(0.00)
    ->setMtoImpVenta(0.00);

// Leyenda requerida
$legend = (new Legend())
    ->setCode('1002')
    ->setValue('TRANSFERENCIA GRATUITA DE UN BIEN Y/O SERVICIO PRESTADO GRATUITAMENTE');

$invoice->setDetails([$item, $item2])
    ->setLegends([$legend]);

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
