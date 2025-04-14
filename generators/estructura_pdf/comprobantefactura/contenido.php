<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comprobante Factura Electronica</title>
    <link rel="icon" type="image/png" href="https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/esawybumfjhhujupw5pa.png">
</head>

<style>
    body {
        font-family: Arial, sans-serif;
        font-size: 12px;
        margin: 0;
        padding: 0;
    }

    .factura-header {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .factura-header td {
        vertical-align: top;
    }

    .logo-cell {
        width: 50%;
    }

    .info-cell {
        width: 50%;
        text-align: right;
    }

    .info-cell .cuadro {
        border: 1px solid #000;
        padding: 10px;
        display: inline-block;
    }

    .info-cell .cuadro div {
        margin-bottom: 5px;
    }

    .empresa-info {
        font-size: 12px;
        padding-top: 5px;
    }

    .cliente {
        margin-top: 20px;
        border: 1px solid #000;
        padding: 10px;
    }

    table.productos {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    table.productos th,
    table.productos td {
        border: 1px solid #000;
        padding: 6px;
        text-align: left;
    }

    table.productos th {
        background-color: #eee;
    }
</style>

<?php
$oGravada = 0;

foreach ($itemsComprobante as $item) {
    $oGravada += floatval($item['valorunitario']);
}

if ($infocomprobante[0]['tieneigv'] == 1) {
    $totalIgv = $oGravada * 0.18;
} else {
    $totalIgv = 0;
}
$importeTotal = $oGravada + $totalIgv;

$montoTotalCuotas = 0;
$totalCuotas = 0;
if (!empty($cuotasComprobante)) {
    $totalCuotas = count($cuotasComprobante);
    foreach ($cuotasComprobante as $cuota) {
        $montoTotalCuotas += floatval($cuota['monto']);
    }
}
function numeroATexto($numero)
{
    $formatter = new NumberFormatter('es', NumberFormatter::SPELLOUT);
    return ucfirst($formatter->format($numero));
}

?>

<body>

    <table class="factura-header">
        <tr>
            <!-- Logo -->
            <td class="logo-cell">
                <img src="https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/<?= $infoEmpresa[0]['logoempresa'] ?>" alt="Logo Empresa" style="width: 20%;">
            </td>

            <!-- Datos de la empresa -->
            <td class="info-cell">
                <div class="cuadro">
                    <div><strong>FACTURA ELECTRÓNICA</strong></div>
                    <div><strong>RUC:</strong> <?= $infoEmpresa[0]['ruc'] ?></div>
                    <div><strong><?= $infocomprobante[0]['nserie'] . '-' . $infocomprobante[0]['correlativo'] ?> </strong></div>
                </div>
            </td>
        </tr>
        <tr>
            <!-- Datos adicionales de la empresa (dirección, teléfono, etc.) -->
            <td colspan="2" class="empresa-info">
                <div><strong><?= $infoEmpresa[0]['razonsocial'] ?></strong> </div>
                <div><strong><?= $infoEmpresa[0]['direccion'] ?></strong> </div>
                <div><strong><?= $infocomprobante[0]['departamento'] . ' - ' . $infocomprobante[0]['provincia'] . ' - ' . $infocomprobante[0]['distrito'] ?></strong> </div>
            </td>
        </tr>
    </table>
    <div class="cliente">
        <strong>Fecha de emisión:</strong> <?= $infocomprobante[0]['fechaemision'] ?> <br>
        <strong>Hora de emisión:</strong> <?= $infocomprobante[0]['horaemision'] ?> <br>
        <strong>Fecha de vencimiento:</strong><br>
        <strong>Cliente:</strong> <?= $infocomprobante[0]['razonsocial'] ?> <br>
        <strong>RUC/DNI:</strong> <?= $infocomprobante[0]['ndocumento'] ?><br>
        <strong>Dirección:</strong> <?= $infocomprobante[0]['direccion'] ?><br>
        <strong>Tipo de moneda:</strong> <?= $nombreMoneda ?><br>
        <strong>Forma de pago:</strong> <?= ($infocomprobante[0]['tipopago'] == 1) ? "Al contado" : (($infocomprobante[0]['tipopago'] == 2) ? "Crédito" : "Otro") ?><br>
    </div>

    <table class="productos" style="margin-bottom: 15px;">
        <thead>
            <tr>
                <th>Ítem</th>
                <th>Descripción</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td><?= $itemsComprobante[0]['descripcion'] ?></td>
                <td>1</td>
                <td>S/ <?= $itemsComprobante[0]['valorunitario'] ?></td>
                <td>S/ <?= $itemsComprobante[0]['valorunitario'] ?></td>
            </tr>
            <tr>
                <td>2</td>
                <td> <?= $itemsComprobante[1]['descripcion'] ?></td>
                <td>1</td>
                <td>S/ <?= $itemsComprobante[1]['valorunitario'] ?></td>
                <td>S/ <?= $itemsComprobante[1]['valorunitario'] ?></td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: right; border: none;"></td>
                <td><strong>Op. Gravada</strong></td>
                <td>S/ <?= number_format($oGravada, 2, '.', ',') ?></td>

            </tr>
            <tr>
                <td colspan="3" style="text-align: right; border: none;"></td>
                <td><strong>I.G.V.</strong></td>
                <td><?php if($totalIgv == 0){
                    echo "No incluye";
                } else {
                    echo "S/ " . number_format($totalIgv, 2, '.', ',');
                } ?></td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: right; border: none;"></td>
                <td><strong>Importe total</strong></td>
                <td>S/ <?= number_format($importeTotal, 2, '.', ',') ?></td>
            </tr>

        </tbody>

    </table>
    <hr>
    <div class="cliente">
        <strong>Son:</strong> <?= numeroATexto($importeTotal) ?>
        <?php
        if ($infocomprobante[0]['tipopago'] == 2) {
            echo "<br><br>";
            echo "<strong>Total de Cuotas:</strong> " . $totalCuotas . " <br>";
            echo "<strong>Monto total de cuotas:</strong> S/ " . number_format($montoTotalCuotas, 2, '.', ',') . "<br>";
        }
        ?>
    </div>


    <?php
    if ($infocomprobante[0]['tipopago'] == 2 && !empty($cuotasComprobante)) {
        // Ordenar cuotas por fecha ascendente
        usort($cuotasComprobante, function ($a, $b) {
            return strtotime($a['fecha']) - strtotime($b['fecha']);
        });
    ?>
        <br>
        <strong>Detalle de Cuotas:</strong>
        <table class="productos">
            <thead>
                <tr>
                    <th>N° Cuota</th>
                    <th>Fecha de vencimiento</th>
                    <th>Monto</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($cuotasComprobante as $index => $cuota): ?>
                    <tr>
                        <td><?= $index + 1 ?></td>
                        <td><?= date('d/m/Y', strtotime($cuota['fecha'])) ?></td>
                        <td>S/ <?= number_format($cuota['monto'], 2, '.', ',') ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php } ?>
    <br>
    <strong>Representación Impresa de la FACTURA ELECTRÓNICA*</strong>
</body>