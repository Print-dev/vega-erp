<?php

require_once 'ExecQuery.php';

class DetalleEvento extends ExecQuery
{
  public function registrarDetalleEvento($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_detalle_evento(@iddetalleevento,?,?,?,?,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idusuario'],
          $params['idcliente'],
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

  /* public function obtenerPersonaPorDoc($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_search_persona_numdoc(?)");
      $cmd->execute(array($params['num_doc']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  } */
}
