<style>
    html,
    body {
        font-family: Arial, Helvetica, sans-serif;
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
    }

    .page-break {
        display: block;
        width: 100%;
        height: 1px;
        page-break-after: always;
    }

    .watermark {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: url('http://localhost/vega-erp/images/cotizacion/calvay/watermark.jpg') no-repeat center;
        background-size: contain;
        /* Ocupa toda la hoja */
        /* Ajusta la transparencia */
        z-index: -1;
    }

    /* Tabla de datos del cliente */
    .datos-terminos-condiciones {
        font-family: Arial, Helvetica, sans-serif;
        width: 70%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;
        text-align: justify;
        margin-top: 220px;
        font-weight: lighter;
    }

    .datos-terminos-condiciones td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
        font-size: 13px;
    }

    .datos-firma {
        width: 82%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;
        margin-top: 100px;

    }

    .datos-firma td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
        border: none;
        text-align: left;
        font-size: 13px;
    }

    .firmas {
        width: 100%;
        border-collapse: collapse;
        font-size: 11px;

    }

    .header-left {
        width: 52%;
        padding-left: 90px;
        text-align: left;
        vertical-align: top;
        font-size: 12px;
        /* Ajusta el margen izquierdo */
    }

    .header-right {
        width: 60%;
        font-size: 15px;
        text-align: right;
        vertical-align: top;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .label {
        font-weight: normal;
        width: 30%;
    }
</style>

<?php
$precioFinal = -1;
// DIAS
$meses = [
    '01' => 'enero',
    '02' => 'febrero',
    '03' => 'marzo',
    '04' => 'abril',
    '05' => 'mayo',
    '06' => 'junio',
    '07' => 'julio',
    '08' => 'agosto',
    '09' => 'septiembre',
    '10' => 'octubre',
    '11' => 'noviembre',
    '12' => 'diciembre'
];

// Convertir la fecha a formato legible
$fecha_original = $contratoPresentacion[0]['fecha_presentacion']; // Ejemplo: "2025-03-10"
$fecha_obj = DateTime::createFromFormat('Y-m-d', $fecha_original);
$dia = $fecha_obj->format('d');
$mes = $meses[$fecha_obj->format('m')];
$anio = $fecha_obj->format('Y');

// Construir la fecha con el mes en español
$fecha_formateada = "$dia de $mes de $anio";

echo $fecha_formateada;

function formatoHora($hora_24h)
{
    // Convertir la hora de 24h a 12h con AM/PM
    $hora_obj = DateTime::createFromFormat('H:i:s', $hora_24h);
    return $hora_obj->format('g:i A'); // "g:i A" da la hora en 12h sin ceros a la izquierda
}

// Ejemplo de uso
$hora_presentacion = $contratoPresentacion[0]['hora_presentacion']; // Ejemplo: "14:00:00"
$hora_formateada = formatoHora($hora_presentacion);

echo $hora_formateada;

// CONVERTIR NUMEROS A TEXTO
function numeroATexto($numero)
{
    $formatter = new NumberFormatter('es', NumberFormatter::SPELLOUT);
    return ucfirst($formatter->format($numero));
}

$monto_numerico = (float) $contratoPresentacion[0]['abono_garantia'];
$monto_texto = numeroATexto($monto_numerico);

$monto_texto = numeroATexto($monto_numerico);

?>

<!-- Encabezado centrado -->
<div class="watermark">
    <table class="datos-terminos-condiciones">
        <tr>
            <td colspan="5" style="text-align: center; font-size: 16px; text-decoration: underline; border: none; padding-bottom: 20px;"><strong>CONTRATO DE PRESENTACION ARTISTICA</strong></td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                En la fecha se reúnen de una parte:

            </td>

        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>Negociaciones y producciones Vega S.A.C</strong>, con RUC N° 20608627422, debidamente
                representado por su gerente general Nayade Liz Vega Pascual identificada con DNI. N.º
                47842296, según el registro de personas jurídicas de Lima, a quién en adelante se le
                denominará EL REPRESENTANTE de <strong>“<?= $contratoPresentacion[0]['nom_usuario'] ?>”</strong>;
                y de la otra parte:
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong> <?= ucwords(strtolower($contratoPresentacion[0]['razonsocial'])) ?>,</strong>

                <?php if (strlen($contratoPresentacion[0]['ndocumento']) == 8): ?>
                    con DNI <?= $contratoPresentacion[0]['ndocumento'] ?>
                <?php elseif (strlen($contratoPresentacion[0]['ndocumento']) == 11): ?>
                    con RUC <?= $contratoPresentacion[0]['ndocumento'] ?>
                <?php endif; ?>

                <?php if (!empty($contratoPresentacion[0]['representantelegal'])): ?>
                    con el representante legal <?= strtoupper($contratoPresentacion[0]['representantelegal']) ?>
                <?php endif; ?>
                , con celular N° <?= $contratoPresentacion[0]['telefono'] ?>, en
                calidad de EL ORGANIZADOR del evento; ambas partes con el propósito de celebrar el
                presente contrato en los términos siguientes:

            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none; text-decoration: underline;">
                <strong>OBJETO:</strong>
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>PRIMERO: EL ORGANIZADOR</strong> contrata los servicios artísticos de <strong><?= $contratoPresentacion[0]['nom_usuario'] ?></strong> Y
                ORQUESTA para una presentación para el día <strong><?= $fecha_formateada ?></strong>, por <strong><?= $contratoPresentacion[0]['tiempo_presentacion'] ?></strong> minutos de SHOW
                a las <?= $hora_formateada ?>, (que por la dificultad de la ruta puede variar como máximo
                1 hora posterior) en la localidad <?= $contratoPresentacion[0]['distrito_evento'] ?>, provincia de <?= $contratoPresentacion[0]['provincia_evento'] ?>, departamento de <?= $contratoPresentacion[0]['departamento_evento'] ?>.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                SEGUNDO: Que, el costo de la representación artística puesta en el escenario (incluido
                traslado, movilidad, boletos de viaje) asciende a la suma de S/
                <strong>
                    <?php if ($contratoPresentacion[0]['igv'] == 0) {
                        if (isset($tarifaArtista[0]['precio'])) {
                            $precioFinal = $tarifaArtista[0]['precio'] + $precio;
                            echo $precioFinal . '.00';
                        } else {
                            $precioFinal = $precio;
                            echo $precioFinal . '.00';
                        }
                    } else if ($contratoPresentacion[0]['igv'] == 1) {
                        if (isset($tarifaArtista[0]['precio'])) {
                            $precioFinal = ($tarifaArtista[0]['precio'] + $precio) + $igv;
                            echo $precioFinal . '.00';
                        } else {
                            $precioFinal = $precio + $igv;
                            echo $precioFinal . '.00';
                        }
                    }
                    $precioFinal_texto = numeroATexto($precioFinal); ?>
                </strong>
                <strong>(<?= strtoupper($precioFinal_texto) ?> MIL CON 00/100 SOLES)</strong>
                <?php if ($contratoPresentacion[0]['igv'] == 1): ?>
                    con
                <?php elseif ($contratoPresentacion[0]['igv'] == 0): ?>
                    sin
                <?php endif; ?>
                IGV, el cual será cancelado de la siguiente forma:

            </td>
        </tr>

        <tr>
            <td class="label" colspan="5" style="border: none;">
                <ul style="list-style: disc;">
                    <li>A la firma del presente contrato la suma ascendente de <strong>S/ <?php
                                                                                            $precioFinal = $precioFinal / 2;
                                                                                            $precioFinal_texto = numeroATexto($precioFinal);
                                                                                            echo $precioFinal . '.00';
                                                                                            ?> (<?= strtoupper($precioFinal_texto) ?> CON 00/100 SOLES)</strong> como adelanto y separación de fecha.
                    </li>
                    <li>Cinco horas antes de la presentación artística se debe cancelar la suma
                        ascendente restante ascendente de <strong> S/ <?= $precioFinal . '.00' ?> (<?= strtoupper($precioFinal_texto) ?> CON 00/100
                            SOLES)</strong> bajo penalidad de no ejecutarse la presentación.
                    </li>
                </ul>
            </td>
        </tr>

        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>EL ORGANIZADOR</strong> deberá abonar dichos montos en efectivo o por transacción bancaria
                a la cuenta <strong> BCP N° 1929842849014</strong> o <strong>CCI N° 00219200984284901432</strong> a nombre de EL
                REPRESENTANTE, dándose por cancelado con la exhibición y validación de los váuchers
                o constancia de pago correspondientes.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>TERCERO: EL ORGANIZADOR,</strong> se responsabiliza de tramitar todos los permisos y
                garantías correspondientes para la ejecución del evento, así como brindará la seguridad
                para los artistas y sus pertenencias.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>EL ORGANIZADOR</strong> es responsable de la calidad del equipo de sonido, pantallas, luces y
                escenario; además es indispensable que se cumpla con el Ryder técnico a fin de otorgar
                al público en general un show de calidad.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none; text-decoration: underline;">
                <strong>PENALIDAD:</strong>
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>CUARTO: EL ORGANIZADOR</strong> se obliga a cumplir con los pagos en las fechas y formas
                especificadas en la cláusula segunda, bajo apercibimiento a aplicar la penalidad de darse
                por resuelto el presente contrato de forma automática, al instante del incumplimiento
                de lo pactado, ello de ninguna manera dará lugar a la devolución de los montos
                adelantados.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                En caso de suspensión del evento, una vez hecho el contrato, de ninguna manera dará
                lugar a la devolución del monto adelantado, en casos que la suspensión sea comunicada
                con 15 días de anticipación a la fecha del evento, <strong>EL ORGANIZADOR</strong> podrá tener opción
                de reprogramar el evento, en función a la disponibilidad del artista.
            </td>
        </tr>


    </table>

</div>

<div class="page-break"></div> <!-- Aquí se fuerza el salto de página -->

<div class="watermark">
    <table class="datos-terminos-condiciones">
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>VIGENCIA:</strong>
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>QUINTO:</strong> Se deja expresa constancia, que el presente contrato es ejecutivo solo cuando
                se cancele el mínimo del 50% del total.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>SEXTO:</strong> En caso de rescisión del presente contrato por incumplimiento de una de las
                partes por causas naturales y de fuerza mayor, el monto adelantado no será
                reembolsable, pero previo acuerdo se buscará un consenso entre ambas partes.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                Leído que fue el presente y estando ambas partes de acuerdo con lo estipulado lo
                suscriben para su debido cumplimiento.

            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none; text-align: right;">
                <?php $formatter = new IntlDateFormatter('es_ES', IntlDateFormatter::LONG, IntlDateFormatter::NONE);
                echo "Lima, " . $formatter->format(time());
                ?>

            </td>
        </tr>
    </table>
    <table class="firmas">
        <tr>
            <td class="header-left">
                <table class="datos-firma ">

                    <tr>
                        <td colspan="5">_________________________________</td>
                    </tr>
                    <tr>
                        <td colspan="5">Negociaciones y producciones Vega S.A.C</td>
                    </tr>
                    <tr>
                        <td colspan="5">Representado por</td>
                    </tr>
                    <tr>
                        <td colspan="5">Nayade Liz Vega Pascual</td>
                    </tr>
                    <tr>
                        <td colspan="5">EL REPRESENTANTE</td>
                    </tr>
                </table>
            </td>
            <td class="header-right">
                <table class="datos-firma ">
                    <tr>
                        <td colspan="5">________________________________</td>
                    </tr>
                    <tr>
                        <td colspan="5"><strong><?= ucwords(strtolower($contratoPresentacion[0]['razonsocial'])) ?></strong></td>
                    </tr>
                    <tr>
                        <td colspan="5"><?php if (strlen($contratoPresentacion[0]['ndocumento']) == 8): ?>
                                DNI: <?= $contratoPresentacion[0]['ndocumento'] ?>
                            <?php elseif (strlen($contratoPresentacion[0]['ndocumento']) == 11): ?>
                                RUC: <?= $contratoPresentacion[0]['ndocumento'] ?>
                            <?php endif; ?></td>
                    </tr>
                    <tr>
                        <td colspan="5"><strong>EL ORGANIZADOR</strong></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>