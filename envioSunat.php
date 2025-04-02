<?php
// Cargar el XML de la factura
$xmlFile = 'factura.xml'; // Ruta de tu archivo XML
$xml = new DOMDocument;
$xml->load($xmlFile);

// Cargar el XSL de validación
$xslFile = 'ValidaExprRegFactura-2.0.1.xsl'; // Ruta del archivo XSL
$xsl = new DOMDocument;
$xsl->load($xslFile);

// Configurar el procesador XSLT
$proc = new XSLTProcessor;
$proc->importStylesheet($xsl);

// Aplicar la transformación XSL al XML
$result = $proc->transformToXML($xml);

// Mostrar el resultado de la validación
if ($result === false) {
    echo "Error: La validación falló.";
} else {
    echo "Validación completada con éxito.\n";
    echo $result; // Esto mostrará los posibles errores encontrados
}
?>
<?php
// Cargar el XML de la factura
$xmlFile = 'factura.xml'; // Ruta de tu archivo XML
$xml = new DOMDocument;
$xml->load($xmlFile);

// Cargar el XSL de validación
$xsl = new DOMDocument;
$xslFile = "C:\\xampp\\htdocs\\vega-erp\\validaciones\\ValidaExprRegFactura-2.0.1.xsl";
$xsl->load($xslFile);

// Configurar el procesador XSLT
$proc = new XSLTProcessor;
$proc->importStylesheet($xsl);

// Aplicar la transformación XSL al XML
$result = $proc->transformToXML($xml);

// Mostrar el resultado de la validación
if ($result === false) {
    echo "Error: La validación falló.";
} else {
    echo "Validación completada con éxito.\n";
    echo $result; // Esto mostrará los posibles errores encontrados
}
?>
