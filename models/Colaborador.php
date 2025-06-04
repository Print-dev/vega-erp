<?php

require_once 'ExecQuery.php';

class Colaborador extends ExecQuery
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

  public function actualizarColaborador($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_colaborador(?,?,?,?,?,?,?)");
      $act = $cmd->execute(
        array(
          $params['idcolaborador'],
          $params['idsucursal'],
          $params['fechaingreso'],
          $params['idarea'],
          $params['idresponsable'],
          $params['banco'],
          $params['ncuenta'],
        )
      );

      return $act;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function actualizarSalario($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_salario(?,?,?,?,?,?)");
      $act = $cmd->execute(
        array(
          $params['idsalario'],
          $params['salario'],
          $params['periodo'],
          $params['horas'],
          $params['costohora'],
          $params['fechainicio']
        )
      );

      return $act;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }

  public function filtrarColaboradores($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_filtrar_colaboradores(?,?)");
      $sp->execute(
        array(
          $params["numdoc"],
          $params["idarea"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function filtrarCargos($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM cargos_colaboradores WHERE idpersonacolaborador = ? ORDER BY idcargocolaborador DESC");
      $sp->execute(
        array(
          $params["idpersonacolaborador"],
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerCargoColaboradorPorId($params = []): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM cargos_colaboradores where idcargocolaborador = ?");
      $sp->execute(
        array(
          $params["idcargocolaborador"],
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function filtrarGastos($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_filtrar_colaboradores(?,?)");
      $sp->execute(
        array(
          $params["numdoc"],
          $params["idarea"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function filtrarNominas($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_filtrar_nominas");
      $sp->execute(
        array(
          /* $params["nombres"],
          $params["numdoc"] */)
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
  public function filtrarSalarios($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_filtrar_salarios(?)");
      $sp->execute(
        array(
          $params["idcolaborador"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerColaboradorPorId($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM colaboradores where idcolaborador = ?");
      $cmd->execute(
        array($params['idcolaborador'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  public function obtenerSalarioPorId($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM salarios where idsalario = ?");
      $cmd->execute(
        array($params['idsalario'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  public function obtenerCargos(): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM cargos");
      $sp->execute();
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function registrarCargo($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('INSERT INTO cargos (cargo) VALUES (?)');
      $rpt = $cmd->execute(
        array(
          $params['cargo'],
        )
      );

      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function registrarCargoColaborador($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('INSERT INTO cargos_colaboradores (idpersonacolaborador, cargo, fechainicio) VALUES (?,?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idpersonacolaborador'],
          $params['cargo'],
          $params['fechainicio'],
        )
      );

      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  /*   public function registrarColaborador($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_colaborador(@idcolaborador,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idpersona'],
          $params['idsucursal'],
          $params['fechaingreso'],
          $params['area'],
          $params['idresponsable'],
          $params['banco'],
          $params['ncuenta'],
        )
      );

      $respuesta = $pdo->query("SELECT @idcolaborador AS idcolaborador")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idcolaborador'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }
 */

  public function registrarPersonaColaborador($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_persona_colaborador(@idpersonacolaborador,?,?,?,?,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['nombreapellidos'],
          $params['dni'],
          $params['fnacimiento'],
          $params['estadocivil'],
          $params['sexo'],
          $params['domicilio'],
          $params['correo'],
          $params['nivelestudio'],
          $params['contactoemergencia'],
          $params['discapacidad'],
          $params['foto'],
        )
      );

      $respuesta = $pdo->query("SELECT @idpersonacolaborador AS idpersonacolaborador")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idpersonacolaborador'];
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
          $params['idpersonacolaborador'],
          $params['camisa'],
          $params['pantalon'],
          $params['zapatos'],
        )
      );

      $respuesta = $pdo->query("SELECT @idcolaborador AS idcolaborador")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idcolaborador'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function registrarGastoNomina($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_gasto_nomina(@idgastonomina,?,?,?)');
      $cmd->execute(
        array(
          $params['idnomina'],
          $params['descripcion'],
          $params['monto']
        )
      );

      $respuesta = $pdo->query("SELECT @idgastonomina AS idgastonomina")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idgastonomina'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  public function registrarSalario($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_salario(@idsalario,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idcolaborador'],
          $params['salario'],
          $params['periodo'],
          $params['horas'],
          $params['costohora'],
        )
      );

      $respuesta = $pdo->query("SELECT @idsalario AS idsalario")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idsalario'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }



  /*   public function registrarNomina($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_nomina(@idnomina,?,?,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idcolaborador'],
          $params['salariousado'],
          $params['periodo'],
          $params['idarea'],
          $params['tiempo'],
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
  } */

  public function registrarNomina($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_nomina(@idnomina,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['tipo'],
          $params['idpersonacolaborador'],
          $params['tipo'],
          $params['fechaingreso'],
          $params['ruc'],
          $params['clavesol'],
          $params['ncuenta'],
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
  public function obtenerPersonaNumDocColaborador($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_buscar_persona_por_numdoc_colaborador(?)");
      $sp->execute(
        array(
          $params["numdoc"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerFichaColaborador($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_ficha_colaborador(?)");
      $sp->execute(
        array(
          $params["idnomina"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerColaboradoresConCargo(): array
  {
    try {
      $sp = parent::execQ("SELECT PC.*, CO.*
FROM personas_colaboradores PC
INNER JOIN (
    SELECT *
    FROM cargos_colaboradores
    WHERE idcargocolaborador IN (
        SELECT MAX(idcargocolaborador)
        FROM cargos_colaboradores
        GROUP BY idpersonacolaborador
    )
) CO ON PC.idpersonacolaborador = CO.idpersonacolaborador
ORDER BY PC.idpersonacolaborador");
      $sp->execute(      
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerUltimaNominaPorColaborador($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_obtener_ultimanomina_por_colaborador(?)");
      $sp->execute(
        array(
          $params["idcolaborador"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerAcumuladosNomina($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_obtener_acumulados_nomina(?)");
      $sp->execute(
        array(
          $params["idnomina"]
        )
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerUltimoSalarioPorColaborador($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_obtener_salario_por_colaborador(?)");
      $sp->execute(
        array(
          $params["idcolaborador"]
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
