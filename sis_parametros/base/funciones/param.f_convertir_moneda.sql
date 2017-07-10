--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_convertir_moneda (
  p_id_moneda_1 integer,
  p_id_moneda_2 integer,
  p_importe numeric,
  p_fecha date,
  p_tipo varchar,
  p_num_decimales integer,
  p_tipo_cambio_custom numeric = 1,
  p_show_error varchar = 'si'::character varying
)
RETURNS numeric AS
$body$
/**************************************************************************
 FUNCION: 		param.f_convertir_moneda
 DESCRIPCION:   Convierte el importe de la moneda1 a la moneda2 con el tipo
                de cambio "O" Oficial, "C" Compra,   "V" venta o "CUS" custom,  por defecto "O" y con el redondeo
                p_num_decimales por defecto 2
 AUTOR: 	    KPLIAN (jrr)	
 FECHA:	
 COMENTARIOS:	
 
 EJEMPLO
 
 v_monto_mb = param.f_convertir_moneda(v_reg_op.id_moneda, --moneda origen para conversion
                                                  v_id_moneda_base,   --moneda a la que sera convertido
                                                  v_reg_op.total_pago, --este monto siemrpe estara en moenda base
                                                  v_reg_op.fecha, 
                                                  'O',-- tipo oficial, venta, compra 
                                                  NULL);--defecto dos decimales   
 
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
    v_id_moneda_2               integer;
    v_registro                  record;
    v_id_moneda_base            integer;
    v_res                       numeric;
    v_id_moneda_1               integer;
    v_moneda                    varchar;
    v_tipo                      varchar;
    v_num_decimales             integer;
    v_res_custom				numeric;
BEGIN
    v_nombre_funcion:='param.f_convertir_moneda';
    
    /*Dar valores por defecto*/
    if(p_tipo is null)then
        v_tipo='O';
    else
        v_tipo=p_tipo;
    end if;
    
    if(p_tipo = 'CUS' and p_tipo_cambio_custom is NULL)then
        v_tipo='O';
    end if;    
    
    
    
    if(p_num_decimales is null)then
        v_num_decimales=2;
    else
        v_num_decimales=p_num_decimales;
    end if;
    
    if(p_fecha is null)then
        raise exception 'Debe definir una fecha para realizar la conversion de monedas';
    end if;
    
    /*Obtener la moneda base*/
    v_id_moneda_base=param.f_get_moneda_base();

    /*Si la moneda 2 es null es igual  la moneda base*/
    if(p_id_moneda_2 is null)then
        v_id_moneda_2=v_id_moneda_base;
    else
        v_id_moneda_2=p_id_moneda_2;
    end if;
    
    /*Si la moneeda 1 y la 2 son la misma se devuelve el mismo importe*/
    if(p_id_moneda_1=v_id_moneda_2)then
        return p_importe;
    end if;
    
    /*Sino tenemos un tipo de cambio custom y Si la moneda 1 y la moneda 2 no son la moneda base,  
    se convierte la moneda 1 a la moneda base*/
    if( p_id_moneda_1 != v_id_moneda_base and v_id_moneda_2 != v_id_moneda_base and v_tipo != 'CUS') then
        
        v_res=  param.f_convertir_moneda(p_id_moneda_1, v_id_moneda_base, p_importe, p_fecha, v_tipo, -1, p_tipo_cambio_custom);
        
        v_id_moneda_1=v_id_moneda_base;
    
    else
        v_id_moneda_1=p_id_moneda_1;
        v_res=p_importe;
    end if;

    /*Si la moneda base es la moneda 1 se divide por el tipo de cambio*/
    if(v_id_moneda_base=v_id_moneda_1)then
        select 
           tc.oficial as tipo_cambio,
          (v_res/tc.oficial) as oficial ,
          (v_res/tc.compra) as compra,
          (v_res/tc.venta) as venta,
          0::numeric as custom
         into 
           v_registro
        from param.ttipo_cambio tc
        where   tc.id_moneda=v_id_moneda_2 and
                tc.fecha=p_fecha;
     
     v_res_custom = (v_res/p_tipo_cambio_custom);
                
    /*Si la moneda base es la moneda 2 se multiplica por el tipo de cambio*/
    elsif(v_id_moneda_base=v_id_moneda_2)then
        
        select 
          tc.oficial as tipo_cambio,
         (v_res*tc.oficial) as oficial,
         (v_res*tc.compra) as compra,
         (v_res*tc.venta)as venta,
         0::numeric as custom 
        into 
          v_registro
        from param.ttipo_cambio tc
        where   tc.id_moneda=v_id_moneda_1 and
                tc.fecha=p_fecha;
        
       v_res_custom = v_res*p_tipo_cambio_custom;
                
        v_id_moneda_2=v_id_moneda_1;
    else
         IF v_tipo = 'CUS' THEN
            
         -----------------------
         --  OJO OJO OJO OJO
         -----------------------
            --09/11/"015, rac (kplian)
            --OJO cuando con distintas moneda y tipo de cambio custom asumimos que es multiplicacion
            -- 1 USD 1  BA    TC 6,96
            --   1 BS a USD  TC 0,143678160
            
             select 
                0::numeric as tipo_cambio,
                0::numeric as oficial,
                0::numeric  as compra,
                0::numeric as venta,
                0::numeric as custom 
              into 
                v_registro
              from param.ttipo_cambio tc
              where   tc.id_moneda=0;
            
            
            v_res_custom = v_res*p_tipo_cambio_custom;
           
         ELSE 
            raise exception 'Ha ocurrido un error al realizar la conversion de monedas';
         END IF;
        
    end if;
    
    if(v_registro.tipo_cambio is null and  v_tipo != 'CUS')then
        
        select m.moneda
        into v_moneda
        from param.tmoneda m
        where id_moneda=v_id_moneda_2;
        
        IF p_show_error = 'si' THEN
        	raise exception 'No existe tipo de cambio para la fecha: % y la moenda: % ', to_char(p_fecha,'DD/MM/YYYY'),v_moneda;
        ELSE
            return NULL;
        END IF;
        
    end if;
    
    /*Retorna el valor q corresponda segun sea oficial, compra o venta y con el redondeo*/
    if(v_tipo='O')then
        if(v_num_decimales=-1)then
            return v_registro.oficial;
        else
            return round(v_registro.oficial, v_num_decimales);
        end if;
    elsif(v_tipo='C')then
        if(v_num_decimales=-1)then
            return v_registro.compra;
        else
            return round(v_registro.compra, v_num_decimales);
        end if;
    elsif(v_tipo='V')then
        if(v_num_decimales=-1)then
            return round(v_registro.venta, v_num_decimales);
        else
            return v_registro.venta;
        end if;
   
   elsif(v_tipo='CUS')then
   
   
        if(v_num_decimales=-1)then
            return round(v_res_custom, v_num_decimales);
        else
            return v_res_custom;
        end if;
    
    ELSE
        raise exception 'No existe el tipo % para convertir las monedas',v_tipo;
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