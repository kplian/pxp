#!/usr/bin/python
import subprocess
import os
import sys

class clsRestauracionBD:

	strDB = ''
	f_log = ''
	url = ''
	strDBusrCnx = ''
	strDBpwdUsrCnx = ''
	
	def restaurar_db(base):
		strFileName = '/tmp/bk_' + base + '_' +datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
		command = 'pg_dump ' + base + ' -U postgres -F c -b -f ' + self.strFileName
		for line in self.run_command(command):
			print line
				
	def get_schema (self, url):
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
			
	def generate_scripts (self, file_str):
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
						self.f_log.write("ERROR: Se encontro: " + line.replace('*','')  + "cuando se buscaba el fin de un SCRIPT\n")
					searching_for = 'fin'
				
				elif line.find('***F-SCP-') != -1 or line.find('***F-DEP-') !=-1 or line.find('***F-DAT-') != -1 or line.find('***F-TYP-') != -1:
					if dic['codigo'] != '':
						scripts.append(dic)
						dic = dict(codigo = '', query = '', is_loaded='')
					if (searching_for == 'inicio'):
						self.f_log.write("ERROR: Se encontro: " + line.replace('*','')  + "cuando se buscaba el inicio de un SCRIPT\n")

					searching_for = 'inicio'
				
				else:
					if dic['codigo'] !='':
						dic['query'] = dic['query'] + line
												
			file.close()
		except:
			print 'El archivo ' + file_str + ' no existe o no tiene permisos de lectura!!!',sys.exc_info()[1]
			sys.exit('Se ha finalizado la ejecucion')

		return scripts
		
	def execute_script (self, systems, kind, file_log):
		for item in systems:
			patches = os.listdir( item + 'base/' )
			for f in patches:
				if f.startswith(kind):
					file_log.write("*************"+ kind + " : " + item + "\n")
					sql_scripts = self.generate_scripts(item + 'base/' + f)
					
					for script in sql_scripts:
						command = 'psql -U postgres -t -1 -q -A -c "select pxp.f_is_loaded_script(\$\$' + script['codigo']  + '\$\$)" -d ' + self.strDB
			
						for line in self.run_command(command):
							if kind == 'custom_type':
								print line 
							if (line.strip() == '0'):
								f_command = open('/tmp/file_command.txt','w')
								f_command.write('BEGIN;')
								f_command.write(script['query'])
								f_command.write("INSERT INTO pxp.tscript_version VALUES('" + script['codigo']  + "');")
								f_command.write('COMMIT;')
								f_command.close()
								command = 'psql -U postgres -t -1 -q -A -d ' + self.strDB + ' < /tmp/file_command.txt'
								self.f_log.write("/***********************************" + script['codigo']  + "*****************************/\n")
								for line in self.run_command(command):
									self.f_log.write(line)
					
	def run_command(self, command):
		p = subprocess.Popen(command,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,shell=True)
		line = p.stdout.readline()
		while line:
			yield line
			line = p.stdout.readline()
			
	def get_db_name():
		try:
			file1 = open(os.path.dirname(__file__) + '/../../lib/DatosGenerales.php', 'r')

			for line in file1:
				if line.find('$_SESSION["_BASE_DATOS"]') != -1 :
					vars = line.split('=')
					self.strDB = vars[1]
					self.strDB = self.strDB.strip()
					self.strDB = self.strDB.replace('"','')
					self.strDB = self.strDB.replace(';','')
					print 'La base de datos es :' + self.strDB	
			file1.close()		
		except:
			sys.exit('El archivo pxp/lib/DatosGenerales.php no existe o no tiene permisos de lectura!!!')

	def create_log_file(self):
		self.f_log = open('/tmp/log_restaurar_bd.log', 'w')
	
	def define_systems_to_restore(self,pSrtPath,pOtherSystems):
		print 'Iniciando la restauracion de los esquemas basicos...' 
		self.url = []
		#url pxp
		self.url.append(pSrtPath + '/pxp/')
		#url segu
		self.url.append(pSrtPath + '/sis_seguridad/')
		# url param
		self.url.append(pSrtPath + '/sis_parametros/')
		# url gen
		self.url.append(pSrtPath + '/sis_generador/')
		#url orga
		self.url.append(pSrtPath + '/sis_organigrama/')
		#url WF
		self.url.append(pSrtPath + '/sis_workflow/')

		if pOtherSystems == 1:
			####RECUPERAR SISTEMAS ADICIONALES
			try:
				file1 = open(pSrtPath + '/sistemas.txt', 'r')
				for line in file1:
					self.url.append(pSrtPath + '/'  + line.replace('\n',''))       
				file1.close()
			except:
				print 'Solo se han recuperado los esquemas basicos del framework. (No existe el archivo sistemas.txt o no es posible leerlo'
	
	def restore_db(self, pSrtPath, pIntOpcion, pIntCreateDB=0, pIntDatosPrueba=0):
		#pIntOpcion (1: restaurar, 2: actualizar)
		
		#Abre archivo de log
		self.create_log_file()
		
		#Creación de la base de datos en función de la bandera
		if pIntCreateDB == 1:
			command = 'psql -U postgres -c  "create database ' + self.strDB + ' with encoding \'UTF-8\'"'
			for line in self.run_command(command):
				self.f_log.write(line)
			#command = 'psql -U postgres -c  "ALTER ROLE ' + self.strDB + '_' + self.strDBusrCnx +' PASSWORD \''+self.strDBpwdUsrCnx+'\';"'
			#for line in self.run_command(command):
				#self.f_log.write(line)
				
		#Primero se restaura los esquemas
		for item in self.url:
			for line in self.run_command('echo "/********************ESQUEMAS: ' + item + '*******************/"'):
				self.f_log.write(line)
			#restaurar subsistema
			#esquema pxp:se crea el esquema sin usar la funcion manage schema ya q td no existe
			if item == pSrtPath + '/pxp/' and pIntOpcion == 1:
				command = 'psql -U postgres -q -d ' + self.strDB + ' < ' + item + 'base/schema.sql'
				for line in self.run_command(command):
					self.f_log.write(line)	

			#otros esquemas:se crea el esquema usando la funcion manage schema
			elif item != pSrtPath + '/pxp/':
				esquemas = self.get_schema(item + 'base/schema.sql')
				for esquema in esquemas:			
					command = 'psql -U postgres '+ self.strDB + ' -c  "select pxp.f_manage_schema(\$\$' + esquema  + '\$\$,' + str(pIntOpcion) + ')"'
					for line in self.run_command(command):
						self.f_log.write(line)
		
		#Se crean los tipos
		self.execute_script(self.url, 'custom_type', self.f_log)
		#Crear objetos de cada esquema
		self.execute_script(self.url, 'patch', self.f_log)
		
		#Crear funciones
		for item in self.url:
			 #restaurar subsistema
			for line in self.run_command('echo "/********************FUNCIONES: ' + item + '*******************/"'):
				self.f_log.write(line)
				funciones_dir = item + 'base/funciones/'	
				funciones = os.listdir( funciones_dir )
				for f in funciones:
					if f.endswith('.sql'):
						command = 'psql -U postgres -q -d ' + self.strDB + ' < ' + funciones_dir + f
						self.f_log.write('restaurando '+funciones_dir + f+'\n')
						for line in self.run_command(command):
							self.f_log.write(line)

		#insertar datos de cada esquema
		self.execute_script(self.url,'data', self.f_log)

		#insertar datos de prueba de cada esquema
		if (pIntDatosPrueba  == 1):
			for item in self.url:
				if os.access(item + 'base/test_data.sql', os.R_OK):
					self.f_log.write("**************TEST DATA : " + item)
					command = 'psql -U postgres '+ self.strDB + ' < ' + item + 'base/test_data.sql'
					for line in self.run_command(command):
						self.f_log.write(line)

		if os.access(os.path.dirname(__file__) + '/../../base/aggregates.sql', os.R_OK):
			self.f_log.write("**************AGGREGATES : ")
			command = 'psql -U postgres '+ self.strDB + ' < ' + os.path.dirname(__file__) + '/../../base/aggregates.sql'
			for line in self.run_command(command):
				self.f_log.write(line)

		#crear dependencias de cada esquema
		self.execute_script(self.url, 'dependencies',self.f_log)
		  
		#Actualizacion de las secuencias
		command = 'psql -U postgres '+ self.strDB + ' -c  \'select pxp.f_update_sequences()\''
		for line in self.run_command(command):
			self.f_log.write(line)
		print 'Se ha generado un log de la restauracion (/tmp/log_restaurar_bd.log)' 	
		self.f_log.close()
		
	def setDBname(self, pStrDBname):
		self.strDB = pStrDBname
		
	def setDBusrCnx(self, pStrDBusrCnx):
		self.strDBusrCnx = pStrDBusrCnx
		
	def setDBpwdUsrCnx(self,pStrDBpwdUsrCnx):
		self.strDBpwdUsrCnx = pStrDBpwdUsrCnx