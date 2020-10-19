
-- FUNCTION: segu.ft_persona_relacion_ime(integer, integer, character varying, character varying)

-- DROP FUNCTION segu.ft_persona_relacion_ime(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION segu.ft_persona_relacion_ime(
	par_administrador integer,
	par_id_usuario integer,
	par_tabla character varying,
	par_transaccion character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
/**************************************************************************
 FUNCION: 		segu.ft_persona_relacion_ime
 DESCRIPCION:   modificaciones de persona
 AUTOR: 		MZM
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

ISSUE	EMPRESA		FECHA		AUTOR			DESCRIPCION
#41		ETR			31.07.2019	MZM-KPLIAN		relacion de persona con sus dependientes
#91		ETR			05.12.2019	MZM-KPLIAN		adicion de campos y omision de relacion con tpersona
#ETR-1378			16.10.2020	MZM-KPLIAN		Adicion de campo genero para insercion/modificacion
***************************************************************************/

DECLARE

v_nro_requerimiento    integer;
v_parametros           record;
v_id_requerimiento     integer;
v_resp                 varchar;
v_nombre_funcion       text;
v_mensaje_error        text;
v_id_persona           integer;
v_nombres				varchar;

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

           

     v_nombre_funcion:='segu.ft_persona_relacion_ime';
     v_parametros:=pxp.f_get_record(par_tabla);

 /*******************************
 #TRANSACCION:  SEG_PERREL_INS
 #DESCRIPCION:	Inserta Persona
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_PERREL_INS')then

          --consulta:=';
          BEGIN
          
               insert into segu.tpersona_relacion (
                               id_persona,
                               relacion,
                               nombre,
                               fecha_nacimiento
                               ,genero --#ETR-1378  
                               )
               values(
                     v_parametros.id_persona,
                     upper(v_parametros.relacion),
                     v_parametros.nombre,
                     v_parametros.fecha_nacimiento
                     ,v_parametros.genero --#ETR-1378  
                     )  
                        
               RETURNING id_persona_relacion INTO v_id_persona;
              
             
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona insertada con exito '||v_id_persona); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_id_persona::varchar);

              

         END;

 /*******************************
 #TRANSACCION:  SEG_PERREL_MOD
 #DESCRIPCION:	Modifica Persona
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_PERREL_MOD')then

          --consulta:=';
          BEGIN
          
               update segu.tpersona_relacion 
               set relacion=upper(v_parametros.relacion),
               id_persona=v_parametros.id_persona,
               nombre= v_parametros.nombre,
               fecha_nacimiento= v_parametros.fecha_nacimiento
			   ,genero=v_parametros.genero --#ETR-1378              
               
               where id_persona_relacion=v_parametros.id_persona_relacion;
              
   
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona modificada con exito '||v_parametros.id_persona_relacion); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_persona_relacion',v_parametros.id_persona_relacion::varchar);
               
             --v_resp = 'exito'; 
             
            -- raise exception 'XXXXXXXXXXXXXxxx' ;  
               
          END;


/*******************************
 #TRANSACCION:  SEG_PERREL_ELI
 #DESCRIPCION:	Elimina Persona
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
    elsif(par_transaccion='SEG_PERREL_ELI')then
                     
          --consulta:=';
          BEGIN
             
            delete from segu.tpersona_relacion where id_persona_relacion=v_parametros.id_persona_relacion;
          
          
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona eliminada '||v_parametros.id_persona_relacion); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_persona_relacion',v_parametros.id_persona_relacion::varchar);
            
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
$BODY$;

ALTER FUNCTION segu.ft_persona_relacion_ime(integer, integer, character varying, character varying)
    OWNER TO postgres;
