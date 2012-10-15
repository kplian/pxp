<?php
/**
*@package pXP
*@file MODConfigurar.php
*@author  (mflores)
*@date 01-12-2011 11:31 am
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODConfigurar extends MODbase
{	
	function __construct(CTParametro $pParam)
	{
		parent::__construct($pParam);
	}			
				
	function configurar()
	{		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_configurar_ime';
		$this->transaccion='SG_CONF_MOD';
		$this->tipo_procedimiento='IME';
		
		$this->arreglo['clave_anterior'] = md5($this->arreglo['clave_anterior']);
		$this->arreglo['clave_nueva'] = md5($this->arreglo['clave_nueva']);
		$this->arreglo['clave_confirmacion'] = md5($this->arreglo['clave_confirmacion']);
		$this->arreglo['clave_windows'] = md5($this->arreglo['clave_windows']);			
				
		//Define los parametros para la funcion
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('clave_anterior','clave_anterior','varchar');
		$this->setParametro('clave_nueva','clave_nueva','varchar');
		$this->setParametro('clave_confirmacion','clave_confirmacion','varchar');
		$this->setParametro('clave_windows','clave_windows','varchar');
		$this->setParametro('estilo','estilo','varchar');
		$this->setParametro('autentificacion','autentificacion','varchar');
		$this->setParametro('modificar_clave','modificar_clave','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();		

		//Devuelve la respuesta
		return $this->respuesta;
	}				
}
?>