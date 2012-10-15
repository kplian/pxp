CREATE OR REPLACE FUNCTION segu.ft_usuario_regional_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_usuario_regional_sel
 DESCRIPCIÓN: 	gestiona las consulta de usario-regional
 AUTOR: 		KPLIAN(jrr)
 FECHA:			28/02/2008
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
***************************************************************************/

DECLARE


v_consulta    varchar;
v_parametros  record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_usuario_regional_sel';

 /*******************************    
 #TRANSACCION:  SEG_USUREG_SEL
 #DESCRIPCION:	lista las regionales del usuario
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2010	
***********************************/
     if(par_transaccion='SEG_USUREG_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select 
                            usureg.id_usuario_regional,
                            usureg.id_usuario,
                            usureg.id_regional,
                            usureg.fecha_reg,
                            usureg.estado_reg,
                            region.nombre as desc_regional,
                            person.nombre_completo2 as desc_person
                        from segu.tusuario_regional usureg
                        inner join segu.tusuario usuari
                        on usuari.id_usuario=usureg.id_usuario
                        inner join segu.tregional region
                        on region.id_regional=usureg.id_regional
                        inner join segu.vpersona person
                        on person.id_persona=usuari.id_persona
                        where usureg.estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;
         
 /*******************************    
 #TRANSACCION:  SEG_USUREG_CONT
 #DESCRIPCION:	cuenta las regionales del usuario
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2010	
***********************************/

     elsif(par_transaccion='SEG_USUREG_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(usureg.id_usuario_regional)
                            from segu.tusuario_regional usureg
                        inner join segu.tusuario usuari
                        on usuari.id_usuario=usureg.id_usuario
                        inner join segu.tregional region
                        on region.id_regional=usureg.id_regional
                        where usureg.estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;

     else
         raise exception 'No existe la opcion';

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
-- Definition for function ft_usuario_rol_ime (OID = 305106) : 
--
