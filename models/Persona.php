<?php

require_once 'ExecQuery.php';

class Persona extends ExecQuery{

    public function obtenerPersonas(): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM personas");
      $cmd->execute();
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  public function obtenerPersonaPorId($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM personas where idpersona = ?");
      $cmd->execute(
        array($params['idpersona'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
      return [];
    }
  }

  public function registrarPersona($params = []): int
{
    try {
        $pdo = parent::getConexion();
        $cmd = $pdo->prepare("CALL sp_registrar_persona(@idpersona,?,?,?,?,?,?,?,?,?)");
        $cmd->execute([
            $params['num_doc'],
            $params['apellidos'],
            $params['nombres'],
            $params['genero'],
            $params['direccion'],
            $params['telefono'],
            $params['telefono2'],
            $params['correo'],
            $params['iddistrito'],
        ]);
        $respuesta = $pdo->query("SELECT @idpersona AS idpersona")->fetch(PDO::FETCH_ASSOC);
        return $respuesta['idpersona'];
    } catch (Exception $e) {
        die($e->getMessage());
    }
}
}

  /* public function updatePersona($params = []): bool
  {
    try {
      $status = false;
      $cmd = parent::execQ("CALL sp_update_persona(?,?,?,?,?,?)");
      $status = $cmd->execute(
        array(
          $params['idpersona'],
          $params['apellidos'],
          $params['nombres'],
          $params['telefono'],
          $params['direccion'],
          $params['email']
        )
      );
      return $status;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function getPersonaById($params=[]):array{
    try{
      $cmd = parent::execQ("CALL sp_search_persona_by_id(?)");
      $cmd->execute(
        array(
          $params['idpersona']
        )
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    }catch (Exception $e) {
      die($e->getMessage());
      return [];
    }
  } */

