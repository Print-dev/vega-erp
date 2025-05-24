    

<?php
require_once '../models/Empresa.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
require '../vendor/autoload.php';

use Cloudinary\Cloudinary;
use Cloudinary\Configuration\Configuration;

$empresa = new Empresa();
// ag order by
if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {

        case 'obtenerDatosEmpresa':
            echo json_encode($empresa->obtenerDatosEmpresa());
            break;

        case 'obtenerCorreoEmpresa':
            echo json_encode($empresa->obtenerCorreoEmpresa());
            break;
    }
}

if (isset($_POST['operation'])) {
    switch ($_POST['operation']) {


        case 'actualizarDatosEmpresa':
            $cloudinary = new Cloudinary([
                'cloud' => [
                    'cloud_name' => 'dynpy0r4v',
                    'api_key'    => '722279687758731',
                    'api_secret' => 'KsLk7dNUAAjRYEBNUsv2JAV7cPI'
                ],
                'url' => ['secure' => true]
            ]);

            // PUBLIC_ID actuales
            $logoAntiguo = $_POST['logoempresaAntiguo'] ?? '';

            $secureUrlLogo = $logoAntiguo;

            // Si se sube nueva marca de agua
            if (isset($_FILES['logoempresa']) && $_FILES['logoempresa']['error'] === UPLOAD_ERR_OK) {
                if (!empty($logoAntiguo)) {
                    $cloudinary->uploadApi()->destroy($logoAntiguo);
                }
                $uploadResultMarcaAgua = $cloudinary->uploadApi()->upload(
                    $_FILES['logoempresa']['tmp_name'],
                    ['folder' => 'logo_vegaproducciones']
                );
                $secureUrlLogo = $uploadResultMarcaAgua['public_id'] ?? '';
            }
        

            $cleanData = [
                'idempresa'   => $empresa->limpiarCadena($_POST['idempresa']),
                'ruc'   => $empresa->limpiarCadena($_POST['ruc']),
                'logoempresa'   => $secureUrlLogo,
                'razonsocial'   => $empresa->limpiarCadena($_POST['razonsocial']),
                'nombrecomercial'   => $empresa->limpiarCadena($_POST['nombrecomercial']),
                'nombreapp'   => $empresa->limpiarCadena($_POST['nombreapp']),
                'direccion'   => $empresa->limpiarCadena($_POST['direccion']),
                'web'   => $empresa->limpiarCadena($_POST['web']),
                /* 'usuariosol'   => $empresa->limpiarCadena($_POST['usuariosol']),
                'clavesol'   => $empresa->limpiarCadena($_POST['clavesol']),
                'certificado'   => $empresa->limpiarCadena($_POST['certificado']), */
                'correo'   => $empresa->limpiarCadena($_POST['correo']),
                'contrasenagmailapp'   => $empresa->limpiarCadena($_POST['contrasenagmailapp']),
                'ncuenta'   => $empresa->limpiarCadena($_POST['ncuenta']),
                'ncci'   => $empresa->limpiarCadena($_POST['ncci']),
                'banco'   => $empresa->limpiarCadena($_POST['banco']),
                'moneda'   => $empresa->limpiarCadena($_POST['moneda']),
            ];

            $rpt = $empresa->actualizarDatosEmpresa($cleanData);

            echo json_encode($rpt);
            break;

            /*  case 'registrarDetalleComprobante':
            $cleanData = [
                'idcomprobante'   => $comprobante->limpiarCadena($_POST['idcomprobante']),
                'estado ' => $comprobante->limpiarCadena($_POST['estado ']),
                'info'   => $comprobante->limpiarCadena($_POST['info'])
            ];

            $rpt = $comprobante->registrarItemComprobante($cleanData);

            echo json_encode($rpt);
            break; */
    }
}
