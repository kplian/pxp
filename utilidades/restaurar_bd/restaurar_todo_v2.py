#!/usr/bin/python

# ***************************************************************************************************************
#    Autor:  Jaime Rivera Rojas  (KPLIAN)
#    Fecha: 05-09-2013
#    Descripcion: permimtw inicializar y actualizar automaticamente a partir  de SQL  la estructura de base de datos
# ***************************************************************************************************   
#   HISTORIAL DE MODIFICACIONES:
#   ISSUE            FECHA:              AUTOR                 DESCRIPCION   
#   0                05-09-2013        JRR KPLIAN       ermimti inicalizar y actulizar automaticamente apartid de SQL  la estructura de base de datos.
#  ******************************************************************************************************************************************************

import sys
import os
import shutil
import subprocess
import datetime
from os.path import expanduser
from shutil import copytree


#Function to generate scripts array
#param String file

def restaurar_db(base):
	print 'Iniciando backup de la BD :' + db
	print 'El host es :' + host 	
	print 'El puerto es:' + port
	file_name = '/tmp/bk_' + base + '_' +datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
	if (host == '127.0.0.1' or host == 'localhost'):
		command = 'pg_dump ' + base + ' -U postgres -F c -b -N log -f ' + file_name
	else:
		validar_pgpass()
		command = 'pg_dump ' + base + ' -h ' + host + ' -p ' + port + ' -U ' + usuario + ' -w -F c -b -N log -f ' + file_name	
    
	for line in run_command(command):
		print line
	print 'Se ha generado el backup de la base de datos en : ' + file_name
	print 'Copie el archivo en otra ubicacion antes de reiniciar el equipo'

def comparar_db(psistema):
        print 'Funciones con diferencia en el sistema : ' + psistema
	url = os.path.dirname(__file__) + '/../../../' + psistema + '/base/schema.sql'
	esquema = get_schema(url)
	
	funciones_dir = os.path.dirname(__file__) + '/../../../' + psistema +  '/base/funciones/'
        funciones = os.listdir( funciones_dir )
	
	if (host == '127.0.0.1' or host == 'localhost'):
		command = 'psql -t -1 -q -A -c "select p.proname from pg_proc p INNER JOIN pg_namespace n ON p.pronamespace = n.oid where n.nspname = \$\$' + esquema[0] + '\$\$" -d ' + db
        else:
        	validar_pgpass()
                command = 'psql -t -1 -q -A -c "select p.proname from pg_proc p INNER JOIN pg_namespace n ON p.pronamespace = n.oid where n.nspname = \$\$' + esquema[0] + '\$\$" -d ' + db     + ' -h ' + host + ' -p ' + port + ' -U ' + usuario	

	
	for line in run_command(command):
                f = line.strip()
				
		codigo_bd = '';
		codigo_file = '';

		if os.path.isfile(funciones_dir + '/' + esquema[0] + '.' + f + '.sql'):
			
			file1 = open(funciones_dir + '/' + esquema[0] + '.' + f + '.sql', 'r')
			inicio = False
        		for line in file1:
				if (line.strip().lower() == '$body$' and inicio == False):
					inicio = True
				elif (line.strip().lower() == '$body$' and inicio == True):
					inicio = False
				elif (inicio == True):
					codigo_file += line
			file1.close()
			if (host == '127.0.0.1' or host == 'localhost'):
        			command = 'psql -t -1 -q -A -c "select p.prosrc from pg_proc p INNER JOIN pg_namespace n ON p.pronamespace = n.oid where proname = \$\$' + f + '\$\$ and n.nspname = \$\$' + esquema[0] + '\$\$" -d ' + db
        		else:
                		validar_pgpass()
                		command = 'psql -t -1 -q -A -c "select p.prosrc from pg_proc p INNER JOIN pg_namespace n ON p.pronamespace = n.oid where proname = \$\$' + f + '\$\$ and n.nspname = \$\$' + esquema[0] + '\$\$" -d ' + db     + ' -h ' + host + ' -p ' + port + ' -U ' + usuario
			for line in run_command(command):
				codigo_bd += line
			codigo_file = "".join(codigo_file.split());
			codigo_bd = "".join(codigo_bd.split());
			if (codigo_file not in codigo_bd):
				print 'Diferencia en funcion : ' + f
		else:
			print 'La funcion : ' + f + ' ,no esta en codigo fuente'	        
			
