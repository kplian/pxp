--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_modificar_momento_documento_wf (
  p_id_usuario_reg integer,
  p_id_proceso_wf integer,
  p_momento varchar,
  p_codigo_documento varchar
)
RETURNS boolean AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_modificar_momento_documento_wf
 DESCRIPCION: 	Devuelve un nuemero de correlativo a partir del Codigo, Numero siguiente y Gestion
 AUTOR: 		KPLIAN(RAC)
 FECHA:			01/02/2014
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE

   v_resp varchar;
   v_nombre_funcion varchar;
   v_registros  record;
  
BEGIN

      /*
      Parametros
      
      id_proceso_wf
      codigo_documento
      momento
      
      
      
      */

      v_nombre_funcion = 'wf.f_modificar_momento_documento_wf';
        
      
      IF p_momento not in ('exigir','verificar') THEN
      
        raise exception 'El mmomento % noes admitido',p_momento;
      
      END IF ;
      
      select 
       dwf.id_documento_wf
      into
       v_registros
      
      from wf.tdocumento_wf dwf
      inner join wf.ttipo_documento td on td.id_tipo_documento = dwf.id_tipo_documento
      where  dwf.id_proceso_wf = p_id_proceso_wf and td.codigo = p_codigo_documento; 
         
         
       update wf.tdocumento_wf d set
         momento = p_momento,
         id_usuario_mod = p_id_usuario_reg,
         fecha_mod = now()
       where id_documento_wf = v_registros.id_documento_wf;

            
     
     
       RETURN TRUE;
    
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