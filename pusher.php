<?php
require __DIR__ . '/vendor/autoload.php';

$pusher = new Pusher\Pusher(
    'a42e1daecb05c59ee961',
    '4a78613d3de4238fd83a',
    '1988345',
    [
        'cluster' => 'us2',
        'useTLS' => true
    ]
);

// Enviar evento
$pusher->trigger('canal-demo', 'evento-demo', ['mensaje' => '¡Hola desde PHP!']);
