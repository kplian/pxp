CREATE OR REPLACE FUNCTION segu.ft_persona_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_persona_ime
 DESCRIPCION:   modificaciones de persona
 AUTOR: 		KPLIAN(jrr)	
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		Jaime Rivera Rojas	
 FECHA:		08/01/11
***************************************************************************/

DECLARE

v_nro_requerimiento    integer;
v_parametros           record;
v_id_requerimiento     integer;
v_resp                 varchar;
v_nombre_funcion       text;
v_mensaje_error        text;
v_id_persona           integer;

--04/04/2012
v_respuesta_sinc       varchar;
/*
 id_persona_juridica
 nombre
 domicilio
 telefono
 correo
 pag_web
 obs
 estado_reg
*/

BEGIN

           

     v_nombre_funcion:='segu.ft_persona_ime';
     v_parametros:=pxp.f_get_record(par_tabla);

 /*******************************
 #TRANSACCION:  SEG_PERSON_INS
 #DESCRIPCION:	Inserta Persona
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_PERSON_INS')then

          --consulta:=';
          BEGIN
          
          		--Verificación de persona ya registrada
          		--CI
                IF(v_parametros.tipo_documento!='Ninguno')THEN
                  if exists(select 1 from segu.tpersona
                              where ci = v_parametros.ci) then
                      raise exception 'Este número de Carnet de Identidad ya fue registrado';
                  end if;
                END IF;
          		--Nombre completo
          		if exists(select 1 from segu.tpersona
          					where upper(nombre) = upper(v_parametros.nombre)
          					and upper(apellido_paterno) = upper(v_parametros.ap_paterno)
          					and upper(apellido_materno) = upper(v_parametros.ap_materno)) then
          			raise exception 'Persona ya registrada';
          		end if;

                       
               insert into segu.tpersona (
                               nombre,
                               apellido_paterno,
                               apellido_materno,
                               ci,
                               correo,
                               celular1,
               				   telefono1,
                               telefono2,
                               celular2,
                               tipo_documento,
                               expedicion)
               values(
                      upper(v_parametros.nombre),
                      upper(v_parametros.ap_paterno),
                      upper(v_parametros.ap_materno),
                      v_parametros.ci,
                      v_parametros.correo,
                      v_parametros.celular1,
                      v_parametros.telefono1,
                      v_parametros.telefono2,
                      v_parametros.celular2,
                      v_parametros.tipo_documento,
                      v_parametros.expedicion)  
                        
               RETURNING id_persona INTO v_id_persona;
              
               --v_respuesta_sinc:= segu.f_sincroniza_persona_entre_bd(v_id_persona,'10.172.0.13','5432','db_link','db_link','dbendesis','INSERT');
               --if(v_respuesta_sinc!='si')  then
               --   raise exception 'Sincronizacion de persona en BD externa no realizada%',v_respuesta_sinc;
               --end if;
               --raise exception 'lega al final del insert';
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona insertada con exito '||v_id_persona); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_id_persona::varchar);

              

         END;

 /*******************************
 #TRANSACCION:  SEG_PERSON_MOD
 #DESCRIPCION:	Modifica Persona
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_PERSON_MOD')then

          --consulta:=';
          BEGIN
          
   				--Verificación de persona ya registrada
          		--CI
                IF(v_parametros.tipo_documento!='Ninguno')THEN
                  if exists(select 1 from segu.tpersona
                              where ci = v_parametros.ci
                              and id_persona != v_parametros.id_persona) then
                      raise exception 'Este número de Carnet de Identidad ya fue registrado';
                  end if;
                END IF;
          		--Nombre completo
          		if exists(select 1 from segu.tpersona
          					where upper(nombre) = upper(v_parametros.nombre)
          					and upper(apellido_paterno) = upper(v_parametros.ap_paterno)
          					and upper(apellido_materno) = upper(v_parametros.ap_materno)
          					and id_persona != v_parametros.id_persona) then
          			raise exception 'Persona ya registrada';
          		end if;

               update segu.tpersona 
               set nombre=upper(v_parametros.nombre),
               apellido_paterno=upper(v_parametros.ap_paterno),
               apellido_materno=upper(v_parametros.ap_materno),
               ci=v_parametros.ci,
               correo=v_parametros.correo,
               celular1=v_parametros.celular1,
               telefono1=v_parametros.telefono1,
               telefono2=v_parametros.telefono2,
               celular2=v_parametros.celular2,
               tipo_documento	= v_parametros.tipo_documento,
               expedicion = v_parametros.expedicion
               where id_persona=v_parametros.id_persona;
              
               --v_respuesta_sinc:= segu.f_sincroniza_persona_entre_bd(v_parametros.id_persona,'10.172.0.13','5432','db_link','db_link','dbendesis','UPDATE');
               --if(v_respuesta_sinc!='si')  then
               --   raise exception 'Sincronizacion a actualizacion de persona en BD externa no realizada%',v_respuesta_sinc;
               --end if;
   
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona modificada con exito '||v_parametros.id_persona); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_parametros.id_persona::varchar);
               
             --v_resp = 'exito'; 
             
            -- raise exception 'XXXXXXXXXXXXXxxx' ;  
               
          END;

 /*******************************
 #TRANSACCION:  SEG_UPFOTOPER_MOD
 #DESCRIPCION:	Modifica la foto de la persona
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_UPFOTOPER_MOD')then

          --consulta:=';
          BEGIN

   -- raise exception 'ERROR al subir archivo';

               update segu.tpersona 
               set 
               foto=v_parametros.foto,
               extension=v_parametros.extension
               where id_persona=v_parametros.id_persona;
             
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Foto de la persona modificada con exito '||v_parametros.id_persona); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_parametros.id_persona::varchar);

               
          END;
/*******************************
 #TRANSACCION:  SEG_PERSON_ELI
 #DESCRIPCION:	Elimina Persona
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
    elsif(par_transaccion='SEG_PERSON_ELI')then
                     
          --consulta:=';
          BEGIN
             
            delete from segu.tpersona where id_persona=v_parametros.id_persona;
          
            --v_respuesta_sinc:= segu.f_sincroniza_persona_entre_bd(v_parametros.id_persona,'10.172.0.13','5432','db_link','db_link','dbendesis','DELETE');
            --if(v_respuesta_sinc!='si')  then
            --      raise exception 'Sincronizacion a eliminacion de persona en BD externa no realizada%',v_respuesta_sinc;
            --end if;
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona eliminada '||v_parametros.id_persona); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_parametros.id_persona::varchar);
            
         END;
         
     else
     
         raise exception 'Transacción inexistente: %',par_transaccion;

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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;