def validar_pgpass ():
	home = expanduser("~")	
	if (not os.path.exists(home + '/.pgpass')):
		sys.exit("No existe el archivo " + home + '/.pgpass  . Debe existir ese archivo para conectarse con BD remotas (Revise la documentacion) ')	
def get_schema (url):
	esquema = []
	
	try:
        	file1 = open( url, 'r')
		for line in file1:
        		esquema.append(line.strip())			
        	file1.close()
		return esquema
	except:
        	print 'El archivo ' + url + ' no existe o no tiene permisos de lectura!!!',sys.exc_info()[1]
        	sys.exit('Se ha finalizado la ejecucion')
def validar_funcion(archivo, nombre):
	try:
                file1 = open( archivo, 'r')
                for line in file1:
			if line.find('CREATE') != -1 and line.find('FUNCTION') != -1 and line.replace('"','').find(nombre) !=-1:
                		break
			elif line.find('CREATE') != -1 and line.find('FUNCTION') != -1 and line.find(nombre) ==-1:
				f_log.write("ERROR: El nombre del archivo " + archivo + " no iguala con el nombre de la funcion definida en el contenido\n")
				break
			
		file1.close()
                
        except:
                print 'El archivo ' + archivo + ' no existe o no tiene permisos de lectura!!!',sys.exc_info()[1]
                sys.exit('Se ha finalizado la ejecucion')
def generate_scripts (file_str):
    scripts = []
    try:
        file = open(file_str, 'r')
	dic = dict(codigo='',query='', is_loaded='')
	searching_for = 'inicio'	
        for line in file:
                if line.find('***I-SCP-') != -1 or line.find('***I-DEP-') !=-1 or line.find('***I-DAT-') != -1 or line.find('***I-TYP-') != -1:
                        dic['codigo'] = line.replace('*','')
			dic['codigo'] = dic['codigo'].replace('/','')
			dic['codigo'] = dic['codigo'].replace(' ','')
			dic['codigo'] = dic['codigo'].replace('\r','')
			dic['codigo'] = dic['codigo'].replace('\n','')
			dic['codigo'] = dic['codigo'][2:]
			if (searching_for == 'fin'):
				 f_log.write("ERROR: Se encontro: " + line.replace('*','')  + "cuando se buscaba el fin de un SCRIPT\n")
	
			searching_for = 'fin'
		elif line.find('***F-SCP-') != -1 or line.find('***F-DEP-') !=-1 or line.find('***F-DAT-') != -1 or line.find('***F-TYP-') != -1:
			if dic['codigo'] != '':
				scripts.append(dic)
                                dic = dict(codigo = '', query = '', is_loaded='')
			if (searching_for == 'inicio'):
				f_log.write("ERROR: Se encontro: " + line.replace('*','')  + "cuando se buscaba el inicio de un SCRIPT\n")

			searching_for = 'inicio'
				
						
		else:
			if dic['codigo'] !='':
				#print line
				dic['query'] = dic['query'] + line
					                        
        file.close()
    except:
        print 'El archivo ' + file_str + ' no existe o no tiene permisos de lectura!!!',sys.exc_info()[1]
	sys.exit('Se ha finalizado la ejecucion')

    return scripts

def execute_script (systems , kind, file_log):
    for item in systems:
    	patches = os.listdir( item + 'base/' )
    	for f in patches:
            if f.startswith(kind):
		file_log.write("*************"+ kind + " : " + item + " ("+")\n")
            	
		sql_scripts = generate_scripts(item + 'base/' + f)
   		
		for script in sql_scripts:
					if (host == '127.0.0.1' or host == 'localhost'):
							command = 'psql -t -1 -q -A -c "select pxp.f_is_loaded_script(\$\$' + script['codigo']  + '\$\$)" -d ' + db
					else:
							validar_pgpass()
							command = 'psql -t -1 -q -A -c "select pxp.f_is_loaded_script(\$\$' + script['codigo']  + '\$\$)" -d ' + db	+ ' -h ' + host + ' -p ' + port + ' -U ' + usuario
                    	        
					for line in run_command(command):
							if kind == 'custom_type':
								print line 
							if (line.strip() == '0'):
								f_command = open('/tmp/file_command.txt','w')
                        					f_command.write('BEGIN;')
                        					f_command.write(script['query'])
                        					f_command.write("INSERT INTO pxp.tscript_version VALUES('" + script['codigo']  + "');")
                        					f_command.write('COMMIT;')
                        					f_command.close()
                        					if (host == '127.0.0.1' or host == 'localhost'):
									command = 'psql -t -1 -q -A -d ' + db + ' < /tmp/file_command.txt'
								else:
									validar_pgpass()
									command = 'psql -t -h ' + host + ' -p ' + port + ' -U ' + usuario + ' -1 -q -A -d ' + db + ' < /tmp/file_command.txt'
                    
                        					f_log.write("/***********************************" + script['codigo']  + "("+ item +"base/"+ f +") *****************************/\n")
                        					for line in run_command(command):
                            	    					f_log.write(line)

