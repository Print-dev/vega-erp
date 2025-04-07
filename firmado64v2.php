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
/* file_put_contents('20608627422-01-F001-00000001.xml', $xmlOutput);
echo "XML firmado correctamente con formato SUNAT.\n";
 */
$ruc = '20608627422';
$tipoDoc = '01'; // 01 = Factura
$serie = 'F001';
$correlativo = '00000001';
$nombreArchivo = "{$ruc}-{$tipoDoc}-{$serie}-{$correlativo}";

// Guardar en archivo XML
$xmlFilePath = "{$nombreArchivo}.xml";
file_put_contents($xmlFilePath, $xmlOutput);

// NUEVA PARTE: Comprimir en ZIP
$zipFilePath = "{$nombreArchivo}.zip";

// Crear archivo ZIP
$zip = new ZipArchive();
if ($zip->open($zipFilePath, ZipArchive::CREATE) !== TRUE) {
    die("No se pudo crear el archivo ZIP");
}

// Agregar el XML al ZIP manteniendo solo el nombre, sin ruta
$zip->addFile($xmlFilePath, basename($xmlFilePath));
$zip->close();

echo "XML firmado y comprimido correctamente.\n";

// NUEVA PARTE: Enviar a SUNAT vía SOAP
// Credenciales para SUNAT
$usuarioSol = 'USUARIO_SOL'; // Reemplazar con tu usuario SOL
$claveSol = 'CLAVE_SOL';     // Reemplazar con tu clave SOL
$rucEmisor = $ruc;

// URL del servicio SOAP de SUNAT (usar la URL correcta según ambiente)
// URL para desarrollo/pruebas
$wsdlURL = 'https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService?wsdl';
// URL para producción
// $wsdlURL = 'https://e-factura.sunat.gob.pe/ol-ti-itcpfegem/billService?wsdl';

try {
    // Configuración de la solicitud SOAP
    $soapClient = new SoapClient($wsdlURL, [
        'trace' => true,
        'cache_wsdl' => WSDL_CACHE_NONE
    ]);

    // Leer el archivo ZIP como contenido binario
    $zipContent = file_get_contents($zipFilePath);
    $zipContentBase64 = base64_encode($zipContent);

    // Preparar parámetros para el servicio sendBill
    $params = [
        'fileName' => "{$nombreArchivo}.zip",
        'contentFile' => $zipContentBase64,
        'partyType' => ''
    ];

    // Credenciales para la autenticación
    $soapHeaders = [
        new SoapHeader(
            'http://service.sunat.gob.pe',
            'UserCredentials',
            [
                'username' => "{$rucEmisor}{$usuarioSol}",
                'password' => $claveSol
            ]
        )
    ];

    // Establecer los encabezados SOAP
    $soapClient->__setSoapHeaders($soapHeaders);

    // Llamar al método sendBill
    $response = $soapClient->sendBill($params);

    // Procesar la respuesta
    if ($response && isset($response->applicationResponse)) {
        // La respuesta es un CDR (Constancia de Recepción) en Base64
        $cdrContent = base64_decode($response->applicationResponse);

        // Guardar el CDR
        $cdrZipPath = "R-{$nombreArchivo}.zip";
        file_put_contents($cdrZipPath, $cdrContent);

        // Extraer el contenido del CDR ZIP
        $zipCdr = new ZipArchive();
        if ($zipCdr->open($cdrZipPath) === TRUE) {
            $cdrXmlName = $zipCdr->getNameIndex(0); // Obtener el nombre del primer archivo
            $extractPath = "./";
            $zipCdr->extractTo($extractPath);
            $zipCdr->close();

            echo "CDR recibido y extraído correctamente: {$extractPath}{$cdrXmlName}\n";

            // Leer el contenido del XML del CDR para verificar estado
            $cdrXml = new DOMDocument();
            $cdrXml->load("{$extractPath}{$cdrXmlName}");

            $cdrXpath = new DOMXPath($cdrXml);
            $cdrXpath->registerNamespace('cac', 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2');
            $cdrXpath->registerNamespace('cbc', 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2');

            // Obtener el código de respuesta
            $responseCode = $cdrXpath->query('//cbc:ResponseCode')->item(0)->nodeValue;
            $description = $cdrXpath->query('//cbc:Description')->item(0)->nodeValue;

            echo "Resultado: Código {$responseCode} - {$description}\n";
        } else {
            echo "Error al extraer el CDR ZIP\n";
        }
    } else {
        echo "No se recibió una respuesta válida de SUNAT\n";
    }
} catch (SoapFault $fault) {
    echo "Error SOAP: " . $fault->getMessage() . "\n";
    echo "Faultcode: " . $fault->faultcode . "\n";
    echo "Detail: " . print_r($fault->detail, true) . "\n";
} catch (Exception $e) {
    echo "Error general: " . $e->getMessage() . "\n";
}

echo "Proceso completado.\n";
