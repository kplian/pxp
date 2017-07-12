<?php
/***
 Nombre: ACTAuten.php
 Proposito: Verificar las credenciales de usario y validar la sesion si son correctas 
 Autor:	Kplian (RAC)
 Fecha:	14/7/2010
 */
class ACTAuten extends ACTbase {

	//Variables
	private $datos=array();
	private $primo1;
	private $primo2;
	private $clase;
	private $fei;
	private $llaves;
	private $cls_primo1;
	private $cls_primo2;
	

	/////////////
	//Constructor
	////////////
	function __construct(CTParametro &$pParam){
		
		
		parent::__construct($pParam);	
		
			
		
	}

	////////////////
	//   Metodos
	////////////////
	
	function prepararLlavesSession(){
		//Se obtiene el primer primo
		$this->funciones= $this->create('MODSesion');
		$this->res=$this->funciones->prepararLlavesSession();
		
		//echo 'resp:'.$this->res;exit;
		if($this->res->getTipo()=='ERROR'){
			$this->res->imprimirRespuesta($this->res->generarJson());
			exit;
		}

		$this->datos=array();
		$this->datos=$this->res->getDatos();
		$this->primo1=$this->datos[0]['primo'];  
		//setea las llaves en variables de session ....	
		$_SESSION['key_k']=$this->datos[0]['m'];
		$_SESSION['key_p']=$this->datos[0]['e'];
		$_SESSION['key_p_inv']=$this->datos[0]['k'];
		$_SESSION['key_m']=$this->datos[0]['p'];
		$_SESSION['key_d']=$this->datos[0]['x'];
		$_SESSION['key_e']=$this->datos[0]['z'];
		
		$_SESSION["_SESION"]= new CTSesion();
		//Se obtiene los feistel
		$this->fei=new feistel();
		$_SESSION["_SESION"]->setEstado("preparada");	
		$_SESSION['_p']=$this->fei->aumenta1($_SESSION['key_p']);
		
		

		//Devuelve la respuesta
		echo "{success:true}";
		exit;

	}
	//Genera las llaves publicas
	function getPublicKey(){
		//Se obtiene el primer primo
		$this->funciones= $this->create('MODPrimo');
		$this->res=$this->funciones->ObtenerPrimo();
		
		
		//echo 'resp:'.$this->res;exit;
		if($this->res->getTipo()=='ERROR'){
			
			$this->res->imprimirRespuesta($this->res->generarJson());
			exit;
		}

		$this->datos=array();
		$this->datos=$this->res->getDatos();
		$this->primo1=$this->datos[0]['primo'];
   
		//Se obtiene el segundo primo
		$this->res=$this->funciones->ObtenerPrimo();

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


		
		$this->funciones= $this->create('MODUsuario');
		$this->res=$this->funciones->ValidaUsuario();
		$this->datos=$this->res->getDatos();
        $this->oEncryp=new CTEncriptacionPrivada($this->objParam->getParametro('contrasena'),$_SESSION['key_p'],$_SESSION['key_k'],$_SESSION['key_d'],$_SESSION['key_m']);



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
			$_SESSION["ss_id_funcionario"] = "";
			$_SESSION["ss_id_cargo"] = "";
			$_SESSION["ss_nombre_basedatos"] = "";
			$_SESSION["ss_id_persona"] = "";
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
					$r=ldap_bind($conex,trim($this->objParam->getParametro('usuario')).'@'.$_SESSION["_DOMINIO"],$this->oEncryp->getDecodificado());
	
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
				$_SESSION["ss_id_funcionario"] = "";
				$_SESSION["ss_id_cargo"] = "";
				$_SESSION["ss_nombre_basedatos"] = "";
				$_SESSION["ss_id_persona"] = "";
				$_SESSION["ss_ip"] = "";
				$_SESSION["ss_mac"] = "";
	
		 }
		 else{
			$_SESSION["autentificado"] = "SI";
	        $_SESSION["ss_id_usuario"] = $this->datos['id_usuario'];
	        
			$_SESSION["ss_id_funcionario"] = $this->datos['id_funcionario'];
			$_SESSION["ss_id_cargo"] = $this->datos['id_cargo'];
			$_SESSION["ss_id_persona"] = $this->datos['id_persona'];
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
			$_SESSION["_CONT_INTERINO"] = $this->datos['cont_interino'];
			$_SESSION["_NOM_USUARIO"] = $this->datos['nombre']." ".$this->datos['apellido_paterno']." ".$this->datos['apellido_materno'];
			$_SESSION["_ID_USUARIO_OFUS"] = $id_usuario_ofus;
			$_SESSION["_ID_FUNCIOANRIO_OFUS"] = $id_funcionario_ofus;
			$_SESSION["_AUTENTIFICACION"] = $this->datos['autentificacion'];
			$_SESSION["_ESTILO_VISTA"] = $this->datos['estilo'];
			
			if(!isset($_SESSION["_SIS_INTEGRACION"])){
			    $sis_integracion = 'NO';
			}
            else{
                  $sis_integracion = $_SESSION["_SIS_INTEGRACION"];
            }
			
			
			if(isset($_SESSION["ss_id_cargo"]) && $_SESSION["ss_id_cargo"] !=''){
				
				$id_cargo = $_SESSION["ss_id_cargo"];
			}
			else{
				$id_cargo = 0;
			}
			

			if($_SESSION["_tipo_aute"] != 'REST'){
				//almacena llave ....
				$_SESSION["_SESION"]->actualizarLlaves($_SESSION['key_k'], $_SESSION['key_p'], $_SESSION['key_p_inv'], $_SESSION['key_m'], $_SESSION['key_d'], $_SESSION['key_e']);
			}
			$logo = str_replace('../../../', '', $_SESSION['_MINI_LOGO']);
			$logo = ($_SESSION["_FORSSL"]=="SI") ? 'https://' : 'http://' . $_SERVER['HTTP_HOST'] . $_SESSION["_FOLDER"] . $logo;
		    //cualquier variable que se agregue aqui tb debe ir en sis_seguridad/vista/_adm/resources/Phx.CP.mmain.php
		    if ($this->objParam->getParametro('_tipo') != 'restAuten') {	
				echo "{success:true,
				id_cargo:".$id_cargo.",
				cont_alertas:".$_SESSION["_CONT_ALERTAS"].",
				cont_interino:".$_SESSION["_CONT_INTERINO"].",
				nombre_usuario:'".$_SESSION["_NOM_USUARIO"]."',
				nombre_basedatos:'".$_SESSION["_BASE_DATOS"]."',
				mini_logo:'".$_SESSION["_MINI_LOGO"]."',
				icono_notificaciones:'" . $logo . "',				
				id_usuario:'".$_SESSION["_ID_USUARIO_OFUS"]."',
				id_funcionario:'".$_SESSION["_ID_FUNCIOANRIO_OFUS"]."',
				autentificacion:'".$_SESSION["_AUTENTIFICACION"]."',
				estilo_vista:'".$_SESSION["_ESTILO_VISTA"]."',
				mensaje_tec:'".$_SESSION["mensaje_tec"]."',
				sis_integracion:'".$sis_integracion."',
				puerto_websocket:'".$_SESSION["_PUERTO_WEBSOCKET"]."',
				timeout:".$_SESSION["_TIMEOUT"]."}";
	
				exit;
			}
		 }
		}
	}
	
	function cerrarSesion(){
	    session_unset();
        session_destroy(); // destruyo la sesion 
        header("Location: /"); 
        echo "{success:true}";
    }
	
}
?>