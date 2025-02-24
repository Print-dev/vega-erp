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

  public function registrarUsuario($params = []): int {
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


  public function updateUsuario($params=[]):int{
    try{
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

  public function cambiarAreaUsuario($params = []): bool
  {
    try {
      $estado = false;
      $cmd = parent::execQ("CALL sp_cambiar_area_usuario(?,?)");
      $estado = $cmd->execute(
        array(
          $params['idusuario'],
          $params['idarea']
        )
      );
      return $estado;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function filtrarUsuarios($params = []): array
  {
    try {
      $defaultParams = [
        'dato' => null,
        'idtipodoc' => null,
        'idnivelacceso' => null,
        'numdoc' => null,
        'estado' => null,
        'externo' => null
      ];

      $realParams = array_merge($defaultParams, $params);

      $cmd = parent::execQ("CALL sp_filtrar_usuarios(?,?,?,?,?,?,?)");
      $cmd->execute(
        array(
          $realParams['dato'],
          $realParams['idtipodoc'],
          $realParams['idnivelacceso'],
          $realParams['estado'],
          $realParams['numdoc'],
          $realParams['externo'],
          $realParams['idarea']
        )
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  public function filtrarUsuariosMantenimiento($params = []): array
  {
    try {
      $defaultParams = [
        'dato' => null,
        'numdoc' => null,
        'externo' => null
      ];

      $realParams = array_merge($defaultParams, $params);

      $cmd = parent::execQ("CALL sp_filtrar_usuarios_mantenimiento(?,?,?)");
      $cmd->execute(
        array(
          $realParams['dato'],
          $realParams['numdoc'],
          $realParams['externo']
        )
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  
  public function updateEstado($params = []): bool
  {
    try {
      $state = false;
      $cmd = parent::execQ("CALL sp_update_estado_usuario(?,?)");
      $state = $cmd->execute(
        array(
          $params['idusuario'],
          $params['estado']
        )
      );
      return $state;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
    }
  }

  public function searchUser($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_search_nom_usuario(?)");
      $cmd->execute(
        array($params['nom_usuario'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function existeResponsableArea($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_existe_responsable_area(?)");
      $cmd->execute(
        array(
          $params['idarea']
        )
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
    }
  }

  /* public function filtrarUsuariosArea($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_filtrar_usuarios_area(?)");
      $cmd->execute(
        array(
          $params['idarea']
        )
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
    }
  } */

  public function designarResponsableArea($params = []): bool
  {
    try {
      $state = false;
      $cmd = parent::execQ("CALL sp_designar_responsable_area(?,?)");
      $state = $cmd->execute(
        array(
          $params['idusuario'],
          $params['responsable_area']
        )
      );
      return $state;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function getIdAdmin():array{
    return parent::getData("sp_get_user_admin");
  }

  public function getIdSupervisorArea($params=[]):array{
    try{
      $cmd = parent::execQ("CALL sp_get_idsupervisor_area(?)");
      $cmd->execute(
        array(
          $params['idarea']
        )
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  public function list_users():array{
    return parent::getData("sp_listar_usuarios");
  }
}
