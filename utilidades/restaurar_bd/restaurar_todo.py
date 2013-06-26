#!/usr/bin/python
import sys
import os
import subprocess
import datetime
#Function to generate scripts array
#param String file

def restaurar_db(base):
	print 'Iniciando backup de la BD :' + db
	file_name = '/tmp/bk_' + base + '_' +datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
	command = 'pg_dump ' + base + ' -U postgres -F c -b -f ' + file_name
        for line in run_command(command):
        	print line
	print 'Se ha generado el backup de la base de datos en : ' + file_name
	print 'Copie el archivo en otra ubicacion antes de reiniciar el equipo'


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
		file_log.write("*************"+ kind + " : " + item + "\n")
            	
		sql_scripts = generate_scripts(item + 'base/' + f)
   		
		for script in sql_scripts:
        
                	command = 'psql -t -1 -q -A -c "select pxp.f_is_loaded_script(\$\$' + script['codigo']  + '\$\$)" -d ' + db
        
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
                        	command = 'psql -t -1 -q -A -d ' + db + ' < /tmp/file_command.txt'
				f_log.write("/***********************************" + script['codigo']  + "*****************************/\n")
                        	for line in run_command(command):
                            	    f_log.write(line)

def run_command(command):
    p = subprocess.Popen(command,
                         stdout=subprocess.PIPE,stderr=subprocess.STDOUT,shell=True)
     
    line = p.stdout.readline()
    while line:
        yield line
        line = p.stdout.readline()


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
print '3. Obtener un backup de la BD'
print '4. Salir del programa'
opcion = raw_input('Ingrese una opcion (1,2,3 o 4): ')
if (opcion != '1' and opcion != '2' and opcion != '3') :
	sys.exit("Ha abandonado la restauracion de la base de datos")

if opcion == '1':
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
	datos = 'n'
else:
	restaurar_db(db)
	sys.exit("Backup generado con exito")	
print 'Iniciando la restauracion de los esquemas basicos...' 
url = []
#url pxp
url.append(os.path.dirname(__file__) + '/../../')
#url segu
url.append(os.path.dirname(__file__) + '/../../sis_seguridad/')
# url param
url.append(os.path.dirname(__file__) + '/../../sis_parametros/')
# url gen
url.append(os.path.dirname(__file__) + '/../../sis_generador/')
#url orga
url.append(os.path.dirname(__file__) + '/../../sis_organigrama/')
#url WF
url.append(os.path.dirname(__file__) + '/../../sis_workflow/')

####RECUPERAR SISTEMAS ADICIONALES
try:
        file1 = open(os.path.dirname(__file__) + '/../../../sistemas.txt', 'r')

        for line in file1:
        	url.append(os.path.dirname(__file__) + '/'  + line.replace('\n',''))       
        file1.close()
except:
        print 'Solo se han recuperado los esquemas basicos del framework. (No existe el archivo sistemas.txt o no es posible leerlo'


# Primero se restaura los esquemas
for item in url:
	for line in run_command('echo "/********************ESQUEMAS: ' + item + '*******************/"'):
    		f_log.write(line)
	#restaurar subsistema
        #esquema pxp:se crea el esquema sin usar la funcion manage schema ya q td no existe
	if item ==os.path.dirname(__file__) +  '/../../' and opcion == '1':
		command = 'psql -q -d ' + db + ' < ' + item + 'base/schema.sql'
		for line in run_command(command):
                	f_log.write(line)	
	#otros esquemas:se crea el esquema usando la funcion manage schema
	elif item !=os.path.dirname(__file__) +  '/../../':
		esquemas = get_schema(item + 'base/schema.sql')
		for esquema in esquemas:			
			command = 'psql '+ db + ' -c  "select pxp.f_manage_schema(\$\$' + esquema  + '\$\$,' + opcion + ')"'
			for line in run_command(command):
       				f_log.write(line)

#Se crean los tipos
execute_script(url, 'custom_type', f_log)
#Crear funciones
for item in url:
	 #restaurar subsistema
	for line in run_command('echo "/********************FUNCIONES: ' + item + '*******************/"'):
                f_log.write(line)
        funciones_dir = item + 'base/funciones/'	
    	funciones = os.listdir( funciones_dir )
    	for f in funciones:
    		if f.endswith('.sql'):
            		command = 'psql -q -d ' + db + ' < ' + funciones_dir + f
    			for line in run_command(command):
                                    f_log.write(line)

#crear objetos de cada esquema
execute_script(url, 'patch', f_log)

#insertar datos de cada esquema
execute_script(url,'data', f_log)

#insertar datos de prueba de cada esquema
if (datos  == 's'):
    for item in url:
        if os.access(item + 'base/test_data.sql', os.R_OK):
	    f_log.write("**************TEST DATA : " + item)
            command = 'psql '+ db + ' < ' + item + 'base/test_data.sql'
            for line in run_command(command):
                f_log.write(line)

#crear dependencias de cada esquema
execute_script(url, 'dependencies',f_log)
  

#Actualizacion de las secuencias
command = 'psql '+ db + ' -c  \'select pxp.f_update_sequences()\''
for line in run_command(command):
	f_log.write(line)
print 'Se ha generado un log de la restauracion (/tmp/log_restaurar_bd.log)' 	
f_log.close()

