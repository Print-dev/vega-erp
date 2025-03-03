<?php

require_once 'ExecQuery.php';

class Tarifario extends ExecQuery
{
  public function obtenerTarifasPorProvincia($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_obtener_tarifario_por_provincia(?) ");
      $sp->execute(
        array(    
          $params['iddepartamento'],
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
  
  public function filtrarTarifas($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_search_tarifa_artista(?)");
      $sp->execute(
        array(    
          $params['nomusuario'],
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
  
  public function registrarTarifa($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_tarifa(@idtarifario,?,?,?)');
      $cmd->execute(
        array(
          $params['idusuario'],
          $params['idprovincia'],
          $params['precio']          
        )
      );

      $respuesta = $pdo->query("SELECT @idtarifario AS idtarifario")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idtarifario'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function actualizarTarifa($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_tarifa(?, ?)");
      $rpt = $cmd->execute(
        array(
          $params['idtarifario'],
          $params['precio']
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

}
