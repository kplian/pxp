<?php
/**
*@package pXP
*@file gen-DeptoUo.php
*@author  (m)
*@date 19-10-2011 12:59:45
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.depto_uo=Ext.extend(Phx.gridInterfaz,{



	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.depto_uo.superclass.constructor.call(this,config);

		this.init();
		this.bloquearMenus();
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_depto_uo'
			},
			type:'Field',
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
		/*{
			config:{
				name: 'id_depto',
				fieldLabel: 'id_depto',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'TextField',
			filters:{pfiltro:'depuo.id_depto',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_uo',
				fieldLabel: 'id_uo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'TextField',
			filters:{pfiltro:'depuo.id_uo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},*/
 
		{
   			config:{
   				name:'id_uo',
   				origen:'UO',
   				fieldLabel:'Unidad',
   				gdisplayField:'desc_uo',//mapea al store del grid
   			    gwidth:200,
      			 renderer:function (value, p, record){return String.format('{0}', record.data['desc_uo']);}		},
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{	
   				        pfiltro:'nombre_unidad',
   						type:'string'
   					},
   		   
   			grid:true,
   			form:true
   	},
		
		
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'depuo.estado_reg',type:'string'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'depuo.fecha_reg',type:'date'},
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
			type:'TextField',
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'depuo.fecha_mod',type:'date'},
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
			type:'TextField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Departamento-UO',
	ActSave:'../../sis_parametros/control/DeptoUo/insertarDeptoUo',
	ActDel:'../../sis_parametros/control/DeptoUo/eliminarDeptoUo',
	ActList:'../../sis_parametros/control/DeptoUo/listarDeptoUo',
	id_store:'id_depto_uo',
	fheight:'50%',
	fwidth:'50%',
	fields: [
		{name:'id_depto_uo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_depto', type: 'numeric'},
		{name:'id_uo', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_depto', type:'string'},
		{name:'desc_uo', type:'string'}
	],
	sortInfo:{
		field: 'id_depto_uo',
		direction: 'ASC'
	},
	
	
	onReloadPage:function(m){

       
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_depto;

		

		//actualiza combos del departamento
		 var cmbUo = this.getComponente('id_uo');
		 if(this.maestro.codigo=='COR'){
			 cmbUo.store.baseParams.correspondencia='si'; 
		
		 }else{
			delete  cmbUo.store.baseParams.correspondencia;
			 }
		 cmbUo.modificado = true;


		// this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);

       if(m.id != 'id'){
    	//   this.grid.getTopToolbar().enable();
     	//	 this.grid.getBottomToolbar().enable();  
		 this.store.baseParams={id_depto:this.maestro.id_depto};
		 this.load({params:{start:0, limit:50}})
       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll(); 
    	   
       }
	},
	
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.depto_uo.superclass.preparaMenu.call(this,tb)
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		