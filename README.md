PXP
===

Framework PXP for agile web development

TO USE IT BY FIRST TIME:

1. Create folder for your project
2. Inside the folder of your project clone this repository
3. Create a empty database for your project
4. You must create soft-links inside your project root folder to: 
    * lib
    * index.php
    * sis_seguridad
    * sis_generador
    * sis_parametros
    * sis_organigrama

   All these folders and files are inside pxp.
5. Create a folder named "reportes_generados" inside your project root folder with write access for Apache user.
6. Create a file named "config_util.txt" inside your project root folder wich contains the name of database in the first line.
7. Create a file named "DatosGenerales.php" inside pxp/lib. This file could be a copy of DatosGenerales.sample.php wich already exists in the same folder.
  It's necesary to do some configurations in that file according to the database.
8. As postgres user execute "pxp/utilidades/restaurar_bd/restaurar_todo.sh" (This will generate the databse).
9. You can use the framework now!!! (user:admin, password:admin)

TO CREATE A NEW SYSTEM:

1. Create a folder for the system. Inside it create this structure:
    * vista
    * control
    * modelo
    * base ->  funciones
           ->  schema.sql
           ->  patch000001.sql
           ->  patch000002.sql
           ->  patch00xxxx.sql

  The folder "funciones" must contain one file for every function in the system. The file "schema.sql" should have the drop and create schema
  for the system. All the patch files contains the scripts to generate the database objects for the system.

2. Create or update a file named "sistemas.txt" inside your project root folder wich contains the path for every system of your project.Eg:
  "../../../sis_mantenimiento/"
  One path should be one line in the file

TO UPDATE THE DATABASE ON PULL OR MERGE:

* After pull the code is updated, the database changes are  not updated yet, but it's possible update executing:

  pxp/utilidades/restaurar_db/actualizar_todo.sh



