PXP
===

## SUPPORT : <a name="support"></a>
Youtube chanel (https://www.youtube.com/channel/UCSk4IfCR6swJYu3zPOEiGuw)

Support forum
(request an invitation! to rensi@kplian.com  or  jaime@kplian.com)

http://foro.kplian.com/

## DEMO : <a name="demo"></a>

http://gema.kplian.com/sis_seguridad/vista/_adm/index.php

	user:      admin
	 
	password:  admin


## INSTALLATION :<a name="installation"></a>

https://github.com/kplian/instalador_framework.pxp for centos 6.x and 7.x

(how to install ...   https://www.youtube.com/watch?v=fIQbMXl5Jdg)




## NEXT ...  (if you want another instance):<a name="new_system"></a>
## FOR CREATE A NEW INSTANCE:<a name="new_system"></a>

1. Create folder for your project  (example mypro)
2. Inside the folder of your project clone this repository (This will create the pxp folder)
    #git  clone https://github.com/kplian/pxp.git

3. Create a empty database for your project
3.1 Create database user for connection:

	Example: CREATE ROLE db_conexion NOINHERIT LOGIN PASSWORD 'db_conexion';

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
     $_SESSION["_FOLDER"] = "/mypro/";


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


## TO CREATE A NEW SYSTEM:<a name="new_system"></a>

1. Create a folder for the system. Inside it create this structure:
    * vista
    * control
    * modelo
    * base
      * funciones
      * schema.sql (name of database schema for the system)
      * data000001.sql (Scripts with initial data )
      * dependencies000001.sql (Scripts to create objects with dependency: create view, add foreing key constraints, etc.)
      * patch000001.sql (Scripts to create objects with no dependency: create table, add columns, etc.)
      * test_data.sql (Test data for the system)

  The folder "funciones" must contain one file for every function in the system. 

2. Create or update a file named "sistemas.txt" inside your project root folder wich contains the path for every system of your project.Eg:
  "../../../sis_mantenimiento/"
  One path should be one line in the file

## TO UPDATE THE DATABASE ON PULL OR MERGE:<a name="update_db"></a>


After pull, the code is updated,but database scripts are  not executed yet. It's possible to execute folowing these steps:
  
1. Go to "/pxp/utilidades/restaurar_bd/" folder
2. Change user to postgres: "su postgres -"  ##don't forget the score
3. Execute the script: "./restaurar_todo.py"
4. Now we have a menu with 4 options:
	* Option 1 Drops all tables and functions an restore them from scripts ¡¡¡You lose information here!!!!
	* Option 2 Keeps tables with data, drop functions and restore them from scripts and execute new script ¡¡¡You don't lose information here!!!!
	* Option 3 Generate a backup from the current database
	* Option 4 Exit the application

## CODE GENERATOR:<a name="code_generator"></a>

This video explains to use code generator for PXP

https://www.youtube.com/watch?v=uUVevOzYDy4

## LICENSE

See the [LICENSE](LICENSE.txt) file for license rights and limitations (GPLv3).
