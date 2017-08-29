CREATE OR REPLACE FUNCTION orga.ft_certificado_planilla_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_certificado_planilla_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tcertificado_planilla'
 AUTOR: 		 (miguel.mamani)
 FECHA:	        24-07-2017 14:48:34
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
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_certificado_planilla	integer;
    v_id_gestion			integer;
    v_nro_tramite			varchar;
   	v_id_proceso_wf			integer;
    v_id_estado_wf			integer;
    v_codigo_estado			varchar;
    v_codigo_tipo_proceso 	varchar;
    v_id_proceso_macro		integer;

    v_registo				record;
    v_acceso_directo		varchar;
    v_clase					varchar;
    v_parametros_ad			varchar;
    v_tipo_noti				varchar;
    v_titulo				varchar;
    v_id_tipo_estado		integer;
    v_pedir_obs				varchar;
    v_codigo_estado_siguiente varchar;
    v_obs					varchar;
    v_id_estado_actual			integer;
    v_id_depto					integer;
    v_operacion						varchar;
    v_registros_cer					record;
    v_id_funcionario integer;
    v_id_usuario_reg integer;
    v_id_estado_wf_ant	integer;

BEGIN

    v_nombre_funcion = 'orga.ft_certificado_planilla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'OR_PLANC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		24-07-2017 14:48:34
	***********************************/

	if(p_transaccion='OR_PLANC_INS')then

        begin

        --Gestion para WF
    	   SELECT g.id_gestion
           INTO v_id_gestion
           FROM param.tgestion g
           WHERE g.gestion = EXTRACT(YEAR FROM current_date);



            select    tp.codigo, pm.id_proceso_macro
           into v_codigo_tipo_proceso, v_id_proceso_macro
           from  wf.tproceso_macro pm
           inner join wf.ttipo_proceso tp on tp.id_proceso_macro = pm.id_proceso_macro
           where pm.codigo='CT' and tp.estado_reg = 'activo' and tp.inicio = 'si' ;

            SELECT
                 ps_num_tramite ,
                 ps_id_proceso_wf ,
                 ps_id_estado_wf ,
                 ps_codigo_estado
              into
                 v_nro_tramite,
                 v_id_proceso_wf,
                 v_id_estado_wf,
                 v_codigo_estado

            FROM wf.f_inicia_tramite(
                 p_id_usuario,
                 v_parametros._id_usuario_ai,
                 v_parametros._nombre_usuario_ai,
                 v_id_gestion,
                 v_codigo_tipo_proceso,
                 NULL,
                 NULL,
                 'Certificados de Trabajo',
                 v_codigo_tipo_proceso);



        	--Sentencia de la insercion
        	insert into orga.tcertificado_planilla(
			tipo_certificado,
			fecha_solicitud,
			id_funcionario,
			estado_reg,
			importe_viatico,
			id_usuario_ai,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            nro_tramite,
            estado,
            id_proceso_wf,
            id_estado_wf
          	) values(
			v_parametros.tipo_certificado,
			v_parametros.fecha_solicitud,
			v_parametros.id_funcionario,
			'activo',
			v_parametros.importe_viatico,
			v_parametros._id_usuario_ai,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			null,
			null,
            v_nro_tramite,
            v_codigo_estado,
            v_id_proceso_wf,
			v_id_estado_wf
			)RETURNING id_certificado_planilla into v_id_certificado_planilla;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Certificado Planilla almacenado(a) con exito (id_certificado_planilla'||v_id_certificado_planilla||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_certificado_planilla',v_id_certificado_planilla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'OR_PLANC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		24-07-2017 14:48:34
	***********************************/

	elsif(p_transaccion='OR_PLANC_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tcertificado_planilla set
			tipo_certificado = v_parametros.tipo_certificado,
			fecha_solicitud = v_parametros.fecha_solicitud,
			beneficiario = v_parametros.beneficiario,
			id_funcionario = v_parametros.id_funcionario,
			importe_viatico = v_parametros.importe_viatico,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_certificado_planilla=v_parametros.id_certificado_planilla;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Certificado Planilla modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_certificado_planilla',v_parametros.id_certificado_planilla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'OR_PLANC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		24-07-2017 14:48:34
	***********************************/

	elsif(p_transaccion='OR_PLANC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tcertificado_planilla
            where id_certificado_planilla=v_parametros.id_certificado_planilla;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Certificado Planilla eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_certificado_planilla',v_parametros.id_certificado_planilla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;
     /*********************************
 	#TRANSACCION:  'OR_SIGUE_EMI'
 	#DESCRIPCION:	Siguiente e
 	#AUTOR:		MMV
 	#FECHA:		06-06-2017 17:32:59
	***********************************/
    elseif(p_transaccion='OR_SIGUE_EMI') then
    	begin

          --recupera el registro de la CVPN
          select *
          into v_registo
          from orga.tcertificado_planilla
          where id_proceso_wf = v_parametros.id_proceso_wf_act;

          SELECT
            ew.id_tipo_estado ,
            te.pedir_obs,
            ew.id_estado_wf
           into
            v_id_tipo_estado,
            v_pedir_obs,
            v_id_estado_wf
          FROM wf.testado_wf ew
          INNER JOIN wf.ttipo_estado te ON te.id_tipo_estado = ew.id_tipo_estado
          WHERE ew.id_estado_wf =  v_parametros.id_estado_wf_act;

           -- obtener datos tipo estado siguiente
           select te.codigo into
             v_codigo_estado_siguiente
           from wf.ttipo_estado te
           where te.id_tipo_estado = v_parametros.id_tipo_estado;


           IF  pxp.f_existe_parametro(p_tabla,'id_depto_wf') THEN
           	 v_id_depto = v_parametros.id_depto_wf;
           END IF;

           IF  pxp.f_existe_parametro(p_tabla,'obs') THEN
           	 v_obs = v_parametros.obs;
           ELSE
           	 v_obs='---';
           END IF;

             --configurar acceso directo para la alarma
             v_acceso_directo = '';
             v_clase = '';
             v_parametros_ad = '';
             v_tipo_noti = 'notificacion';
             v_titulo  = 'Emetido';


             IF   v_codigo_estado_siguiente not in('borrador')   THEN

                  v_acceso_directo = '../../../sis_organigrama/vista/certificado_planilla/CertificadoPlanilla.php';
             	  v_clase = 'CertificadoPlanilla';
                  v_parametros_ad = '{filtro_directo:{campo:"cvpn.id_proceso_wf",valor:"'||v_parametros.id_proceso_wf_act::varchar||'"}}';
                  v_tipo_noti = 'notificacion';
                  v_titulo  = 'Notificacion';
             END IF;


             -- hay que recuperar el supervidor que seria el estado inmediato...
            	v_id_estado_actual =  wf.f_registra_estado_wf(v_parametros.id_tipo_estado,
                                                             v_parametros.id_funcionario_wf,
                                                             v_parametros.id_estado_wf_act,
                                                             v_parametros.id_proceso_wf_act,
                                                             p_id_usuario,
                                                             v_parametros._id_usuario_ai,
                                                             v_parametros._nombre_usuario_ai,
                                                             v_id_depto,
                                                             COALESCE(v_registo.nro_tramite,'--')||' Obs:'||v_obs,
                                                             v_acceso_directo ,
                                                             v_clase,
                                                             v_parametros_ad,
                                                             v_tipo_noti,
                                                             v_titulo);



         		IF orga.f_procesar_estados_certificado(p_id_usuario,
           									v_parametros._id_usuario_ai,
                                            v_parametros._nombre_usuario_ai,
                                            v_id_estado_actual,
                                            v_parametros.id_proceso_wf_act,
                                            v_codigo_estado_siguiente) THEN

         			RAISE NOTICE 'PASANDO DE ESTADO';

          		END IF;


          -- si hay mas de un estado disponible  preguntamos al usuario
          v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo el cambio de estado del Reclamo)');
          v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
          v_resp = pxp.f_agrega_clave(v_resp,'v_codigo_estado_siguiente',v_codigo_estado_siguiente);

          -- Devuelve la respuesta
          return v_resp;
        end;

    /*********************************
 	#TRANSACCION:  'OR_ANTE_IME'
 	#DESCRIPCION:	Anterior estado
 	#AUTOR:		MMV
 	#FECHA:		06-06-2017 17:32:59
	***********************************/
    elseif(p_transaccion='OR_ANTE_IME') then
    	begin

        	v_operacion = 'anterior';

            IF  pxp.f_existe_parametro(p_tabla , 'estado_destino')  THEN
               v_operacion = v_parametros.estado_destino;
            END IF;

            --obtenemos los datos del registro de solicitud VPN
            select
                tcv.id_certificado_planilla,
                tcv.id_proceso_wf,
                tcv.estado
            into v_registros_cer
            from orga.tcertificado_planilla  tcv
            inner  join wf.tproceso_wf pwf  on  pwf.id_proceso_wf = tcv.id_proceso_wf
            where tcv.id_proceso_wf  = v_parametros.id_proceso_wf;

            --v_id_proceso_wf = v_registros_cvpn.id_proceso_wf;


            IF  v_operacion = 'anterior' THEN
                --------------------------------------------------
                --Retrocede al estado inmediatamente anterior
                -------------------------------------------------
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
                  FROM wf.f_obtener_estado_ant_log_wf(v_parametros.id_estado_wf);

                  select
                    ew.id_proceso_wf
                  into
                    v_id_proceso_wf
                  from wf.testado_wf ew
                  where ew.id_estado_wf= v_id_estado_wf_ant;
            END IF;


			 v_acceso_directo = '../../../sis_organigrama/vista/certificado_planilla/CertificadoPlanilla.php';
             v_clase = 'CertificadoPlanilla';
             v_parametros_ad = '{filtro_directo:{campo:"cvpn.id_proceso_wf",valor:"'||v_id_proceso_wf::varchar||'"}}';
             v_tipo_noti = 'notificacion';
             v_titulo  = 'Visto Bueno';

              -- registra nuevo estado

              v_id_estado_actual = wf.f_registra_estado_wf(
                    v_id_tipo_estado,                --  id_tipo_estado al que retrocede
                    v_id_funcionario,                --  funcionario del estado anterior
                    v_parametros.id_estado_wf,       --  estado actual ...
                    v_id_proceso_wf,                 --  id del proceso actual
                    p_id_usuario,                    -- usuario que registra
                    v_parametros._id_usuario_ai,
                    v_parametros._nombre_usuario_ai,
                    v_id_depto,                       --depto del estado anterior
                    '[RETROCESO] '|| v_parametros.obs,
                    v_acceso_directo,
                    v_clase,
                    v_parametros_ad,
                    v_tipo_noti,
                    v_titulo);

                IF  not orga.f_ant_estado_certificado (p_id_usuario,
                                                       v_parametros._id_usuario_ai,
                                                       v_parametros._nombre_usuario_ai,
                                                       v_id_estado_actual,
                                                       v_parametros.id_proceso_wf,
                                                       v_codigo_estado) THEN

                   raise exception 'Error al retroceder estado';

                END IF;

                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo volvio al anterior estado)');
                v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');

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
		raise exception '%',v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;