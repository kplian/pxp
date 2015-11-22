CREATE OR REPLACE FUNCTION segu.ft_regional_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_regional_sel
 DESCRIPCION:   consultas de regionales
 AUTOR: 		KPLIAN(jrr)	
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		KPLIAN(jrr)		
 FECHA:		08/01/11
***************************************************************************/


DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
    v_resp				varchar;

BEGIN

    v_parametros:=pxp.f_get_record(p_tabla);
    v_nombre_funcion:='segu.ft_regional_sel';

 /*******************************
 #TRANSACCION:  SEG_REGION_SEL
 #DESCRIPCION:	Selecciona Regionales
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
    if p_transaccion = 'SEG_REGION_SEL' then

    	begin
        	v_consulta:='select
            			id_regional, fecha_reg, estado_reg,
                        nombre, descripcion
            			from segu.tregional
                        where  ';
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            return v_consulta;
		end;

 /*******************************
 #TRANSACCION:  SEG_REGION_CONT
 #DESCRIPCION:	Cuenta Regionales
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
    elsif p_transaccion = 'SEG_REGION_CONT' then

        begin
        	v_consulta:='select count(id_regional)
            			from segu.tregional
                        where ';
            v_consulta:=v_consulta||v_parametros.filtro;
            return v_consulta;
        end;

     else
     
         raise exception 'Transaccion inexistente';
         
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
-- Definition for function ft_rol_ime (OID = 305089) : 
--
