CREATE OR REPLACE FUNCTION segu.f_get_id_usuario (
  v_cuenta character varying
)
RETURNS integer
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.f_get_id_usuario
 DESCRIPCION: 	recupera id de usuario apartir del nombre de cuenta
 AUTOR: 		KPLIAN(RAC)
 FECHA:			29/02/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE
  v_id_usuario integer;
BEGIN
        select u.id_usuario
        into v_id_usuario
        from segu.tusuario u
        where u.cuenta=v_cuenta;
        
   RETURN v_id_usuario;


END;
$body$
    LANGUAGE plpgsql SECURITY DEFINER;
--
-- Definition for function f_grant_all_privileges (OID = 305031) : 
--
