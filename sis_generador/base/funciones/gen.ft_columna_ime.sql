CREATE OR REPLACE FUNCTION gen.ft_columna_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
DECLARE

    v_nro_requerimiento    	integer;
    v_parametros           	record;
    v_id_requerimiento     	integer;
    v_resp		            varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_columna			integer;


/*

 id_proyecto
 denominacion 
 descripcion
 estado_reg 

*/

BEGIN

     v_nombre_funcion:='gen.ft_columna_ime';
     v_parametros:=pxp.f_get_record(p_tabla);

     if(p_transaccion='GEN_COLUMN_INS')then

          BEGIN
               
               insert into gen.tcolumna(
		 		nombre,
                 descripcion,
                 id_tabla,
                 id_usuario_reg,
                 id_usuario_mod,
                 fecha_reg,
                 fecha_mod,
                 estado_reg,
                 etiqueta,
                 guardar
               ) values(
                v_parametros.nombre,
                v_parametros.descripcion,
                v_parametros.id_tabla,
                v_parametros.id_usuario_reg,
                NULL,
                now(),
                NULL,
                'activo',
                v_parametros.etiqueta,
                v_parametros.guardar
               )RETURNING id_columna into v_id_columna;
               
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Columna almacenada con exito (id_columna'||v_id_columna||')'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_columna',v_id_columna::varchar);

               return v_resp;

         END;

     elsif(p_transaccion='GEN_COLUMN_MOD')then

          BEGIN

               update gen.tcolumna set
               nombre=v_parametros.nombre,
               descripcion=v_parametros.descripcion,
               id_tabla=v_parametros.id_tabla,
               id_usuario_mod=v_parametros.id_usuario_mod,
               fecha_mod=now(),
               etiqueta=v_parametros.etiqueta,
               guardar=v_parametros.guardar,
               longitud=v_parametros.longitud,
               grid_ancho=v_parametros.grid_ancho,
               grid_mostrar=v_parametros.grid_mostrar,
               form_ancho_porcen=v_parametros.form_ancho_porcen,
               orden=v_parametros.orden,
               grupo=v_parametros.grupo
               where id_columna=v_parametros.id_columna;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Columna modificada'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_columna',v_parametros.id_columna::varchar);
               
               return v_resp;
          END;

    elsif(p_transaccion='GEN_COLUMN_ELI')then

          BEGIN

               delete from gen.tcolumna
               where id_columna=v_parametros.id_columna;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Columna eliminada'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_columna',v_parametros.id_columna::varchar);
              
               return v_resp;
         END;
         
     else
     
         raise exception 'Transacción inexistente: %',p_transaccion;

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
    LANGUAGE plpgsql;
--
-- Definition for function ft_columna_sel (OID = 303920) : 
--
