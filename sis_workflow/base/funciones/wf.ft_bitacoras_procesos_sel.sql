CREATE OR REPLACE FUNCTION wf.ft_bitacoras_procesos_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Flujo de Trabajo
 FUNCION: 		wf.ft_bitacotas_procesos_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tbitacotas_procesos'
 AUTOR: 		 (admin)
 FECHA:	        21-03-2017 16:31:09
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
    v_campos			record;

BEGIN

	v_nombre_funcion = 'wf.ft_bitacoras_procesos_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'WF_BTS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin
 	#FECHA:		21-03-2017 16:31:09
	***********************************/

	if(p_transaccion='WF_BTS_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select	bts.id_tipo_proceso,
                        		bts.tipo_proceso,
                        		bts.nro_tramite,
                        		bts.nombre_estado,
                        		bts.date_part,
                        		bts.fecha_ini,
                                bts.fecha_fin,
                                bts.estado_sig,
                                bts.proveido,
           						bts.proceso_wf,
                                bts.id_proceso_wf,
                                bts.id_estado_wf,
                                bts.id_funcionario,
                                bts.nombre_completo1
                                from wf.vbitacotas_procesos bts
                                where ';
        	--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'WF_BTS_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		21-03-2017 16:31:09
	***********************************/

	elsif(p_transaccion='WF_BTS_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_proceso)
					    from wf.vbitacotas_procesos bts
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
        /*********************************
 	#TRANSACCION:  'WF_PRO_SEL'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		21-03-2017 16:31:09
	***********************************/
     elsif(p_transaccion='WF_PRO_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='SELECT t.id_tipo_proceso,
            					t.codigo,
								t.nombre,
        						t.id_proceso_macro
								FROM wf.ttipo_proceso t
								where t.estado_reg = ''activo'' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;
    /*********************************
 	#TRANSACCION:  'WF_PRO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		21-03-2017 16:31:09
	***********************************/
       elsif(p_transaccion='WF_PRO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(t.id_tipo_proceso)
					    FROM wf.ttipo_proceso t
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
  /*********************************
 	#TRANSACCION:  'MAT_FUN_GET'
 	#DESCRIPCION:	Lista de funcionarios para registro
 	#AUTOR:		MMV
 	#FECHA:		10-01-2017 13:13:01
	***********************************/

	elsif(p_transaccion='MAT_FUN_GET')then

		begin
			--Sentencia de la consulta de conteo de registros
			SELECT tf.id_funcionario, vfcl.desc_funcionario1, vfcl.nombre_cargo
            INTO v_campos
			FROM segu.tusuario tu
            INNER JOIN orga.tfuncionario tf on tf.id_persona = tu.id_persona
            INNER JOIN orga.vfuncionario_cargo_lugar vfcl on vfcl.id_funcionario = tf.id_funcionario
            WHERE tu.id_usuario = p_id_usuario or tu.id_usuario = 0 ;

            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Transaccion Exitosa');
			v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_campos.id_funcionario::varchar);
			v_resp = pxp.f_agrega_clave(v_resp,'nombre_completo1',v_campos.desc_funcionario1::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'nombre_cargo',v_campos.nombre_cargo);

            return v_resp;

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