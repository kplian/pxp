-- Function: param.f_tproveedor_ime(integer, integer, character varying, character varying)

-- DROP FUNCTION param.f_tproveedor_ime(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION param.f_tproveedor_ime(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_tproveedor_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tproveedor'
 AUTOR: 		 (mzm)
 FECHA:	        15-11-2011 10:44:58
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
	v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_proveedor          integer;
    v_codigo                varchar;
    
    --10abr12   
    v_respuesta_sinc       varchar;            
BEGIN
                           
    v_nombre_funcion = 'param.f_tproveedor_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_PROVEE_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        mzm    
     #FECHA:        15-11-2011 10:44:58
    ***********************************/

    if(p_transaccion='PM_PROVEE_INS')then
                    
        begin      
          
           --verificar que el proveedor no se duplique  para la misma institucion 
           -- o persona
           
           IF( v_parametros.id_institucion is not NULL 
                and (exists (select 1 from param.tproveedor  p
                      where p.id_institucion =  v_parametros.id_institucion
                      and p.estado_reg ='activo'))) THEN
                      
               raise exception 'ya esxiste un proveedor para esta institución';
           
           
           END IF;
           
           
           IF( v_parametros.id_persona is Not NULL 
               and (exists (select 1 from param.tproveedor  p
                      where p.id_persona =  v_parametros.id_persona
                      and p.estado_reg ='activo'))) THEN
                      
               raise exception 'ya esxiste un proveedor para esta persona';
           END IF;
           
           
        
            
            --Sentencia de la insercion
            insert into param.tproveedor(
              id_persona,
              --codigo,
             
              numero_sigma,
              tipo,
              estado_reg,
              id_institucion,
              id_usuario_reg,
              fecha_reg,
              id_usuario_mod,
              fecha_mod,
              nit,
              id_lugar
              ) values(
              v_parametros.id_persona,
              --v_codigo,
             
              v_parametros.numero_sigma,
              v_parametros.tipo,
              'activo',
              v_parametros.id_institucion,
              p_id_usuario,
              now(),
              null,
              null,
              v_parametros.nit,
              v_parametros.id_lugar
            )RETURNING id_proveedor into v_id_proveedor;
            
            v_codigo:=('PROV'||f_llenar_ceros(v_id_proveedor::numeric,4))::varchar;      
           
           
           
            update param.tproveedor
            set codigo=v_codigo
            where id_proveedor=v_id_proveedor;
            
            --10-04-2012: sincronizacion de UO entre BD
            /*v_respuesta_sinc:=param.f_sincroniza_proveedor_entre_bd(v_id_proveedor,'10.172.0.13','5432','db_link','db_link','dbendesis' ,'INSERT');
          
            if(v_respuesta_sinc!='si')  then
               raise exception 'Sincronizacion de proveedor en BD externa no realizada%',v_respuesta_sinc;
            end if;*/
            
                         
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedores almacenado(a) con exito (id_proveedor'||v_id_proveedor||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor',v_id_proveedor::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************    
     #TRANSACCION:  'PM_PROVEE_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        mzm    
     #FECHA:        15-11-2011 10:44:58
    ***********************************/

    elsif(p_transaccion='PM_PROVEE_MOD')then

        begin
            --Sentencia de la modificacion
            update param.tproveedor set
            id_persona = v_parametros.id_persona,
             nit=v_parametros.nit,
            --codigo = v_parametros.codigo,
            numero_sigma = v_parametros.numero_sigma,
            tipo = v_parametros.tipo,
            id_institucion = v_parametros.id_institucion,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_lugar = v_parametros.id_lugar
            where id_proveedor=v_parametros.id_proveedor;
           
        
            --10-04-2012: sincronizacion de UO entre BD
            /*v_respuesta_sinc:=param.f_sincroniza_proveedor_entre_bd(v_parametros.id_proveedor,'10.172.0.13','5432','db_link','db_link','dbendesis' ,'UPDATE');
                     
            if(v_respuesta_sinc!='si')  then
               raise exception 'Sincronizacion de proveedor en BD externa no realizada%',v_respuesta_sinc;
            end if;*/
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedores modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor',v_parametros.id_proveedor::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
     #TRANSACCION:  'PM_PROVEE_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        mzm    
     #FECHA:        15-11-2011 10:44:58
    ***********************************/

    elsif(p_transaccion='PM_PROVEE_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from param.tproveedor
            where id_proveedor=v_parametros.id_proveedor;
             
            --10-04-2012: sincronizacion de UO entre BD
            /*v_respuesta_sinc:=param.f_sincroniza_proveedor_entre_bd(v_parametros.id_proveedor,'10.172.0.13','5432','db_link','db_link','dbendesis','DELETE');
                     
            if(v_respuesta_sinc!='si')  then
               raise exception 'Sincronizacion de proveedor en BD externa no realizada%',v_respuesta_sinc;
            end if;*/
              
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedores eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor',v_parametros.id_proveedor::varchar);
              
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION param.f_tproveedor_ime(integer, integer, character varying, character varying) OWNER TO postgres;
