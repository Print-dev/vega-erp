<?php

// Ruta al archivo de la clave privada, el certificado y el XML a firmar
$private_key_file = 'certificado/clave.pem';
$certificate_file = 'certificado/certificado_public.pem';
$xml_file = 'xmlprueba.xml';

// Cargar el archivo XML
$dom = new DOMDocument();
$dom->load($xml_file);

// Cargar la clave privada
$private_key = file_get_contents($private_key_file);
$private_key_resource = openssl_pkey_get_private($private_key);

// Cargar el certificado X.509
$certificate_content = file_get_contents($certificate_file);

// Eliminar las líneas de encabezado y pie del certificado PEM
$certificate_content = preg_replace('/-----BEGIN CERTIFICATE-----/', '', $certificate_content);
$certificate_content = preg_replace('/-----END CERTIFICATE-----/', '', $certificate_content);

// Codificar el certificado en base64
$base64_certificate = base64_encode($certificate_content);

// Buscar el nodo con Id="signatureKG"
$signatureNode = $dom->getElementById('signatureKG');

// Si no se encuentra el nodo, crear uno nuevo (si es necesario)
if (!$signatureNode) {
    $signatureNode = $dom->createElement('ds:Signature');
    $signatureNode->setAttribute('Id', 'signatureKG');
    $dom->documentElement->appendChild($signatureNode);  // Agregarlo al final del documento
}

// Crear el nodo ds:SignedInfo (información sobre la firma)
$signed_info = $dom->createElement('ds:SignedInfo');

// Crear los nodos CanonicalizationMethod y SignatureMethod
$canonicalization_method = $dom->createElement('ds:CanonicalizationMethod');
$canonicalization_method->setAttribute('Algorithm', 'http://www.w3.org/2001/10/xml-exc-c14n#');

$signature_method = $dom->createElement('ds:SignatureMethod');
$signature_method->setAttribute('Algorithm', 'http://www.w3.org/2001/04/xmldsig-more#rsa-sha256');

// Crear el nodo ds:Reference (el recurso que se firma)
$reference = $dom->createElement('ds:Reference');
$reference->setAttribute('URI', '#signatureKG');  // Referencia al ID de la firma

// Crear los nodos ds:Transforms y ds:Transform
$transforms = $dom->createElement('ds:Transforms');
$transform = $dom->createElement('ds:Transform');
$transform->setAttribute('Algorithm', 'http://www.w3.org/2000/09/xmldsig#enveloped-signature');
$transforms->appendChild($transform);

// Crear el nodo ds:DigestMethod
$digest_method = $dom->createElement('ds:DigestMethod');
$digest_method->setAttribute('Algorithm', 'http://www.w3.org/2000/09/xmldsig#sha1');

// Crear el nodo ds:DigestValue (valor del hash)
$digest_value = $dom->createElement('ds:DigestValue', '+pruib33lOapq6GSw58GgQLR8VGIGqANloj4EqB1cb4=');

// Anidar los elementos dentro de ds:Reference
$reference->appendChild($transforms);
$reference->appendChild($digest_method);
$reference->appendChild($digest_value);

// Agregar ds:Reference a ds:SignedInfo
$signed_info->appendChild($canonicalization_method);
$signed_info->appendChild($signature_method);
$signed_info->appendChild($reference);

// Agregar ds:SignedInfo al nodo ds:Signature
$signatureNode->appendChild($signed_info);

// Crear la firma digital usando OpenSSL
openssl_sign($dom->C14N(), $signature, $private_key_resource, OPENSSL_ALGO_SHA256);

// Crear el nodo ds:SignatureValue y agregar la firma digital
$signature_value = $dom->createElement('ds:SignatureValue', base64_encode($signature));
$signatureNode->appendChild($signature_value);

// Crear el nodo ds:KeyInfo y agregar el certificado X.509
$key_info = $dom->createElement('ds:KeyInfo');
$x509_data = $dom->createElement('ds:X509Data');
$x509_certificate = $dom->createElement('ds:X509Certificate', $base64_certificate);
$x509_data->appendChild($x509_certificate);
$key_info->appendChild($x509_data);

// Agregar ds:KeyInfo a la firma
$signatureNode->appendChild($key_info);

// Guardar el XML firmado
$dom->save('factura_firmada.xml');

echo "XML firmado exitosamente con el certificado. El archivo se ha guardado como 'factura_firmada.xml'.";
?>
