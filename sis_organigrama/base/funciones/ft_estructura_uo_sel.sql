CREATE OR REPLACE FUNCTION orga.ft_estructura_uo_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		orga.ft_estructura_uo_sel
 DESCRIPCIÓN:  listado de uo
 AUTOR: 	    KPLIAN (mzm)	
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		21-01-2011
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;


v_condicion 		varchar;
v_join varchar;


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='orga.ft_estructura_uo_sel';
    

/*******************************
 #TRANSACCION:  RH_UO_SEL
 #DESCRIPCION:	Listado de uos
 #AUTOR:		
 #FECHA:		23/05/11	
***********************************/
     if(par_transaccion='RH_ESTRUO_SEL')then

          
          BEGIN

           if(v_parametros.id_padre = '%') then
             --  v_condicion:='uo.nodo_base=''si'' and uo.tipo='||v_parametros.tipo;
                v_condicion:='uo.nodo_base=''si'' ';
                v_join = 'LEFT';
                
                
           else
               v_condicion:='euo.id_uo_padre='||v_parametros.id_padre||' and uo.nodo_base=''no'' ';
                v_join = 'INNER';
           end if;
               v_condicion:=v_condicion ||'  and uo.estado_reg=''activo'' ';
               
               
               v_consulta:='SELECT
                                UO.id_uo,
                                UO.codigo,
                                UO.descripcion,
                                UO.cargo_individual,
                                UO.nombre_unidad,
                                UO.nombre_cargo,
                                UO.presupuesta,
                                UO.nodo_base,
                                UO.estado_reg,
                                UO.fecha_reg,
                                UO.id_usuario_reg,
                                UO.fecha_mod,
                                UO.id_usuario_mod,
                                PERREG.nombre_completo2 AS USUREG,
                                PERMOD.nombre_completo2 AS USUMOD,
                                euo.id_uo_padre,
                                euo.id_estructura_uo,
                                UO.correspondencia,
                                UO.gerencia,
                                ''false''::varchar as checked,
                                UO.id_nivel_organizacional,
                                nivorg.nombre_nivel
                            FROM orga.tuo UO '
                            ||v_join|| ' join orga.testructura_uo euo
                                  on UO.id_uo=euo.id_uo_hijo  and euo.estado_reg=''activo''
                            INNER JOIN segu.tusuario USUREG ON  UO.id_usuario_reg=USUREG.id_usuario
                            INNER JOIN SEGU.vpersona PERREG ON PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN orga.tnivel_organizacional nivorg on nivorg.id_nivel_organizacional = UO.id_nivel_organizacional
                            LEFT JOIN SEGU.tusuario USUMOD ON USUMOD.id_usuario=UO.id_usuario_mod
                            LEFT JOIN SEGU.vpersona PERMOD ON PERMOD.id_persona=USUMOD.id_persona
                            WHERE '|| v_condicion;
               
               
             --  v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by euo.id_uo_hijo,UO.nombre_unidad';

               raise notice '%',v_consulta;
               return v_consulta;


         END;

/*******************************
 #TRANSACCION:  RH_ESTRUO_CONT
 #DESCRIPCION:	Conteo de estructura uos
 #AUTOR:		
 #FECHA:		24/05/11	
***********************************/
     elsif(par_transaccion='RH_ESTRUO_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT
                                  count(UO.id_uo)
                            FROM orga.tuo UO
                            inner join orga.testructura_uo euo
                            on UO.id_uo=euo.id_uo_hijo
                            INNER JOIN segu.tusuario USUREG ON  UO.id_usuario_reg=USUREG.id_usuario
                            INNER JOIN SEGU.vpersona PERREG ON PERREG.id_persona=USUREG.id_persona
                            INNER JOIN orga.tnivel_organizacional nivorg on nivorg.id_nivel_organizacional = UO.id_nivel_organizacional
                            LEFT JOIN SEGU.tusuario USUMOD ON USUMOD.id_usuario=UO.id_usuario_mod
                            LEFT JOIN SEGU.vpersona PERMOD ON PERMOD.id_persona=USUMOD.id_persona
                            WHERE '|| v_condicion;
              -- v_consulta:=v_consulta||v_parametros.filtro;
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