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
        ->setClient($client);

    // ✅ Condicional: Si tiene IGV, se configura como gravada
    // Configuración del invoice según si tiene IGV o no
    if ($data['tieneigv'] == 1) {
        $invoice->setMtoOperGravadas($data['monto_gravado']) // Base imponible
            ->setMtoIGV($data['igv']) // IGV total
            ->setTotalImpuestos($data['igv'])
            ->setValorVenta($data['monto_gravado']); // Base sin IGV
    } else {
        // Si es exonerado (tieneigv == 0)
        $invoice->setMtoOperExoneradas($data['monto_gravado']) // Total exonerado
            ->setMtoIGV(0)
            ->setTotalImpuestos(0)
            ->setValorVenta($data['monto_gravado']); // También puede ser el monto total sin IGV
    }

/*     echo "<pre>";
    var_export($data['total']);
    echo "</pre>"; */

    // Estos siempre aplican en ambos casos
    $invoice->setSubTotal($data['total']) // Monto total (con o sin IGV según corresponda)
        ->setMtoImpVenta($data['total']); // Total a pagar

    $items = [];
    // Modify your item creation in the foreach loop
    // Dentro de tu foreach para los detalles
    foreach ($data['detalle'] as $item) {
        $valorUnitario = (float)$item['valorunitario']; // Valor sin IGV
        $igvItem = (float)$item['igvproducto']; // Usar el IGV que viene en el request
        $precioUnitario = (float)$item['preciounitario']; // Usar el precio que viene en el request

        $detalle = (new SaleDetail())
            ->setUnidad('NIU')
            ->setCantidad(1)
            ->setDescripcion($item['descripcion'])
            ->setMtoValorUnitario($valorUnitario) // Valor sin IGV
            ->setMtoValorVenta($valorUnitario) // Valor total del ítem (cantidad=1)
            ->setMtoBaseIgv($valorUnitario);

        if ($data['tieneigv'] == 1) {
            $detalle->setPorcentajeIgv(18)
                ->setIgv($igvItem)
                ->setTipAfeIgv('10') // 10 = Gravado
                ->setTotalImpuestos($igvItem)
                ->setMtoPrecioUnitario($precioUnitario); // Precio CON IGV
        } else {
            $detalle->setPorcentajeIgv(18) // Siempre es 18% aunque exonerado
                ->setIgv(0)
                ->setTipAfeIgv('20') // 20 = Exonerado
                ->setTotalImpuestos(0)
                ->setMtoPrecioUnitario($valorUnitario); // Precio sin IGV (igual al valor)
        }

        $items[] = $detalle;
    }

    // Asignar los detalles al invoice
    $invoice->setDetails($items);

/*     echo "<pre>";
    var_export($detalle);
    echo "</pre>";
 */

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