def run_command(command):
    p = subprocess.Popen(command,
                         stdout=subprocess.PIPE,stderr=subprocess.STDOUT,shell=True)
     
    line = p.stdout.readline()
    while line:
        yield line
        line = p.stdout.readline()

def obtener_usuario():
	usuario = ''
	if (host != '127.0.0.1' and host != 'localhost'):
    		usuario = raw_input('La base de datos es una base de datos remota. Ingrese el nombre de usuario de bd con el que se conectara a la BD remota(El mismo usuario definido en el archivo .pgpass): ')
	return usuario


def obtener_url():	
	url = []
	#url pxp
	cadena_url = '/../../pxp'
	if sistema == 'indefinido' or cadena_url.find(sistema) != -1:
		url.append(os.path.dirname(__file__) + '/../../')
	#url segu
	cadena_url = '/../../sis_seguridad/'
	if sistema == 'indefinido' or cadena_url.find(sistema) != -1:
		print 'entra' 
		url.append(os.path.dirname(__file__) + '/../../sis_seguridad/')
	# url param
	cadena_url = '/../../sis_parametros/'
	if sistema == 'indefinido' or cadena_url.find(sistema) != -1:
		url.append(os.path.dirname(__file__) + '/../../sis_parametros/')
	# url gen
	cadena_url = '/../../sis_generador/'
	if sistema == 'indefinido' or cadena_url.find(sistema) != -1:
		url.append(os.path.dirname(__file__) + '/../../sis_generador/')
	#url orga
	cadena_url = '/../../sis_organigrama/'
	if sistema == 'indefinido' or cadena_url.find(sistema) != -1:
		url.append(os.path.dirname(__file__) + '/../../sis_organigrama/')
	#url WF
	cadena_url = '/../../sis_workflow/'
	if sistema == 'indefinido' or cadena_url.find(sistema) != -1:
		url.append(os.path.dirname(__file__) + '/../../sis_workflow/')

	####RECUPERAR SISTEMAS ADICIONALES
	try:
			file1 = open(os.path.dirname(__file__) + '/../../../sistemas.txt', 'r')

			for line in file1:
				if sistema == 'indefinido' or line.find(sistema) != -1:
					url.append(os.path.dirname(__file__) + '/'  + line.replace('\n',''))       
			file1.close()
	except:
			print 'Solo se han recuperado los esquemas basicos del framework. (No existe el archivo sistemas.txt o no es posible leerlo'
	return url

def restaurar_esquema(url):
	# Primero se restaura los esquemas
	for item in url:
		for line in run_command('echo "/********************ESQUEMAS: ' + item + '*******************/"'):
				f_log.write(line)
		#restaurar subsistema
			#esquema pxp:se crea el esquema sin usar la funcion manage schema ya q td no existe
		if item ==os.path.dirname(__file__) +  '/../../' and opcion == '1':
			if (host == '127.0.0.1' or host == 'localhost'):
				command = 'psql -q -d ' + db + ' < ' + item + 'base/schema.sql'
			else:
				validar_pgpass()
				command = 'psql -h ' + host + ' -p ' + port + ' -U ' + usuario + ' -q -d ' + db + ' < ' + item + 'base/schema.sql'
			
			for line in run_command(command):
						f_log.write(line)	
		#otros esquemas:se crea el esquema usando la funcion manage schema
		elif item !=os.path.dirname(__file__) +  '/../../':
			esquemas = get_schema(item + 'base/schema.sql')
			for esquema in esquemas:		
				if (host == '127.0.0.1' or host == 'localhost'):
					command = 'psql '+ db + ' -c  "select pxp.f_manage_schema(\$\$' + esquema  + '\$\$,' + opcion + ')"'
				else:
					validar_pgpass()
					command = 'psql '+ db + ' -h ' + host + ' -p ' + port  + ' -U ' + usuario + ' -c  "select pxp.f_manage_schema(\$\$' + esquema  + '\$\$,' + opcion + ')"'
							
				for line in run_command(command):
						f_log.write(line)

