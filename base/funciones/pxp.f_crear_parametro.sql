CREATE OR REPLACE FUNCTION pxp.f_crear_parametro (
  variables varchar [],
  valores varchar [],
  tipos varchar []
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		pxp.f_crear_parametro
 DESCRIPCION:   crea  una tabla para devolver un row como parametro. Devuelve el nombre de la tabla
                Web
 AUTOR: 	    KPLIAN (jrr)	
 FECHA:	        01/05/2016
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
 
 
 DECLARE
    v_nombre_funcion   	text;
    v_resp              varchar;
    v_respuesta         boolean;
    v_secuencia		integer;
    v_consulta		varchar;
    v_tamano		integer;
 BEGIN
    v_nombre_funcion:='pxp.f_crear_parametro';
    v_secuencia:=(nextval('pxp.parametro'));
    v_consulta:='create temporary table tt_parametros_'||v_secuencia||'(';
    v_tamano:=array_upper(tipos,1);
             --   raise exception 'aa%',variable_files;          

    for i in 1..(v_tamano-1) loop
        v_consulta:=v_consulta || variables[i] || ' ' || tipos[i] || ',';
    end loop;
    v_consulta:=v_consulta || variables[v_tamano] || ' ' || tipos[v_tamano] || ') on commit drop';
    
    execute(v_consulta);

    v_consulta:='insert into tt_parametros_'||v_secuencia||' values(';

    for i in 1..(v_tamano-1) loop
	    -- 3.2.1)IF si los valores son del tipo numeric o integer los espacios se insertan con valores nulos
	    IF(tipos[i]='numeric' or tipos[i]='integer' or tipos[i]='int4' or tipos[i]='int8' or tipos[i]='bigint')then
		if(valores[i]='')THEN
		    v_consulta:=v_consulta || 'null' || ',';
		else
		    v_consulta:=v_consulta || valores[i] || ',';
		end if;
	    ELSE
		--RAC 12/09/2011 validacion para campo date vacio 
		if((tipos[i]='date' or tipos[i]='timestamp' or tipos[i]='time' or tipos[i]='bool' or tipos[i]='boolean') and  valores[i]='')THEN
		    v_consulta:=v_consulta || 'null' || ',';
		else
		   v_consulta:=v_consulta ||''''|| replace(valores[i],'''','''''') || ''',';
		end if;
	    

	    END IF;

        end loop;

        if(tipos[v_tamano]='numeric' or tipos[v_tamano]='integer' or tipos[v_tamano]='int4' or tipos[v_tamano]='int8' or tipos[v_tamano]='bigint')then
                 
                if(valores[v_tamano]='')THEN
                    v_consulta:=v_consulta || 'null' || ')';
                else
                    v_consulta:=v_consulta || valores[v_tamano] || ')';
                end if;
        else
              if((tipos[v_tamano]='date' or tipos[v_tamano]='timestamp' or tipos[v_tamano]='time' or tipos[v_tamano]='bool' or tipos[v_tamano]='boolean') and  valores[v_tamano]='')THEN
                  v_consulta:=v_consulta || 'null' || ')';
              else
                v_consulta:=v_consulta ||''''|| replace(valores[v_tamano],'''','''''') ||  ''')';
              end if;
        end if;
      -- 3.4  Ejecuta la cadena de insercion  en la tabla temporal con los datos recibidos del servidor
    	--raise exception '%',v_consulta;
        execute v_consulta;

    
    return 'tt_parametros_'||v_secuencia;
    
 EXCEPTION

	WHEN OTHERS THEN
    	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;