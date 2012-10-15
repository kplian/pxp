<?php
/**
*@package pXP
*@file gen-DeDeptoUsuario.php
*@author  (mzm)
*@date 24-11-2011 18:26:47
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DeptoUsuario=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.DeptoUsuario.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_depto_usuario'
			},
			type:'Field',
			form:true 
		},
	
		{
			config:{
				name: 'id_depto',
				labelSeparator:'',
				anchor: '80%',
				inputType:'hidden',
				maxLength:4
			},
			type:'Field',
			form:true
		},
		{
   			config:{
   				name:'id_usuario',
   				fieldLabel:'Usuario',
   				allowBlank:false,
   				emptyText:'Usuario...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_seguridad/control/Usuario/listarUsuario',
					id: 'id_persona',
					root: 'datos',
					sortInfo:{
						field: 'desc_person',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_usuario','desc_person','cuenta'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'desc_person#cuenta'}
				}),
   				valueField: 'id_usuario',
   				displayField: 'desc_person',
   				gdisplayField:'desc_usuario',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{desc_person}</p><p>CI:{ci}</p> </div></tpl>',
   				hiddenName: 'id_usuario',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:280,
   				minChars:2,
   				turl:'../../../sis_seguridad/vista/usuario/Usuario.php',
   			    ttitle:'Usuarios',
   			   // tconfig:{width:1800,height:500},
   			    tdata:{},
   			    tcls:'usuario',
   			    pid:this.idContenedor,
   			
   				renderer:function (value, p, record){return String.format('{0}', record.data['desc_usuario']);}
   			},
   			type:'TrigguerCombo',
   			//type:'ComboRec',
   			id_grupo:0,
   			filters:{	
   				        pfiltro:'desc_person',
   						type:'string'
   					},
   		   
   			grid:true,
   			form:true
       	},{
			config:{
				name: 'cargo',
				fieldLabel: 'Cargo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'depusu.cargo',type:'string'},
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
			filters:{pfiltro:'depusu.estado_reg',type:'string'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'depusu.fecha_reg',type:'date'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'depusu.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Usuario por Depto',
	ActSave:'../../sis_parametros/control/DeptoUsuario/insertarDeptoUsuario',
	ActDel:'../../sis_parametros/control/DeptoUsuario/eliminarDeptoUsuario',
	ActList:'../../sis_parametros/control/DeptoUsuario/listarDeptoUsuario',
	id_store:'id_depto_usuario',
	fields: [
		{name:'id_depto_usuario', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_depto', type: 'numeric'},
		{name:'id_usuario', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_usuario', type: 'string'},
		{name:'cargo', type: 'string'}
	],
	sortInfo:{
		field: 'id_depto_usuario',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	onReloadPage:function(m){

       
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_depto;


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


	}
	
	}
)
</script>
		
		