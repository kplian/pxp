-- FUNCTION: orga.f_cambiar_vigencia_uo(integer, boolean)

-- DROP FUNCTION orga.f_cambiar_vigencia_uo(integer, boolean);

CREATE OR REPLACE FUNCTION orga.f_cambiar_vigencia_uo(
	 p_id_estructura_uo varchar,
	 p_accion varchar)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    STABLE 
AS $BODY$
/****************************************************************************
 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR               DESCRIPCION
 #ETR-2026			  09.12.2020			MZM					Creacion
*****************************************************************************/
DECLARE

  v_respuesta				varchar;
  v_id_uo					integer;
  v_resp	            	varchar;
  v_nombre_funcion      	text;
  v_mensaje_error       	text;
  v_registros				record;
  v_bandera					boolean;	
  v_nivel_max				integer;
  v_nivel					integer;
  v_control					varchar;
  v_ids						varchar;
  v_tam			integer;
  v_array		varchar;
  i integer;
  v_cant	integer;
  v_pos	integer;
BEGIN 
  
  v_nombre_funcion = 'orga.f_cambiar_vigencia_uo';
 
  
  select * into v_array from  orga.f_get_id_uo(p_id_estructura_uo);
  SELECT COUNT(*) into v_cant FROM regexp_matches(v_array, ',','g');
  i=1;
  v_pos=1;        
  v_respuesta='si';
--raise exception 'a%, b%',v_array, v_cant;
  if(v_cant!=0) then
    while ( i < v_cant+1) loop 
    	SELECT substr(v_array,1,strpos(v_array,',') -1),
             substr(v_array,strpos(v_array,',')+1) into v_ids;
              raise notice 'id %, i%',v_ids, i;
              if ( select coalesce(orga.f_get_funcionarios_x_uo(v_ids::integer, now()::Date)::varchar,'0') !='0' ) then --tiene personal asignado
    				i=v_cant+1;
                    v_respuesta='no';
              else
	              i=i+1;
              end if;
              
              
              
              v_array=(substr(v_array,strpos(v_array,',')+1 ));
              --raise exception 'aaaa%', (substr(v_array,strpos(v_array,',')+1 ));
              --v_pos=v_pos+ length (v_ids)+1;
              
    end loop;
 end if;
	

	return v_respuesta;
 
EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$;