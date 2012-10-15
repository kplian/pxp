<?php
/**
*@package pXP
*@file ACTConfigurar.php
*@author  (mflores)
*@date 01-12-2011 11:30 am
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

include("../../sis_seguridad/control/adLDAP_2.0/adLDAP.php");

class ACTConfigurar extends ACTbase
{			
	function configurar()
	{					
		if($this->objParam->getParametro('autentificacion') == 'Contraseña WINDOWS')
		{
			$autentificacion = 'ldap';
		}
		else 
		{
			$autentificacion = 'local';
		}					
		
		$modificar_clave = $this->objParam->getParametro('modificar_clave');	
		$clave_anterior = $this->objParam->getParametro('clave_anterior');
		$clave_nueva = $this->objParam->getParametro('clave_nueva');
		$clave_confirmacion = $this->objParam->getParametro('clave_confirmacion');						
		$clave_windows = $this->objParam->getParametro('clave_windows');
		$estilo = $this->objParam->getParametro('estilo');			
					
		//$filter = "(&(objectCategory=person)(sAMAccountName=$usuario_LDAP))";
											
		//preguntamos el tipo de autentificacion
	    if($autentificacion == 'ldap')
	    {
	    	$LDAP=TRUE;						
			
			//$_SESSION["_CONTRASENA"]=md5($_SESSION["_SEMILLA"].$this->datos['contrasena']);
			$conex = ldap_connect($_SESSION["_SERVER_LDAP"],$_SESSION["_PORT_LDAP"]) or die ("No ha sido posible conectarse al servidor");			         							
			ldap_set_option($conex, LDAP_OPT_PROTOCOL_VERSION, 3);
						
			$servidor_LDAP = $_SESSION['_SERVER_LDAP'];
			//$servidor_LDAP = '10.10.0.17';
		    $servidor_dominio = $_SESSION["_DOMINIO"];
			$vec_serv_dom = explode('.', $servidor_dominio);			
		    $ldap_dn = "dc=$vec_serv_dom[0], dc=$vec_serv_dom[1]"; 		    		    
		    $usuario_LDAP = trim($_SESSION["_LOGIN"]);
		    $contrasena_LDAP = $clave_windows;					
			
			//$usuario_LDAP = 'marcos.flores';												
			//$filter = "samaccountname=$usuario_LDAP*";
			$filter = "uid=$usuario_LDAP*";					
									
			if ($conex) 
			{
				// bind with appropriate dn to give update access 
				$r_adm = ldap_bind($conex,trim('adm.endesis').'@'.$_SESSION["_DOMINIO"],addslashes(htmlentities(trim('Ad.ENDE.Sis56'),ENT_QUOTES)));
				//$r_adm = ldap_bind($conex,trim('ende\admin.ende').'@'.$_SESSION["_DOMINIO"],addslashes(htmlentities(trim('Mafv.4337'),ENT_QUOTES)));
				
				if($r_adm)
				{
					//echo 'entra'; exit;											
					$busqueda = ldap_search($conex, $ldap_dn, $filter);
					$entries = ldap_get_entries($conex, $busqueda); 
					
					echo var_dump($entries); exit;
		
					//if ($entries["count"] > 0) 
					//{			
						//ldap_unbind($conex);
						
						$conex1 = ldap_connect($_SESSION["_SERVER_LDAP"],$_SESSION["_PORT_LDAP"]) or die ("No ha sido posible conectarse al servidor");
						ldap_set_option($conex1, LDAP_OPT_PROTOCOL_VERSION, 3);
						ldap_set_option($conex1, LDAP_OPT_REFERRALS, 0);
						
						if ($conex1) 
						{
							$r = ldap_bind($conex1,trim($_SESSION["_LOGIN"]).'@'.$_SESSION["_DOMINIO"],addslashes(htmlentities(trim($clave_windows),ENT_QUOTES)));	
							//$r = ldap_bind($conex1,trim($_SESSION["_LOGIN"]).'@'.$_SESSION["_DOMINIO"]);
								
							/*try
							{
								if(ldap_bind($conex1,trim($_SESSION["_LOGIN"]).'@'.$_SESSION["_DOMINIO"],addslashes(htmlentities(trim($clave_windows),ENT_QUOTES))) === FALSE) throw new Exception("USUARIO NO REGISTRADO EN EL DOMINIO");
								$r = ldap_bind($conex1,trim($_SESSION["_LOGIN"]).'@'.$_SESSION["_DOMINIO"],addslashes(htmlentities(trim($clave_windows),ENT_QUOTES)));
							}
							catch(Exception $e)
							{
								echo 'Error: '.$e->getMessage();
							}	*/						
						}															
					/*} 
					else 
					{ 
						echo "Usuario no registrado"; 
					}*/
				}
								
			   	if ($r && trim($clave_windows)!= '') 
				{
	               $LDAP=TRUE;
				}
				else
				{
				   $LDAP=FALSE; 
				}
	
				ldap_close($conex1);				
			}
			else
			{
				$LDAP=FALSE;
			}
		}								
			
		$this->objFunc = new FuncionesSeguridad();
		$this->res=$this->objFunc->configurar($this->objParam);
		$this->datos=$this->res->getDatos();
		
		if($this->datos['autentificacion'] == 'local')
		{
			$_SESSION["_CONTRASENA"] = md5($_SESSION["_SEMILLA"].$this->datos['clave']);
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}									
}

?>