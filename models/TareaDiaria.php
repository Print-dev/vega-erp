
<?php

require_once 'ExecQuery.php';

class TareaDiaria extends ExecQuery
{

    public function asignarTareaDiaria($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_asignar_tarea_diaria (@idtaradiariaasig,?,?,?,?)');
            $cmd->execute(
                array(
                    $params['idusuario'],
                    $params['idtareadiaria'],
                    $params['fechaentrega'],
                    $params['horaentrega'],
                )
            );


            $respuesta = $pdo->query("SELECT @idtaradiariaasig AS idtaradiariaasig")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idtaradiariaasig'];
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    }

    public function registrarTareaDiaria($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_registrar_tarea_diaria (@idtareadiaria,?)');
            $cmd->execute(
                array(
                    $params['tarea']
                )
            );


            $respuesta = $pdo->query("SELECT @idtareadiaria AS idtareadiaria")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idtareadiaria'];
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    }

    public function obtenerTareas(): array
    {
        try {
            $sp = parent::execQ("SELECT * FROM tareas_diarias");
            $sp->execute();
            return $sp->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }

    public function obtenerTareasDiariasPorUsuario($params = []): array
    {
        try {
            $sp = parent::execQ("CALL sp_obtener_tareas_diarias_por_usuario (?)");
            $sp->execute(array(
                $params['idusuario']
            ));
            return $sp->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }

    public function actualizarEstadoTareaDiariaAsignacion($params = []): bool
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare("CALL sp_actualizar_estado_tarea_diaria_asignacion(?, ?)");
            $rpt = $cmd->execute(
                array(
                    $params['idtaradiariaasig'],
                    $params['estado']
                )
            );
            return $rpt;
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return false;
        }
    }
}
