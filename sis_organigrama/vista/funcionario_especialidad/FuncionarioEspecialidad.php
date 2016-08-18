<?php
/**
*@package pXP
*@file gen-FuncionarioEspecialidad.php
*@author  (admin)
*@date 16-04-2016 21:18:37
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FuncionarioEspecialidad=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.FuncionarioEspecialidad.superclass.constructor.call(this,config);
		console.log('MAEEESTRO',this.maestro);
		if(this.maestro){
			this.store.baseParams={id_funcionario:this.maestro.id_funcionario};
			this.load({params:{start:0, limit:this.tam_pag}})
		} else {
			this.grid.getTopToolbar().disable();
			this.grid.getBottomToolbar().disable();
		}
		this.init();
		this.iniciarEventos();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcionario_especialidad'
			},
			type:'Field',
			form:true 
		},
		
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcionario'
			},
			type:'Field',
			form:true 
		},
		
		{
			config: {
				name: 'id_especialidad',
				fieldLabel: 'Especialidad',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/Especialidad/listarEspecialidad',
					id: 'id_especialidad',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_especialidad','id_especialidad_nivel', 'nombre', 'codigo'],
					remoteSort: true,
					baseParams: {par_filtro: 'espcia.nombre#espcia.codigo'}
				}),
				valueField: 'id_especialidad',
				displayField: 'nombre',
				gdisplayField: 'nombre',
				hiddenName: 'id_especialidad',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'espcia.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
            config:{
                name: 'fecha',
                fieldLabel: 'Fecha Titulo',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                            format: 'd/m/Y', 
                            renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
            },
                type:'DateField',
                filters:{pfiltro:'funes.fecha',type:'date'},
                valorInicial:new Date(),
                id_grupo:1,
                grid:true,
                form:true
        },
		{
            config:{
                name: 'numero_especialidad',
                fieldLabel: 'Numero Titulo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:150
            },
            type:'Field',
			form:true
        },
		{
            config:{
                name: 'descripcion',
                fieldLabel: 'Descripcion ',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:150
            },
            type:'TextArea',
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
				filters:{pfiltro:'funes.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: '',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'funes.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'funes.usuario_ai',type:'string'},
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
				filters:{pfiltro:'funes.fecha_reg',type:'date'},
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
				filters:{pfiltro:'funes.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	onButtonNew:function(){

		console.log(this.maestro);
		Phx.vista.FuncionarioEspecialidad.superclass.onButtonNew.call(this);
		this.Cmp.id_funcionario.setValue(this.maestro.id_funcionario);
		
	},
	tam_pag:50,	
	title:'Funcionario Especialidad',
	ActSave:'../../sis_organigrama/control/FuncionarioEspecialidad/insertarFuncionarioEspecialidad',
	ActDel:'../../sis_organigrama/control/FuncionarioEspecialidad/eliminarFuncionarioEspecialidad',
	ActList:'../../sis_organigrama/control/FuncionarioEspecialidad/listarFuncionarioEspecialidad',
	id_store:'id_funcionario_especialidad',
	fields: [
		{name:'id_funcionario_especialidad', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'id_especialidad', type: 'numeric'},
		{name:'fecha', type: 'date',dateFormat:'Y-m-d'},
		{name:'numero_especialidad', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	iniciarEventos:function(){
        
        //inicio de eventos 
       
	},
	sortInfo:{
		field: 'id_funcionario_especialidad',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,

	loadValoresIniciales:function()
	{
		Phx.vista.FuncionarioEspecialidad.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_funcionario').setValue(this.maestro.id_funcionario);		
	},
	
	onReloadPage:function(m)
	{
		this.maestro=m;						
		this.store.baseParams={id_funcionario:this.maestro.id_funcionario};
		this.load({params:{start:0, limit:50}});			
	}

})
</script>
		
		