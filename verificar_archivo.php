<?php

$zip = new ZipArchive();
$zip->open('20608627422-01-F001-000001.zip', ZipArchive::CREATE | ZipArchive::OVERWRITE);
$zip->addFile('20608627422-01-F001-000001.xml', '20608627422-01-F001-000001.xml');
$zip->close();