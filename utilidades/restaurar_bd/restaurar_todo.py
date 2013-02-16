#!/usr/bin/python
import sys
import os
import subprocess
#Function to generate scripts array
#param String file
def generate_scripts (file_str):
    scripts = []
    try:
        file = open(file_str, 'r')
	dic = dict(codigo='',query='', is_loaded='')
	
        for line in file:
                if line.find('***I-SCP-') != -1 or line.find('***I-DEP-') !=-1 or line.find('***I-DAT-') != -1 :
                        dic['codigo'] = line.replace('*','')
			dic['codigo'] = dic['codigo'].replace('/','')
			dic['codigo'] = dic['codigo'].replace(' ','')
			dic['codigo'] = dic['codigo'].replace('\r','')
			dic['codigo'] = dic['codigo'].replace('\n','')
			dic['codigo'] = dic['codigo'][2:]

		elif line.find('***F-SCP-') != -1 or line.find('***F-DEP-') !=-1 or line.find('***F-DAT-') != -1:
			if dic['codigo'] != '':
				scripts.append(dic)
                                dic = dict(codigo = '', query = '', is_loaded='')			
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
		file_log.write("*************"+ kind + " : " + item)
            	sql_scripts = generate_scripts(item + 'base/' + f)
   		for script in sql_scripts:
        
                	command = 'psql -t -1 -q -A -c "select pxp.f_is_loaded_script(\$\$' + script['codigo']  + '\$\$)" -d ' + db
        
                	for line in run_command(command):
            
                    	    if (line.strip() == '0'):
                        	f_command = open('/tmp/file_command.txt','w')
                        	f_command.write('BEGIN;')
                        	f_command.write(script['query'])
                        	f_command.write("INSERT INTO pxp.tscript_version VALUES('" + script['codigo']  + "');")
                        	f_command.write('COMMIT;')
                        	f_command.close()
                        	command = 'psql -t -1 -q -A -d ' + db + ' < /tmp/file_command.txt'
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

####################MENU#############################################3

print '**************UTILIDAD PARA RESTAURAR BD DEL FRAMEWORK PXP**********************'
print 'Que desea hacer?'
print '1. Restaurar la base de datos completamente (Esta opcion eliminara todos los objetos de la bd)'
print '2. Actualizar los scripts faltantes en su base de datos (Solo eliminara las funciones y las volvera a crear)'
print '3. Salir del programa'
opcion = raw_input('Ingrese una opcion (1,2 o 3): ')
if (opcion != '1' and opcion != '2' ) :
	sys.exit("Ha abandonado la restauracion de la base de datos")

if opcion == '1':
	print 'Para restaurar la base de datos :' + db + ', esta debe ser eliminada.'	
	question = raw_input("Esta segur@ de hacerlo? (s/n): ")
	if question != 's':
		sys.exit("Ha abandonado la restauracion de la base de datos")
	datos = raw_input("Desea restaurar los datos de prueba? (s/n): ")
else:
	datos = 'n'

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

archivo_log = '/tmp/log_restaurar_bd.log'
f_log = open('/tmp/log_restaurar_bd.log', 'w')

# Primero se restaura los esquemas y las funciones
for item in url:
	for line in run_command('echo "/********************FUNCIONES y ESQUEMAS: ' + item + '*******************/"'):
    		f_log.write(line)
	#restaurar subsistema
        funciones_dir = item + 'base/funciones/'
    	if opcion == '1':
    		#crear esquema
    		command = 'psql -q -d ' + db + ' < ' + item + 'base/schema.sql' 
    	
    		for line in run_command(command):
        		f_log.write(line)
    	#crear funciones
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
  

#Actualización de las secuencias
command = 'psql '+ db + ' -c  \'select pxp.f_update_sequences()\''
for line in run_command(command):
	f_log.write(line)
print 'Se ha generado un log de la restauracion (/tmp/log_restauracion_bd.log)' 	
f_log.close()

