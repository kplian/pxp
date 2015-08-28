--------------- SQL ---------------

CREATE OR REPLACE FUNCTION tes.ft_obligacion_pago_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Tesoreria
 FUNCION: 		tes.ft_obligacion_pago_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'tes.tobligacion_pago'
 AUTOR: 		Gonzalo Sarmiento Sejas (KPLIAN)
 FECHA:	        02-04-2013 16:01:32
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
    v_registros_op          record;
   
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_obligacion_pago	integer;
    
    v_tipo_documento   		varchar;
    v_num 					varchar;
    v_id_periodo 			integer;
    v_codigo_proceso_macro  varchar;
    v_id_proceso_macro 		integer;
    v_codigo_tipo_proceso	varchar;
    
     v_num_tramite 			varchar;
     v_id_proceso_wf 		integer;
     v_id_estado_wf 		integer;
     v_codigo_estado 		varchar;
     v_codigo_estado_ant 	varchar;
     v_anho 				integer;
     v_id_gestion 			integer;
     v_id_subsistema 		integer;
     
    va_id_tipo_estado 		integer[];
    va_codigo_estado 		varchar[];
    va_disparador 			varchar[];
    va_regla 				varchar[];
    va_prioridad  			integer[];
    
    v_id_proceso_compra 	integer;
    v_id_depto 				integer;
    v_total_detalle 		numeric;
    v_id_estado_actual  	integer;
    v_tipo_obligacion 		varchar;
    v_id_tipo_estado 		integer;
    v_id_funcionario 		integer;
    v_id_usuario_reg 		integer;
    v_id_estado_wf_ant  	integer;
    v_comprometido 			varchar;
    v_monto_total 			numeric;
    v_id_obligacion_det 	integer;
    v_factor 				numeric;
    
    v_registros    			record;
    v_cad_ep 				varchar;
    v_cad_uo 				varchar;
    v_tipo_plan_pago		varchar;
    
    
     v_total_nro_cuota  integer;
     v_fecha_pp_ini		date;
     v_rotacion			integer;
     v_id_plantilla 	integer;
     
     v_hstore_pp		hstore;
     v_tipo_cambio_conv numeric;
     v_registros_plan   record;
     v_desc_proveedor   text;
     v_descuentos_ley   numeric;
     v_i                integer;
     v_monto_cuota 		numeric;
     v_ope_filtro       varchar[];
     v_ind              varchar;
     v_sw               boolean;
     v_resp_doc     boolean;
     va_id_funcionario_gerente   INTEGER[];
     v_num_estados integer;
     v_num_funcionarios integer;
     v_id_funcionario_estado integer;
     v_obs varchar;
     v_pago_variable	varchar;
     v_check_ant_mixto numeric;
     v_hstore_registros hstore;
     v_date date;
     v_registros_det record;
     v_id_centro_costo_dos integer;
     v_id_obligacion_pago_sg varchar[];
     v_id_gestion_sg varchar[];
     v_id_partida  integer;
     v_id_obligacion_pago_extendida integer;
     v_registros_op_ori record;
     v_saldo_x_pagar numeric;
     v_registros_pp_origen record;
     
     v_id_estado_wf_pp  VARCHAR[];
     v_id_proceso_wf_pp varchar[];
     v_id_plan_pago_pp varchar[];
     v_id_estado_actual_pp integer;
     v_id_tipo_estado_pp integer;
     v_monto_ajuste_ret_garantia_ga  numeric;
     v_monto_ajuste_ret_anticipo_par_ga  numeric;
     v_resp_fin varchar[];
     v_preguntar varchar;
     v_id_funcionario_sol integer;
     
     va_id_presupuesto 			integer[];
     va_id_partida 	    		integer[];
     va_momento					INTEGER[];
     va_monto          			numeric[];
     va_id_moneda    			integer[];
     va_id_partida_ejecucion	integer[];
     va_columna_relacion   		varchar[];
     va_fk_llave             	integer[];
     va_id_obligacion_det	  	integer[];
     va_fecha 					date[];
     v_fecha     				date;
     va_id_obligacion_det_tmp   integer[];
     va_revertir  				numeric[];
     v_tam        				integer;
     v_indice 					integer;
     va_resp_ges              	numeric[];
     v_id_contrato				integer;
     v_registros_documento		record;
     v_registros_con			record;
     v_id_documento_wf_op		integer;
     v_id_usuario_reg_op        integer;
     v_habilitar_copia_contrato	boolean;
     v_ano_1 					integer;
     v_ano_2 					integer;
     v_sw_saltar 				boolean;
     v_fecha_op					date;
     va_id_funcionarios			integer[];
     v_id_uo					integer;
     v_codigo_estado_siguiente	varchar;
     v_registros_proc 			record;
     v_codigo_tipo_pro   		varchar;
     v_pre_integrar_presupuestos	varchar;

     
			    
