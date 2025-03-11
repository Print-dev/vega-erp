
<?php
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos

if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {
        case 'obtenerLongLatPorCiudad':
            $provincia = $_GET['provincia'] ?? '';

            if (empty($provincia)) {
                echo json_encode(['error' => 'provincia requerida']);
                exit();
            }

            $api_url = "https://nominatim.openstreetmap.org/search?q={$provincia}&format=json";

            // Usar cURL para hacer la solicitud
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $api_url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // Desactivar validación SSL si es necesario
            $response = curl_exec($ch);
            curl_close($ch);

            // Devolver la respuesta al frontend
            echo $response;

        case 'obtenerDuracionDeViaje':
            $lon_origen = $_GET['lon_origen'] ?? '';
            $lat_origen = $_GET['lat_origen'] ?? '';
            $lon_destino = $_GET['lon_destino'] ?? '';
            $lat_destino = $_GET['lat_destino'] ?? '';

            $api_url = "https://router.project-osrm.org/route/v1/driving/{$lon_origen},{$lat_origen};{$lon_destino},{$lat_destino}?overview=false";

            // Usar cURL para hacer la solicitud
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $api_url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // Desactivar validación SSL si es necesario
            $response = curl_exec($ch);
            curl_close($ch);

            // Devolver la respuesta al frontend
            echo $response;
        
    }
}
