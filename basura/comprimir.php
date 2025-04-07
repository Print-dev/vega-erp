<?php
$zip = new ZipArchive();
$nombreZip = '20608627422-01-F001-00000001.zip';
$xmlFirmado = '20608627422-01-F001-00000001.xml';

if ($zip->open($nombreZip, ZipArchive::CREATE) === true) {
    $zip->addFile($xmlFirmado, $xmlFirmado); // importante que el nombre interno coincida
    $zip->close();
    echo "✅ ZIP creado correctamente.\n";
} else {
    echo "❌ Error al crear el ZIP\n";
}
