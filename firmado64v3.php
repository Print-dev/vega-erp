<?php
require 'vendor/autoload.php';

use RobRichards\XMLSecLibs\XMLSecEnc;
use RobRichards\XMLSecLibs\XMLSecurityDSig;
use RobRichards\XMLSecLibs\XMLSecurityKey;

class FirmadorSunat
{
    private $rutaCertificado;
    private $rutaClavePrivada;

    public function __construct($rutaCertificado, $rutaClavePrivada)
    {
        $this->rutaCertificado = $rutaCertificado;
        $this->rutaClavePrivada = $rutaClavePrivada;

        // Verificar existencia de archivos
        $this->validarArchivos();
    }

    private function validarArchivos()
    {
        if (!file_exists($this->rutaCertificado)) {
            throw new Exception("Certificado digital no encontrado en: " . $this->rutaCertificado);
        }

        if (!file_exists($this->rutaClavePrivada)) {
            throw new Exception("Clave privada no encontrada en: " . $this->rutaClavePrivada);
        }

        // Verificar la clave privada
        if (!openssl_pkey_get_private(file_get_contents($this->rutaClavePrivada))) {
            throw new Exception("La clave privada no es válida o está corrupta");
        }

        // Verificar el certificado
        if (!openssl_x509_read(file_get_contents($this->rutaCertificado))) {
            throw new Exception("El certificado no es válido o está corrupto");
        }

        // Verificar permisos de los archivos
        /* if (substr(sprintf('%o', fileperms($this->rutaClavePrivada)), -3) != '600') {
            throw new Exception("La clave privada debe tener permisos 600 (chmod 600)");
        } */
    }

    public function firmarFactura($xmlInputPath, $xmlOutputPath)
    {
        if (!file_exists($xmlInputPath)) {
            throw new Exception("Archivo XML de entrada no encontrado: " . $xmlInputPath);
        }

        $doc = new DOMDocument();
        $doc->load($xmlInputPath);

        if ($doc->documentElement->nodeName !== 'Invoice') {
            throw new Exception("El documento XML no es una factura UBL válida");
        }

        $objDSig = new XMLSecurityDSig('ds');
        $objDSig->setCanonicalMethod(XMLSecurityDSig::EXC_C14N);

        $objDSig->addReference(
            $doc,
            XMLSecurityDSig::SHA256,
            ['http://www.w3.org/2000/09/xmldsig#enveloped-signature'],
            [
                'force_uri' => true,
                'overwrite' => false,
                'id_name' => 'ID'
            ]
        );

        // ✅ Cargar la clave directamente desde el archivo
        $objKey = new XMLSecurityKey(XMLSecurityKey::RSA_SHA256, ['type' => 'private']);

        try {
            $objKey->loadKey($this->rutaClavePrivada, true);  // Aquí se pasa la ruta, no el contenido
        } catch (Exception $e) {
            throw new Exception("Error al cargar la clave privada: " . $e->getMessage());
        }

        $objDSig->sign($objKey);

        // ✅ Cargar el contenido del certificado (esto sí está bien con contenido)
        $certContent = file_get_contents($this->rutaCertificado);
        $objDSig->add509Cert($certContent, true, false);

        $this->insertarFirma($doc, $objDSig->sigNode);

        $doc->save($xmlOutputPath);

        return $xmlOutputPath;
    }

    private function insertarFirma($doc, $sigNode)
    {
        $xpath = new DOMXPath($doc);
        $xpath->registerNamespace('ext', 'urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2');

        // Importar nodo al documento si viene de otro DOM
        $sigNode = $doc->importNode($sigNode, true);

        // Buscar el último UBLExtensions
        $extensions = $xpath->query('//ext:UBLExtensions[last()]');

        if ($extensions->length > 0) {
            $extensions->item(0)->parentNode->insertBefore(
                $sigNode,
                $extensions->item(0)->nextSibling
            );
        } else {
            $doc->documentElement->insertBefore(
                $sigNode,
                $doc->documentElement->firstChild
            );
        }
    }
}

// Uso seguro del firmador
try {
    $firmador = new FirmadorSunat(
        'certificado/certificado_publico.pem',
        'certificado/clave.pem'
    );

    $resultado = $firmador->firmarFactura(
        'xmlprueba2.xml',
        '20608627422-01-F001-00000001.xml'
    );

    echo "Factura firmada correctamente: $resultado";
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage();
    // Aquí puedes agregar logging adicional
}

// Función para validar firma
/* function validarFirma($xmlPath, $certPath)
{
    $doc = new DOMDocument();
    $doc->load($xmlPath);

    $objDSig = new XMLSecurityDSig();
    $signatureNode = $objDSig->locateSignature($doc);

    if (!$signatureNode) {
        return false;
    }

    $objDSig->canonicalizeSignedInfo();
    $objDSig->idKeys = ['SignatureKM'];

    $key = $objDSig->locateKey();
    if (!$key) {
        return false;
    }

    $keyInfo = XMLSecEnc::staticLocateKeyInfo($key, $signatureNode);
    if (!$keyInfo) {
        return false;
    }

    // Comparar con el certificado proporcionado
    $certProvided = file_get_contents($certPath);
    $certInSignature = $keyInfo->getX509Certificate();

    return $objDSig->verify($key) && ($certInSignature === $certProvided);
}
 */