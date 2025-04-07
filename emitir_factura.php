<?php

require 'vendor/autoload.php';

use Greenter\See;
use Greenter\Ws\Services\SunatEndpoints;

// Crear instancia de See
$see = new See();

// Cargar el certificado digital
$see->setCertificate(file_get_contents(__DIR__.'/certificate.pem'));

// Seleccionar el endpoint de SUNAT Beta
$see->setService(SunatEndpoints::FE_BETA);

// Establecer credenciales SOL (RUC, Usuario, Clave)
$see->setClaveSOL('20000000001', 'MODDATOS', 'moddatos');

// Puedes retornar $see o seguir con la lógica
return $see;
