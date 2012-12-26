<?php 
/***
 Nombre: Intermediario.php
 Proposito: Invocar a la clase Intermediaria para ejecutar las acciones
 a peticion del usuario
 Autor:	Kplian (RAC)
 Fecha:	19/12/2012
 */
session_start();
//sanitizar variables
$titulo=$_GET['titulo'];

$log=$_GET['log'];

if(!isset($_SESSION['titulo'])){
	//si la variable no  fue definida
	$_SESSION['titulo'][0]=$titulo;
	$_SESSION['ML'.$titulo]=$log;
}
else{
	 $sw =false;
	 for($i=0 ; $i<count($_SESSION['titulo']); $i++)
  	{
		  if($_SESSION['titulo'][$i]==$titulo){
		  	
			$_SESSION['ML'.$titulo]=$_SESSION['ML'.$titulo]."<br>".$log;
			$sw = true;
			
		  }
  	}
	
	if(!$sw){
		$_SESSION['titulo'][$i]=$titulo;
        $_SESSION['ML'.$titulo]=$log;
	}
	//si ya fue definida
	//buscamos si ya esxiste el valor

}


?>
<html>
	<body>
		<h1>LOG DE ERRORES</h1>
		
		<?php 
		
		 for($i=0 ; $i<count($_SESSION['titulo']); $i++)
		  	{
				echo ("<h2>".$_SESSION['titulo'][$i]."</h2>");
				
				$titulo_var = $_SESSION['titulo'][$i];
				
				echo ("<p>".$_SESSION['ML'.$titulo_var]."</p>");
				
			}
		?>
		
		
	</body>
</html>
	