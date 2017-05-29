CREATE OR REPLACE FUNCTION orga.f_obtener_uo_x_funcionario (
  par_id_funcionario integer,
  par_opcion varchar,
  par_fecha date
)
RETURNS integer AS
$body$
/************************************
FUNCION: f_obtener_uo_x_funcionario
AUTOR: 	    KPLIAN (mzm)
PARAMETROS: par_id_funcionario : Nodo a partir del cual se quiere obtener la uo (que presupuesta, que es gerencia, a la que pertenece en linea directa)
            par_opcion: presupuesto==> presupuesto, gerencia ==> gerencia, inmediato_superior==> superior, funcionario==> funcionario
            par_fecha: indica la fecha a la cual se quiere obtener la dependencia del funcionario, si se envia null, tomar la fecha actual
            Si no existe una asignacion activa para el funcionario a la fecha indicada ==> devolver -1
************************************/
DECLARE
    
    v_id_uo                              integer;
    v_registros                          record;
    v_mensaje_error                      varchar;
    v_uo_funcionario                     integer;
    v_gerencia                           varchar;
    v_presupuesta                        varchar;
    v_tope                               varchar;
    v_uo_padre                           integer;
    v_resp                               varchar;
    v_nombre_funcion                     text;
    

BEGIN

v_nombre_funcion:='orga.f_obtener_uo_x_funcionario';
v_id_uo:=-1;
v_tope:='no';

    select  euo.id_uo_padre, UOFUNC.id_uo, UO.presupuesta, UO.gerencia, pxp.f_iif(UO.nodo_base='si','si','no')
    into v_uo_padre, v_uo_funcionario, v_presupuesta, v_gerencia, v_tope
    from orga.tuo_funcionario UOFUNC
    inner join orga.tuo UO on UO.id_uo=UOFUNC.id_uo
    inner join orga.testructura_uo euo on euo.id_uo_hijo=UO.id_uo and UOFUNC.id_uo=euo.id_uo_hijo
    where
         ((UOFUNC.estado_reg='activo' and UOFUNC.fecha_asignacion<=coalesce(par_fecha,now()::date))
         or (UOFUNC.estado_reg='inactivo' and UOFUNC.fecha_finalizacion>=coalesce(par_fecha,now()::date)))
         and UOFUNC.id_funcionario=par_id_funcionario AND UO.estado_reg='activo';
                              

    v_id_uo:= pxp.f_iif(((par_opcion='presupuesto' and v_presupuesta='si') or (par_opcion='gerencia' and v_gerencia='si') or (par_opcion='funcionario')), ''||v_uo_funcionario||'','-1')::integer;
 
   while (v_tope='no' and v_id_uo<1) loop

           select euo.id_uo_padre, UO.gerencia, UO.presupuesta, UO.id_uo, pxp.f_iif(UO.nodo_base='si','si','no') as nodo_base
           into v_uo_padre, v_gerencia, v_presupuesta, v_uo_funcionario, v_tope
           from orga.testructura_uo euo
           inner join orga.tuo UO on UO.id_uo=euo.id_uo_padre
           where euo.id_uo_hijo=v_uo_funcionario;
                 
                 if(par_opcion ='presupuesto') then
                        if(v_presupuesta='si') then
                                v_id_uo:=v_uo_funcionario;
                        else
                                v_uo_funcionario:=v_uo_padre;
                        end if;

                 elsif (par_opcion='gerencia') then
                 elsif (par_opcion='superior') then
                 else -- la uo a la que pertenece el usuario

                 end if;
   
    end loop;
    
    return v_id_uo;
    


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