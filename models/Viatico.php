<?php

require_once 'ExecQuery.php';

class Viatico extends ExecQuery
{
  public function obtenerViatico($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM viaticos WHERE iddetalle_presentacion = ?");
      $sp->execute(
        array(    
          $params['iddetallepresentacion']
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerInfoViatico($params = []): array
  {
    try {
      $sp = parent::execQ("call sp_obtener_info_viatico (?)");
      $sp->execute(
        array(    
          $params['idviatico']
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  

  public function registrarViatico($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_viatico(@idviatico,?,?,?,?)');
      $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['pasaje'],
          $params['comida'],
          $params['viaje']          
        )
      );

      $respuesta = $pdo->query("SELECT @idviatico AS idviatico")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idviatico'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function actualizarViatico($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_viatico(?,?,?,?)");
      $rpt = $cmd->execute(
        array(
          $params['idviatico'],
          $params['pasaje'],
          $params['comida'],
          $params['viaje']
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

}
