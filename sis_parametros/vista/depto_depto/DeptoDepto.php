<?php
/**
*@package pXP
*@file gen-DeptoDepto.php
*@author  (admin)
*@date 08-09-2015 14:02:42
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DeptoDepto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.DeptoDepto.superclass.constructor.call(this,config);
		this.init();
		this.bloquearMenus();
		this.init();
		if(Phx.CP.getPagina(this.idContenedorPadre)){
      	 var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
	 	 if(dataMaestro){ 
	 	 	this.onEnablePanel(this,dataMaestro)
	 	 }
	    }
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_depto_depto'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_depto_origen'
			},
			type:'Field',
			form:true 
		},
		{
	   			config:{
				    name:'id_depto_destino',
				    hiddenName: 'id_depto_destino',
				    qtip: 'Depto relacionado. Por ejemplo: el libro de bancos de Madrid se contabiliza en madrid. (Esta relación no es comutativa)',
				    origen: 'DEPTO',
	   				allowBlank: false,
	   				fieldLabel: 'Depto Destino',
	   				disabled: false,
	   				width: '80%',
			        baseParams: { estado:'activo',tipo_filtro:'DEPTO_UO' },
			        gdisplayField:'desc_depto_destino',
                    gwidth: 120
	   			},
	   			filters:{pfiltro:'ddes.nombre',type:'string'},
	   			type:'ComboRec',
	   			bottom_filter: true,
	   			id_grupo: 1,
	   			form: true,
	   			grid: true
		},
		{
			config:{
				name: 'obs',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
				type:'TextArea',
				filters:{pfiltro:'dede.obs',type:'string'},
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
				filters:{pfiltro:'dede.estado_reg',type:'string'},
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
				filters:{pfiltro:'dede.fecha_reg',type:'date'},
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
				filters:{pfiltro:'dede.usuario_ai',type:'string'},
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
				filters:{pfiltro:'dede.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'dede.fecha_mod',type:'date'},
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
	title:'DEP',
	ActSave:'../../sis_parametros/control/DeptoDepto/insertarDeptoDepto',
	ActDel:'../../sis_parametros/control/DeptoDepto/eliminarDeptoDepto',
	ActList:'../../sis_parametros/control/DeptoDepto/listarDeptoDepto',
	id_store:'id_depto_depto',
	fields: [
		'id_depto_depto',
		'id_depto_origen',
		{name:'estado_reg', type: 'string'},
		{name:'obs', type: 'string'},
		{name:'id_depto_destino', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_depto_destino'
		
	],
	
	onReloadPage:function(m){
       
	   this.maestro=m;
	   if(m.id != 'id'){
    	this.store.baseParams={id_depto:this.maestro.id_depto};
		this.load({params:{start:0, limit:50}})
       
       }
       else{//alert("else");
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll(); 
    	   
       }


	},
	loadValoresIniciales:function(){
        Phx.vista.DeptoDepto.superclass.loadValoresIniciales.call(this);
        this.Cmp.id_depto_origen.setValue(this.maestro.id_depto);
   },
	
	
	sortInfo:{
		field: 'id_depto_depto',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false
	}
)
</script>
		
		