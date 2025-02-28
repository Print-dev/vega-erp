<?php

require_once 'ExecQuery.php';

class Convenio extends ExecQuery
{


  public function registrarConvenio($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_convenio(@idconvenio,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['abonogarantia'],
          $params['abonopublicidad'],
          $params['propuestacliente'],
          $params['estado'],
        )
      );

      $respuesta = $pdo->query("SELECT @idconvenio AS idconvenio")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idconvenio'];
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

  public function actualizarEstadoConvenio($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_estado_convenio(?, ?)");
      $rpt = $cmd->execute(
        array(
          $params['idconvenio'],
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
