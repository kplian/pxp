<?php
/**
 * *********************************
 * 
 * Clase:conexion
 * Descripcion: Conexion y desconexion de bases de datos postgersql(conexiones persistenes)
 */
// Esta es la variable que indica el host del servidor Postgres
	$_SESSION["_HOST"] = "localhost";
	//$HOST = "192.168.1.8";
	//Puerto
	$_SESSION["_PUERTO"] = "5432";
	
	//la palabra utilizada como semilla tambien debe configurarce y coincidir exactamente  
	//en el triger de creacion de usuarios
	$_SESSION["_SEMILLA"] = "+_)(*&^%$#@!@TERPODO"; 
	                       
	
	$_SESSION["_SEMILLA_OFUS"] = "1611829075654";
	
	//nombre carpeta donde se aloja el framewoek en el servidor web
	//la cokies solamente son admitidas en esta direccion
	//$_SESSION["_FOLDER"] = "/web/lib/lib_control/";
	$_SESSION["_FOLDER"] = "/kerp-boa/";
	
	//nombre carpeta de logs de postgres
	$_SESSION["_FOLDER_LOGS_BD"] = "/var/lib/pgsql/9.1/data/pg_log/";
	
	//nombre base de los archivos de los logs de base de datos el nombre del archivo sera :
	//$_SESSION["_NOMBRE_LOG_BD"].-%Y-%m-%d.log
	$_SESSION["_NOMBRE_LOG_BD"] ="postgresql";

		// Esta es la variable que indica el usuario del servidor Postgres
	$_SESSION["_USUARIO_CONEXION"] = "conexion" ;
	// Esta es la variable que indica la contrasena del usuario de Postgres
	$_SESSION["_CONTRASENA_CONEXION"]	= "dbkerp_conexion" ;
	
	//DOMINIO PARA AUTENTIFICACION LDAP
		$_SESSION["_DOMINIO"] = 'kplian.com';
	//servidor de autenticacion ldap en el dominio especificado 
	$_SESSION["_SERVER_LDAP"] = '10.10.0.32';
	//puerto de autenticacion ldap
	$_SESSION["_PORT_LDAP"] = '389';
	
	
	//$CONTRASENA	= "1234" ;
	// Esta es la variable que indica la base de datos a utilizar
	$_SESSION["_BASE_DATOS"]= "dbkerp";
	
	$_SESSION["codificacion_xml"] = "UTF-8";//latin 9 
	
	$_SESSION["codificacion_header"] = "UTF-8";//Latin 9
	//$_SESSION["CODIFICACION_HEADER"] = "utf-8";
	
	// Usuarios administradores, el rol de administracion solo 
	// puede ejecutarse desde estas direcciones IP
	//$_SESSION["_IP_ADMIN"]=array('10.100.105.64','10.100.105.57','10.100.105.51','10.100.105.52','10.100.105.50','10.100.105.59','192.168.3.0','192.168.2.236','192.168.122.101','192.168.1.195','192.168.1.3','192.168.0.31','192.168.1.28','192.168.1.243','192.168.1.220','192.168.2.90','192.168.1.21','192.168.1.17','192.168.1.250','192.168.3.233','10.100.105.53','10.100.105.58','10.100.105.54','192.168.1.5','10.100.105.69');
	
	
	//Estuilo de iconos utilizados en la barra de herramientas
	// icono_dibu, icono, icono_byn, icono_inc, icono_awesome
	$_SESSION['_ESTILO_MENU']='icono_awesome';
	
	//varciale que determina el cotexto del sistema
	//para determinar la claridad de los errores
	// [desarrollo,produccion]
	$_SESSION["_ESTADO_SISTEMA"] = "desarrollo";  //produccion
	
	
	//$_SESSION["CODIFICACION_HEADER"] = "utf-8";
	
	$_SESSION["type_header"] = "text/x-json";
	
	//Metodo de envio de datos
	//$_SESSION["metodo_envio"]="post";   
	
	//Variable que determina si la vista mandara los datos encriptado o no
	$_SESSION["encriptar_data"]='no'; 
	
	//Variable que determina si los identificadores de registro seran ofuscados o no
	$_SESSION["_OFUSCAR_ID"]='si'; 
	
	//Variable para definir el tipo de conexion
	//persistente  ,  no_persistente
	$_SESSION["_TIPO_CONEXION"]='no_persistente';
	
	//variable para tomar 
	$_SESSION['cantidad_reportes']=200;
	$_SESSION['fecha_pie']=false;
	
	
	
	//tiempo de espera para la interfaces javascript en el cliente
	$_SESSION["_TIMEOUT"]=200000;
	$_SESSION['color_fill_reportes']='#F2F2F2';
	
	
	//Para obligar conexiones ssl [SI, NO]
	
	$_SESSION["_FORSSL"]="NO"; 
	/*DoS para denegacion de servicio*/
	
	//habilitar el control de DoS
	$_SESSION['_CRT_DOS']='NO';
	//la cantidad de datos que se almacenan en la pila
	$_SESSION['_TAM_MAX']=10;
	//segundos ultima transaccion sospechosa
	$_SESSION['_SEG_DOS']=0;
	//mili segundos ultima transaccion sospechosa
	$_SESSION['_MSEG_DOS']=0.3;
	//peso maximo para considerar una trasaccion como sospechosa 
	$_SESSION["_PESOMAX_DOS"]=9;

	//Para el generador
    $_SESSION["_QUITAR_CANT_PREFIJO_TABLA"]='si'; // si|no
    $_SESSION["_CANT_PREFIJO_TABLA"]=1; 
    $_SESSION["_PREFIJO_TABLA"]='ft_';
	
	
	//datos de correo elecronico
    $_SESSION["_CUENTA_MAIL"]='user@tudomiino.com';

	//---------------WEBSOCKET----------------------------------//
	//por defecto es el puerto 8010 en caso de que tengas mas pxp ejemplo un vps con varios pxp entonces considerar otros puertos
	//puertos recomendados 8010 a 8079
	$_SESSION['_PUERTO_WEBSOCKET']= 8010;

	//--------------- TITULOS ----------------------------------//
	
	$_SESSION['_TITULO_SIS_LARGO']="FRAMEWORK PARA DESARROLLO DE SOFTWARE";
	$_SESSION['_TITULO_SIS_CORTO']=" DESARROLLO ÁGIL";
	$_SESSION['_NOMBRE_SIS']="PXP";
	$_SESSION['_REP_NOMBRE_SISTEMA']='GEMA - Gestión de Mantenimiento';
 	
	
	  $_SESSION['_PLANTIILA']= "<tr height=\"20%\">
        <td width=\"100%\">
          <p align=\"center\">
           <font color=\"black\" SIZE=6>".$_SESSION['_TITULO_SIS_LARGO']."</font>
          </p>
	      <br/>
	      <p align=\"center\"><font color=\"black\" SIZE=4>".$_SESSION['_TITULO_SIS_CORTO']."</font></p>
          <div align=\"center\"><strong><h1><font color=\"black\" SIZE=8>".$_SESSION['_NOMBRE_SIS']."</font></strong></h1></div>
        </td>
       </tr>";
	
	
	//-------------------  LOGOTIPOS--------------------------//
	
	//Tiene que ser una imagen que pueda ser bien vista a un tamaño de 35*15
	//$_SESSION['dir_logo']='../../images/logo_reporte.jpg'; 
	
	$_SESSION['_DIR_FAV_ICON']='../../../lib/images/favicon.ico';
	  
	$_SESSION['_DIR_LOGO']='/imagenes/logos/logo.png'; 
	
	$_SESSION['_MINI_LOGO']='../../../lib/imagenes/kplian2.jpg';
	
	$_SESSION['_DIR_IMAGEN_INI']='../../../lib/imagenes/fondo_ini.jpg';
	
	$_SESSION['_DIR_FABICON']='../../images/logo_reporte.jpg';
	
	$_SESSION['_DIR_BACKGROUND_LOGIN']='../../../recursos/imagenes/Logo.png';
	
	//-----------------CORREO ELECTRONICO----------------------//
    
    $_SESSION['_MAIL_USUARIO']='kplian@gmail.com';
    $_SESSION['_MAIL_PASSWORD']='password...';
    $_SESSION['_MAIL_REMITENTE']='kplain@gmail.com';
    $_SESSION['_NOMBER_REMITENTE']='Sistema ERP';
	$_SESSION['_MAIL_PRUEBAS']='kplain@gmail.com';    
    $_SESSION['_MAIL_SERVIDOR']='smtp.gmail.com';
    $_SESSION['_MAIL_PUERTO']=587;
    $_SESSION['_MAIL_AUTENTIFICACION']=true;
    $_SESSION['_SMTPSecure']='tls';
    
     //-----correos de notificaciones---------//
    $_SESSION['_MAIL_NITIFICACIONES_1']='dcastro@boa.bo';//se utiliza para enviar correo al area legal 
    
   
   // EL SSITEMA SE INTEGRA CON  OTROS----------------------------------------------------
    //esto puede activa o desactivar funcionalidad en otros sistemas
    //ENDESIS, NO, (SE PUEDEN ANHADIR SEGUN NECSIDAD)
    //tiene que estar sincronizado con la variable global en base de datos
    $_SESSION['_SIS_INTEGRACION']='NO'; 

     // Si se incluira la libreria de google maps o no al cargar la pagina de inicio ,posibles valores:  si|no
     $_SESSION["_INCLUDE_GMAPS"] = 'no';

	//REST clases que no necesitan la vaidacion de permisos de sesion
	$_SESSION['_REST_NO_CHECK'] = array('/parametros/Alarma/confirmarAcuseRecibo',
	                                    '/parametros/Alarma/otro');

	
?>
