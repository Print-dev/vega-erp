<?php
$ruc = "20608627422";
$usuarioSol = "NEGOVEGA"; // Reemplaza si usas PRODUCCIÓN
$claveSol = "VegaSAC2068";   // Reemplaza si usas PRODUCCIÓN

$nombreArchivo = "20608627422-01-F001-000001";
$zipFile = $nombreArchivo . ".zip";

// Leer contenido del ZIP en base64
$zipContent = file_get_contents($zipFile);
$zipBase64 = base64_encode($zipContent);

// URL de SUNAT (Beta o Producción)
$wsdl = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService?wsdl"; // Cambia si usas Producción

// Configurar cliente SOAP
$client = new SoapClient($wsdl, [
    'cache_wsdl' => WSDL_CACHE_NONE,
    'trace' => 1,
    'exceptions' => true,
    'soap_version' => SOAP_1_1,
]);

$params = [
    'fileName' => $zipFile,
    'contentFile' => $zipBase64,
];

try {
    // Autenticación con RUC y SOL
    $header = new SoapHeader(
        'http://schemas.xmlsoap.org/ws/2003/06/secext',
        'Security',
        new SoapVar(
            '
            <wsse:UsernameToken xmlns:wsse="http://schemas.xmlsoap.org/ws/2003/06/secext">
                <wsse:Username>' . $usuarioSol . '</wsse:Username>
                <wsse:Password>' . $claveSol . '</wsse:Password>
            </wsse:UsernameToken>',
            XSD_ANYXML
        )
    );
    $client->__setSoapHeaders([$header]);

    // Enviar ZIP a SUNAT
    $response = $client->sendBill($params);

    // Guardar CDR (respuesta)
    $cdrZipName = "R-" . $zipFile;
    file_put_contents($cdrZipName, $response->applicationResponse);

    echo "✅ Enviado correctamente. CDR guardado como: $cdrZipName\n";
} catch (SoapFault $e) {
    echo "❌ Error al enviar: " . $e->getMessage() . "\n";
    if (isset($client)) {
        echo "📩 Última solicitud:\n" . $client->__getLastRequest() . "\n";
        echo "📨 Última respuesta:\n" . $client->__getLastResponse() . "\n";
    }
}