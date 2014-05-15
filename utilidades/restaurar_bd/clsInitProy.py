#!/usr/bin/python
import subprocess
import os
import sys
import datetime
from git import Repo

class clsInitProy:

	def __init__(self, pStrProyNombre, pStrBDesquema, pStrPath):
		self.strProyNombre = pStrProyNombre
		self.strProyNombreFull = 'sis_' + pStrProyNombre
		self.strPath = pStrPath
		self.strPathFull = self.strPath + self.strProyNombreFull
		self.strBDesquema = pStrBDesquema
		
	def crearDirectorios(self):
		#Verifica que no exista ya el directorio
		try:
		
			if not os.path.exists(self.strPathFull):
				os.makedirs(self.strPathFull)
				#Inicializa repositorio Git
				newRepo = Repo.init(self.strPathFull)
				#Crea las carpetas de la estructura
				if not os.path.exists(self.strPathFull+'/base'):
					os.makedirs(self.strPathFull+'/base')
				if not os.path.exists(self.strPathFull+'/base/funciones'):
					os.makedirs(self.strPathFull+'/base/funciones')
				if not os.path.exists(self.strPathFull+'/control'):
					os.makedirs(self.strPathFull+'/control')
				if not os.path.exists(self.strPathFull+'/modelo'):
					os.makedirs(self.strPathFull+'/modelo')
				if not os.path.exists(self.strPathFull+'/vista'):
					os.makedirs(self.strPathFull+'/vista')
		except:
			sys.exit('Proyecto ya existente')
			
	def crearArchivos(self):
		if not os.path.isfile(self.strPathFull+'/base/data000001.sql'):
			#with open(self.strPathFull+'/base/data000001.sql', 'w+'): pass
			open(self.strPathFull+'/base/data000001.sql', 'w+').close()
		if not os.path.isfile(self.strPathFull+'/base/dependencies000001.sql'):
			open(self.strPathFull+'/base/dependencies000001.sql', 'w+').close()
		if not os.path.isfile(self.strPathFull+'/base/patch000001.sql'):
			open(self.strPathFull+'/base/patch000001.sql', 'w+').close()
		if not os.path.isfile(self.strPathFull+'/base/schema.sql'):
			f = open(self.strPathFull+'/base/schema.sql', 'w+')
			f.write(self.strBDesquema)
			f.close()
			
	def actualizarArchivoSistemas(self):
		
		if not os.path.isfile(self.strPath+'sistemas.txt'):
			f = open(self.strPath+'sistemas.txt', 'w+').close()
			aux = '../../../' + self.strProyNombreFull + '/'
		else:
			aux = '\n../../../' + self.strProyNombreFull + '/'
			
		f = open(self.strPath+'sistemas.txt', 'a')
		f.write(aux)
		f.close()
			
	def getProyecto(self):
		return self.strPathFull
		
	def getProyectoNombre(self):
		return self.strProyNombre
			

print '**************CREAR PROYECTO NUEVO PXP*********************'

strProyNombre = raw_input('Introduzca el nombre del Nuevo Proyecto: ')
strProyAlias = raw_input('Introduzca el alias del Nuevo Proyecto: ')
strPath = raw_input('Introduzca el path: ')
strBDesquema = raw_input('Introduzca el nombre del Esquema de Base de datos: ')
print __file__
objProy = clsInitProy(strProyNombre,strBDesquema,strPath)

print '-------------------------------------------'
print 'Se creará el proyecto con en la siguiente ruta: ' + objProy.getProyecto()

strOk = ''
while (strOk != 'si' and strOk != 'no'):
	strOk = raw_input('¿Esta seguro de crear el proyecto? (si/no)')
if strOk == 'si':
	objProy.crearDirectorios()
	objProy.crearArchivos()
	objProy.actualizarArchivoSistemas()
	sys.exit('PROYECTO \"'+ objProy.getProyectoNombre() +'\" CREADO!')
else:
	sys.exit('Programa terminado por usuario')

		