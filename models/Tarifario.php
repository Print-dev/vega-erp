<?php

require_once 'ExecQuery.php';

class Tarifario extends ExecQuery
{

  
  public function filtrarTarifas($params = []): array
  {
    try {
      $sp = parent::execQ("CALL sp_search_tarifa_artista(?)");
      $sp->execute(
        array(    
          $params['nomusuario'],
        )
        
      );
      return $sp->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
  

}
