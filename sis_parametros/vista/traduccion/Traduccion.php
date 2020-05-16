<?php
/****************************************************************************************
*@package pXP
*@file gen-Traduccion.php
*@author  (RAC)
*@date 21-04-2020 03:41:52
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema

HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
#133                21-04-2020 03:41:52    RAC            Creacion    
*******************************************************************************************/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Traduccion=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.Traduccion.superclass.constructor.call(this,config);
        this.init();
        this.bloquearMenus();
    },
            
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_traduccion'
            },
            type:'Field',
            form:true 
        },
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_palabra_clave'
            },
            type:'Field',
            form:true 
        },
        {
            config: {
                name: 'id_lenguaje',
                fieldLabel: 'Lenguaje',
                allowBlank: false,
                emptyText: 'Elija una opción...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Lenguaje/listarLenguaje',
                    id: 'id_lenguaje',
                    root: 'datos',
                    sortInfo: {
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_lenguaje', 'nombre', 'codigo'],
                    remoteSort: true,
                    baseParams: {par_filtro: 'len.nombre#len.codigo'}
                }),
                valueField: 'id_lenguaje',
                displayField: 'nombre',
                gdisplayField: 'desc_lenguaje',
                hiddenName: 'id_lenguaje',
                forceSelection: true,
                typeAhead: false,
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 15,
                queryDelay: 1000,
                anchor: '100%',
                gwidth: 150,
                minChars: 2
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {pfiltro: 'len.nombre#len.codigo',type: 'string'},
            grid: true,
            form: true
        },        
        {
            config:{
                name: 'texto',
                fieldLabel: 'Texto Traducido',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
            	maxLength:500
            },
                type:'TextField',
                filters:{pfiltro:'tra.texto',type:'string'},
                bottom_filter:true,
                id_grupo:1,
                grid:true,
                form:true
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
                filters:{pfiltro:'tra.estado_reg',type:'string'},
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
                filters:{pfiltro:'tra.id_usuario_ai',type:'numeric'},
                id_grupo:1,
                grid:false,
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
                name: 'fecha_reg',
                fieldLabel: 'Fecha creación',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                            format: 'd/m/Y', 
                            renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
            },
                type:'DateField',
                filters:{pfiltro:'tra.fecha_reg',type:'date'},
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
                filters:{pfiltro:'tra.usuario_ai',type:'string'},
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
                filters:{pfiltro:'tra.fecha_mod',type:'date'},
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
    onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_palabra_clave: this.maestro.id_palabra_clave};
		this.load({params:{start:0, limit:50}})
		
	},
	loadValoresIniciales:function(){
		Phx.vista.Traduccion.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_palabra_clave').setValue(this.maestro.id_palabra_clave);		
	},
    tam_pag:50,    
    title:'Traducciones',
    ActSave:'../../sis_parametros/control/Traduccion/insertarTraduccion',
    ActDel:'../../sis_parametros/control/Traduccion/eliminarTraduccion',
    ActList:'../../sis_parametros/control/Traduccion/listarTraduccion',
    id_store:'id_traduccion',
    fields: [
		{name:'id_traduccion', type: 'numeric'},
		{name:'id_lenguaje', type: 'numeric'},
		{name:'id_palabra_clave', type: 'numeric'},
		{name:'texto', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_lenguaje'
        
    ],
    sortInfo:{
        field: 'id_traduccion',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true
    }
)
</script>
        
        