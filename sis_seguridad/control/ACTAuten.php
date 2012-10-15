<?php
/***
 Nombre: ACTAuten.php
 Proposito: Verificar las credenciales de usario y validar la sesion si son correctas 
 Autor:	Kplian (RAC)
 Fecha:	14/7/2010
 */
class ACTAuten extends ACTbaseSeguridad {

	//Variables
	private $datos=array();
	private $primo1;
	private $primo2;
	private $clase;
	private $fei;
	private $llaves;

	/////////////
	//Constructor
	////////////
	function __construct(CTParametro $pParam){
		
		parent::__construct($pParam);
		
	}

	/////////
	//Metodos
	/////////
	
	//Genera las llaves publicas
	function getPublicKey(){
		//Se obtiene el primer primo
		
		$this->res=$this->funciones->ObtenerPrimo($this->objParam);
		//var_dump($this->res);exit;
		if($this->res->getTipo()=='ERROR'){
			
			$this->res->imprimirRespuesta($this->res->generarJson());
			exit;
		}

		$this->datos=array();
		$this->datos=$this->res->getDatos();
		$this->primo1=$this->datos[0]['primo'];

		//Se obtiene el segundo primo
		$this->res=$this->funciones->ObtenerPrimo($this->objParam);

		if($this->res->getTipo()=='ERROR'){
			$this->res->imprimirRespuesta($this->res->generarJson());
			exit;
		}

		$this->datos=$this->res->getDatos();
		$this->primo2=$this->datos[0]['primo'];

		//Se genero las llaves a partir de los primos
		$this->clase=new RSA();
		$this->llaves=$this->clase->generate_keys($this->primo1,$this->primo2);

		//Se obtiene los feistel
		$this->fei=new feistel();
		$_SESSION['key_k']=$this->fei->generarK();
		$_SESSION['key_p']=$this->fei->generarPi();
		$_SESSION['key_p_inv']=$this->fei->inversaPi($_SESSION['key_p']);

		//Se guarda las llaves asincronas
		$_SESSION['key_m']=$this->llaves[0];
		$_SESSION['key_d']=$this->llaves[2];
		$_SESSION['key_e']=$this->llaves[1];
		//echo 'asdasd';exit;
		
		/*
		echo 'key_k '.$_SESSION['key_k'].' #';
		echo 'key_p '.$_SESSION['key_p'].' #';
		echo 'key_p_inv '.$_SESSION['key_p_inv'].' #';
		echo 'key_m '.$_SESSION['key_m'].' #';
		echo 'key_d '.$_SESSION['key_d'].' #';
		echo 'key_e '.$_SESSION['key_e'].' #';*/
		
		
		/*if($_SESSION["_SESION"] instanceof CTSesion){

		} else{
		throw new Exception('no es sesion',1);
		}*/
		$_SESSION["_SESION"]->setEstado("preparada");
		
		
		$x=0;
	    if($_SESSION["encriptar_data"]=='si'){
	    	$x=1;
	    }
		$_SESSION['_p']=$this->fei->aumenta1($_SESSION['key_p']);

		//Devuelve la respuesta
		echo "{success:true,
		    m:'".$this->llaves[0]."',
			e:'".$this->llaves[1]."',
			k:'".$_SESSION['key_k']."',
			p:'".$_SESSION['_p']."',
			x:".$x."}";
		exit;

	}

	//Verifica las credenciales de usuario
	
	function verificarCredenciales(){
		

		$this->res=$this->funciones->ValidaUsuario($this->objParam);
		$this->datos=$this->res->getDatos();


		if($this->res->getTipo()=='Error' || $this->datos['cuenta']==''){
			//si no existe le mando otra vez a la portada
			$_SESSION["autentificado"] = "NO";
			$_SESSION["ss_id_usuario"] = "";
			$_SESSION["ss_id_lugar"] = "";
			$_SESSION["ss_nombre_lugar"] = "";
			$_SESSION["ss_nombre_empleado"] = "";
			$_SESSION["ss_paterno_empleado"] = "";
			$_SESSION["ss_materno_empleado"] = "";
			$_SESSION["ss_nombre_usuario"] = "";
			$_SESSION["ss_id_empleado"] = "";
			$_SESSION["ss_nombre_basedatos"] = "";
			$_SESSION["ss_ip"] = "";
			$_SESSION["ss_mac"] = "";

           echo "{success:false,mensaje:'".addslashes($this->res->getMensaje())."'}";
			exit;
		}
		else{
			$LDAP=TRUE;
			
			//preguntamos el tipo de autentificacion
            if($this->datos['autentificacion']=='ldap'){
				
				$_SESSION["_CONTRASENA"]=md5($_SESSION["_SEMILLA"].$this->datos['contrasena']);
				$conex = ldap_connect($_SESSION["_SERVER_LDAP"],$_SESSION["_PORT_LDAP"]) or die ("No ha sido posible conectarse al servidor");
				ldap_set_option($conex, LDAP_OPT_PROTOCOL_VERSION, 3);
				
				if ($conex) { 
						   // bind with appropriate dn to give update access 
					$r=ldap_bind($conex,trim($this->objParam->getParametro('usuario')).'@'.$_SESSION["_DOMINIO"],addslashes(htmlentities(trim($this->objParam->getParametro('contrasena')),ENT_QUOTES))); 
	
				   if ($r && trim($this->objParam->getParametro('contrasena'))!= '') 
					{
                       $LDAP=TRUE;
					}
					else{
					   $LDAP=FALSE; 
					}

					ldap_close($conex);
					
				}
				else{
					$LDAP=FALSE;
				} 
	
			}
			
			
		 //si falla la autentificacion LDAP cerramos sesion
		 if(!$LDAP){
		 	$_SESSION["autentificado"] = "NO";
				$_SESSION["ss_id_usuario"] = "";
				$_SESSION["ss_id_lugar"] = "";
				$_SESSION["ss_nombre_lugar"] = "";
				$_SESSION["ss_nombre_empleado"] = "";
				$_SESSION["ss_paterno_empleado"] = "";
				$_SESSION["ss_materno_empleado"] = "";
				$_SESSION["ss_nombre_usuario"] = "";
				$_SESSION["ss_id_empleado"] = "";
				$_SESSION["ss_nombre_basedatos"] = "";
				$_SESSION["ss_ip"] = "";
				$_SESSION["ss_mac"] = "";
	
		 }
		 else{
			$_SESSION["autentificado"] = "SI";
	        $_SESSION["ss_id_usuario"] = $this->datos['id_usuario'];
			$_SESSION["ss_id_funcionario"] = $this->datos['id_funcionario'];
			$_SESSION["_SESION"]->setIdUsuario($this->datos['id_usuario']);
			//cambia el estado del Objeto de sesion activa
			$_SESSION["_SESION"]->setEstado("activa");
			
			
			
		    if($_SESSION["_ESTADO_SISTEMA"]=='desarrollo'){
	          $_SESSION["mensaje_tec"]=true;
	     	}
			else{
	          $_SESSION["mensaje_tec"]=false;
			}
			$mres = new Mensaje();		
			if($_SESSION["_OFUSCAR_ID"]=='si'){
				$id_usuario_ofus = $mres->ofuscar(($this->datos['id_usuario']));
				$id_funcionario_ofus = $mres->ofuscar(($this->datos['id_funcionario']));
			}
			else{
				$id_usuario_ofus = $this->datos['id_usuario'];
				$id_funcionario_ofus = $this->datos['id_funcionario'];
			}
			
			
			////
			
			$_SESSION["_CONT_ALERTAS"] = $this->datos['cont_alertas'];
			$_SESSION["_NOM_USUARIO"] = $this->datos['nombre']." ".$this->datos['apellido_paterno']." ".$this->datos['apellido_materno'];
			$_SESSION["_ID_USUARIO_OFUS"] = $id_usuario_ofus;
			$_SESSION["_ID_FUNCIOANRIO_OFUS"] = $id_funcionario_ofus;
			$_SESSION["_AUTENTIFICACION"] = $this->datos['autentificacion'];
			$_SESSION["_ESTILO_VISTA"] = $this->datos['estilo'];
		    	
			echo "{success:true,
			cont_alertas:".$_SESSION["_CONT_ALERTAS"].",
			nombre_usuario:'".$_SESSION["_NOM_USUARIO"]."',
			nombre_basedatos:'".$_SESSION["_BASE_DATOS"]."',
			id_usuario:'".$_SESSION["_ID_USUARIO_OFUS"]."',
			id_funcionario:'".$_SESSION["_ID_FUNCIOANRIO_OFUS"]."',
			autentificacion:'".$_SESSION["_AUTENTIFICACION"]."',
			estilo_vista:'".$_SESSION["_ESTILO_VISTA"]."',
			mensaje_tec:'".$_SESSION["mensaje_tec"]."',
			timeout:".$_SESSION["_TIMEOUT"]."}";

			exit;
		 }
		}
	}
	
}
?>
