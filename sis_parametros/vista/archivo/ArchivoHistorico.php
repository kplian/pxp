<?php
/**
 *@package pXP
 *@file gen-ArchivoHistorico.php
 *@author  (admin)
 *@date 05-12-2016 15:04:48
 *@description ArchivoHistorico con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.ArchivoHistorico=Ext.extend(Phx.gridInterfaz,{

            constructor:function(config){
                this.maestro=config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.ArchivoHistorico.superclass.constructor.call(this,config);



                this.grid.addListener('cellclick', this.oncellclick,this);



                this.init();
                //this.load({params:{start:0, limit:this.tam_pag}})
            },

            Atributos:[
                {
                    //configuracion del componente
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_archivo'
                    },
                    type:'Field',
                    form:true
                },

                {
                    config:{
                        name: 'ver',
                        fieldLabel: 'Doc. Digital',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 65,
                        scope: this,
                        renderer:function (value, p, record, rowIndex, colIndex){

                            if(record.data.id_archivo != null){
                                return "<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Abrir Documento' src = '../../../lib/imagenes/icono_awesome/awe_print_good.png' align='center' width='30' height='30'></div>";

                            }else{
                                return  String.format('{0}',"<div style='text-align:center'><img title='Documento No Escaneado' src = '../../../lib/imagenes/icono_awesome/awe_wrong.png' align='center' width='30' height='30'/></div>");

                            }

                        },
                    },
                    type:'Checkbox',
                    filters:{pfiltro:'arch.ver',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:false
                },


                {
                    config:{
                        name: 'nombre',
                        fieldLabel: 'Nombre',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:255
                    },
                    type:'TextField',
                    filters:{pfiltro:'tipar.nombre',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'tabla',
                        fieldLabel: 'tabla',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:255
                    },
                    type:'TextField',
                    filters:{pfiltro:'arch.tabla',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },



                {
                    config:{
                        name: 'folder',
                        fieldLabel: 'folder',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:255
                    },
                    type:'TextField',
                    filters:{pfiltro:'arch.folder',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'extension',
                        fieldLabel: 'extension',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:255
                    },
                    type:'TextField',
                    filters:{pfiltro:'arch.extension',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'id_tabla',
                        fieldLabel: 'id_tabla',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:255
                    },
                    type:'TextField',
                    filters:{pfiltro:'arch.id_tabla',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },

                {
                    config:{
                        name: 'nombre_archivo',
                        fieldLabel: 'nombre_archivo',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:255
                    },
                    type:'TextField',
                    filters:{pfiltro:'arch.nombre_archivo',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },



                {
                    config: {
                        name: 'id_tipo_archivo',
                        fieldLabel: 'id_tipo_archivo',
                        allowBlank: false,
                        emptyText: 'Elija una opción...',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_/control/Clase/Metodo',
                            id: 'id_',
                            root: 'datos',
                            sortInfo: {
                                field: 'nombre',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_', 'nombre', 'codigo'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'movtip.nombre#movtip.codigo'}
                        }),
                        valueField: 'id_',
                        displayField: 'nombre',
                        gdisplayField: 'desc_',
                        hiddenName: 'id_tipo_archivo',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '100%',
                        gwidth: 150,
                        minChars: 2,
                        renderer : function(value, p, record) {
                            return String.format('{0}', record.data['desc_']);
                        }
                    },
                    type: 'ComboBox',
                    id_grupo: 0,
                    filters: {pfiltro: 'movtip.nombre',type: 'string'},
                    grid: true,
                    form: true
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
                    filters:{pfiltro:'arch.fecha_reg',type:'date'},
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
                    filters:{pfiltro:'arch.usuario_ai',type:'string'},
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
                        name: 'id_usuario_ai',
                        fieldLabel: 'Creado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:4
                    },
                    type:'Field',
                    filters:{pfiltro:'arch.id_usuario_ai',type:'numeric'},
                    id_grupo:1,
                    grid:false,
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
                    filters:{pfiltro:'arch.estado_reg',type:'string'},
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
                    filters:{pfiltro:'arch.fecha_mod',type:'date'},
                    id_grupo:1,
                    grid:true,
                    form:false
                }
            ],
            tam_pag:50,
            title:'ArchivoHistorico',
            ActSave:'../../sis_parametros/control/Archivo/insertarArchivoHistorico',
            ActDel:'../../sis_parametros/control/Archivo/eliminarArchivoHistorico',
            ActList:'../../sis_parametros/control/Archivo/listarArchivoHistorico',
            id_store:'id_archivo',
            fields: [
                {name:'id_archivo', type: 'numeric'},
                {name:'estado_reg', type: 'string'},
                {name:'folder', type: 'string'},
                {name:'extension', type: 'string'},
                {name:'id_tabla', type: 'numeric'},
                {name:'nombre_archivo', type: 'string'},
                {name:'id_tipo_archivo', type: 'numeric'},
                {name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
                {name:'usuario_ai', type: 'string'},
                {name:'id_usuario_reg', type: 'numeric'},
                {name:'id_usuario_ai', type: 'numeric'},
                {name:'id_usuario_mod', type: 'numeric'},
                {name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
                {name:'usr_reg', type: 'string'},
                {name:'usr_mod', type: 'string'},
                {name:'tabla', type: 'string'},
                {name:'nombre', type: 'string'},
                {name:'codigo', type: 'string'},

            ],
            sortInfo:{
                field: 'id_tipo_archivo',
                direction: 'ASC'
            },
            bdel:false,
            bsave:false,
            bnew:false,
            bedit:false,

            preparaMenu: function (tb) {
                // llamada funcion clace padre
                Phx.vista.ArchivoHistorico.superclass.preparaMenu.call(this, tb)
            },
            onButtonNew: function () {
                Phx.vista.ArchivoHistorico.superclass.onButtonNew.call(this);
                this.getComponente('id_archivo').setValue(this.maestro.id_archivo);
            },
            onReloadPage: function (m) {
                this.maestro = m;
                console.log(this.maestro);

                if(this.maestro.id_archivo != null){
                    this.store.baseParams = {id_archivo: this.maestro.id_archivo};
                    this.load({params: {start: 0, limit: 50}})
                }

            },


        oncellclick : function(grid, rowIndex, columnIndex, e) {

            var record = this.store.getAt(rowIndex),
                fieldName = grid.getColumnModel().getDataIndex(columnIndex); // Get field name

            console.log('record seleccionado ',record);

            if (fieldName == 'upload') {
                //if (record.data.solo_lectura == 'no' &&  !record.data.id_proceso_wf_ori) {
                this.subirArchivo(record);
                //}
            }else if (fieldName == 'ver') {
                if (record.data['extension'].length != 0) {
                    window.open( record.data.folder+"/"+record.data.nombre_archivo+"."+record.data.extension);
                } else {
                    alert('No se ha subido ningun archivo para este documento');
                }
            }



        },



        }
    )
</script>

