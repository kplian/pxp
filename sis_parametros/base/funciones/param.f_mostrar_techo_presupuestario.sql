CREATE OR REPLACE FUNCTION param.f_mostrar_techo_presupuestario (
  id_tipo integer
)
RETURNS varchar AS
$body$
DECLARE


v_parametros  		record;
v_registros 		record;
v_nombre_funcion   	text;
v_resp				varchar;
v_resultado   	    varchar;
techo   	        varchar;

BEGIN

    v_nombre_funcion = 'param.f_mostrar_techo_presupuestario';
    -- 0) inicia suma

     v_resultado ='';
     -- FOR listado de cuenta basicas de la gestion 
     FOR  v_registros in (select
                                tcc.id_tipo_cc,
                                tcc.control_techo,
                                tcc.movimiento,
                                tcc.codigo,
                                tcc.id_tipo_cc_fk
                                          from param.ttipo_cc tcc
                                          inner join segu.tusuario usu1 on usu1.id_usuario = tcc.id_usuario_reg
                                          left join segu.tusuario usu2 on usu2.id_usuario = tcc.id_usuario_mod
                                          left join param.vep ep on ep.id_ep = tcc.id_ep
                                          where  
                                          -- tcc.id_tipo_cc_fk is NULL   and
                                                 tcc.estado_reg = 'activo'
                                                and tcc.movimiento='si'
                                                and tcc.id_tipo_cc=2084
                                                ORDER BY tcc.id_tipo_cc )LOOP
                                   
                   IF v_registros.control_techo = 'si' and v_resultado !='' THEN
                       v_resultado := (select tcc1.codigo||'-'||tcc1.descripcion from param.ttipo_cc tcc1 where tcc1.id_tipo_cc=v_registros.id_tipo_cc_fk)::VARCHAR;
                   END IF;              

     END LOOP;
      
     
     RETURN v_resultado;

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