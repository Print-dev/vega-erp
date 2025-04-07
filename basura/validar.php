<?php

$xmlFile = '20608627422-01-F001-00000001.xml';
$xsdFile = 'archivosxsd/maindoc/UBL-Invoice-2.1.xsd'; // Ruta al XSD principal

$dom = new DOMDocument();
$dom->preserveWhiteSpace = false;
$dom->formatOutput = true;
$dom->load($xmlFile);

// Activa los errores internos de libxml
libxml_use_internal_errors(true);

if ($dom->schemaValidate($xsdFile)) {
    echo "✅ El XML es válido según el esquema de SUNAT.";
} else {
    echo "❌ El XML NO es válido. Errores:\n";
    foreach (libxml_get_errors() as $error) {
        echo "- Línea {$error->line}: {$error->message}";
    }
    libxml_clear_errors();
}
