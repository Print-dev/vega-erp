<?php

function comprimirXML($nombreXML) {
    // Asegurarse que el archivo XML existe
    if (!file_exists($nombreXML . '.xml')) {
        return false;
    }
    
    $zip = new ZipArchive();
    $nombreZip = $nombreXML . '.zip';
    
    // Crear el archivo ZIP
    if ($zip->open($nombreZip, ZipArchive::CREATE) === TRUE) {
        // Importante: añadir el archivo con el mismo nombre dentro del ZIP
        $zip->addFile($nombreXML . '.xml', $nombreXML . '.xml');
        $zip->close();
        
        // Verificar que el ZIP se creó correctamente
        if (file_exists($nombreZip)) {
            return $nombreZip;
        }
    }
    
    return false;
}

comprimirXML('20608627422-01-F001-00000001');