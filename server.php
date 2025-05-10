
<?php
// servidor.php
date_default_timezone_set('America/Lima'); // o tu zona horaria correcta
error_reporting(E_ALL);
set_time_limit(0);
ob_implicit_flush();

function ws_handshake($client, $headers)
{
  if (preg_match('/Sec-WebSocket-Key: (.*)\r\n/', $headers, $matches)) {
    $key = base64_encode(sha1($matches[1] . '258EAFA5-E914-47DA-95CA-C5AB0DC85B11', true));
    $headers = "HTTP/1.1 101 Switching Protocols\r\n";
    $headers .= "Upgrade: websocket\r\n";
    $headers .= "Connection: Upgrade\r\n";
    $headers .= "Sec-WebSocket-Accept: $key\r\n\r\n";
    socket_write($client, $headers);
    return true;
  }
  return false;
}

function ws_decode($data)
{
  if (empty($data) || strlen($data) < 2) {
    return '';
  }

  $length = ord($data[1]) & 127;
  if ($length == 126) {
    $masks = substr($data, 4, 4);
    $data = substr($data, 8);
  } elseif ($length == 127) {
    $masks = substr($data, 10, 4);
    $data = substr($data, 14);
  } else {
    $masks = substr($data, 2, 4);
    $data = substr($data, 6);
  }

  $text = '';
  for ($i = 0; $i < strlen($data); ++$i) {
    $text .= $data[$i] ^ $masks[$i % 4];
  }
  return $text;
}

function ws_encode($text)
{
  $b1 = 0x80 | (0x1 & 0x0f);
  $length = strlen($text);

  if ($length <= 125)
    $header = pack('CC', $b1, $length);
  elseif ($length > 125 && $length < 65536)
    $header = pack('CCn', $b1, 126, $length);
  else
    $header = pack('CCNN', $b1, 127, $length);

  return $header . $text;
}

$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
socket_set_option($socket, SOL_SOCKET, SO_REUSEADDR, 1);
socket_bind($socket, '0.0.0.0', 8000);
socket_listen($socket);

$clients = [];
$client_ids = [];
$handshakes = [];
$nicknames = [];

echo "Servidor WebSocket iniciado en el puerto 8000...\n";

