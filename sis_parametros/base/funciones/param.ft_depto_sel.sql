--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 documento: 	param.ft_depto_sel
 DESCRIPCIÓN:  listado de documento
 AUTOR: 	    KPLIAN	
 FECHA:	        06/06/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;
v_filadd varchar;

va_id_depto  integer[];
v_inner  varchar;
v_codadd  varchar;

v_a_eps varchar[];

v_a_uos varchar[];
v_uos_eps varchar;
v_size  integer;
v_i integer;
v_id_deptos  varchar;


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='param.ft_depto_sel';
     
 /*******************************
 #TRANSACCION:  PM_DEPPTO_SEL
 #DESCRIPCION:	Listado de departamento
 #AUTOR:		MZM	
 #FECHA:		03-06-2011
 #AUTOR_MOD:     RAC
 #DESCRIPCION_MOD  se aumenta el filtro de id_subsistema cuando dea distinto de null	
 #FECHA:		15-10-2011
***********************************/


     if(par_transaccion='PM_DEPPTO_SEL')then
     	BEGIN
        
       
               v_consulta:='SELECT 
                              DEPPTO.id_depto,
                              DEPPTO.codigo,
                              DEPPTO.nombre,
                              DEPPTO.nombre_corto,
                              DEPPTO.id_subsistema,
                              DEPPTO.estado_reg,
                              DEPPTO.fecha_reg,
                              DEPPTO.id_usuario_reg,
                              DEPPTO.fecha_mod,
                              DEPPTO.id_usuario_mod,
                              PERREG.nombre_completo1 as usureg,
                              PERMOD.nombre_completo1 as usumod,
                              SUBSIS.codigo || '' - '' || SUBSIS.nombre as desc_subsistema,
                              array_to_string(DEPPTO.id_lugares,'','')::varchar as id_lugares,
                              DEPPTO.prioridad,
                              DEPPTO.modulo,
                              DEPPTO.id_entidad,
                              ENT.nombre as desc_entidad
                            FROM param.tdepto DEPPTO
                              INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                              INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                              INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                              LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                              LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                              LEFT JOIN param.tentidad ENT on ENT.id_entidad=DEPPTO.id_entidad
                            WHERE DEPPTO.estado_reg =''activo'' and ';
              
               v_consulta:=v_consulta||v_parametros.filtro;
               
               
               
               
               if pxp.f_existe_parametro(par_tabla,'codigo_subsistema') then
		          	v_consulta =  v_consulta || ' AND SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||'''';
		       end if;
               
               
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
               raise notice '%',v_consulta;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  PM_DEPPTO_CONT
 #DESCRIPCION:	cuenta la cantidad de departamentos
 #AUTOR:		MZM	
 #FECHA:		03-06-2011
 #AUTOR_MOD:     RAC
 #DESCRIPCION_MOD  se aumenta el filtro de id_subsistema cuando dea distinto de null	
 #FECHA:		15-10-2011
***********************************/

     elsif(par_transaccion='PM_DEPPTO_CONT')then
        BEGIN
                  
               v_consulta:='SELECT
                                  count(DEPPTO.id_depto)
                            FROM param.tdepto DEPPTO
                              INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                              INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                              INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                              LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                              LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                              LEFT JOIN param.tentidad ENT on ENT.id_entidad=DEPPTO.id_entidad
                            WHERE DEPPTO.estado_reg =''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               
               if pxp.f_existe_parametro(par_tabla,'codigo_subsistema') then
		          	v_consulta =  v_consulta || ' AND SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||'''';
		       end if;
               
                raise notice '%',v_consulta;
               return v_consulta;
         END;
