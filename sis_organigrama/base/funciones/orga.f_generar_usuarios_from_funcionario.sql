--------------- SQL ---------------

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
v_pass varchar;	
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
   
   FOR v_registros in  (
                         select
                            per.nombre,
                            per.apellido_paterno,
                            per.apellido_materno,
                            per.id_persona,
                            ft.usuario
                         from orga.tfuncionario fun
                         inner join segu.tpersona per on per.id_persona = fun.id_persona
                         inner join orga.tfuncionario_tmp ft on ft.correo_empresa  = fun.email_empresa
                         where per.id_persona != 1) LOOP
                             
                                           
                 --si el usuario existe no hacemos nada
                 
                 
                
              
                  --generar password
                  v_pass  =  COALESCE(SUBSTRING(lower(v_registros.nombre), 1, 3),'')||  COALESCE(SUBSTRING (upper(v_registros.apellido_paterno), 1, 1),'')||  COALESCE(SUBSTRING (lower(v_registros.apellido_paterno), 2, 2),'')||'123';
                  v_password = md5(trim(v_pass));
                  
                  IF v_registros.usuario is NULL or  v_registros.usuario = '' THEN
                     
                     v_aux1 = TRIM((split_part(trim(v_registros.nombre),' ',1)));
                     
                     if v_registros.apellido_paterno is not null and  v_registros.apellido_paterno != '' then
                        v_aux2 = lower(split_part(trim(v_registros.apellido_paterno),' ',1));
                     else
                        v_aux2 = lower(split_part(trim(v_registros.apellido_materno),' ',1));
                     
                     end if;
                     
                     v_cuenta_usuario = v_aux1||'.'||trim(v_aux2);
                  
                  
                  ELSE
                    v_cuenta_usuario = v_registros.usuario;
                  END IF;
                  
                  /*
                   update segu.tusuario set
                      contrasena = v_password
                    where id_persona = v_registros.id_persona;*/
                    
                    
                    raise notice 'se crea ... % -- % --%',v_cuenta_usuario, v_pass , _SEMILLA;
                  
                  
  
                  
                   IF not exists (select 1 from segu.tusuario  u where lower(trim(u.cuenta)) =  lower(trim(v_cuenta_usuario)) ) THEN
                  
                  
                  
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
                              lower(trim(v_cuenta_usuario)),
                              v_password,
                              '31/12/2024',
                              'xtheme-gray.css',
                              NULL,
                              v_registros.id_persona,
                              'local');
                              
                                
                 raise notice 'se crea ... % -- % --%',v_cuenta_usuario, v_pass , _SEMILLA;
                             
               ELSE
                 raise notice '>> NO  se crea -----% , %  --%',lower(trim(v_cuenta_usuario)), v_pass, _SEMILLA;  
               END IF;             
    
   END LOOP;
   
    
  
  

RETURN TRUE;
  

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;