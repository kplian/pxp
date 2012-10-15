<?php
/**
*@package pXP
*@file ProcedimientoGUI.php
*@author KPLIAN (Rac)
*@date 14-02-2011
*@description  Vista para desplegar los procediemintos de guardar, insertar y actualizar
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.procedimiento_gui=Ext.extend(Phx.gridInterfaz,{
    Atributos:[
		{
			// configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_procedimiento_gui'
	
			},
			
			type:'Field',
			form:true 
			
		},
		{	config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_gui'
		
			},
			type:'Field',
			form:true 
			
		},
		 {
			config:{
				fieldLabel: "Subsistema",
				gwidth: 130,
				name: 'codigo_sub',
				allowBlank:false,	
				maxLength:150,
				minLength:5,
				anchor:'100%'
			},
			type:'TextField',
			filters:{pfiltro:'sub.codigo',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},
		 {
			config:{
				fieldLabel: "Función",
				gwidth: 130,
				name: 'nombre_fun',
				allowBlank:false,	
				maxLength:150,
				minLength:5,
				anchor:'100%'
			},
			type:'TextField',
			filters:{pfiltro:'fun.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},

       	{
       			config:{
       				name:'id_procedimiento',
       				fieldLabel:'Procedimiento',
       				allowBlank:false,
       				emptyText:'Procedimiento...',
       				store: new Ext.data.JsonStore({
    					url: '../../sis_seguridad/control/Procedimiento/listarProcedimientoCmb',
    					id: 'id_procedimiento',
    					root: 'datos',
    					sortInfo:{
    						field: 'codigo_sub',
    						direction: 'ASC'
    					},
    					totalProperty: 'total',
    					fields: ['id_procedimiento','codigo_sub','nombre_fun','codigo','descripcion'],
      					// turn on remote sorting
    					remoteSort: true,
    					baseParams:{par_filtro:'pro.codigo#pro.descripcion#fun.nombre#sub.codigo'}
    				}),
    				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo} - Sis: {codigo_sub} </p><p>{descripcion}</p><p>CI:{nombre_fun}</p> </div></tpl>',
	       			
       				valueField: 'id_procedimiento',
       				displayField: 'codigo',
       				gdisplayField: 'codigo',
       				hiddenName: 'id_procedimiento',
       				//forceSelection:false,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				width:150,
       				minChars:2,
       				minListWidth:300,
       				renderer:function(value, p, record){return String.format('{0}', record.data['codigo']);}

       			},
       			type:'ComboBox',
       			id_grupo:0,
       			filters:{   pfiltro:'proced.codigo',
       						type:'string'
       					},
       			grid:true,
       			form:true
       	},
		 {
			config:{
				fieldLabel: "Descripción",
				gwidth: 130,
				name: 'desc_procedimiento',
				allowBlank:false,	
				maxLength:150,
				minLength:5,
				anchor:'100%'
			},
			type:'TextField',
			filters:{pfiltro:'proced.descripcion',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		}
		,
		
		{
			config:{
				name:'boton',
				fieldLabel:'Es un boton',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		emptyText:'Seleccione Opcion...',
	    		selectOnFocus:true,
				mode:'local',
				store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['si','si'],	
	        			['no','no']]
	        				
	    		}),
				valueField:'ID',
				displayField:'valor',
				width:150,			
				
			},
			type:'ComboBox',
			id_grupo:1,
			form:true
		}
		
		
		],



	title:'Procedimientos',
	fheight:'50%',
	fwidth:'300',
	ActSave:'../../sis_seguridad/control/ProcedimientoGui/GuardarProcedimientoGui',
	ActDel:'../../sis_seguridad/control/ProcedimientoGui/EliminarProcedimientoGui',
	ActList:'../../sis_seguridad/control/ProcedimientoGui/ListarProcedimientoGui',
	id_store:'id_procedimiento_gui',
	fields: [
	         'id_procedimiento_gui',
             'id_procedimiento',
             'id_gui',
             'codigo_sub',
             'nombre_fun',
             'codigo',
             'desc_procedimiento',                           
             'boton',
             'fecha_reg',
             'estado_reg'
	],
	sortInfo:{
		field: 'codigo_sub',
		direction: 'ASC',
	},
/*	onButtonNew:function(){
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		
		Phx.vista.procedimiento_gui.superclass.onButtonNew.call(this);
		//seteamos un valor fijo que vienen de la vista maestro para id_gui 
		this.getComponente('id_gui').setValue(this.maestro.id_gui);
		
	},*/
	/*funcion corre cuando el padre cambia el nodo maestero*/
	onReloadPage:function(m){

       
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_gui;


		// this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);

       if(m.id != 'id'){
    	//   this.grid.getTopToolbar().enable();
     	//	 this.grid.getBottomToolbar().enable();  

		this.store.baseParams={id_gui:this.maestro.id_gui};
		this.load({params:{start:0, limit:50}})
       
       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll(); 
    	   
       }


	},
	constructor: function(config){
		// configuracion del data store
		
		this.maestro=config.maestro;
		
		//this.Atributos[1].valorInicial=this.maestro.id_gui;
		Phx.vista.procedimiento_gui.superclass.constructor.call(this,config);


		this.init();
		//deshabilita botones
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		
		
		// this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip:
		// '<b>My Boton</b><br/>Icon only button with tooltip'});
		
		
		//this.load({params:{start:0, limit:50}})

	},
	
	bdel:true,// boton para eliminar
	bsave:false,// boton para eliminar


	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.procedimiento_gui.superclass.preparaMenu.call(this,tb)
	}

	/*
	 * Grupos:[{
	 * 
	 * xtype:'fieldset', border: false, //title: 'Checkbox Groups', autoHeight:
	 * true, layout: 'form', items:[], id_grupo:0 }],
	 */


  }
)
</script>