while (true) {
  $read = array_merge([$socket], $clients);
  $write = $except = null;

  if (socket_select($read, $write, $except, null) < 1) {
    continue;
  }

  if (in_array($socket, $read)) {
    $client = socket_accept($socket);
    $clients[] = $client;

    $socket_id = spl_object_hash($client);
    $client_ids[$socket_id] = uniqid('client_');
    $handshakes[$client_ids[$socket_id]] = false;

    echo "Nuevo cliente conectado: " . $client_ids[$socket_id] . "\n";
    $key = array_search($socket, $read);
    unset($read[$key]);
  }

  foreach ($read as $read_socket) {
    $data = @socket_read($read_socket, 2048);
    $socket_id = spl_object_hash($read_socket);

    if ($data === false || $data === '') {
      $client_id = $client_ids[$socket_id];
      if (isset($nicknames[$client_id])) {
        $nickname = $nicknames[$client_id];
        $response = json_encode([
          'type' => 'system',
          'message' => "$nickname se ha desconectado"
        ]);

        foreach ($clients as $client) {
          $current_socket_id = spl_object_hash($client);
          if (
            $client != $read_socket &&
            isset($client_ids[$current_socket_id]) &&
            isset($handshakes[$client_ids[$current_socket_id]]) &&
            $handshakes[$client_ids[$current_socket_id]]
          ) {
            socket_write($client, ws_encode($response));
          }
        }

        echo "$nickname se ha desconectado\n";
        unset($nicknames[$client_id]);
      }

      $key = array_search($read_socket, $clients);
      unset($clients[$key]);
      unset($handshakes[$client_ids[$socket_id]]);
      unset($client_ids[$socket_id]);
      continue;
    }

    $client_id = $client_ids[$socket_id];

    if (!$handshakes[$client_id]) {
      if (ws_handshake($read_socket, $data)) {
        $handshakes[$client_id] = true;
        echo "Handshake completado para cliente: $client_id\n";
      }
      continue;
    }

    $message = ws_decode($data);
    if (!empty($message)) {
      $decoded = json_decode($message, true);

      if ($decoded !== null) {
        if ($decoded['type'] === 'notificacion') {
          $response = json_encode([
            'idusuario' => $decoded['idusuario'],
            'type' => 'notificacion',
            /* 'idusuariodest' => $decoded['idusuariodest'],
              'idusuariorem' => $decoded['idusuariorem'],
              'tipo' => $decoded['tipo'],
              'idreferencia' => $decoded['idreferencia'], */
            'mensaje' => $decoded['mensaje']
          ]);

          foreach ($clients as $client) {
            if ($client !== $read_socket) { // No reenviar al emisor
              socket_write($client, ws_encode($response));
            }
          }
        }
        else if ($decoded['type'] === 'evento') {
          $response = json_encode([
            'idusuario' => $decoded['idusuario'],
            'type' => 'evento',
            /* 'idusuariodest' => $decoded['idusuariodest'],
              'idusuariorem' => $decoded['idusuariorem'],
              'tipo' => $decoded['tipo'],
              'idreferencia' => $decoded['idreferencia'], */
            'mensaje' => $decoded['mensaje']
          ]);

          foreach ($clients as $client) {
            if ($client !== $read_socket) { // No reenviar al emisor
              socket_write($client, ws_encode($response));
            }
          }
        }
        else if ($decoded['type'] === 'asignacion filmmaker') {
          $response = json_encode([
            'idusuario' => $decoded['idusuario'],
            'type' => 'asignacion filmmaker',
            /* 'idusuariodest' => $decoded['idusuariodest'],
              'idusuariorem' => $decoded['idusuariorem'],
              'tipo' => $decoded['tipo'],
              'idreferencia' => $decoded['idreferencia'], */
            'mensaje' => $decoded['mensaje']
          ]);

          foreach ($clients as $client) {
            if ($client !== $read_socket) { // No reenviar al emisor
              socket_write($client, ws_encode($response));
            }
          }
        }
        else if ($decoded['type'] === 'viatico') {
          $response = json_encode([
            'idusuario' => $decoded['idusuario'],
            'type' => 'viatico',
            /* 'idusuariodest' => $decoded['idusuariodest'],
              'idusuariorem' => $decoded['idusuariorem'],
              'tipo' => $decoded['tipo'],
              'idreferencia' => $decoded['idreferencia'], */
            'mensaje' => $decoded['mensaje']
          ]);

          foreach ($clients as $client) {
            if ($client !== $read_socket) { // No reenviar al emisor
              socket_write($client, ws_encode($response));
            }
          }
        }
        else if ($decoded['type'] === 'propuesta') {
          $response = json_encode([
            'idusuario' => $decoded['idusuario'],
            'type' => 'propuesta',
            /* 'idusuariodest' => $decoded['idusuariodest'],
              'idusuariorem' => $decoded['idusuariorem'],
              'tipo' => $decoded['tipo'],
              'idreferencia' => $decoded['idreferencia'], */
            'mensaje' => $decoded['mensaje']
          ]);

          foreach ($clients as $client) {
            if ($client !== $read_socket) { // No reenviar al emisor
              socket_write($client, ws_encode($response));
            }
          }
        }
        else if ($decoded['type'] === 'entradas') {
          $response = json_encode([
            'idusuario' => $decoded['idusuario'],
            'type' => 'entradas',
            /* 'idusuariodest' => $decoded['idusuariodest'],
              'idusuariorem' => $decoded['idusuariorem'],
              'tipo' => $decoded['tipo'],
              'idreferencia' => $decoded['idreferencia'], */
            'mensaje' => $decoded['mensaje']
          ]);

          foreach ($clients as $client) {
            if ($client !== $read_socket) { // No reenviar al emisor
              socket_write($client, ws_encode($response));
            }
          }
        }
      }
    }
  }

  usleep(100000);
}

socket_close($socket);