/*******************************
 #TRANSACCION:  PM_DEPUSUCOMB_SEL
 #DESCRIPCION:	Listado de departamento filtrados por los usuarios configurados en los mismo
 #AUTOR:		JRR	
 #FECHA:		03-05-2013
***********************************/


     elsif(par_transaccion='PM_DEPUSUCOMB_SEL')then

          --consulta:=';
          
         
          BEGIN
          v_filadd = '';
          IF (pxp.f_existe_parametro(par_tabla,'codigo_subsistema')) THEN
          	v_filadd = ' (SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||''') and ';
          
          END IF;
                    
          IF   par_administrador != 1 THEN
          
                 v_id_deptos =  param.f_get_lista_deptos_x_usuario(par_id_usuario, v_parametros.codigo_subsistema);
                IF(v_id_deptos='')THEN
                   v_id_deptos = '0';
                END IF;
                
          		v_filadd='(DEPPTO.id_depto  in ('||v_id_deptos||')) and';
            END IF;  
                 

               v_consulta:='SELECT 
                            DEPPTO.id_depto,
                            DEPPTO.codigo,
                            DEPPTO.nombre,
                            DEPPTO.nombre_corto,
                            DEPPTO.id_subsistema,
                            DEPPTO.estado_reg,
                            DEPPTO.fecha_reg,
                            DEPPTO.id_usuario_reg,
                            DEPPTO.fecha_mod,
                            DEPPTO.id_usuario_mod,
                            PERREG.nombre_completo1 as usureg,
                            PERMOD.nombre_completo1 as usumod,
                            SUBSIS.codigo||'' - ''||SUBSIS.nombre as desc_subsistema
                            FROM param.tdepto DEPPTO
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                            WHERE DEPPTO.estado_reg =''activo'' and '||v_filadd;
               
             
          
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
               raise notice '%',v_consulta;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  PM_DEPUSUCOMB_CONT
 #DESCRIPCION:	cuenta la cantidad de departamentos por usuario para combos
 #AUTOR:		JRR
 #FECHA:		03-05-2013
***********************************/

     elsif(par_transaccion='PM_DEPUSUCOMB_CONT')then
        BEGIN
          v_filadd = '';
          IF (pxp.f_existe_parametro(par_tabla,'codigo_subsistema')) THEN
          	v_filadd = ' (SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||''') and ';
          
          END IF;
                    
          IF   par_administrador != 1 THEN
          
                v_id_deptos =  param.f_get_lista_deptos_x_usuario(par_id_usuario, v_parametros.codigo_subsistema);
                IF(v_id_deptos='')THEN
                   v_id_deptos = '0';
                END IF;
                
          		v_filadd='(DEPPTO.id_depto  in ('||v_id_deptos||')) and';
          END IF;  
          
               v_consulta:='SELECT
                                  count(DEPPTO.id_depto)
                            FROM param.tdepto DEPPTO
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                            WHERE DEPPTO.estado_reg =''activo'' and '||v_filadd;
               v_consulta:=v_consulta||v_parametros.filtro;
               
                raise notice '%',v_consulta;
               return v_consulta;
         END;
     /*******************************
 #TRANSACCION:  PM_DEPFILUSU_SEL
 #DESCRIPCION:	Listado departametos filtrado por los grupos ep del usuarios
 #AUTOR:		RAC	
 #FECHA:		03-06-2013
***********************************/


     elsif(par_transaccion='PM_DEPFILUSU_SEL')then


         --raise exception 'LLEga';
        
          v_codadd = '';
          
          
          BEGIN
       
          IF (pxp.f_existe_parametro(par_tabla,'codigo_subsistema')) THEN
          	v_codadd = ' (SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||''') and ';
          
          END IF;
                    
          
          v_filadd = '';
          
           v_inner='';
          
          IF   par_administrador != 1 THEN
          
              select 
              pxp.list(uge.id_grupo::text)
              into 
              v_filadd  
             from segu.tusuario_grupo_ep uge 
             where  uge.id_usuario = par_id_usuario;
             
             
             IF  v_filadd is NULL THEN
              
                 raise exception 'El usuario no tiene ningun grupo EP-UO asignado';
              
              END IF;
              
              v_inner =  '
                          inner join param.tdepto_uo_ep due on due.id_depto =DEPPTO.id_depto
                          inner join param.tgrupo_ep gep on gep.estado_reg = ''activo'' and
                            
                                 ((gep.id_uo = due.id_uo  and gep.id_ep = due.id_ep )
                               or 
                                 (gep.id_uo = due.id_uo  and gep.id_ep is NULL )
                               or
                                 (gep.id_uo is NULL and gep.id_ep = due.id_ep )) and gep.id_grupo in ('||COALESCE(v_filadd,'0')||') ';
              		
             
               
          
          END IF;     

               v_consulta:='SELECT 
                            DISTINCT
                            DEPPTO.id_depto,
                            DEPPTO.codigo,
                            DEPPTO.nombre,
                            DEPPTO.nombre_corto,
                            DEPPTO.id_subsistema,
                            DEPPTO.estado_reg,
                            DEPPTO.fecha_reg,
                            DEPPTO.id_usuario_reg,
                            DEPPTO.fecha_mod,
                            DEPPTO.id_usuario_mod,
                            PERREG.nombre_completo1 as usureg,
                            PERMOD.nombre_completo1 as usumod,
                            SUBSIS.codigo||'' - ''||SUBSIS.nombre as desc_subsistema
                            FROM param.tdepto DEPPTO
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                             '||v_inner||'
                            WHERE   DEPPTO.estado_reg = ''activo''  and '||v_codadd;
               
              
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
               raise notice    '--->  % % %',v_filadd,par_id_usuario,v_consulta;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION: PM_DEPFILUSU_CONT
 #DESCRIPCION:	Listado departametos filtrado por los grupos ep del usuarios
 #AUTOR:		RAc
 #FECHA:		03-06-2013
