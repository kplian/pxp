#!/usr/bin/python
import sys
import os
import datetime
from git import Repo
from clsRestauracionBD import clsRestauracionBD

#Funcion para desplegar el menu del utilitario
def menu():
	print 'Opciones'
	print '========'
	print '1. Inicializar un nuevo Workspace'
	print '2. Abrir aplicación para restauración de BD'
	print '3. Salir'
	
	mnuOpcion = raw_input('Ingrese una opcion (1,2 o 3): ')
	if mnuOpcion == '1':
		mnuWorkSpace()
	elif  mnuOpcion == '2':
		print 'Opción 2'
	else:
		sys.exit("Utilitario finalizado por usuario")

def mnuWorkSpace():
	global strBDusuarioCnx, strHost, intBDpuerto, strBDfolderLog, strBDnombre, strWSruta
	global strWSnombre, strBDpwdUsuarioCnx
	print 'Inicializando Workspace'
	print '-----------------------'
	strWSnombre = raw_input('Introduzca el nombre del Workspace: ')
	#Forma el valor por defecto de la base de datos
	strBDnombre = 'db'+strWSnombre.lower()
	aux = raw_input('Introduzca la ruta para el Workspace (/var/www/html/): ')
	if aux != '':
		strWSruta = aux
	aux=''
	aux = raw_input('Introduzca Nombre base de datos ('+strBDnombre+'): ')
	if aux != '':
		strBDnombre = aux
	aux=''
	aux = raw_input('Introduzca Nombre de Usuario para conexión a la BD (conexion):')
	if aux != '':
		strBDusuarioCnx = aux
	aux=''
	strBDpwdUsuarioCnx = 'db'+strWSnombre.lower()+'_conexion'
	aux = raw_input('Introduzca Password para Usuario de conexión a la BD ('+strBDpwdUsuarioCnx+'): ')
	if aux != '':
		strBDpwdUsuarioCnx = aux
	aux=''
	aux = raw_input('Introduzca Host de la BD (localhost):')
	if aux != '':
		strHost = aux
	aux=''
	aux = raw_input('Introduzca el puerto de la BD (5432): ')
	if aux != '':
		intBDpuerto = aux
	aux=''
	aux = raw_input('Introduzca destino del log de BD (/var/lib/pgsql/9.1/data/pg_log/): ')
	if aux != '':
		strBDfolderLog = aux
		
	print 'Workspace: ' + strWSnombre
	print 'Ruta: ' + strWSruta
	print 'Nombre de base de datos: ' + strBDnombre
	print 'Usuario Conexión BD: ' + strBDusuarioCnx
	print 'Password usuario conexión BD: ' + strBDpwdUsuarioCnx
	print 'Host BD: ' + strHost
	print 'Puerto BD: ' + intBDpuerto
	print 'Destino Log BD: ' + strBDfolderLog
	
	aux = raw_input('¿Está seguro de inicializar el Workspace? (si/no)')
	if aux=='no':
		sys.exit("Utilitario finalizado por usuario")
	#Creación del workspace
	initWorkSpace(strWSnombre,strWSruta,strBDnombre,strBDusuarioCnx,strBDpwdUsuarioCnx)
	##crearArchivoConf(strWSnombre,strWSruta,strBDnombre,strBDusuarioCnx,strBDpwdUsuarioCnx)
	#Restauración inicial de la base de datos
	objResBD = clsRestauracionBD()
	print 'Restaurando base de datos: '+strBDnombre
	objResBD.setDBname(strBDnombre)
	objResBD.setDBusrCnx(strBDusuarioCnx)
	objResBD.setDBpwdUsrCnx(strBDpwdUsuarioCnx)
	objResBD.define_systems_to_restore(strWSruta+strWSnombre,0)
	objResBD.restore_db(strWSruta+strWSnombre,1,1,0)
	
def mnuRestaurarBD():
	print 'Restaurando BD'
	
