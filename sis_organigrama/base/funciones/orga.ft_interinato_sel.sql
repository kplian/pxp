CREATE OR REPLACE FUNCTION orga.ft_interinato_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_interinato_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tinterinato'
 AUTOR: 		 (admin)
 FECHA:	        20-05-2014 20:01:24
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




	v_nombre_funcion = 'orga.ft_interinato_sel';
    v_parametros = pxp.f_get_record(p_tabla);
    
    
    --raise exception 'XXX %', v_parametros._id_usuario_ai;

	/*********************************    
 	#TRANSACCION:  'OR_INT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		20-05-2014 20:01:24
	***********************************/

	if(p_transaccion='OR_INT_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						int.id_interinato,
						int.id_cargo_titular,
						int.id_cargo_suplente,
						int.fecha_ini,
						int.descripcion,
						int.id_usuario_ai,
						int.fecha_fin,
						int.estado_reg,
						int.id_usuario_reg,
						int.fecha_reg,
						int.id_usuario_mod,
						int.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        ct.nombre as  nombre_titular,
                        cs.nombre as  nombre_suplente,
                        
                        ft.desc_funcionario1 as desc_funcionario_titular,
                        fs.desc_funcionario1 as desc_funcionario_suplente
                        	
						from orga.tinterinato int
                        inner join orga.tcargo ct on ct.id_cargo = int.id_cargo_titular
                        inner join orga.tuo_funcionario uoft on uoft.id_cargo = ct.id_cargo --and uoft.tipo = ''oficial''
                        inner join orga.vfuncionario ft on ft.id_funcionario = uoft.id_funcionario 
                        
                        inner join orga.tcargo cs on cs.id_cargo = int.id_cargo_suplente 
                        inner join orga.tuo_funcionario uofs on uofs.id_cargo = cs.id_cargo and uofs.tipo = ''oficial''
                        inner join orga.vfuncionario fs on fs.id_funcionario = uofs.id_funcionario 
                        
						inner join segu.tusuario usu1 on usu1.id_usuario = int.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = int.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OR_INT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-05-2014 20:01:24
	***********************************/

	elsif(p_transaccion='OR_INT_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_interinato)
					    from orga.tinterinato int
                        inner join orga.tcargo ct on ct.id_cargo = int.id_cargo_titular
                        inner join orga.tuo_funcionario uoft on uoft.id_cargo = ct.id_cargo --and uoft.tipo = ''oficial''
                        inner join orga.vfuncionario ft on ft.id_funcionario = uoft.id_funcionario 
                        
                        inner join orga.tcargo cs on cs.id_cargo = int.id_cargo_suplente 
                        inner join orga.tuo_funcionario uofs on uofs.id_cargo = cs.id_cargo and uofs.tipo = ''oficial''
                        inner join orga.vfuncionario fs on fs.id_funcionario = uofs.id_funcionario 
                        
						inner join segu.tusuario usu1 on usu1.id_usuario = int.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = int.id_usuario_mod
				        
					    where ';
			
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