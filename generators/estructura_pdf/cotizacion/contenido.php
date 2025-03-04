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
        margin-top: 160px;
    }

    .header-left {
        width: 70%;
        text-align: left;
        vertical-align: top;
        padding-left: 230px;
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
            <td colspan="4" style="text-align: center; font-size: 14px;"><strong>DATOS DE CLIENTE</strong></td>
        </tr>
        <tr>
            <td class="label">Nombres / Razón Social</td>
            <td colspan="3"><?php echo $cotizacion[0]['razonsocial']; ?></td>
        </tr>
        <tr>
            <td class="label"><?php echo $cotizacion[0]['ndocumento']; ?></td>
            <td colspan="3"></td>
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
            <td class="label" style="border-right: none;">Distrito</td>
            <td style="border-left: none;"><?php echo $cotizacion[0]['distrito']; ?></td>
            <td class="label" colspan="1">Provincia</td>
            <td colspan="1"><?php echo $cotizacion[0]['provincia']; ?></td>
        </tr>
        <tr>
            <td class="label" style="border-right: none;">Correo</td>
            <td style="border-left: none;"><?php echo $cotizacion[0]['correo']; ?></td>
            <td class="label" colspan="1">Celular</td>
            <td colspan="1"><?php echo $cotizacion[0]['telefono']; ?></td>
        </tr>
    </table>
    <table class="datos-presentacion">
        <tr style="background-color: #FFC000;">
            <td colspan="4" style="text-align: center; font-size: 14px;"><strong>DATOS DE PRESENTACION</strong></td>
        </tr>
        <tr>
            <td class="label">Artista</td>
            <td colspan="3"><?php echo $cotizacion[0]['nom_usuario']; ?></td>
        </tr>
        <tr>
            <td class="label">Tiempo:</td>
            <td><?php echo $cotizacion[0]['tiempo_presentacion']; ?></td>
            <td class="label" colspan="1">Hora</td>
            <td colspan="1"><?php echo $cotizacion[0]['hora_presentacion']; ?></td>
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
    </table>
    <table class="datos-cotizacion">
        <tr style="background-color: #FFC000;">
            <td colspan="5" style="text-align: center; font-size: 14px;"><strong>COTIZACION</strong></td>
        </tr>
        <tr>
            <td class="label">Ítem</td>
            <td class="label">Descripción</td>
            <td class="label">Tiempo</td>
            <td class="label">Costo</td>
            <td class="label">Total</td>
        </tr>
        <tr>
            <td>1</td>
            <td>Presentacion artistica</td>
            <td></td>
            <td><?php if(isset($tarifaArtista[0]['precio'])){
                echo $tarifaArtista[0]['precio'];
            } else {
                echo 'Sin tarifa en esta provincia';
            } ?></td>
            <td><?php if(isset($tarifaArtista[0]['precio'])){
                echo $tarifaArtista[0]['precio'];
            } else {
                echo 'Sin tarifa en esta provincia';
            } ?></td>
        </tr>
        <tr>
            <td>2</td>
            <td>Puesto en la locacion <?php echo $provincia; ?></td>
            <td></td>
            <td><?php echo $precio; ?></td>
            <td><?php echo $precio; ?></td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: right; border: none;">(Opcional)</td>
            <td><strong>IGV (18%)</strong></td>
            <td><?php if ($cotizacion[0]['igv'] == 0) {
                echo 'no incluye';
            }else if ($cotizacion[0]['igv'] == 1) { 
                echo $igv;
            } ?></td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: right; border: none;"></td>
            <td><strong>TOTAL</strong></td>
            <td><?php if ($cotizacion[0]['igv'] == 0){
                if (isset($tarifaArtista[0]['precio'])){
                    echo $tarifaArtista[0]['precio'] + $precio;
                } else{
                    echo $precio;
                }
            } else if ($cotizacion[0]['igv'] == 1) {
                if (isset($tarifaArtista[0]['precio'])){
                    echo ($tarifaArtista[0]['precio'] + $precio) + $igv;
                }else{
                    echo $precio + $igv;
                }
            } ?></td>
        </tr>

    </table>
    <table class="datos-pagos">
        <tr style="background-color: #FFC000;">
            <td colspan="5" style="text-align: center; font-size: 14px;"><strong>MEDIOS DE PAGO</strong></td>
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
            <td colspan="5" style="text-align: start; font-size: 14px; text-decoration: underline; border: none;"><strong>TERMINOS Y CONDICIONES</strong></td>
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
            <td colspan="5">_________________________________</td>
        </tr>
        <tr>
            <td colspan="5">V° B° Vega Producciones S.A.C</td>
        </tr>
        <tr>
            <td colspan="5">RUC N° 20608627422</td>
        </tr>
    </table>
</div>