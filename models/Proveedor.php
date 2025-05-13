<?php

require_once 'ExecQuery.php';

class Proveedor extends ExecQuery
{

    /*     public function obtenerPersonas(): array
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
  } */

    public function filtrarProveedores($params = []): array
    {
        try {
            $cmd = parent::execQ("CALL sp_filtrar_proveedores(?,?)");
            $cmd->execute([
                $params['nombre'],
                $params['dni'],
            ]);
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }


    public function registrarProveedor($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare("CALL sp_registrar_proveedor(@idproveedor,?,?,?,?,?,?,?,?,?)");
            $cmd->execute([
                $params['empresa'],
                $params['nombre'],
                $params['contacto'],
                $params['correo'],
                $params['dni'],
                $params['banco'],
                $params['ctabancaria'],
                $params['servicio'],
                $params['nproveedor']
            ]);
            $respuesta = $pdo->query("SELECT @idproveedor AS idproveedor")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idproveedor'];
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }


    public function actualizarProveedor($params = []): bool
    {
        try {
            $status = false;
            $cmd = parent::execQ("CALL sp_actualizar_proveedor(?,?,?,?,?,?,?,?,?,?)");
            $status = $cmd->execute(
                array(
                    $params['idproveedor'],
                    $params['empresa'],
                    $params['nombre'],
                    $params['contacto'],
                    $params['correo'],
                    $params['dni'],
                    $params['banco'],
                    $params['ctabancaria'],
                    $params['servicio'],
                    $params['nproveedor'],
                )
            );
            return $status;
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }

    public function obtenerProveedorPorId($params = []): array
    {
        try {
            $cmd = parent::execQ("SELECT * FROM proveedores WHERE idproveedor = ? ");
            $cmd->execute(
                array(
                    $params['idproveedor']
                )
            );
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
            return [];
        }
    }
}
