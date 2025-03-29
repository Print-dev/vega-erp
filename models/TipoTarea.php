
<?php

require_once 'ExecQuery.php';

class TipoTarea extends ExecQuery
{

    public function registrarTipoTarea($params = []): bool
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('INSERT INTO tipotarea (tipotarea) VALUES (?)');
            $reg = $cmd->execute(
                array(
                    $params['tipotarea']
                )
            );

            return $reg;
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    }

    public function actualizarNombreTipoTarea($params = []): bool
    {
        try {
            $pdo = parent::getConexion();
            $cmd = $pdo->prepare('CALL sp_actualizar_nombre_tipotarea (?,?)');
            $reg = $cmd->execute(
                array(
                    $params['idtipotarea'],
                    $params['tipotarea'],
                )
            );

            return $reg;
        } catch (Exception $e) {
            error_log("Error: " . $e->getMessage());
            return -1;
        }
    }

    public function obtenerTodosTipoTarea(): array
    {
        try {
            $sp = parent::execQ("SELECT * FROM tipotarea");
            $sp->execute();
            return $sp->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }
    
    public function removerTipoTarea($params = []): bool
    {
        try {
            $sp = parent::execQ("CALL sp_remover_tipotarea (?)");
            $rpt = $sp->execute(array(
                $params['idtipotarea']
            ));
            return $rpt;
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }
}
