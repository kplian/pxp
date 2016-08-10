CREATE OR REPLACE FUNCTION orga.ft_interinato_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_interinato_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tinterinato'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
    v_registros             record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_interinato	        integer;
    v_date                  date;
    v_cont_interino         integer;
    v_cont_alertas          integer;
    v_sql					text;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_interinato_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_INT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-05-2014 20:01:24
	***********************************/

	if(p_transaccion='OR_INT_INS')then
					
        begin
        	
        	
              --Sentencia de la insercion
              insert into orga.tinterinato(
              id_cargo_titular,
              id_cargo_suplente,
              fecha_ini,
              descripcion,
  			
              fecha_fin,
              estado_reg,
              id_usuario_reg,
              fecha_reg,
              id_usuario_mod,
              fecha_mod
              ) values(
              v_parametros.id_cargo_titular,
              v_parametros.id_cargo_suplente,
              v_parametros.fecha_ini,
              v_parametros.descripcion,
  			
              v_parametros.fecha_fin,
              'activo',
              p_id_usuario,
              now(),
              null,
              null
  							
			)RETURNING id_interinato into v_id_interinato;
            
            if (pxp.f_get_variable_global('sincronizar') = 'true') then
            	v_sql = 'INSERT INTO 
                			kard.tkp_interinato (id_interinato,id_item_titular,id_item_suplente,
                            					fecha_ini,fecha_fin,descripcion) VALUES ('||
                                                v_id_interinato || ',' || v_parametros.id_cargo_titular || ',' 
                                                || v_parametros.id_cargo_suplente || ',''' || v_parametros.fecha_ini || ''',''' ||
                                                v_parametros.fecha_fin || ''',''' || v_parametros.descripcion || ''');';
            	v_resp = dblink_exec(migra.f_obtener_cadena_conexion(), v_sql,true);
            end if;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Interinato almacenado(a) con exito (id_interinato'||v_id_interinato||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_interinato',v_id_interinato::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_INT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-05-2014 20:01:24
	***********************************/

	elsif(p_transaccion='OR_INT_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tinterinato set
			id_cargo_titular = v_parametros.id_cargo_titular,
			id_cargo_suplente = v_parametros.id_cargo_suplente,
			fecha_ini = v_parametros.fecha_ini,
			descripcion = v_parametros.descripcion,
			
			fecha_fin = v_parametros.fecha_fin,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_interinato=v_parametros.id_interinato;
            
            if (pxp.f_get_variable_global('sincronizar') = 'true') then
            	v_sql = 'update
                			kard.tkp_interinato set
                            id_item_titular = ' || v_parametros.id_cargo_titular || ',
                            id_item_suplente = ' || v_parametros.id_cargo_suplente || ',
                            fecha_ini = ''' ||v_parametros.fecha_ini|| ''',
                            descripcion = ''' ||v_parametros.descripcion|| ''',                			
                            fecha_fin = ''' || v_parametros.fecha_fin || ''',
                            usuario_mod = "current_user"(),
                            fecha_mod = now()
                            where id_interinato = '||v_parametros.id_interinato;
                --raise exception '%',v_sql;
            	v_resp = dblink_exec(migra.f_obtener_cadena_conexion(), v_sql,true);
            end if;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Interinato modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_interinato',v_parametros.id_interinato::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_INT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-05-2014 20:01:24
	***********************************/

	elsif(p_transaccion='OR_INT_ELI')then

		begin
			--Sentencia de la eliminacion
            
            
			delete from orga.tinterinato
            where id_interinato=v_parametros.id_interinato;
            
            if (pxp.f_get_variable_global('sincronizar') = 'true') then
            	v_sql = 'delete from 
                			kard.tkp_interinato 
                            where id_interinato = '||v_parametros.id_interinato;
            	v_resp = dblink_exec(migra.f_obtener_cadena_conexion(), v_sql,true);
            end if;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Interinato eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_interinato',v_parametros.id_interinato::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    
    
    /*********************************    
 	#TRANSACCION:  'OR_APLINT_IME'
 	#DESCRIPCION:	captura los datos del interinato selecionado para su postrior aplicacion 
 	#AUTOR:		rac
 	#FECHA:		20-05-2014 20:01:24
	***********************************/

	elsif(p_transaccion='OR_APLINT_IME')then

		begin
			
        v_date = now();
        
          select
             u.id_usuario,
             u.cuenta,
             p.nombre,
             p.apellido_paterno,
             p.apellido_materno,
             u.estilo,
             u.autentificacion,
             p.id_persona,
             int.id_cargo_titular,
             f.id_funcionario
             
          into
            v_registros
          from orga.tinterinato int 
          inner join orga.tuo_funcionario tuof on 
                       tuof.id_cargo = int.id_cargo_titular 
                  and tuof.estado_reg = 'activo' 
                  --and tuof.tipo = 'oficial' 
                  and ( (v_date >=  tuof.fecha_asignacion and v_date <= tuof.fecha_finalizacion)  or (v_date >=  tuof.fecha_asignacion and tuof.fecha_finalizacion is NULL))
         inner join orga.tfuncionario f on f.id_funcionario = tuof.id_funcionario
         inner join segu.tpersona p on p.id_persona = f.id_persona         
          
          inner join segu.tusuario u on u.estado_reg = 'activo' and u.id_persona = f.id_persona
          where 
               int.id_interinato = v_parametros.id_interinato
               and (  v_date BETWEEN  int.fecha_ini and int.fecha_fin);
        
               
               
           IF v_registros.id_usuario is NULL THEN
           
              raise exception 'no se encontro nigun usuario activo o el interinato es invalido';
           
           END IF;
           
           
           --obtiene el numero de alertas
           SELECT 
                   count(id_alarma) 
           into 
                 v_cont_alertas
          FROM  param.talarma ala
          LEFT JOIN orga.tfuncionario fun 
            on fun.id_funcionario = ala.id_funcionario 
          and ala.estado_reg = 'activo' and fun.estado_reg = 'activo'
          WHERE (    fun.id_persona = v_registros.id_persona 
                  or ala.id_usuario = v_registros.id_usuario)
            GROUP BY ala.id_funcionario, id_alarma;
           
           
          
           
              
             
           -- obtenermos el numero de suplentes
              
             IF(v_registros.id_cargo_titular is not null) THEN
                
                  select 
                    count(int.id_interinato) into v_cont_interino
                  from orga.tinterinato int
                  where  
                          v_date BETWEEN  int.fecha_ini  and int.fecha_fin
                     and  int.id_cargo_suplente =  v_registros.id_cargo_titular  
                     and int.estado_reg='activo'; 
                     
             END IF;
          
           --Definicion de la respuesta
           v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Interinato aplicado del usuario '||p_id_usuario::VARCHAR||' al usuario '||v_registros.id_usuario::varchar ||'('||v_registros.cuenta::VARCHAR||')'); 
           v_resp = pxp.f_agrega_clave(v_resp,'id_interinato',v_parametros.id_interinato::varchar);
             
           v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_registros.id_usuario::varchar);
           v_resp = pxp.f_agrega_clave(v_resp,'cuenta',v_registros.cuenta);
           v_resp = pxp.f_agrega_clave(v_resp,'nombre',v_registros.nombre);
           v_resp = pxp.f_agrega_clave(v_resp,'apellido_paterno',v_registros.apellido_paterno);
           v_resp = pxp.f_agrega_clave(v_resp,'apellido_materno',v_registros.apellido_materno);
           v_resp = pxp.f_agrega_clave(v_resp,'estilo',v_registros.estilo);
           v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_registros.id_persona::varchar);
           v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_registros.id_funcionario::varchar);
           v_resp = pxp.f_agrega_clave(v_resp,'id_cargo',v_registros.id_cargo_titular::varchar);
           v_resp = pxp.f_agrega_clave(v_resp,'autentificacion',v_registros.autentificacion::varchar);
              
               
               
           v_resp = pxp.f_agrega_clave(v_resp,'cont_alertas',v_cont_alertas::varchar);
           v_resp = pxp.f_agrega_clave(v_resp,'cont_interino',v_cont_interino::varchar);
              
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