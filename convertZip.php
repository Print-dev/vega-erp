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

function comprimirXML($xmlFilePath, $zipFilePath)
{
    $zip = new ZipArchive();
    if ($zip->open($zipFilePath, ZipArchive::CREATE) === true) {
        $xmlFileName = basename($xmlFilePath); // solo el nombre sin ruta
        $zip->addFile($xmlFilePath, $xmlFileName);
        $zip->close();
        return true;
    } else {
        return false;
    }
}
