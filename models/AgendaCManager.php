<?php

require_once 'ExecQuery.php';

class AgendaCManager extends ExecQuery
{

    public function registrarAgendaCManager($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_asignar_agenda_cmanager (@idagendacmanager,?,?)');
            $cmd->execute(
                array(
                    $params['idagendaeditor'],
                    $params['idusuariocmanager'],
                )
            );

            $respuesta = $pdo->query("SELECT @idagendacmanager AS idagendacmanager")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idagendacmanager'];
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    }

    public function obtenerCmanagerPorIdAgendaEditor($params = []): array
    {
        try {
            $cmd = parent::execQ("CALL sp_obtener_agenda_cmmanager (?)");
            $cmd->execute(array($params['idagendaeditor']));
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }
}
