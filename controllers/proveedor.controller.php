<?php
require_once '../models/Proveedor.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$proveedor = new Proveedor();
// ag order by
if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {
        case 'obtenerProveedorPorId':
            echo json_encode($proveedor->obtenerProveedorPorId(['idproveedor' => $_GET['idproveedor']]));
            break;

        case 'filtrarProveedores':
            $cleanData = [
                'nombre' => empty($_GET['nombre']) ? null : $proveedor->limpiarCadena($_GET['nombre']),
                'dni' => empty($_GET['dni']) ? null : $proveedor->limpiarCadena($_GET['dni']),
            ];
            echo json_encode($proveedor->filtrarProveedores($cleanData));
            break;

            //
    }
}
if (isset($_POST['operation'])) {
    switch ($_POST['operation']) {
        case 'registrarProveedor':
            $cleanData = [
                'empresa'   => $proveedor->limpiarCadena($_POST['empresa']) ? $proveedor->limpiarCadena($_POST['empresa']) : '',
                'nombre'   => $proveedor->limpiarCadena($_POST['nombre']) ? $proveedor->limpiarCadena($_POST['nombre']) : '',
                'contacto' => $proveedor->limpiarCadena($_POST['contacto']) ? $proveedor->limpiarCadena($_POST['contacto']) : '',
                'correo'   => $proveedor->limpiarCadena($_POST['correo']) ? $proveedor->limpiarCadena($_POST['correo']) : '',
                'dni'    => $proveedor->limpiarCadena($_POST['dni']) ? $proveedor->limpiarCadena($_POST['dni']) : '',
                'banco' => $proveedor->limpiarCadena($_POST['banco']) ? $proveedor->limpiarCadena($_POST['banco']) : '',
                'ctabancaria'  => $proveedor->limpiarCadena($_POST['ctabancaria']) ? $proveedor->limpiarCadena($_POST['ctabancaria']) : '',
                'servicio' => $proveedor->limpiarCadena($_POST['servicio']) ? $proveedor->limpiarCadena($_POST['servicio']) : '',
                'nproveedor'    => $proveedor->limpiarCadena($_POST['nproveedor']) ? $proveedor->limpiarCadena($_POST['nproveedor']) : '',
            ];

            $respuesta = ['idproveedor' => -1];

            $idproveedor = $proveedor->registrarProveedor($cleanData);

            if ($idproveedor > 0) {
                $respuesta['idproveedor'] = $idproveedor;
            }

            echo json_encode($respuesta);
            break;

        case 'actualizarProveedor':
            $cleanData = [
                'idproveedor' => $proveedor->limpiarCadena($_POST['idproveedor']) ? $proveedor->limpiarCadena($_POST['idproveedor']) : '',
                'empresa' => $proveedor->limpiarCadena($_POST['empresa']) ? $proveedor->limpiarCadena($_POST['empresa']) : '',
                'nombre' => $proveedor->limpiarCadena($_POST['nombre']) ? $proveedor->limpiarCadena($_POST['nombre']) : '',
                'contacto' => $proveedor->limpiarCadena($_POST['contacto']) ? $proveedor->limpiarCadena($_POST['contacto']) : '',
                'correo' => $proveedor->limpiarCadena($_POST['correo']) ? $proveedor->limpiarCadena($_POST['correo']) : '',
                'dni' => $proveedor->limpiarCadena($_POST['dni']) ? $proveedor->limpiarCadena($_POST['dni']) : '',
                'banco' => $proveedor->limpiarCadena($_POST['banco']) ? $proveedor->limpiarCadena($_POST['banco']) : '',
                'ctabancaria' => $proveedor->limpiarCadena($_POST['ctabancaria']) ? $proveedor->limpiarCadena($_POST['ctabancaria']) : '',
                'servicio' => $proveedor->limpiarCadena($_POST['servicio']) ? $proveedor->limpiarCadena($_POST['servicio']) : '',
                'nproveedor' => $proveedor->limpiarCadena($_POST['nproveedor']) ? $proveedor->limpiarCadena($_POST['nproveedor']) : '',
            ];

            $respuesta = ['update' => false];

            $update = $proveedor->actualizarProveedor($cleanData);

            if ($update) {
                $respuesta['update'] = true;
            }
            echo json_encode($respuesta);
            break;
    }
}
