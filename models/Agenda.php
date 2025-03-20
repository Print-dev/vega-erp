<?php

require_once 'ExecQuery.php';

class Agenda extends ExecQuery
{
  
  public function obtenerAgendaArtista($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_agenda_artista(?,?)");
      $cmd->execute(array(
        $params['idusuario'],
        $params['iddetallepresentacion'],
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerFilmmakerAsignado($params = []): array
  {
    try {
      $cmd = parent::execQ("CALL sp_obtener_filmmaker_asignado(?)");
      $cmd->execute(array(
        $params['iddetallepresentacion']
      ));
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      die($e->getMessage());
    }
  }
}