def initWorkSpace(pStrWSnombre,pStrWSruta,pStrBDnombre,pStrBDusuarioCnx,pStrBDpwdUsuarioCnx):
	#Ruta del repositorio pxp
	pxp_git = 'https://github.com/kplian/pxp.git'
	print ''
	print 'Inicializando Workspace: ' + pStrWSnombre

	try:
		#Creación del directrio
		strWS = pStrWSruta + pStrWSnombre
		#Verifica si existe el directorio
		if not os.path.exists(strWS):
			#Clonación de pxp desde el repositorio en Github
			print 'Cloning into \'pxp\' ... (Esta operación puede tardar varios minutos.)'
			Repo.clone_from(pxp_git, strWS+'/pxp/')
			
			#Creación de carpetas adicionales
			os.makedirs(strWS+'/reportes_generados')
			os.makedirs(strWS+'/uploaded_files')
			
			#Creación de enlaces simbólicos
			os.symlink(strWS+'/pxp/lib', strWS+'/lib')
			os.symlink(strWS+'/pxp/index.php', strWS+'/index.php')
			os.symlink(strWS+'/pxp/sis_seguridad', strWS+'/sis_seguridad')
			os.symlink(strWS+'/pxp/sis_generador', strWS+'/sis_generador')
			os.symlink(strWS+'/pxp/sis_parametros', strWS+'/sis_parametros')
			os.symlink(strWS+'/pxp/sis_organigrama', strWS+'/sis_organigrama')
			os.symlink(strWS+'/pxp/sis_workflow', strWS+'/sis_workflow')
			
			#Creación de archivo de configuración
			crearArchivoConf(pStrWSnombre,pStrWSruta,pStrBDnombre,pStrBDusuarioCnx,pStrBDpwdUsuarioCnx)
			
		else:
			print 'La ruta definida ya existe, cambie la ruta o el nombre del workspace'

	except:
		print 'Ha ocurrido un error inesperado'

