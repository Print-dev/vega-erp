<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contrato convenio <?= $convenioContrato[0]['nom_usuario'] ?></title>
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
        background: url('https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/<?php echo $convenioContrato[0]['marcaagua']; ?>') no-repeat center;
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
        margin-top: 200px;
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
$fecha_original = $convenioContrato[0]['fecha_presentacion']; // Ejemplo: "2025-03-10"
$fecha_obj = DateTime::createFromFormat('Y-m-d', $fecha_original);
$dia = $fecha_obj->format('d');
$mes = $meses[$fecha_obj->format('m')];
$anio = $fecha_obj->format('Y');

// Construir la fecha con el mes en español
$fecha_formateada = "$dia de $mes de $anio";

echo $fecha_formateada;

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
$horainicio = $convenioContrato[0]['horainicio']; // Ejemplo: "14:00:00"
$horafinal = $convenioContrato[0]['horafinal']; // Ejemplo: "14:00:00"
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

$monto_numerico = (float) $convenioContrato[0]['abono_garantia'];
$monto_texto = numeroATexto($monto_numerico);


?>

<!-- Encabezado centrado -->
<div class="watermark">
    <table class="datos-terminos-condiciones">
        <tr>
            <td colspan="5" style="text-align: center; font-size: 16px; text-decoration: underline; border: none; padding-bottom: 20px;"><strong>CONTRATO CONVENIO</strong></td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                En la fecha se reúnen de una parte Negociaciones y producciones Vega S.A.C, con RUC N° 20608627422,
                debidamente representado por su gerente general Nayade Liz Vega Pascual identificada con DNI. N.º 47842296,
                según el registro de personas jurídicas de Lima, a quién en adelante se le denominará EL REPRESENTANTE
                de <strong><?= strtoupper($convenioContrato[0]['nom_usuario']) ?></strong>; y de la otra parte:
                <?= strtoupper($convenioContrato[0]['razonsocial']) ?>,

                <?php if (strlen($convenioContrato[0]['ndocumento']) == 8): ?>
                    con DNI <?= $convenioContrato[0]['ndocumento'] ?>,
                <?php elseif (strlen($convenioContrato[0]['ndocumento']) == 11): ?>
                    con RUC <?= $convenioContrato[0]['ndocumento'] ?>,
                <?php endif; ?>

                <?php if (!empty($convenioContrato[0]['representantelegal'])): ?>
                    con el representante legal <?= strtoupper($convenioContrato[0]['representantelegal']) ?>,
                <?php endif; ?>

                con domicilio en <?= strtoupper($convenioContrato[0]['direccion']) ?>, en calidad de ORGANIZADOR(A) del evento;
                ambas partes con el propósito de celebrar el presente contrato en los términos siguientes:
            </td>

        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>PRIMERO:</strong> EL ORGANIZADOR contrata los servicios artísticos de <?= strtoupper($convenioContrato[0]['nom_usuario']) ?>
                para una presentación para el día <?= $fecha_formateada ?>,
                por <?= restarHoras($horainicio, $horafinal); ?> de SHOW a las
                <?= $hora_inicio_formateada ?> a <?= $hora_final_formateada ?> en <strong>“<?= strtoupper($convenioContrato[0]['establecimiento']) ?>”</strong>,
                <?php
                if ($convenioContrato[0]['esExtranjero'] == 1) {
                    echo $convenioContrato[0]['pais'];
                } else {
                    echo 'provincia de ' . strtoupper($convenioContrato[0]['provincia_evento']) . ', departamento de ' . strtoupper($convenioContrato[0]['departamento_evento']);
                }
                ?>
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>SEGUNDO:</strong> Que EL REPRESENTANTE en forma de Convenio, acuerda con EL ORGANIZADOR que
                el objeto del presente será ejecutado en porcentajes <strong>(<?= strtoupper($convenioContrato[0]['porcentaje_vega']) . '% VEGA Y ' . strtoupper($convenioContrato[0]['porcentaje_promotor']) . '% PROMOTOR' ?>)</strong> iguales a beneficio de
                ambos <?php if ($convenioContrato[0]['igv'] == 1): ?>
                    con
                <?php elseif ($convenioContrato[0]['igv'] == 0): ?>
                    sin
                <?php endif; ?>
                IGV; siendo que LA ORGANIZADORA deberá abonar en forma de Garantía el monto
                de S/. <?= $convenioContrato[0]['abono_garantia'] ?> (<?= strtoupper($monto_texto) ?> CON 100/100) el cual deberá ser dado en efectivo o por
                transferencia bancaria a la cuenta <?= $infoEmpresa[0]['banco']; ?> N° <?= $infoEmpresa[0]['ncuenta']; ?> o CCI N° <?= $infoEmpresa[0]['ncci']; ?> a
                nombre de EL REPRESENTANTE, y será contabilizado al cálculo de la liquidación.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>TERCERO:</strong> LA ORGANIZADORA se responsabiliza de tramitar todos los permisos y garantías
                correspondientes para la realización del evento, así como brindará la seguridad para los artistas
                y sus pertenencias.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                LA ORGANIZADORA es el responsable de la buena calidad del equipo de sonido, pantallas, luces
                y escenario; además es indispensable que se cumpla con el Rider técnico.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>CUARTO:</strong> En caso de suspensión del evento, debe ser notificado a EL PRESENTANTE con una
                antelación mínima de 7 días, de ninguna manera dará lugar a la devolución de la Garantía.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <strong>QUINTO:</strong> En caso de rescisión del presente contrato por incumplimiento de una de las partes
                ésta no causará un reintegro por concepto de indemnización y/o reembolso.
                Leído que fue el presente y estando ambas partes de acuerdo con lo estipulado lo suscriben
                para su debido cumplimiento.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
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
                        <td colspan="5" style="position: relative; text-align: center;">
                            <img src="https://res.cloudinary.com/dynpy0r4v/image/upload/v1742792207/<?= $representante[0]['firma'] ?>" style="
        position: absolute;
        top: -100px; /* Ajusta según sea necesario */
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
                                            echo $representante[0]['nombres'] . ' ' . $representante[0]['apellidos'];
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
                        <td colspan="5"><?= ucwords(strtolower($convenioContrato[0]['razonsocial'])) ?></td>
                    </tr>
                    <tr>
                        <td colspan="5"><?php if (strlen($convenioContrato[0]['ndocumento']) == 8): ?>
                                DNI: <?= $convenioContrato[0]['ndocumento'] ?>
                            <?php elseif (strlen($convenioContrato[0]['ndocumento']) == 11): ?>
                                RUC: <?= $convenioContrato[0]['ndocumento'] ?>
                            <?php endif; ?></td>
                    </tr>
                    <tr>
                        <td colspan="5">EL ORGANIZADOR</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>