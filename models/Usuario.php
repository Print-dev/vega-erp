<?php

require_once 'ExecQuery.php';

class Usuario extends ExecQuery
{

  public function login($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_user_login(?)");
      $sp->execute(array($params['nom_usuario']));
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function getPermisos($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_permisos(?)");
      $cmd->execute(array($params['idnivelacceso']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function registrarUsuario($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_usuario(@idusuario,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idpersona'],
          $params['nom_usuario'],
          $params['claveacceso'],
          $params['idnivelacceso'],
        )
      );

      $respuesta = $pdo->query("SELECT @idusuario AS idusuario")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idusuario'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

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


  public function updateUsuario($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_update_usuario(@idpersona, ?, ?)");
      $cmd->execute(
        array(
          $params['idusuario'],
          $params['idperfil']
        )
      );

      $respuesta = $pdo->query("SELECT @idpersona AS idpersona")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idpersona'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function obtenerPersonaPorDoc($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_search_persona_numdoc(?)");
      $cmd->execute(array($params['num_doc']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }


  public function obtenerUsuarioPorNivel($params = []): array // mas que todo para obtener ARTISTAS
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_usuario_por_nivel(?)");
      $cmd->execute(array($params['idnivelacceso']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }


}
