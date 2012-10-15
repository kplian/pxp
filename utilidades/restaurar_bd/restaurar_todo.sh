#!/bin/bash
i=0
#cargar configuracion de utilidades
#por ahora solo se carga la base de datos, mas adelante se cargaran otros datos
while read line         
    do
        #cargar una variable
        config[$i] = $line
    done < ../../../config_util.txt

#url pxp
url[0]=../../
#url segu
url[1]=../../sis_seguridad/
# url param
url[2]=../../sis_parametros/
# url gen
url[3]=../../sis_generador/
#url orga
url[4]=../../sis_organigrama/
# Primero se restaura los esquemas basicos
for item in ${url[*]}
do
    #restaurar subsistema
    funciones=$item"base/funciones/*.sql"
    #solo si no es actualizar
    psql ${config[0]} < $item"base/schema.sql"
        
    for f in $funciones
	do
	  psql ${config[0]} < $f
	done
	
	#solo si no es actualizar
    psql ${config[0]} < $item"base/patch000001.sql" 
    
done

# Finalmente se restaura los sistemas secundarios
# En el orden en el que estan en el archivo sistemas.txt
if [ -r ../../../sistemas.txt ]
then

    $i=0
    while read line         
    do 
        #restaurar subsistema
        funciones=$line"base/funciones/*.sql"
        #solo si no es actualizar
        psql ${config[0]} < $line"base/schema.sql"

        for f in $funciones
            do
              psql ${config[0]} < $f
            done

        #solo si no es actualizar
        psql ${config[0]} < $line"base/patch000001.sql"        
    done < ../../../sistemas.txt
else
    echo NO SE HA RESTAURADO NINGUN SISTEMAS ADEMAS DE LOS BASICOS SI NECESITA RESTAURAR ALGUNO DEBE EXISTIR EL ARCHIVO sistemas.txt CON PERMISOS DE LECTURA
fi
