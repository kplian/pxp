--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ftrig_tobs (
)
RETURNS trigger AS
$body$
DECLARE
  v_esquema	varchar;
  v_codigo_proceso		varchar;
  v_codigo_estado		varchar;
BEGIN
  select lower(sub.codigo), lower(tp.codigo), lower(te.codigo)
  into v_esquema, v_codigo_proceso,v_codigo_estado
  from wf.testado_wf ewf 
  inner join wf.tproceso_wf pwf on pwf.id_proceso_wf = ewf.id_proceso_wf
  inner join wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado
  inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = te.id_tipo_proceso
  inner join wf.tproceso_macro pm on tp.id_proceso_macro = pm.id_proceso_macro
  inner join segu.tsubsistema sub on pm.id_subsistema = sub.id_subsistema
  where ewf.id_estado_wf = NEW.id_estado_wf;
  
  if (exists (select 1
              from pg_proc p 
                   join pg_namespace n 
                   on p.pronamespace = n.oid 
             where n.nspname = v_esquema and 
             p.proname like 'f_wfobs_' || v_codigo_proceso)) then
  		execute ('select ' || v_esquema || '.f_wfobs_' || v_codigo_proceso || 
        				'(' || NEW.id_obs || ')');
  end if;
  
  RETURN NULL;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;