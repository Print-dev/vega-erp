<?php

$zip = new ZipArchive();
$zipFileName = '20608627422-01-F001-1.zip'; // Nombre del archivo ZIP
$xmlFileName = 'factura_firmada.xml'; // Nombre del XML firmado

if ($zip->open($zipFileName, ZipArchive::CREATE) === TRUE) {
    $zip->addFile($xmlFileName, basename($xmlFileName));
    $zip->close();
    echo "Archivo ZIP generado correctamente: $zipFileName";
} else {
    echo "Error al crear el archivo ZIP";
}
