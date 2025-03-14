<?php

require_once 'ExecQuery.php';

class CajaChica extends ExecQuery
{

    public function obtenerUltimaCCFinal(): array
    {
        try {
            $cmd = parent::execQ("
            SELECT * FROM cajachica 
            ORDER BY idcajachica DESC 
            LIMIT 1
            ");
            $cmd->execute();
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }

    public function obtenerGastosPorCaja($params = []): array
    {
        try {
            $cmd = parent::execQ("SELECT * FROM gastos_cajachica WHERE idcajachica = ?");
            $cmd->execute(array($params['idcajachica']));
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }
    
    public function obtenerCajaChicaPorId($params = []): array
    {
        try {
            $cmd = parent::execQ("SELECT * FROM cajachica WHERE idcajachica = ?");
            $cmd->execute(array($params['idcajachica']));
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }
    
    public function filtrarCajasChicas($params = []): array
    {
        try {
            $cmd = parent::execQ("call sp_filtrar_cajachica(?,?)");
            $cmd->execute(array(
                $params['fechaapertura'],
                $params['fechacierre'],
            ));
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }

    public function registrarCajaChica($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_registrar_cajachica(@idcajachica,?,?,?)');
            $cmd->execute(
                array(
                    $params['ccinicial'],
                    $params['incremento'],
                    $params['ccfinal']
                )
            );

            $respuesta = $pdo->query("SELECT @idcajachica AS idcajachica")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idcajachica'];
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    }
    public function registrarGasto($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_registrar_gasto(@idcaja,?,?,?)');
            $cmd->execute(
                array(
                    $params['idcajachica'],
                    $params['concepto'],
                    $params['monto']
                )
            );

            $respuesta = $pdo->query("SELECT @idcaja AS idcaja")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idcaja'];
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    }

    public function actualizarEstadoCaja($params = []): bool
    {
      try {
        $pdo = parent::getConexion();
        $cmd = $pdo->prepare("CALL sp_actualizar_estado_caja(?, ?)");
        $rpt = $cmd->execute(
          array(
            $params['idcajachica'],
            $params['estado']
          )
        );
        return $rpt;
      } catch (Exception $e) {
        error_log("Error: " . $e->getMessage());
        return false;
      }
    }

    public function actualizarCCfinal($params = []): bool
    {
      try {
        $pdo = parent::getConexion();
        $cmd = $pdo->prepare("CALL sp_actualizar_ccfinal(?, ?)");
        $rpt = $cmd->execute(
          array(
            $params['idcajachica'],
            $params['ccfinal']
          )
        );
        return $rpt;
      } catch (Exception $e) {
        error_log("Error: " . $e->getMessage());
        return false;
      }
    }
}

