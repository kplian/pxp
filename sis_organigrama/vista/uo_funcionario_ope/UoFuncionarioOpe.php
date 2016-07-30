<?php
/**
*@package pXP
*@file gen-UoFuncionarioOpe.php
*@author  (admin)
*@date 19-05-2015 17:53:09
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UoFuncionarioOpe=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.UoFuncionarioOpe.superclass.constructor.call(this,config);
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
					name: 'id_uo_funcionario_ope'
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
   			filters:{pfiltro:'funcio.desc_funcionario1',
				type:'string'
			},
   		   
   			grid:true,
   			form:true
   	      },
		{
			config:{
				fieldLabel: "Fecha Asignacion",
				name: 'fecha_asignacion',
	   			allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				format: 'd/m/Y', 
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
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
			name: 'fecha_finalizacion',
   		    allowBlank: false,
			anchor: '80%',
			gwidth: 100,
			format: 'd/m/Y', 
			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
		},
		type:'DateField',
		filters:{pfiltro:'UOFUNC.fecha_finalizacion',type:'date'},
		grid:true,		
		form:true
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
				filters:{pfiltro:'uofo.fecha_reg',type:'date'},
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
				filters:{pfiltro:'uofo.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'uofo.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'uofo.usuario_ai',type:'string'},
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
				filters:{pfiltro:'uofo.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Asignación Operacional ',
	ActSave:'../../sis_organigrama/control/UoFuncionarioOpe/insertarUoFuncionarioOpe',
	ActDel:'../../sis_organigrama/control/UoFuncionarioOpe/eliminarUoFuncionarioOpe',
	ActList:'../../sis_organigrama/control/UoFuncionarioOpe/listarUoFuncionarioOpe',
	id_store:'id_uo_funcionario_ope',
	fields: [
		{name:'id_uo_funcionario_ope', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_uo', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'fecha_asignacion', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_finalizacion', type: 'date',dateFormat:'Y-m-d'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'ci','codigo','desc_funcionario1','desc_funcionario2','num_doc'
		
	],
	loadValoresIniciales:function()
    {	
        this.Cmp.id_uo.setValue(this.maestro.id_uo);       
        Phx.vista.UoFuncionarioOpe.superclass.loadValoresIniciales.call(this);
    },
	  
     onReloadPage:function(m){       
		this.maestro=m;
		this.Cmp.id_funcionario.store.setBaseParam('id_uo',this.maestro.id_uo);

       if(m.id != 'id'){	

		this.store.baseParams={id_uo:this.maestro.id_uo};
		this.load({params:{start:0, limit:50}})
       
       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll(); 
    	   
       }


	},
     
	sortInfo:{
		field: 'id_uo_funcionario_ope',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		