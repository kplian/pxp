<?php
/**
*@package pXP
*@file gen-Alarma.php
*@author  (fprudencio)
*@date 18-11-2011 11:59:10
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AlarmaFuncionario=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.AlarmaFuncionario.superclass.constructor.call(this,config);
		
		this.addButton('accesoDirec',{text:'Acceso Directo',iconCls: 'blist',disabled:true,handler:this.accesoDirect,tooltip: '<b>Acceso Directo</b><br/>Direcciona a la interfaz con mas información'});
		
		
		this.init();
		this.load({params:{start:0, limit:50,id_usuario:Phx.CP.config_ini.id_usuario}})
	},
	accesoDirect:function(){
		
		
		var rec=this.sm.getSelected();
		
		
		var par = Ext.util.JSON.decode(Ext.util.Format.trim(rec.data.parametros))
		
		//Phx.CP.loadWindows('../../../sis_legal/vista/proceso_contrato/subirContrato.php',
			Phx.CP.loadWindows(rec.data.acceso_directo,
			rec.data.titulo+'-'+par.tipoFiltro,
			{modal:true,
			 width:'90%',
			 height:'90%'
		    },par,this.idContenedor,rec.data.clase)
		    
		   /* Phx.CP.loadWindows('../../../sis_legal/vista/proceso_contrato/subirContrato.php',
			'Subir Contrato',
			{
				modal:true,
				width:500,
				height:250
		    },rec.data,this.idContenedor,'subirContrato')*/
		    
		    
		
	},
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_alarma'
			},
			type:'Field',
			form:true 
		},
		{
		config:{
				name: 'tipo',
				fieldLabel: 'Tipo',
				gwidth: 50,
				renderer:function (value, p, record){
					var icono='eli';
					if(record.data.tipo == 'alarma')
					{
	
					   return "<div style='text-align:center'><img  src = '../../../lib/imagenes/icono_dibu/dibu_alert.png' align='center' width='32' height='32'/></div>"
					}
					else
					{
						return "<div style='text-align:center'><img  src = '../../../lib/imagenes/icono_dibu/dibu_info.png' align='center' width='32' height='32'/></div>"
					}
					
				}
			},
			type:'Field',
			filters:{pfiltro:'alarm.tipo',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
		config:{
				name: 'obs',
				fieldLabel: 'Oss',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'Field',
			filters:{pfiltro:'alarm.obs',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
		config:{
				name: 'dias',
				fieldLabel: 'Dias',
				allowBlank: true,
			    gwidth: 35
			},
			type:'Field',
			//filters:{pfiltro:'alarm.obs',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},

		{
			config:{
				name: 'fecha',
				fieldLabel: 'fecha Fin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
			    format:'d/m/Y h:m:s',
			    disabled:true,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'alarm.fecha',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'descripcion',
				allowBlank: true,
				disabled:false,
				grow:true,
				minGrow:200,
				anchor: '80%',
				gwidth: 300,
				maxLength:200
			},
			type:'TextArea',
			filters:{pfiltro:'alarm.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name:'id_funcionario',
   				fieldLabel:'Funcionario',
   				allowBlank:false,
   				emptyText:'Funcionario...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_recursos_humanos/control/Funcionario/listarFuncionario',
					id: 'id_funcionario',
					root: 'datos',
					sortInfo:{
						field: 'desc_person',
						direction:'ASC'
					},
					totalProperty: 'total',
					fields: ['id_funcionario','desc_person','ci'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'PERSON.nombre_completo1#PERSON.ci'}
				}),
   				valueField:'id_funcionario',
   				displayField: 'desc_person',
   				gdisplayField:'nombre_completo1',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{desc_person}</p><p>CI:{ci}</p> </div></tpl>',
   				hiddenName: 'id_funcionario',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:150,
   				gwidth:280,
   				minChars:2,
   				disabled:true,   				
   				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_completo1']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'nombre_completo1',type:'string'},
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
			filters:{pfiltro:'alarm.estado_reg',type:'string'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'alarm.fecha_reg',type:'date'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'alarm.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Alarmas',
	ActSave:'../../sis_parametros/control/Alarma/insertarAlarma',
	ActDel:'../../sis_parametros/control/Alarma/eliminarAlarma',
	ActList:'../../sis_parametros/control/Alarma/listarAlarma',
	id_store:'id_alarma',
	fields: [
		{name:'id_alarma', type: 'numeric'},
		{name:'acceso_directo', type: 'string'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'fecha', type: 'date', dateFormat:'Y-m-d'},
		{name:'estado_reg', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'nombre_completo1', type: 'string'},'titulo','clase','parametros','obs','tipo','dias'
		
	],
	sortInfo:{
		field: 'alarm.fecha', 
		direction: 'ASC'
	},
	onButtonEdit:function(){
        this.loadForm(this.sm.getSelected())
		this.window.show();
		this.window.buttons[0].hide();
		this.window.buttons[1].hide();
	},
	
	preparaMenu:function(n){
	  var data = this.getSelectedData();
	  
	  
	  this.getBoton('accesoDirec').enable();
	  
	  var tb = Phx.vista.AlarmaFuncionario.superclass.preparaMenu.call(this,n);
	  
	  if(data['tipo']=='notificacion'){
	  		this.getBoton('del').enable();
	  }
	  else{
	  		this.getBoton('del').disable();
	  }
	  
	  
	  return tb;
	 
	},
	liberaMenu:function(n){
	  var data = this.getSelectedData();
	  var tb =this.tbar;
	 
	  this.getBoton('accesoDirec').disable();
	  return Phx.vista.AlarmaFuncionario.superclass.liberaMenu.call(this,n);
	 } ,
	 
	
	/*onButtonEdit:function(){
        this.loadForm(this.sm.getSelected())
		this.window.show();
		this.window.buttons[1].hide();
		
	},*/
	
	bdel:true,// boton para eliminar
	bnew:false,
	bsave:false// boton para eliminar
	}
)
</script>
		
		