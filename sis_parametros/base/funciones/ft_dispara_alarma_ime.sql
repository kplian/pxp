--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_dispara_alarma_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_dispara_alarma_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.talarma'
 AUTOR: 		 (fprudencio)
 FECHA:	        18-11-2011 11:59:10
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
	v_id_alarma	integer;  
    v_registros_config		record;
    v_registros_detalle		record;
    v_dif_dias				integer;
    v_id_funcionario		integer;
    v_id_subsistema			integer;
    v_consulta_config	    text;
    v_consulta_detalle		text;
    --Ids que se necesitan para  SAJ
    v_mensaje varchar;
			    
BEGIN   

    v_nombre_funcion = 'param.ft_dispara_alarma_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ALARMASAJ_INS'
 	#DESCRIPCION:	Revisa alaramas del sistema SAJ
 	#AUTOR:		rarteaga	
 	#FECHA:		18-11-2011 11:59:10
	***********************************/

	if(p_transaccion='PM_GENALA_INS')then
					
        begin    
        	/*
            IF(v_parametros.tipo='TODOS' or v_parametros.tipo='SAJ')THEN 
               v_mensaje:= saj.f_verifica_alarma(v_parametros.id_usuario);
            END IF;*/
            
            --ir introducion if que diparen la funcion segun sistema X
            IF(v_parametros.tipo='TODOS' or v_parametros.tipo='GEM')THEN 
                v_mensaje:= gem.f_verifica_alarma_gem(v_parametros.id_usuario);
            END IF;
 
           --Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Alarmas almacenado(a) con exito'); 
            v_resp = pxp.f_agrega_clave(v_resp,'respuesta',v_mensaje);

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
SECURITY DEFINER
COST 100;