<?php

require_once 'ExecQuery.php';

class Convenio extends ExecQuery
{


  public function registrarConvenio($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_convenio(@idconvenio,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['abonogarantia'],
          $params['abonopublicidad'],
          $params['propuestacliente'],
          $params['acuerdo'],
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

  public function obtenerConvenioPorDP($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM convenios WHERE iddetalle_presentacion = ?");
      $cmd->execute(
        array($params['iddetallepresentacion'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  public function obtenerContratoConvenio($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL obtenerContratoConvenio(?)");
      $cmd->execute(
        array($params['idconvenio'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  public function obtenerConvenioPorIdDP($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL obtenerConvenioPorIdDP(?)");
      $cmd->execute(
        array($params['iddetallepresentacion'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }
  
  public function obtenerConvenioPorId($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM convenios WHERE idconvenio = ?");
      $cmd->execute(
        array($params['idconvenio'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

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

  public function actualizarConvenio($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_convenio(?,?,?,?,?,?)");
      $rpt = $cmd->execute(
        array(
          $params['idconvenio'],
          $params['abonogarantia'],
          $params['abonopublicidad'],
          $params['propuestacliente'],
          $params['acuerdo'],
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
