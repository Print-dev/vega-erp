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
        background: url('http://localhost/vega-erp/images/cotizacion/calvay/watermark.jpg') no-repeat center;
        background-size: 100% 100%;
        /* Ocupa toda la hoja */
        /* Ajusta la transparencia */
        z-index: -1;
    }

    /* Tabla de datos del cliente */
    .datos-terminos-condiciones {
        width: 70%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;
        text-align: justify;
        margin-top: 200px;
        font-weight: normal;
    }

    .datos-terminos-condiciones td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
        font-size: 12px;
    }

    .datos-firma {
        width: 80%;
        margin: 20px auto;
        /* Centrar y dar espacio debajo del header */
        border-collapse: collapse;
        font-size: 11px;
        margin-top: 130px;

    }

    .datos-firma td {
        border: 1px solid black;
        padding: 4px;
        border-color: #FFC000;
        border: none;
        text-align: right;
        font-size: 13px;
    }

    .firmas{
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
        background-color: #FFC000;
        /* Ajusta el margen izquierdo */
    }

    .header-right {
        background-color: green;
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
    
    .label {
        font-weight: bold;
        width: 30%;
    }
</style>

<!-- Encabezado centrado -->
<div class="watermark">
    <table class="datos-terminos-condiciones">
        <tr>
            <td colspan="5" style="text-align: center; font-size: 14px; text-decoration: underline; border: none;"><strong>CONTRATO CONVENIO</strong></td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
            En la fecha se reúnen de una parte Negociaciones y producciones Vega S.A.C, con RUC N°
20608627422, debidamente representado por su gerente general Nayade Liz Vega Pascual
identificada con DNI. N.º 47842296, según el registro de personas jurídicas de Lima, a quién en
adelante se le denominará EL REPRESENTANTE de AZUCENA CALVAY Y ORQUESTA; y de la otra
parte: Mercedes Vanessa Lay Diaz, con DNI 40754619, con domicilio en Av. Chancay, Lote 25,
en calidad de LA ORGANIZADORA del evento; ambas partes con el propósito de celebrar el
presente contrato en los términos siguientes:
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
            PRIMERO: EL ORGANIZADOR contrata los servicios artísticos de AZUCENA CALVAY Y ORQUESTA
para una presentación para el día 21 de diciembre del 2024, por 3 horas de SHOW de 11:00
P.M. a 1:00 A.M. en la Discoteca “Coco bongo Huaral”, provincia de Huaral, departamento de
Lima.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
            SEGUNDO: Que EL REPRESENTANTE en forma de Convenio, acuerda con EL ORGANIZADOR que
el objeto del presente será ejecutado en porcentajes (50 % CADA UNO) iguales a beneficio de
ambos sin IGV; siendo que LA ORGANIZADORA deberá abonar en forma de Garantía el monto
de S/. 5,000.00 (CINCO MIL CON 100/100) el cual deberá ser dado en efectivo o por
transferencia bancaria a la cuenta BCP N° 1929842849014 o CCI N° 00219200984284901432 a
nombre de EL REPRESENTANTE, y será contabilizado al cálculo de la liquidación.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
            TERCERO: LA ORGANIZADORA se responsabiliza de tramitar todos los permisos y garantías
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
            CUARTO: En caso de suspensión del evento, debe ser notificado a EL PRESENTANTE con una
antelación mínima de 7 días, de ninguna manera dará lugar a la devolución de la Garantía.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
            QUINTO: En caso de rescisión del presente contrato por incumplimiento de una de las partes
ésta no causará un reintegro por concepto de indemnización y/o reembolso.
Leído que fue el presente y estando ambas partes de acuerdo con lo estipulado lo suscriben
para su debido cumplimiento.
            </td>
        </tr>
        <tr>
            <td class="label" colspan="5" style="border: none;">
            Lima, 16 de diciembre del 2024.
            </td>
        </tr>

    </table>
    <table class="firmas">
        <tr>
        <td class="header-left">
    <table class="datos-firma ">
        <tr>
            <td colspan="5">EL REPRESENTANTE</td>
        </tr>
        <tr>
            <td colspan="5">_________________________________</td>
        </tr>
        <tr>
            <td colspan="5">Mercedes Vanessa Lay Diaz</td>
        </tr>
        <tr>
            <td colspan="5">DNI. 40754619</td>
        </tr>
        <tr>
            <td colspan="5">EL ORGANIZADOR</td>
        </tr>
    </table>
    </td class="header-right">
    <table class="datos-firma ">
        <tr>
            <td colspan="5">EL REPRESENTANTE</td>
        </tr>
        <tr>
            <td colspan="5">_________________________________</td>
        </tr>
        <tr>
            <td colspan="5">Mercedes Vanessa Lay Diaz</td>
        </tr>
        <tr>
            <td colspan="5">DNI. 40754619</td>
        </tr>
        <tr>
            <td colspan="5">EL ORGANIZADOR</td>
        </tr>
    </table>
    </td>
        </tr>
    </table>
</div>