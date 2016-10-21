--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_check_proveedor (
  p_id_usuario integer,
  p_nit varchar,
  p_desc_proveedor varchar
)
RETURNS integer AS
$body$
/**************************************************************************
 FUNCION: 		param.f_check_proveedor
 DESCRIPCION:   verifica si existe el proveedor, si existe retorna el ID, si no lo creea
 AUTOR: 	    KPLIAN (rac)	
 FECHA:	        12/02/2016
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
DECLARE


    v_resp                      varchar;
    v_nombre_funcion            text;
    v_mensaje_error             text;
    v_reg_proveedor                  record;
    
BEGIN
    v_nombre_funcion:='param.f_check_proveedor';
    
    
    -- si tenemos un nit buscamos si existe un proveedor
    IF trim(p_nit) !='' and p_nit is not null THEN
        
        select 
          *
        into
         v_reg_proveedor
        from param.tproveedor p
        where trim(p.nit) = trim(p_nit)
         limit  1 offset 0 ;
        
      IF  v_reg_proveedor.id_proveedor is not null THEN
         return v_reg_proveedor.id_proveedor;
      END IF;
      
    
    
    ELSE
          --si no tenemos nit buscamos por el nombre del proveedor  
             select 
              *
            into
             v_reg_proveedor
            from param.vproveedor p
            where trim(lower(p.desc_proveedor)) = trim(lower(p_desc_proveedor))
            limit  1 offset 0 ;
            
          IF  v_reg_proveedor.id_proveedor is not null THEN
             return v_reg_proveedor.id_proveedor;
          END IF;
    
    END IF;
    
    --  si no tenemos el proveedor ...  

    RETURN NULL;
    

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