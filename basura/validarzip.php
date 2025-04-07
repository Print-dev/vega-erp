<?php

$zip = new ZipArchive;
if ($zip->open('20608627422-01-F001-00000001.zip') === TRUE) {
    echo "Archivos en el ZIP:\n";
    for ($i = 0; $i < $zip->numFiles; $i++) {
        echo "- " . $zip->getNameIndex($i) . "\n";
    }
    $zip->close();
} else {
    echo "❌ No se pudo abrir el ZIP.";
}
