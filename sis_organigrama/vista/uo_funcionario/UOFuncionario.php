<?php
/**
*@package pXP
*@file UOFuncionario.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para asociar los funcionarios a su correspondiente Unidad Organizacional
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.uo_funcionario=Ext.extend(Phx.gridInterfaz,{
    Atributos:[
		{
			// configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_uo_funcionario'
	
			},
			
			type:'Field',
			form:true 
			
		},
		{	config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_uo'
		
			},
			type:'Field',
			form:true 
			
		},
		/* {
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
		},*/
		 {
			config:{
				fieldLabel: "Codigo",
				gwidth: 130,
				name: 'codigo',
				allowBlank:false,	
				maxLength:150,
				minLength:5,
				anchor:'100%'
			},
			type:'TextField',
			filters:{pfiltro:'FUNCIO.codigo',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},

		  {
   			config:{
       		    name:'id_funcionario',
   				origen:'FUNCIONARIO',
   				gwidth: 300,
   				fieldLabel:'Funcionario',
   				allowBlank:false,
   				  				
   				valueField: 'id_funcionario',
   			    gdisplayField: 'desc_funcionario1',
      			renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario1']);}
       	     },
   			type:'ComboRec',//ComboRec
   			id_grupo:0,
   			filters:{pfiltro:'funcio.desc_person',
				type:'string'
			},
   		   
   			grid:true,
   			form:true
   	      },

       	{
			config:{
				fieldLabel: "CI",
				gwidth: 130,
				name: 'ci',
				allowBlank:false,	
				maxLength:150,
				minLength:5,
				anchor:'100%'
			},
			type:'TextField',
			filters:{pfiltro:'FUNCIO.ci',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		}
		,{
			config:{
				fieldLabel: "Fecha Asignacion",
				gwidth: 130,
				renderer:function (value,p,record){return value},
	   		    name: 'fecha_asignacion',
	   			format:'d/m/Y',
	   		    width:115
				//?value.dateFormat('d/m/Y h:i:s'):''
			   },
			type:'DateField',
			filters:{pfiltro:'UOFUNC.fecha_asignacion',
					type:'date'
					},
			grid:true,
			form:true
		},
		
		
		
		{
		config:{
			fieldLabel: "Fecha Finalizacion",
			gwidth: 130,
			renderer:function (value,p,record){return value},
   		    name: 'fecha_finalizacion',
   		       format:'d/m/Y',
   		    width:115
			//?value.dateFormat('d/m/Y h:i:s'):''
		},
		type:'DateField',
		filters:{pfiltro:'UOFUNC.fecha_finalizacion',
				type:'date'
				},
		grid:true,
		
		form:true
	},
	
		
		{
			config:{
				name:'estado_reg',
				fieldLabel:'Estado',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		emptyText:'Seleccione Opcion...',
	    		selectOnFocus:true,
				mode:'local',
				store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['activo','activo'],	
	        			['inactivo','inactivo']]
	        				
	    		}),
				valueField:'ID',
				displayField:'valor',
				width:115,			
				
			},
			type:'ComboBox',
			grid:true,
			id_grupo:1,
			form:true
		}
		],



	title:'Funcionarios',
	fheight:'50%',
	fwidth:'300',
	ActSave:'../../sis_organigrama/control/UoFuncionario/GuardarUoFuncionario',
	ActDel:'../../sis_organigrama/control/UoFuncionario/EliminarUoFuncionario',
	ActList:'../../sis_organigrama/control/UoFuncionario/ListarUoFuncionario',
	id_store:'id_uo_funcionario',
	fields: ['id_uo_funcionario',
             'id_uo',
             'id_funcionario',
             'codigo',
             'ci',
             'desc_funcionario1',
             'desc_person',
             'num_doc',
             'fecha_asignacion',
             'estado_reg',
             'fecha_finalizacion',
             'fecha_reg',
             'fecha_mod',
             'USUREG',
             'USUMOD','correspondencia'],
	sortInfo:{
		field: 'desc_funcionario1',
		direction: 'ASC',
	},
	onButtonNew:function(){
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		this.getComponente('fecha_finalizacion').visible=false;
		Phx.vista.uo_funcionario.superclass.onButtonNew.call(this);
		//seteamos un valor fijo que vienen de la vista maestro para id_gui 
		
		
	},onButtonEdit:function(){
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		
		this.getComponente('fecha_finalizacion').visible=true;
		Phx.vista.uo_funcionario.superclass.onButtonEdit.call(this);
	},
	
	/*funcion corre cuando el padre cambia el nodo maestero*/
	onReloadPage:function(m){

       
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_uo;


		// this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);

       if(m.id != 'id'){
    	//   this.grid.getTopToolbar().enable();
     	//	 this.grid.getBottomToolbar().enable();  

		this.store.baseParams={id_uo:this.maestro.id_uo};
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
		Phx.vista.uo_funcionario.superclass.constructor.call(this,config);

		txt_fecha_fin=this.getComponente('fecha_finalizacion');
		
		
		
			//this.ocultarComponente(this.getComponente('id_parametro'));
		
		this.getComponente('estado_reg').on('beforeselect',function(combo,record,index){
				if(record.json[0]=='inactivo'){
					//getComponente('fecha_finalizacion').allowBlank=false;
					txt_fecha_fin.allowBlank=false;
					txt_fecha_fin.enable();
					//this.mostrarComponente(txt_fecha_fin);
				}else{
					txt_fecha_fin.allowBlank=true;
					//this.ocultarComponente(txt_fecha_fin);
					txt_fecha_fin.reset();
					txt_fecha_fin.disable();
					//this.ocultarComponente(this.getComponente('fecha_finalizacion'));						
					//getComponente('fecha_finalizacion').allowBlank=true;
					//getComponente('fecha_finalizacion').allowBlank=false;
				}
			}
		)
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
		Phx.vista.uo_funcionario.superclass.preparaMenu.call(this,tb)
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