***********************************/

     elsif(par_transaccion='PM_DEPFILUSU_CONT')then
        BEGIN
         
        
        
          v_codadd = '';
          IF (pxp.f_existe_parametro(par_tabla,'codigo_subsistema')) THEN
          	v_codadd = ' (SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||''') and ';
          
          END IF;
         
          v_filadd = '';
       
          v_inner='';
         
        
         IF   par_administrador != 1 THEN
          
              select 
              pxp.list(uge.id_grupo::text)
              into 
              v_filadd  
             from segu.tusuario_grupo_ep uge 
             where  uge.id_usuario = par_id_usuario;
              
              IF  v_filadd is NULL THEN
              
                 raise exception 'El usuario no tiene ningun grupo EP-UO asignado';
              
              END IF;
             
             
              v_inner =  '
                          inner join param.tdepto_uo_ep due on due.id_depto =DEPPTO.id_depto
                          inner join param.tgrupo_ep gep on gep.estado_reg = ''activo'' and
                            
                                 ((gep.id_uo = due.id_uo  and gep.id_ep = due.id_ep )
                               or 
                                 (gep.id_uo = due.id_uo  and gep.id_ep is NULL )
                               or
                                 (gep.id_uo is NULL and gep.id_ep = due.id_ep )) and gep.id_grupo in ('||v_filadd||') ';
              		
             
               
          
          END IF;   
          
               v_consulta:='SELECT
                                  count(DISTINCT DEPPTO.id_depto)
                            FROM param.tdepto DEPPTO
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                             '||v_inner||'
                            WHERE DEPPTO.estado_reg = ''activo''  and   '||v_codadd;
               
               raise notice '%',v_consulta;
               
               v_consulta:=v_consulta||v_parametros.filtro;
               
             
               return v_consulta;
         END;    
         
     /*******************************
       #TRANSACCION:  PM_DEPFILEPUO_SEL
       #DESCRIPCION:	Listado departametos filtrado por vector de uos, eps
                      Este modulo busca ser generico para que desde cualquier sistema
                      se obtenga un filtro de depto en ufncion a un array de uo y ep,
                      
                      Estos array se arman en control en otra cosulta que si deberia ser particular segun el 
                      sistema desde el que se quiera lista   
       #AUTOR:		RAC	
       #FECHA:		03-06-2013
      ***********************************/


     elsif(par_transaccion='PM_DEPFILEPUO_SEL')then

         BEGIN
         
         
      
          v_codadd = '';
          IF (pxp.f_existe_parametro(par_tabla,'codigo_subsistema')) THEN
          	v_codadd = ' (SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||''') and ';
          
          END IF;
          
          --TODO armar 
           
         
          
          v_a_eps = string_to_array(v_parametros.eps, ',');
          v_a_uos = string_to_array(v_parametros.uos, ',');
          
          
           v_size :=array_upper(v_a_eps,1);
          
          for v_i IN 1..v_size
          Loop
          
             IF v_i =1 THEN
               v_uos_eps='('||v_a_eps[v_i]||','||v_a_uos[v_i]||')';
          	 ELSE
              v_uos_eps=v_uos_eps||',('||v_a_eps[v_i]||','||v_a_uos[v_i]||')';
             END IF;
          
          END Loop;
          
       

               v_consulta:='SELECT 
                            DISTINCT
                            DEPPTO.id_depto,
                            DEPPTO.codigo,
                            DEPPTO.nombre,
                            DEPPTO.nombre_corto,
                            DEPPTO.id_subsistema,
                            DEPPTO.estado_reg,
                            DEPPTO.fecha_reg,
                            DEPPTO.id_usuario_reg,
                            DEPPTO.fecha_mod,
                            DEPPTO.id_usuario_mod,
                            PERREG.nombre_completo1 as usureg,
                            PERMOD.nombre_completo1 as usumod,
                            SUBSIS.codigo||'' - ''||SUBSIS.nombre as desc_subsistema
                            FROM param.tdepto DEPPTO
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                            inner join param.tdepto_uo_ep due on 
                                due.id_depto = DEPPTO.id_depto and due.estado_reg = ''activo'' 
                            WHERE  DEPPTO.estado_reg = ''activo'' and  
                            
                            
                            
                                (
                                (due.id_ep,due.id_uo) in ('||v_uos_eps||')
                                 or
                                (due.id_uo is null and  due.id_ep in ('||v_parametros.eps ||') ) 
                                
                                or 
                                
                                (due.id_ep is null and  due.id_uo in ('||v_parametros.uos ||') ) )
                                
                                and
                            
                             '||v_codadd;
               
              
         
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
               raise notice    '% % %',v_filadd,par_id_usuario,v_consulta;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION: PM_DEPFILEPUO_CONT
 #DESCRIPCION:	Listado departametos filtrado por vector de uos, eps
                Este modulo busca ser generico para que desde cualquier sistema
                se obtenga un filtro de depto en ufncion a un array de uo y ep,
                
                Estos array se arman en control en otra cosulta que si deberia ser particular segun el 
                sistema desde el que se quiera lista   
 #AUTOR:		RAc
 #FECHA:		03-06-2013
