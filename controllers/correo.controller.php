

<?php
header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require '../vendor/autoload.php';

$mail = new PHPMailer(true);


/* $empresa = new Empresa();
// ag order by
if (isset($_GET['operation'])) {
    switch ($_GET['operation']) {

        case 'obtenerDatosEmpresa':
            echo json_encode($empresa->obtenerDatosEmpresa());
            break;
    }
} */

if (isset($_POST['operation'])) {
    switch ($_POST['operation']) {
        case 'solicitarCodigoParaCambiarContrasena':
            try {
                $codigo = rand(100000, 999999);

                //Server settings
                $nombreApp = !empty($_POST['nombreapp']) ? trim($_POST['nombreapp']) : "Vega Producciones";
                $contrasenaApp = !empty($_POST['contrasenagmailapp']) ? trim($_POST['contrasenagmailapp']) : "xmcofazbzqjhkrzs";
                $remitente = !empty($_POST['remitente']) ? trim($_POST['remitente']) : "alexisjkg@gmail.com";
                $destinatario = !empty($_POST['destinatario']) ? trim($_POST['destinatario']) : null;

                $mail->SMTPDebug = 0; //SMTP::DEBUG_SERVER;                      //Enable verbose debug output
                $mail->isSMTP();                                            //Send using SMTP
                $mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
                $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
                $mail->Username = $remitente;
                $mail->Password = $contrasenaApp;                              //SMTP password
                $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
                $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`
                //xmcofazbzqjhkrzs
                //Recipients
                $mail->setFrom($remitente, $nombreApp);
                $mail->addAddress($destinatario);

                // Contenido del correo
                $mail->isHTML(true);
                $mail->Subject = 'Código para cambiar tu contraseña';
                $mail->Body = "
                    <html>
                    <head>
                        <style>
                            .codigo {
                                font-size: 24px;
                                font-weight: bold;
                                color: #2c3e50;
                            }
                            .contenedor {
                                font-family: Arial, sans-serif;
                                background-color: #f4f4f4;
                                padding: 20px;
                                border-radius: 10px;
                                max-width: 500px;
                                margin: auto;
                            }
                        </style>
                    </head>
                    <body>
                        <div class='contenedor'>
                            <h2>Solicitud de cambio de contraseña</h2>
                            <p>Hola, has solicitado cambiar tu contraseña. Usa el siguiente código para continuar:</p>
                            <p class='codigo'>$codigo</p>
                            <p>Si no solicitaste este cambio, ignora este mensaje.</p>
                        </div>
                    </body>
                    </html>
                ";

                $mail->AltBody = "Hola, has solicitado cambiar tu contraseña. Código: $codigo";

                $mail->send();
                // Puedes devolver el código si lo necesitas guardar en sesión o base de datos (por seguridad, no se debe mostrar en frontend directamente)
                echo json_encode(['status' => 'success', 'message' => 'Correo enviado', 'codigo' => $codigo]);
            } catch (Exception $e) {
                echo json_encode(['status' => 'error', 'message' => "Error al enviar el correo: {$mail->ErrorInfo}"]);
            }
            break;
    }
}
