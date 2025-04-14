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

    // OBTENER UBIGEOS POR ID ****************************************************************************************
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

    public function obtenerDepartamentoPorId($params = []): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM departamentos WHERE iddepartamento = ?");
        $cmd->execute(array($params['iddepartamento']));
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

    public function obtenerDistritoPorId($params = []): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM distritos WHERE iddistrito = ?");
        $cmd->execute(array($params['iddistrito']));
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }
    
    public function obtenerDistritoPorNombre($params = []): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM distritos WHERE distrito = ?");
        $cmd->execute(array($params['distrito']));
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

    // OBTENER UBIGEOS POR ID ****************************************************************************************
    public function obtenerTodosDepartamentos(): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM departamentos");
        $cmd->execute();
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

    public function obtenerTodosProvincias(): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM provincias");
        $cmd->execute();
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

    public function obtenerTodosDistritos(): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM distritos");
        $cmd->execute();
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

    public function obtenerTodosNacionalidades(): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM nacionalidades");
        $cmd->execute();
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

    public function buscarCorreoCliente($params = []): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM clientes WHERE correo = ?");
        $cmd->execute(array($params['correo']));
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

    public function obtenerFilmmakers(): array
    {
      try {
        $cmd = parent::execQ("SELECT * FROM usuarios WHERE idnivelacceso = 11");
        $cmd->execute();
        return $cmd->fetchAll(PDO::FETCH_ASSOC);
      } catch (Exception $e) {
        die($e->getMessage());
      }
    }

}
