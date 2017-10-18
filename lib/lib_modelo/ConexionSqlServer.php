<?php

/**
 * Nombre Clase:    conexionSqlServer
 * Proposito:       Clase que tiene la funcionalidad para una conexion a un bad SqlServer
 * Autor:           Franklin Espinoza A.
 * Fecha:           18/09/2017
 */
class ConexionSqlServer{


    private $link;
    private $host;
    private $user;
    private $pass;
    private $db;

    static $control;

    function __construct($host, $user, $pass, $db){ //conectarSQL(
       $this->host = $host;
       $this->user = $user;
       $this->pass = $pass;
       $this->db = $db;
    }

    function conectarSQL(){
        $this->link = mssql_connect($this->host, $this->user, $this->pass);// or die("No se pudo conectar a ".$this->host." Server");
        if (!$this->link) {
            return 'connect';
        }
        $this->select_db = mssql_select_db($this->db, $this->link); /*or die('No se puede seleccionarse '.$this->db.' database')*/
        if (!$this->select_db) {
            return 'select_db';
        }

        return $this->link;
    }

    function closeSQL(){
        mssql_close($this->link);
    }
}

?>