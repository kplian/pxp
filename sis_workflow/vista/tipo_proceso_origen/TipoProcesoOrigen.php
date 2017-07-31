<?php
/**
*@package pXP
*@file gen-TipoProcesoOrigen.php
*@author  (admin)
*@date 09-06-2014 17:03:47
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoProcesoOrigen=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoProcesoOrigen.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();
		var dataPadre = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData()
        if(dataPadre){
         this.onEnablePanel(this, dataPadre);
        }
        else
        {
           this.bloquearMenus();
        }
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_proceso_origin'
			},
			type:'Field',
			form:true 
		},
		{
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_tipo_proceso'
            },
            type:'Field',
            form:true 
        },
        {
            config: {
                name: 'id_proceso_macro',
                fieldLabel: 'Proceso',
                typeAhead: false,
                forceSelection: true,
                allowBlank: false,
                emptyText: 'Proceso Macro...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_workflow/control/ProcesoMacro/listarProcesoMacro',
                    id: 'id_proceso_macro',
                    root: 'datos',
                    sortInfo: {
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_proceso_macro', 'nombre', 'codigo'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'promac.nombre#promac.codigo'}
                }),
                valueField: 'id_proceso_macro',
                displayField: 'nombre',
                gdisplayField: 'desc_proceso_macro',
                
              
                 triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '80%',
                listWidth:'280',
                resizable:true,
                minChars: 2,
               tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Codigo: <strong>{codigo}</strong> </div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {pfiltro: 'pm.nombre',type: 'string'},
            grid: true,
            form: true
        },
		
		
		
		{
            config: {
                name: 'id_tipo_estado',
                fieldLabel: 'Tipo Estado',
                typeAhead: false,
                forceSelection: false,
                allowBlank: true,
                emptyText: 'Lista de tipos estados...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_workflow/control/TipoEstado/listarTipoEstado',
                    id: 'id_tipo_estado',
                    root: 'datos',
                    sortInfo: {
                        field: 'nombre_estado',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_tipo_estado', 'nombre_estado', 'inicio','codigo','disparador','fin','desc_tipo_proceso'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'tipes.nombre_estado#tipes.inicio',disparador:'si'}
                }),
                valueField: 'id_tipo_estado',
                displayField: 'nombre_estado',
                gdisplayField: 'desc_tipo_estado',
                triggerAction: 'all',
                lazyRender: true,
                disabled:true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '80%',
                minChars: 2,
                gwidth: 200,
                renderer: function(value, p, record) {
                    return String.format('{0}, {1}', record.data['desc_tipo_estado'], record.data['desc_tipo_proceso']);
                },
                tpl: '<tpl for="."><div class="x-combo-list-item"><p>({codigo})- {nombre_estado}</p>Inicio: <strong>{inicio}</strong>, Fin: <strong>{fin} <p>Tipo Proceso: {desc_tipo_proceso}</p></strong> </div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'te.nombre_estado',
                type: 'string'
            },
            grid: true,
            form: true
        },
        {
            config:{
                name: 'tipo_disparo',
                fieldLabel: 'Tipo disparo',
                qtip:'Opcional: el susario escoge si se dispara o no,  Obigatorio: siempre se dispara, Bandeja de espera:   El proceso se dispara manualmente atrave de otra interface  , Manual: el programador realize el proceso manualmente',
                allowBlank: true,
                anchor: '40%',
                gwidth: 80,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                store:['opcional','obligatorio','bandeja_espera','manual']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{   pfiltro:'tpo.tipo_disparo',
                        type: 'list',
                        //dataIndex: 'size',
                        options: ['opcional','obligatorio','bandeja_espera','manual'],  
                    },
            grid:true,
            form:true
        },
		{
			config:{
				name: 'funcion_validacion_wf',
				fieldLabel: 'Fun Val Dis',
				qtip:'Si se define, verifica si se lanza o no el proceso (La funcion tiene que retorna TRUE o FALSE)',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
				type:'TextField',
				filters:{pfiltro:'tpo.funcion_validacion_wf',type:'string'},
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
				filters:{pfiltro:'tpo.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'tpo.fecha_reg',type:'date'},
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
				filters:{pfiltro:'tpo.fecha_mod',type:'date'},
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
                filters:{pfiltro:'tpo.id_usuario_ai',type:'numeric'},
                id_grupo:1,
                grid:false,
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
                filters:{pfiltro:'tpo.usuario_ai',type:'string'},
                id_grupo:1,
                grid:true,
                form:false
        }
	],
	tam_pag:50,	
	title:'Origenes',
	ActSave:'../../sis_workflow/control/TipoProcesoOrigen/insertarTipoProcesoOrigen',
	ActDel:'../../sis_workflow/control/TipoProcesoOrigen/eliminarTipoProcesoOrigen',
	ActList:'../../sis_workflow/control/TipoProcesoOrigen/listarTipoProcesoOrigen',
	id_store:'id_tipo_proceso_origin',
	fields: [
		{name:'id_tipo_proceso_origin', type: 'numeric'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'id_tipo_estado', type: 'numeric'},
		{name:'id_proceso_macro', type: 'numeric'},
		{name:'funcion_validacion_wf', type: 'string'},
		{name:'tipo_disparo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_proceso_macro','desc_tipo_estado','desc_tipo_proceso'
		
	],
	sortInfo:{
		field: 'id_tipo_proceso_origin',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	iniciarEventos:function(){
	    
	    this.Cmp.id_proceso_macro.on('select',function(){
	        
	        this.Cmp.id_tipo_estado.enable();
	        this.Cmp.id_tipo_estado.reset();
	        this.Cmp.id_tipo_estado.store.baseParams.id_proceso_macro=this.Cmp.id_proceso_macro.getValue();
            this.Cmp.id_tipo_estado.modificado=true;
	        
	        
	    },this);
	    
	    
	},
    onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_tipo_proceso:this.maestro.id_tipo_proceso};
        this.load({params:{start:0, limit:50}})
    },
    loadValoresIniciales:function()
    {
        Phx.vista.TipoProcesoOrigen.superclass.loadValoresIniciales.call(this);
        this.Cmp.id_tipo_proceso.setValue(this.maestro.id_tipo_proceso);     
    },
})
</script>
		
		