BEGIN

    v_nombre_funcion = 'tes.ft_obligacion_pago_ime';
    v_pre_integrar_presupuestos = pxp.f_get_variable_global('pre_integrar_presupuestos');
    v_parametros = pxp.f_get_record(p_tabla);
    v_preguntar = 'no';

	/*********************************    
 	#TRANSACCION:  'TES_OBPG_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		02-04-2013 16:01:32
	***********************************/

	if(p_transaccion='TES_OBPG_INS')then
					
        begin
        
             v_resp = tes.f_inserta_obligacion_pago(p_administrador, p_id_usuario,hstore(v_parametros));
            --Devuelve la respuesta
            return v_resp;
			
		end;

	/*********************************    
 	#TRANSACCION:  'TES_OBPG_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		02-04-2013 16:01:32
	***********************************/

	elsif(p_transaccion='TES_OBPG_MOD')then

		begin
        
           --raise exception 'sss';
        
            select 
               op.id_funcionario,
               op.fecha,
               op.tipo_obligacion,
               op.id_proceso_wf,
               op.tipo_obligacion,
               op.num_tramite
            into
               v_registros
            from tes.tobligacion_pago op
            where  op.id_obligacion_pago = v_parametros.id_obligacion_pago; 
            
            
            IF  v_parametros.id_funcionario is NULL THEN
               v_id_funcionario_sol = v_registros.id_funcionario;
            ELSE
               v_id_funcionario_sol = v_parametros.id_funcionario;
            END IF;
            
            --   TODO
            --   revisa tabla de expcecion por concepto de gasto
            --  algunos concepto de gasto solo los pueden aprobar ciertas gerencias ....
            
            
            
            
            
            
            IF  v_id_funcionario_sol is not NULL  THEN
              
                 --OJO  si el funcionario que solicita es un gerente .... es el mimso encargado de aprobar
                 IF exists(select 1 from orga.tuo_funcionario uof 
                           inner join orga.tuo uo on uo.id_uo = uof.id_uo and uo.estado_reg = 'activo'
                           inner join orga.tnivel_organizacional no on no.id_nivel_organizacional = uo.id_nivel_organizacional and no.numero_nivel in (1,2)
                           where  uof.estado_reg = 'activo' and  uof.id_funcionario = v_id_funcionario_sol ) THEN
                  
                      va_id_funcionario_gerente[1] = v_id_funcionario_sol;
                 
                 ELSE
                    --si tiene funcionario identificar el gerente correspondientes
                     SELECT  
                           pxp.aggarray(id_funcionario) 
                       into
                           va_id_funcionario_gerente
                     FROM orga.f_get_aprobadores_x_funcionario(v_registros.fecha,  v_id_funcionario_sol , 'todos', 'si', 'todos', 'ninguno') AS (id_funcionario integer);      
                        --NOTA el valor en la primera posicion del array es el genre de menor nivel
                   
                END IF;
                
                 
            END IF;
            
             
            IF   pxp.f_existe_parametro(p_tabla,'id_contrato')    THEN
              v_id_contrato = v_parametros.id_contrato;
            END IF;
            
           
           
            --raise exception 'sss %',va_id_funcionario_gerente[1];
            
			--Sentencia de la modificacion
			update tes.tobligacion_pago set
			id_proveedor = v_parametros.id_proveedor,
		    id_moneda = v_parametros.id_moneda,
            tipo_cambio_conv=v_parametros.tipo_cambio_conv,
			obs = v_parametros.obs,
			--porc_retgar = v_parametros.porc_retgar,
		    id_funcionario = v_id_funcionario_sol,
			--porc_anticipo = v_parametros.porc_anticipo,
		    id_depto = v_parametros.id_depto,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
            pago_variable = v_parametros.pago_variable,
            total_nro_cuota = v_parametros.total_nro_cuota,
            fecha_pp_ini = v_parametros.fecha_pp_ini,
            rotacion = v_parametros.rotacion,
            id_plantilla = v_parametros.id_plantilla,
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai,
            tipo_anticipo = v_parametros.tipo_anticipo,
            id_funcionario_gerente = va_id_funcionario_gerente[1],
            id_contrato = v_id_contrato
            
            
            
			where id_obligacion_pago = v_parametros.id_obligacion_pago;
            
           
            -------------------------------------
            -- COPIA CONTRATOS,  si es un pago recurrente
            -- si viene de adquiscioens y elnumero de de tramite del troato es el mismo que la obligacion no es encesario copiar
            -------------------------------------
            
            --  Si  la referencia al contrato esta presente ..  copiar el documento de contrato
            IF v_id_contrato  is not  NULL    THEN
                
                 v_habilitar_copia_contrato = TRUE;
                 
                  --con el ide de contrato obtenet el id_proceso_wf
                   SELECT
                     con.id_proceso_wf,
                     con.numero,
                     con.estado,
                     pwf.nro_tramite
                   INTO
                    v_registros_con
                   FROM leg.tcontrato con
                   INNER JOIN wf.tproceso_wf pwf on pwf.id_proceso_wf = con.id_proceso_wf
                   WHERE con.id_contrato = v_id_contrato;
                 
                 IF  v_registros.tipo_obligacion = 'adquisiciones'  THEN
                 
                       IF v_registros_con.nro_tramite = v_registros.num_tramite THEN
                         v_habilitar_copia_contrato = FALSE;
                       ELSE
                         v_habilitar_copia_contrato = TRUE;
                       END IF;
                 
                 END IF;
                 
                IF v_habilitar_copia_contrato THEN
                      -- con el proceso del contrato buscar el documento con codigo CONTRATO 
                   
                      SELECT
                        d.*
                      into
                       v_registros_documento
                      FROM wf.tdocumento_wf d
                      INNER JOIN wf.ttipo_documento td on td.id_tipo_documento = d.id_tipo_documento
                      WHERE td.codigo = 'CONTRATO' and 
                            d.id_proceso_wf = v_registros_con.id_proceso_wf;
                     
                        -- copiamos el link de referencia del contrato
                        select
                         dwf.id_documento_wf
                        into
                         v_id_documento_wf_op
                        from wf.tdocumento_wf dwf
                        inner  join  wf.ttipo_documento td on td.id_tipo_documento = dwf.id_tipo_documento
                        where td.codigo = 'CONTRATO'  and dwf.id_proceso_wf = v_registros.id_proceso_wf;
                     
                        UPDATE 
                          wf.tdocumento_wf  
                        SET 
                           id_usuario_mod = p_id_usuario,
                           fecha_mod = now(),
                           chequeado = v_registros_documento.chequeado,
                           url = v_registros_documento.url,
                           extension = v_registros_documento.extension,
                           obs = v_registros_documento.obs,
                           chequeado_fisico = v_registros_documento.chequeado_fisico,
                           id_usuario_upload = v_registros_documento.id_usuario_upload,
                           fecha_upload = v_registros_documento.fecha_upload,
                           id_proceso_wf_ori = v_registros_documento.id_proceso_wf,
                           id_documento_wf_ori = v_registros_documento.id_documento_wf,
                           nro_tramite_ori = v_registros_con.nro_tramite
                        WHERE 
                          id_documento_wf = v_id_documento_wf_op;    
                  END IF;
            
            END IF;
            
            
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Obligaciones de Pago modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'TES_OBPG_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		02-04-2013 16:01:32
	***********************************/

	elsif(p_transaccion='TES_OBPG_ELI')then

		begin
        
            -- obtiene datos de la obligacion
           
                select
                  op.estado,
                  op.id_proceso_wf,
                  op.id_obligacion_pago,
                  op.id_depto,
                  op.id_estado_wf
                into v_registros  
                 from  tes.tobligacion_pago op 
                 where  op.id_obligacion_pago = v_parametros.id_obligacion_pago;
                 
                 
                IF v_registros.estado!='borrador'  THEN
                
                   raise exception 'Solo se pueden anular obligaciones en estado borrador';
                
                END IF; 
            
               --recuperamos el id_tipo_proceso en el WF para el estado anulado
               --ya que este es un estado especial que no tiene padres definidos
               
               
               select 
               	te.id_tipo_estado
               into
               	v_id_tipo_estado
               from wf.tproceso_wf pw 
               inner join wf.ttipo_proceso tp on pw.id_tipo_proceso = tp.id_tipo_proceso
               inner join wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso and te.codigo = 'anulado'               
               where pw.id_proceso_wf = v_registros.id_proceso_wf;
               
               
               IF v_id_tipo_estado is NULL THEN
               
                  raise exception 'El estado anulado para la obligacion de pago no esta parametrizado en el workflow';  
               
               END IF;
              
              
               -- pasamos la obligacion al estado anulado
               
               
           
               v_id_estado_actual =  wf.f_registra_estado_wf(v_id_tipo_estado, 
                                                           NULL, 
                                                           v_registros.id_estado_wf, 
                                                           v_registros.id_proceso_wf,
                                                           p_id_usuario,
                                                           v_parametros._id_usuario_ai,
            											   v_parametros._nombre_usuario_ai,
                                                           v_registros.id_depto,
                                                           'Obligacion de Pago Anulada');
            
            
               -- actualiza estado en la cotizacion
              
               update tes.tobligacion_pago  op set 
                 id_estado_wf =  v_id_estado_actual,
                 estado = 'anulado',
                 id_usuario_mod=p_id_usuario,
                 fecha_mod=now(),
                 estado_reg='inactivo',
                 id_usuario_ai = v_parametros._id_usuario_ai,
                 usuario_ai = v_parametros._nombre_usuario_ai
               where op.id_obligacion_pago  = v_parametros.id_obligacion_pago;
               
               
               --inactiva el datalle de la solicitud
               update tes.tobligacion_det od set  
                estado_reg= 'inactivo',
                id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                id_usuario_ai = v_parametros._id_usuario_ai,
                usuario_ai = v_parametros._nombre_usuario_ai
               where  od.id_obligacion_pago = v_parametros.id_obligacion_pago;
               
               
               ----------------------------------------------------------------
               ---si esta integrado con adquisiciones libera la cotizacion ----
               -----------------------------------------------------------------
                
                IF  exists (select 1 
                            from adq.tcotizacion cot 
                            where cot.id_obligacion_pago = v_parametros.id_obligacion_pago)  THEN
                
                     
                         -- retroceder el estado de la cotizacion
                        
                          Select     
                          c.id_cotizacion,
                          c.id_proceso_wf,
                          c.id_estado_wf,
                          c.estado
                          into
                          v_registros
                          
                          from adq.tcotizacion c 
                          where c.id_obligacion_pago = v_parametros.id_obligacion_pago;   
                              
                         --recuperaq estado anterior segun Log del WF
                          
                            SELECT  
                               ps_id_tipo_estado,
                               ps_id_funcionario,
                               ps_id_usuario_reg,
                               ps_id_depto,
                               ps_codigo_estado,
                               ps_id_estado_wf_ant
                            into
                               v_id_tipo_estado,
                               v_id_funcionario,
                               v_id_usuario_reg,
                               v_id_depto,
                               v_codigo_estado,
                               v_id_estado_wf_ant 
                            FROM wf.f_obtener_estado_ant_log_wf(v_registros.id_estado_wf);
                                                   
                
                          
                          
                          -- registra nuevo estado
                          
                          v_id_estado_actual = wf.f_registra_estado_wf(
                              v_id_tipo_estado, 
                              v_id_funcionario, 
                              v_registros.id_estado_wf, 
                              v_registros.id_proceso_wf, 
                              p_id_usuario,
                              v_parametros._id_usuario_ai,
                              v_parametros._nombre_usuario_ai,
                              v_id_depto,
                              'El estado  retrocede por anulacion de la obligacion en tesoreria');
                          
                        
                          
                            -- actualiza estado en la solicitud
                            update adq.tcotizacion  s set 
                               id_estado_wf =  v_id_estado_actual,
                               estado = v_codigo_estado,
                               id_usuario_mod=p_id_usuario,
                               fecha_mod=now(),
                               id_obligacion_pago = NULL
                             where id_cotizacion = v_registros.id_cotizacion;    
                    
                           --romper relacion con obligacion det
                           update adq.tcotizacion_det  s set 
                                   id_obligacion_det = NULL
                           where id_cotizacion = v_registros.id_cotizacion; 
                
                  v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Obligaciones de Pago eliminado(a), y cotizacion retrocedida'); 
                
                ELSE
                  v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Obligaciones de Pago eliminado(a)'); 
                END IF; 
              
            --Definicion de la respuesta
          
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
      
    /*********************************    
 	#TRANSACCION:  'TES_FINREG_IME'
 	#DESCRIPCION:	Finaliza el registro de obligacion de pago
 	#AUTOR:	    Rensi Arteaga Copari
 	#FECHA:		02-04-2013 16:01:32
	***********************************/

	elsif(p_transaccion='TES_FINREG_IME')then

		begin
        
            v_resp = tes.f_finalizar_obligacion_total(v_parametros.id_obligacion,p_id_usuario,v_parametros._id_usuario_ai,v_parametros._nombre_usuario_ai,v_parametros.forzar_fin);
                         
            --Devuelve la respuesta
            return v_resp;

		end;
     
     /*********************************    
 	#TRANSACCION:  'TES_SIGESTOB_IME'
 	#DESCRIPCION:	cambia al siguiente estado de la obligacion de pago con el wizard del WF (no se considera el estado finalizado)
 	#AUTOR:		RAC	
 	#FECHA:		24-06-2015 12:12:51
	***********************************/

	elseif(p_transaccion='TES_SIGESTOB_IME')then   
        begin
        
         /*   PARAMETROS
         
        $this->setParametro('id_proceso_wf_act','id_proceso_wf_act','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('id_funcionario_wf','id_funcionario_wf','int4');
        $this->setParametro('id_depto_wf','id_depto_wf','int4');
        $this->setParametro('obs','obs','text');
        $this->setParametro('json_procesos','json_procesos','text');
        */
        
        --obtenermos datos basicos
         select 
              op.id_proceso_wf,
              op.id_estado_wf,
              op.estado,
              op.id_depto,
              op.tipo_obligacion,
              op.total_nro_cuota,
              op.fecha_pp_ini,
              op.rotacion,
              op.id_plantilla,
              op.tipo_cambio_conv,
              pr.desc_proveedor,
              op.pago_variable,
              op.comprometido,
              op.id_usuario_reg,
              op.fecha
              
             into
              v_id_proceso_wf,
              v_id_estado_wf,
              v_codigo_estado,
              v_id_depto,
              v_tipo_obligacion,
              v_total_nro_cuota,
              v_fecha_pp_ini,
              v_rotacion,
              v_id_plantilla,
              v_tipo_cambio_conv,
              v_desc_proveedor,
              v_pago_variable,
              v_comprometido,
              v_id_usuario_reg_op,
              v_fecha_op
           from tes.tobligacion_pago op
           left join param.vproveedor pr  on pr.id_proveedor = op.id_proveedor
           where op.id_obligacion_pago = v_parametros.id_obligacion_pago;
          
          -------------------------------------------------
          --  Validamos que la solicitud tengan contenido
          --------------------------------------------------
         
           IF  v_codigo_estado in ('borrador','vbpoa','vbpresupuestos' ) THEN
                  --validamos que el detalle tenga por lo menos un item con valor
                   select 
                    sum(od.monto_pago_mo)
                   into
                    v_total_detalle
                   from tes.tobligacion_det od
                   where od.id_obligacion_pago = v_parametros.id_obligacion_pago and od.estado_reg ='activo'; 
                   
                   IF v_total_detalle = 0 or v_total_detalle is null THEN
                      raise exception 'No existe el detalle de obligacion...';
                   END IF; 
                  ------------------------------------------------------------
                  --calcula el factor de prorrateo de la obligacion  detalle
                  -----------------------------------------------------------
                  IF (tes.f_calcular_factor_obligacion_det(v_parametros.id_obligacion_pago) != 'exito')  THEN
                      raise exception 'error al calcular factores';
                  END IF;
           END IF;
         
           ----------------------------------------------------------------------------------------------------------
           --  valida si tiene algun concepto en la tabla de excepciones, si es asi cambi la gerencia de aprobación
           ----------------------------------------------------------------------------------------------------------
           IF  v_codigo_estado = 'borrador'  THEN
                    
                    SELECT  
                      ce.id_uo
                    into
                      v_id_uo
                    FROM tes.tconcepto_excepcion ce 
                    where   ce.estado_reg = 'activo'  and
                             ce.id_concepto_ingas in (select 
                                                    id_concepto_ingas
                                                   from tes.tobligacion_det od
                                                   where od.id_obligacion_pago = v_parametros.id_obligacion_pago
                                                   and od.estado_reg = 'activo' ) 
                    limit 1 OFFSET 0;
                     
                    --si existe una excepcion cambiar el funcionar aprobador
                    
                    IF v_id_uo is NOT NULL THEN
                         --recuperamos el aprobador
                        
                         va_id_funcionarios =  orga.f_get_funcionarios_x_uo(v_id_uo, v_fecha_op);
                        
                        IF va_id_funcionarios[1] is NULL THEN
                           raise exception 'La UO configurada por excpeción no tiene un funcionario asignado para le fecha de la OP';
                        END IF;
                        
                        update tes.tobligacion_pago o set
                          id_funcionario_gerente = va_id_funcionarios[1],
                          uo_ex = 'si'
                        where o.id_obligacion_pago = v_parametros.id_obligacion_pago; 
                    
                     END IF ; 
            END IF;
         
          -- recupera datos del estado
         
           select 
            ew.id_tipo_estado ,
            te.codigo
           into 
            v_id_tipo_estado,
            v_codigo_estado
          from wf.testado_wf ew
          inner join wf.ttipo_estado te on te.id_tipo_estado = ew.id_tipo_estado
          where ew.id_estado_wf = v_parametros.id_estado_wf_act;
        
         
          
           -- obtener datos tipo estado
           select
                 te.codigo
            into
                 v_codigo_estado_siguiente
           from wf.ttipo_estado te
           where te.id_tipo_estado = v_parametros.id_tipo_estado;
                
           IF  pxp.f_existe_parametro(p_tabla,'id_depto_wf') THEN
              v_id_depto = v_parametros.id_depto_wf;
           END IF;
                
           IF  pxp.f_existe_parametro(p_tabla,'obs') THEN
                  v_obs=v_parametros.obs;
           ELSE
                  v_obs='---';
           END IF;
            
           ---------------------------------------
           -- REGISTA EL SIGUIENTE ESTADO DEL WF.
           ---------------------------------------
            
           v_id_estado_actual =  wf.f_registra_estado_wf(  v_parametros.id_tipo_estado, 
                                                           v_parametros.id_funcionario_wf, 
                                                           v_parametros.id_estado_wf_act, 
                                                           v_id_proceso_wf,
                                                           p_id_usuario,
                                                           v_parametros._id_usuario_ai,
                                                           v_parametros._nombre_usuario_ai,
                                                           v_id_depto,
                                                           v_obs);
                                                             
          --------------------------------------
          -- registra los procesos disparados
          --------------------------------------
         
          FOR v_registros_proc in ( select * from json_populate_recordset(null::wf.proceso_disparado_wf, v_parametros.json_procesos::json)) LOOP
    
               -- get cdigo tipo proceso
               select   
                  tp.codigo 
               into 
                  v_codigo_tipo_pro   
               from wf.ttipo_proceso tp 
               where  tp.id_tipo_proceso =  v_registros_proc.id_tipo_proceso_pro;
          
          
              -- disparar creacion de procesos seleccionados
              SELECT
                       ps_id_proceso_wf,
                       ps_id_estado_wf,
                       ps_codigo_estado
                 into
                       v_id_proceso_wf,
                       v_id_estado_wf,
                       v_codigo_estado
              FROM wf.f_registra_proceso_disparado_wf(
                       p_id_usuario,
                       v_parametros._id_usuario_ai,
                       v_parametros._nombre_usuario_ai,
                       v_id_estado_actual, 
                       v_registros_proc.id_funcionario_wf_pro, 
                       v_registros_proc.id_depto_wf_pro,
                       v_registros_proc.obs_pro,
                       v_codigo_tipo_pro,    
                       v_codigo_tipo_pro);
                       
                       
           END LOOP; 
           
          -- si es estado actual es vbpresupeustos registras las observaciones de presupeustos
           IF  v_codigo_estado  in  ('vbpresupuestos') THEN
                 update tes.tobligacion_pago  set 
                  obs_presupuestos = v_parametros.obs
                 where id_obligacion_pago  = v_parametros.id_obligacion_pago;
           END IF;   
           
          --------------------------------------------------
          --  ACTUALIZA EL NUEVO ESTADO DE LA OBLIGACION
          ----------------------------------------------------
                  
           update tes.tobligacion_pago  set 
             id_estado_wf =  v_id_estado_actual,
             estado = v_codigo_estado_siguiente,
             id_usuario_mod = p_id_usuario,
             total_pago = v_total_detalle,
             fecha_mod = now(),
             id_usuario_ai = v_parametros._id_usuario_ai,
             usuario_ai = v_parametros._nombre_usuario_ai
           where id_obligacion_pago  = v_parametros.id_obligacion_pago;
          
          
          
          ---------------------------------------
          --  CHEQUEAR OBLIGACIONES EXTENDIDAS
          ---------------------------------------
          
          IF  v_codigo_estado_siguiente = 'registrado'  THEN  -- solo si esta pasando al estado registrado
                 
                  --  chequear si es una obligacion de pago extendida,
                  select 
                       op.id_obligacion_pago,
                       op.num_tramite,
                       op.id_depto,
                       op.id_depto_conta
                  into
                      v_registros_op_ori
                  from tes.tobligacion_pago op 
                  where op.id_obligacion_pago_extendida = v_parametros.id_obligacion_pago;
                 
                 --  si es una obligacion de pago extendida
                 
                 IF v_registros_op_ori is not NULL THEN
                  
                        -- Chequear si la obligacion original tiene un saldo anticipado
                        v_saldo_x_pagar = 0;
                        v_saldo_x_pagar = tes.f_determinar_total_faltante(v_registros_op_ori.id_obligacion_pago,'anticipo_sin_aplicar');
                        
                        
                        
                        IF  v_saldo_x_pagar > 0 THEN
                           -- Si tiene saldo anticipado validar el monto presupuesto es suficiente para  cubrir este anticipo
                           IF  v_saldo_x_pagar > v_total_detalle   THEN
                              raise exception 'El total presupuestado no es suficiente para  cubrir el saldo anticipado en la gestión anterior. Saldo anticipado (%)', v_saldo_x_pagar;
                           END IF;
                           -- Recupera la ultima plantilla de  documento con saldo anticipado
                            select 
                              *
                           INTO 
                              v_registros_pp_origen
                           from tes.tplan_pago pp
                           where 
                                 (pp.monto_anticipo > 0 or  pp.tipo = 'anticipo' ) and
                                 pp.estado_reg = 'activo'  and
                                 pp.id_obligacion_pago = v_registros_op_ori.id_obligacion_pago
                            
                           order by pp.nro_cuota desc  LIMIT 1 OFFSET 0;
                                
                           -- insertar un plan de pagos de anticipo en estado anticipado 
                           -- con el monto del saldo listo para colgar aplicaciones
                            
                           v_hstore_registros =   hstore(ARRAY[
                                                  'id_cuenta_bancaria', v_registros_pp_origen.id_cuenta_bancaria::varchar,
                                                  'id_cuenta_bancaria_mov', v_registros_pp_origen.id_cuenta_bancaria_mov::varchar,
                                                  'forma_pago', v_registros_pp_origen.forma_pago::varchar,
                                                  'nro_cheque', v_registros_pp_origen.nro_cheque::varchar,
                                                  'nro_cuenta_bancaria',v_registros_pp_origen.nro_cuenta_bancaria::varchar,
                                                  'monto', v_saldo_x_pagar::varchar,
                                                  'id_obligacion_pago', v_parametros.id_obligacion_pago::varchar,
                                                  'monto_retgar_mo', '0',
                                                  'descuento_ley', v_registros_pp_origen.descuento_ley::varchar,
                                                  'descuento_anticipo', '0',
                                                  'otros_descuentos', '0',
                                                  'monto_no_pagado', '0',
                                                  'fecha_tentativa', now()::varchar,
                                                  'id_plantilla', v_registros_pp_origen.id_plantilla::varchar,
                                                  'tipo', 'anticipo',
                                                  'porc_monto_excento_var', v_registros_pp_origen.porc_monto_excento_var::varchar,
                                                  'monto_excento', v_registros_pp_origen.monto_excento::varchar, 
                                                  'tipo_cambio', v_registros_pp_origen.tipo_cambio::varchar,
                                                  'porc_descuento_ley', v_registros_pp_origen.porc_descuento_ley::varchar,
                                                  'descuento_inter_serv', 0::varchar,
                                                  '_id_usuario_ai', v_parametros._id_usuario_ai::varchar,
                                                  '_nombre_usuario_ai', v_parametros._nombre_usuario_ai::varchar,
                                                  'nombre_pago', v_registros_pp_origen.nombre_pago::varchar,
                                                  'id_plan_pago_fk',NULL::varchar,
                                                  'porc_monto_retgar', '0',
                                                  'monto_ajuste_ag', '0'
                                                ]);
                            
                              
                               -- llamada para insertar plan de pagos
                               v_resp = tes.f_inserta_plan_pago_anticipo(p_administrador, p_id_usuario, v_hstore_registros);
                               v_id_estado_wf_pp =  pxp.f_recupera_clave(v_resp, 'id_estado_wf');
                               v_id_proceso_wf_pp =  pxp.f_recupera_clave(v_resp, 'id_proceso_wf');
                               v_id_plan_pago_pp =  pxp.f_recupera_clave(v_resp, 'id_plan_pago');
                             
                               --  cambia de estado el plan de pago,lo lleva a anticipado	
                               select   
                                te.id_tipo_estado
                               into
                                v_id_tipo_estado_pp
                               from wf.ttipo_estado te 
                               inner join wf.tproceso_wf  pw on pw.id_tipo_proceso = te.id_tipo_proceso 
                                    and pw.id_proceso_wf = v_id_proceso_wf_pp[1]::integer
                               where te.codigo = 'anticipado';
                               
                               IF v_id_tipo_estado_pp is  null THEN                        
                                raise exception 'El proceso de WF esta mal parametrizado, no tiene el estado Visto bueno contabilidad (vbconta) ';
                               END IF;
                               
                             
                             -- registrar el siguiente estado detectado  (vbconta)
                             v_id_estado_actual_pp =  wf.f_registra_estado_wf(v_id_tipo_estado_pp, 
                                                                           NULL, 
                                                                           v_id_estado_wf_pp[1]::integer, 
                                                                           v_id_proceso_wf_pp[1]::integer,
                                                                           p_id_usuario,
                                                                           v_parametros._id_usuario_ai,
                                                                           v_parametros._nombre_usuario_ai,
                                                                           v_id_depto,
                                                                           'Se lleva el anticipo a finalizado por saldo de la anterior gestion ('||v_registros_op_ori.num_tramite ||')');
                             
                             
                              -- actualiza el nuevo estado para el anticipo
                              update tes.tplan_pago pp  set 
                                     id_estado_wf =  v_id_estado_actual_pp,
                                     estado = 'anticipado'
                              where id_plan_pago  = v_id_plan_pago_pp[1]::integer;
                           
                        END IF;
                        
                        -- Chequear si tiene dev de garantia pendientes,
                        v_monto_ajuste_ret_garantia_ga = 0;
                        v_monto_ajuste_ret_garantia_ga = tes.f_determinar_total_faltante(v_registros_op_ori.id_obligacion_pago,'dev_garantia');
                        
                        -- chequear si tiene retenciones pendientes de anticipos parciales
                        v_monto_ajuste_ret_anticipo_par_ga = 0;
                        v_monto_ajuste_ret_anticipo_par_ga = tes.f_determinar_total_faltante(v_registros_op_ori.id_obligacion_pago,'ant_parcial_descontado');
                        
                        update tes.tobligacion_pago  set 
                         monto_ajuste_ret_garantia_ga = COALESCE(v_monto_ajuste_ret_garantia_ga,0),
                         monto_ajuste_ret_anticipo_par_ga = COALESCE(v_monto_ajuste_ret_anticipo_par_ga,0)
                       where id_obligacion_pago  = v_parametros.id_obligacion_pago;
                              
                 END IF;
             
            END IF;
            
          -------------------------------------------
          --  VERIFICA SI ES NECESARIO UN CONTRATO
          -----------------------------------------
           IF  v_codigo_estado = 'borrador'  THEN 
               
                 IF not tes.f_validar_contrato(v_parametros.id_obligacion_pago) THEN
                   raise exception 'contrato no validao';
                 END IF;
             
           END IF;  
          
          --------------------------------------------------
          --  INSERCION AUTOMATICA DE CUOTAS
          --------------------------------------------------
            
          --  TODO considerar el saldo de anticipo, menos  el total a pagar para determinar el monto, considerar numero de cuota
          --  si llegando al estado registrado,  verifica el total de cuotas y las inserta con la plantilla por defecto 
            
          IF  v_codigo_estado_siguiente = 'registrado'  and v_total_nro_cuota > 0 THEN 
            
                      select  
                       ps_descuento_porc,
                       ps_descuento,
                       ps_observaciones
                     into
                      v_registros_plan
                     FROM  conta.f_get_descuento_plantilla_calculo(v_id_plantilla);
                     
                     /*jrr(10/10/2014): En caso de que sea pago variable el valor de la cuota sera 0*/ 
                     
                     if (v_pago_variable = 'si') then
                      	v_monto_cuota = 0;
                     else
                     	v_monto_cuota =  (v_total_detalle::numeric/v_total_nro_cuota::numeric)::numeric(19,1);
                     end if;
                     
                     FOR v_i  IN 1..v_total_nro_cuota LOOP
                         IF v_i = v_total_nro_cuota THEN
                            v_monto_cuota = v_total_detalle - (v_monto_cuota*v_total_nro_cuota) + v_monto_cuota;
                         	/*jrr(10/10/2014): En caso de que sea pago variable el valor de la cuota sera 0*/ 
                            if (v_pago_variable = 'si') then
                              v_monto_cuota = 0;
                           	end if;
                         END IF;
                         
                         v_descuentos_ley = v_monto_cuota * v_registros_plan.ps_descuento_porc;
                         
                         IF v_tipo_obligacion in  ('pago_especial') THEN
                            v_tipo_plan_pago = 'especial';
                         ELSE
                           v_tipo_plan_pago = 'devengado_pagado';
                         END IF;
                         
                         --armar hstore 
                         v_hstore_pp =   hstore(ARRAY[
                                                        'tipo_pago', 
                                                        'normal',
                                                        'tipo',   
                                                        v_tipo_plan_pago,
                                                        'tipo_cambio',v_tipo_cambio_conv::varchar,
                                                        'id_plantilla',v_id_plantilla::varchar,
                                                        'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar,
                                                        'monto_no_pagado','0',
                                                        'monto_retgar_mo','0',
                                                        'otros_descuentos','0',
                                                        'monto_excento','0',
                                                        'id_plan_pago_fk',NULL::varchar,
                                                        'porc_descuento_ley',v_registros_plan.ps_descuento_porc::varchar,
                                                        'obs_descuentos_ley',v_registros_plan.ps_observaciones::varchar,
                                                        'obs_otros_descuentos','',
                                                        'obs_monto_no_pagado','',
                                                        'nombre_pago',v_desc_proveedor::varchar,
                                                        'monto', v_monto_cuota::varchar,
                                                        'descuento_ley',v_descuentos_ley::varchar,
                                                        'fecha_tentativa',v_fecha_pp_ini::varchar,
                                                        '_id_usuario_ai',v_parametros._id_usuario_ai::varchar,
                                                        '_nombre_usuario_ai', v_parametros._nombre_usuario_ai::varchar
                                                       ]);
                          
                            --TODO,  bloquear en formulario de OP  facturas con monto excento
                            
                            
                            -- si es un proceso de pago unico,  la primera cuota pasa de borrador al siguiente estado de manera automatica 
                            IF  v_tipo_obligacion = 'pago_unico' and   v_i = 1   THEN
                               v_sw_saltar = TRUE;
                            else
                               v_sw_saltar = FALSE;
                            END IF;
                             
                            -- llamada para insertar plan de pagos
                            v_resp = tes.f_inserta_plan_pago_dev(p_administrador, v_id_usuario_reg_op,v_hstore_pp, v_sw_saltar);
                            
                            -- calcula la fecha para la siguiente insercion
                            v_fecha_pp_ini =  v_fecha_pp_ini + interval  '1 month'*v_rotacion;
                     END LOOP;
          END IF;
          
          -----------------------------------------------------------------------------
          -- COMPROMISO PRESUPUESTARIO
          -- cuando pasa al estado registrado y el presupeusto no esta comprometido
          ------------------------------------------------------------------------------
          IF  v_codigo_estado_siguiente = 'registrado'  and  v_comprometido = 'no' and v_tipo_obligacion != 'adquisiciones' and v_tipo_obligacion != 'pago_especial' and   v_pre_integrar_presupuestos = 'true'  THEN
               
               --TODO aumentar capacidad de rollback
               -- verficar presupuesto y comprometer
               IF not tes.f_gestionar_presupuesto_tesoreria(v_parametros.id_obligacion_pago, p_id_usuario, 'comprometer')  THEN
                   raise exception 'Error al comprometer el presupeusto';
               END IF;
               
               v_comprometido = 'si';
               --cambia la bandera del comprometido
               update tes.tobligacion_pago  set 
                 comprometido = v_comprometido
               where id_obligacion_pago  = v_parametros.id_obligacion_pago;
               
               --jrr: llamamos a la funcion que revierte de planillas en caso de que sea de recursos humanos
                if (v_tipo_obligacion = 'rrhh') then
                    IF NOT plani.f_generar_pago_tesoreria(p_administrador,p_id_usuario,v_parametros._id_usuario_ai,
                              v_parametros._nombre_usuario_ai,v_parametros.id_obligacion_pago,v_obs) THEN                                                         
                         raise exception 'Error al generar el pago de devengado';                          
                      END IF;            	
                end if;
           
           END IF;
           
           -- cuando viene de adquisiciones no es necesario comprometer pero dejamos la bancera de compromiso barcada
           --  ya que los montos se comprometiron en la solicitud de compra
           IF v_codigo_estado_siguiente = 'registrado'  and  v_comprometido = 'no' and v_tipo_obligacion in  ('adquisiciones','pago_especial') THEN
               v_comprometido = 'si';
               --cambia la bandera del comprometido
               update tes.tobligacion_pago  set 
                 comprometido = v_comprometido
               where id_obligacion_pago  = v_parametros.id_obligacion_pago;
           END IF;
             
          -- si hay mas de un estado disponible  preguntamos al usuario
          v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo el cambio de estado del plan de pagos)'); 
          v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
          
          
          -- Devuelve la respuesta
          return v_resp;
        
     end;  
    
    
    
    /*********************************    
 	#TRANSACCION:  'TES_ANTEOB_IME'
 	#DESCRIPCION:	Retrocede estado de la obligacion
 	#AUTOR:	        Rensi Arteaga Copari
 	#FECHA:		02-04-2013 16:01:32
	***********************************/

	elsif(p_transaccion='TES_ANTEOB_IME')then

		begin
        
        --recupera parametros
            select 
            op.id_estado_wf,
            op.id_proceso_wf,
            op.estado,
            op.comprometido,
            op.tipo_obligacion,
            op.comprometido
            into
            v_id_estado_wf,
            v_id_proceso_wf,
            v_codigo_estado_ant,
            v_comprometido,
            v_tipo_obligacion,
            v_comprometido
            
            from tes.tobligacion_pago op
            where op.id_obligacion_pago = v_parametros.id_obligacion_pago; 
            
        
        
        --------------------------------------------------
        --Retrocede al estado inmediatamente anterior
        -------------------------------------------------
         IF  v_parametros.operacion = 'cambiar' THEN
                     
                       --validaciones
                       
                       IF v_codigo_estado_ant = 'en_pago' THEN
                       --verificar que no tenga plnes de pago
                       
                         IF  EXISTS(select 1
                         from tes.tplan_pago pp
                         where pp.id_obligacion_pago = v_parametros.id_obligacion_pago
                               and pp.estado_reg='activo') THEN
                       
                            raise exception 'Para retroceder no debe tener planes de pago activos';
                          
                         END IF;
                       
                       
                       END IF;      
         
         
              
                      --recuperaq estado anterior segun Log del WF
                      
                        SELECT  
                           ps_id_tipo_estado,
                           ps_id_funcionario,
                           ps_id_usuario_reg,
                           ps_id_depto,
                           ps_codigo_estado,
                           ps_id_estado_wf_ant
                        into
                           v_id_tipo_estado,
                           v_id_funcionario,
                           v_id_usuario_reg,
                           v_id_depto,
                           v_codigo_estado,
                           v_id_estado_wf_ant 
                        FROM wf.f_obtener_estado_ant_log_wf(v_id_estado_wf);
                        
                        
                      -- recupera el proceso_wf
                      
                      select 
                           ew.id_proceso_wf 
                        into 
                           v_id_proceso_wf
                      from wf.testado_wf ew
                      where ew.id_estado_wf= v_id_estado_wf_ant;
                      
                      v_obs = '';
                      
                      IF  pxp.f_existe_parametro(p_tabla,'obs') THEN
                         v_obs = '-'||v_obs||COALESCE(v_parametros.obs,'---');
                      END IF;
                      
                     
                      
                      
                      -- registra nuevo estado
                      
                      v_id_estado_actual = wf.f_registra_estado_wf(
                          v_id_tipo_estado, 
                          v_id_funcionario, 
                          v_id_estado_wf, 
                          v_id_proceso_wf, 
                          p_id_usuario,
                          v_parametros._id_usuario_ai,
                          v_parametros._nombre_usuario_ai,
                          v_id_depto,
                          v_obs);
                      
                    
                      
                      -- actualiza estado en la obligacion
                        update tes.tobligacion_pago  op set 
                           id_estado_wf =  v_id_estado_actual,
                           estado = v_codigo_estado,
                           id_usuario_mod=p_id_usuario,
                           fecha_mod=now(),
                           obs = obs ||v_obs
                         where id_obligacion_pago = v_parametros.id_obligacion_pago;
                         
                        
                        -- cuando el estado al que regresa es  borrador o presupeustos esta comprometido y no viene de adquisiciones se revierte el repsupuesto
                         IF (v_codigo_estado = 'borrador' or v_codigo_estado = 'vbpresupuestos') and v_comprometido = 'si' and   v_tipo_obligacion !='adquisiciones' and   v_tipo_obligacion !='pago_especial' and   v_pre_integrar_presupuestos = 'true'  THEN
                         
                             --se revierte el presupeusto
                             IF not tes.f_gestionar_presupuesto_tesoreria(v_parametros.id_obligacion_pago, p_id_usuario, 'revertir')  THEN
                                 
                                   raise exception 'Error al revertir el presupeusto';
                                 
                             END IF;
                            
                            --se modifica la bandera del comprometido
                            update tes.tobligacion_pago op set
                              comprometido = 'no'
                            where id_obligacion_pago = v_parametros.id_obligacion_pago;                         
                         
                         END IF;
                         
                         
                          IF v_codigo_estado = 'borrador' THEN
                          
                              --se modifica la bandera del comprometido
                              update tes.tobligacion_pago op set
                                 total_pago=NULL
                              where id_obligacion_pago = v_parametros.id_obligacion_pago;
                              
                              --jrr: llamamos a la funcion que revierte de planillas en caso de que sea de recursos humanos
                              if (v_tipo_obligacion = 'rrhh') then
                                  IF NOT plani.f_anular_obligacion_tesoreria(p_id_usuario,v_parametros._id_usuario_ai,
                                            v_parametros._nombre_usuario_ai,v_parametros.id_obligacion_pago,v_obs) THEN                                                         
                                       raise exception 'Error al anular la obligacion';                          
                                    END IF;            	
                              end if; 
                         
                          END IF;
                          
                          
                        -- si hay mas de un estado disponible  preguntamos al usuario
                        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo el cambio de estado)'); 
                        v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
                        
                              
                      --Devuelve la respuesta
                        return v_resp;
                        
        
         
         
           ELSEIF  v_parametros.operacion = 'inicio' THEN
              raise exception 'Operacion no implementada';
            
           ELSE
              
                   raise exception 'Operacion no implementada';   
           END IF; 
           
      		          
			
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Retrocede estado de la obligacion'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    /*********************************    
 	#TRANSACCION:  'TES_PAFPP_IME'
 	#DESCRIPCION:	Calcula el restante por registrar, devengar o pagar  segun filtro
 	#AUTOR:		admin	
 	#FECHA:		10-04-2013 15:43:23
	***********************************/

	elsif(p_transaccion='TES_PAFPP_IME')then

		begin
			
            v_ope_filtro = regexp_split_to_array(v_parametros.ope_filtro,',');
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','determina cuanto falta por pgar'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
            
            v_sw = TRUE;
            
            
           
            
            
            FOR v_ind IN array_lower(v_ope_filtro, 1) .. array_upper(v_ope_filtro, 1)
            LOOP
                v_monto_total= tes.f_determinar_total_faltante(v_parametros.id_obligacion_pago, v_ope_filtro[v_ind], v_parametros.id_plan_pago);
              
              IF v_sw THEN
                v_resp = pxp.f_agrega_clave(v_resp,'monto_total_faltante',v_monto_total::varchar);
                v_sw = FALSE;
              ELSE
                v_resp = pxp.f_agrega_clave(v_resp,v_ope_filtro[v_ind],v_monto_total::varchar);
              END IF;
              
            END LOOP;
            
          
              
            --Devuelve la respuesta
            return v_resp;

		end;   
	 /*********************************    
 	#TRANSACCION:  'TES_OBEPUO_IME'
 	#DESCRIPCION:	Obtener listado de up y ep correspondientes a los centros de costo
                    del detalle de la obligacion de pago 
                    
 	#AUTOR:	        Rensi Arteaga Copari
 	#FECHA:		    1-4-2013 14:48:35
	***********************************/

	elsif(p_transaccion='TES_OBEPUO_IME')then

		begin
			
         
        
            select 
              pxp.list(cc.id_uo::text),
              pxp.list(cc.id_ep::text)
            into
              v_cad_uo,
              v_cad_ep
            from tes.tobligacion_det  od
            inner join param.tcentro_costo cc on od.id_centro_costo = cc.id_centro_costo
            where od.id_obligacion_pago = v_parametros.id_obligacion_pago 
            and od.estado_reg = 'activo';
        
           
             --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','UOs, EPs retornados'); 
            v_resp = pxp.f_agrega_clave(v_resp,'eps',v_cad_ep::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'uos',v_cad_uo::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'TES_IDSEXT_GET'
 	#DESCRIPCION:	Devuelve los IDS de otros sistemas (adquisiciones, etc.) a partir de la obligacion de pago
 	#AUTOR:			RCM	
 	#FECHA:			02-04-2013 16:01:32
	***********************************/

	elsif(p_transaccion='TES_IDSEXT_GET')then

		begin
		
			--1.Verificar existencia de la obligación de pago
			if not exists(select 1 from tes.tobligacion_pago
						where id_obligacion_pago = v_parametros.id_obligacion_pago) then
				raise exception 'Obligación de pago inexistente';
			end if;
			
			--2.Condicional por sistema
			if v_parametros.sistema = 'ADQ' then
			
				--2.1 Obtiene los IDS: id_cotizacion, id_proceso_compra, id_solicitud
				select
				cot.id_cotizacion, cot.id_proceso_compra, pro.id_solicitud
				into v_registros
				from adq.tcotizacion cot
				inner join adq.tproceso_compra pro on pro.id_proceso_compra = cot.id_proceso_compra
				where cot.id_obligacion_pago = v_parametros.id_obligacion_pago;
				
				
				--2.2 Respuesta por sistema
				v_resp = pxp.f_agrega_clave(v_resp,'mensaje','IDs obtenidos');
				v_resp = pxp.f_agrega_clave(v_resp,'id_cotizacion',v_registros.id_cotizacion::varchar);
				v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_compra',v_registros.id_proceso_compra::varchar);
				v_resp = pxp.f_agrega_clave(v_resp,'id_solicitud',v_registros.id_solicitud::varchar);
			
			
			elsif v_parametros.sistema = 'TES' then
				--(17/12/2013)TODO implementar cuando corresponda
				raise exception 'Funcionalidad no implementada para el sistema %',v_parametros.sistema;
				
				--2.1 Obtiene los IDS
				--2.2 Respuesta por sistema
				v_resp = pxp.f_agrega_clave(v_resp,'mensaje','IDs obtenidos');
			
			
			elsif v_parametros.sistema = 'CONTA' then
				--(17/12/2013)TODO implementar si corresponde
				raise exception 'Funcionalidad no implementada para el sistema %',v_parametros.sistema;
				
				--2.1 Obtiene los IDS
				--2.2 Respuesta por sistema
				v_resp = pxp.f_agrega_clave(v_resp,'mensaje','IDs obtenidos');
			
			
			else
				raise exception 'Sistema no reconocido';
			end if;

			--3.Respuesta
			return v_resp;

		end;
   
   /*********************************    
 	#TRANSACCION:  'TES_OBLAJUS_IME'
 	#DESCRIPCION:	Inserta ajustes en la obligacion de pagos variables, segun el tipo ajustes para anticipos totales o resevar paga anticipos a aplicar la siguiente gestion
 	#AUTOR:	    Rensi Arteaga Copari (KPLIAN) 
 	#FECHA:		23-10-2014 16:01:32
	***********************************/

	elsif(p_transaccion='TES_OBLAJUS_IME')then

		begin
			select 
            op.estado,
            op.pago_variable,
            op.monto_estimado_sg,
            op.id_obligacion_pago_extendida
            into
            v_registros
            from tes.tobligacion_pago op
            where op.id_obligacion_pago = v_parametros.id_obligacion_pago;
        
          IF v_parametros.tipo_ajuste = 'ajuste' THEN 
                
                
                
                IF v_registros.pago_variable = 'no' THEN
                  raise exception 'Solo puede insertar ajustes en pagos variables';
                END IF;
                
                IF v_registros.estado != 'en_pago' THEN
                  raise exception 'Solo puede insertar ajustes cuando la obligacion este en estado: en_pago';
                END IF;
                
                
                --Sentencia de la modificacion
                update tes.tobligacion_pago  set
                ajuste_aplicado = v_parametros.ajuste_aplicado,
                ajuste_anticipo = v_parametros.ajuste_anticipo,
                id_usuario_mod = p_id_usuario,
                fecha_mod = now()
                where id_obligacion_pago=v_parametros.id_obligacion_pago;
                   
                --Definicion de la respuesta
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se insertaron ajustes a la obligacion de pago'); 
                v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
                   
                
          ELSE
          
                --revision de anticipo
                IF v_registros.id_obligacion_pago_extendida is not NULL THEN
                  raise exception 'No puede modificar para obligaciones extendidas';
                END IF;
                
                IF v_registros.estado   in ('finalizado','anulado') THEN
                  raise exception 'No puede modificar en obligaciones finalizadas o anuladas';
                END IF;
                
                --suma los montos a ejecutar y anticipar antes de la edicion
               IF  v_parametros.monto_estimado_sg  < 0 THEN
                     raise exception 'El monto de ampliación no puede ser menor que cero';
               END IF;
          
                
                
                --  Sentencia de la modificacion
                update tes.tobligacion_pago  set
                monto_estimado_sg = v_parametros.monto_estimado_sg,
                id_usuario_mod = p_id_usuario,
                fecha_mod = now()
                where id_obligacion_pago=v_parametros.id_obligacion_pago;
                   
                --Definicion de la respuesta
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se cambio el monto  previsto para llevar al gasto la siguiente gestion (anticipos)'); 
                v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
           
          
          
          END IF;
          
          --Devuelve la respuesta
          return v_resp;
            
		end;     
   /*********************************    
 	#TRANSACCION:  'TES_EXTOP_IME'
 	#DESCRIPCION:  Extiende la obligacion de pago para la gestion siguiente	
 	#AUTOR:	    Rensi Arteaga Copari (KPLIAN) 
 	#FECHA:		31-10-2014 16:01:32
	***********************************/

	elsif(p_transaccion='TES_EXTOP_IME')then

		begin
        
            --------------------------------------
            -- verificar que no este extendida
            --------------------------------------
            
            Select 
            *
            into
            v_registros
            from tes.tobligacion_pago op
            where op.id_obligacion_pago = v_parametros.id_obligacion_pago;
            
            --validar que el estado de la obligacion sea finaliza
            IF v_registros.estado not in ('finalizado') THEN
               raise exception 'No se permiten obligaciones de pago que no esten finalizadas';
            END IF;
            
            --validar que no tenga extenciones
            IF v_registros.id_obligacion_pago_extendida is not null THEN
              raise exception 'la obligacion de pago ya fue extendida';
            END IF;
            
           ------------------------------
           -- copiar obligacion de pago
           ------------------------------
           
            v_date = now()::Date;
            v_anho = (date_part('year', v_registros.fecha))::integer;
            v_anho = v_anho  + 1;
            
            IF (v_anho||'-1-1')::date > v_date THEN
               v_date = (v_anho::varchar||'-1-1')::Date;
            END  IF;
            
           
            v_hstore_registros =   hstore(ARRAY[
                                             'fecha',v_date::varchar,
                                             'tipo_obligacion', 'pago_directo',
                                             'id_funcionario',v_registros.id_funcionario::varchar,
                                             '_id_usuario_ai',v_parametros._id_usuario_ai::varchar,
                                             '_nombre_usuario_ai',v_parametros._nombre_usuario_ai::varchar,
                                             'id_depto',v_registros.id_depto::varchar,
                                             'obs','Extiende el tramite: '||v_registros.num_tramite||',  Obs:  '||v_registros.obs,
                                             'id_proveedor',v_registros.id_proveedor::varchar,
                                             'tipo_obligacion',v_registros.tipo_obligacion::varchar,
                                             'id_moneda',v_registros.id_moneda::varchar,
                                             'tipo_cambio_conv',v_registros.tipo_cambio_conv::varchar,
                                             'pago_variable',v_registros.pago_variable::varchar,
                                             'total_nro_cuota',v_registros.total_nro_cuota::varchar,
                                             'fecha_pp_ini',v_registros.fecha_pp_ini::varchar,
                                             'rotacion',v_registros.rotacion::varchar,
                                             'id_plantilla',v_registros.id_plantilla::varchar,
                                             'tipo_anticipo',v_registros.tipo_anticipo::varchar
                                            ]);
            
            
             v_resp = tes.f_inserta_obligacion_pago(p_administrador, p_id_usuario, hstore(v_hstore_registros));
             v_id_obligacion_pago_sg =  pxp.f_recupera_clave(v_resp, 'id_obligacion_pago');
             v_id_gestion_sg =  pxp.f_recupera_clave(v_resp, 'id_gestion');

           

             --------------------------------------------------------------------------------------------
             -- copiar detalle de obligacion , verifican la tabla id_presupuestos_ids si existe se copia...
             ------------------------------------------------------------------------------------------------
              FOR  v_registros_det in (
                                      SELECT
                                          od.id_obligacion_det,
                                          od.id_concepto_ingas,
                                          od.id_centro_costo,
                                          od.id_partida,
                                          od.descripcion,
                                          od.monto_pago_mo ,
                                          od.id_orden_trabajo,
                                          od.monto_pago_mb
                                        FROM  tes.tobligacion_det od 
                                        where  od.estado_reg = 'activo' and 
                                               od.id_obligacion_pago = v_parametros.id_obligacion_pago) LOOP
                   
                   
                    --recueprar centro de cotos para la siguiente gestion  (los centro de cosots y presupeustos tiene los mismo IDS)
                    
                      
                      select   
                        pi.id_presupuesto_dos
                      into
                        v_id_centro_costo_dos
                      from pre.tpresupuesto_ids pi
                      where pi.id_presupuesto_uno = v_registros_det.id_centro_costo;
                      
                      IF v_id_centro_costo_dos is not NULL THEN
                             
                              SELECT 
                                  ps_id_partida 
                                into 
                                  v_id_partida 
                              FROM conta.f_get_config_relacion_contable('CUECOMP', v_id_gestion_sg[1]::integer, v_registros_det.id_concepto_ingas, v_id_centro_costo_dos);
                              
                                                           
                              --Sentencia de la insercion
                              insert into tes.tobligacion_det(
                                estado_reg,
                                --id_cuenta,
                                id_partida,
                                --id_auxiliar,
                                id_concepto_ingas,
                                monto_pago_mo,
                                id_obligacion_pago,
                                id_centro_costo,
                                monto_pago_mb,
                                descripcion,
                                fecha_reg,
                                id_usuario_reg,
                                fecha_mod,
                                id_usuario_mod,
                                id_orden_trabajo
                              ) 
                              values
                              (
                                'activo',
                                --v_parametros.id_cuenta,
                                v_id_partida,
                                --v_parametros.id_auxiliar,
                                v_registros_det.id_concepto_ingas,
                                v_registros_det.monto_pago_mo,
                                v_id_obligacion_pago_sg[1]::integer,
                                v_id_centro_costo_dos,
                                v_registros_det.monto_pago_mb,
                                v_registros_det.descripcion,		
                                now(),
                                p_id_usuario,
                                null,
                                null,
                                v_registros_det.id_orden_trabajo
                  							
                              )RETURNING id_obligacion_det into v_id_obligacion_det;
                              
                      END IF;         
                         
              END LOOP;
              
            --actualiza obligacion extendida en la original  
            
            update tes.tobligacion_pago set  
                id_obligacion_pago_extendida = v_id_obligacion_pago_sg[1]::integer,
                id_usuario_mod = p_id_usuario,
                fecha_mod = now() 
            where id_obligacion_pago = v_parametros.id_obligacion_pago;
             
            -- Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se extendio la obligacion de pago a la siguiente gestion'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
           
          
          --Devuelve la respuesta
          return v_resp;
            
		end;  
    /*********************************    
 	#TRANSACCION:  'TES_REVPARPRE_IME'
 	#DESCRIPCION:	Revierte el presupeusto parcialmente
 	#AUTOR:		RAC - KPLIAN	
 	#FECHA:		10-04-2013 15:43:23
	***********************************/

	elsif(p_transaccion='TES_REVPARPRE_IME')then

		begin
        
           v_pre_integrar_presupuestos = pxp.f_get_variable_global('pre_integrar_presupuestos');
		    
            select 
               op.id_obligacion_pago,
               op.id_moneda,
               op.estado,
               op.fecha
            into
               v_registros_op
            from tes.tobligacion_pago op
            where op.id_obligacion_pago = v_parametros.id_obligacion_pago;
          
            IF v_registros_op.estado = 'finalizado' THEN
               raise exception 'no puede modificar el presupuesto de obligaciones finalizadas';
            END IF;
            
            --validar que no tenga comprobantes  pendientes sin validar
            IF exists( select 1
                      from tes.tplan_pago pp 
                      where pp.id_obligacion_pago  = v_parametros.id_obligacion_pago and pp.estado_reg ='activo' and pp.estado = 'pendiente') THEN
            
                 raise exception 'Tiene algun comprobnate pendiente de valiación, eliminelo o validaelo antes de volver a intentar';
            
             END IF;
        
            
            
            -- la fecha de solictud es la fecha de compromiso 
            IF  now()  < v_registros_op.fecha THEN
                v_fecha = v_registros_op.fecha::date;
            ELSE
                 -- la fecha de reversion como maximo puede ser el 31 de diciembre   
                 v_fecha = now()::date;
                 v_ano_1 =  EXTRACT(YEAR FROM  now()::date);
                 v_ano_2 =  EXTRACT(YEAR FROM  v_registros_op.fecha::date);
                       
                 IF  v_ano_1  >  v_ano_2 THEN
                   v_fecha = ('31-12-'|| v_ano_2::varchar)::date;
                 END IF;
            END IF;  
            
            va_id_obligacion_det_tmp =  string_to_array(v_parametros.id_ob_dets::text,',')::integer[];
            va_revertir = string_to_array(v_parametros.revertir::text,',')::numeric[];
            v_tam = array_length(va_id_obligacion_det_tmp, 1);
           
            v_i = 1;
            FOR v_registros in (
                            SELECT  od.id_obligacion_det,
                                    od.id_centro_costo,
                                    od.id_partida_ejecucion_com,
                                    od.id_partida,
                                    p.id_presupuesto
                            FROM  tes.tobligacion_det od 
                            INNER JOIN pre.tpresupuesto   p  on p.id_centro_costo = od.id_centro_costo
                            WHERE od.id_obligacion_det = ANY(va_id_obligacion_det_tmp)
                         ) LOOP
                
              
                va_id_presupuesto[v_i] = v_registros.id_presupuesto;
                va_id_partida[v_i] = v_registros.id_partida;
                va_momento[v_i]	= 2; --el momento 2 con signo negativo  es revertir
                va_id_moneda[v_i]  = v_registros_op.id_moneda;
                
              
                va_id_partida_ejecucion[v_i] = v_registros.id_partida_ejecucion_com;
                va_columna_relacion[v_i] = 'id_obligacion_pago';
                va_fk_llave[v_i] = v_registros_op.id_obligacion_pago;
                va_fecha[v_i] = v_fecha ;
                va_id_obligacion_det[v_i] = v_registros.id_obligacion_det;
                v_indice = v_i;
                
                FOR v_j IN 1..v_tam LOOP
                   IF v_registros.id_obligacion_det = va_id_obligacion_det_tmp[v_j] THEN
                       v_indice = v_j;
                       v_j = v_tam + 1;
                   END IF;
                END LOOP;
                
                va_monto[v_i]  = va_revertir[v_indice]*-1; 
                
                v_i = v_i + 1;
                
          END LOOP;
           
          
          
          --si se integra con presupuestos
          IF v_pre_integrar_presupuestos = 'true' THEN  
           
            va_resp_ges =  pre.f_gestionar_presupuesto(  va_id_presupuesto, 
                                                         va_id_partida, 
                                                         va_id_moneda, 
                                                         va_monto, 
                                                         va_fecha, --p_fecha
                                                         va_momento, 
                                                         va_id_partida_ejecucion,--  p_id_partida_ejecucion 
                                                         va_columna_relacion, 
                                                         va_fk_llave,
                                                         NULL
                                                         );	
            
          END IF;
            -- Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se extendio la obligacion de pago a la siguiente gestion'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
           
            
            --Devuelve la respuesta
            return v_resp;

		end;
        
    /*********************************    
 	#TRANSACCION:  'TES_OBSPRE_MOD'
 	#DESCRIPCION:	Modificar las observaciones de presupeustos
                    
 	#AUTOR:	        Rensi Arteaga Copari
 	#FECHA:		    1-4-2015 14:48:35
	***********************************/

	elsif(p_transaccion='TES_OBSPRE_MOD')then

		begin
			
         
             update tes.tobligacion_pago set  
              obs_presupuestos = v_parametros.obs
             where id_obligacion_pago = v_parametros.id_obligacion_pago;
           
             --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','UOs, EPs retornados'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
            
              
            --Devuelve la respuesta
            return v_resp;

		end; 
     /*********************************    
 	#TRANSACCION:  'TES_OBSPOA_MOD'
 	#DESCRIPCION:	Modificar las observaciones del área de POA
                    
 	#AUTOR:	        Rensi Arteaga Copari
 	#FECHA:		    1-4-2015 14:48:35
	***********************************/

	elsif(p_transaccion='TES_OBSPOA_MOD')then

		begin
			
         
             update tes.tobligacion_pago set  
              obs_poa = v_parametros.obs_poa,
              codigo_poa = v_parametros.codigo_poa
             where id_obligacion_pago = v_parametros.id_obligacion_pago;
           
             --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Obs poa en obligaciones de pago'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
            
              
            --Devuelve la respuesta
            return v_resp;

		end;     
    
     /*********************************    
 	#TRANSACCION:  'TES_GETFILOP_IME'
 	#DESCRIPCION:	Recupera datos delproveedor, OT , tramite y conceptos de gasto  de la obligacion
    #AUTOR:	        Rensi Arteaga Copari
 	#FECHA:		    29-08-2015 14:48:35
	***********************************/

	elsif(p_transaccion='TES_GETFILOP_IME')then

		begin
			
        
           --recupera datos de la OP y proveedor
           select
             op.id_proveedor,
              pr.desc_proveedor,
              op.num_tramite
           into
             v_registros_op  
           from tes.tobligacion_pago op
           inner join param.vproveedor pr on pr.id_proveedor = op.id_proveedor
           where op.id_obligacion_pago = v_parametros.id_obligacion_pago;
           
                      
           --recupera datos del detalle ots y conceptos
           select
              pxp.list(od.id_orden_trabajo::varchar) as id_orden_trabajos,
              pxp.list(od.id_concepto_ingas::varchar) as id_concepto_ingas
           into
             v_registros
           from tes.tobligacion_det od 
           where od.id_obligacion_pago = v_parametros.id_obligacion_pago and od.estado_reg = 'activo';
           
           
             
             --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','recupera datos de la obligacion'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor',v_registros_op.id_proveedor::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'num_tramite',v_registros_op.num_tramite::varchar);
            
            
            v_resp = pxp.f_agrega_clave(v_resp,'desc_proveedor',v_registros_op.desc_proveedor::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'id_orden_trabajos',v_registros.id_orden_trabajos::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas',v_registros.id_concepto_ingas::varchar);
            
              
            --Devuelve la respuesta
            return v_resp;

		end;     
          
    
    else      
    
    raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
        v_resp = pxp.f_agrega_clave(v_resp,'foo','barr');
        v_resp = pxp.f_agrega_clave(v_resp,'preguntar',v_preguntar);
        
		raise exception '%',v_resp;
				        
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;