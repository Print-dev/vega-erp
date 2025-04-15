<?php

require __DIR__ . '/vendor/autoload.php';

use Greenter\Model\Client\Client;
use Greenter\Model\Company\Company;
use Greenter\Model\Company\Address;
use Greenter\Model\Sale\Invoice;
use Greenter\Model\Sale\SaleDetail;
use Greenter\Model\Sale\Legend;

function generarBoleta($data)
{

    $directorioDestinoXML = __DIR__ . '/sunat/cpe/xml/';
    $directorioDestinoCDR = __DIR__ . '/sunat/cpe/cdr/';

    $see = require __DIR__ . '/config.php';

    // Cliente
    $client = (new Client())
        ->setTipoDoc('6')
        ->setNumDoc($data['ndocumento'])
        ->setRznSocial($data['razon_social_cliente']);

    $address = (new Address())
        ->setUbigueo($data['ubigeo'])
        ->setDepartamento($data['departamento'])
        ->setProvincia($data['provincia'])
        ->setDistrito($data['distrito'])
        ->setDireccion($data['direccion_emisor']);

    $company = (new Company())
        ->setRuc($data['ruc_emisor'])
        ->setRazonSocial($data['razon_social_emisor'])
        ->setAddress($address);

    // Venta
    $invoice = (new Invoice())
        ->setUblVersion('2.1')
        ->setTipoOperacion('0101') // Catalog. 51
        ->setTipoDoc('03')
        ->setSerie($data['serie'])
        ->setCorrelativo($data['correlativo'])
        ->setFechaEmision(new DateTime('now', new DateTimeZone('America/Lima')))
        ->setTipoMoneda($data['moneda'])
        ->setCompany($company)
        ->setClient($client)
        ->setMtoOperGravadas($data['monto_gravado'])
        ->setMtoIGV(0)
        ->setTotalImpuestos(0)
        ->setValorVenta($data['monto_gravado'])
        ->setSubTotal($data['total'])
        ->setMtoImpVenta($data['total']);

    $items = [];

    foreach ($data['detalle'] as $item) {
        $valorUnitario = (float)$item['valorunitario']; // Valor sin IGV
        //$igvItem = (float)$item['igvproducto']; // Usar el IGV que viene en el request
        //$precioUnitario = (float)$item['preciounitario']; // Usar el precio que viene en el request

        $item = (new SaleDetail())
            ->setUnidad('NIU')
            ->setCantidad(1)
            ->setDescripcion($item['descripcion'])
            ->setMtoBaseIgv($valorUnitario)
            ->setPorcentajeIgv(18) // 18%
            ->setIgv(0)
            ->setTipAfeIgv('20') // EXONERADO
            ->setTotalImpuestos(0)
            ->setMtoValorVenta($valorUnitario)
            ->setMtoValorUnitario($valorUnitario)
            ->setMtoPrecioUnitario($valorUnitario);
        $items[] = $detalle;
    }

    $invoice->setDetails($items);
    $invoice->setLegends([
        (new Legend())
            ->setCode('1000')
            ->setValue('SON ' . strtoupper($_POST['monto_letras']))
    ]);

    $result = $see->send($invoice);

    // Guardar XML
    file_put_contents($directorioDestinoXML . $invoice->getName() . '.xml', $see->getFactory()->getLastXml());

    // Enviar boleta a SUNAT (esto es lo que te falta)
    $result = $see->send($invoice);

    if (!$result->isSuccess()) {
        return [
            'success' => false,
            'error' => $result->getError()->getMessage(),
        ];
    }


    // Guardar CDR
    file_put_contents($directorioDestinoCDR . 'R-' . $invoice->getName() . '.zip', $result->getCdrZip());

    $cdr = $result->getCdrResponse();
    return [
        'success' => true,
        'estado' => $cdr->isAccepted() ? 'ACEPTADA' : 'RECHAZADA',
        'descripcion' => $cdr->getDescription(),
        'observaciones' => $cdr->getNotes(),
    ];
}
