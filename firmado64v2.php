<?php
require 'vendor/autoload.php';

use RobRichards\XMLSecLibs\XMLSecurityDSig;
use RobRichards\XMLSecLibs\XMLSecurityKey;

// Cargar el XML
$xmlFile = 'xmlbase.xml';
$xml = new DOMDocument();
$xml->preserveWhiteSpace = false;
$xml->formatOutput = false; // Cambiado a false para evitar cambios en espacios en blanco
$xml->load($xmlFile);

// Agregar ID al elemento raíz Invoice antes de cualquier modificación
$rootNode = $xml->documentElement;
$rootNode->setAttribute('Id', 'SignSUNAT');

// Buscar el nodo ExtensionContent
$xpath = new DOMXPath($xml);
$xpath->registerNamespace('ext', 'urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2');
$extensionContentNode = $xpath->query('//ext:ExtensionContent')->item(0);

if (!$extensionContentNode) {
    die("No se encontró el nodo <ext:ExtensionContent>");
}

// Crear firma
$objDSig = new XMLSecurityDSig();
// Usar el método de canonicalización exacto que espera SUNAT
$objDSig->setCanonicalMethod(XMLSecurityDSig::EXC_C14N);

// Crear un nodo Signature dentro de ExtensionContent
$signatureNode = $xml->createElementNS('http://www.w3.org/2000/09/xmldsig#', 'ds:Signature');
$extensionContentNode->appendChild($signatureNode);

// Establecer este nodo como el nodo de firma para XMLSecurityDSig
//$objDSig->setIdAttributes(['Id' => 'SignSUNAT'], $rootNode);
$rootNode->setIdAttribute('Id', true);


// Agregar la referencia con el ID específico
$referenceNodeID = 'SignSUNAT';
$objDSig->addReference(
    $xml,
    XMLSecurityDSig::SHA1,
    [
        'http://www.w3.org/2000/09/xmldsig#enveloped-signature',
        'http://www.w3.org/TR/2001/REC-xml-c14n-20010315'
    ],
    [
        'id' => 'Reference-' . $referenceNodeID,
        'uri' => '#' . $referenceNodeID,
        'force_uri' => true
    ]
);

// Cargar clave privada
$objKey = new XMLSecurityKey(XMLSecurityKey::RSA_SHA1, ['type' => 'private']);
$objKey->loadKey('certificado/clave.pem', true);

// Iniciar la firma
$objDSig->sign($objKey, $signatureNode);

// Agregar el certificado
$cert = file_get_contents('certificado/certificado_publico.pem');
$objDSig->add509Cert($cert, true, false, null, 'ds');

// Eliminar nodos existentes para evitar duplicación
$signatureParent = $signatureNode->parentNode;
$signatureParent->removeChild($signatureNode);

// Regenerar la firma limpia
$newSignatureNode = $objDSig->appendSignature($extensionContentNode);

// Asegurarse que los namespace están correctamente declarados
if ($newSignatureNode instanceof DOMElement) {
    $newSignatureNode->setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
}
// Asegurarse que el Reference URI es correcto
$referenceNode = $xpath->query('//ds:Reference', $newSignatureNode)->item(0);
if ($referenceNode instanceof DOMElement) {
    $referenceNode->setAttribute('URI', '#SignSUNAT');  // Aquí se establece el URI si el nodo es un DOMElement
} else {
    die("El nodo <ds:Reference> no es un DOMElement.");
}

// NO formatear la salida para evitar alteraciones en espacios en blanco
$xml->formatOutput = false;

// Guardar el documento firmado
$xmlOutput = $xml->saveXML();

// Guardar en archivo evitando que se modifique el contenido después de firmado
file_put_contents('20608627422-01-F001-00000001.xml', $xmlOutput);
echo "XML firmado correctamente con formato SUNAT.\n";
