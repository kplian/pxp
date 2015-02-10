INSTALACIÓN FRAMEWORK PXP
=========================

POSTGRES + APACHE + PHP5 (CENTOS 5.7)
---------------------------------------


Este es el manual inicial realizado con nuestros programadores , puede contener errores u omisiones, que esperamos solucionar con ayuda de todos ustedes, son bienvenidos todos los comentarios y sugerencias


Prerrequisitos:
----------------

contar con los archivos
backup de base de datos
backup de codigo fuente
puede conseguir las ultimas versiones aqui


INSTALACIÓN DE REPOSITORIO POSTGRES
------------------------------------

Referencia: http://yum.postgresql.org/howtoyum.php

1) Descargar el RPM adecuado para su distribución desde aquí ­http://yum.postgresql.org/repopackages.php

```wget http://yum.postgresql.org/9.1/redhat/rhel-5-x86_64/pgdg-centos91-9.1-4.noarch.rpm```

2) Como root

```cd /etc/yum.repos.d```

```vim /etc/yum.repos.d/CentOS-Base.repo```

Adicionar la linea

```exclude=postgresql* ```

3) Instalar el repositorio

```rpm -U pgdg-centos91-9.1-4.noarch.rpm```

INSTALACIÓN DE REPOSITORIO POSTGRES (Y LIBRERIAS ADICONALES)
-------------------------------------------------------------

1) yum -y install postgresql91-server postgresql91-docs postgresql91-contrib postgresql91-plperl postgresql91-plpython postgresql91-pltcl postgresql91-test rhdb-utils gcc-objc postgresql91-devel postgis91

gcc-objc: herramientas para compilar en c

postgresql91-devel: cabeceras y librerí­as (sin esto no se puede compilar en c porque no están los includes postgres.h, etc.)

2)Primera corrida de Postgres

service postgresql-9.1.2 initdb

service postgresql-9.1 start

3)Inicio automÃ¡tico de Postgresserive pos

 chkconfig postgresql-9.1 on


INSTALAR APACHE, PHP

1) Instalar repositorio. Edita el archivo

vim /etc/yum.repos.d/CentOSBase.repo

Adicionar

[utterramblings]
name=Jason's Utter Ramblings Repo
baseurl=http://www.jasonlitka.com/media/EL$releasever/$basearch/
enabled=1
gpgcheck=1
gpgkey=http://www.jasonlitka.com/media/RPM-GPG-KEY-jlitka

luego importer las llaves

rpm --import http://www.jasonlitka.com/media/RPM-GPG-KEY-jlitka

 

2) Ejecutar como root:

 yum -y install httpd php53  mod_ssl mod_auth_pgsql  php-pear php53-bcmath  php53-cli php53-ldap php53-pdo php53-pgsql php53-gd

httpd: apache 2

php: php

mod_ssl: modulo de ssl para conectar a apache

php-pear: módulo PEAR apache y php

php-pgsql: módulo de postgres para php

mod_auth_pgsql: módulo para conectar el postgres apache y php

php-bcmath: módulos para cálculos grandes con php

php53-gd: ligreria GD para graficos gant

 

Después iniciar apache:

/etc/init.d/httpd start

3) Inicio de apache

 service httpd start

4) Configuración automática de inicio

 chkconfig httpd on

5)Para permitir conexiones desde php hacia la base de datos. Si el SELINUX esta activo como root ejecutar:

setsebool -P httpd_can_network_connect_db=1

6)Habilitar el Firrewal para que acepte conexiones en los puertos HTTP (80), HTTPS (443) y Postgres (5432)

setup (entorno gráfico para configurar iptables)

 

7)Configuracion de /etc/php.ini

deshabilitar errores por defecto

display_errors = Off

 

configurarcion de persistnecia en php postgres (esto es opcional depende si queremos conexiones persistentes solo experimental)



pgsql.allow_persistent = On

pgsql.auto_reset_persistent = on

 

Nota

tiempo de ejecución 30 minutos considerando sistemas complejos, No es lo mismo que una página web común

