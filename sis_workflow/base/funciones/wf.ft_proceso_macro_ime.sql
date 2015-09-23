--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_proceso_macro_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_proceso_macro_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.proceso_macro'
 AUTOR: 		 (rac)
 FECHA:	        19-02-2013 13:51:29
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
	v_id_proceso_macro	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_proceso_macro_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	if(p_transaccion='WF_PROMAC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.tproceso_macro(
              id_subsistema,
              nombre,
              codigo,
              inicio,
              estado_reg,
              id_usuario_reg,
              fecha_reg,
              id_usuario_mod,
              fecha_mod,
              grupo_doc
              ) values(
              v_parametros.id_subsistema,
              v_parametros.nombre,
              v_parametros.codigo,
              v_parametros.inicio,
              'activo',
              p_id_usuario,
              now(),
              null,
              null,
              v_parametros.grupo_doc
							
			)RETURNING id_proceso_macro into v_id_proceso_macro;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proceso Macro almacenado(a) con exito (id_proceso_macro'||v_id_proceso_macro||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_macro',v_id_proceso_macro::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	elsif(p_transaccion='WF_PROMAC_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tproceso_macro set
			id_subsistema = v_parametros.id_subsistema,
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			inicio = v_parametros.inicio,
			id_usuario_mod = p_id_usuario,
            grupo_doc = v_parametros.grupo_doc,
			fecha_mod = now()
			where id_proceso_macro=v_parametros.id_proceso_macro;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proceso Macro modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_macro',v_parametros.id_proceso_macro::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	elsif(p_transaccion='WF_PROMAC_ELI')then

		begin
        	
            if (exists (select 1 
            			from wf.ttipo_proceso t
                        where t.id_proceso_macro = v_parametros.id_proceso_macro and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Tipos de Proceso que depende(n) de este proceso macro';
            end if;
            
            if (exists (select 1 
            			from wf.ttipo_proceso_origen t
                        where t.id_proceso_macro = v_parametros.id_proceso_macro and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Tipos de Proceso Origen que depende(n) de este proceso macro';
            end if;
            
            
			--Sentencia de la eliminacion
			update  wf.tproceso_macro
            set estado_reg = 'inactivo'
            where id_proceso_macro=v_parametros.id_proceso_macro;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proceso Macro eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_macro',v_parametros.id_proceso_macro::varchar);
              
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