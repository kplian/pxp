CREATE OR REPLACE FUNCTION pxp.f_validar_bloqueos (
  p_id_usuario integer,
  p_ip character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_validar_bloqueos
 DESCRIPCION:   Verifica si un usuario tiene un bloqueo activo al momento de ejecutar
                una transaccion
 AUTOR: 	    KPLIAN (jrr)	
 FECHA:	        02/06/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
DECLARE

BEGIN
    if(exists(  select 1
                from segu.tbloqueo_notificacion
                where id_usuario=p_id_usuario
                and aplicacion='usuario'
                and tipo='bloqueo'
                and estado_reg='activo' and fecha_hora_fin>now()))then
        raise exception 'Su cuenta ha sido bloqueada. Comuniquese con el administrador';
    end if;
    if(exists(  select 1
                from segu.tbloqueo_notificacion
                where ip=p_ip
                and aplicacion='ip'
                and tipo='bloqueo'
                and estado_reg='activo' and fecha_hora_fin>now()))then

        raise exception 'Su equipo ha sido bloqueado. Comuniquese con el administrador';

    end if;
    
    return 'exito';
END;
$body$
    LANGUAGE plpgsql SECURITY DEFINER;
--
-- Definition for function f_verifica_permisos (OID = 304251) : 
--