def actualizar_codigo():
		usuario = ''
		print 'Inicio la Actualizacion de codigo en los sistemas'
		url=obtener_url()
		for line in url:
			#las carpetas de git deben tener permisos 777 				
			#si ya tiene permisos la carpeta git
			command = ['cd '+line+';git pull origin master']
			for i in command:
				os.system(i)
				
def modo_desarrollo():
		usuario = ''
		print 'Inicio de cambio de modo desarrollo'
		
		os.rename(os.path.dirname(__file__) + '/../../lib/DatosGenerales.php', os.path.dirname(__file__) + '/../../lib/DatosGeneralesOld.php')
		file2 = open(os.path.dirname(__file__) + '/../../lib/DatosGeneralesOld.php', 'r')
		file3 = open(os.path.dirname(__file__) + '/../../lib/DatosGenerales.php', 'w')
		for line in file2:
			
			if line.find('$_SESSION["_ESTADO_SISTEMA"]') != -1 :
						line = line.replace('produccion','desarrollo')
									
			file3.write(line)	
		
		file3.close()
		file2.close()
		os.remove(os.path.dirname(__file__) + '/../../lib/DatosGeneralesOld.php')
		command = 'psql -U postgres -c  "select pxp.f_update_development_mode()" ' + db 
		os.system(command)
		
		sys.exit("Se ha cambiado a modo Desarrollo")
def modo_produccion():
		usuario = ''
		print 'Inicio de cambio a Produccion'
		
		os.rename(os.path.dirname(__file__) + '/../../lib/DatosGenerales.php', os.path.dirname(__file__) + '/../../lib/DatosGeneralesOld.php')
		file2 = open(os.path.dirname(__file__) + '/../../lib/DatosGeneralesOld.php', 'r')
		file3 = open(os.path.dirname(__file__) + '/../../lib/DatosGenerales.php', 'w')
		for line in file2:
			
			if line.find('$_SESSION["_ESTADO_SISTEMA"]') != -1 :
						line = line.replace('desarrollo','produccion')
									
			file3.write(line)	
		
		file3.close()
		file2.close()
		os.remove(os.path.dirname(__file__) + '/../../lib/DatosGeneralesOld.php')
				
		sys.exit("Se ha cambiado a modo Produccion")

def instancia():
		
	usuario = ''
	print 'Inicio de la creacion del proyecto: ' + proyecto
	
	file1 = open(os.path.dirname(__file__) + '/../../lib/DatosGenerales.php', 'r')
	for line in file1:
		if line.find('$_SESSION["_FOLDER"]') != -1 :
				#la cokies solamente son admitidas en esta direccion no es tomada esta direccion para la creacion de instancias
				#$_SESSION["_FOLDER"] = "/web/lib/lib_control/";
				if line.find('"/web/lib/lib_control/"') == -1 :
					vars = line.split('=')
					base = vars[1]
					base = base.strip()
					base = base.replace('/','')
					base = base.replace('"','')
					base = base.replace(';','')
					print 'La instacia se creara de la carpeta :' + base
		if line.find('$_SESSION["_BASE_DATOS"]') != -1 :
			vars = line.split('=')
			db = vars[1]
			db = db.strip()
			db = db.replace('"','')
			db = db.replace(';','')
			print 'La base de datos se creara a partir de  :' + db	
	file1.close()

	#evalua las rutas del proyecto a copiar y el destino
	ruta = os.path.dirname(__file__) + '/../../../../'
	origen = ruta + base
	destino = ruta + proyecto

	if (os.path.exists(destino)):
		sys.exit('El Proyecto ya existe en la ruta del proyecto '+ proyecto+'Se encuentra en la carpeta base de la instancia' )
	if (os.path.exists(origen)):
		print 'Copiando las carpetas base para la nueva instancia '+ proyecto
		shutil.copytree(origen, destino, symlinks= True)
		dbinstancia(db,proyecto)
		print 'Actualizando a modo Desarrollo'
		data_g = os.path.dirname(__file__) + '/../../../../'+proyecto+'/pxp/lib/DatosGenerales.php'
		data_g_ol = os.path.dirname(__file__) + '/../../../../'+proyecto+'/pxp/lib/DatosGeneralesOld.php'
		
		os.rename(data_g,data_g_ol)
		file2 = open(data_g_ol, 'r')
		file3 = open(data_g, 'w')
		
		
		for line in file2:
			if line.find('$_SESSION["_ESTADO_SISTEMA"]') != -1 :
						line = line.replace('produccion','desarrollo')
			if line.find('$_SESSION["_FOLDER"]') != -1 :
				if line.find('"/web/lib/lib_control/"') == -1 :
						line = line.replace(base,proyecto)
			
			if line.find('$_SESSION["_BASE_DATOS"]') != -1 :
						line = line.replace('db'+base,'db'+proyecto)
						
			if line.find('$_SESSION["_CONTRASENA_CONEXION"]') != -1 :
						line = line.replace('db'+base+'_conexion','db'+proyecto+'_conexion')
												
			file3.write(line)	
		
		file3.close()
		file2.close()
		os.remove(data_g_ol)
		command = 'psql -U postgres -c  "select pxp.f_update_development_mode()" ' + 'db'+proyecto 
		os.system(command)
		
		
	else:
		sys.exit('El script no se ejecuto desde la carpeta donde se encuentra la carpeta '+ base )
	
		
	sys.exit("Ha Finalizado La creacion de instancia")
	
