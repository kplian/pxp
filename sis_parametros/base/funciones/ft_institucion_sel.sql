CREATE OR REPLACE FUNCTION param.ft_institucion_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_institucion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tinstitucion'
 AUTOR: 		 (gvelasquez)
 FECHA:	        21-09-2011 10:50:03
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
    v_filadd			varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_institucion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_INSTIT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		gvelasquez	
 	#FECHA:		21-09-2011 10:50:03
	***********************************/

	if(p_transaccion='PM_INSTIT_SEL')then
     				
    	begin
            v_filadd = ' 0=0 ';
            IF (pxp.f_existe_parametro(p_tabla,'es_banco')) THEN
               v_filadd = ' instit.es_banco = '''||v_parametros.es_banco||''' ';
            END IF;
        
        
    		--Sentencia de la consulta
			v_consulta:='select
						instit.id_institucion,
						instit.fax,
						instit.estado_reg,
                        instit.casilla,
						instit.direccion,
						instit.doc_id,
						instit.telefono2,
						instit.id_persona,
						instit.email2,
						instit.celular1,
						instit.email1,
					
						instit.nombre,
						instit.observaciones,
						instit.telefono1,
						instit.celular2,
						instit.codigo_banco,
						instit.pag_web,
						instit.id_usuario_reg,
						instit.fecha_reg,
						instit.id_usuario_mod,
						instit.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        instit.codigo,	
						instit.es_banco,
                        per.nombre_completo2 as desc_persona,
                        instit.cargo_representante
						from param.tinstitucion instit
						inner join segu.tusuario usu1 on usu1.id_usuario = instit.id_usuario_reg
                        LEFT JOIN segu.vpersona per on per.id_persona = instit.id_persona
						left join segu.tusuario usu2 on usu2.id_usuario = instit.id_usuario_mod
				        where  (instit.estado_reg=''activo'' and '||v_filadd||' ) and';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_INSTIT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		gvelasquez	
 	#FECHA:		21-09-2011 10:50:03
	***********************************/

	elsif(p_transaccion='PM_INSTIT_CONT')then

		begin
          v_filadd = ' 0=0 ';
            IF (pxp.f_existe_parametro(p_tabla,'es_banco')) THEN
               v_filadd = ' instit.es_banco = '''||v_parametros.es_banco||''' and  instit.estado_reg=''activo'' ';
            END IF;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_institucion)
					    from param.tinstitucion instit
                        WHERE  '||v_filadd;
			
			--Definicion de la respuesta		    
			--v_consulta:=v_consulta||v_parametros.filtro;

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
    LANGUAGE plpgsql;
--
-- Definition for function ft_lugar_ime (OID = 304039) : 
--
