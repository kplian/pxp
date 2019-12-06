CREATE OR REPLACE FUNCTION segu.ft_persona_relacion_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_persona_relacion_sel
 DESCRIPCION:   consultas de persona
 AUTOR: 		
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

ISSUE	EMPRESA		FECHA		AUTOR	DESCRIPCION
#41		ETR			31.07.2019	MZM		relacion de persona con sus dependientes
#91		ETR			05.12.2019	MZM		adicion de campos y omision de relacion con tpersona
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
     v_nombre_funcion:='segu.ft_persona_relacion_sel';


 /*******************************
 #TRANSACCION:  SEG_PERREL_SEL
 #DESCRIPCION:	Selecciona Personas
 #AUTOR:		
 #FECHA:		31/07/19	
***********************************/
     if(par_transaccion='SEG_PERREL_SEL')then

          --  Se arma la consulta de personas
          BEGIN

               v_consulta:='SELECT pr.id_persona_relacion, pr.nombre, pr.fecha_nacimiento, 
                            pr.genero, pr.historia_clinica, pr.matricula,
                            pr.relacion, pr.id_persona, 
                            pr.estado_reg, pr.id_usuario_reg
                            FROM segu.tpersona_relacion pr 
                            inner join segu.tpersona per on per.id_persona=pr.id_persona
							WHERE ';
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta || ' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
               --raise exception '%',v_consulta;
               return v_consulta;


         END;
         
/*******************************
 #TRANSACCION:  SEG_PERREL_CONT
 #DESCRIPCION:	Cuenta Personas
 #AUTOR:			
 #FECHA:		31/07/19
***********************************/

     elsif(par_transaccion='SEG_PERREL_CONT')then

          --se arma la sonsulta que cuenta personas
          BEGIN
               
               v_consulta:='select count(pr.id_persona_relacion)
               from segu.tpersona_relacion pr 
               inner join segu.tpersona per on per.id_persona=pr.id_persona
               where ';
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
LANGUAGE 'plpgsql';