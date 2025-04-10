

<?php
require_once '../models/Empresa.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$empresa = new Empresa();
// ag order by
if(isset($_GET['operation'])){
  switch($_GET['operation']){

    case 'obtenerDatosEmpresa':
        echo json_encode($empresa->obtenerDatosEmpresa());
        break;
    
  }
}

if (isset($_POST['operation'])) {
    switch ($_POST['operation']) {
        

        case 'actualizarDatosEmpresa':
            $cleanData = [
                'idempresa'   => $empresa->limpiarCadena($_POST['idempresa']),
                'ruc'   => $empresa->limpiarCadena($_POST['ruc']),
                'logoempresa'   => $empresa->limpiarCadena($_POST['logoempresa']),
                'razonsocial'   => $empresa->limpiarCadena($_POST['razonsocial']),
                'nombrecomercial'   => $empresa->limpiarCadena($_POST['nombrecomercial']),
                'nombreapp'   => $empresa->limpiarCadena($_POST['nombreapp']),
                'direccion'   => $empresa->limpiarCadena($_POST['direccion']),
                'web'   => $empresa->limpiarCadena($_POST['web']),
                'usuariosol'   => $empresa->limpiarCadena($_POST['usuariosol']),
                'clavesol'   => $empresa->limpiarCadena($_POST['clavesol']),
                'certificado'   => $empresa->limpiarCadena($_POST['certificado'])
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