max_execution_time = 1800


para manejo de archivos subir la capacidad de envio

 

memory_limit = 256M

post_max_size = 500M

upload_max_filesize = 500M

 

NOTA: Prueba para verificar que funcione  apache con php

- echo "<?php echo phpinfo(); ?>" > /var/www/html/prueba.php

 

CONFIGURACIÓN Y PREPARACION DE LA BASE DE DATOS

1) En pg_hba.conf habilitar las IP que se conectarán, y cambiar el método de autenticación a md5 tanto de los sockets unix como de Ipv4

 vim /var/lib/pgsql/9.1/data/pg_hba.conf

-------------------

local all all md5

local all postgres,bdweb_conexion trust

 IPv4 local connections:

hostall all 127.0.0.1/32 md5

hostall all 192.168.2.236/32 md5

2) Configurar Archivo

vim /var/lib/pgsql/9.1/data/postgresql.conf

Buscar e l parámetro y descomentar

1. listen_addresses = '*'

2. #configuracion de diccionarios para filtros

default_text_search_config = 'pg_catalog.spanish'




3. para manejo de imagenes



bytea_output = 'escape'

 

3)  Creación de la base de datos. Como root

su postgres

psql

=# create database dbweb with encoding ="UTF-8";

=# \q 

 exit

3) Configuracion de Postgis

Buscar los archivos Â postgis.sql y spatial_ref_sys.sql

/usr/pgsql-9.1/share/contrib/postgis-1.5/postgis.sql

psql -d dbweb -f postgis.sql

psql -d dbweb -f spatial_ref_sys.sql

4)Creación de los primeros usuarios

su postgres

psql

//el password de usuario debe coincidir con el asignado en el archive de configuracion ../wev/lib/DatosGenerales.php en su variable

$_SESSION["_CONTRASENA_CONEXION"]

=# create user dbweb_conexion with password 'dbweb_conexion';

//creamos la contraseña del usuario admin del framework . Esta contraseña encriptada equivale a la palabra "admin"

=# create user dbweb_admin with password "a1a69c4e834c5aa6cce8c6eceee84295";

=# CREATE ROLE rol_usuario_dbweb SUPERUSER NOINHERIT ROLE dbweb_admin;

 

NOTA: Los usuarios de base de datos se crean con el siguiente formato

[nombre_base_de_datos]_[cuenta_usaruio_framework],  ejemplo:

Si la base de datos tiene el nombre "dbweb"

El usuario "admin" del framework tendrá el siguiente usuario de base de datos

"dbweb_admin"

 

5)  Instalación de scipt de contrib _int.sql que contiene varias funciones de manejo de intarray

su postgres -

psql -d dbweb

Dentro de psql ejecutar lo siguiente:

 \i /usr/pgsql-9.0/share/contrib/_int.sql;

 

Preparación de PXP

1)Descomprimir el contenido del archivo web.tar.gz dentro de /var/www/html/web

Copiar el archivo dentro de /var/www/html

 tar -xzvf web.X.tar.gz

 chown -R apache.apache /var/www/html/web/

 chmod 700 -R /var/www/html/web/

2)Archivo de Configuración  /var/www/html/web/lib/DatosGenerales.php

 // Esta es la variable que indica el host del servidor Postgres

 $_SESSION["_HOST"] = "10.10.0.48";
//nombre de la carpeta donde se aloja el framework en el servidor web
//la cokies solamente son admitidas en esta dirección

$_SESSION["_FOLDER"] = "/web/";
//nombre carpeta de logs de postgres

$_SESSION["_FOLDER_LOGS_BD"]="/var/lib/pgsql/9.1/data/pg_log/";

//nombre base de los archivos de los logs de base de datos el nombre del archivo sera :

$_SESSION["_NOMBRE_LOG_BD"] ="postgresql";
// Esta es la variable que indica el usuario del servidor Postgres
$_SESSION["_USUARIO_CONEXION"]="conexion"
;
// Esta es la variable que indica la contrasena del usuario de Postgres
$_SESSION["_CONTRASENA_CONEXION"]="dbweb_conexion";

