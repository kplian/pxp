--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_plantilla_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Contabilidad
 FUNCION: 		param.f_plantilla_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tplantilla'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        01-04-2013 21:49:11
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
	v_id_plantilla	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_plantilla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PLT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	if(p_transaccion='PM_PLT_INS')then
					
        begin
           
           if v_parametros.sw_ic = 'si' and v_parametros.sw_monto_excento = 'no' then
            raise exception 'Si tenemos IC es necesario habilitar el Excento';
           end if;
           
           v_parametros.valor_excento = COALESCE(v_parametros.valor_excento,0);
           
           IF v_parametros.tipo_excento != 'variable'  and  v_parametros.valor_excento <= 0 THEN
             raise exception 'El valor Exento no puede ser menro a cero,  si el tipo no es variable';
           END IF;
           
           IF  v_parametros.valor_excento < 0 THEN
             raise exception 'El valor Exento no puede ser menor a cero';
           END IF;
           
        
        	--Sentencia de la insercion
        	insert into param.tplantilla(
                estado_reg,
                desc_plantilla,
                sw_tesoro,
                sw_compro,
                nro_linea,
                tipo,
                fecha_reg,
                id_usuario_reg,
                fecha_mod,
                id_usuario_mod,
                sw_monto_excento,
                sw_descuento ,
                sw_autorizacion,
                sw_codigo_control,
                tipo_plantilla,
                sw_nro_dui,
                sw_ic,
                tipo_excento,
                valor_excento,
                tipo_informe,
                sw_qr,
                sw_nit,
                plantilla_qr
                
                
                
          	) values(
			'activo',
			v_parametros.desc_plantilla,
			v_parametros.sw_tesoro,
			v_parametros.sw_compro,
			v_parametros.nro_linea,
			v_parametros.tipo,
			now(),
			p_id_usuario,
			null,
			null,
            v_parametros.sw_monto_excento,
            v_parametros.sw_descuento ,
            v_parametros.sw_autorizacion,
            v_parametros.sw_codigo_control,
            v_parametros.tipo_plantilla,
            v_parametros.sw_nro_dui,
            v_parametros.sw_ic,
            v_parametros.tipo_excento,
            v_parametros.valor_excento,
            v_parametros.tipo_informe,
            v_parametros.sw_qr,
            v_parametros.sw_nit,
            v_parametros.plantilla_qr
		)RETURNING id_plantilla into v_id_plantilla;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla Documento almacenado(a) con exito (id_plantilla'||v_id_plantilla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla',v_id_plantilla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_PLT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	elsif(p_transaccion='PM_PLT_MOD')then

		begin
        
        
            if v_parametros.sw_ic = 'si' and v_parametros.sw_monto_excento = 'no' then
               raise exception 'Si tenemos IC es necesario habilitar el Excento';
            end if;
           
           v_parametros.valor_excento = COALESCE(v_parametros.valor_excento,0);
           
           IF v_parametros.tipo_excento != 'variable'  and  v_parametros.valor_excento <= 0 THEN
             raise exception 'El valor Exento no puede ser menor a cero,  si el tipo no es variable';
           END IF;
           
           IF  v_parametros.valor_excento < 0 THEN
             raise exception 'El valor Exento no puede ser menor a cero';
           END IF;
           
           
			--Sentencia de la modificacion
			update param.tplantilla set
              desc_plantilla = v_parametros.desc_plantilla,
              sw_tesoro = v_parametros.sw_tesoro,
              sw_compro = v_parametros.sw_compro,
              nro_linea = v_parametros.nro_linea,
              tipo = v_parametros.tipo,
              fecha_mod = now(),
              id_usuario_mod = p_id_usuario,
              sw_monto_excento = v_parametros.sw_monto_excento,
              sw_descuento=v_parametros.sw_descuento,
              sw_autorizacion=v_parametros.sw_autorizacion,
              sw_codigo_control=v_parametros.sw_codigo_control,
              tipo_plantilla=v_parametros.tipo_plantilla, 
              sw_nro_dui = v_parametros.sw_nro_dui,
              sw_ic = v_parametros.sw_ic,
              tipo_excento = v_parametros.tipo_excento,
              valor_excento = v_parametros.valor_excento,
              tipo_informe = v_parametros.tipo_informe,
              sw_qr = v_parametros.sw_qr,
              sw_nit = v_parametros.sw_nit,
              plantilla_qr = v_parametros.plantilla_qr,
              sw_estacion = v_parametros.sw_estacion,
              sw_punto_venta = v_parametros.sw_punto_venta,
              sw_cod_no_iata = v_parametros.sw_codigo_no_iata
			where id_plantilla=v_parametros.id_plantilla;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla Documento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla',v_parametros.id_plantilla::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PLT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	elsif(p_transaccion='PM_PLT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tplantilla
            where id_plantilla=v_parametros.id_plantilla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla Documento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla',v_parametros.id_plantilla::varchar);
              
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