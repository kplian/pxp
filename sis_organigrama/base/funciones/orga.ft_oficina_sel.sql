CREATE OR REPLACE FUNCTION orga.ft_oficina_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
  /**************************************************************************
   SISTEMA:		Organigrama
   FUNCION: 		orga.ft_oficina_sel
   DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.toficina'
   AUTOR: 		 (admin)
   FECHA:	        15-01-2014 16:05:34
   COMENTARIOS:
  ***************************************************************************
   HISTORIAL DE MODIFICACIONES:

   DESCRIPCION:
   AUTOR:
   FECHA:
  ***************************************************************************/

  DECLARE

    v_consulta    		varchar;
    v_parametros  		record;
    v_nombre_funcion   	text;
    v_resp				varchar;

  BEGIN

    v_nombre_funcion = 'orga.ft_oficina_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'OR_OFI_SEL'
     #DESCRIPCION:	Consulta de datos
     #AUTOR:		admin
     #FECHA:		15-01-2014 16:05:34
    ***********************************/

    if(p_transaccion='OR_OFI_SEL')then

      begin
        --Sentencia de la consulta
        v_consulta:='select
						ofi.id_oficina,
						ofi.aeropuerto,
						ofi.id_lugar,
						ofi.nombre,
						ofi.codigo,
						ofi.estado_reg,
						ofi.fecha_reg,
						ofi.id_usuario_reg,
						ofi.fecha_mod,
						ofi.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						lug.nombre as nombre_lugar,
						ofi.zona_franca,
						ofi.frontera,
						ofi.correo_oficina,
						ofi.direccion,
                        ofi.telefono,
                        ofi.orden
						from orga.toficina ofi
						inner join segu.tusuario usu1 on usu1.id_usuario = ofi.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ofi.id_usuario_mod
						inner join param.tlugar lug on lug.id_lugar = ofi.id_lugar
				        where  ofi.estado_reg = ''activo'' and ';

        --Definicion de la respuesta
        v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

        --Devuelve la respuesta
        return v_consulta;

      end;

    /*********************************
     #TRANSACCION:  'OR_OFI_CONT'
     #DESCRIPCION:	Conteo de registros
     #AUTOR:		admin
     #FECHA:		15-01-2014 16:05:34
    ***********************************/

    elsif(p_transaccion='OR_OFI_CONT')then

      begin
        --Sentencia de la consulta de conteo de registros
        v_consulta:='select count(id_oficina)
					    from orga.toficina ofi
					    inner join segu.tusuario usu1 on usu1.id_usuario = ofi.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ofi.id_usuario_mod
                        inner join param.tlugar lug on lug.id_lugar = ofi.id_lugar
					    where  ofi.estado_reg = ''activo'' and ';

        --Definicion de la respuesta
        v_consulta:=v_consulta||v_parametros.filtro;

        --Devuelve la respuesta
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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;