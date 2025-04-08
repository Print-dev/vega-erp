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
    ->setMtoOperGratuitas(200.00)
    ->setMtoIGVGratuitas(36.00)
    ->setTotalImpuestos(0.00)
    ->setValorVenta(0.00)
    ->setSubTotal(0.00)
    ->setMtoImpVenta(0.00);

// Producto gratuito
$item = (new SaleDetail())
    ->setCodProducto('P001')
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

// Leyenda requerida
$legend = (new Legend())
    ->setCode('1002')
    ->setValue('TRANSFERENCIA GRATUITA DE UN BIEN Y/O SERVICIO PRESTADO GRATUITAMENTE');

$invoice->setDetails([$item])
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
