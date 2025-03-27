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

    public function quitarResponsablePosteo($params = []): bool
    {
      try {
        $cmd = parent::execQ("CALL sp_quitar_responsable_posteo (?)");
        $eliminado = $cmd->execute(array(
          $params['idagendaeditor']
        ));
        return $eliminado;
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

    
    public function asignarPortalWebContenido($params = []): bool
    {
      try {
        $pdo = parent::getConexion();
        $cmd = $pdo->prepare('CALL sp_asignar_portal_web_contenido(?,?)');
        $act = $cmd->execute(
          array(
            $params['idagendacommanager'],
            $params['portalpublicar']
          )
        );
        
        return $act;
      } catch (PDOException $e) {
        // Registrar detalles del error en el log
        error_log("Error en registrarDetallePresentacion: " . $e->getMessage());
  
        // Retornar detalles del error
        die($e->getMessage());
      }
    }

    public function actualizarEstadoPublicarContenido($params = []): bool
    {
      try {
        $pdo = parent::getConexion();
        $cmd = $pdo->prepare('CALL sp_actualizar_estado_publicar_contenido(?,?)');
        $act = $cmd->execute(
          array(
            $params['idagendacommanager'],
            $params['estado']
          )
        );
        
        return $act;
      } catch (PDOException $e) {
        // Registrar detalles del error en el log
        error_log("Error en registrarDetallePresentacion: " . $e->getMessage());
  
        // Retornar detalles del error
        die($e->getMessage());
      }
    }
}
