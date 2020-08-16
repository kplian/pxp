<?php
/**
 *@package pXP
 *@file    ReporteTipoCC.php
 *@author  Yamil Medina Rodriguez
 *@date    05-08-2020
 *@description Archivo con la interfaz para generaci�n de reporte

HISTORIAL DE MODIFICACIONES:
ISSUE            FECHA:          AUTOR       DESCRIPCION

 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Reporte_tipo_cc = Ext.extend(Phx.frmInterfaz, {

        Atributos : [

            {
                config:{
                    name:'id_tipo_cc',
                    qtip: 'Tipo de centro de costos, cada tipo solo puede tener un centro por gestión',
                    origen:'TIPOCC',
                    fieldLabel:'Tipo Centro de Costo',
                    gdisplayField: 'descripcion_tccp',
                    url:'../../sis_parametros/control/TipoCc/listarTipoCcAll',
                    baseParams: {movimiento:'no'} ,
                    allowBlank:true,
                    width:300,
                    gwidth:300,
                    renderer:function (value, p, record){return String.format('({0}) {1}', record.data['codigo_tccp'],  record.data['descripcion_tccp']);}

                },
                type:'ComboRec',
                id_grupo:0,
                filters:{pfiltro:'tccp.codigo#tccp.descripcion',type:'string'},
                grid:true,
                form:true
            },
            {
                config:{
                    name: 'fecha_ini',
                    fieldLabel: 'Fecha Inicio',
                    allowBlank: true,//#45
                    anchor: '100%', //#45
                    gwidth: 100,
                    format: 'd/m/Y',
                    renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
                },
                type:'DateField',
                filters:{pfiltro:'fecha_ini',type:'date'},
                id_grupo:1,
                grid:true,
                form:true
            },
            {
                config:{
                    name: 'fecha_fin',
                    fieldLabel: 'Fecha Fin',
                    allowBlank: true,//#45
                    anchor: '100%',//#45
                    gwidth: 100,
                    format: 'd/m/Y',
                    renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
                },
                type:'DateField',
                filters:{pfiltro:'fecha_fin',type:'date'},
                id_grupo:1,
                grid:true,
                form:true
            },
            {
                config:{
                    name:'formato_reporte',
                    fieldLabel:'Formato del Reporte',
                    typeAhead: true,
                    allowBlank:false,
                    triggerAction: 'all',
                    emptyText:'Formato...',
                    selectOnFocus:true,
                    mode:'local',
                    store:new Ext.data.ArrayStore({
                        fields: ['ID', 'valor'],
                        data :[ ['pdf','PDF'],
                            ['csv','CSV']]
                    }),
                    valueField:'ID',
                    displayField:'valor',
                    width:250,
                    anchor:'100%'
                },
                type:'ComboBox',
                id_grupo:1,
                form:true
            },

        ],


        //ActSave : '../../sis_contabilidad/control/TsLibroBancos/reporteLibroBancos',

        topBar : true,
        botones : false,
        labelSubmit : 'Generar',
        tooltipSubmit : '<b>Ejecución de proyecto</b>',

        constructor : function(config) {
            Phx.vista.Reporte_tipo_cc.superclass.constructor.call(this, config);
            this.init();
            this.mostrarComponente(this.Cmp.fecha_fin);
            this.mostrarComponente(this.Cmp.fecha_ini);
            this.iniciarEventos();
        },

        iniciarEventos:function(){
            this.mostrarComponente(this.Cmp.fecha_fin);
            this.mostrarComponente(this.Cmp.fecha_ini);
        },

        tipo : 'reporte',
        clsSubmit : 'bprint',

        Grupos : [{
            layout : 'column',
            items : [{
                xtype : 'fieldset',
                layout : 'form',
                border : true,
                title : 'Datos para el reporte',
                bodyStyle : 'padding:0 10px 0;',
                columnWidth : '500px',
                items : [],
                id_grupo : 0,
                collapsible : true
            }]
        }],

        ActSave:'../../sis_parametros/control/TipoCc/reporteTipoCc',
        successSave :function(resp){

            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if (reg.ROOT.error) {
                alert('error al procesar');
                return
            }
            var nomRep = reg.ROOT.detalle.archivo_generado;
            if(Phx.CP.config_ini.x==1){
                nomRep = Phx.CP.CRIPT.Encriptar(nomRep);
            }

            if(this.Cmp.formato_reporte.getValue()=='pdf'){
                window.open('../../../lib/lib_control/Intermediario.php?r='+nomRep+'&t='+new Date().toLocaleTimeString())
            }
            else{
                window.open('../../../reportes_generados/'+nomRep+'?t='+new Date().toLocaleTimeString())
            }

        }
    })
</script>