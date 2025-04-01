<?php

$wsdl = "https://e-factura.sunat.gob.pe/ol-ti-itcpfegem/billService?wsdl";
$client = new SoapClient($wsdl, [
    'trace' => 1,
    'exceptions' => true,
    'soap_version' => SOAP_1_1,
]);

// Datos de autenticación (RUC + usuario SOL)
$ruc = "20608627422";
$usuario = "NEGOVEGA";
$clave = "VegaSAC2068";
$zipBase64 = base64_encode(file_get_contents("factura.zip"));

$params = [
    'fileName' => '20608627422-01-F001-00001234.zip', // Formato: RUC-TipoSerie-Numero
    'contentFile' => $zipBase64
];

$response = $client->__soapCall("sendBill", [$params], [
    'login' => "$ruc$usuario",
    'password' => $clave,
]);

// Guardar CDR (Constancia de Recepción)
file_put_contents("cdr.zip", base64_decode($response->applicationResponse));

echo "Factura enviada correctamente.";
