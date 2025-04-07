<?php

$doc = new DOMDocument();
$doc->load('20608627422-01-F001-000001.xml');

$signatureNode = $doc->getElementsByTagName('Signature')->item(0);
$signatureNode->parentNode->removeChild($signatureNode);

$canonical = $doc->C14N();
$digest = base64_encode(sha1($canonical, true));
echo "Digest postfirma: $digest\n";
