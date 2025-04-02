<?php

// Cargar la clave privada desde el archivo clave.pem
$clavePrivada = file_get_contents('certificado/clave.pem');
$privateKeyId = openssl_pkey_get_private($clavePrivada);

// Cargar el certificado desde el archivo certificado.pem
$certificado = file_get_contents('certificado/certificado.pem');

// Cargar el archivo XML que quieres firmar
$xml = new DOMDocument();
$xml->load('20123456789-01-F001-1_c14.xml'); // Cargar el XML

// Obtener el nodo SignedInfo del XML para firmar
$signedInfoNode = $xml->getElementsByTagName('SignedInfo')->item(0);
$canonicalSignedInfo = $signedInfoNode->C14N(true, false); // Canonicalizar la estructura

// Firmar el contenido de SignedInfo usando la clave privada
openssl_sign($canonicalSignedInfo, $signature, $privateKeyId, OPENSSL_ALGO_SHA256);

// Codificar la firma en base64 e insertarla en el XML
$signatureBase64 = base64_encode($signature);
$signatureNode = $xml->getElementsByTagName('SignatureValue')->item(0);
$signatureNode->nodeValue = $signatureBase64;

// Insertar el certificado en el XML en formato base64
$certificadoBase64 = base64_encode($certificado);
$certificadoX509Node = $xml->getElementsByTagName('X509Certificate')->item(0);
$certificadoX509Node->nodeValue = $certificadoBase64;

// Guardar el XML firmado
$xml->save('factura_firmada.xml');

echo "XML firmado correctamente y guardado como 'factura_firmada.xml'";
