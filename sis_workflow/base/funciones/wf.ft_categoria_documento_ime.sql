CREATE OR REPLACE FUNCTION wf.ft_categoria_documento_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_categoria_documento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tcategoria_documento'
 AUTOR: 		 (admin)
 FECHA:	        20-03-2015 15:44:44
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_categoria_documento	integer;
    v_codigo_categoria			varchar;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_categoria_documento_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_CATDOC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-03-2015 15:44:44
	***********************************/

	if(p_transaccion='WF_CATDOC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.tcategoria_documento(
			codigo,
			estado_reg,
			nombre,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.codigo,
			'activo',
			v_parametros.nombre,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_categoria_documento into v_id_categoria_documento;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Caterogiras de Documento almacenado(a) con exito (id_categoria_documento'||v_id_categoria_documento||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_documento',v_id_categoria_documento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_CATDOC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-03-2015 15:44:44
	***********************************/

	elsif(p_transaccion='WF_CATDOC_MOD')then

		begin
        	select cd.codigo into v_codigo_categoria
            from wf.tcategoria_documento cd
            where id_categoria_documento = id_categoria_documento;
            
            if (v_codigo_categoria != v_parametros.codigo) then
            	raise exception 'No es posible modificar el codigo de la categoria, elimine esta categoria y cree una nueva';
            end if;
            
			--Sentencia de la modificacion
			update wf.tcategoria_documento set
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_categoria_documento=v_parametros.id_categoria_documento;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Caterogiras de Documento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_documento',v_parametros.id_categoria_documento::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_CATDOC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-03-2015 15:44:44
	***********************************/

	elsif(p_transaccion='WF_CATDOC_ELI')then

		begin
        	select cd.codigo into v_codigo_categoria
            from wf.tcategoria_documento cd
            where id_categoria_documento = id_categoria_documento;
            
        	if (exists (select 1 
            			from wf.ttipo_documento td
                        where  v_codigo_documento = ANY(t.categoria_documento) and
                        td.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Tipos de documento que depende(n) de esta categoria';
            end if;
            
            
			--Sentencia de la eliminacion
			update  wf.tcategoria_documento
            set estado_reg = 'inactivo'
            where id_categoria_documento=v_parametros.id_categoria_documento;
			 
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Caterogiras de Documento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_documento',v_parametros.id_categoria_documento::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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