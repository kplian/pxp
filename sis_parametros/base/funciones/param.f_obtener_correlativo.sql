CREATE OR REPLACE FUNCTION param.f_obtener_correlativo(par_codigo_documento varchar, par_id int4, par_id_uo int4, par_id_depto int4, par_id_usuario int4, par_codigo_subsistema varchar, par_formato varchar, par_digitos_periodo int4 = 0, par_digitos_correlativo int4 = 0, par_tabla varchar = 'no_aplica', par_id_tabla int4 = 0, par_cod_tabla varchar = 'no_aplica', par_id_empresa int4 = 1, par_saltar_inicio varchar = 'no', par_forzar_inicio varchar = 'no')
  RETURNS varchar
AS
$BODY$
  /**************************************************************************
 FUNCION: 		param.f_obtener_correlativo
 DESCRIPCION:   Obtiene el correlativo de acuerdo al id_documento y su configuracion
               periodo/gestion  depto/uo/depto_uo, el formato
 
 AUTOR: 	    KPLIAN (mzm)
 FECHA:	        03/06/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:  1)se cambia los parametros de entra  id_documento por codigo_documento
               2)se agregan los parametro par_codigo_subsistema
               3) se agrega la variable par_formato 
                 'sin' => solo devuelve el correlativo correspondiente solo numero
                 'is not NULL'=> evalua  las palabra clave :'depto','uo', 'codsub',
                 											'coddoc','periodo','gestion'
                                                            'correlativo' 
                                 y las remplaza por su valor correpondiente                           
                                                            
                 'NULL' => si el valor es nulo obtiene le formato por defecto
                           revisa el formato configurado en el documento si no existe 
                           usa formato por defecto segun tipo depto/uo/depto_uo
 
               4) cambia el tipo de dato de vuelto, antes integer ahora varchar
               
               
 AUTOR:		KPLIAN (rac)
 FECHA:		1/12/2011
 ***************************************************************************/
DECLARE

    
    v_resp                      varchar;
    v_nombre_funcion            text;
    v_mensaje_error             text;
    
    v_correlativo               integer;
    v_cadena                    varchar;
    v_periodo_gestion           varchar;
    v_tipo_numeracion           varchar;
    v_id                        integer;
    par_id_documento		integer;
    v_num_periodo integer;
    v_num_gestion integer;
    v_codigo_uo varchar;
    v_codigo_depto varchar;
    v_formula varchar;
    v_formato_doc varchar;
    g_registros record;
    v_consulta varchar;
    v_where varchar;
