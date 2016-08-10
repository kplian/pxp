--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_lugar_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_tlugar_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tlugar'
 AUTOR: 		 (rac)
 FECHA:	        29-08-2011 09:19:28
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_lugar	integer;
    v_codigo_largo varchar;
			    
BEGIN

    v_nombre_funcion = 'param.f_tlugar_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_lug_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		29-08-2011 09:19:28
	***********************************/

	if(p_transaccion='PM_LUG_INS')then
					
        begin
        
           --obtiene codigo recursivamente
            IF v_parametros.id_lugar_fk is null THEN
               v_codigo_largo = v_parametros.codigo;
            ELSE
            
             WITH RECURSIVE t(id,id_fk,cod,n) AS (
               SELECT l.id_lugar,l.id_lugar_fk, l.codigo,1 
               FROM param.tlugar l 
               WHERE l.id_lugar = v_parametros.id_lugar_fk
              UNION ALL
               SELECT l.id_lugar,l.id_lugar_fk, l.codigo , n+1
               FROM param.tlugar l, t
               WHERE l.id_lugar = t.id_fk
            )
            SELECT pxp.textcat_all(a.cod||'.')
             into  
             v_codigo_largo
            FROM (SELECT  cod
                  FROM t 
                 order by n desc)  a;
                 
                 
               v_codigo_largo = v_codigo_largo||v_parametros.codigo;
            END IF;
            
            
        	--Sentencia de la insercion
        	insert into param.tlugar(
			codigo,
			estado_reg,
			id_lugar_fk,
			nombre,
			sw_impuesto,
			sw_municipio,
			tipo,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            codigo_largo,
            es_regional
          	) values(
			v_parametros.codigo,
			'activo',
			v_parametros.id_lugar_fk,
			v_parametros.nombre,
			v_parametros.sw_impuesto,
			v_parametros.sw_municipio,
			v_parametros.tipo,
			now(),
			p_id_usuario,
			null,
			null,
            v_codigo_largo,
            v_parametros.es_regional
			)RETURNING id_lugar into v_id_lugar;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Lugar almacenado(a) con exito (id_lugar'||v_id_lugar||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_lugar',v_id_lugar::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_lug_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		29-08-2011 09:19:28
	***********************************/

	elsif(p_transaccion='PM_LUG_MOD')then

		begin
            --obtiene codigo recursivamente
            IF v_parametros.id_lugar_fk is null THEN
               v_codigo_largo = v_parametros.codigo;
            ELSE
            
             WITH RECURSIVE t(id,id_fk,cod,n) AS (
               SELECT l.id_lugar,l.id_lugar_fk, l.codigo,1 
               FROM param.tlugar l 
               WHERE l.id_lugar = v_parametros.id_lugar_fk
              UNION ALL
               SELECT l.id_lugar,l.id_lugar_fk, l.codigo , n+1
               FROM param.tlugar l, t
               WHERE l.id_lugar = t.id_fk
            )
            SELECT pxp.textcat_all(a.cod||'.')
             into  
             v_codigo_largo
            FROM (SELECT  cod
                  FROM t 
                 order by n desc)  a;
                 
                 
               v_codigo_largo = v_codigo_largo||v_parametros.codigo;
            END IF;
        
			--Sentencia de la modificacion
			update param.tlugar set
			codigo = v_parametros.codigo,
			id_lugar_fk = v_parametros.id_lugar_fk,
			nombre = v_parametros.nombre,
			sw_impuesto = v_parametros.sw_impuesto,
			sw_municipio = v_parametros.sw_municipio,
			tipo = v_parametros.tipo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
            codigo_largo=v_codigo_largo,
            es_regional = v_parametros.es_regional
			where id_lugar=v_parametros.id_lugar;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Lugar modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_lugar',v_parametros.id_lugar::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_lug_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		29-08-2011 09:19:28
	***********************************/

	elsif(p_transaccion='PM_LUG_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tlugar
            where id_lugar=v_parametros.id_lugar;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Lugar eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_lugar',v_parametros.id_lugar::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

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