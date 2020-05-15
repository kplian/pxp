<?php
/****************************************************************************************
*@package pXP
*@file GrupoIdioma.php
*@author  (admin)
*@date 21-04-2020 02:29:46
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema

HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                21-04-2020 02:29:46    admin            Creacion    
 #   

*******************************************************************************************/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.GrupoIdioma=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.GrupoIdioma.superclass.constructor.call(this,config);
        this.init();
        this.addButton('exp_menu',{text:'Exportar SQL',iconCls: 'blist', handler: this.expProceso, disabled:true,tooltip: '<b>Permite exportar los datos de traducción del grupo seleccionado</b>'});
        this.load({params:{start:0, limit:this.tam_pag}})
    },
            
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_grupo_idioma'
            },
            type:'Field',
            form:true 
        },
        {
            config:{
                name: 'codigo',
                fieldLabel: 'Codigo',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
            	maxLength:200
            },
                type:'TextField',
                filters:{pfiltro:'gri.codigo',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'nombre',
                fieldLabel: 'Nombre',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
            	maxLength:200
            },
                type:'TextField',
                filters:{pfiltro:'gri.nombre',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'tipo',
                fieldLabel: 'Tipo',
                allowBlank: false,
                qtip:'Común , para traducciones comunes / Almacenado, para traducir datos almacenados ( se tiene que definir la tabla)',
                anchor: '40%',
                gwidth: 50,
                maxLength: 10,                               
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                valueField: 'defecto',  
                store: ['comun','almacenado']
            },
            type:'ComboBox',
            id_grupo:1,
            filters: {    
                        type: 'list',
                        pfiltro:'gri.defecto',
                        options: ['comun','almacenado'],    
                    },
            grid:true,
            form:true
        },
        {
            config:{
                name: 'nombre_tabla',
                fieldLabel: 'Tabla/Vista',
                qtip: 'hace referencia a la tabla que se va traducir',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:200
            },
                type:'TextField',
                filters:{pfiltro:'gri.nombre_tabla',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'columna_llave',
                fieldLabel: 'Columna Llave',
                qtip: 'nombre de la columna que se usara como llave',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:200
            },
                type:'TextField',
                filters:{pfiltro:'gri.columna_llave',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'columna_texto_defecto',
                fieldLabel: 'Columna Texto Defecto',
                qtip: 'nombre de la columna con el texto por defecto en tabla o vista referida en la columna nombre_tabla',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:200
            },
                type:'TextField',
                filters:{pfiltro:'gri.columna_texto_defecto',type:'string'},
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
                filters:{pfiltro:'gri.estado_reg',type:'string'},
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
                filters:{pfiltro:'gri.id_usuario_ai',type:'numeric'},
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
                name: 'usuario_ai',
                fieldLabel: 'Funcionaro AI',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:300
            },
                type:'TextField',
                filters:{pfiltro:'gri.usuario_ai',type:'string'},
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
                filters:{pfiltro:'gri.fecha_reg',type:'date'},
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
                filters:{pfiltro:'gri.fecha_mod',type:'date'},
                id_grupo:1,
                grid:true,
                form:false
		}
    ],
    tam_pag:50,    
    title:'Grupo de Idioma',
    ActSave:'../../sis_parametros/control/GrupoIdioma/insertarGrupoIdioma',
    ActDel:'../../sis_parametros/control/GrupoIdioma/eliminarGrupoIdioma',
    ActList:'../../sis_parametros/control/GrupoIdioma/listarGrupoIdioma',
    id_store:'id_grupo_idioma',
    fields: [
		{name:'id_grupo_idioma', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre_tabla', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
        
    ],
    sortInfo:{
        field: 'id_grupo_idioma',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true,
    preparaMenu:function(tb){
		this.getBoton('exp_menu').enable();
		Phx.vista.GrupoIdioma.superclass.preparaMenu.call(this,tb)
		return tb
	},
	 
	liberaMenu:function(tb){
		this.getBoton('exp_menu').disable();
		Phx.vista.GrupoIdioma.superclass.liberaMenu.call(this,tb)
		return tb
	},

    expProceso : function(resp){
			var data=this.sm.getSelected().data.id_grupo_idioma;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url:'../../sis_parametros/control/GrupoIdioma/exportarDatosGrupo',
				params:{'id_grupo_idioma' : data},
				success: this.successExport,
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});
			
	},
});
</script>
        
        