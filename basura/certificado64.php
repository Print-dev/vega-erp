<?php

$certPath = "certificado/certificado.pem";  // Ruta del certificado

// Leer el certificado
$certContent = file_get_contents($certPath);

// Eliminar las cabeceras y pies del certificado (-----BEGIN CERTIFICATE----- y -----END CERTIFICATE-----)
$certContent = preg_replace(["/\n/", "/-----BEGIN CERTIFICATE-----/", "/-----END CERTIFICATE-----/"], "", $certContent);

// Codificar el certificado en Base64
$certContentBase64 = base64_encode($certContent);

// Mostrar el certificado codificado en Base64 en consola
echo "Certificado codificado en Base64: \n";
echo $certContentBase64;
