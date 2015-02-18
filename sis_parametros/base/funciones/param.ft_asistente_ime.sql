CREATE OR REPLACE FUNCTION param.ft_asistente_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_asistente_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tasistente'
 AUTOR: 		 (admin)
 FECHA:	        05-04-2013 14:02:14
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
	v_id_asistente			integer;
	v_sql					varchar;
			    
BEGIN

    v_nombre_funcion = 'param.ft_asistente_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ASIS_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-04-2013 14:02:14
	***********************************/

	if(p_transaccion='PM_ASIS_INS')then
					
        begin
        	--Guardando el array de UOs
        	if coalesce(v_parametros.id_uo,'') != '' then
                v_sql = '
                        insert into param.tasistente(
                        id_uo,id_funcionario,estado_reg, recursivo, id_usuario_reg, fecha_reg)
                        select
                        uo.id_uo,' || v_parametros.id_funcionario ||', ''activo'','''||v_parametros.recursivo||''','||p_id_usuario||',now()
                        from orga.tuo uo
                        where uo.id_uo = ANY(ARRAY['||v_parametros.id_uo||'])
                        and uo.id_uo not in (select id_uo
                                            from param.tasistente
                                            where id_uo is not null
                                            and estado_reg = ''activo''
                                            and id_funcionario = ' || v_parametros.id_funcionario ||')';

                execute(v_sql);
            end if;
        
        	/*--Sentencia de la insercion
        	insert into param.tasistente(
			id_uo,
			id_funcionario,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_uo,
			v_parametros.id_funcionario,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_asistente into v_id_asistente;*/
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Registro de Asistentes por UO almacenado(a) con exito'); 
            --v_resp = pxp.f_agrega_clave(v_resp,'id_asistente',v_id_asistente::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_ASIS_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-04-2013 14:02:14
	***********************************/

	elsif(p_transaccion='PM_ASIS_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tasistente set
			id_uo = v_parametros.id_uo,
			id_funcionario = v_parametros.id_funcionario,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			recursivo = v_parametros.recursivo
			where id_asistente=v_parametros.id_asistente;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Registro de Asistentes por UO modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_asistente',v_parametros.id_asistente::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ASIS_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-04-2013 14:02:14
	***********************************/

	elsif(p_transaccion='PM_ASIS_ELI')then

		begin
			--Sentencia de la eliminacion
			update param.tasistente
			set estado_reg = 'inactivo'
            where id_asistente=v_parametros.id_asistente;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Registro de Asistentes por UO eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_asistente',v_parametros.id_asistente::varchar);
              
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