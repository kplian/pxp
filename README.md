PXP
===

Example

http://gema.kplian.com/sis_seguridad/vista/_adm/index.php

user:      angela.correa
password:  angela.correa

Framework PXP for agile web development

TO USE IT BY FIRST TIME:

1. Create folder for your project
2. Inside the folder of your project clone this repository (This will create the pxp folder)
    #git  clone http://github.com/kplian/pxp.git

3. Create a empty database for your project 
4. You must create soft-links inside your project root folder to: 
    * lib                     
    ln -s pxp/lib lib  (execute inside your project root folder) 
    * index.php               
    ln -s pxp/index.php index.php  (execute inside your project root folder)
    * sis_seguridad           
    ln -s pxp/sis_seguridad sis_seguridad  (execute inside your project root folder)
    * sis_generador           
    ln -s pxp/sis_generador sis_generador  (execute inside your project root folder)
    * sis_parametros          
    ln -s pxp/sis_parametros sis_parametros  (execute inside your project root folder)
    * sis_organigrama
    ln -s pxp/sis_organigrama sis_organigrama  (execute inside your project root folder)
    * sis_workflow
    ln -s pxp/sis_workflow sis_workflow (execute inside your project root folder)

   All these folders and files are inside pxp.
5. Create two folders one named "reportes_generados" and other "uploaded_files" inside your project root folder with write access for Apache user.
6. Create a file named "DatosGenerales.php" inside pxp/lib. This file could be a copy of DatosGenerales.sample.php wich already exists in the same folder.
  It's necesary to do some configurations in that file according to the database.


   --  ejm Create user dbweb_conexion  in your database with superuser privileges
     $_SESSION["_BASE_DATOS"]= "dbweb";
     $_SESSION["_USUARIO_CONEXION"] = "conexion" ;
	 $_SESSION["_CONTRASENA_CONEXION"]	= "pass_user_web_web_conexion" 


7. As postgres user execute "pxp/utilidades/restaurar_bd/restaurar_todo.py" (This will generate the database). Postgres user needs execution access
   to restaurar_todo.py (./restaurar_todo.py)
    - ejm 
        create user conexion in your database
        
        $_SESSION["_USUARIO_CONEXION"] = "conexion" ;
	    $_SESSION["_CONTRASENA_CONEXION"]	= "dbweb_conexion" ;
        ...   

7.1. Configure postgres file, pg_hba.conf in direccion /var/lib/pgsql/9.1/data/, add next line:


        local	all		postgres, dbweb_conexion 		trust


7.2. Restart postgres service
	
        /etc/init.d/postgresql-9.1 restart
or



        service postgresql-9.1 restart

8. You can use the framework now!!! (user:admin, password:admin)

TO CREATE A NEW SYSTEM:

1. Create a folder for the system. Inside it create this structure:
    * vista
    * control
    * modelo
    * base
      * funciones
      * schema.sql
      * data000001.sql
      * dependencies000001.sql
      * patch000001.sql
      * test_data.sql

  The folder "funciones" must contain one file for every function in the system. The file "schema.sql" should have the drop and create schema
  for the system. All the patch files contains the scripts to generate the database objects for the system. for example "schema.sql"
  
          DROP SCHEMA IF EXISTS nut CASCADE;
          CREATE SCHEMA nut AUTHORIZATION postgres;

2. Create or update a file named "sistemas.txt" inside your project root folder wich contains the path for every system of your project.Eg:
  "../../../sis_mantenimiento/"
  One path should be one line in the file

TO UPDATE THE DATABASE ON PULL OR MERGE:

* After pull the code is updated, the database changes are  not updated yet, but it's possible update executing:

  pxp/utilidades/restaurar_db/restaurar_todo.py














