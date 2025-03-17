<style>
    html,
    body {

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
        background: url('http://localhost/vega-erp/images/cotizacion/calvay/watermark.jpg') no-repeat center;
        background-size: 100% 100%;
        /* Ocupa toda la hoja */
        /* Ajusta la transparencia */
        z-index: -1;
    }

    .header-container {
        width: 100%;
        border-collapse: collapse;
        font-size: 11px;
        margin-top: 150px;
    }

    .header-left {
        width: 70%;
        text-align: left;
        vertical-align: top;
        padding-left: 230px;
        font-size: 12px;
        /* Ajusta el margen izquierdo */
    }

    .header-right {
        width: 60%;
        font-size: 15px;
        padding-left: 40px;
        text-align: right;
        vertical-align: top;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }


    .header-table,
    .header-cotizacion {
        width: 100%;
    }

    /* Tabla de datos del cliente */
    .datos-cliente {
        width: 80%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;

    }

    .datos-cliente td:nth-child(3) {
        /* Aplica a la tercera celda (DNI / RUC) */
        width: 15%;
    }

    .datos-cliente td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
    }

    /* Tabla de datos del cliente */
    .datos-presentacion {
        width: 80%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;

    }

    .datos-presentacion td:nth-child(3) {
        /* Aplica a la tercera celda (DNI / RUC) */
        width: 15%;
    }

    .datos-presentacion td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
    }

    /* Tabla de datos del cliente */
    .datos-cotizacion {
        width: 80%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;

    }

    .datos-cotizacion td:nth-child(3) {
        /* Aplica a la tercera celda (DNI / RUC) */
        width: 15%;
    }

    .datos-cotizacion td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
    }

    /* Tabla de datos del cliente */
    .datos-terminos-condiciones {
        width: 80%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;

    }

    .datos-terminos-condiciones td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
    }

    /* Tabla de datos del cliente */
    .datos-pagos {
        width: 80%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;

    }

    .datos-pagos td:nth-child(2) {
        /* Aplica a la tercera celda (DNI / RUC) */
        width: 10%;
    }

    .datos-pagos td:nth-child(1) {
        /* Aplica a la tercera celda (DNI / RUC) */
        width: 10%;
    }

    .datos-pagos td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
    }

    .datos-pagos td:nth-child(3) {
        /* Aplica a la tercera celda (DNI / RUC) */
        width: 15%;
    }

    /* Tabla de datos del cliente */
    .datos-firma {
        width: 80%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;
        margin-top: 30px;

    }

    .datos-firma td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
        border: none;
        text-align: right;
        font-size: 13px;
    }


    .label {
        font-weight: bold;
        width: 30%;
    }
</style>

<?php
date_default_timezone_set('America/Lima');

function formatoHora($hora_24h)
{
    // Convertir la hora de 24h a 12h con AM/PM
    $hora_obj = DateTime::createFromFormat('H:i:s', $hora_24h);
    return $hora_obj->format('g:i A'); // "g:i A" da la hora en 12h sin ceros a la izquierda
}


/* function restarHoras($horaInicio, $horaFinal)
{
    $inicio = new DateTime($horaInicio);
    $final = new DateTime($horaFinal);
    $intervalo = $inicio->diff($final);

    $horas = $intervalo->h;
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
 */

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


?>

