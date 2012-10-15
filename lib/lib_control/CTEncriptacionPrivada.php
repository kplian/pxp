<?php
/***
 Nombre: CTEncriptacionPrivada.php
 Proposito: Clase que realiza la encriptacion y desencriptacion
 Autor:	Kplian (RCM)
 Fecha:	05/07/2010
 */
class CTEncriptacionPrivada{
	
	//Variables
	private $Cadena;
	private $key_p; //Feistel
	private $key_k; //Feistel
	private $key_d; //RSA
	private $key_m; //RSA
	private $iFeis;
	private $iRsa;
	private $Decodificado;
	
	//Constructor
	function __construct($pCadena,$pKeyP,$pKeyK,$pKeyD,$pKeyM){
		$this->Cadena=$pCadena;
		$this->key_p=$pKeyP;
		$this->key_k=$pKeyK;
		$this->key_d=$pKeyD;
		$this->key_m=$pKeyM;
		//echo 'cadena:'.$this->Cadena.' keyp:'.$this->key_p.'   keyk:'.$this->key_k.'   keyd:'.$this->key_d.'   keym:'.$this->key_m;
		//exit;
		
		$this->iFeis=new feistel();
		$this->Decodificado=$this->iFeis->encriptar($this->Cadena,$this->key_p,$this->key_k,2);
		//echo 'decod:'.$this->Decodificado;
		//exit;
		$this->iRsa = new RSA(); 
		$this->Decodificado = $this->iRsa->decrypt ($this->Decodificado, $this->key_d,$this->key_m);
		//echo 'decod:'.$this->Decodificado;
		//exit;
	}
	
	//Metodos
	function getDecodificado(){
		return $this->Decodificado;
	}
	
}


?>