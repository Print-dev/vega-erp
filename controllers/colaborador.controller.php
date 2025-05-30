<?php

require '../vendor/autoload.php';

use Cloudinary\Cloudinary;
use Cloudinary\Configuration\Configuration;

require_once '../models/Colaborador.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$colaborador = new Colaborador();


if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {
        case 'obtenerCargos':
            echo json_encode($colaborador->obtenerCargos());
            break;

        case 'obtenerFichaColaborador':
            $cleanData = [
                'idnomina'   => $colaborador->limpiarCadena($_GET['idnomina']),
            ];
            echo json_encode($colaborador->obtenerFichaColaborador($cleanData));
            break;
    }
}


if (isset($_POST['operation'])) {
    switch ($_POST['operation']) {

        case 'registrarColaborador':
            $cleanData = [
                'idpersonacolaborador'   => $colaborador->limpiarCadena($_POST['idpersonacolaborador']),
                'camisa'   => $colaborador->limpiarCadena($_POST['camisa']),
                'pantalon'   => $colaborador->limpiarCadena($_POST['pantalon']),
                'zapatos'   => $colaborador->limpiarCadena($_POST['zapatos']),
            ];

            $respuesta = ['idcolaborador' => -1];

            $idcolaborador = $colaborador->registrarColaborador($cleanData);

            if ($idcolaborador > 0) {
                $respuesta['idcolaborador'] = $idcolaborador;
            }

            echo json_encode($respuesta);
            break;

        case 'registrarCargo':
            $cleanData = [
                'cargo'   => $colaborador->limpiarCadena($_POST['cargo'])
            ];

            $rpt = $colaborador->registrarCargo($cleanData);

            echo json_encode($rpt);
            break;

        case 'registrarPersonaColaborador':
            $cloudinary = new Cloudinary([
                'cloud' => [
                    'cloud_name' => 'dynpy0r4v',
                    'api_key'    => '722279687758731',
                    'api_secret' => 'KsLk7dNUAAjRYEBNUsv2JAV7cPI'
                ],
                'url' => [
                    'secure' => true
                ]
            ]);

            // Variables por defecto
            $secureUrlFotoColaborador = $_POST['publicIdFotoColaboradorAnterior'] ?? '';

            // Subir marca de agua si existe
            if (isset($_FILES['foto']) && $_FILES['foto']['error'] === UPLOAD_ERR_OK) {
                $uploadResultFotoColaboradorUrl = $cloudinary->uploadApi()->upload(
                    $_FILES['foto']['tmp_name'],
                    ['folder' => 'fotocolaboradores_vegaproducciones']
                );
                $secureUrlFotoColaborador = $uploadResultFotoColaboradorUrl['public_id'] ?? '';
            }

            $cleanData = [
                'nombreapellidos'   => $colaborador->limpiarCadena($_POST['nombreapellidos']),
                'dni'   => $colaborador->limpiarCadena($_POST['dni']),
                'fnacimiento'   => $colaborador->limpiarCadena($_POST['fnacimiento']),
                'estadocivil'   => $colaborador->limpiarCadena($_POST['estadocivil']),
                'sexo'   => $colaborador->limpiarCadena($_POST['sexo']),
                'domicilio'   => $colaborador->limpiarCadena($_POST['domicilio']),
                'correo'   => $colaborador->limpiarCadena($_POST['correo']),
                'nivelestudio'   => $colaborador->limpiarCadena($_POST['nivelestudio']),
                'contactoemergencia'   => $colaborador->limpiarCadena($_POST['contactoemergencia']),
                'discapacidad'   => $colaborador->limpiarCadena($_POST['discapacidad']),
                'foto'   => $secureUrlFotoColaborador ? $secureUrlFotoColaborador : ''
            ];

            $respuesta = ['idpersonacolaborador' => -1];

            $idpersonacolaborador = $colaborador->registrarPersonaColaborador($cleanData);

            if ($idpersonacolaborador > 0) {
                $respuesta['idpersonacolaborador'] = $idpersonacolaborador;
            }

            echo json_encode($respuesta);
            break;
    }
}
