CREATE OR REPLACE FUNCTION pxp.f_fecha_literal (
  fecha_fecha date
)
RETURNS text AS
$body$
DECLARE
dia varchar;                  
mes varchar;
anno varchar;  
fecha_literal text;                                  
BEGIN
              dia=to_char(fecha_fecha,'dd'); 
              mes=to_char(fecha_fecha,'mm');
              anno=to_char(fecha_fecha,'yyyy');
IF(mes='01')
THEN 
RETURN dia||' de enero de '||anno ;
ELSIF(mes='02')
THEN 
RETURN dia||' de febrero de '||anno  ;
ELSIF(mes='03')
THEN 
RETURN dia||' de marzo de '||anno ;         
ELSIF(mes='04')
THEN 
RETURN dia||' de abril de '||anno ;
ELSIF(mes='05')
THEN 
RETURN dia||' de mayo de '||anno ;
ELSIF(mes='06')
THEN 
RETURN dia||' de junio de '||anno ;
ELSIF(mes='07')
THEN 
RETURN dia||' de julio de '||anno ;
ELSIF(mes='08')
THEN 
RETURN dia||' de agosto de '||anno ;
ELSIF(mes='09')
THEN 
RETURN dia||' de septiembre de '||anno;
ELSIF(mes='10')
THEN 
RETURN dia||' de octubre de '||anno ;
ELSIF(mes='11')
THEN 
RETURN dia||' de noviembre de '||anno ;
ELSE 
RETURN dia||' de  diciembre de '||anno ;
END if;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;