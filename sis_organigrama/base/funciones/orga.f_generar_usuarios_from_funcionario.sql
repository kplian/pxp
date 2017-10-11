CREATE OR REPLACE FUNCTION orga.f_generar_usuarios_from_funcionario (
)
RETURNS boolean AS
$body$
DECLARE
 
v_registros record;
v_id_nivel_organizacional	integer;
v_id_uo	integer;
v_id_uo_padre	integer;
v_id_persona 	integer;
v_genero				varchar;
v_reg_cargo				record; 
v_id_afp				integer;
v_estado_civil			varchar;
v_id_funcionario		integer;
v_id_escala_salarial	integer;
v_password				varchar;
v_id_clasificador		integer;
_SEMILLA				varchar;
v_cuenta_usuario		varchar;
v_aux1			varchar;
v_aux2			varchar;	
BEGIN
 
    --recuperar clasificador
    select 
       cl.id_clasificador
      into
       v_id_clasificador
    from segu.tclasificador cl
    where cl.codigo = 'PUBLICO';
    
    _SEMILLA = '+_)(*&^%$#@!@TERPODO';
   
   --listar funcionarios 
   
   FOR v_registros in  (select
                            per.nombre,
                            per.apellido_paterno,
                            per.apallido_materno,
                            per.id_persona,
                            ft.usuario
                         from orga.tfuncionario fun
                         inner join segu.tpersona per on per.id_persona = fun.id_persona
                         inner join orga.tfuncionario_tmp ft on ft.item = fun.codigo
                         where 
                             per.id_persona not in(select u.id_persona from segu.tusuario u )) LOOP
                             
                             
                             
                  --generar password
                  v_password = md5( _SEMILLA  || SUBSTRING (lower(v_registros.nombre), 1, 3)|| SUBSTRING (upper(v_registros.nombre), 1, 1)|| SUBSTRING (lower(v_registros.apellido_paterno), 2, 3)||'123');
                  
                  IF v_registros.usuario is NULL or  v_registros.usuario = '' THEN
                     
                     v_aux1 = TRIM((split_part(trim(v_registros.nombre,' ',1))));
                     
                     if v_registros.apellido_paterno is not null and  v_registros.apellido_paterno != '' then
                        v_aux2 = lower(split_part(v_registros.apellido_paterno,' ',1));
                     else
                        v_aux2 = lower(split_part(v_registros.apallido_materno,' ',1));
                     
                     end if;
                     
                     v_cuenta_usuario = v_aux1||'.'||trim(v_aux2);
                  
                  
                  ELSE
                    v_cuenta_usuario = v_registros.usuario;
                  END IF;
                  
                  
                  INSERT  INTO segu.tusuario(
               				 id_clasificador,
                              cuenta,
                              contrasena,
                              fecha_caducidad,
                              estilo,
                              contrasena_anterior,
                              id_persona,
                              autentificacion)
                              
                       VALUES( 
                       
                        v_id_clasificador,
                        v_cuenta_usuario,
                        v_password,
                        '31/12/2024',
                        'xtheme-gray.css',
                        NULL,
                        v_registros.id_persona,
                        'ldap');
                             
                             
    
   END LOOP;
   
    
  
  

RETURN TRUE;
  

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;