<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Constancia Reserva <?= $cotizacion[0]['nom_usuario'] ?></title>
    <link rel="icon" type="image/png" href="https://res.cloudinary.com/dynpy0r4v/image/upload/v1742818076/vegaimagenes/esawybumfjhhujupw5pa.png">
</head>
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
        page-break-before: always;
        /* Crea un salto de página antes de este elemento */
    }

    .watermark {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: url('https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/<?php echo $cotizacion[0]['marcaagua']; ?>') no-repeat center;
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
        width: 80%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;
        margin-top: 120px;

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
        width: 70%;
        font-size: 15px;
        text-align: right;
        vertical-align: top;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .datos-terminos-condiciones-custom {
        font-family: Arial, Helvetica, sans-serif;
        width: 70%;
        margin: 0 auto;
        /* Centrar */
        border-collapse: collapse;
        font-size: 11px;
        text-align: justify;
        font-weight: lighter;
        position: relative;
        top: 90px;
        /* Mueve hacia arriba */
    }


    .label {
        font-weight: normal;
        width: 30%;
    }
</style>

<?php
date_default_timezone_set('America/Lima');

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
$fecha_original = $cotizacion[0]['fecha_presentacion']; // Ejemplo: "2025-03-10"
$fecha_obj = DateTime::createFromFormat('Y-m-d', $fecha_original);
$dia = $fecha_obj->format('d');
$mes = $meses[$fecha_obj->format('m')];
$anio = $fecha_obj->format('Y');

$fecha_obj = DateTime::createFromFormat('Y-m-d', $reserva[0]['fechacreada']);
$diaC = $fecha_obj->format('d');
$mesC = $meses[$fecha_obj->format('m')];
$anioC = $fecha_obj->format('Y');

// Construir la fecha con el mes en español
$fecha_formateada = "$dia de $mes de $anio";
$fecha_creada_formateada = "$diaC de $mesC de $anioC";

echo $fecha_formateada;

//FECHAS
$formatter = new IntlDateFormatter('es_ES', IntlDateFormatter::LONG, IntlDateFormatter::NONE);

// HORAS 
function formatoHora($hora_24h)
{
    // Convertir la hora de 24h a 12h con AM/PM
    $hora_obj = DateTime::createFromFormat('H:i:s', $hora_24h);
    return $hora_obj->format('g:i A'); // "g:i A" da la hora en 12h sin ceros a la izquierda
}

function restarHoras($horaInicio, $horaFinal)
{
    $inicio = new DateTime($horaInicio);
    $final = new DateTime($horaFinal);

    // Si la hora final es menor que la inicial, significa que termina al día siguiente
    if ($final < $inicio) {
        $final->modify('+1 day'); // Sumar un día a la hora final
    }

    $intervalo = $inicio->diff($final);
    $horas = $intervalo->h + ($intervalo->d * 24); // Agregar días convertidos a horas
    $minutos = $intervalo->i;

    // Formatear la salida
    $resultado = [];
    if ($horas > 0) {
        $resultado[] = "$horas " . ($horas == 1 ? "hora" : "horas");
    }
    if ($minutos > 0) {
        $resultado[] = "$minutos " . ($minutos == 1 ? "minuto" : "minutos");
    }

    return implode(" con ", $resultado);
}




// Ejemplo de uso
$horainicio = $cotizacion[0]['horainicio']; // Ejemplo: "14:00:00"
$horafinal = $cotizacion[0]['horafinal']; // Ejemplo: "14:00:00"
$hora_inicio_formateada = formatoHora($horainicio);
$hora_final_formateada = formatoHora($horafinal);

echo $hora_inicio_formateada;
echo $hora_final_formateada;

// CONVERTIR NUMEROS A TEXTO
function numeroATexto($numero)
{
    $formatter = new NumberFormatter('es', NumberFormatter::SPELLOUT);
    return ucfirst($formatter->format($numero));
}

$monto_numerico = (float) $reserva[0]['monto'];
$monto_texto = numeroATexto($monto_numerico);


?>

<!-- Encabezado centrado -->
<div class="watermark">
    <table class="datos-terminos-condiciones">
        <tr>
            <td colspan="5" style="text-align: center; font-size: 16px; text-decoration: underline; border: none; padding-bottom: 20px;"><strong>CONSTANCIA DE RESERVA</strong></td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none; text-align: center;">
                En la fecha <?= $fecha_creada_formateada ?>, se deja constancia de la reserva de fecha realizada por:
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none; text-align: center; padding-top: 20px;">
                <strong><?= $cotizacion[0]['razonsocial'] ?></strong>
            </td>

        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none; padding-top: 20px;">
                Debidamente identificado

                <?php if (strlen($cotizacion[0]['ndocumento']) == 8): ?>
                    con DNI N° <?= $cotizacion[0]['ndocumento'] ?>,
                <?php elseif (strlen($cotizacion[0]['ndocumento']) == 11): ?>
                    con RUC N°<?= $cotizacion[0]['ndocumento'] ?>,
                <?php endif; ?>

                <?php if (!empty($cotizacion[0]['representantelegal'])): ?>
                    con el representante legal <?= strtoupper($cotizacion[0]['representantelegal']) ?>,
                <?php endif; ?>

                con domicilio en <?= $cotizacion[0]['direccion'] ?>, con celular N° <?= $cotizacion[0]['telefono'] ?>,
                en calidad de Organizador(a) del evento a realizarse en día <?= $fecha_formateada ?>, con hora de
                inicio <?= $hora_inicio_formateada ?> horas, y hora de termino <?= $hora_final_formateada ?>, haciendo un total de <?= restarHoras($horainicio, $horafinal); ?>, en el local/sector/urb.
                <?= $cotizacion[0]['establecimiento'] ?>, en el distrito de <?= $cotizacion[0]['distrito_evento'] ?>, provincia de <?= $cotizacion[0]['provincia_evento'] ?>, departamento de <?= $cotizacion[0]['departamento_evento'] ?>.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                Se deja constancia mediante la presente del desembolso ascendente a S/. <?= $reserva[0]['monto'] ?> (<?= strtoupper($monto_texto) ?>)
                mediante EFECTIVO/ TRANSFERENCIA que equivale al 25%, del valor total de la presentación sin/con IGV .
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                La presente constancia tiene una vigencia por <?= $reserva[0]['vigencia'] ?> días, plazo en el cual la/el
                organizador(a) del evento tendrá que realizar la cancelación diferencial necesaria para completar el 50% a fin de
                celebrar el contrato.
            </td>
        </tr>

    </table>
    <table class="firmas">
        <tr>
            <td class="header-left">
                <table class="datos-firma ">

                    <tr>
                        <td colspan="5" style="position: relative; text-align: center;">
                            <img src="https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/<?= $representante[0]['firma'] ?>" style="
        position: absolute;
        top: -70px; /* Ajusta según sea necesario */
        left: 50%;
        transform: translateX(-50%);
        width: 170px; /* Ajusta el tamaño */
    " alt="Firma">
                            ___________________________________
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5"><?= $representante[0]['nombre'] ?></td>
                    </tr>
                    <tr>
                        <td colspan="5">Representado por</td>
                    </tr>
                    <tr>
                        <td colspan="5"><?php
                                        if (isset($representante[0])) {
                                            echo $representante[0]['nombres']  . ' '.  $representante[0]['apellidos'];
                                        } else {
                                            echo "No hay representante asignado aun.";
                                        }
                                        ?></td>
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
                        <td colspan="5"><strong><?= ucwords(strtolower($cotizacion[0]['razonsocial'])) ?></strong></td>
                    </tr>
                    <tr>
                        <td colspan="5"><?php if (strlen($cotizacion[0]['ndocumento']) == 8): ?>
                                DNI: <?= $cotizacion[0]['ndocumento'] ?>
                            <?php elseif (strlen($cotizacion[0]['ndocumento']) == 11): ?>
                                RUC: <?= $cotizacion[0]['ndocumento'] ?>
                            <?php endif; ?></td>
                    </tr>
                    <tr>
                        <td colspan="5">EL / LA ORGANIZADOR(A)</td>
                    </tr>
                </table>
            </td>

        </tr>
    </table>
    <table class="datos-terminos-condiciones-custom">
        <tr>
            <td colspan="5" style="text-align: start; font-size: 12px; text-decoration: underline; border: none; margin-top: 300px;"><strong>TERMINOS Y CONDICIONES</strong></td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <ol>
                    <li>La presente es una constancia de separación, no es ejecutivo para la celebración del evento hasta que se cancele el 50% del total del valor del evento.</li>
                    <li>En caso no realizar el pago correspondiente en la fecha indicada, se procederá a declarar la fecha como fecha libre sin derecho a devolución del dinero o de fecha.</li>
                    <li>Solo en casos fortuitos y de fuerza mayor puede otorgarse una reprogramación previa disponibilidad del artista.</li>
                    </li>
                </ol>
            </td>

        </tr>

    </table>
</div>