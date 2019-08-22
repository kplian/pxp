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

               v_consulta:='SELECT p.id_persona,
                             p.apellido_materno AS ap_materno,
                             p.apellido_paterno AS ap_paterno,
                             p.nombre,
                             (((COALESCE(p.nombre, '''' ::character varying) ::text || '' '' ::text) ||
                              COALESCE(p.apellido_paterno, '''' ::character varying) ::text) || '' ''
                               ::text) || COALESCE(p.apellido_materno, '''' ::character varying)
                                ::text AS nombre_completo1,
                             (((COALESCE(p.apellido_paterno, '''' ::character varying) ::text || '' ''
                              ::text) || COALESCE(p.apellido_materno, '''' ::character varying) ::text
                              ) || '' '' ::text) || COALESCE(p.nombre, '''' ::character varying) ::text
                               AS  desc_person,
                             p.ci,
                             p.correo,
                             p.celular1,
                             p.num_documento,
                             p.telefono1,
                             p.telefono2,
                             p.celular2,                             
                             p.extension,
                             p.tipo_documento,
                             p.expedicion,
                             p.foto, 
                             p.matricula, 
                             p.historia_clinica,
                             pr.relacion,
                             pr.id_persona_fk, pr.id_persona_relacion
                          FROM segu.tpersona p inner join segu.tpersona_relacion pr on pr.id_persona=p.id_persona
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
               
               v_consulta:='select count(p.id_persona)
               from segu.tpersona p 
               inner join segu.tpersona_relacion pr on pr.id_persona=p.id_persona
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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;