<?php

// Ruta al archivo de la clave privada, el certificado y el XML a firmar
$private_key_file = 'certificado/clave.pem';
$certificate_file = 'certificado/certificado_publico.pem';
$xml_file = 'xmlprueba.xml';

// Cargar el archivo XML
$dom = new DOMDocument();
$dom->preserveWhiteSpace = false;
$dom->formatOutput = true;
$dom->load($xml_file);

// Cargar la clave privada
$private_key = file_get_contents($private_key_file);
$private_key_resource = openssl_pkey_get_private($private_key);

// Cargar el certificado X.509
$certificate_content = file_get_contents($certificate_file);

// Eliminar las líneas de encabezado y pie del certificado PEM
$certificate_content = preg_replace('/-----BEGIN CERTIFICATE-----/', '', $certificate_content);
$certificate_content = preg_replace('/-----END CERTIFICATE-----/', '', $certificate_content);
$certificate_content = trim($certificate_content); // Limpiar espacios innecesarios

// Codificar el certificado en base64
$base64_certificate = base64_encode($certificate_content);

// Buscar el nodo <ext:ExtensionContent>
$xpath = new DOMXPath($dom);
$extensionContentNode = $xpath->query('//ext:ExtensionContent')->item(0);

if ($extensionContentNode) {
    // Crear el nodo ds:Signature
    $signatureNode = $dom->createElement('ds:Signature');
    $signatureNode->setAttribute('Id', 'signatureKG');

    // Crear el nodo ds:SignedInfo
    $signed_info = $dom->createElement('ds:SignedInfo');

    // CanonicalizationMethod
    $canonicalization_method = $dom->createElement('ds:CanonicalizationMethod');
    $canonicalization_method->setAttribute('Algorithm', 'http://www.w3.org/TR/2001/REC-xml-c14n20010315#WithComments');

    // SignatureMethod
    $signature_method = $dom->createElement('ds:SignatureMethod');
    $signature_method->setAttribute('Algorithm', 'http://www.w3.org/2000/09/xmldsig#dsa-sha1');

    // Reference
    $reference = $dom->createElement('ds:Reference');
    $reference->setAttribute('URI', '');

    // Transforms
    $transforms = $dom->createElement('ds:Transforms');
    $transform = $dom->createElement('ds:Transform');
    $transform->setAttribute('Algorithm', 'http://www.w3.org/2000/09/xmldsig#envelopedsignature');
    $transforms->appendChild($transform);

    // DigestMethod
    $digest_method = $dom->createElement('ds:DigestMethod');
    $digest_method->setAttribute('Algorithm', 'http://www.w3.org/2000/09/xmldsig#sha1');

    // DigestValue
    $digest_value = $dom->createElement('ds:DigestValue', '+pruib33lOapq6GSw58GgQLR8VGIGqANloj4EqB1cb4=');

    // Estructura de ds:Reference
    $reference->appendChild($transforms);
    $reference->appendChild($digest_method);
    $reference->appendChild($digest_value);

    // Estructura de ds:SignedInfo
    $signed_info->appendChild($canonicalization_method);
    $signed_info->appendChild($signature_method);
    $signed_info->appendChild($reference);

    // Agregar ds:SignedInfo a ds:Signature
    $signatureNode->appendChild($signed_info);

    // Firmar el documento
    openssl_sign($dom->C14N(), $signature, $private_key_resource, OPENSSL_ALGO_SHA256);
    $signature_value = $dom->createElement('ds:SignatureValue', base64_encode($signature));
    $signatureNode->appendChild($signature_value);

    // Agregar certificado
    $key_info = $dom->createElement('ds:KeyInfo');
    $x509_data = $dom->createElement('ds:X509Data');
    $x509_certificate = $dom->createElement('ds:X509Certificate', $base64_certificate);
    $x509_data->appendChild($x509_certificate);
    $key_info->appendChild($x509_data);

    // Agregar ds:KeyInfo a ds:Signature
    $signatureNode->appendChild($key_info);

    // Insertar <ds:Signature> después de <ext:ExtensionContent>
    if ($extensionContentNode->parentNode) {
        $extensionContentNode->appendChild($signatureNode);
    }

    // Guardar el XML firmado
    $dom->save('20608627422-01-F001-000001.xml');

    echo "XML firmado exitosamente. Guardado como 'factura_firmada.xml'.";
} else {
    echo "Error: No se encontró <ext:ExtensionContent> en el XML.";
}

?>
