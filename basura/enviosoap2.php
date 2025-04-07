<?php

function enviarZipASunat(
    $rutaZip,
    $nombreArchivoSinExtension,
    $ruc,
    $usuarioSol,
    $claveSol,
    $ambiente = 'beta' // 'beta' o 'produccion'
) {
    $urlSunat = $ambiente === 'produccion'
        ? 'https://e-factura.sunat.gob.pe/ol-ti-itcpfegem/billService'
        : 'https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService';

    $wsdl = $urlSunat . '?wsdl';

    // Cargar contenido del ZIP
    if (!file_exists($rutaZip)) {
        die("❌ Archivo ZIP no encontrado: $rutaZip");
    }
    $contenidoZip = file_get_contents($rutaZip);
    $archivoBase64 = base64_encode($contenidoZip);

    // Crear encabezado WS-Security
    $usuario = $ruc . $usuarioSol;
    $pass = $claveSol;

    $ns = 'http://schemas.xmlsoap.org/ws/2002/12/secext';
    $headerVars = [
        'UsernameToken' => [
            'Username' => new SoapVar($usuario, XSD_STRING, null, $ns, null, $ns),
            'Password' => new SoapVar($pass, XSD_STRING, null, $ns, null, $ns)
        ]
    ];
    $header = new SoapHeader($ns, 'Security', $headerVars, true);

    // Crear cliente SOAP
    $params = [
        'trace' => true,
        'exceptions' => true,
        'cache_wsdl' => WSDL_CACHE_NONE,
        'soap_version' => SOAP_1_1,
    ];

    try {
        $client = new SoapClient($wsdl, $params);
        $client->__setSoapHeaders([$header]);

        // Llamar al método sendBill
        $respuesta = $client->sendBill([
            'fileName' => $nombreArchivoSinExtension . '.zip',
            'contentFile' => $archivoBase64
        ]);

        // Procesar respuesta (CDR en base64)
        $cdrZip = $respuesta->applicationResponse;
        $nombreCDR = 'R-' . $nombreArchivoSinExtension . '.zip';
        file_put_contents($nombreCDR, $cdrZip);

        echo "✅ Enviado correctamente a SUNAT.\n";
        echo "📦 CDR guardado como: $nombreCDR\n";
    } catch (SoapFault $e) {
        echo "❌ Error al enviar a SUNAT:\n";
        echo "Código: " . $e->faultcode . "\n";
        echo "Mensaje: " . $e->faultstring . "\n";

        // Debug opcional
        // echo "Request:\n" . $client->__getLastRequest() . "\n";
        // echo "Response:\n" . $client->__getLastResponse() . "\n";
    }
}

enviarZipASunat(
    '20608627422-01-F001-00000001.zip',
    '20608627422-01-F001-00000001',
    '20608627422',
    'NEGOVEGA',
    'VegaSAC2068',
    'beta'
);
