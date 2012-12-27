CREATE OR REPLACE FUNCTION orga.ft_funcionario_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		orga.ft_funcionario_ime
 DESCRIPCIÓN:   modificaciones de funciones
 AUTOR: 	    KPLIAN (mzm)	
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		KPLIAN (rac)
 FECHA:		21-01-2011
 ***************************************************************************/
DECLARE


v_parametros                record;
v_resp                      varchar;
v_nombre_funcion            text;
v_mensaje_error             text;

v_id_funcion  				integer;
v_ids						varchar[];
v_tamano					integer;
v_i 						integer;
v_id_funcionario			integer;

BEGIN

     v_nombre_funcion:='orga.ft_funcionario_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
     
     
 /*******************************    
 #TRANSACCION:   RH_FUNCIO_INS
 #DESCRIPCION:	Inserta Funcionarios
 #AUTOR:			
 #FECHA:		25-01-2011	
***********************************/
     if(par_transaccion='RH_FUNCIO_INS')then

        
          BEGIN


               --insercion de nuevo FUNCIONARIO
               if exists (select 1 from orga.tfuncionario where codigo=v_parametros.codigo and estado_reg='activo') then
                  raise exception 'Insercion no realizada. CODIGO EN USO';
               end if;
               
               if exists(select 1 from orga.tfuncionario where id_persona=v_parametros.id_persona and estado_reg='activo') then
                  raise exception 'Insercion no realizada. Esta persona ya está registrada como funcionario';
               end if;

               INSERT INTO orga.tfuncionario(
		               codigo, id_persona,
		               estado_reg,
		               fecha_reg,
		               id_usuario_reg,
		               email_empresa,
		               interno,
		               fecha_ingreso )
               values(
                      v_parametros.codigo,
                      v_parametros.id_persona, 
                      'activo',now()::date, 
                      par_id_usuario,
                      v_parametros.id_persona,
                      v_parametros.interno,
                      v_parametros.fecha_ingreso)
               RETURNING id_funcionario into v_id_funcionario;
                      
			--RCM (27/12/2012): se aumenta inserción de especialdades y horarios desde la interfaz de funcionario
			--Especialidades
            v_ids= string_to_array(v_parametros.id_especialidades,',');
            v_tamano = coalesce(array_length(v_ids, 1),0);
                        
            FOR v_i IN 1..v_tamano LOOP
            	--insertamos  registro si no esta presente como activo
                insert into orga.tfuncionario_especialidad(
                id_funcionario, id_especialidad, estado_reg, id_usuario_reg
                ) values(
                v_id_funcionario, v_ids[v_i]::integer, 'activo',par_id_usuario
                );
             END LOOP;
             
            --Horarios
            v_ids= string_to_array(v_parametros.id_especialidades,',');
            v_tamano = coalesce(array_length(v_ids, 1),0);
                        
            FOR v_i IN 1..v_tamano LOOP
            	--insertamos  registro si no esta presente como activo
                insert into gem.tfuncionario_honorario(
                id_funcionario, id_tipo_horario, id_moneda, costo_hora, estado_reg, id_usuario_reg
                ) values(
                v_id_funcionario, v_ids[v_i]::integer, 1, 20, 'activo',par_id_usuario
                );
            END LOOP;
              

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','funcionario '||v_parametros.codigo ||' insertado con exito ');
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_id_funcion::varchar);
         END;
 /*******************************    
 #TRANSACCION:      RH_FUNCIO_MOD
 #DESCRIPCION:	Modifica la parametrizacion seleccionada
 #AUTOR:			
 #FECHA:		25-01-2011
***********************************/
     elsif(par_transaccion='RH_FUNCIO_MOD')then

          
          BEGIN
        
          
                if exists (select 1 from orga.tfuncionario
                			where id_funcionario!=v_parametros.id_funcionario
                			and codigo=v_parametros.codigo
                			and estado_reg='activo') then
                  raise exception 'Modificacion no realizada. CODIGO EN USO';
                end if;
                
                if exists(select 1 from orga.tfuncionario
                			where id_funcionario!=v_parametros.id_funcionario
                			and id_persona=v_parametros.id_persona and estado_reg='activo') then
                  raise exception 'Insercion no realizada. Esta persona ya está registrada como funcionario';
               end if;
                
                update orga.tfuncionario set
                	codigo=v_parametros.codigo,
                    id_usuario_mod=par_id_usuario,
                    id_persona=v_parametros.id_persona,
                    estado_reg=v_parametros.estado_reg,
                    email_empresa=v_parametros.email_empresa,
                    interno=v_parametros.interno,
                    fecha_ingreso=v_parametros.fecha_ingreso,
                    fecha_mod=now()::date
                where id_funcionario=v_parametros.id_funcionario;
                
                --RCM (27/12/2012): se aumenta inserción de especialdades y horarios desde la interfaz de funcionario
                --Especialidades
	            v_ids= string_to_array(v_parametros.id_especialidades,',');
	            v_tamano = coalesce(array_length(v_ids, 1),0);
	            
	            --Se inactiva todas las especialidades de la persona
	            update orga.tfuncionario_especialidad set
	            estado_reg = 'inactivo',
	            id_usuario_mod = par_id_usuario,
	            fecha_mod = now()
	            where id_funcionario = v_parametros.id_funcionario;
	                        
	            FOR v_i IN 1..v_tamano LOOP
	            	if exists(select 1 from orga.tfuncionario_especialidad 
		                        where id_funcionario = v_parametros.id_funcionario
		                        and id_especialidad = v_ids[v_i]::integer) then
		            	--update
		            	update orga.tfuncionario_especialidad set
			            estado_reg = 'activo',
			            id_usuario_mod = par_id_usuario,
	            		fecha_mod = now()
			            where id_funcionario = v_parametros.id_funcionario
			            and id_especialidad = v_ids[v_i]::integer;
		            	
		            else
		            	--insert
		            	insert into orga.tfuncionario_especialidad(
		                id_funcionario, id_especialidad, estado_reg, id_usuario_reg
		                ) values(
		                v_id_funcionario, v_ids[v_i]::integer, 'activo', par_id_usuario
		                );
		            
		            end if;		                      

	             END LOOP;
	             
	            --Horarios
	            v_ids= string_to_array(v_parametros.id_especialidades,',');
	            v_tamano = coalesce(array_length(v_ids, 1),0);
	            
	            --Se inactiva todos los horarios de la persona
	            update gem.tfuncionario_honorario set
	            estado_reg = 'inactivo',
	            id_usuario_mod = par_id_usuario,
	            fecha_mod = now()
	            where id_funcionario = v_parametros.id_funcionario;
	                        
	            FOR v_i IN 1..v_tamano LOOP
	            	if exists(select 1 from orga.tfuncionario_especialidad 
		                        where id_funcionario = v_parametros.id_funcionario
		                        and id_especialidad = v_ids[v_i]::integer) then
		            	update gem.tfuncionario_honorario set
			            estado_reg = 'activo',
			            id_usuario_mod = par_id_usuario,
	            		fecha_mod = now()
			            where id_funcionario = v_parametros.id_funcionario
			            and id_tipo_horario = v_ids[v_i]::integer;
		            else
		            	--insertamos  registro si no esta presente como activo
		                insert into gem.tfuncionario_honorario(
		                id_funcionario, id_tipo_horario, id_moneda, costo_hora, estado, id_usuario_reg
		                ) values(
		                v_id_funcionario, v_ids[v_i]::integer, 1, 20, 'activo', par_id_usuario
		                );
		            
		            end if;
	            	
	            END LOOP;
                
                
                
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcionario modificado con exito '||v_parametros.id_funcionario);
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_parametros.id_funcionario::varchar);
               
                
          END;
          
/*******************************    
 #TRANSACCION:  RH_FUNCIO_ELI
 #DESCRIPCION:	Inactiva la parametrizacion selecionada
 #AUTOR:			
 #FECHA:		25-01-2011
***********************************/

    elsif(par_transaccion='RH_FUNCIO_ELI')then
        BEGIN
        
         --inactivacion de la periodo
               update orga.tfuncionario
               set estado_reg='inactivo'
               where id_funcionario=v_parametros.id_funcionario;
               return 'Funcionario eliminado con exito';
               
               --rcm (27/12/2012)
               update orga.tfuncionario_especialidad set
               estado_teg = 'inactivo'
               where id_funcionario = v_parametros.id_funcionario;
               
               update gem.tfuncionario_honorario set
               estado_teg = 'inactivo'
               where id_funcionario = v_parametros.id_funcionario;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcionario eliminado con exito '||v_parametros.id_funcionario);
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_parametros.id_funcionario::varchar);

        END;
        
   
    else

         raise exception 'No existe la transaccion: %',par_transaccion;
    end if;
    
 return v_resp;  

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
-- Definition for function ft_funcionario_sel (OID = 304951) : 
--
