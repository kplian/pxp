<?php
/**
 *@package pXP
 *@file gen-FieldTipoArchivoValor.php
 *@author  (admin)
 *@date 18-10-2017 14:28:34
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.FieldTipoArchivoValor=Ext.extend(Phx.gridInterfaz,{

            constructor:function(config){
                this.maestro=config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.FieldTipoArchivoValor.superclass.constructor.call(this,config);
                this.init();
                //this.load({params:{start:0, limit:this.tam_pag}})




            },

            Atributos:[
                {
                    //configuracion del componente
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_field_tipo_archivo'
                    },
                    type:'Field',
                    form:true
                },
                {
                    //configuracion del componente
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_tipo_archivo'
                    },
                    type:'Field',
                    form:true
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
                    filters:{pfiltro:'fitiar.nombre',type:'string'},
                    id_grupo:1,
                    grid:false,
                    form:true
                },

                {
                    config:{
                        name: 'descripcion',
                        fieldLabel: 'Descripcion',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 230,
                        maxLength:255
                    },
                    type:'TextField',
                    filters:{pfiltro:'fitiar.descripcion',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true
                },

                {
                    config:{
                        name: 'valor',
                        fieldLabel: 'Valor',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 300,
                        maxLength:255,
                        renderer:function (value,p,record){


                            if(record.data.tipo == 'DateField' && value != ''){
                                var d = new Date(value);
                                value = d.getDate()+"/"+(d.getMonth()+1) +"/"+d.getFullYear();
                            }

                            if(record.data.tipo == 'TextArea' && value != ''){
                                p.css = 'multilineColumn';
                                return String.format('{0}', value);
                            }

                            return value;

                        }
                    },
                    type:'TextField',
                    filters:{pfiltro:'fitiar.valor',type:'string'},
                    id_grupo:1,
                    //egrid: true,
                    grid:true,
                    form:true
                },



                {
                    config: {
                        name: 'tipo',
                        fieldLabel: 'Tipo',
                        allowBlank: true,
                        emptyText: 'tipo...',
                        typeAhead: true,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'local',
                        store: ['TextField', 'ComboBox','DateField'],
                        width: 200
                    },
                    type: 'ComboBox',
                    filters: {pfiltro: 'fitiar.tipo', type: 'string'},
                    id_grupo: 1,
                    form: true,
                    grid: true
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
                    filters:{pfiltro:'fitiar.estado_reg',type:'string'},
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
                    filters:{pfiltro:'fitiar.usuario_ai',type:'string'},
                    id_grupo:1,
                    grid:true,
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
                    filters:{pfiltro:'fitiar.fecha_reg',type:'date'},
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
                    filters:{pfiltro:'fitiar.id_usuario_ai',type:'numeric'},
                    id_grupo:1,
                    grid:false,
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
                    filters:{pfiltro:'fitiar.fecha_mod',type:'date'},
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
            title:'Field Tipo Archivo',
            ActSave:'../../sis_parametros/control/FieldTipoArchivo/insertarFieldTipoArchivoValor',
            ActDel:'../../sis_parametros/control/FieldTipoArchivo/eliminarFieldTipoArchivoValor',
            ActList:'../../sis_parametros/control/FieldTipoArchivo/listarFieldTipoArchivoValor',
            id_store:'id_field_tipo_archivo',
            fields: [
                {name:'id_field_tipo_archivo', type: 'numeric'},
                {name:'id_tipo_archivo', type: 'numeric'},
                {name:'nombre', type: 'string'},
                {name:'descripcion', type: 'string'},
                {name:'tipo', type: 'string'},
                {name:'valor', type: 'string'},


            ],
            sortInfo:{
                field: 'id_field_tipo_archivo',
                direction: 'ASC'
            },
            bdel:false,
            bsave:false,
            bedit:false,
            bnew:false,
            //bact:false,
            //bexcel:false,
            //btest:false,

            preparaMenu: function (tb) {
                // llamada funcion clace padre
                Phx.vista.FieldTipoArchivoValor.superclass.preparaMenu.call(this, tb)

            },
            onButtonNew: function () {
                Phx.vista.FieldTipoArchivoValor.superclass.onButtonNew.call(this);

                this.getComponente('id_tipo_archivo').setValue(this.maestro.id_tipo_archivo);
            },
            onReloadPage: function (m) {
                this.maestro = m;
                console.log(this.maestro);


                if(this.maestro.id_archivo != null){
                    this.store.baseParams = {id_tipo_archivo: this.maestro.id_tipo_archivo,id_archivo: this.maestro.id_archivo};


                    this.load({params: {start: 0, limit: 50}})
                }
            },
        }
    )
</script>

		