// Esta es la variable que indica el nombre de la base de datos a utilizar

$_SESSION["_BASE_DATOS"]="dbweb";

// El usuario admin puede ejecutarse desde estas direcciones IP. Restringe el uso del usuarios con el rol administrador solamente a las direcciones declaradas en este array

$_SESSION["_IP_ADMIN"]=array('10.100.105.64','10.100.105.54â€™);

//la palabra utilizada como semilla tambien debe configurarce y coincidir exactamente en el triger de creacion de usuarios  (segu.trigger_usuario)

$_SESSION["_SEMILLA"] = "+_)(*&^%$#@!@TERPODO";


 

INSTALACION DE FUENTES PARA JPGRPAH

 

Descargar el paquete de.http://www.cabextract.org.uk/ con preferencia el tar.gz:cabextract-1.4.tar.gz o su última versión

1.  Proceder a descomprimir y ejecutar:

 gzip -cd < cabextract-1.4.tar.gz | tar xf -
 cd cabextract-1.4
 ./configure
 make
 make install


2.Baja la especificación del paquete msttcorefonts con el comando:

 wget http://corefonts.sourceforge.net/msttcorefonts-2.0-1.spec

3.Con la especificación podemos generar el nuevo rpm:

 rpmbuild -bb msttcorefonts-2.0-1.spec

3.1 Solución en el caso de ver: rpmbuild: command not found
 yum install rpm-build

 

4.  El anterior comando baja los archivos necesarios los compila y genera el rpm (Necesitas tener instaladas las herramientas de desarrollo en tu sistema). Ahora nos toca instalar ese paquete:

 rpm -ivh /usr/src/redhat/RPMS/noarch/msttcorefonts-2.0-1.noarch.rpm

5.Los nuevos fondos se instalan en /usr/share/fonts/truetype/. Para permitir que jpgraph encuentre los fonts requeridos crear el directorio:

 mkdir /usr/share/fonts/truetype / msttcorefonts

y copiar los fondos con:

 cp /usr/share/fonts/trutype/*.ttf /usr/share/fonts/truetype/msttcorefonts



Instalar JPGRAPH  (Solo para actualizar Pxp ya viene con una version compatible)
[root@proot /]# wget http://www.aditus.nu/jpgraph/jpdownload.php/
[root@proot /]# tar zxvf jpgraph-3.5.0b1.tar.gz
[root@proot /]# ln -s jpgraph-3.5.0b1/ jpgraph
[root@proot /]# rm jpgraph-3.5.0b1.tar.gz


PREPARACION DEL MODULO DE BITACORAS

 

=> Para compilar el paquete en c (librerías instaladas anteriormente)

1)  Copia de archivo:

Para compilar el programa en c de phx:

Entrar al directorio /usr/local/lib/ y copiar el archivo phx.c

2)compilar

gcc -I /usr/local/include -I /usr/pgsql-9.0/include/server/ -fpic -c /usr/local/lib/phx.c
gcc -I /usr/local/include -I /usr/pgsql-9.0/include/server/ -shared -o phx.so phx.o

Hacer dueño a root con

chown root.postgres phx.so

Dar permisos con

chmod 750 phx.so

3)  Copiar el archivo phxbd.sh a la ruta /usr/local/lib/

Verificar el contenido sea el siguiente

vim /usr/local/lib/phxbd.php

CONTENIDO DEL ARCHIVO:

#!/bin/bash

top -b -n 1 | grep -e postgres -e httpd |  awk '{print $1","$12","$2","$9","$10","$5""""}' > /tmp/procesos.csv

chown root.postgres /tmp/procesos.csv

chmod 740 /tmp/procesos.csv

Asignar los permisos necesarios para la corrida del archivo

sudo chown root.root /usr/local/lib/phxbd.sh

sudo chmod 700 /usr/local/lib/phxbd.sh

4)  Crear Cron como usuario postgres para log de bd apartir del archivo

cron.txt .

Es este archivo cambiar [/opt/PostgreSQL/9.1/data/pg_log/postgresql] de acuerdo a la ruta de postgres Â en [/opt/PostgreSQL/9.1/data/pg_log/log_cron.log] se guardan los logs del cron y tb dependen de la ruta de postgres

NOTA: El archivo Cron.txt tiene la configuración del para la generación de bitácoras y también para el envío de las alarmas configuradas en el framework.

su postgres

 crontab /usr/local/lib/cron.txt

5) Modificar postgresql.conf de acuerdo a lo requerido

1. log_destination  csvlog

2. logging_collector on

3. log_directory dejar el por defecto o si se cambia dar permisos a postgres

4. log_filename  'postgresql-%Y-%m-%d.log'

5. log_rotation_age  1d

5. log_rotation_size  0

6. log_truncate_on_rotation off

7. log_error_verbosity  verbose

8. log_statement  mod (recomendado Â puede ser all, ddl y none)

9. escape_string_warning  off

 

6)   Verificar  que las siguientes variables en el archivo de configuración están correctas:  .. /lib/DatosGenerales.php

$_SESSION["_FOLDER_LOGS_BD"]= "ruta logs de psotgres"

$_SESSION["_NOMBRE_LOG_BD"] ="postgresql";

7) Asignar permisos a postgres para hacer sudo al ejecutar el script. Como root ejecutar

visudo

Comentar:

Defaultsrequiretty

adir:

postgres  ALL=NOPASSWD: /usr/local/lib/phxbd.sh

 

RESTAURA DUMP DE BASE DE DATOS  sin errores.

1) Restauración de la bd a partir del dump

pg_restore -d  bdweb -U postgres -no-owner -no-privileges -e -v  --disable-triggers dbweb.dump

Asegurarse que pg_restore sea de la versión 9 y no de una versión anterior, porque sino generará error de compatibilidad.

PERMISOS Y ROLES DE USUARIO

NOTA.-

 

1) El usuario de conexión en este caso "dbwebpxp_conexion" debe tener permisos limitados solo para ejecutar algunas cuantas funciones:

f_ejecutar_dblink

usuario

esquema/funcion	
SEL

UPD

exec

own

usg

dbwebpxp_conexion

sss

 	 	 	 	
x

dbwebpxp_conexion

f_ejecutar_dblink

 

 	 	
x

 	 
 	
Secuencia parÃ¡metro en public

x

x

 	 	
X

 	
relacion variable_global

x

 	 	 	 
 	
Relacin segu.tprimo

x

 	 	 	 
 	
Segu.ft_validar_usuario_ime

 	 	
x

 	 
 

2) Cada vez que se creen nuevas funciones tablas para que los usuarios que se creen en el sistemas puedan realizar transacciones sobre las mismas hay que otorgar permisos al grupo de de usuarios del sistemas

 

SELECT segu.f_grant_all_privileges ('rol_usuario_dbweb','todos');


PARA INSTALAR PHP  MCRYPT  EN CENTOS 5.X CLIENTE Y SERVIDOR REST

wget http://museum.php.net/php5/php-5.3.3.tar.gz

tar xf php-5.3.3.tar.gz

cd php-5.3.3/ext/mcrypt/

yum install php53-devel

yum install libmcrypt libmcrypt-devel

phpize && ./configure && make && sudo make install

sudo echo "extension=mcrypt.so" > /etc/php.d/mcrypt.ini

/etc/init.d/httpd restart
 
PARA HABILITAR REWRITE ENGINE PARA SERVIDOR  REST

Configurar en /etc/httpd/conf/httpd.conf
AllowOverride All
Para todos los sitios o para el virtualhost en el que corre el framework

 

ANEXOS: FUNCIONES CON PRIVILEGISO DE EJECUCION DE ADMINISTRADOR

 	 
 	
segu.f_get_id_usuario

 	
Public.f_verifica_permisos

 	
f_registrar_log

 	
f_obtiene_clave_valor

 	
f_agrega_clave
