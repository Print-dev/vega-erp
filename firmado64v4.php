<?php

require_once 'vendor/autoload.php';

use RobRichards\XMLSecLibs\XMLSecurityDSig;
use RobRichards\XMLSecLibs\XMLSecurityKey;

function firmarXMLFacturaSunat($rutaXML, $rutaClavePEM, $rutaCertificadoPEM, $rutaXMLFirmado)
{
    // Cargar XML
    $doc = new DOMDocument();
    $doc->preserveWhiteSpace = false;
    $doc->formatOutput = false;
    $doc->load($rutaXML);

    // Crear firma digital
    $objDSig = new XMLSecurityDSig();
    $objDSig->setCanonicalMethod(XMLSecurityDSig::EXC_C14N);

    // Agrega referencia del documento (Firma envolvente)
    $objDSig->addReference(
        $doc,
        XMLSecurityDSig::SHA1,
        ['http://www.w3.org/2000/09/xmldsig#enveloped-signature'],
        ['force_uri' => true]
    );

    // Cargar clave privada
    $objKey = new XMLSecurityKey(XMLSecurityKey::RSA_SHA1, ['type' => 'private']);
    $objKey->loadKey($rutaClavePEM, true); // true = clave privada

    // 🔒 Firmar el XML (solo una vez)
    $objDSig->sign($objKey);

    // 📄 Cargar el certificado
    $cert = file_get_contents($rutaCertificadoPEM);

    // 📌 Agregar el atributo Id="SignatureKG" al nodo de firma
    $objDSig->sigNode->setAttribute("Id", "SignatureKG");

    // 🧷 Insertar certificado (ahora sí, después de firmar)
    $objDSig->add509Cert($cert, true, false, null, 'ds');

    // 🔍 Buscar el nodo <ext:ExtensionContent>
    $nodoExtension = $doc->getElementsByTagNameNS(
        'urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2',
        'ExtensionContent'
    )->item(0);

    if (!$nodoExtension) {
        die('❌ No se encontró el nodo <ext:ExtensionContent>.');
    }

    // 🧩 Insertar firma en el nodo de extensión
    $objDSig->appendSignature($nodoExtension);

    // 💾 Guardar XML firmado
    $doc->save($rutaXMLFirmado);
    echo "✅ XML firmado correctamente en: $rutaXMLFirmado\n";
}


// USO:
firmarXMLFacturaSunat(
    'xmlprueba4.xml',
    'certificado/clave.pem',
    'certificado/certificado_publico.pem',
    '20608627422-01-F001-00000001.xml'
);