#Creacion de archivo de configuracion		
def crearArchivoConf(pStrWSnombre,pStrWSruta,pStrBDnombre,pStrBDusuarioCnx,pStrBDpwdUsuarioCnx):
	#Creación del archivo de configuración
	strNombreArchivo = 'DatosGenerales.php'
	filConf = open(pStrWSruta+pStrWSnombre+'/lib/'+strNombreArchivo, 'w')
	#Contenido del archivo
	strFile = """
<?php
/**
 * *********************************
 * 
 * Archivo: Configuración PXP
 * Descripcion: Configuraciones iniciales para workspace de PXP
 * Fecha: 
 *
 ************************************/
 
  /************************************
  * INFORMACION BASE DE DATOS
  *************************************/
  $_SESSION["_HOST"] = "%s";
  $_SESSION["_BASE_DATOS"]= "%s";
  $_SESSION["_PUERTO"] = "%s";
  $_SESSION["_USUARIO_CONEXION"] = "%s" ;
  $_SESSION["_CONTRASENA_CONEXION"] = "%s" ;
  //Nombre carpeta de los logs de la base de datos
  $_SESSION["_FOLDER_LOGS_BD"] = "%s";
  //Nombre de los logs de base de datos
  $_SESSION["_NOMBRE_LOG_BD"] ="postgresql";
  //Tipo de conexion (persistente, no_persistente)
  $_SESSION["_TIPO_CONEXION"]='no_persistente';
  
  /************************************
  * SEGURIDAD
  *************************************/
  //Semilla de encriptación; debe coincidir con la semilla de BD
  $_SESSION["_SEMILLA"] = "+_)(*&^%s$#@!@TERPODO"; 
  //Semilla de ofuscación para el cliente
  $_SESSION["_SEMILLA_OFUS"] = "1611829075654";
  //Nombre DOMINIO para autentificación LDAP
  $_SESSION["_DOMINIO"] = 'dominio.com';
  //Servidor de autenticacion LDAP en el dominio especificado 
  $_SESSION["_SERVER_LDAP"] = '10.10.0.32';
  //Puerto de autenticacion ldap
  $_SESSION["_PORT_LDAP"] = '389';
  //Bandera de encriptación de datos
  $_SESSION["encriptar_data"]='si'; 
  //Bandera de encriptación de IDs
  $_SESSION["_OFUSCAR_ID"]='si'; 
  //bandera para obligar conexiones ssl [SI, NO]
  $_SESSION["_FORSSL"]="NO"; 
  //Bandera para habilitar control DoS (denegacion de servicio)
  $_SESSION['_CRT_DOS']='NO';
  //Cantidad de datos que se almacenan en la pila
  $_SESSION['_TAM_MAX']=10;
  //Segundos ultima transaccion sospechosa
  $_SESSION['_SEG_DOS']=0;
  //Mili segundos ultima transaccion sospechosa
  $_SESSION['_MSEG_DOS']=0.3;
  //Peso maximo para considerar una transaccion como sospechosa 
  $_SESSION["_PESOMAX_DOS"]=9;

  /************************************
  * INFORMACIÓN CÓDIGO FUENTE
  *************************************/
  //Nombre carpeta de la instancia de PXP (workspace)
  $_SESSION["_FOLDER"] = "%s";
  //Codificación de caracteres
  $_SESSION["codificacion_xml"] = "UTF-8";
  $_SESSION["codificacion_header"] = "UTF-8";
  $_SESSION["type_header"] = "text/x-json";
  //Estado del sistema (desarrollo,produccion)
  $_SESSION["_ESTADO_SISTEMA"] = "desarrollo";
  //Metodo de envio de datos
  $_SESSION["metodo_envio"]="post"; 
  //Tiempo de espera para la interfaces javascript en el cliente
  $_SESSION["_TIMEOUT"]=200000;

  /************************************
  * APARIENCIA DEL SISTEMA
  *************************************/
  //Estuilo de iconos utilizados en la barra de herramientas (icono_dibu, icono, icono_byn, icono_inc)
  $_SESSION['_ESTILO_MENU']='icono_dibu';
  $_SESSION['_TITULO_SIS_LARGO']="TITULO LARGO";
  $_SESSION['_TITULO_SIS_CORTO']=" DESARROLLO ÁGIL";
  $_SESSION['_NOMBRE_SIS']="SISTEMA";
  $_SESSION['_REP_NOMBRE_SISTEMA']='DESCRIPCION SISTEMA';
  //Plantilla html para background del sistema
  $_SESSION['_PLANTIILA']= "<tr height=\\"20%s\\">
  <td width=\\"100%s\\">
    <p align=\\"center\\">
     <font color=\\"black\\" SIZE=6>".$_SESSION['_TITULO_SIS_LARGO']."</font>
    </p>
    <br/>
    <p align=\\"center\\"><font color=\\"black\\" SIZE=4>".$_SESSION['_TITULO_SIS_CORTO']."</font></p>
    <div align=\\"center\\"><strong><h1><font color=\\"black\\" SIZE=8>".$_SESSION['_NOMBRE_SIS']."</font></strong></h1></div>
  </td>
  </tr>";

  /************************************
  * REPORTES
  *************************************/
  //Cantidad de registros por lote máximo
  $_SESSION['cantidad_reportes']=200;
  $_SESSION['fecha_pie']=false;
  $_SESSION['color_fill_reportes']='#F2F2F2';

  /************************************
  * GENERADOR DE CÓDIGO FUENTE
  *************************************/
  $_SESSION["_QUITAR_CANT_PREFIJO_TABLA"]='si'; // si|no
  $_SESSION["_CANT_PREFIJO_TABLA"]=1; 
  $_SESSION["_PREFIJO_TABLA"]='ft_';

  /************************************
  * CONFIGURACIÓN CORREO ELECTRÓNICO
  *************************************/
  $_SESSION["_CUENTA_MAIL"]='user@tudomiino.com';
  $_SESSION['_MAIL_USUARIO']='kplian@gmail.com';
  $_SESSION['_MAIL_PASSWORD']='password...';
  $_SESSION['_MAIL_REMITENTE']='kplain@gmail.com';
  $_SESSION['_NOMBER_REMITENTE']='Sistema ERP';
  $_SESSION['_MAIL_SERVIDOR']='smtp.gmail.com';
  $_SESSION['_MAIL_PUERTO']=465;
  $_SESSION['_MAIL_AUTENTIFICACION']=true;
  $_SESSION['_SMTPSecure']='ssl';
  //Correos para notificaciones
  $_SESSION['_MAIL_NITIFICACIONES_1']='usuario@gmail.com';

  /************************************
  * LOGOS
  *************************************/
  $_SESSION['_DIR_LOGO']='/imagenes/logos/logo.png'; 
  $_SESSION['_DIR_FAV_ICON']='../../../lib/images/favicon.ico';
  $_SESSION['_MINI_LOGO']='../../../lib/imagenes/kplian2.jpg';
  $_SESSION['_DIR_IMAGEN_INI']='../../../lib/imagenes/fondo_ini.jpg';
  $_SESSION['_DIR_FABICON']='../../images/logo_reporte.jpg';
  $_SESSION['_DIR_BACKGROUND_LOGIN']='../../../recursos/imagenes/Logo.png';
	
?>
	""" % (strHost,strBDnombre,intBDpuerto,strBDusuarioCnx,strBDpwdUsuarioCnx,strBDfolderLog,'%','/'+pStrWSnombre+'/','%','%')
	#Guarda el archivo
	filConf.write(strFile)
	#Cierra el archivo
	filConf.close()
							
#Variables globales
strWSnombre = ''
strWSruta = '/var/www/html/'
strBDnombre = ''
strBDusuarioCnx = 'conexion'
strBDpwdUsuarioCnx = ''
strHost = 'localhost'
intBDpuerto = '5432'
strBDfolderLog = '/var/lib/pgsql/9.1/data/pg_log/'
####################MENU#############################################

print '**************UTILITARIO PXP**********************'
print ''
menu()





