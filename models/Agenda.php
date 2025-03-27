<?php

require_once 'ExecQuery.php';

class Agenda extends ExecQuery
{

  public function obtenerAgendaArtista($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_agenda_artista(?,?)");
      $cmd->execute(array(
        $params['idusuario'],
        $params['iddetallepresentacion'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerAgenda($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_agenda(?,?,?)");
      $cmd->execute(array(
        $params['idusuario'],
        $params['iddetallepresentacion'],
        $params['idnivelacceso'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerAgendaFilmmakers($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_agenda_filmmakers(?,?,?)");
      $cmd->execute(array(
        $params['idusuario'],
        $params['iddetallepresentacion'],
        $params['idnivelacceso'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }


  public function obtenerFilmmakerAsignado($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_filmmaker_asignado(?)");
      $cmd->execute(array(
        $params['iddetallepresentacion']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function registrarAgendaEdicion($params = []): bool
  {
    try {
      $cmd = parent::execQ("INSERT INTO agenda_edicion (iddetalle_presentacion) VALUES (?)");
      $registrado = $cmd->execute(array(
        $params['iddetallepresentacion']
      ));
      return $registrado;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerTodasLasAgendasEdicion(): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_agenda_edicion ");
      $cmd->execute();
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerAgendaEdicionPorEditorYGeneral($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_agenda_edicion_por_editor_y_general (?) ");
      $cmd->execute(array(
        $params['idusuario']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerContenidoHistorialEdicion($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_contenido_historial_edicion (?) ");
      $cmd->execute(array(
        $params['idagendaeditor']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerEditoresAsignados($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_agenda_editores (?) ");
      $cmd->execute(array(
        $params['idagendaedicion']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerUsuarioAsignado($params = []): array // este spu lo q hace es que verifica si una tarea ya tiene a un editor asignado
  {
    try {
      $cmd = parent::execQ("CALL obtenerUsuarioAsignado (?,?)");
      $cmd->execute(array(
        $params['idagendaedicion'],
        $params['idtipotarea'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerTareaPorUsuarioYagenda($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_usuario_asignado_tarea (?,?) ");
      $cmd->execute(array(
        $params['idusuario'],
        $params['idagendaedicion'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function eliminarTareaUsuario($params = []): bool
  {
    try {
      $cmd = parent::execQ("DELETE FROM agenda_editores WHERE idagendaeditor = ?");
      $eliminado = $cmd->execute(array(
        $params['idagendaeditor']
      ));
      return $eliminado;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerTodasLasTareasEnLaAgenda($params = []): array
  {
    try {
      $cmd = parent::execQ("select * from agenda_editores where idagendaedicion = ? ");
      $cmd->execute(array(
        $params['idagendaedicion']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerTareasEditor($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_tareas_editor (?)");
      $cmd->execute(array(
        $params['idusuario']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  // ************************* AGENDA EDITORES ************************************

  public function asignarAgendaEditor($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_asignar_agenda_editor(@idagendaeditor,?,?,?,?,?)");
      $cmd->execute(array(
        $params['idagendaedicion'],
        $params['idusuario'],
        $params['idtipotarea'],
        $params['fechaentrega'],
        $params['horaentrega'],
      ));
      $respuesta = $pdo->query("SELECT @idagendaeditor AS idagendaeditor")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idagendaeditor'];
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function subirContenidoEditor($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_subir_contenido_editor(@idsubida,?,?)");
      $cmd->execute(array(
        $params['idagendaeditor'],
        $params['url']
      ));
      $respuesta = $pdo->query("SELECT @idsubida AS idsubida")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idsubida'];
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  /*   public function actualizarAgendaEditor($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_estado_caja(?,?,?)");
      $rpt = $cmd->execute(
        array(
          $params['idagendaeditor'],
          $params['urlimagen'],
          $params['urlvideo'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  } */

  public function actualizarAgendaEditor($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_agenda_editor(?,?,?,?,?)");
      $rpt = $cmd->execute(
        array(
          $params['idagendaeditor'],
          $params['idusuario'],
          $params['idtipoentrega'],
          $params['fechaentrega'],
          $params['horaentrega'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function comentarContenido($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_observacion_subida (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['idsubida'],
          $params['observaciones'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function actualizarEstadoTareaEdicion($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_estado_tarea_edicion (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['idagendaeditor'],
          $params['estado'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function registrarNuevoTipoTarea($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_registrar_nuevo_tipotarea (@idtipotarea,?)");
      $cmd->execute(
        array(
          $params['tipotarea']
        )
      );
      $respuesta = $pdo->query("SELECT @idtipotarea AS idtipotarea")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idtipotarea'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }
}
