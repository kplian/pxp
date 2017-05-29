<?php
/**
 *@package pXP
 *@file gen-BitacotasProcesos.php
 *@author  (admin)
 *@date 21-03-2017 16:31:09
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.DetallleProceso=Ext.extend(Phx.gridInterfaz,{

            constructor:function(config){
                this.maestro=config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.DetallleProceso.superclass.constructor.call(this,config);
                this.grid.getTopToolbar().disable();
                this.grid.getBottomToolbar().disable();
                this.init();
                this.addButton('btnChequeoDocumentosWf',{
                    text: 'Documentos',
                    grupo: [0,1,2,3,4,5],
                    iconCls: 'bchecklist',
                    disabled: true,
                    handler: this.loadCheckDocumentosRecWf,
                    tooltip: '<b>Documentos del Reclamo</b><br/>Subir los documetos requeridos en el Reclamo seleccionado.'
                });
                this.addButton('diagrama_gantt',{
                    grupo:[0,1,2,3,4,5],
                    text:'Gant',
                    iconCls: 'bgantt',
                    disabled:true,
                    handler:diagramGantt,
                    tooltip: '<b>Diagrama Gantt de proceso macro</b>'
                });
                this.addButton('btnObs',{
                    grupo:[0,1,3,4,5],
                    text :'Obs Wf.',
                    iconCls : 'bchecklist',
                    disabled: true,
                    handler : this.onOpenObs,
                    tooltip : '<b>Observaciones</b><br/><b>Observaciones del WF</b>'
                });
                function diagramGantt(){
                    var data=this.sm.getSelected().data.id_proceso_wf;
                    Phx.CP.loadingShow();
                    Ext.Ajax.request({
                        url:'../../sis_workflow/control/ProcesoWf/diagramaGanttTramite',
                        params:{'id_proceso_wf':data},
                        success:this.successExport,
                        failure: this.conexionFailure,
                        timeout:this.timeout,
                        scope:this
                    });
                }

            },

            Atributos:[

                {
                    config:{
                        name: 'tipo_proceso',
                        fieldLabel: 'Tipo Proceso',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 200,
                        maxLength:200
                    },
                    type:'TextField',
                    filters:{pfiltro:'bts.tipo_proceso',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'nro_tramite',
                        fieldLabel: 'Nro. Tramite',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 150,
                        maxLength:-5
                    },
                    type:'TextField',
                    filters:{pfiltro:'bts.nro_tramite',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'nombre_completo1',
                        fieldLabel: 'Funcionario Solicitante ',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 200,
                        maxLength:150
                    },
                    type:'TextField',
                    filters:{pfiltro:'bts.nombre_completo1',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'nombre_estado',
                        fieldLabel: 'Estado Inicial',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 150,
                        maxLength:150
                    },
                    type:'TextField',
                    filters:{pfiltro:'bts.nombre_estado',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'estado_sig',
                        fieldLabel: 'Siguiente Estado',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 150,
                        maxLength:150
                    },
                    type:'TextField',
                    filters:{pfiltro:'bts.estado_sig',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },

                {
                    config:{
                        name: 'date_part',
                        fieldLabel: 'Dias',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:8
                    },
                    type:'TextField',
                    filters:{pfiltro:'bts.date_part',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },


                {
                    config:{
                        name: 'fecha_ini',
                        fieldLabel: 'Fecha Inicio',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer:function (value,p,record){return value?value.dateFormat('d/m/Y '):''}
                    },
                    type:'DateField',
                    filters:{pfiltro:'bts.fecha_ini',type:'date'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'fecha_fin',
                        fieldLabel: 'Fecha Fin',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer:function (value,p,record){return value?value.dateFormat('d/m/Y '):''}
                    },
                    type:'DateField',
                    filters:{pfiltro:'bts.fecha_fin',type:'date'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },

                {
                    config:{
                        name: 'proveido',
                        fieldLabel: 'Proveido',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 250,
                        maxLength:-5
                    },
                    type:'TextField',
                    filters:{pfiltro:'bts.proveido',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'proceso_wf',
                        fieldLabel: 'Proceso Wf',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 200,
                        maxLength:1000
                    },
                    type:'TextField',
                    filters:{pfiltro:'bts.proceso_wf',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                }

            ],
            tam_pag:150,
            title:'Bitacoras',
            ActSave:'../../sis_workflow/control/BitacorasProcesos/insertarBitacotasProcesos',
            ActDel:'../../sis_workflow/control/BitacorasProcesos/eliminarBitacotasProcesos',
            ActList:'../../sis_workflow/control/BitacorasProcesos/listarBitacotasProcesos',
            id_store:'id_proceso_wf',
            fields: [

                {name:'tipo_proceso', type: 'string'},
                {name:'date_part', type: 'string'},
                {name:'nombre_estado', type: 'string'},
                {name:'proceso_wf', type: 'string'},
                {name:'proveido', type: 'string'},
                {name:'fecha_fin', type: 'date'},
                {name:'fecha_ini', type: 'date'},
                {name:'nro_tramite', type: 'string'},
                {name:'id_proceso_wf', type: 'numeric'},
                {name:'id_estado_wf', type: 'numeric'},
                {name:'desc_funcionario1', type: 'string'},
                {name:'nombre_completo1', type: 'string'},
                {name:'id_tipo_proceso', type: 'numeric'},
                {name:'id_funcionario', type: 'numeric'},
                {name:'estado_sig', type: 'string'}


            ],
            sortInfo:{
                field: 'id_proceso_wf',
                direction: 'ASC'
            },
        loadValoresIniciales:function(){
            Phx.vista.DetallleProceso.superclass.loadValoresIniciales.call(this);
            //this.getComponente('id_int_comprobante').setValue(this.maestro.id_int_comprobante);
        },
        onReloadPage:function(param){
            //Se obtiene la gestión en función de la fecha del comprobante para filtrar partidas, cuentas, etc.
            var me = this;
            this.initFiltro(param);
        },

        initFiltro: function(param){
            this.store.baseParams=param;
            this.load( { params: { start:0, limit: this.tam_pag } });
        },
        loadCheckDocumentosRecWf:function() {
            var rec=this.sm.getSelected();
            rec.data.nombreVista = this.nombreVista;
            Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/DocumentoWf.php',
                'Chequear documento del WF',
                {
                    width:'90%',
                    height:500
                },
                rec.data,
                this.idContenedor,
                'DocumentoWf'
            )
        },
        onOpenObs:function() {
            var rec=this.sm.getSelected();
            var data = {
                id_proceso_wf: rec.data.id_proceso_wf,
                id_estado_wf: rec.data.id_estado_wf,
                num_tramite: rec.data.nro_tramite
            }
            Phx.CP.loadWindows('../../../sis_workflow/vista/obs/Obs.php',
                'Observaciones del WF',
                {
                    width:'80%',
                    height:'70%'
                },
                data,
                this.idContenedor,
                'Obs'
            )
        },
        preparaMenu: function(n)
        {	var rec = this.getSelectedData();
            var tb =this.tbar;
            this.getBoton('btnChequeoDocumentosWf').setDisabled(false);
            Phx.vista.DetallleProceso.superclass.preparaMenu.call(this,n);
            this.getBoton('diagrama_gantt').enable();
            this.getBoton('btnObs').enable();

        },

        liberaMenu:function(){
            var tb = Phx.vista.DetallleProceso.superclass.liberaMenu.call(this);
            if(tb){

                this.getBoton('btnChequeoDocumentosWf').setDisabled(true);
                this.getBoton('diagrama_gantt').disable();
                this.getBoton('btnObs').disable();

            }
            return tb
        },
            bdel:false,
            bsave:false,
            bedit:false,
            bnew:false
        }
    )
</script>