def dbinstancia(base,proyecto):
		date = datetime.datetime.now().strftime("%Y%m%d")

		file_name = 'db_base_instancia'
		db_proyecto = 'db'+proyecto 
		ruta_bd_bkb	= os.getcwd() + os.sep +'db_base_instancia_'+date
		
		#ruta_bd_bkb = os.path.dirname(__file__) + '/../../../../db_base_instancia_'+date
		if (os.path.exists(ruta_bd_bkb)):
			print 'La backup de la base de datos ya existe del dia de hoy ('+date+') se restaurara con esa backup '
		else:
			print 'La ruta el backup de la bd '+base+' es:'+ruta_bd_bkb
			command = 'pg_dump ' + base + ' -U postgres -F c -b -N log -f '+ file_name+'_'+date
			print 'Iniciando el backup de la base de datos '+ base
			os.system(command)
		
		command = 'createdb -U postgres -O postgres '+db_proyecto
		print 'creando la base de datos : '+ db_proyecto
		os.system(command)
		
		command = 'pg_restore -U postgres -d '+ db_proyecto + ' -1 '+ file_name+'_'+date
		print 'Restaurando los datos a : '+ db_proyecto
		os.system(command)
		
		command = 'psql '+db_proyecto+' postgres -c "create schema log"'
		print 'creando el esquema log en '+db_proyecto
		os.system(command)
				
		command = 'psql -U postgres -c  "CREATE ROLE db'+proyecto+'_conexion SUPERUSER NOINHERIT NOREPLICATION LOGIN PASSWORD *db'+proyecto+'_conexion*;"'
		command =  command.replace("*","'")		
		print 'creando conexion db'+proyecto
		os.system(command)
		
try:
	file1 = open(os.path.dirname(__file__) + '/../../lib/DatosGenerales.php', 'r')

	for line in file1:
		if line.find('$_SESSION["_BASE_DATOS"]') != -1 :
			vars = line.split('=')
			db = vars[1]
			db = db.strip()
			db = db.replace('"','')
			db = db.replace(';','')
			print 'La base de datos es :' + db	
		if line.find('$_SESSION["_HOST"]') != -1 :
			vars = line.split('=')
			host = vars[1]
			host = host.strip()
			host = host.replace('"','')
			host = host.replace(';','')
			print 'El host es :' + host
		if line.find('$_SESSION["_PUERTO"]') != -1 :
                        vars = line.split('=')
                        port = vars[1]
                        port = port.strip()
                        port = port.replace('"','')
                        port = port.replace(';','')
                        print 'La puerto es :' + port
	file1.close()		
except:
	sys.exit('El archivo pxp/lib/DatosGenerales.php no existe o no tiene permisos de lectura!!!')

archivo_log = '/tmp/log_restaurar_bd.log'
f_log = open('/tmp/log_restaurar_bd.log', 'w')






####################MENU#############################################3

