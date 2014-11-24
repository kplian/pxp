<?php

include ('../../codebase/connector/db_sqlite3.php');
include ('../../codebase/connector/gantt_connector.php');

// SQLite
$dbtype = "SQLite3";
$res = new SQLite3(dirname(__FILE__)."/samples.sqlite");
$res->busyTimeout(1000);
// Mysql
// $dbtype = "MySQL";
// $res=mysql_connect("192.168.1.251", "gantt", "gantt");
// mysql_select_db("gantttest");

?>