<?php
require 'vendor/autoload.php';

use RobRichards\XMLSecLibs\XMLSecurityDSig;
use RobRichards\XMLSecLibs\XMLSecurityKey;

// Ruta del XML sin firmar
$xmlInputPath = 'xmlprueba4.xml';
// Ruta donde se guardará el XML firmado
$xmlSignedPath = '20608627422-01-F001-00000001.xml';
// Ruta de la clave privada (en formato .pem)
$privateKeyPath = 'certificado/clave.pem';
// Ruta del certificado público (en formato .pem)
$publicCertPath = 'certificado/certificado_publico.pem';

// Cargar el XML
$doc = new DOMDocument('1.0', 'UTF-8');
$doc->preserveWhiteSpace = false;
$doc->formatOutput = false;
$doc->load($xmlInputPath);

// Buscar el nodo donde se insertará la firma (por ejemplo, dentro de <ExtensionContent>)
$extNodes = $doc->getElementsByTagName('ExtensionContent');
if ($extNodes->length === 0) {
    die('No se encontró el nodo <ExtensionContent> para insertar la firma.');
}
$signatureParentNode = $extNodes->item(0);

// Crear el objeto de firma
$objDSig = new XMLSecurityDSig('ds');
$objDSig->setCanonicalMethod(XMLSecurityDSig::EXC_C14N);

// Referenciar el contenido del documento y usar SHA-256
$objDSig->addReference(
    $doc,
    XMLSecurityDSig::SHA256,
    ['http://www.w3.org/2000/09/xmldsig#enveloped-signature'],
    ['id_name' => null, 'overwrite' => false]
);

// Crear clave privada para firmar
$objKey = new XMLSecurityKey(XMLSecurityKey::RSA_SHA256, ['type'=>'private']);
$objKey->loadKey($privateKeyPath, true);

// Si tu clave tiene passphrase:
// $objKey->passphrase = 'mi_contraseña_secreta';

// Generar la firma
$objDSig->sign($objKey);

// Agregar el certificado público
$objDSig->add509Cert(file_get_contents($publicCertPath), true, false, ['subjectName' => true]);

// Insertar la firma en el nodo adecuado
$objDSig->appendSignature($signatureParentNode, true);

// Guardar el XML firmado
$doc->save($xmlSignedPath);

echo "XML firmado correctamente: {$xmlSignedPath}\n";
