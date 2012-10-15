<?php
	$script = fopen('dump.sql', 'r');
	$functionString = '';
	$functionName = '';
	while (($line = fgets($script, 4096)) !== false) {
		
        if (strpos($line, 'CREATE FUNCTION')!== false) {
        	
        	if ($functionName != '') {
        		//tengo que crear un nuevo archivo con el nombre de la funcion
        		$newFile = fopen('funciones/'.$functionName.'.sql', 'w');
				fwrite($newFile, $functionString);
				fclose($newFile);
        	}
			$functionString = $line;
						
			$functionString = str_replace('CREATE FUNCTION', 'CREATE OR REPLACE FUNCTION', $functionString);
			$myArray = explode('.', $functionString);
			$functionName = substr($myArray[1], 0, strlen($myArray[1]) - 3 );
			$functionName = trim($functionName);
        } else {
        	$functionString .= $line;
        }
		
    }
	if ($functionName != '') {
		//tengo que crear un nuevo archivo con el nombre de la funcion
		$newFile = fopen('funciones/'.$functionName.'.sql', 'w');
		fwrite($newFile, $functionString);
		fclose($newFile);
	}
	echo 'Fin de creacion de archivos';
	exit;

?>
