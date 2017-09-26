--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_tproveedor_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Parametros Generales
 FUNCION:     param.f_tproveedor_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tproveedor'
 AUTOR:      (mzm)
 FECHA:         15-11-2011 10:44:58
 COMENTARIOS: 
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:   
***************************************************************************/

DECLARE

  v_consulta        varchar;
  v_parametros      record;
  v_nombre_funcion    		text;
  v_resp        			varchar;
  v_ids						varchar;
  v_where					varchar;
  v_filadd					varchar;
  v_join_responsables		varchar;
  v_sw_distinc				varchar;
          
BEGIN

  v_nombre_funcion = 'param.f_tproveedor_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'PM_PROVEE_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   mzm 
  #FECHA:   15-11-2011 10:44:58
  ***********************************/

  if(p_transaccion='PM_PROVEE_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
                provee.id_proveedor,
                provee.id_persona,
                provee.codigo,
                provee.numero_sigma,
                provee.tipo,
                provee.estado_reg,
                provee.id_institucion,
                provee.id_usuario_reg,
                provee.fecha_reg,
                provee.id_usuario_mod,
                provee.fecha_mod,
                usu1.cuenta as usr_reg,
                usu2.cuenta as usr_mod  ,
                person.nombre_completo1,
                instit.nombre,
                provee.nit,
                provee.id_lugar,
                lug.nombre as lugar,
                param.f_obtener_padre_lugar(provee.id_lugar,''pais'') as pais,
                param.f_get_datos_proveedor(provee.id_proveedor,''correos'') as correos,
                param.f_get_datos_proveedor(provee.id_proveedor,''telefonos'') as telefonos,
                param.f_get_datos_proveedor(provee.id_proveedor,''items'') as items,
                param.f_get_datos_proveedor(provee.id_proveedor,''servicios'') as servicios 
            from param.tproveedor provee
            inner join segu.tusuario usu1 on usu1.id_usuario = provee.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = provee.id_usuario_mod   
            left join segu.vpersona person on person.id_persona=provee.id_persona
            left join param.tinstitucion instit on instit.id_institucion=provee.id_institucion
            left join param.tlugar lug on lug.id_lugar = provee.id_lugar
            where  ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
      raise notice '%',v_consulta;
      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'PM_PROVEE_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   mzm 
  #FECHA:   15-11-2011 10:44:58
  ***********************************/

  elsif(p_transaccion='PM_PROVEE_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_proveedor)
              from param.tproveedor provee
            inner join segu.tusuario usu1 on usu1.id_usuario = provee.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = provee.id_usuario_mod   
                        left join segu.vpersona person on person.id_persona=provee.id_persona
                        left join param.tinstitucion instit on instit.id_institucion=provee.id_institucion
                        left join param.tlugar lug on lug.id_lugar = provee.id_lugar
                where  ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;
      
      

    end;
    
   /*********************************    
 	#TRANSACCION:  'PM_PROVEEDOR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		01-03-2013 10:44:58
	***********************************/

   
	ELSEIF(p_transaccion='PM_PROVEEDOR_SEL')then
    	begin
        
            if v_parametros.tipo='persona' then
                v_where:= 'provee.id_institucion is null';
            elsif v_parametros.tipo='institucion' then
                v_where:= 'provee.id_persona is null';
            end if;
    		--Sentencia de la consulta
			v_consulta:='select
						provee.id_proveedor,
						provee.id_institucion,
						provee.id_persona,
						provee.tipo,
					    provee.numero_sigma,
						provee.codigo,
                        provee.nit,
                        provee.id_lugar,
						provee.estado_reg,
						provee.id_usuario_reg,
						provee.fecha_reg,
						provee.id_usuario_mod,
						provee.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        person.nombre_completo1,
                        instit.nombre,
                        lug.nombre as lugar,
                        (case when person.id_persona is null then
                        	instit.nombre
                        else
                        	person.nombre_completo1
                        end):: varchar as nombre_proveedor,
                        provee.rotulo_comercial,
                        person.ci,
                        (case when person.id_persona is null then
                        	instit.direccion
                        else
                        	person.direccion
                        end):: varchar as desc_dir_proveedor,
						provee.contacto,
                        provee.id_proceso_wf,
                        provee.id_estado_wf,
                        provee.nro_tramite,
                        provee.estado
                        from param.tproveedor provee
						inner join segu.tusuario usu1 on usu1.id_usuario = provee.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = provee.id_usuario_mod   
                        left join segu.vpersona2 person on person.id_persona=provee.id_persona
                        left join param.tinstitucion instit on instit.id_institucion=provee.id_institucion
                        left join param.tlugar lug on lug.id_lugar = provee.id_lugar
				        where '||v_where||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PROVEEDOR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		01-03-2013 10:44:58
	***********************************/

	elsif(p_transaccion='PM_PROVEEDOR_CONT')then

		begin
        
             if v_parametros.tipo='persona' then
                v_where:= 'provee.id_institucion is null';
            elsif v_parametros.tipo='institucion' then
                v_where:= 'provee.id_persona is null';
            end if;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_proveedor)
					    from param.tproveedor provee
						inner join segu.tusuario usu1 on usu1.id_usuario = provee.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = provee.id_usuario_mod   
                        left join segu.vpersona2 person on person.id_persona=provee.id_persona
                        left join param.tinstitucion instit on instit.id_institucion=provee.id_institucion
                        left join param.tlugar lug on lug.id_lugar = provee.id_lugar
				        where '||v_where||' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end; 
    
    
    /*********************************    
  #TRANSACCION:  'PM_PROVEEV_SEL'
  #DESCRIPCION: Consulta de datos de proveedores a partir de una vista de base de datos
  #AUTOR:   rac 
  #FECHA:   08-12-2011 10:44:58
  ***********************************/    
        
          
  elseif(p_transaccion='PM_PROVEEV_SEL')then
            
      begin
      	
         
      	--Sentencia de la consulta
     	 v_consulta:='select
            			id_proveedor,
                        id_persona,
                        codigo,
                        numero_sigma,
                        tipo,
                        id_institucion,
                        desc_proveedor,
                        nit,
                        id_lugar,
                        lugar,
                        pais,
                        rotulo_comercial,
                        (COALESCE(email,''''))::varchar as email
            from param.vproveedor provee
            where  ';
            
            if pxp.f_existe_parametro(p_tabla,'id_lugar') then
      			v_ids = param.f_get_id_lugares(v_parametros.id_lugar);
      			v_consulta = v_consulta || 'provee.id_lugar in ('||v_ids||') and ';
      		end if;
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'PM_PROVEEV_CONT'
  #DESCRIPCION: Conteo de registros de proveedores en la vista vproveedor
  #AUTOR:   rac 
  #FECHA:   09-12-2011 10:44:58
  ***********************************/

  elsif(p_transaccion='PM_PROVEEV_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_proveedor)
              from param.vproveedor provee
              where ';
              
			if pxp.f_existe_parametro(p_tabla,'id_lugar') then
      			v_ids = param.f_get_id_lugares(v_parametros.id_lugar);
      			
      			v_consulta = v_consulta || 'provee.id_lugar in ('||v_ids||') and ';
      		end if;
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
    
   /*********************************    
 	#TRANSACCION:  'PM_PROVEEDORWF_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		RAC KPLIAN
 	#FECHA:		07-09-2017 10:44:58
	***********************************/

   
	ELSEIF(p_transaccion='PM_PROVEEDORWF_SEL')then
    	begin
        
           v_filadd =  '0 = 0 AND ';
           v_join_responsables = '';
           v_sw_distinc = '';
        
            if v_parametros.tipo='persona' then
                v_where:= 'provee.id_institucion is null';
            elsif v_parametros.tipo='institucion' then
                v_where:= 'provee.id_persona is null';
            end if;
            
            /*
            IF v_parametros.tipo_interfaz = 'ProveedorVb' THEN
                 IF p_administrador !=1 THEN
                    v_filadd = ' (lower(provee.estado)  not in (''borrador'', ''aprobado'')) and ';
                  ELSE
                    v_filadd = ' (lower(provee.estado)  not in (''borrador'', ''aprobado'')) and ';
                  END IF;
            END IF;*/
            
            IF p_administrador !=1 THEN
                v_filadd = ' (ewf.id_funcionario='||v_parametros.id_funcionario_usu::varchar||' ) and  (lower(provee.estado) not in (''borrador'', ''aprobado'')) and ';
               
             ELSE
                v_filadd = ' (lower(provee.estado) not in (''borrador'', ''aprobado'')) and ';
              
            END IF;
            
            
            
    		--Sentencia de la consulta
			v_consulta:='select
                             '||v_sw_distinc||'
                            provee.id_proveedor,
                            provee.id_institucion,
                            provee.id_persona,
                            provee.tipo,
                            provee.numero_sigma,
                            provee.codigo,
                            provee.nit,
                            provee.id_lugar,
                            provee.estado_reg,
                            provee.id_usuario_reg,
                            provee.fecha_reg,
                            provee.id_usuario_mod,
                            provee.fecha_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            person.nombre_completo1,
                            instit.nombre,
                            lug.nombre as lugar,
                            (case when person.id_persona is null then
                                instit.nombre
                            else
                                person.nombre_completo1
                            end):: varchar as nombre_proveedor,
                            provee.rotulo_comercial,
                            person.ci,
                            (case when person.id_persona is null then
                                instit.direccion
                            else
                                person.direccion
                            end):: varchar as desc_dir_proveedor,
                            provee.contacto,
                            provee.id_proceso_wf,
                            provee.id_estado_wf,
                            provee.nro_tramite,
                            provee.estado
                        from param.tproveedor provee
						inner join segu.tusuario usu1 on usu1.id_usuario = provee.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = provee.id_usuario_mod   
                        left join segu.vpersona2 person on person.id_persona=provee.id_persona
                        left join param.tinstitucion instit on instit.id_institucion=provee.id_institucion
                        left join param.tlugar lug on lug.id_lugar = provee.id_lugar
                        INNER  join wf.testado_wf ewf on ewf.id_estado_wf = provee.id_estado_wf
				        where '||v_where||' and '||v_filadd;
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PROVEEDORWF_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		RAC KPLIAN
 	#FECHA:		07-09-2017 10:44:58
	***********************************/

	elsif(p_transaccion='PM_PROVEEDORWF_CONT')then

		begin
        
           v_filadd =  '0 = 0 AND ';
           v_join_responsables = '';
           v_sw_distinc = '';
        
            if v_parametros.tipo='persona' then
                v_where:= 'provee.id_institucion is null';
            elsif v_parametros.tipo='institucion' then
                v_where:= 'provee.id_persona is null';
            end if;
            
            
             IF p_administrador !=1 THEN
                v_filadd = ' (ewf.id_funcionario='||v_parametros.id_funcionario_usu::varchar||' ) and  (lower(provee.estado) not in (''borrador'')) and ';
               
             ELSE
                v_filadd = ' (lower(provee.estado) not in (''borrador'')) and ';
              
            END IF;
            
            
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_proveedor)
					    from param.tproveedor provee
						inner join segu.tusuario usu1 on usu1.id_usuario = provee.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = provee.id_usuario_mod   
                        left join segu.vpersona2 person on person.id_persona=provee.id_persona
                        left join param.tinstitucion instit on instit.id_institucion=provee.id_institucion
                        left join param.tlugar lug on lug.id_lugar = provee.id_lugar
                        INNER  join wf.testado_wf ewf on ewf.id_estado_wf = provee.id_estado_wf
				        where  '||v_where||' and '||v_filadd;
			
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