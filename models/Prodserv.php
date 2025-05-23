<?php

require_once 'ExecQuery.php';

class Prodserv extends ExecQuery
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

    /*  public function actualizarColaborador($params = []): bool
  {
    try {
      $pdo = parent::getConexion();
      $cmd = $pdo->prepare("CALL sp_actualizar_colaborador(?,?,?,?)");
      $act = $cmd->execute(
        array(
          $params['idcolaborador'],
          $params['idsucursal'],
          $params['fechaingreso'],
          $params['idarea']
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
  } */

    public function filtrarProdserv(): array
    {
        try {
            $sp = parent::execQ("CALL sp_filtrar_prodserv");
            $sp->execute(
                /* array(
          $params["numdoc"],
          $params["idarea"]
        ) */);
            return $sp->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }



    public function registrarProdserv($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_registrar_prodserv(@idprodserv,?,?,?,?,?)');
            $cmd->execute(
                array(
                    $params['nombre'],
                    $params['tipo'],
                    $params['codigo'],
                    $params['idproveedor'],
                    $params['precio'],
                )
            );

            $respuesta = $pdo->query("SELECT @idprodserv AS idprodserv")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idprodserv'];
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    }
}
