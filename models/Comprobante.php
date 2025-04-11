<?php

require_once 'ExecQuery.php';

class Comprobante extends ExecQuery
{
  public function obtenerSeriePorTipoDoc($params = []): array
  {
    try {
      $sp = parent::execQ("select * from comprobantes where idtipodoc = ? ");
      $sp->execute(
        array(
          $params['idtipodoc']
        )

      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function filtrarFacturas($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_facturas (?,?,?)");
      $cmd->execute(array(
        $params['fechaemision'],
        $params['horaemision'],
        $params['numerocomprobante']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
  /*   public function obtenerFactura($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_obtener_tarifario_por_provincia(?,?) ");
      $sp->execute(
        array(    
          $params['iddepartamento'],
          $params['idusuario'],
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  } */

  /* public function obtenerTarifaArtistaPorProvincia($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_search_tarifa_artista_por_provincia(?,?) ");
      $sp->execute(
        array(    
          $params['idprovincia'],
          $params['idusuario'],
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
  } */

  public function registrarComprobante($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_comprobante(@idcomprobante,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idsucursal'],
          $params['idcliente'],
          $params['idtipodoc'],
          $params['nserie'],
          $params['correlativo'],
          $params['tipomoneda'],
          $params['monto'],
        )
      );

      $respuesta = $pdo->query("SELECT @idcomprobante AS idcomprobante")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idcomprobante'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function registrarItemComprobante($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_item_comprobante(?,?,?,?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idcomprobante'],
          $params['cantidad'],
          $params['descripcion'],
          $params['valorunitario'],
          $params['valortotal']
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function registrarDetalleComprobante($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_detalle_comprobante(?,?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idcomprobante'],
          $params['estado'],
          $params['info']
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  /*   public function actualizarTarifa($params = []): bool
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
  } */
}
