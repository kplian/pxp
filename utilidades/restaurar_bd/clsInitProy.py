#!/usr/bin/python
import subprocess
import os
import sys
import datetime
from git import Repo

class clsInitProy:

	def __init__(self, pStrProyNombre, pStrBDesquema):
		self.strProyNombre = pStrProyNombre
		self.strProyNombreFull = 'sis_' + pStrProyNombre
		self.strPath = os.path.dirname(__file__)+'/'+self.strProyNombreFull
		self.strBDesquema = pStrBDesquema
		
	def crearDirectorios(self):
		#Verifica que no exista ya el directorio
		try:
			if not os.path.exists(self.strPath):
				os.makedirs(self.strPath)
				#Inicializa repositorio Git
				newRepo = Repo.init(self.strPath)
				#Crea las carpetas de la estructura
				if not os.path.exists(self.strPath+'/base'):
					os.makedirs(self.strPath+'/base')
				if not os.path.exists(self.strPath+'/base/funciones'):
					os.makedirs(self.strPath+'/base/funciones')
				if not os.path.exists(self.strPath+'/control'):
					os.makedirs(self.strPath+'/control')
				if not os.path.exists(self.strPath+'/modelo'):
					os.makedirs(self.strPath+'/modelo')
				if not os.path.exists(self.strPath+'/vista'):
					os.makedirs(self.strPath+'/vista')
		except:
			sys.exit('Proyecto ya existente')
			
	def crearArchivos(self):
		if not os.path.isfile(self.strPath+'/base/data000001.sql'):
			#with open(self.strPath+'/base/data000001.sql', 'w+'): pass
			open(self.strPath+'/base/data000001.sql', 'w+').close()
		if not os.path.isfile(self.strPath+'/base/dependencies000001.sql'):
			open(self.strPath+'/base/dependencies000001.sql', 'w+').close()
		if not os.path.isfile(self.strPath+'/base/patch000001.sql'):
			open(self.strPath+'/base/patch000001.sql', 'w+').close()
		if not os.path.isfile(self.strPath+'/base/schema.sql'):
			f = open(self.strPath+'/base/schema.sql', 'w+')
			f.write(self.strBDesquema)
			f.close()
			
	def actualizarArchivoSistemas(self):
		if not os.path.isfile(os.path.dirname(__file__)+'/sistemas.txt'):
			f = open(self.strPath+'sistemas.txt', 'w+').close()
			aux = '../../../' + self.strProyNombreFull + '/'
		else:
			aux = '\n../../../' + self.strProyNombreFull + '/'
			
		f = open(os.path.dirname(__file__)+'/sistemas.txt', 'a')
		f.write(aux)
		f.close()
			
	def getProyecto(self):
		return self.strPath
		 
	def getProyectoNombre(self):
		return self.strProyNombre
			

print '**************CREAR PROYECTO NUEVO PXP*********************'

strProyNombre = raw_input('Introduzca el nombre del Nuevo Proyecto: ')
strBDesquema = raw_input('Introduzca el nombre del Esquema de Base de datos: ')
print __file__
objProy = clsInitProy(strProyNombre,strBDesquema)

print '-------------------------------------------'
print 'Se creara el proyecto en la siguiente ruta: ' + objProy.getProyecto()

strOk = ''
while (strOk != 'si' and strOk != 'no'):
	strOk = raw_input('Esta seguro de crear el proyecto? (si/no)')
if strOk == 'si':
	objProy.crearDirectorios()
	objProy.crearArchivos()
	objProy.actualizarArchivoSistemas()
	sys.exit('PROYECTO \"'+ objProy.getProyectoNombre() +'\" CREADO!')
else:
	sys.exit('Programa terminado por usuario')

		