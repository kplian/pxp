<?php
/**
 *@package pXP
 *@file gen-Certificado.php
 *@author  (MMV)
 *@date 24-07-2017 14:48:34
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Certificado=Ext.extend(Phx.gridInterfaz,{

            constructor:function(config){
                this.maestro=config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.Certificado.superclass.constructor.call(this,config);
                this.init();
                this.ocultarComponente(this.Cmp.importe_viatico);
                //this.inicarEvento();
                this.load({params:{start:0, limit:this.tam_pag}});
                this.addButton('ant_estado',{
                    grupo: [2],//2
                    argument: {estado: 'anterior'},
                    text: 'Anterior',
                    iconCls: 'batras',
                    disabled: true,
                    handler: this.antEstado,
                    tooltip: '<b>Volver al Anterior Estado</b>'
                });

                this.addButton('sig_estado',{
                    grupo: [0],//2
                    text:'Siguiente',
                    iconCls: 'badelante',
                    disabled:true,
                    handler:this.sigEstado,
                    tooltip: '<b>Pasar al Siguiente Estado</b>'
                });
                this.addButton('btnImprimir',
                    {   grupo:[7],
                        text: 'Imprimir',
                        iconCls: 'bpdf32',
                        disabled: true,
                        handler: this.imprimirNota,
                        tooltip: '<b>Imprimir Certificado de Trabajo</b><br/>Certificado De Trabajo'
                    }
                );
                this.addButton('btnChequeoDocumentosWf',{
                    text: 'Documentos',
                    grupo: [0,1,2,3,4,5,6,7],
                    iconCls: 'bchecklist',
                    disabled: true,
                    handler: this.loadCheckDocumentosRecWf,
                    tooltip: '<b>Documentos del Reclamo</b><br/>Subir los documetos requeridos en el Reclamo seleccionado.'
                });
                this.addButton('diagrama_gantt',{
                    grupo:[0,1,2,3,4,5,6,7],
                    text:'Gant',
                    iconCls: 'bgantt',
                    disabled:true,
                    handler:diagramGantt,
                    tooltip: '<b>Diagrama Gantt de proceso macro</b>'
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
            Grupos: [
                {
                    layout: 'column',
                    border: false,
                    defaults: {
                        border: false
                    },

                    items: [
                        {
                            bodyStyle: 'padding-right:10px;',
                            items: [

                                {
                                    xtype: 'fieldset',
                                    title: 'Datos Generales',
                                    autoHeight: true,
                                    width: 600,
                                    items: [/*this.compositeFields()*/],
                                    id_grupo: 0
                                }

                            ]
                        }

                    ]
                }],

            Atributos:[
                {
                    //configuracion del componente
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_certificado_planilla'
                    },
                    type:'Field',
                    form:true
                },
                {
                    config:{
                        name: 'impreso',
                        fieldLabel: 'Impreso',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 80,
                        maxLength:100,
                        renderer: function (value,p,record) {
                            var result;
                            if(value == "si") {
                            result = "<div style='text-align:center'><img src = '../../../lib/imagenes/icono_inc/inc_printer.png' align='center' width='28' height='28' title='impreso'/></div>";
                            }else{
                                result = "<div style='text-align:center'><img src = '../../../lib/imagenes/icono_inc/inc_pdf.png' align='center' width='28' height='28' title='impreso'/></div>";

                            }
                            return result;
                        }
                    },
                    type:'TextField',
                    filters:{pfiltro:'planc.impreso',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false

                },
                {
                    config:{
                        name: 'nro_tramite',
                        fieldLabel: 'Nro. Tramite',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 150,
                        maxLength:100
                    },
                    type:'TextField',
                    filters:{pfiltro:'planc.nro_tramite',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false

                },
                {
                    config:{
                        name:'tipo_certificado',
                        fieldLabel:'Tipo de Certificado',
                        typeAhead: true,
                        allowBlank:false,
                        triggerAction: 'all',
                        emptyText:'Tipo...',
                        selectOnFocus:true,
                        mode:'local',
                        store:new Ext.data.ArrayStore({
                            fields: ['ID', 'valor'],
                            data :	[
                                ['1','General'],
                                ['2','Con viáticos de los últimos tres meses']
                            ]
                        }),
                        valueField:'valor',
                        displayField:'valor',
                        gwidth:150,
                        anchor: '60%'

                    },
                    type:'ComboBox',
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'estado',
                        //name: 'estado',
                        fieldLabel: 'Estado',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:100

                    },
                    type:'TextField',
                    filters:{pfiltro:'planc.nombre_estado',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false

                },
                {
                    config:{
                        name: 'fecha_solicitud',
                        fieldLabel: 'Fecha Solicitud',
                        allowBlank: false,
                        anchor: '60%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
                    },
                    type:'DateField',
                    filters:{pfiltro:'planc.fecha_solicitud',type:'date'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config: {
                        name: 'id_funcionario',
                        fieldLabel: 'Solicitante',
                        allowBlank: false,
                        emptyText: 'Elija una opción...',
                        qtip:'Funcionario que registra el Reclamo en el ERP, se rellena por Defecto.',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_organigrama/control/Funcionario/listarFuncionarioCargo',
                            id: 'id_funcionario',
                            root: 'datos',
                            sortInfo: {
                                field: 'desc_funcionario1',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_funcionario','desc_funcionario1','email_empresa','nombre_cargo','lugar_nombre','oficina_nombre'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'FUNCAR.desc_funcionario1'}//#FUNCAR.nombre_cargo
                        }),
                        valueField: 'id_funcionario',
                        displayField: 'desc_funcionario1',
                        gdisplayField: 'desc_funcionario1',//corregit materiaesl
                        tpl:'<tpl for="."><div class="x-combo-list-item" style="color: black"><p><b>{desc_funcionario1}</b></p><p style="color: #80251e">{nombre_cargo}<br>{email_empresa}</p><p style="color:green">{oficina_nombre} - {lugar_nombre}</p></div></tpl>',
                        hiddenName: 'id_funcionario',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 20,
                        queryDelay: 1000,
                        anchor: '60%',
                        width: 260,
                        gwidth: 250,
                        minChars: 2,
                        resizable:true,
                        listWidth:'240',
                        renderer: function (value, p, record) {
                            return String.format('{0}', record.data['desc_funcionario1']);
                        }
                    },
                    type: 'ComboBox',
                    bottom_filter:true,
                    id_grupo:1,
                    filters:{
                        pfiltro:'fun.desc_funcionario1',
                        type:'string'
                    },
                    grid: true,
                    form: true
                },
                {
                    config:{
                        name: 'nombre_cargo',
                        fieldLabel: 'Cargo',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 150,
                        maxLength:100
                    },
                    type:'TextField',
                    filters:{pfiltro:'fun.nombre_cargo',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false

                },
                {
                    config:{
                        name: 'ci',
                        fieldLabel: 'CI',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 80,
                        maxLength:100
                    },
                    type:'TextField',
                    filters:{pfiltro:'fun.ci',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false

                },
                {
                    config:{
                        name: 'expedicion',
                        fieldLabel: 'Exp.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 50,
                        maxLength:100
                    },
                    type:'TextField',
                    filters:{pfiltro:'pe.expedicion',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false

                },
                {
                    config: {
                        name: 'haber_basico',
                        fieldLabel: 'Remuneración',
                        currencyChar: ' ',
                        allowBlank: true,
                        width: 100,
                        gwidth: 90,
                        disabled: true,
                        maxLength: 1245186
                    },
                    type: 'MoneyField',
                    filters: {pfiltro: 'es.haber_basico', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'importe_viatico',
                        fieldLabel: 'Importe Viatico',
                        currencyChar: ' ',
                        allowBlank: true,
                        width: 100,
                        gwidth: 90,
                        disabled: true,
                        maxLength: 1245186
                    },
                    type: 'MoneyField',
                    filters: {pfiltro: 'planc.importe_viatico', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config:{
                        name: 'estado_reg',
                        fieldLabel: 'Estado Reg.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:10
                    },
                    type:'TextField',
                    filters:{pfiltro:'planc.estado_reg',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false
                },
                {
                    config:{
                        name: 'id_usuario_ai',
                        fieldLabel: '',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:4
                    },
                    type:'Field',
                    filters:{pfiltro:'planc.id_usuario_ai',type:'numeric'},
                    id_grupo:1,
                    grid:false,
                    form:false
                },
                {
                    config:{
                        name: 'fecha_reg',
                        fieldLabel: 'Fecha creación',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
                    },
                    type:'DateField',
                    filters:{pfiltro:'planc.fecha_reg',type:'date'},
                    id_grupo:1,
                    grid:true,
                    form:false
                },
                {
                    config:{
                        name: 'usuario_ai',
                        fieldLabel: 'Funcionaro AI',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:300
                    },
                    type:'TextField',
                    filters:{pfiltro:'planc.usuario_ai',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false
                },
                {
                    config:{
                        name: 'usr_reg',
                        fieldLabel: 'Creado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:4
                    },
                    type:'Field',
                    filters:{pfiltro:'usu1.cuenta',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false
                },
                {
                    config:{
                        name: 'fecha_mod',
                        fieldLabel: 'Fecha Modif.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
                    },
                    type:'DateField',
                    filters:{pfiltro:'planc.fecha_mod',type:'date'},
                    id_grupo:1,
                    grid:true,
                    form:false
                },
                {
                    config:{
                        name: 'usr_mod',
                        fieldLabel: 'Modificado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:4
                    },
                    type:'Field',
                    filters:{pfiltro:'usu2.cuenta',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false
                }
            ],
            tam_pag:50,
            title:'Certificado Planilla',
            ActSave:'../../sis_organigrama/control/CertificadoPlanilla/insertarCertificadoPlanilla',
            ActDel:'../../sis_organigrama/control/CertificadoPlanilla/eliminarCertificadoPlanilla',
            ActList:'../../sis_organigrama/control/CertificadoPlanilla/listarCertificadoPlanilla',
            id_store:'id_certificado_planilla',
            fields: [
                {name:'id_certificado_planilla', type: 'numeric'},
                {name:'tipo_certificado', type: 'string'},
                {name:'fecha_solicitud', type: 'date',dateFormat:'Y-m-d'},
                {name:'beneficiario', type: 'string'},
                {name:'id_funcionario', type: 'numeric'},
                {name:'estado_reg', type: 'string'},
                {name:'importe_viatico', type: 'numeric'},
                {name:'id_usuario_ai', type: 'numeric'},
                {name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
                {name:'usuario_ai', type: 'string'},
                {name:'id_usuario_reg', type: 'numeric'},
                {name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
                {name:'id_usuario_mod', type: 'numeric'},
                {name:'usr_reg', type: 'string'},
                {name:'usr_mod', type: 'string'},
                {name:'desc_funcionario1', type: 'string'},
                {name:'nro_tramite', type: 'string'},
                {name:'estado', type: 'string'},
                {name:'id_proceso_wf', type: 'numeric'},
                {name:'id_estado_wf', type: 'numeric'},
                {name:'nombre_cargo', type: 'string'},
                {name:'ci', type: 'string'},
                {name:'haber_basico', type: 'numeric'},
                {name:'expedicion', type: 'string'} ,
                {name:'impreso', type: 'string'}

            ],
            sortInfo:{
                field: 'nro_tramite',
                direction: 'DESC'
            },
            bdel:true,
            bsave:false,
            preparaMenu: function(n)
            {	var rec = this.getSelectedData();
                var tb =this.tbar;

                this.getBoton('btnChequeoDocumentosWf').setDisabled(false);
                Phx.vista.Certificado.superclass.preparaMenu.call(this,n);
                this.getBoton('diagrama_gantt').enable();
                this.getBoton('sig_estado').enable();
                this.getBoton('ant_estado').enable();
                //this.getBoton('ant_estado').setVisible(false);
            },

            liberaMenu:function(){
                var tb = Phx.vista.Certificado.superclass.liberaMenu.call(this);
                if(tb){
                    this.getBoton('ant_estado').disable();
                    this.getBoton('sig_estado').disable();
                    this.getBoton('btnChequeoDocumentosWf').setDisabled(true);
                    this.getBoton('diagrama_gantt').disable();
                    //this.getBoton('btnImprimir').setVisible(false);
                    /// this.getBoton('ant_estado').setVisible(false);
                }
                return tb
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
            sigEstado: function() {
                var rec = this.sm.getSelected();

                this.objWizard = Phx.CP.loadWindows('../../../sis_workflow/vista/estado_wf/FormEstadoWf.php',
                    'Estado de Wf',
                    {
                        modal: true,
                        width: 700,
                        height: 450
                    },
                    {
                        data: {
                            id_estado_wf: rec.data.id_estado_wf,
                            id_proceso_wf: rec.data.id_proceso_wf
                        }
                    }, this.idContenedor, 'FormEstadoWf',
                    {
                        config: [{
                            event: 'beforesave',
                            delegate: this.onSaveWizard
                        }],
                        scope: this
                    }
                );
            },

            onSaveWizard:function(wizard,resp){
                var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                Phx.CP.loadingShow();
                Ext.Ajax.request({
                    url:'../../sis_organigrama/control/CertificadoPlanilla/siguienteEstado',
                    params:{
                        id_proceso_wf_act:  resp.id_proceso_wf_act,
                        id_estado_wf_act:   resp.id_estado_wf_act,
                        id_tipo_estado:     resp.id_tipo_estado,
                        id_funcionario_wf:  resp.id_funcionario_wf,
                        id_depto_wf:        resp.id_depto_wf,
                        obs:                resp.obs,
                        json_procesos:      Ext.util.JSON.encode(resp.procesos)
                    },
                    success:function (resp) {
                        Phx.CP.loadingHide();
                        resp.argument.wizard.panel.destroy();
                        this.reload();
                    },
                    failure: this.conexionFailure,
                    argument:{wizard:wizard},
                    timeout:this.timeout,
                    scope:this
                });
            },
            antEstado:function(res){
                var rec=this.sm.getSelected();
                Phx.CP.loadWindows('../../../sis_workflow/vista/estado_wf/AntFormEstadoWf.php',
                    'Estado de Wf',
                    {
                        modal:true,
                        width:450,
                        height:250
                    }, { data:rec.data, estado_destino: res.argument.estado }, this.idContenedor,'AntFormEstadoWf',
                    {
                        config:[{
                            event:'beforesave',
                            delegate: this.onAntEstado
                        }
                        ],
                        scope:this
                    })
            },

            onAntEstado: function(wizard,resp){
                Phx.CP.loadingShow();
                Ext.Ajax.request({
                    url:'../../sis_organigrama/control/CertificadoPlanilla/anteriorEstado',
                    params:{
                        id_proceso_wf: resp.id_proceso_wf,
                        id_estado_wf:  resp.id_estado_wf,
                        obs: resp.obs,
                        estado_destino: resp.estado_destino
                    },
                    argument:{wizard:wizard},
                    success:function (resp) {
                        Phx.CP.loadingHide();
                        resp.argument.wizard.panel.destroy();
                        this.reload();
                    },
                    failure: this.conexionFailure,
                    timeout:this.timeout,
                    scope:this
                });
            },
            inicarEvento:function(){
                this.Cmp.tipo_certificado.on('select',function(combo, record, index){
                    this.Cmp.importe_viatico.reset();
                    if (record.data.ID == 1 ){
                        this.ocultarComponente(this.Cmp.importe_viatico);
                    }if (record.data.ID == 2){
                        this.mostrarComponente(this.Cmp.importe_viatico);
                    }


                },this);


            }

        }
    )
</script>