***********************************/

     elsif(par_transaccion='PM_DEPFILEPUO_CONT')then
        BEGIN
         
        
        
          v_codadd = '';
          IF (pxp.f_existe_parametro(par_tabla,'codigo_subsistema')) THEN
          	v_codadd = ' (SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||''') and ';
          
          END IF;
          
          v_a_eps = string_to_array(v_parametros.eps, ',');
          v_a_uos = string_to_array(v_parametros.uos, ',');
          
          v_size :=array_upper(v_a_eps,1);
          
          for v_i IN 1..v_size
          Loop
          
             IF v_i =1 THEN
               v_uos_eps='('||v_a_eps[v_i]||','||v_a_uos[v_i]||')';
          	 ELSE
              v_uos_eps=v_uos_eps||',('||v_a_eps[v_i]||','||v_a_uos[v_i]||')';
             END IF;
          
          END Loop;
         
         
          
               v_consulta:='SELECT
                                  count(DISTINCT DEPPTO.id_depto)
                            FROM param.tdepto DEPPTO
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                            inner join param.tdepto_uo_ep due on 
                                due.id_depto = DEPPTO.id_depto and due.estado_reg = ''activo'' 
                            WHERE  DEPPTO.estado_reg = ''activo'' and  
                            
                                (
                                (due.id_ep,due.id_uo) in ('||v_uos_eps||')
                                 or
                                (due.id_uo is null and  due.id_ep in ('||v_parametros.eps ||') ) 
                                
                                or 
                                
                                (due.id_ep is null and  due.id_uo in ('||v_parametros.uos ||') ) )
                                
                                and
                            
                             '||v_codadd;
               v_consulta:=v_consulta||v_parametros.filtro;
               
             
               return v_consulta;
         END; 
     
        
     else
         raise exception 'No existe la opcion';

     end if;

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