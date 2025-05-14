<?php

require_once 'ExecQuery.php';

class Nomina extends ExecQuery
{

  /* public function registrarNotificacionViatico($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_registrar_notificacion_viatico(@idnotificacion_viatico,?,?,?)');
            $cmd->execute(
                array(
                    $params['idviatico'],
                    $params['filmmaker'],
                    $params['mensaje']
                )
            );

            $respuesta = $pdo->query("SELECT @idnotificacion_viatico AS idnotificacion_viatico")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idnotificacion_viatico'];
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    } */
  public function registrarArea($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('INSERT INTO areas (area) VALUES (?)');
      $rpt = $cmd->execute(
        array(
          $params['area'],
        )
      );

      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }
  public function registrarColaborador($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_colaborador(@idcolaborador,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idpersona'],
          $params['fechaingreso'],
          $params['area'],
          $params['nivel']
        )
      );

      $respuesta = $pdo->query("SELECT @idcolaborador AS idcolaborador")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idcolaborador'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function registrarSalario($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_salario(@idsalario,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idcolaborador'],
          $params['salario'],
          $params['costohora'],
          $params['fechainicio']
        )
      );

      $respuesta = $pdo->query("SELECT @idsalario AS idsalario")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idsalario'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function registrarNomina($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_nomina(@idnomina,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idcolaborador'],
          $params['periodo'],
          $params['fechainicio'],
          $params['fechafin'],
          $params['horas'],
          $params['rendimiento'],
          $params['proporcion'],
          $params['acumulado'],
        )
      );

      $respuesta = $pdo->query("SELECT @idnomina AS idnomina")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idnomina'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }


  /*  public function obtenerNotificacionesViatico(): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM notificaciones_viatico");
      $sp->execute();
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  } */
  public function obtenerNotificaciones($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM notificaciones WHERE idusuariodest = ? ORDER BY idnotificacion DESC LIMIT 4");
      $sp->execute(
        array(
          $params["idusuariodest"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

/*   public function obtenerNotificaciones($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM notificaciones WHERE idusuariodest = ? ORDER BY idnotificacion DESC LIMIT 4");
      $sp->execute(
        array(
          $params["idusuariodest"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
 */
  public function obtenerTodasLasNotificaciones($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM notificaciones WHERE idusuariodest = ? ORDER BY idnotificacion DESC");
      $sp->execute(
        array(
          $params["idusuariodest"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerNotificacionPropuesta($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_obtener_notificacion_propuesta(?)");
      $sp->execute(
        array(
          $params["idreferencia"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerNotificacionPorNivel($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_obtener_notificaciones_por_nivel (?,?)");
      $sp->execute(
        array(
          $params["idnivelacceso"],
          $params["idusuario"],
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
}
