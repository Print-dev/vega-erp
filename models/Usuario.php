<?php

require_once 'ExecQuery.php';

class Usuario extends ExecQuery
{


  public function filtrarUsuarios($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_obtener_usuarios(?,?,?,?,?,?,?)");
      $sp->execute(
        array(
          $params['nivelacceso'],
          $params['numdoc'],
          $params['nombres'],
          $params['apellidos'],
          $params['telefono'],
          $params['nomusuario'],
          $params['idsucursal'],
        )

      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

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
      $cmd = $pdo->prepare('CALL sp_registrar_usuario(@idusuario,?,?,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idsucursal'],
          $params['idpersona'],
          $params['nom_usuario'],
          $params['claveacceso'],
          $params['color'],
          $params['porcentaje'],
          $params['marcaagua'],
          $params['firma'],
          //$params['esRepresentante'],
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

  public function obtenerUsuarioCompletoPorId($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM usuarios where idusuario = ?");
      $cmd->execute(
        array($params['idusuario'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  public function obtenerPersonaCompletoPorId($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM personas where idpersona = ?");
      $cmd->execute(
        array($params['idpersona'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

/*   public function obtenerRepresentanteEmpresa(): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_representante");
      $cmd->execute();
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }
 */

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

  public function actualizarUsuario($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_usuario(?,?,?,?,?,?,?,?)");
      $act = $cmd->execute(
        array(
          $params['idsucursal'],
          $params['idusuario'],
          $params['nomusuario'],
          $params['claveacceso'],
          $params['color'],
          $params['porcentaje'],
          $params['marcaagua'],
          $params['firma'],
          //$params['esRepresentante'],
        )
      );

      return $act;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function actualizarPersona($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_persona(?,?,?,?,?,?,?,?,?,?)");
      $act = $cmd->execute(
        array(
          $params['idpersona'],
          $params['numdoc'],
          $params['apellidos'],
          $params['nombres'],
          $params['genero'],
          $params['direccion'],
          $params['telefono'],
          $params['telefono2'],
          $params['correo'],
          $params['iddistrito'],
        )
      );

      return $act;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function deshabilitarUsuario($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_deshabilitar_usuario(?,?)");
      $act = $cmd->execute(
        array(
          $params['idusuario'],
          $params['estado'],
        )
      );

      return $act;
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


  public function obtenerUsuarioPorNivel($params = []): array // mas que todo para obtener ARTISTAS, ULTIMA UPDATE: USARSE PARA FILTRAR SU AGENDA
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_usuario_por_nivel(?)");
      $cmd->execute(array($params['idnivelacceso']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  /* public function obtenerMarcaAguaPorUsuario($params = []): array // mas que todo para obtener ARTISTAS, ULTIMA UPDATE: USARSE PARA FILTRAR SU AGENDA
  {
    try {
      $cmd = parent::execQ("SELECT marcaagua from usuarios where idusuario = ?");
      $cmd->execute(array($params['idusuario']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  } */
}
