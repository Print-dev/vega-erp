<?php

require_once 'ExecQuery.php';

class Reparticion extends ExecQuery
{

  
  public function filtrarReparticiones($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_filtrar_reparticiones(?)");
      $sp->execute(
        array(    
          $params['evento'],
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerIngresoPorId($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM ingresos_evento WHERE idingreso = ?");
      $sp->execute(
        array(    
          $params['idingreso'],
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerEgresoPorId($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM egresos_evento WHERE idegreso = ?");
      $sp->execute(
        array(    
          $params['idegreso'],
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerIngresoPorIdReparticion($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM ingresos_evento WHERE idreparticion = ?");
      $sp->execute(
        array(    
          $params['idreparticion'],
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerEgresoPorIdReparticion($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM egresos_evento WHERE idreparticion = ?");
      $sp->execute(
        array(    
          $params['idreparticion'],
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
  
  public function registrarReparticion($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_reparticion(@idreparticion,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['montototal'],
          $params['montorepresentante'],
          $params['montopromotor'],
          $params['ingresototal'],
          $params['montoartista'],
          $params['montofinal'],
        )
      );

      $respuesta = $pdo->query("SELECT @idreparticion AS idreparticion")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idreparticion'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function registrarIngreso($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_ingreso(@idingreso,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idreparticion'],
          $params['descripcion'],
          $params['monto'],
          $params['tipopago'],
          $params['noperacion']
        )
      );

      $respuesta = $pdo->query("SELECT @idingreso AS idingreso")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idingreso'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function registrarEgreso($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_egresos(@idegreso,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idreparticion'],
          $params['descripcion'],
          $params['monto'],
          $params['tipopago'],
          $params['noperacion']
        )
      );

      $respuesta = $pdo->query("SELECT @idegreso AS idegreso")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idegreso'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }


}
