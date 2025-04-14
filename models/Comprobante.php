<?php

require_once 'ExecQuery.php';

class Comprobante extends ExecQuery
{
  public function filtrarCuotas($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_obtener_cuotas (?,?,?)");
      $sp->execute(
        array(
          $params['fecha'],
          $params['numerocomprobante'],
          $params['idcliente'],
        )

      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerCuotasFacturaPorIdComprobante($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM cuotas_comprobante WHERE idcomprobante = ? ");
      $sp->execute(
        array(
          $params['idcomprobante']
        )

      );
      
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

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

  public function obtenerItemsPorIdComprobante($params = []): array
  {
    try {
      $sp = parent::execQ("select * from items_comprobante where idcomprobante = ? ");
      $sp->execute(
        array(
          $params['idcomprobante']
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

  public function obtenerPagosCuotasPorIdCuota($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM pagos_cuota WHERE idcuotacomprobante = ? ");
      $cmd->execute(array(
        $params['idcuotacomprobante']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
  
  public function obtenerComprobantePorTipoDoc($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_comprobante_por_tipodoc (?,?)");
      $cmd->execute(array(
        $params['idcomprobante'],
        $params['idtipodoc']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerDetallesComprobante($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM detalles_comprobante where idcomprobante = ?");
      $cmd->execute(array(
        $params['idcomprobante']
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
      $cmd = $pdo->prepare('CALL sp_registrar_comprobante(@idcomprobante,?,?,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idsucursal'],
          $params['idcliente'],
          $params['idtipodoc'],
          $params['tipopago'],
          $params['nserie'],
          $params['correlativo'],
          $params['tipomoneda'],
          $params['monto'],
          $params['tieneigv'],
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
      return false;
    }
  }

  public function registrarCuotaFactura($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_cuota_factura(?,?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idcomprobante'],
          $params['fecha'],
          $params['monto']
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function registrarPagoCuota($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_pago_cuota(?,?,?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idcuotacomprobante'],
          $params['montopagado'],
          $params['tipopago'],
          $params['noperacion'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
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

  public function actualizarEstadoCuotaComprobante($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_actualizar_estado_cuota_comprobante(?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idcuotacomprobante'],
          $params['estado'],
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
