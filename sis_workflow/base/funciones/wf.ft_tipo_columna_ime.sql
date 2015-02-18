CREATE OR REPLACE FUNCTION wf.ft_tipo_columna_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:       Work Flow
 FUNCION:       wf.ft_tipo_columna_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_columna'
 AUTOR:          (admin)
 FECHA:         07-05-2014 21:41:15
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:         
 FECHA:     
***************************************************************************/

DECLARE

    v_nro_requerimiento     integer;
    v_parametros            record;
    v_id_requerimiento      integer;
    v_resp                  varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_tipo_columna   integer;
                
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_columna_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
    #TRANSACCION:  'WF_TIPCOL_INS'
    #DESCRIPCION:   Insercion de registros
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:41:15
    ***********************************/

    if(p_transaccion='WF_TIPCOL_INS')then
                    
        begin
            --Sentencia de la insercion
            insert into wf.ttipo_columna(
            id_tabla,
            bd_campos_adicionales,
            form_combo_rec,
            bd_joins_adicionales,
            bd_descripcion_columna,
            bd_formula_calculo,
            form_sobreescribe_config,
            form_tipo_columna,
            grid_sobreescribe_filtro,
            estado_reg,
            bd_nombre_columna,
            form_es_combo,
            grid_campos_adicionales,
            bd_tipo_columna,
            id_usuario_reg,
            fecha_reg,
            id_usuario_mod,
            fecha_mod,
            bd_tamano_columna,
            form_label,
            bd_prioridad,
            form_grupo,
            bd_campos_subconsulta
            ) values(
            v_parametros.id_tabla,
            v_parametros.bd_campos_adicionales,
            v_parametros.form_combo_rec,
            v_parametros.bd_joins_adicionales,
            v_parametros.bd_formula_calculo,
            v_parametros.bd_descripcion_columna,
            v_parametros.form_sobreescribe_config,
            v_parametros.form_tipo_columna,
            v_parametros.grid_sobreescribe_filtro,
            'activo',
            v_parametros.bd_nombre_columna,
            v_parametros.form_es_combo,
            v_parametros.grid_campos_adicionales,
            v_parametros.bd_tipo_columna,
            p_id_usuario,
            now(),
            null,
            null,
            v_parametros.bd_tamano_columna,
            v_parametros.form_label,
            v_parametros.bd_prioridad,
            v_parametros.form_grupo,
            v_parametros.bd_campos_subconsulta
            )RETURNING id_tipo_columna into v_id_tipo_columna;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Columna almacenado(a) con exito (id_tipo_columna'||v_id_tipo_columna||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_columna',v_id_tipo_columna::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************    
    #TRANSACCION:  'WF_TIPCOL_MOD'
    #DESCRIPCION:   Modificacion de registros
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:41:15
    ***********************************/

    elsif(p_transaccion='WF_TIPCOL_MOD')then

        begin
            --Sentencia de la modificacion
            update wf.ttipo_columna set
            id_tabla = v_parametros.id_tabla,
            bd_campos_adicionales = v_parametros.bd_campos_adicionales,
            form_combo_rec = v_parametros.form_combo_rec,
            bd_joins_adicionales = v_parametros.bd_joins_adicionales,
            bd_descripcion_columna = v_parametros.bd_descripcion_columna,
            bd_formula_calculo = v_parametros.bd_formula_calculo,
            form_sobreescribe_config = v_parametros.form_sobreescribe_config,
            form_tipo_columna = v_parametros.form_tipo_columna,
            grid_sobreescribe_filtro = v_parametros.grid_sobreescribe_filtro,
            bd_nombre_columna = v_parametros.bd_nombre_columna,
            form_es_combo = v_parametros.form_es_combo,
            grid_campos_adicionales = v_parametros.grid_campos_adicionales,
            bd_tipo_columna = v_parametros.bd_tipo_columna,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            bd_tamano_columna = v_parametros.bd_tamano_columna,
            form_label = v_parametros.form_label,
            bd_prioridad = v_parametros.bd_prioridad,
            form_grupo = v_parametros.form_grupo,
            bd_campos_subconsulta = v_parametros.bd_campos_subconsulta
            where id_tipo_columna=v_parametros.id_tipo_columna;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Columna modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_columna',v_parametros.id_tipo_columna::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
    #TRANSACCION:  'WF_TIPCOL_ELI'
    #DESCRIPCION:   Eliminacion de registros
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:41:15
    ***********************************/

    elsif(p_transaccion='WF_TIPCOL_ELI')then

        begin
        
            if (exists (select 1 
                        from wf.tcolumna_estado t
                        where t.id_tipo_columna = v_parametros.id_tipo_columna and
                        t.estado_reg = 'activo'))then
                raise exception 'Existe(n) Columna Estado que depende(n) de este tipo columna';
            end if;
            
            --Sentencia de la eliminacion
            update wf.ttipo_columna
            set estado_reg = 'inactivo'
            where id_tipo_columna=v_parametros.id_tipo_columna;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Columna eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_columna',v_parametros.id_tipo_columna::varchar);
              
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