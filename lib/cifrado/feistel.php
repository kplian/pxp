<?php
class feistel{
	private $alfabeto;
	private $n=2;
	private $bloque=4;
	private  $tam_alfabeto = 64;
	function __construct(){
		//$this->alfabeto=array("0","1","2","3","4","5","6","7","8","9","."," ");
		$this->alfabeto=array("0","1","2","3","4","5","6","7","8","9","."," ",
		                       "q","w","e","r","t","y","u","i","o","p",
		                       "a","s","d","f","g","h","j","k","l",
		                       "z","x","c","v","b","n","m",
		                       "Q","W","E","R","T","Y","U","I","O","P",
		                       "A","S","D","F","G","H","J","K","L",
		                       "Z","X","C","V","B","N","M");
			
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
					//$auxi=$auxi.$this->caracterPosicion(($this->buscaPosicion($data{$i})+$k)%12);
					$auxi=$auxi.$this->caracterPosicion(($this->buscaPosicion($data{$i})+$k)%$this->tam_alfabeto);
                    
					
														
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
						//$var=$var+12;	
						
						$var=$var+$this->tam_alfabeto;				
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
		}
		elseif($caracter=="q"){
            return 12;
        }
		elseif($caracter=="w"){
            return 13;
        }
        elseif($caracter=="e"){
            return 14;
        }
        elseif($caracter=="r"){
            return 15;
        }
        elseif($caracter=="t"){
            return 16;
        }
        elseif($caracter=="y"){
            return 17;
        }
        elseif($caracter=="u"){
            return 18;
        }
        elseif($caracter=="i"){
            return 19;
        }
        elseif($caracter=="o"){
            return 20;
        }
        elseif($caracter=="p"){
            return 21;
        }
        elseif($caracter=="a"){
            return 22;
        }
        elseif($caracter=="s"){
            return 23;
        }
        elseif($caracter=="d"){
            return 24;
        }
        elseif($caracter=="f"){
            return 25;
        }
        elseif($caracter=="g"){
            return 26;
        }
        elseif($caracter=="h"){
            return 27;
        }
        elseif($caracter=="j"){
            return 28;
        }
        elseif($caracter=="k"){
            return 29;
        }
        elseif($caracter=="l"){
            return 30;
        }
        elseif($caracter=="z"){
            return 31;
        }
        elseif($caracter=="x"){
            return 32;
        }
        elseif($caracter=="c"){
            return 33;
        }
        elseif($caracter=="v"){
            return 34;
        }
        elseif($caracter=="b"){
            return 35;
        }
        elseif($caracter=="n"){
            return 36;
        }
        elseif($caracter=="m"){
            return 37;
        }
        elseif($caracter=="Q"){
            return 38;
        }
        elseif($caracter=="W"){
            return 39;
        }
        elseif($caracter=="E"){
            return 40;
        }
        elseif($caracter=="R"){
            return 41;
        }
        elseif($caracter=="T"){
            return 42;
        }
        elseif($caracter=="Y"){
            return 43;
        }
        elseif($caracter=="U"){
            return 44;
        }
        elseif($caracter=="I"){
            return 45;
        }
        elseif($caracter=="O"){
            return 46;
        }
        elseif($caracter=="P"){
            return 47;
        }
        elseif($caracter=="A"){
            return 48;
        }
        elseif($caracter=="S"){
            return 49;
        }
        elseif($caracter=="D"){
            return 50;
        }
        elseif($caracter=="F"){
            return 51;
        }
        elseif($caracter=="G"){
            return 52;
        }
        elseif($caracter=="H"){
            return 53;
        }
        elseif($caracter=="J"){
            return 54;
        }
        elseif($caracter=="K"){
            return 55;
        }
        elseif($caracter=="L"){
            return 56;
        }
        elseif($caracter=="Z"){
            return 57;
        }
        elseif($caracter=="X"){
            return 58;
        }
        elseif($caracter=="C"){
            return 59;
        }
        elseif($caracter=="V"){
            return 60;
        }
        elseif($caracter=="B"){
            return 61;
        }
        elseif($caracter=="N"){
            return 62;
        }
        elseif($caracter=="M"){
            return 63;
        }
       
        else{
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