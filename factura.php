<?php

require __DIR__ . '/vendor/autoload.php';

use Greenter\Model\Client\Client;
use Greenter\Model\Company\Company;
use Greenter\Model\Company\Address;
use Greenter\Model\Sale\FormaPagos\FormaPagoContado;
use Greenter\Model\Sale\FormaPagos\FormaPagoCredito;
use Greenter\Model\Sale\Cuota;
use Greenter\Model\Sale\Invoice;
use Greenter\Model\Sale\SaleDetail;
use Greenter\Model\Sale\Legend;



// Cliente
function generarFactura($data)
{
    $directorioDestinoXML = __DIR__ . '/sunat/cpe/xml/';
    $directorioDestinoCDR = __DIR__ . '/sunat/cpe/cdr/';

    $see = require __DIR__ . '/config.php';

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

    $invoice = (new Invoice())
        ->setUblVersion('2.1')
        ->setTipoOperacion('0101')
        ->setTipoDoc('01') // FACTURA
        ->setSerie($data['serie'])
        ->setCorrelativo($data['correlativo'])
        ->setFechaEmision(new DateTime('now', new DateTimeZone('America/Lima')))
        ->setFormaPago(new FormaPagoContado())
        ->setTipoMoneda($data['moneda'])
        ->setCompany($company)
        ->setClient($client)
        ->setMtoOperGravadas($data['monto_gravado']) //calculable desde javascript // total de monto gravado de cada producto sin incluir si igv (crudo)
        ->setMtoIGV($data['igv']) //calculable desde javascript // sumar cada igv de cada producto
        ->setTotalImpuestos($data['igv']) // lo mismo que el campo de arriba (Se repite)
        ->setValorVenta($data['monto_gravado']) // mismo valor que setMtoOperGravadas
        ->setSubTotal($data['total']) // suma de todos los igvs (de cada producto) + monto gravado total (en este caso de dos productos sin igv), calculadble desde javascirpt
        ->setMtoImpVenta($data['total']); // lo mismo que el campo de arriba

    $items = [];
    foreach ($data['detalle'] as $item) {
        $detalle = (new SaleDetail())
            ->setUnidad('NIU')
            ->setCantidad(1)
            ->setDescripcion($item['descripcion'])
            ->setMtoValorUnitario((float)$item['valorunitario']) // monto gravado sin igv (impuesto)
            ->setIgv((float)$item['igvproducto']) // el igv del producto gravado
            ->setTipAfeIgv('10')
            ->setTotalImpuestos((float)$item['igvproducto'])
            ->setMtoPrecioUnitario((float)$item['preciounitario']) // valor unitario + igv , //calculable desde javascript
            ->setMtoValorVenta((float)$item['valorunitario'])
            ->setMtoBaseIgv((float)$item['valorunitario'])
            ->setPorcentajeIgv(18.00) // 18%
        ;
        $items[] = $detalle;
    }

    if ($data['tipo_pago'] === '2') {
        $invoice->setFormaPago(new FormaPagoCredito($data['total'], $data['moneda'])); // Monto total del crédito

        $cuotas = [];
        foreach ($data['cuotas'] as $cuota) {
            $cuotas[] = (new Cuota())  
                ->setMonto((float)$cuota['monto'])
                ->setFechaPago(new DateTime($cuota['fecha']));
        }
        $invoice->setCuotas($cuotas);
    } else if ($data['tipo_pago'] == '1') {
        $invoice->setFormaPago(new FormaPagoContado());
    }

    $invoice->setDetails($items);
    $invoice->setLegends([
        (new Legend())
            ->setCode('1000')
            ->setValue('SON ' . strtoupper($_POST['monto_letras']))
    ]);

    $result = $see->send($invoice);
    file_put_contents($directorioDestinoXML . $invoice->getName() . '.xml', $see->getFactory()->getLastXml());

    if (!$result->isSuccess()) {
        return [
            'success' => false,
            'error' => $result->getError()->getMessage(),
        ];
    }

    file_put_contents($directorioDestinoCDR . 'R-' . $invoice->getName() . '.zip', $result->getCdrZip());

    $cdr = $result->getCdrResponse();
    return [
        'success' => true,
        'estado' => $cdr->isAccepted() ? 'ACEPTADA' : 'RECHAZADA',
        'descripcion' => $cdr->getDescription(),
        'observaciones' => $cdr->getNotes(),
    ];
}
