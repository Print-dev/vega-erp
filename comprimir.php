<?php
$ruc = "20608627422";
$tipoDoc = "01"; // Factura
$serie = "F001";
$correlativo = "000001";

$nombreComprobante = "{$ruc}-{$tipoDoc}-{$serie}-{$correlativo}";
$xmlFilePath = __DIR__ . "/{$nombreComprobante}.xml";
$zipFilePath = __DIR__ . "/{$nombreComprobante}.zip";

// ✅ Crear el ZIP
$zip = new ZipArchive();
if ($zip->open($zipFilePath, ZipArchive::CREATE | ZipArchive::OVERWRITE) === TRUE) {
    // Añadir el archivo XML al ZIP (asegúrate que exista)
    if (file_exists($xmlFilePath)) {
        $zip->addFile($xmlFilePath, "{$nombreComprobante}.xml");
        $zip->close();
        echo "✅ ZIP generado correctamente: {$nombreComprobante}.zip\n";
    } else {
        echo "❌ El archivo XML no existe: {$xmlFilePath}\n";
        exit;
    }
} else {
    echo "❌ No se pudo crear el ZIP\n";
    exit;
}

// 🔍 Verificar contenido del ZIP
$zip = new ZipArchive();
if ($zip->open($zipFilePath) === true) {
    echo "📦 Contenido del ZIP:\n";
    for ($i = 0; $i < $zip->numFiles; $i++) {
        echo "- " . $zip->getNameIndex($i) . "\n";
    }
    $zip->close();
} else {
    echo "❌ No se pudo abrir el ZIP para ver el contenido\n";
}
