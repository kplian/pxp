CREATE OR REPLACE FUNCTION segu.f_verif_eliminado (
  par_id_subsistema integer
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.f_verif_eliminado
 DESCRIPCION:   
 AUTOR: 		KPLIAN(rac)
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		KPLIAN(jrr)	
 FECHA:		08/01/11
***************************************************************************/
DECLARE
v_registros       record;
v_esquema         varchar;
v_mensaje_error   text;
v_nombre_funcion  varchar;
v_contenido        text;
v_cant             integer;
v_bandera          boolean;
v_codigo           varchar;
v_array_cod        integer[];
i                  integer;
cont               integer;
v_array_id         integer[];
j                  integer;
cont_id            integer;
v_resp          varchar;

BEGIN


v_nombre_funcion:='segu.f_verif_eliminado';

     for v_registros in (select nombre, id_funcion from segu.tfuncion where id_subsistema=par_id_subsistema order by nombre) loop
                         
                 if not exists(select * from pg_proc where proname ~ v_registros.nombre order by proname) then
                        if exists(select 1 from segu.tprocedimiento where id_funcion=v_registros.id_funcion) then
                             delete from segu.tprocedimiento where id_funcion=v_registros.id_funcion;
                        end if;
                        delete from segu.tfuncion where lower(nombre) ~ v_registros.nombre and id_subsistema=par_id_subsistema;
                 else
                 --existe la funcion (verificar q todos los procedimientos sigan existiendo)
                          select prosrc
                                 into v_contenido
                                 from pg_proc where proname ~ v_registros.nombre;

                                 v_bandera:=true;
                                 v_cant:=2;
                                 cont:=0;
                                 while((v_bandera) or (v_cant<20)) loop

                                           if(strpos(split_part(v_contenido,'par_transaccion=''',v_cant),''')then')<1) then
                                                v_bandera:=false;
                                           else
                                                v_codigo:=(select substr(split_part(v_contenido,'par_transaccion=''',v_cant),1,strpos(split_part(v_contenido,'par_transaccion=''',v_cant),''')then')-1))::varchar;
                                                v_array_cod[v_cant-1]:=(select id_procedimiento from segu.tprocedimiento where lower(codigo)=lower(v_codigo) and id_funcion=v_registros.id_funcion);
                                                cont=cont+1;
                                           end if;
                                           v_cant=v_cant+1;
                                 end loop;

                                 
                                 i=(array_upper(v_array_cod,1));
                                 select aggarray(id_procedimiento) into v_array_id
                                 from segu.tprocedimiento where id_funcion=v_registros.id_funcion;

                                 j=(array_upper(v_array_id,1));

                                 if(j>i) then
                                   j:=j;
                                 else
                                   j:=i;
                                 end if;

raise exception 'id%',v_array_cod;
                                /* for i in 1..j loop
                                     if(v_array_cod[i]=v_array_id[i]) then
                                     else
                                     end if;
                                 
                                 end loop;*/



                                /* while (cont>=i) loop

                                        if exists (select 1 from segu.procedimiento where lower(v_array_cod[i])~ lower(codigo) and id_funcion=v_registros.id_funcion) then

                                           v_array_id[j]:=(select id_procedimiento from segu.procedimiento where lower(v_array_cod[i])~ lower(codigo) and id_funcion=v_registros.id_funcion);
                                            j:=j+1;

                                            cont_id:=cont_id+1;
                                        end if;
                                        i=i+1;
                                    end loop;



                                    while(cont_id>0) loop

                                       delete from segu.procedimiento where id_funcion=v_registros.id_funcion
                                       and id_procedimiento not in (v_array_id [cont_id]);
                                    
                                    end loop;*/
                                    
                                 --end if;
                                 
                                 
                 end if;

     end loop;
    return 'exito';

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
-- Definition for function ft_actividad_ime (OID = 305042) : 
--
