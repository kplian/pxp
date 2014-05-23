--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.ftrig_log (
)
RETURNS trigger AS
$body$
DECLARE
	nombre_tabla   varchar;
    consulta	   varchar;
    valores			varchar;
    fecha1			date;
    fecha2 			date;
    crear_tabla		text;
	v_rol 			varchar;
    	  

BEGIN

/***************************************************************************
 XPHS - PARTICIONAMIENTO LOGS
***************************************************************************
 SCRITP: 		segu.ftrig_log
 DESCRIPCION: 	Ingreso de registro de logs		(tablas particionadas)
 AUTOR: 		KPLIAN(jrr)
 FECHA:			02/02/2011
 COMENTARIOS:	
***************************************************************************
	1) Se obtiene el nombre de tabla que corresponde para la fecha actual
    2) IF: existe la tabla
    	2.1) Se registra el evento en la tabla particionada correspondiente
    3) ELSE no existe la tabla
    	3.1) Se define el rango de fechas el que se creara la tabla
        3.2) Se crea la tabla con el nombre y el rango de fechas que corresponde
        3.3) Se inserta el evento en la tabla particionada correspondiente


*/
IF (TG_OP='INSERT')then
BEGIN
 nombre_tabla='tlog_'||to_char(NEW.fecha_reg,'YYYY_MM');

 if(not exists (select 1 from pg_class where relname like nombre_tabla))then
 	
 	fecha1:=to_char(NEW.fecha_reg,'YYYY-MM-01')::date;
    fecha2:= fecha1 + interval '1 month';

    crear_tabla:='CREATE TABLE "log"."'||nombre_tabla||'" (
      			  CHECK ((fecha_reg >= '''||fecha1||'''::date) AND (fecha_reg < '''||fecha2||'''::date)),
  				  CONSTRAINT "'||nombre_tabla||'_id_log_key" UNIQUE("id_log")
  				) INHERITS ("segu"."tlog");
                CREATE INDEX "'||nombre_tabla||'_idx" ON "log"."'||nombre_tabla||'"
  				USING btree ("fecha_reg")
                ';

    execute(crear_tabla);
    --RCM 24-03-2011: se vuelve dinámico el rol del grant
    v_rol = 'rol_usuario_' || current_database();
    --execute('GRANT SELECT ON log.'||nombre_tabla||' TO rol_usuario_bdweb');
    --execute('GRANT SELECT ON log.'||nombre_tabla||' TO '||v_rol);
    --FIN RCM

 end if;

    --raise notice '%',NEW.fecha_reg;
 	valores:=NEW.id_log||','||
    coalesce(''''||(NEW.id_usuario::text)||'''','null')||','||
    coalesce(''''||(NEW.id_subsistema::text)||'''','null')||','||
    coalesce(''''||(NEW.mac_maquina::text)||'''','null')||','||
    coalesce(''''||NEW.ip_maquina||'''','null')||','''||
    NEW.tipo_log||''','||
    coalesce(''''||replace (NEW.descripcion,'''','''''')||'''','null')||','''||
    NEW.fecha_reg||''','''||
    NEW.estado_reg||''','||
    coalesce(''''||NEW.procedimientos||'''','null')||','||
    coalesce(''''||NEW.transaccion||'''','null')||','||
    coalesce(''''||replace (NEW.consulta,'''','''''')||'''','null')||','||
    coalesce(''''||(NEW.tiempo_ejecucion::text)||'''','null')||','||
    coalesce(''''||NEW.usuario_base||'''','null')||','||
    coalesce(''''||NEW.codigo_error||'''','null')||','||
    coalesce(''''||(NEW.dia_semana::text)||'''','null')||','||
    NEW.pid_db||','||
    NEW.pid_web||','''||
    NEW.sid_web||''','||
    coalesce(''''||NEW.cuenta_usuario||'''','null')||','||
    coalesce(''''||NEW.descripcion_transaccion||'''','null')||','||
    coalesce(''''||NEW.codigo_subsistema||'''','null')||','||
    NEW.si_log||','|| 
    coalesce(''''||(NEW.id_usuario_ai::text)||'''','null')||','||
    coalesce(''''||NEW.usuario_ai||'''','null');
    
    

    valores=replace(valores,'\\','\\\\');
 	
    consulta='INSERT INTO log.'||nombre_tabla||' VALUES ('||valores||');';
    
    EXECUTE(consulta);

END;
end if;
 RETURN NULL;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
COST 100;