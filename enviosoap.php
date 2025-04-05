<?php
// Datos del contribuyente
$ruc = "20608627422";
$usuarioSol = "NEGOVEGA"; // Usuario secundario SOL
$claveSol = "VegaSAC2068";               // Clave del usuario secundario

// Archivo ZIP con el XML firmado
$nombreArchivo = "20608627422-01-F001-00000001";
$ruc = "20608627422";
$usuarioSol = "NEGOVEGA";
$claveSol = "VegaSAC2068"; 

// Codificar ZIP en base64 directamente desde archivo
$zipData = file_get_contents($zipFile);
$zipBase64 = base64_encode($zipData);

// Definir el cuerpo SOAP con la misma estructura
$soap = <<<XML
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:ser="http://service.sunat.gob.pe"
                  xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
    <soapenv:Header>
        <wsse:Security>
            <wsse:UsernameToken>
                <wsse:Username>{$ruc}{$usuarioSol}</wsse:Username>
                <wsse:Password>{$claveSol}</wsse:Password>
            </wsse:UsernameToken>
        </wsse:Security>
    </soapenv:Header>
    <soapenv:Body>
        <ser:sendBill>
            <fileName>{$nombreArchivo}.zip</fileName>
            <contentFile>{$zipBase64}</contentFile>
        </ser:sendBill>
    </soapenv:Body>
</soapenv:Envelope>
XML;

// URL del servicio (beta)
$url = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService";

// Encabezados HTTP
$headers = [
    "Content-Type: text/xml; charset=utf-8",
    "SOAPAction: \"\"",
    "Content-Length: " . strlen($soap),
];

// Enviar solicitud con cURL
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_POSTFIELDS, $soap);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

$response = curl_exec($ch);

if (curl_errno($ch)) {
    echo "❌ Error en cURL: " . curl_error($ch);
} else {
    // Guardar la respuesta SOAP
    file_put_contents("respuesta_soap.xml", $response);
    
    if (strpos($response, 'applicationResponse') !== false) {
        preg_match('/<applicationResponse>(.*?)<\/applicationResponse>/s', $response, $matches);
        $cdrBase64 = $matches[1] ?? '';
        if ($cdrBase64) {
            $cdrZip = base64_decode($cdrBase64);
            file_put_contents("R-{$nombreArchivo}.zip", $cdrZip);
            echo "✅ Enviado a SUNAT. CDR guardado como R-{$nombreArchivo}.zip";
        } else {
            echo "❌ SUNAT respondió pero no se encontró el CDR.";
        }
    } else {
        echo "❌ Error en respuesta SOAP: " . $response;
    }
}

curl_close($ch);
