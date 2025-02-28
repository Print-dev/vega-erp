<?php

require_once 'ExecQuery.php';

class Contrato extends ExecQuery
{


  public function registrarContrato($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_contrato(@idcontrato,?,?,?)');
      $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['montopagado'],
          $params['estado'],
        )
      );

      $respuesta = $pdo->query("SELECT @idcontrato AS idcontrato")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idcontrato'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }
/* 
  public function obtenerUsuarioPorId($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_usuario_por_id(?)");
      $cmd->execute(
        array($params['idusuario'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }
 */

  public function actualizarEstadoContrato($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_estado_contrato(?, ?)");
      $rpt = $cmd->execute(
        array(
          $params['idcontrato'],
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
