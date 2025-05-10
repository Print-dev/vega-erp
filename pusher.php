<?php
date_default_timezone_set('America/Lima'); // o tu zona horaria correcta

require __DIR__ . '/vendor/autoload.php';
header('Content-Type: application/json');

$pusher = new Pusher\Pusher(
    'a42e1daecb05c59ee961',
    '4a78613d3de4238fd83a',
    '1988345',
    [
        'cluster' => 'us2',
        'useTLS' => true
    ]
);

// Obtener los datos del cliente (ej. con fetch POST)
$data = json_decode(file_get_contents("php://input"), true);

// Enviar evento
// Lógica: canal general "canal-notificaciones", tipo de evento como nombre de evento
$pusher->trigger('canal-notificaciones', $data['type'], [
    'idusuario' => $data['idusuario'],
    'mensaje' => $data['mensaje']
]);

echo json_encode(['status' => 'ok']);
