<?php
// Configuración
$ruc = "20608627422";
$usuarioSol = "NEGOVEGA";
$claveSol = "VegaSAC2068";
$archivoZip = "20608627422-01-F001-1.zip";
$contenidoZip = file_get_contents($archivoZip);
$nombreArchivoZip = basename($archivoZip);

// Crear el XML de la solicitud SOAP
$soapRequest = <<<XML
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.sunat.gob.pe">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:sendBill>
         <fileName>$nombreArchivoZip</fileName>
         <contentFile><![CDATA[" . base64_encode($contenidoZip) . "]]></contentFile>
         <party>
            <ruc>$ruc</ruc>
            <user>$usuarioSol</user>
            <password>$claveSol</password>
         </party>
      </ser:sendBill>
   </soapenv:Body>
</soapenv:Envelope>
XML;

// Configuración de la conexión SOAP
$ch = curl_init("https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $soapRequest);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    "Content-Type: text/xml; charset=utf-8",
    "Content-Length: " . strlen($soapRequest),
]);

// Ejecutar la solicitud
$response = curl_exec($ch);
curl_close($ch);

// Guardar la respuesta de SUNAT
file_put_contents("respuesta_sunat.xml", $response);

echo "Respuesta recibida de SUNAT y guardada en respuesta_sunat.xml";