<!-- Encabezado centrado -->
<div class="watermark">
    <table class="header-container">
        <tr>
            <!-- Información de la empresa (izquierda) -->
            <td class="header-left">
                <table class="header-table">
                    <tr>
                        <td><strong>NEGOCIACIONES Y PRODUCCIONES VEGA S.A.C.</strong></td>
                    </tr>
                    <tr>
                        <td>RUC N° 20608627422 / Cel. 970666528</td>
                    </tr>
                    <tr>
                        <td>Direc: Av. Alfredo Mendiola N° 2139</td>
                    </tr>
                    <tr>
                        <td>San Martín de Porres – Lima</td>
                    </tr>
                </table>
            </td>

            <!-- Número de cotización (derecha) -->
            <td class="header-right">
                <table class="header-cotizacion">
                    <tr>
                        <td style="text-align: center;"><strong>COTIZACIÓN N°:</strong></td>
                    </tr>
                    <tr>
                        <td style="text-decoration: underline; text-align: center;"><?php echo $cotizacion[0]['ncotizacion']; ?></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table class="datos-cliente">
        <tr style="background-color: #FFC000;">
            <td colspan="4" style="text-align: center; font-size: 12px;"><strong>DATOS DE CLIENTE</strong></td>
        </tr>
        <tr>
            <td class="label">Nombres / Razón Social</td>
            <td colspan="3"><?php echo $cotizacion[0]['razonsocial']; ?></td>
        </tr>
        <tr>
            <td class="label">DNI / RUC</td>
            <td colspan="3"><?php echo $cotizacion[0]['ndocumento']; ?></td>
        </tr>
        <tr>
            <td class="label">Representante Legal</td>
            <td colspan="3"><?php echo $cotizacion[0]['representantelegal']; ?></td>
        </tr>
        <tr>
            <td class="label">Dirección</td>
            <td colspan="3"><?php echo $cotizacion[0]['direccion']; ?></td>
        </tr>
        <tr>
            <td class="label">Distrito</td>
            <td style="border-left: none;"><?php echo $cotizacion[0]['distrito']; ?></td>
            <td class="label" colspan="1">Provincia</td>
            <td colspan="1"><?php echo $cotizacion[0]['provincia']; ?></td>
        </tr>
        <tr>
            <td class="label">Correo</td>
            <td style="border-left: none;"><?php echo $cotizacion[0]['correo']; ?></td>
            <td class="label" colspan="1">Celular</td>
            <td colspan="1"><?php echo $cotizacion[0]['telefono']; ?></td>
        </tr>
    </table>
    <table class="datos-presentacion">
        <tr style="background-color: #FFC000;">
            <td colspan="4" style="text-align: center; font-size: 12px;"><strong>DATOS DE PRESENTACION</strong></td>
        </tr>
        <tr>
            <td class="label">Artista</td>
            <td colspan="3"><?php echo $cotizacion[0]['nom_usuario']; ?></td>
        </tr>
        <tr>
            <td class="label">Tiempo:</td>
            <td><?= restarHoras($horainicio, $horafinal); ?></td>
            <td class="label" colspan="1">Desde - Hasta</td>
            <td colspan="1"><?php echo $hora_inicio_formateada . ' - ' . $hora_final_formateada ?></td>
        </tr>
        <tr>
            <td class="label">Fecha</td>
            <td colspan="3"><?php echo $cotizacion[0]['fecha_presentacion']; ?></td>
        </tr>
        <tr>
            <td class="label">Establecimiento</td>
            <td colspan="3"><?php echo $cotizacion[0]['establecimiento']; ?></td>
        </tr>
        <tr>
            <td class="label">Ubicación</td>
            <td colspan="3"><?php echo $cotizacion[0]['departamento_evento'] . '/' . $cotizacion[0]['provincia_evento'] . '/' . $cotizacion[0]['distrito_evento']; ?></td>
        </tr>
        <tr>
            <td class="label">Referencia</td>
            <td colspan="3"><?= $cotizacion[0]['referencia'] ?></td>
        </tr>
    </table>
    <table class="datos-cotizacion">
        <tr style="background-color: #FFC000;">
            <td colspan="5" style="text-align: center; font-size: 12px;"><strong>COTIZACION</strong></td>
        </tr>
        <tr>
            <td class="label">Ítem</td>
            <td class="label">Descripción</td>
            <td class="label">Tiempo</td>
            <td class="label">Costo</td>
            <td class="label">Total</td>
        </tr>
        <tr>
            <td style="width: 20px;">1</td>
            <td style="width: 345px;">PRESENTACION ARTÍSTICA DE <?= strtoupper($cotizacion[0]['nom_usuario']); ?> </td>
            <td style="width: 90px;"><?= restarHoras($horainicio, $horafinal); ?></td>
            <td style="width: 70px;"><?php if (isset($tarifaArtista[0]['precio'])) {
                                            echo "S/. " . $tarifaArtista[0]['precio'];
                                        } else {
                                            echo 'Sin tarifa en esta provincia';
                                        } ?></td>
            <td><?php if (isset($tarifaArtista[0]['precio'])) {
                    echo "S/. " . $tarifaArtista[0]['precio'];
                } else {
                    echo 'Sin tarifa en esta provincia';
                } ?></td>
        </tr>
        <tr>
            <td>2</td>
            <td>Puesto en la locacion de <?php echo $provincia; ?></td>
            <td></td>
            <td><?php echo "S/. " . $precio; ?></td>
            <td><?php echo "S/. " . $precio; ?></td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: right; border: none;">(Opcional)</td>
            <td><strong>IGV (18%)</strong></td>
            <td><?php if ($cotizacion[0]['igv'] == 0) {
                    echo 'no incluye';
                } else if ($cotizacion[0]['igv'] == 1) {
                    echo "S/. " . $igv;
                } ?></td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: right; border: none;"></td>
            <td><strong>TOTAL</strong></td>
            <td><?php if ($cotizacion[0]['igv'] == 0) {
                    if (isset($tarifaArtista[0]['precio'])) {
                        echo "S/. " . $tarifaArtista[0]['precio'] + $precio;
                    } else {
                        echo "S/. " . $precio;
                    }
                } else if ($cotizacion[0]['igv'] == 1) {
                    if (isset($tarifaArtista[0]['precio'])) {
                        echo "S/. " . ($tarifaArtista[0]['precio'] + $precio) + $igv;
                    } else {
                        echo "S/. " . $precio + $igv;
                    }
                } ?></td>
        </tr>

    </table>
    <table class="datos-pagos">
        <tr style="background-color: #FFC000;">
            <td colspan="5" style="text-align: center; font-size: 12px;"><strong>MEDIOS DE PAGO</strong></td>
        </tr>
        <tr>
            <td class="label">Banco</td>
            <td class="label">Moneda</td>
            <td class="label" colspan="2" style="text-align: center;">Cuenta de ahorro N°</td>
            <td class="label" style="text-align: center;">CCI N°</td>
        </tr>
        <tr>
            <td>BCP</td>
            <td>Soles</td>
            <td colspan="2" style="text-align: center;">1929842849014</td>
            <td style="text-align: center;">00219200984284901432</td>
        </tr>
    </table>
    <table class="datos-terminos-condiciones">
        <tr>
            <td colspan="5" style="text-align: start; font-size: 12px; text-decoration: underline; border: none;"><strong>TERMINOS Y CONDICIONES</strong></td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
                <ol>
                    <li> El pago será debitado al 50 % de emitida la conformidad de la proforma y 50 % antes del inicio del concierto. La presente cotización otorga la posibilidad de RESERVA de FECHA con el 25%, vigente solo por 5 días de emitida la presente.</li>
                    <li> El pago inicial del 50% se realiza por transferencia o depósito en la cuenta señalada.</li>
                    <li> La presente cotización, es válida por <?php echo $cotizacion[0]['validez'] ?> días calendario. </li>
                    <li> No existe concepto de reembolso en caso de suspensión del evento, o abstención de contrato.
                    <li> La presente cotización no es factible de cesión de uso o ceder a otro ya sea de forma onerosa o gratuita.
                    </li>
                </ol>
            </td>

        </tr>

    </table>
    <table class="datos-firma">
        <tr>
            <td colspan="5" style="position: relative; text-align: end;">
                <img src="http://localhost/vega-erp/images/firma/firma.png" style="
        position: absolute;
        top: -70px; /* Ajusta según sea necesario */
        left: 90%;
        transform: translateX(-50%);
        width: 170px; /* Ajusta el tamaño */
    " alt="Firma">
                _______________________________
            </td>
        </tr>
        <tr>
            <td colspan="5">V° B° Vega Producciones S.A.C</td>
        </tr>
        <tr>
            <td colspan="5">RUC N° 20608627422</td>
        </tr>
    </table>
</div>