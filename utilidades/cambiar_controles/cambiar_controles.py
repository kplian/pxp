#!/usr/bin/python
import sys
import os
import subprocess
import re
#Define vars
controles_dir = os.path.dirname(__file__) + '/../../../sis_parametros/control2/'
var_funciones = 'FuncionesParametros'

controles = os.listdir( controles_dir )
#for all controls
for c in controles:
	if c.startswith('ACT'):
		file = open(controles_dir + c, 'r')
		#create string to rewirte the file
		string_file = ''
		nombre_clase = c.replace('ACT','')
		nombre_clase = nombre_clase.replace('.php','')
		nombre_modelo = 'MOD' + nombre_clase
		for line in file:
			line = line.replace ('new ' + var_funciones + '()',"$this->create('" + nombre_modelo  + "')")
			line = line.replace ('new Reporte($this->objParam)',"new Reporte($this->objParam, $this)")

			#if re.search(r"$this->res.*=.*$this->objFunc.*($this->objParam);", line):
			if '$this->res=$this->objFunc' in line.replace(' ','') and '($this->objParam)' in line:
				line = line.replace ('$this->objParam',"")

			#if re.search(r"$this->res.*=.*$this->objReporte->generarReporteListado.*", line):
			if '$this->res=$this->objReporte->generarReporteListado' in line.replace(' ',''):
                                line = line.replace (var_funciones,nombre_modelo)
			
			string_file = string_file + line
		file.close()
				
		#rewrite the file
		write_file = open(controles_dir + c,'w')
		write_file.write(string_file)
		write_file.close()	
"""
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
# Primero se restaura los esquemas basicos
for item in url:
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
	
        #crear tablas y objetos de estructura
	sql_scripts = generate_scripts(item + 'base/patch000001.sql')
	
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
	#insertar datos del esquema
    	if (datos  == 's'):
		if os.access(item + 'base/datos.sql', os.R_OK):
    	    		command = 'psql '+ db + ' < ' + item + 'base/datos.sql'
       			for line in run_command(command):
                		f_log.write(line)

print 'Se ha generado un log de la restauracion (/tmp/log_restauracion_bd.log)' 	
f_log.close()
"""
