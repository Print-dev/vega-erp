<?php

require_once 'ExecQuery.php';

class Sucursal extends ExecQuery
{


  public function filtrarSucursales($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_listar_sucursales (?,?,?,?)");
      $sp->execute(
        array(
          $params['nombre'],
          $params['iddepartamento'],
          $params['idprovincia'],
          $params['iddistrito'],
        )

      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerSucursales(): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM sucursales ");
      $sp->execute();
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function registrarSucursal($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_sucursal(?,?,?,?,?,?,?,?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idempresa'],
          $params['iddistrito'],
          $params['idresponsable'],
          $params['nombre'],
          $params['ruc'],
          $params['telefono'],
          $params['direccion'],
          $params['email'],
          $params['ubigeo'],
        )
      );

      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function actualizarSucursal($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_actualizar_sucursal(?,?,?,?,?,?,?,?,?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idsucursal'],
          $params['idempresa'],
          $params['iddistrito'],
          $params['idresponsable'],
          $params['nombre'],
          $params['ruc'],
          $params['telefono'],
          $params['direccion'],
          $params['email'],
          $params['ubigeo'],
        )
      );

      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }


  public function obtenerSucursalPorId($params = []): array
  {
    try {
      $sp = parent::execQ("call obtenerSucursalPorId(?)");
      $sp->execute(
        array(
          $params['idsucursal']
        )

      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerSucursalesPorEmpresa($params = []): array
  {
    try {
      $sp = parent::execQ("call sp_obtener_sucursales_por_empresa (?)");
      $sp->execute(
        array(
          $params['idempresa']
        )

      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerRepresentanteEmpresa($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_representante (?)");
      $cmd->execute(
        array(
          $params['idsucursal']
        )
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }
}
