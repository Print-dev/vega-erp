<?php

require_once 'ExecQuery.php';

class DetalleEvento extends ExecQuery
{
  public function registrarDetallePresentacion($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_detalle_presentacion(@iddetalleevento,?,?,?,?,?,?,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idusuario'],
          $params['idcliente'],
          $params['iddistrito'],
          $params['ncotizacion'],
          $params['fechapresentacion'],
          $params['horapresentacion'],
          $params['tiempopresentacion'],
          $params['establecimiento'],
          $params['tipoevento'],
          $params['modalidad'],
          $params['validez'],
          $params['igv'],
          $params['tipopago'],
        )
      );

      $respuesta = $pdo->query("SELECT @iddetalleevento AS iddetalleevento")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['iddetalleevento'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function obtenerCotizacionPorNcot($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM detalles_presentacion WHERE ncotizacion = ?");
      $cmd->execute(array($params['ncotizacion']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerDPporId($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_dp_porid(?)");
      $cmd->execute(array($params['iddetallepresentacion']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
}
