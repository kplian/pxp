<?php
/**
*@package pXP
*@file gen-TipoDocumento.php
*@author  (admin)
*@date 14-01-2014 17:43:47
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoDocumento=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoDocumento.superclass.constructor.call(this,config);
		this.init();
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
					name: 'id_tipo_documento'
			},
			type:'Field',
			form:true 
		},
		
		{
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_proceso_macro'
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
            config:{
                name: 'codigo',
                fieldLabel: 'codigo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:25
            },
                type:'TextField',
                filters:{pfiltro:'tipdw.codigo',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
        },
		
		
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
				type:'TextField',
				filters:{pfiltro:'tipdw.nombre',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
				type:'TextArea',
				filters:{pfiltro:'tipdw.descripcion',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
        {
            config:{
                name: 'tipo',
                fieldLabel: 'Tipo ',
                allowBlank: false,
                anchor: '70%',
                gwidth: 150,
                maxLength:50,
                emptyText:'Tipo...',                
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                valueField: 'tipo_asignacion',                  
              store:['escaneado','generado']
            },
            type:'ComboBox',
            //filters:{pfiltro:'tipdw.tipo',type:'string'},
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'tipdw.tipo',
                         options: ['escaneado','generado'],   
                    },
            grid:true,
            form:true
        },
		
		{
			config:{
				name: 'action',
				fieldLabel: 'action',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
				type:'TextField',
				filters:{pfiltro:'tipdw.action',type:'string'},
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
                filters:{pfiltro:'tipdw.estado_reg',type:'string'},
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
				type:'NumberField',
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
				filters:{pfiltro:'tipdw.fecha_reg',type:'date'},
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
				type:'NumberField',
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
				filters:{pfiltro:'tipdw.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Tipo Documentos',
	ActSave:'../../sis_workflow/control/TipoDocumento/insertarTipoDocumento',
	ActDel:'../../sis_workflow/control/TipoDocumento/eliminarTipoDocumento',
	ActList:'../../sis_workflow/control/TipoDocumento/listarTipoDocumento',
	id_store:'id_tipo_documento',
	fields: [
		{name:'id_tipo_documento', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'id_proceso_macro', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'id_usuario_asignado', type: 'numeric'},
		{name:'id_num_tramite', type: 'numeric'},
		{name:'action', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	
	onReloadPage:function(m){
		this.maestro=m;
        this.store.baseParams={id_tipo_proceso:this.maestro.id_tipo_proceso};
        this.load({params:{start:0, limit:50}})
    },
    loadValoresIniciales:function()
    {
        Phx.vista.TipoDocumento.superclass.loadValoresIniciales.call(this);
        this.Cmp.id_tipo_proceso.setValue(this.maestro.id_tipo_proceso);
        this.Cmp.id_proceso_macro.setValue(this.maestro.id_proceso_macro);        
    },
    
    tabsouth:[
         {
          url:'../../../sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstado.php',
          title:'Estados por momento', 
          height:'50%',
          cls:'TipoDocumentoEstado'
         }
    
       ],
    
	
	sortInfo:{
		field: 'id_tipo_documento',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		