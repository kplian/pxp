CREATE OR REPLACE FUNCTION param.f_inserta_alarma (
  par_id_funcionario integer,
  par_descripcion character varying,
  par_acceso_directo character varying,
  par_fecha date,
  par_tipo character varying,
  par_obs character varying,
  par_id_usuario integer,
  par_clase character varying,
  par_titulo character varying,
  par_parametros character varying
)
RETURNS integer
AS 
$body$
/************************************
FUNCION: f_inserta_alarma
AUTOR: 	    fprudencio
PARAMETROS: par_id_funcionario : indica el funcionario para el que se genera la alrma
            par_descripcion: una descripción de la alarma
            par_acceso_directo: es el link que lleva a la relacion de la alarma generada
            par_fecha: Indica la fecha de vencimiento de la alarma
            par_tipo: indica el tipo de alarma, puede ser alarma o notificacion
            par_obs: son las observaciones de la alarma

************************************/
DECLARE
    
    v_id_alarma                             integer;
    v_nombre_funcion						text;  
    v_resp                                  varchar;
BEGIN

v_nombre_funcion:='param.f_inserta_alarma';
   
   --realizamos la inserción de datos en alarma
   
   insert into param.talarma(
			acceso_directo,
			id_funcionario,
			fecha,
			estado_reg,
			descripcion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
            tipo,
            obs,
            clase,
            titulo,
            parametros
          	) values(
			par_acceso_directo,
			par_id_funcionario,
			par_fecha,
			'activo',
			par_descripcion,
			par_id_usuario,
			now()::date,
			null,
			null,
            par_tipo,
            par_obs,
            par_clase,
            par_titulo,
            par_parametros
			)RETURNING id_alarma into v_id_alarma;
    
    return v_id_alarma;
    


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
-- Definition for function f_obtener_correlativo (OID = 304013) : 
--
