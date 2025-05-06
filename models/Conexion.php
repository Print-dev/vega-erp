<?php

class Conexion{

  //1. Almacenamos los datos de conexión
  /* private $servidor = "vega-producciones-database.cgp80wsakiq3.us-east-1.rds.amazonaws.com";
  private $puerto = "3306";
  private $baseDatos = "vega_producciones_erp";
  private $usuario = "admin";
  private $clave = "vegaproducciones123"; */

  private $servidor = "localhost";
  private $puerto = "3306";
  private $baseDatos = "vega_producciones_erp";
  private $usuario = "root";
  private $clave = "";

/*   private $servidor = "127.0.0.1:3306";
  private $puerto = "3306";
  private $baseDatos = "u321513493_vegaerp";
  private $usuario = "u321513493_vegaerp";
  private $clave = "Qv:dHH&3c"; */

  public function getConexion(){

    try{
      $pdo = new PDO(
        "mysql:host={$this->servidor};
        port={$this->puerto};
        dbname={$this->baseDatos};
        charset=UTF8", 
        $this->usuario, 
        $this->clave
      );

      $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      return $pdo;
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

    //Metodo para evitar la SQLinjection
  /**
   * Evita intentos de ataque a traves de campos INPUT
   */
  public static function limpiarCadena($cadena):string{
    $cadena = trim($cadena);
    $cadena = stripslashes($cadena);
    $cadena = str_ireplace("<script>", "",$cadena);
    $cadena = str_ireplace("</script>", "", $cadena);
    $cadena = str_ireplace("<script src", "", $cadena);
    $cadena = str_ireplace("<script type", "", $cadena);

    $cadena = str_ireplace("SELECT * FROM", "", $cadena);
    $cadena = str_ireplace("DELETE FROM", "", $cadena);
    $cadena = str_ireplace("INSERT INTO", "", $cadena);

    $cadena = str_ireplace("DROP TABLE", "", $cadena);
    $cadena = str_ireplace("DROP DATABASE", "", $cadena);
    $cadena = str_ireplace("TRUNCATE TABLE", "", $cadena);
    $cadena = str_ireplace("SHOW TABLES", "", $cadena);
    $cadena = str_ireplace("SHOW DATABASES", "", $cadena);

    $cadena = str_ireplace("<?php", "", $cadena);
    $cadena = str_ireplace("?>", "", $cadena);
    $cadena = str_ireplace("--", "", $cadena);
    $cadena = str_ireplace(">", "", $cadena);
    $cadena = str_ireplace("<", "", $cadena);
    $cadena = str_ireplace("[", "", $cadena);
    $cadena = str_ireplace("]", "", $cadena);

    $cadena = str_ireplace("^", "", $cadena);
    $cadena = str_ireplace("==", "", $cadena);
    $cadena = str_ireplace("===", "", $cadena);
    $cadena = str_ireplace(";", "", $cadena);
    $cadena = str_ireplace("::", "", $cadena);
    $cadena = str_ireplace("(", "", $cadena);
    $cadena = str_ireplace(")", "", $cadena);

    $cadena = stripslashes($cadena);
    $cadena = trim($cadena);

    return $cadena;
  }

  /**
   * Retorna una coleccion de datos de la fuente (SPU) especificada
   */
  public function getData($spuName=""):array{
    try{
      $cmd = $this->getConexion()->prepare("call {$spuName}()");
      $cmd->execute();
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    }catch(Exception $e){
      error_log("Error: ".$e->getMessage());
    }
  }

}