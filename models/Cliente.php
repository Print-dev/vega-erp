<?php

require_once 'ExecQuery.php';

class Cliente extends ExecQuery
{
  public function registrarCliente($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_cliente(@idcliente,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['iddistrito'],
          $params['ndocumento'],
          $params['razonsocial'],
          $params['representantelegal'],
          $params['telefono'],
          $params['correo'],
          $params['direccion'],
        )
      );

      $respuesta = $pdo->query("SELECT @idcliente AS idcliente")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idcliente'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function obtenerClientePorDoc($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_search_cliente_numdoc(?)");
      $cmd->execute(array($params['ndocumento']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function actualizarCliente($params = []):  bool
  {
    try {
      $cmd = parent::execQ("CALL sp_actualizar_cliente(?,?,?,?,?,?,?,?)");
      $rpt = $cmd->execute(array(
        $params['iddistrito'],
        $params['ndocumento'],
        $params['razonsocial'],
        $params['representantelegal'],
        $params['telefono'],
        $params['correo'],
        $params['direccion'],
        $params['idcliente'],
      ));
      return $rpt;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function verificarDatosIncompletosCliente($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM clientes WHERE idcliente = ?");
      $cmd->execute(array($params['idcliente']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
}
