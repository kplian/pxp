--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_ep_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_ep_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tep'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        06-02-2013 19:20:32
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
	v_id_ep	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_ep_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_FRPP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 19:20:32
	***********************************/

	if(p_transaccion='PM_FRPP_INS')then
					
        begin

            if (exists((select 1
                       from param.tep ep
                       where ep.id_financiador = v_parametros.id_financiador
                         and ep.id_regional = v_parametros.id_regional
                         and ep.id_prog_pory_acti = v_parametros.id_prog_pory_acti))) then
                v_resp = pxp.f_agrega_clave(v_resp, 'mensaje',
                                            'La estrutura programática ya existe!');
                raise exception '%', v_resp;
            end if;
        	--Sentencia de la insercion
        	insert into param.tep(
			estado_reg,
			id_financiador,
			id_prog_pory_acti,
			id_regional,
			--sw_presto,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_financiador,
			v_parametros.id_prog_pory_acti,
			v_parametros.id_regional,
			--v_parametros.sw_presto,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_ep into v_id_ep;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Financiador-Regional-Programa-Proyecto almacenado(a) con exito (id_ep'||v_id_ep||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_ep',v_id_ep::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_FRPP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 19:20:32
	***********************************/

	elsif(p_transaccion='PM_FRPP_MOD')then

		begin
            --Sentencia de la modificacion
            if (exists((select 1
                        from param.tep ep
                        where ep.id_financiador = v_parametros.id_financiador
                          and ep.id_regional = v_parametros.id_regional
                          and ep.id_prog_pory_acti = v_parametros.id_prog_pory_acti
                          and ep.id_ep != v_parametros.id_ep))) then
                v_resp = pxp.f_agrega_clave(v_resp, 'mensaje',
                                            'La estrutura programática ya existe!');
                raise exception '%', v_resp;
            end if;

			update param.tep set
			id_financiador = v_parametros.id_financiador,
			id_prog_pory_acti = v_parametros.id_prog_pory_acti,
			id_regional = v_parametros.id_regional,
			--sw_presto = v_parametros.sw_presto,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_ep=v_parametros.id_ep;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Financiador-Regional-Programa-Proyecto modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_ep',v_parametros.id_ep::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_FRPP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 19:20:32
	***********************************/

	elsif(p_transaccion='PM_FRPP_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tep
            where id_ep=v_parametros.id_ep;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Financiador-Regional-Programa-Proyecto eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_ep',v_parametros.id_ep::varchar);
              
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