BEGIN


    /*
    EJEMPLO
    
    
              SELECT * FROM param.f_obtener_correlativo(
                        'SOLB', --codigo documento
                         NULL,-- par_id, 
                        NULL, --id_uo 
                        1, --depto
                        1, --usuario
                        'ADQ', --codigo depto
                        NULL,--formato
                        1); --id_empresa
             
    
          --obtiene numero sin formato  
                   
             SELECT * FROM param.f_obtener_correlativo(
                        'SOLB', 
                         NULL,-- par_id, 
                        NULL, --id_uo 
                        1, 
                        1, 
                        'ADQ', 
                        'sin')--formato
                                
             
           
            SELECT * FROM param.f_obtener_correlativo(
                        'SOLB', 
                         NULL,-- par_id, 
                        NULL, --id_uo 
                        1, 
                        1, 
                        'ADQ', 
                        '{depto}-{periodo}/{correlativo}-{gestion})--formato
                                
                        
            SELECT * FROM param.f_obtener_correlativo(
                        'SOLB', 
                         NULL,-- par_id, 
                        NULL, --id_uo 
                        1, 
                        1, 
                        'ADQ', 
                         'depto-docdoc-periodo/correlativo')--formato
                                
                         
            SELECT * FROM param.f_obtener_correlativo(
                        'SOLB', 
                         NULL,-- par_id, 
                        NULL, --id_uo 
                        1, 
                        1, 
                        'ADQ', 
                         'depto-coddoc-periodo/correlativo')--formato
                                
              
    
    
    
    
    */


    
    v_nombre_funcion:='param.f_obtener_correlativo';
    
    --0)obtenemos el id_documento segun el codigo indicado
      --por tipo_documento se tiene la informacion de si se numera por periodo o gestion
      --si se envia null en un doc q se numera por periodo==> numerar de acuerdo a la fecha_actual(defecto)
 
 
         raise notice 'par_codigo_documento =% par_codigo_subsistema=%',par_codigo_documento,par_codigo_subsistema;
    
          SELECT d.id_documento, d.periodo_gestion, d.tipo_numeracion , d.formato
          into   par_id_documento,v_periodo_gestion, v_tipo_numeracion,v_formato_doc
          FROM param.tdocumento d
          INNER JOIN segu.tsubsistema s 
          on s.id_subsistema = d.id_subsistema and s.codigo = par_codigo_subsistema
          WHERE d.estado_reg='activo' and d.codigo = par_codigo_documento;
    
    
   -- raise exception 'par_id_documento=%',v_formato_doc;
    
     --     raise exception 'aa%',v_formato_doc;
    --1) validar la existencia del documento para el que se quiere obtener el correlativo
    if par_id_documento is NULL then
        raise exception 'Obtencion de correlativo no realizada. Documento inexistente % o esta inactivo',par_codigo_documento;
    end if;
    
    
    ------------------
    -- Verificación de Tipo de Numeración
    ------------------
    if (v_tipo_numeracion  = 'depto') then
    	if par_id_depto is null then
    		raise exception 'La numeracion del documento requiere indicar DEPTO';
    	else
    		--obtenemos codigo depto
     		select d.codigo into v_codigo_depto from param.tdepto d where d.id_depto = par_id_depto;
    	end if;
    elsif (v_tipo_numeracion = 'uo') then
    	if par_id_uo is null then
    		raise exception 'La numeracion del documento requiere indicar UO';
    	else
    		--obtenemos codigo UO
      		select u.codigo into v_codigo_uo from orga.tuo u where u.id_uo = par_id_uo;
    	end if;
    elsif (v_tipo_numeracion = 'depto_uo') then
    	if par_id_uo is null or par_id_depto is null then
    		raise exception 'La numeracion del documento requiere indicar UO y DEPTO';
    	else
    		--obtenemos codigo depto
     		select d.codigo into v_codigo_depto from param.tdepto d where d.id_depto = par_id_depto;
     		--obtenemos codigo UO
      		select u.codigo into v_codigo_uo from orga.tuo u where u.id_uo = par_id_uo;
    	end if;
    elsif (v_tipo_numeracion = 'tabla') then
    	--Asume la numeración para cualquier tabla
    	if par_id_tabla is null then
    		raise exception 'La numeracion del documento requiere indicar ID TABLA';
    	end if;
    else
    	raise exception 'Tipo de numeración no válida';
    end if;
    
    
    
    /*--2) verifica si el  tipo de numeracio es depto y si es asi que  exista la variable id_depto
    if (v_tipo_numeracion  in ('depto','depto_uo') and par_id_depto is null) then
        raise exception 'La numeracion del documento requiere indicar DEPTO';
    else
    --obtenemos codigo depto
     select d.codigo into v_codigo_depto from param.tdepto d where d.id_depto = par_id_depto;
    
    end if;
    
    --3) verifica si el  tipo de numeracio se UO y si es asi que  exista la variable id_uo
    if (v_tipo_numeracion  in ('uo','depto_uo') and par_id_uo is null) then
        raise exception 'La numeracion del documento requiere indicar UO';
    else
      --obtenemos codigo UO
      select u.codigo into v_codigo_uo from orga.tuo u where u.id_uo = par_id_uo;
    end if;*/
    
    
    -------------------------------------------------
    
    
    -- 4) IF - Si la numeracion se realiza por periodo obtiene el periodo correspondiente
        --     NOTA si el par_id esta definido indica el periodo al que se quiere
        --     obtener el correlativo
    v_id:=par_id;
    
    raise notice '% %',par_id,v_periodo_gestion;
    
    if(v_periodo_gestion='periodo') then
    
     raise notice 'periodo % %',v_id,v_num_periodo;
         
         --4.1) obtiene la id del periodo
         IF(par_id is null) THEN
         
            -- la numeracion se genera en base al periodo de la fecha actual
            select p.id_periodo, p.periodo,ges.gestion
            into v_id, v_num_periodo ,v_num_gestion
            from param.tperiodo p
            inner join param.tgestion ges 
            on ges.id_gestion = p.id_gestion 
            and ges.estado_reg ='activo'
            where p.estado_reg='activo' and
            now()::date between p.fecha_ini and p.fecha_fin ;
            
            if(v_id is null) then
               raise exception 'Periodo para la fecha % inexistente', now()::date ;
            end if;
         ELSE 
         
            select p.id_periodo, p.periodo, ges.gestion
            into v_id, v_num_periodo,v_num_gestion
            from param.tperiodo p
            inner join param.tgestion ges 
            on ges.id_gestion = p.id_gestion 
            and ges.estado_reg ='activo'
            where  p.estado_reg='activo' and p.id_periodo = par_id;
				
			if(v_id is null) then
               raise exception 'Periodo para el par_id % inexistente', par_id ;
            end if;
    
         END IF; 
         
         -- en funcion al id enviado
         if exists (select 1 from param.tperiodo where id_periodo=v_id and estado_reg!='activo') then
               raise exception 'El periodo solicitado no esta activo';
         end if;

        
       
   ELSE
    
       -- 5.1) obtiene el id de la gestion 
         IF(par_id is null) then
               
               select g.id_gestion , g.gestion
               into v_id, v_num_gestion
               from param.tgestion g
               where g.estado_reg='activo' 
                 and g.gestion=to_char(now()::date,'YYYY')::integer
                   and g.id_empresa = par_id_empresa;
               
              if(v_id is null) then
                 raise exception 'Gestion % no existente', to_char(now()::date,'YYYY');
              end if;
              
         ELSE 
               select g.id_gestion , g.gestion
               into v_id, v_num_gestion
               from param.tgestion g
               where g.id_gestion = par_id;
         END IF;

         if exists (select 1 from param.tgestion 
                   where id_gestion=v_id 
                   and estado_reg!='activo') then
               raise exception 'La gestion no esta activa';
         end if;
      
    end if;
    
   
    
    -- verifica si existe un registro de correlativo para este documento
                raise notice '0 id_documento % ',par_id_documento;
                raise notice '1 gestion >>> %',pxp.f_iif(v_periodo_gestion='gestion',v_id::varchar,0::varchar)::integer ;
                raise notice '2 periodo >>> %',pxp.f_iif (v_periodo_gestion='periodo',v_id::varchar,0::varchar)::integer;
                raise notice '3 uo >>> %',pxp.f_iif(v_tipo_numeracion in ('uo','depto_uo'), par_id_uo::varchar, 0::varchar)::integer;
                raise notice '4 depto >>> %',pxp.f_iif(v_tipo_numeracion in ('depto','depto_uo'),par_id_depto::varchar, 0::varchar)::integer;

    
    
    v_where = '   id_documento='||par_id_documento::varchar ||'
                  and id_gestion '|| pxp.f_iif(v_periodo_gestion='gestion','= '||v_id::varchar,'is NULL') ||'
                  and id_periodo '|| pxp.f_iif (v_periodo_gestion='periodo','= '||v_id::varchar,'is NULL')||'
                  and id_uo      '||  pxp.f_iif(v_tipo_numeracion in ('uo','depto_uo'), '= '||par_id_uo::varchar,'is NULL')||'
                  and id_depto   '|| pxp.f_iif(v_tipo_numeracion in ('depto','depto_uo'),'= '||par_id_depto::varchar, 'is NULL')||'
                  and tabla   '|| pxp.f_iif(v_tipo_numeracion in ('tabla'),'= '''||par_tabla||'''', 'is NULL')||'
                  and id_tabla   '|| pxp.f_iif(v_tipo_numeracion in ('tabla'),'= '||par_id_tabla::varchar, 'is NULL');
     
     
     FOR g_registros in EXECUTE('select 0 as res
                          from param.tcorrelativo 
                          where '|| v_where) LOOP
     
       
           v_correlativo:=g_registros.res;
            
       
     
     END LOOP;
     
     
     
raise notice '>> % correlativo ini %',v_where,v_correlativo;
            
    
    
    
   -- 6) si no existe correlativo para el periodo o gestion se crea un registro
   
      if(v_correlativo is NULL) then
         
         if par_saltar_inicio = 'si' then
            v_correlativo=1;
         else
            v_correlativo=0;
         end if;

         insert into param.tcorrelativo 
         (id_documento,	 
          id_gestion, 
          id_periodo,  
          num_actual, 
          num_siguiente, 
          estado_reg, 
          fecha_reg,   
          id_usuario_reg , 
          id_uo,
          id_depto,
          tabla,
          id_tabla)
         values (
         	par_id_documento, 
            pxp.f_iif(v_periodo_gestion='gestion',v_id::varchar,NULL)::integer, 
            pxp.f_iif (v_periodo_gestion='periodo',v_id::varchar,NULL)::integer,
         	v_correlativo+1, 
            v_correlativo+2, 
            'activo', 
            now(), 
            par_id_usuario, 
            pxp.f_iif(v_tipo_numeracion in ('uo','depto_uo'), par_id_uo::varchar, NULL)::integer, 
            pxp.f_iif((v_tipo_numeracion in ('depto','depto_uo')),par_id_depto::varchar, NULL)::integer,
            pxp.f_iif((v_tipo_numeracion in ('tabla')),par_tabla, NULL)::varchar,
            pxp.f_iif((v_tipo_numeracion in ('tabla')),par_id_tabla::varchar, NULL)::integer
            );
         	v_correlativo:= v_correlativo + 1;
      else
      
         -- 7) si  existe correlativo se actualiza la numeracion para el registro
         --    seleciona el registro bloqueando la tabla para evitar duplicados
         
             FOR g_registros in EXECUTE('SELECT
                                          id_correlativo,
                                          num_actual 
                                          FROM param.tcorrelativo
                                          WHERE '|| v_where ||'
                                          FOR UPDATE
                                          ') LOOP
             
              	 
                
                IF par_forzar_inicio = 'si' THEN
                     v_correlativo = 1;
                ELSE
                      update param.tcorrelativo
                      set num_siguiente=g_registros.num_actual+2,
                      num_actual=g_registros.num_actual+1
                      where 
                      id_correlativo=g_registros.id_correlativo;
                  
                      v_correlativo=g_registros.num_actual+1;
                 END IF;
             
             END LOOP;
        
                       
         
    end if;
    
    raise notice 'correlativo % tipo  % gestion %',v_correlativo,v_tipo_numeracion,v_num_gestion;

 --9) verifica si es necesario retorna el numero con formato   
                        --raise exception 'aa%',par_formato;
  IF(par_formato = 'sin')THEN
              
    return  pxp.f_iif(par_digitos_correlativo>0,pxp.f_llenar_ceros(v_correlativo::numeric,par_digitos_correlativo),v_correlativo::varchar);
    
  ELSEIF par_formato is not null THEN
                  
     
      
      v_formula = replace(par_formato,'depto', COALESCE(v_codigo_depto,'')::varchar); 
      v_formula = replace(v_formula,'uo', COALESCE(v_codigo_uo,'')::varchar);  
      v_formula = replace(v_formula,'codsub', COALESCE(par_codigo_subsistema,'')::varchar);
      v_formula = replace(v_formula,'coddoc', COALESCE(par_codigo_documento,'')::varchar);
      v_formula = replace(v_formula,'periodo', COALESCE(pxp.f_iif(par_digitos_periodo>0,pxp.f_llenar_ceros(v_num_periodo::numeric,par_digitos_periodo),v_num_periodo::varchar),'')::varchar);
      v_formula = replace(v_formula,'gestion', COALESCE(v_num_gestion::varchar,'')::varchar);
      v_formula = replace(v_formula,'correlativo', COALESCE(pxp.f_iif(par_digitos_correlativo>0,pxp.f_llenar_ceros(v_correlativo::numeric,par_digitos_correlativo),v_correlativo::varchar),'')::varchar);
      v_formula = replace(v_formula,'codtabla', COALESCE(par_cod_tabla::varchar,'')::varchar);
  
     
     return  v_formula;
  ELSE
      
     IF(v_formato_doc is not null) THEN
                       
          v_formula = replace(v_formato_doc,'depto', COALESCE(v_codigo_depto,'')::varchar);  
          v_formula = replace(v_formula,'uo', COALESCE(v_codigo_uo,'')::varchar);  
          v_formula = replace(v_formula,'codsub', COALESCE(par_codigo_subsistema,'')::varchar);
          v_formula = replace(v_formula,'coddoc', COALESCE(par_codigo_documento,'')::varchar);
          v_formula = replace(v_formula,'periodo', COALESCE(pxp.f_iif(par_digitos_periodo>0,pxp.f_llenar_ceros(v_num_periodo::numeric,par_digitos_periodo),v_num_periodo::varchar),'')::varchar);
          v_formula = replace(v_formula,'gestion', COALESCE(v_num_gestion::varchar,'')::varchar);
          v_formula = replace(v_formula,'correlativo', COALESCE(pxp.f_iif(par_digitos_correlativo>0,pxp.f_llenar_ceros(v_correlativo::numeric,par_digitos_correlativo),v_correlativo::varchar),'')::varchar);
          v_formula = replace(v_formula,'codtabla', COALESCE(par_cod_tabla::varchar,'')::varchar);
      
         return  v_formula;

     ELSE    
             v_formula='';
              IF v_tipo_numeracion = 'uo' THEN
              
                  v_formula = v_codigo_uo;        
            
              ELSEIF v_tipo_numeracion = 'depto_uo' THEN  

                  v_formula = COALESCE(v_codigo_depto,'')||'-'||COALESCE(v_codigo_uo,'');  
                
              ELSEIF v_tipo_numeracion = 'depto' THEN  
                  v_formula = v_codigo_depto;        
              ELSEIF v_tipo_numeracion = 'tabla' THEN  
                  v_formula = par_cod_tabla;
                
              END IF;
            
               IF  v_periodo_gestion = 'periodo' THEN
                 v_formula = v_formula||'-'||COALESCE(par_codigo_documento,'')||'-'||COALESCE(pxp.f_iif(par_digitos_periodo>0,pxp.f_llenar_ceros(v_num_periodo::numeric,par_digitos_periodo),v_num_periodo::varchar),'')||'/'||COALESCE(v_correlativo::varchar,'')||'-'||COALESCE(v_num_gestion::varchar,'');
               ELSE
                 v_formula = v_formula||'-'||COALESCE(par_codigo_documento,'')||'-'||COALESCE(pxp.f_iif(par_digitos_correlativo>0,pxp.f_llenar_ceros(v_correlativo::numeric,par_digitos_correlativo),v_correlativo::varchar),'')||'-'||COALESCE(v_num_gestion::varchar,'');     
               END IF;
               
             return  v_formula; 
               
      END IF;
      
  END IF;
        
EXCEPTION

      WHEN OTHERS THEN
    	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;