<?php

require_once 'ExecQuery.php';

class DetalleEvento extends ExecQuery
{
  public function actualizarDetallePresentacion($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_actualizar_detalle_presentacion(?,?,?,?,?,?,?,?,?,?,?)');
      $act = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['fechapresentacion'],
          $params['horainicio'],
          $params['horafinal'],
          $params['establecimiento'],
          $params['referencia'],
          $params['tipoevento'],
          $params['modotransporte'],
          $params['validez'],
          $params['iddistrito'],
          $params['igv'],
        )
      );

      return $act;
    } catch (PDOException $e) {
      // Registrar detalles del error en el log
      error_log("Error en registrarDetallePresentacion: " . $e->getMessage());

      // Retornar detalles del error
      die($e->getMessage());
    }
  }

  public function obtenerEventosUnicos(): array
  {
    try {
      $sp = parent::execQ("SELECT * FROM detalles_presentacion GROUP BY establecimiento");
      $sp->execute();
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }


  public function registrarResponsableBoleteriaContrato($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('INSERT INTO responsables_boleteria_contratoreservasreservas (iddetalle_presentacion, idusuarioBoleteria, idusuarioContrato) VALUES (?,?,?)');
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['idusuarioboleteria'],
          $params['idusuariocontrato']
        )
      );

      return $rpt;
    } catch (PDOException $e) {
      // Retornar detalles del error
      die($e->getMessage());
    }
  }

  public function registrarPrecioEvento($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('INSERT INTO precios_entrada_evento (iddetalle_presentacion, entradas) VALUES (?,?)');
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['entradas']
        )
      );

      return $rpt;
    } catch (PDOException $e) {
      // Retornar detalles del error
      die($e->getMessage());
    }
  }

  public function actualizarResponsableBoleteriaContrato($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_actualizar_responsables_boleteria_contrato_evento (?,?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idresponsablecontrato'],
          $params['idusuarioboleteria'],
          $params['idusuariocontrato'],
        )
      );

      return $rpt;
    } catch (PDOException $e) {
      // Retornar detalles del error
      die($e->getMessage());
    }
  }

  public function actualizarPrecioEntradaEvento($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_actualizar_precios_entrada_evento (?,?)');
      $rpt = $cmd->execute(
        array(
          $params['idprecioentradaconvenio'],
          $params['entradas']
        )
      );

      return $rpt;
    } catch (PDOException $e) {
      // Retornar detalles del error
      die($e->getMessage());
    }
  }

  public function obtenerResponsableBoleteriaContrato($params = []): array
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('SELECT * FROM responsables_boleteria_contratoreservasreservas WHERE iddetalle_presentacion = ?');
      $cmd->execute(
        array(
          $params['iddetallepresentacion']
        )
      );

      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
      // Retornar detalles del error
      die($e->getMessage());
    }
  }

  public function obtenerPreciosEvento($params = []): array
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('SELECT * FROM precios_entrada_evento WHERE iddetalle_presentacion = ?');
      $cmd->execute(
        array(
          $params['iddetallepresentacion']
        )
      );

      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
      // Retornar detalles del error
      die($e->getMessage());
    }
  }

  public function registrarDetallePresentacion($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare('CALL sp_registrar_detalle_presentacion(@iddetalleevento,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)');
      $cmd->execute(
        array(
          $params['idusuario'],
          $params['idcliente'],
          $params['iddistrito'],
          $params['ncotizacion'],
          $params['fechapresentacion'],
          $params['horainicio'],
          $params['horafinal'],
          $params['establecimiento'],
          $params['referencia'],
          $params['acuerdo'],
          $params['tipoevento'],
          $params['modotransporte'],
          $params['modalidad'],
          $params['validez'],
          $params['igv'],
          $params['esExtranjero'],
          $params['idnacionalidad'],
        )
      );

      $respuesta = $pdo->query("SELECT @iddetalleevento AS iddetalleevento")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['iddetalleevento'];
    } catch (PDOException $e) {
      // Registrar detalles del error en el log
      error_log("Error en registrarDetallePresentacion: " . $e->getMessage());

      // Retornar detalles del error
      die($e->getMessage());
    }
  }

  public function filtrarAtenciones($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_detalles_evento (?,?,?,?,?,?,?)");
      $cmd->execute(array(
        $params['ncotizacion'],
        $params['ndocumento'],
        $params['nomusuario'],
        $params['establecimiento'],
        $params['fechapresentacion'],
        $params['mes'],
        $params['añosemana'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerDetallesPresentacionPorModalidad($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_detalles_presentacion_por_modalidad (?,?)");
      $cmd->execute(array(
        $params['modalidad'],
        $params['igv'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerEventos($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM eventos");
      $cmd->execute(array(
        $params['ncotizacion'],
        $params['ndocumento'],
        $params['nomusuario'],
        $params['establecimiento'],
        $params['fechapresentacion'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
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

  public function obtenerFilmmakerAsociadoEvento($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_filmmaker_asociado_evento (?)");
      $cmd->execute(array($params['idusuario']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function editarAcuerdoEvento($params = []): bool
  {
    try {
      $cmd = parent::execQ("CALL sp_editar_acuerdo_evento (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['acuerdo'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  /* public function asignarFilmmakerDP($params = []): bool
  {
    try {
      $cmd = parent::execQ("CALL sp_asignarfilmmaker_dp (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['filmmaker'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  } */
  public function asignarAgenda($params = []): int
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_asignar_agenda (@idasignacion,?,?)");
      $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['idusuario'],
        )
      );
      $respuesta = $pdo->query("SELECT @idasignacion AS idasignacion")->fetch(PDO::FETCH_ASSOC);
      return $respuesta['idasignacion'];
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function actualizarEstadoReservaDp($params = []): bool
  {
    try {
      $cmd = parent::execQ("CALL sp_actualizar_estado_reserva_dp (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['reserva'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function actualizarPagado50DP($params = []): bool
  {
    try {
      $cmd = parent::execQ("CALL sp_actualizar_pagado50_dp (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['pagado50'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function actualizarCajaDP($params = []): bool
  {
    try {
      $cmd = parent::execQ("CALL sp_actualizar_caja_dp (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['tienecaja'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function actualizarEstadoDp($params = []): bool
  {
    try {
      $cmd = parent::execQ("CALL sp_actualizar_estado_dp (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['estado'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function actualizarEstadoCordinacionTecnica($params = []): bool
  {
    try {
      $cmd = parent::execQ("CALL sp_actualizar_estadoCordinacionTecnica (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['estadocordinaciontecnica'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function actualizarEstadoCordinacionPublicidad($params = []): bool
  {
    try {
      $cmd = parent::execQ("CALL sp_actualizar_estadoCordinacionPublicidad (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['estadocordinacionpublicidad'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  /* public function asignarLugarDestinoBus($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_asignar_lugar_destino_bus (?,?)");
      $rpt = $cmd->execute(
        array(
          $params['iddetallepresentacion'],
          $params['lugardestino'],
        )
      );
      return $rpt;
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return false;
    }
  }
 */
  public function obtenerCotizacionesPorModalidad($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM detalles_presentacion WHERE modalidad = ?");
      $cmd->execute(array($params['modalidad']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerNotificacionDP($params = []): array // SOLO PARA NOTIFICACIONES DE SALIDA Y RETORNO DE ARTISTA
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_notificacion_dp (?)");
      $cmd->execute(array(
        $params['idreferencia']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerNotificacionDPIndividual($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_notificacion_dp_individual (?)");
      $cmd->execute(array(
        $params['idreferencia']
      ));
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

  public function obtenerDPs($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM detalles_presentacion WHERE = ");
      $cmd->execute(array($params['iddetallepresentacion']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerInfoDPporId($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT * FROM detalles_presentacion WHERE iddetalle_presentacion = ?");
      $cmd->execute(array($params['iddetallepresentacion']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerAcuerdo($params = []): array
  {
    try {
      $cmd = parent::execQ("SELECT acuerdo FROM detalles_presentacion WHERE iddetalle_presentacion = ?");
      $cmd->execute(array($params['iddetallepresentacion']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerCotizacion($params = []): array
  {
    try {
      $cmd = parent::execQ("call sp_obtenerCotizacion (?)");
      $cmd->execute(array($params['iddetallepresentacion']));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }


  public function obtenerDpPorFecha($params = []): array
  {
    try {
      $cmd = parent::execQ("call sp_obtener_dp_por_fecha (?,?)");
      $cmd->execute(array(
        $params['idusuario'],
        $params['fechapresentacion'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
}
