
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
}
