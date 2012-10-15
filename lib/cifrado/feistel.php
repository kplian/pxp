<?php
class feistel{
	private $alfabeto;
	private $n=2;
	private $bloque=4;
	function __construct(){
		$this->alfabeto=array("0","1","2","3","4","5","6","7","8","9","."," ");
			
	}
	function generarPi(){
		$pi='';
		$var=0;
		while(strlen($pi)<$this->bloque){
			$var=rand(0,$this->bloque-1);
			if(preg_match((String)"/".$var."/",(String)$pi)==0){
				$pi=$pi.(String)$var;
			}
		}
		return $pi;
	}
	function aumenta1($pi){
		$res='';
		for($i=0;$i<strlen($pi);$i++){
			$res=$res.(String)((int)$pi{$i}+1);
		}
		return $res;
	}
	
	
	
	function generarK(){
		return(rand(1,9));
		
	}
	function inversaPi($pi){
		
		$inversa=$pi;
		for($i=0;$i<strlen($pi);$i++){
			
			$inversa{(int)$pi{$i}}=$i;
			//echo $inversa."<BR>";
			
			
		}
		return $inversa;
	}
	function cifrar($arreglo,$pi,$k,$tipo){
		$res=array();
		$auxi='';
		foreach ($arreglo as $data){
			if($tipo==1){
			$auxi='';}
			else{
				$auxi=$data;
			}
			
			for($i=0;$i<strlen($data);$i++){
				if($tipo==1){
					$auxi=$auxi.$this->caracterPosicion(($this->buscaPosicion($data{$i})+$k)%12);
														
				}
				else{
					
					$auxi{(int)$pi{$i}}=$data{$i};
			
				}
			}
			if($tipo==1){
			$aux2=$auxi;}
			else{
				$aux2='';
			}
			
			for($i=0;$i<strlen($data);$i++){
				
				if($tipo==1){
				$aux2{(int)$pi{$i}}=$auxi{$i};
				}
				else{
				$var=$this->buscaPosicion($auxi{$i})-$k;
					if($var<0){
						$var=$var+12;					
					}
					$aux2=$aux2.$this->caracterPosicion($var);
				}
			}
			//echo $aux2;
			
			array_push($res,$aux2);
		}
		return $res;
		
	}
	function buscaPosicion($caracter){
		if($caracter=="."){
			return 10;
		}
		elseif($caracter==" "){
			return 11;
		}else{
			return (int)$caracter;
		}
	}
	function caracterPosicion($pos){
		return($this->alfabeto[$pos]);
	}
	
	//recibe cadena la cadena a encriptar o desencriptar
	//pi es el bloque de permutacion
	//k 
	// tipo 2 desncriptar 1 encriptar
	function encriptar($cad,$pi,$k,$tipo){
		
		$max     = strlen($cad);
        $packets = ceil($max/$this->bloque);
        $vuelta=0;
        $izquierda=array();
        $derecha=array();
        $aux=array();
        $res=array();
        $encriptada='';
        $cadena=$cad;
        //aumenta espacions en blanco
        for($i=$max;$i<$packets*$this->bloque;$i++){
        	$cadena=$cadena." ";
        }
       
        //lleva los bloques de la cadena a los arreglos izquierda y derecha, los pares a la izquierda
        //y los impares a la derecha
		for($i=0; $i<$packets; $i++){
        	if($i%2==0){
        		array_push($izquierda,substr($cadena, $i*$this->bloque, $this->bloque));
        		
        	}
        	else{
        		array_push($derecha,substr($cadena, $i*$this->bloque, $this->bloque));
        		
        	}
				
        }
        /*Si es par llama la funcion cifrar para el arreglo izquierda
        sino llama para el arreglo derecha*/
        for($i=0;$i<$this->n;$i++){
        	
        	if($i%2==0){
        		
        			$izquierda=$this->cifrar($izquierda,$pi,$k,$tipo);	
        		
        	}
        	else
        	{        		
        			$derecha=$this->cifrar($derecha,$pi,$k,$tipo);
        		        		       		       		
        	}
        }
        
        
        //RAC 25/10/2011: variale n  no utilizaba this->n  
        if($this->n%2==0){
        	$aux=$izquierda;
        	$izquierda=$derecha;
        	$derecha=$aux;
        }
        
        $res=$this->unirArreglos($izquierda,$derecha);
        $textci=$this->convierteCadena($res);
        if($tipo==2){
        	$textci=trim($textci);
        }
        return $textci;
	}
	
	function unirArreglos($izq,$der){
		$res=array();
		$tam=count($der);
		//echo $tam;
		for($i=0;$i<=$tam;$i++){
			
			if(isset($izq[$i])){
				array_push($res,$izq[$i]);
				
			}
			
			if(isset($der[$i])){
				array_push($res,$der[$i]);
				
			}
			
		}
		return $res;
		
	}
	
	function convierteCadena($arre){
		$otro='';
		
		foreach ($arre as $data){
			//echo $data;
			$otro=$otro.$data;
		}
		return $otro;
	}
	
	
    
        
}
	
	
	
	
?>