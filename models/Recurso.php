<?php

require_once 'ExecQuery.php';

class Recurso extends ExecQuery
{
    public function obtenerNiveles(): array
    {
        try {
            $cmd = parent::execQ("SELECT * FROM nivelaccesos");
            $cmd->execute();
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }

    public function obtenerDepartamentos($params = []): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM departamentos WHERE idnacionalidad = ?");
        $cmd->execute(array($params['idnacionalidad']));
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

    public function obtenerProvincias($params = []): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM provincias WHERE iddepartamento = ?");
        $cmd->execute(array($params['iddepartamento']));
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

    public function obtenerDistritos($params = []): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM distritos WHERE idprovincia = ?");
        $cmd->execute(array($params['idprovincia']));
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

    public function buscarCorreo($params = []): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM personas WHERE correo = ?");
        $cmd->execute(array($params['correo']));
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

}