print '**************UTILIDAD PARA RESTAURAR BD DEL FRAMEWORK PXP**********************'
print 'Que desea hacer?'
print '1. Restaurar la base de datos completamente (Esta opcion eliminara todos los objetos de la bd)'
print '2. Actualizar los scripts faltantes en su base de datos (Solo eliminara las funciones y las volvera a crear)'
print '3. Actualizar los scripts faltantes en la bd solo sobre un sistema'
print '4. Comparar funciones de un esquema en la bd con archivos en codigo fuente'
print '5. Actualiza codigo todos los sistemas desde el repositorio de github'
print '6. Actualizar codigo desde el repositorio de github por sistema'
print '7. Crea Instancias del Framework con base del existente en el Servidor (una copia del pxp con los sistemas agregados)NOTA: SOLO MODO BASH LINUX'
print '8. Modo Desarrollo y Produccion NOTA: SOLO MODO BASH LINUX'
print '9. Obtener un backup de la BD (sin el esquema log)'
print '10. Salir del programa'
opcion = raw_input('Ingrese una opcion (1,2,3,4,5,6,7,8,9,10): ')
sistema = 'indefinido'
proyecto = 'indefinido'
if (opcion != '1' and opcion != '2' and opcion != '3' and opcion != '4' and opcion != '5' and opcion != '6' and opcion != '7' and opcion != '8' and opcion != '9') :
	sys.exit("Ha abandonado la restauracion de la base de datos")

if opcion == '1':
	usuario = obtener_usuario()
	print 'Para restaurar la base de datos :********************' + db + '*****************, esta debe ser ELIMINADA!!!.'
	question = ''
	while question != db :
		question = raw_input("Ingrese el nombre de la BD para ELIMINARLA: ")
	while (question != 'SI'	and question != 'NO'):
		question = raw_input("Desea obtener un backup de la BD antes de eliminarla? (SI/NO) : ")
		if question == 'SI':
			restaurar_db(db)		
	datos = raw_input("Desea restaurar los datos de prueba? (s/n): ")
elif opcion == '2':
	usuario = obtener_usuario()
	datos = 'n'
elif opcion == '3':
	usuario = obtener_usuario()
	datos = 'n'
	sistema = raw_input("Ingrese el nombre del sistema a actualzar(Ej: sis_seguridad): ")
	if sistema == '':
		sys.exit("Debe ingresar un nombre de sistema valido!!!")
elif opcion == '4':
	usuario = obtener_usuario()
	datos = 'n'
	sistema = raw_input("Ingrese el nombre del sistema a comparar(Ej: sis_seguridad): ")
	if sistema == '':
			sys.exit("Debe ingresar un nombre de sistema valido!!!")
	comparar_db(sistema)
	sys.exit("Comparacion Finalizada")
elif opcion == '5':
	usuario = obtener_usuario()
	actualizar_codigo()
	sys.exit("Termino la Actualizacion del codigo")
elif opcion == '6':
	usuario = obtener_usuario()
	datos = 'n'
	sistema = raw_input("Ingrese el nombre del sistema a actualzar(Ej: sis_seguridad): ")
	actualizar_codigo()
	sys.exit("Termino la Actualizacion del codigo")
	
	#resp = raw_input("Desea realiza la restauracion de funciones y script en el sistema "+sistema+" (s/n):")
	#if ( resp!= 's' and resp != 'n') :
	#	sys.exit("Ha abandonado la restauracion Ingrese")
	#elif resp == 'n':
	#	sys.exit("Termino la Actualizacion del codigo")
elif opcion == '7':
	usuario = obtener_usuario()
	datos = 'n'
	proyecto = raw_input("Ingrese el nombre de la instancia nueva a crear (Ej: kerp_2): ")
	proyecto = proyecto.lower()
	proyecto = proyecto.replace(' ', '')
	instancia()

elif opcion == '8':
	
	usuario = obtener_usuario()
	datos = 'n'
	resp = raw_input("Desea activar el Modo Desarrollo ('D') o el Modo Produccion (P) (Ingrese 'D' u 'P') ")
	if ( resp!= 'D' and resp != 'P') :
		sys.exit("Ha abandonado la restauracion Ingrese D o P")
	elif resp == 'D':
		modo_desarrollo()
	elif resp == 'P':
		modo_produccion()
	
else:
	usuario = obtener_usuario()
	restaurar_db(db)
	sys.exit("Backup generado con exito")	

if opcion == '4':
	print 'Iniciando la comparacion...'
else:
	print 'Iniciando la restaturacion de la BD' 
