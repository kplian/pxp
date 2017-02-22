--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_importar_funcionario_tmp (
)
RETURNS boolean AS
$body$
DECLARE
 
v_registros record;
v_id_nivel_organizacional	integer;
v_id_uo	integer;
v_id_uo_padre	integer;
v_id_persona 	integer;
v_genero		varchar;
v_reg_cargo	record; 
v_id_afp	integer;
v_estado_civil	varchar;
v_id_funcionario	integer;
v_id_escala_salarial	integer;
BEGIN
 
   
   
   
   FOR v_registros in (select 
                                nombre ,
                                nombre2 ,
                                paterno ,
                                materno ,
                                item ,
                                fecha_nac ,
                                nua ,
                                ci ,
                                exp ,
                                domicilio ,
                                telefono ,
                                celular ,
                                sangre ,
                                sexo ,
                                estado_civil ,
                                profesion ,
                                cd_cargo ,
                                fecha_ingreso ,
                                estado ,
                                codigo_escala ,
                                nombre_escala ,
                                lugar_pago ,
                                forma_pago ,
                                cuenta_banco ,
                                aporte_cacsel ,
                                afp ,
                                nacionalidad ,
                                correo_empresa ,
                                sindicato ,
                                calsel ,
                                id_persona ,
                                id_funcionario ,
                                migrado ,
                                banco, 
                                distrito_trabajo ,
                                matricula_seguro 
                        from orga.tfuncionario_tmp f
                        WHERE f.migrado = 'no' )LOOP
                        
           --inicia variables
           v_id_persona = NULL;           
             
           --  verficamos si existe una persona con el mismo nombre, recuepramos el id
           select 
              p.id_persona
             into
              v_id_persona
           from segu.tpersona p
           where upper(p.apellido_paterno) = upper(v_registros.paterno)
                 and upper(p.apellido_materno) = upper(v_registros.materno)
                 and upper(p.nombre)= upper(v_registros.nombre||' '||v_registros.nombre2);
           
           
           -- si no existe insertamos  persona
           IF  v_id_persona is NULL THEN
           
               IF  v_registros.sexo = 'M'  THEN
                 v_genero = 'masculino';
               ELSE
                 v_genero = 'femenino';
               END IF;
               
               
                
           
                 insert into segu.tpersona (
                                     nombre,
                                     apellido_paterno,
                                     apellido_materno,
                                     ci,
                                     correo,
                                     celular1,
                                     telefono1,
                                     telefono2,
                                     celular2,                                    
                                     expedicion,
                                     tipo_documento,
                                     genero)
                     values(
                             upper(v_registros.nombre||' '||v_registros.nombre2),
                             upper(v_registros.paterno),
                             upper(v_registros.materno),
                             v_registros.ci,
                            v_registros.correo_empresa,
                            v_registros.celular,
                            v_registros.telefono,
                            v_registros.telefono,
                            v_registros.celular,                           
                            v_registros.exp,
                            'documento_identidad',
                            v_genero) 
                           RETURNING id_persona into v_id_persona;
           
                 
           
           END IF;
           
           -- recuperamos el cargo y la uo a la que pertenece el cargo 
           
           select 
             c.id_uo,
             c.id_cargo,
             c.id_lugar,
             c.id_escala_salarial
           into
             v_reg_cargo
           from orga.tcargo c
           where c.codigo = v_registros.item; 
           
           
           -- recuperamos AFP
           
           select 
              afp.id_afp
             into
               v_id_afp
           from plani.tafp afp
           where     (afp.codigo =  'FUTURO' and v_registros.afp = '1' )
                  or  
                     (afp.codigo =  'PREV' and v_registros.afp = '2' );
           
           
           -- recuperamos el seguro
           
           
           --------------------------------
           -- insertamos funcionario
           --------------------------------------
            INSERT INTO orga.tfuncionario(
		               codigo, 
                       id_persona,
		               estado_reg,
		               fecha_reg,
		               id_usuario_reg,
		               email_empresa)
               values(
                      v_registros.item,
                      v_id_persona,
                      'activo',
                      now()::date,
                      1,
                      v_registros.correo_empresa)   RETURNING id_funcionario into v_id_funcionario;
               
               
               
               
             --recuperamos el estado civil
             IF  upper(v_registros.sexo) = 'C'  THEN
                 v_estado_civil = 'casado';
             ELSEIF  upper(v_registros.sexo) = 'D'   THEN
                 v_estado_civil = 'divorciado';
             ELSEIF  upper(v_registros.sexo) = 'V'   THEN
                 v_estado_civil = 'viudo';
             ELSE
                v_estado_civil = 'soltero';
             END IF;  
               
               
              update segu.tpersona
               	set estado_civil = v_estado_civil,
               	genero =v_genero,
               	fecha_nacimiento = v_registros.fecha_nac,
               	id_lugar = v_reg_cargo.id_lugar,
               	nacionalidad = upper(v_registros.nacionalidad )
               where id_persona = v_id_persona;
           
           --------------------------------------
           -- insertamos  funcionario_uo
           ---------------------------------------
           
           
           INSERT INTO orga.tuo_funcionario(
           				id_uo, 
                        id_funcionario, 
                        fecha_asignacion, 
                        id_cargo, 
                        nro_documento_asignacion, 
                        fecha_documento_asignacion, 
                        id_usuario_reg, 
                        tipo)
           values (
           			v_reg_cargo.id_uo, 
                    v_id_funcionario, 
                    v_registros.fecha_ingreso, 
                    v_reg_cargo.id_cargo, 
                    '0', 
                    v_registros.fecha_ingreso, 
                    1, 
                    'oficial');
           
           
           -- actulizamos escala salarial
           
            select 
                e.id_escala_salarial
               into
                 v_id_escala_salarial
            from orga.tescala_salarial e
            where e.codigo = v_registros.codigo_escala||v_registros.nombre_escala;
            
            
            update orga.tcargo set
               id_escala_salarial = v_id_escala_salarial
            where id_cargo = v_reg_cargo.id_cargo;
    
   
   END LOOP;
  

reTURN TRUE;
  

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;