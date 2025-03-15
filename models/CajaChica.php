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

    public function obtenerMontoCajaChica(): array
    {
        try {
            $cmd = parent::execQ("SELECT * FROM montoCajaChica");
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

    public function obtenerGastoPorId($params = []): array
    {
        try {
            $cmd = parent::execQ("SELECT * FROM gastos_cajachica where idgasto = ?");
            $cmd->execute(array($params['idgasto']));
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }

    public function filtrarCajasChicas($params = []): array
    {
        try {
            $cmd = parent::execQ("CALL sp_filtrar_cajachica(?,?,?,?)");
            $cmd->execute([
                $params['fechaapertura'],
                $params['fechacierre'],
                $params['mes'],
                $params['año_semana']
            ]);
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }


    public function registrarCajaChica($params = []): int
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_registrar_cajachica(@idcajachica,?,?,?,?,?)');
            $cmd->execute(
                array(
                    $params['iddetallepresentacion'],
                    $params['idmonto'],
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
            $cmd = $pdo->prepare('CALL sp_registrar_gasto(@idgasto,?,?,?)');
            $cmd->execute(
                array(
                    $params['idcajachica'],
                    $params['concepto'],
                    $params['monto']
                )
            );

            $respuesta = $pdo->query("SELECT @idgasto AS idgasto")->fetch(PDO::FETCH_ASSOC);
            return $respuesta['idgasto'];
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

    public function actualizarMontoCajaChica($params = []): bool
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare("CALL sp_actualizar_monto_cajachica(?, ?)");
            $rpt = $cmd->execute(
                array(
                    $params['idmonto'],
                    $params['monto']
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

    public function actualizarIncremento($params = []): bool
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare("CALL sp_actualizar_incremento(?, ?)");
            $rpt = $cmd->execute(
                array(
                    $params['idcajachica'],
                    $params['incremento']
                )
            );
            return $rpt;
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return false;
        }
    }
}
