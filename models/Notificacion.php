<?php

require_once 'ExecQuery.php';

class Notificacion extends ExecQuery
{

    /* public function registrarNotificacionViatico($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_registrar_notificacion_viatico(@idnotificacion_viatico,?,?,?)');
            $cmd->execute(
                array(
                    $params['idviatico'],
                    $params['filmmaker'],
                    $params['mensaje']
                )
            );

            $respuesta = $pdo->query("SELECT @idnotificacion_viatico AS idnotificacion_viatico")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idnotificacion_viatico'];
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    } */
    public function registrarNotificacion($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_registrar_notificacion(@idnotificacion,?,?,?,?,?)');
            $cmd->execute(
                array(
                    $params['idusuariodest'],
                    $params['idusuariorem'],
                    $params['tipo'],
                    $params['idreferencia'],
                    $params['mensaje'],
                )
            );

            $respuesta = $pdo->query("SELECT @idnotificacion AS idnotificacion")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idnotificacion'];
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    }
    

   /*  public function obtenerNotificacionesViatico(): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM notificaciones_viatico");
      $sp->execute();
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  } */
    public function obtenerNotificaciones($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM notificaciones WHERE idusuariodest = ? ORDER BY idnotificacion DESC LIMIT 4" );
      $sp->execute(
        array(
          $params["idusuariodest"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerTodasLasNotificaciones($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM notificaciones WHERE idusuariodest = ? ORDER BY idnotificacion DESC" );
      $sp->execute(
        array(
          $params["idusuariodest"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
    
}
