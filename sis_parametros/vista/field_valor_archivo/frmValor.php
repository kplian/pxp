<?php
/**
 *@package pXP
 *@file gen-TipoSensor.php
 *@author  (favio figueroa)
 *@date 19-10-2017 10:27:35
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.frmValor=Ext.extend(Phx.frmInterfaz,{
            constructor:function(config){

                this.configMaestro=config;
                this.config=config;
                var id_tipo_archivo = config.data.id_tipo_archivo;
                var id_archivo = config.data.id_archivo;

                this.arra_ = [];
                //llama al constructor de la clase padre
                console.log('id_tipo_archivo',id_tipo_archivo)
                console.log('id_archivo',id_archivo)
                console.log('config',config)
                Phx.CP.loadingShow();
                this.storeAtributos= new Ext.data.JsonStore({
                    url:'../../sis_parametros/control/FieldTipoArchivo/listarFieldTipoArchivoValor',
                    id: 'id_field_tipo_archivo',
                    root: 'datos',
                    totalProperty: 'total',
                    fields: ['id_field_tipo_archivo','id_field_valor_archivo','id_tipo_archivo','id_archivo','nombre','descripcion','tipo','valor'],
                    sortInfo:{
                        field: 'id_field_tipo_archivo',
                        direction: 'ASC'
                    }});
                //evento de error
                this.storeAtributos.on('loadexception',this.conexionFailure);

                this.storeAtributos.load({
                    params: {
                        "sort": "id_field_tipo_archivo",
                        "dir": "ASC",
                        'id_tipo_archivo': config.data.id_tipo_archivo,
                        'id_archivo': config.data.id_archivo,
                        start: 0,
                        limit: 500
                    }, callback: this.successConstructor, scope: this
                })
            },


            successConstructor:function(rec,con,res){

                console.log('1');
                this.recColumnas = rec;
                this.Atributos=[];
                this.fields=[];
                this.id_store='id_item'
                console.log('2');
                this.sortInfo={
                    field: 'id_item',
                    direction: 'ASC'
                };
                this.fields.push(this.id_store)

                this.fields.push({name:'id_field_valor_archivo', type: 'string'});
                this.fields.push({name:'id_field_tipo_archivo', type: 'string'});
                this.fields.push({name:'id_tipo_archivo', type: 'string'});
                this.fields.push({name:'id_archivo', type: 'numeric'});
                console.log('3');
                if(res)
                {

                    /*this.Atributos[0]={
                     //configuracion del componente
                     config:{
                     labelSeparator:'',
                     inputType:'hidden',
                     name: 'id_field_valor_archivo'
                     },
                     type:'Field',
                     form:true
                     };
                     this.Atributos[1]={
                     //configuracion del componente
                     config:{
                     labelSeparator:'',
                     inputType:'hidden',
                     name: 'id_field_tipo_archivo'
                     },
                     type:'Field',
                     form:true
                     };
                     this.Atributos[2]={
                     //configuracion del componente
                     config:{
                     labelSeparator:'',
                     inputType:'hidden',
                     name: 'id_tipo_archivo'
                     },
                     type:'Field',
                     form:true
                     };
                     this.Atributos[3]={
                     //configuracion del componente
                     config:{
                     labelSeparator:'',
                     inputType:'hidden',
                     name: 'id_archivo'
                     },
                     type:'Field',
                     form:true
                     };*/


                    /*this.Atributos[1]={
                     config:{
                     name: 'nombre',
                     fieldLabel: 'nombre',
                     allowBlank: true,
                     anchor: '80%',
                     gwidth: 100,
                     maxLength:255
                     },
                     type:'TextField',
                     filters:{pfiltro:'item.nombre',type:'string'},
                     id_grupo:1,
                     grid:true,
                     form:true
                     };

                     this.Atributos[2]={
                     config:{
                     name: 'codigo',
                     fieldLabel: 'codigo',
                     allowBlank: true,
                     anchor: '80%',
                     gwidth: 100,
                     maxLength:255
                     },
                     type:'TextField',
                     filters:{pfiltro:'item.codigo',type:'string'},
                     id_grupo:1,
                     grid:true,
                     form:true
                     };

                     this.Atributos[3]={
                     config:{
                     name: 'precio_compra',
                     fieldLabel: 'precio_compra',
                     allowBlank: true,
                     anchor: '80%',
                     gwidth: 100,

                     },
                     type:'NumberField',
                     filters:{pfiltro:'item.precio_compra',type:'numeric'},
                     id_grupo:1,
                     grid:true,
                     form:true
                     };

                     this.Atributos[4]={
                     config:{
                     name: 'precio_venta',
                     fieldLabel: 'precio_venta',
                     allowBlank: true,
                     anchor: '80%',
                     gwidth: 100,

                     },
                     type:'NumberField',
                     filters:{pfiltro:'item.precio_venta',type:'numeric'},
                     id_grupo:1,
                     grid:true,
                     form:true
                     };

                     this.Atributos[5]={

                     config: {
                     name: 'id_marca',
                     fieldLabel: 'id_marca',
                     allowBlank: true,
                     emptyText: 'Elija una opción...',
                     store: new Ext.data.JsonStore({
                     url: '../../sis_mercado/control/Marca/listarMarca',
                     id: 'id_marca',
                     root: 'datos',
                     sortInfo: {
                     field: 'nombre',
                     direction: 'ASC'

                     },
                     totalProperty: 'total',
                     fields: ['id_marca', 'nombre'],
                     remoteSort: true,
                     baseParams: {par_filtro: 'marc.nombre',tipo:'origen'}
                     }),
                     valueField: 'id_marca',
                     displayField: 'nombre',
                     gdisplayField: 'desc_marca',
                     hiddenName: 'id_marca',
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
                     return String.format('{0}', record.data['desc_marca']);
                     }
                     },
                     type: 'ComboBox',
                     id_grupo: 0,
                     filters: {pfiltro: 'marc.nombre',type: 'string'},
                     grid: true,
                     form: true

                     };*/



                    console.log('rec',rec);
                    var array_datos = new Array();

                    for (var i=0;i<rec.length;i++){

                        array_datos[rec[i].data.nombre] = new Object({
                            nombre:  rec[i].data.nombre,
                            id_field_valor_archivo:  rec[i].data.id_field_valor_archivo,
                            id_field_tipo_archivo:  rec[i].data.id_field_tipo_archivo,
                            tipo:rec[i].data.tipo,
                            valor:rec[i].data.valor,

                        });

                        console.log(array_datos);

                        console.log(Ext.encode(array_datos));
                        var json = Ext.encode(array_datos)


                        var codigo_col = rec[i].data.nombre;
                        this.fields.push(rec[i].data.nombre);

                        if( rec[i].data.tipo == 'COMBOBOX'){


                            var nombre_atributo = rec[i].data.nombre;
                            var id_combobox = rec[i].data.id_combobox;
                            console.log('nombre',nombre_atributo);


                        }else if( rec[i].data.tipo == 'DateField'){


                            this.Atributos.push({
                                config:{
                                    name: rec[i].data.nombre,
                                    fieldLabel: rec[i].data.descripcion,
                                    allowBlank: true,
                                    qtip: 'Fecha',
                                    anchor: '80%',
                                    gwidth: 100,
                                    format: 'd/m/Y',
                                    renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
                                },
                                type:'DateField',
                                id_grupo:1,
                                grid:false,
                                form:true
                            });

                        }else if( rec[i].data.tipo == 'TextArea'){


                            this.Atributos.push({
                                config:{
                                    name: rec[i].data.nombre,
                                    fieldLabel: rec[i].data.descripcion,
                                    qtip:'',
                                    allowBlank: false,
                                    anchor: '100%',
                                    gwidth: 100,
                                    width: 250,
                                    maxLength:500
                                },
                                type:'TextArea',

                                id_grupo:2,
                                grid:false,
                                form:true
                            });

                        }else if(rec[i].data.tipo == 'ComboBox'){

                            this.Atributos.push({
                                config : {
                                    name : rec[i].data.nombre,
                                    fieldLabel : rec[i].data.descripcion,
                                    anchor : '90%',
                                    tinit : false,
                                    allowBlank : true,
                                    origen : 'CATALOGO',
                                    gdisplayField : 'tipo',
                                    gwidth : 200,
                                    anchor : '100%',
                                    valueField: 'descripcion',
                                    baseParams : {
                                        cod_subsistema : 'PARAM',
                                        catalogo_tipo : rec[i].data.nombre
                                    }
                                },
                                type : 'ComboRec',
                                id_grupo : 0,
                                filters : {
                                    pfiltro : 'puve.tipo',
                                    type : 'string'
                                },
                                grid : true,
                                form : true
                            });

                        }else{

                            this.Atributos.push({config:{
                                name: rec[i].data.nombre,
                                fieldLabel: rec[i].data.descripcion,
                                allowBlank: true,
                                anchor: '80%',
                                gwidth: 100,

                            },
                                type:'Field',
                                filters:{pfiltro:rec[i].data.nombre,type:'string'},
                                id_grupo:1,
                                egrid:true,
                                grid:true,
                                form:true
                            });
                        }

                    }

                    Phx.CP.loadingHide();


                    Phx.vista.frmValor.superclass.constructor.call(this,this.config);

                    console.log('llegaa',this.Cmp);



                    this.arra_ = array_datos;


                    this.init();


                    var that = this;
                    this.Atributos.forEach(function (p1,index) {

                        console.log(array_datos[p1.config.name].valor)
                        if( array_datos[p1.config.name].valor != null){
                            if(array_datos[p1.config.name].tipo == 'DateField'){

                                that.Cmp[p1.config.name].setValue(new Date(array_datos[p1.config.name].valor))

                            }else{
                                that.Cmp[p1.config.name].setValue(array_datos[p1.config.name].valor)

                            }
                        }



                    });







                }

            },


            onSubmit: function () {

                //alert('asd');
                console.log('this.arra_', this.arra_);
                console.log('Atributos', this.Atributos);
                console.log('this.Cmp', this.Cmp);

                var that = this;
                var arra_aux = [];
                var Cmp = this.Cmp;
                var i = 0;
                this.Atributos.forEach(function (p1,index) {
                    console.log(index)
                    console.log(this.Cmp)
                    console.log(p1.config.name)
                    console.log(Cmp[p1.config.name].getValue());
                    arra_aux[index] = that.arra_[p1.config.name]
                    arra_aux[index].valor = Cmp[p1.config.name].getValue();

                });
                console.log(arra_aux);
                var json = Ext.encode(arra_aux)
                Ext.Ajax.request({
                    url:'../../sis_parametros/control/FieldValorArchivo/insertarFieldValorArchivoJson',
                    params:{id_archivo:this.config.data.id_archivo,json:json},
                    success: this.successSaveArchivoJson,
                    failure: this.conexionFailure,
                    timeout:this.timeout,
                    scope:this
                });




            },



            title:'Mediciones del Equipo',
            /*ActSave:'../../sis_mercado/control/Item/insertarfrmValor',
             ActDel:'../../sis_mercado/control/Item/eliminarItem',
             ActList:'../../sis_mercado/control/Item/listarfrmValor',*/
            bdel:true,
            bsave:true,
            bnew:true,
            bedit:true,



            onReloadPage:function(m)
            {
                this.maestro=m;
                this.limit = this.cmbLimit.getValue();
                this.store.baseParams={id_uni_cons:this.maestro.id_uni_cons};
                this.load({params:{start:0, limit:this.limit}});
            },
            successSaveArchivoJson:function () {
                var dataPadre = Phx.CP.getPagina(this.idContenedorPadre);
                /*if (dataPadre) {
                 this.onReloadPage(dataPadre)

                 }*/
                dataPadre.load({params:{start:0, limit:50,tabla:dataPadre.tabla_,id_tabla:dataPadre.id_}});
                console.log(dataPadre)
                this.close();
            }




        }
    )
</script>