#recuperamos las url de los sistemas
url=obtener_url()
#restauramos los esquemas
restaurar_esquema(url)
#Se crean los tipos
execute_script(url, 'custom_type', f_log)
#crear objetos de cada esquema
execute_script(url, 'patch', f_log)

#Crear funcion para eliminar funciones
if (host == '127.0.0.1' or host == 'localhost'):
	command = 'psql -q -d ' + db + ' < ' + url[0] +   'base/funciones/pxp.f_delfunc.sql'
else:
	validar_pgpass()
	command = 'psql -h ' + host + ' -p ' + port + ' -U ' + usuario + ' -q -d ' + db + ' < ' + url[0] +   'base/funciones/pxp.f_delfunc.sql'          	
			
for line in run_command(command):
	f_log.write(line)
                                   
#Crear funciones
for item in url:
	 #restaurar subsistema
	for line in run_command('echo "/********************FUNCIONES: ' + item + '*******************/"'):
                f_log.write(line)
        funciones_dir = item + 'base/funciones/'	
    	funciones = os.listdir( funciones_dir )
    	for f in funciones:
    		if f.endswith('.sql'):
    			f_log.write('restaurando '+funciones_dir + f+'\n')
    			#solo eliminar si la funcion no es pxp.f_delfunc.sql
    			if (f != 'pxp.f_delfunc.sql'):
				validar_funcion(funciones_dir + f,f.replace('.sql',''))
    				if (host == '127.0.0.1' or host == 'localhost'):
					command = 'psql '+ db + ' -c  "select pxp.f_delfunc(\$\$' + f.replace('.sql','')  + '\$\$)"'
				else:
					validar_pgpass()
					command = 'psql '+ db + ' -h ' + host + ' -p ' + port + ' -U ' + usuario + ' -c  "select pxp.f_delfunc(\$\$' + f.replace('.sql','')  + '\$\$)"'
    			 	    				
    			  	for line in run_command(command):
                                    f_log.write(line)
					#Ejecutar la creacion de la funcion
			if (host == '127.0.0.1' or host == 'localhost'):
				command = 'psql -q -d ' + db + ' < ' + funciones_dir + f  
			else:
				validar_pgpass()
				command = 'psql  -h ' + host + ' -p ' + port + ' -U ' + usuario + ' -q -d ' + db + ' < ' + funciones_dir + f            	
    			 	
            		
			for line in run_command(command):
				f_log.write(line)

#insertar datos de cada esquema
execute_script(url,'data', f_log)

#insertar datos de prueba de cada esquema
if (datos  == 's'):
    for item in url:
        if os.access(item + 'base/test_data.sql', os.R_OK):
	    f_log.write("**************TEST DATA : " + item)
	    if (host == '127.0.0.1' or host == 'localhost'):
		command = 'psql '+ db + ' < ' + item + 'base/test_data.sql'
	    else:
		validar_pgpass()
		command = 'psql -h ' + host + ' -p ' + port + ' -U ' + usuario + ' '+ db + ' < ' + item + 'base/test_data.sql'           	
    			 	
            for line in run_command(command):
                f_log.write(line)

if os.access(os.path.dirname(__file__) + '/../../base/aggregates.sql', os.R_OK):
	f_log.write("**************AGGREGATES : ")
	if (host == '127.0.0.1' or host == 'localhost'):
		command = 'psql '+ db + ' < ' + os.path.dirname(__file__) + '/../../base/aggregates.sql'
	else:
		validar_pgpass()
		command = 'psql -h ' + host + ' -p ' + port + ' -U ' + usuario + ' '+ db + ' < ' + os.path.dirname(__file__) + '/../../base/aggregates.sql'           	
    		
	
	for line in run_command(command):
		f_log.write(line)

#crear dependencias de cada esquema
execute_script(url, 'dependencies',f_log)
  

#Actualizacion de las secuencias
if (host == '127.0.0.1' or host == 'localhost'):
	command = 'psql '+ db + ' -c  \'select pxp.f_update_sequences()\''
else:
	validar_pgpass()
	command = 'psql  -h ' + host + ' -p ' + port + ' -U ' + usuario + ' '+ db + ' -c  \'select pxp.f_update_sequences()\''
	
for line in run_command(command):
	f_log.write(line)
print 'Se ha generado un log de la restauracion (/tmp/log_restaurar_bd.log)' 	
f_log.close()

