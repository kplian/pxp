<?php
/**
*@package pXP
*@file gen-DeptoEp.php
*@author  (admin)
*@date 29-04-2013 20:34:21
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DeptoEp=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.DeptoEp.superclass.constructor.call(this,config);
		this.init();
		this.bloquearMenus();
		if(Phx.CP.getPagina(this.idContenedorPadre)){
      	  var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
	 	  if(dataMaestro){ 
	 	 	 this.onEnablePanel(this,dataMaestro)
	 	  }
	   }
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_depto_ep'
			},
			type:'Field',
			form:true 
		},
		
		{
            config:{
                    name:'id_ep',
                    origen:'EP',
                    fieldLabel:'EP',
                    allowBlank:true,
                    gdisplayField:'ep',//mapea al store del grid
                    gwidth:200,
                    renderer:function (value, p, record){return String.format('{0}', record.data['ep']);}
                },
            type:'ComboRec',
            id_grupo:0,
            filters:{pfiltro:'ep',type:'string'},
            grid:true,
            form:true
        },
		{	config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_depto'
		
			},
			type:'Field',
			form:true 
			
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
			filters:{pfiltro:'deep.fecha_reg',type:'date'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'deep.fecha_mod',type:'date'},
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
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'deep.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		
	],
	
	title:'Depto - EP',
	ActSave:'../../sis_parametros/control/DeptoEp/insertarDeptoEp',
	ActDel:'../../sis_parametros/control/DeptoEp/eliminarDeptoEp',
	ActList:'../../sis_parametros/control/DeptoEp/listarDeptoEp',
	id_store:'id_depto_ep',
	fields: [
		{name:'id_depto_ep', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_ep', type: 'numeric'},
		{name:'ep', type: 'string'},
		{name:'id_depto', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_depto_ep',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	bedit:false,
	
	onReloadPage:function(m) {
   
		this.maestro=m;
		this.Atributos[2].valorInicial=this.maestro.id_depto;

       if(m.id != 'id'){
		this.store.baseParams={id_depto:this.maestro.id_depto};
		this.load({params:{start:0, limit:50}})
       
       }
       else { 
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll(); 
    	   
       }


	}
	}
)
</script>
		
		