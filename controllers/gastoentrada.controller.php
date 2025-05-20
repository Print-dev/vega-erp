<?php
require_once '../models/Gastos.php';
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
$gastos = new Gastos();


if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {

        /* case 'obtenerAreas':
            echo json_encode($nomina->obtenerAreas());
            break;

        case 'obtenerPersonaNumDocColaborador':
            $cleanData = [
                'numdoc'   => $nomina->limpiarCadena($_GET['numdoc']),
            ];
            echo json_encode($nomina->obtenerPersonaNumDocColaborador($cleanData));
            break;
 */

        case 'filtrarGastos':
            $cleanData = [
                'idproveedor' => empty($_GET['idproveedor']) ? null : $gastos->limpiarCadena($_GET['idproveedor']),
                'fgasto' => empty($_GET['fgasto']) ? null : $gastos->limpiarCadena($_GET['fgasto']),
            ];
            echo json_encode($gastos->filtrarGastos($cleanData));
            break;
    }
}


if (isset($_POST['operation'])) {
    switch ($_POST['operation']) {

        case 'registrarGastoEntrada':
            $cleanData = [
                'estadopago'      => $gastos->limpiarCadena($_POST['estadopago']) ? $gastos->limpiarCadena($_POST['estadopago']) : null,
                'fgasto'          => $gastos->limpiarCadena($_POST['fgasto']) ? $gastos->limpiarCadena($_POST['fgasto']) : null,
                'fvencimiento'    => $gastos->limpiarCadena($_POST['fvencimiento']) ? $gastos->limpiarCadena($_POST['fvencimiento']) : null,
                'tipo'            => $gastos->limpiarCadena($_POST['tipo']) ? $gastos->limpiarCadena($_POST['tipo']) : null,
                'concepto'        => $gastos->limpiarCadena($_POST['concepto']) ? $gastos->limpiarCadena($_POST['concepto']) : null,
                'subtipo'         => $gastos->limpiarCadena($_POST['subtipo']) ? $gastos->limpiarCadena($_POST['subtipo']) : null,
                'idproveedor'     => $gastos->limpiarCadena($_POST['idproveedor']) ? $gastos->limpiarCadena($_POST['idproveedor']) : null,
                'idcolaborador'   => $gastos->limpiarCadena($_POST['idcolaborador']) ? $gastos->limpiarCadena($_POST['idcolaborador']) : null,
                'gasto'           => $gastos->limpiarCadena($_POST['gasto']) ? $gastos->limpiarCadena($_POST['gasto']) : null,
                'cunitario'       => $gastos->limpiarCadena($_POST['cunitario']) ? $gastos->limpiarCadena($_POST['cunitario']) : null,
                'pagado'          => $gastos->limpiarCadena($_POST['pagado']) ? $gastos->limpiarCadena($_POST['pagado']) : null,
                'idproducto'      => $gastos->limpiarCadena($_POST['idproducto']) ? $gastos->limpiarCadena($_POST['idproducto']) : null,
                'cantidad'        => $gastos->limpiarCadena($_POST['cantidad']) ?  $gastos->limpiarCadena($_POST['cantidad']) : null,
                'unidades'        => $gastos->limpiarCadena($_POST['unidades']) ? $gastos->limpiarCadena($_POST['unidades']) : null,
                'formapago'       => $gastos->limpiarCadena($_POST['formapago']) ? $gastos->limpiarCadena($_POST['formapago']) : null,
                'cuenta'          => $gastos->limpiarCadena($_POST['cuenta']) ? $gastos->limpiarCadena($_POST['cuenta']) : null,
                'foliofactura'    => $gastos->limpiarCadena($_POST['foliofactura']) ? $gastos->limpiarCadena($_POST['foliofactura']) : null,
                'emision'         => $gastos->limpiarCadena($_POST['emision']) ? $gastos->limpiarCadena($_POST['emision']) : null,
                'descripcion'     => $gastos->limpiarCadena($_POST['descripcion']) ? $gastos->limpiarCadena($_POST['descripcion']) : null,
                'costofinal'      => $gastos->limpiarCadena($_POST['costofinal']) ? $gastos->limpiarCadena($_POST['costofinal']) : null,
                'egreso'          => $gastos->limpiarCadena($_POST['egreso']) ? $gastos->limpiarCadena($_POST['egreso']) : null,
                'montopdte'       => $gastos->limpiarCadena($_POST['montopdte']) ? $gastos->limpiarCadena($_POST['montopdte']) : null,
                'impuestos'       => $gastos->limpiarCadena($_POST['impuestos']) ? $gastos->limpiarCadena($_POST['impuestos']) : null,
                'costofinalunit'  => $gastos->limpiarCadena($_POST['costofinalunit']) ? $gastos->limpiarCadena($_POST['costofinalunit']) : null,
            ];

            $respuesta = ['idgastoentrada' => -1];

            $idgastoentrada = $gastos->registrarGastoEntrada($cleanData);

            if ($idgastoentrada > 0) {
                $respuesta['idgastoentrada'] = $idgastoentrada;
            }

            echo json_encode($respuesta);
            break;
    }
}
