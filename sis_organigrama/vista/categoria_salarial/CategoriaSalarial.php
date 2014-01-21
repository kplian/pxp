<?php
/**
*@package pXP
*@file gen-CategoriaSalarial.php
*@author  (admin)
*@date 13-01-2014 23:53:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.CategoriaSalarial=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.CategoriaSalarial.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}});
		this.addButton('btnIncrementoSalarial',{
            text :'',
            iconCls : 'bincremento_salarial',
            disabled: true,
            handler : this.onButtonIncremento,
            tooltip : '<b>Incremento salarial porcentual</b>'
  		});
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_categoria_salarial'
			},
			type:'Field',
			form:true,
			id_grupo:1
		},
		
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'catsal.codigo',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
				type:'TextField',
				filters:{pfiltro:'catsal.nombre',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'incremento',
				fieldLabel: '% Incremento',
				allowBlank: true,
				anchor: '80%',
				maxLength:3
			},
				type:'NumberField',				
				id_grupo:2,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'fecha_ini',
				fieldLabel: 'Aplicado Desde',
				allowBlank: true,
				anchor: '80%',
				format: 'd/m/Y'
							
			},
				type:'DateField',
				id_grupo:2,
				grid:false,
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
				filters:{pfiltro:'catsal.estado_reg',type:'string'},
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
				filters:{pfiltro:'catsal.fecha_reg',type:'date'},
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
				filters:{pfiltro:'catsal.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Categoria Salarial',
	ActSave:'../../sis_organigrama/control/CategoriaSalarial/insertarCategoriaSalarial',
	ActDel:'../../sis_organigrama/control/CategoriaSalarial/eliminarCategoriaSalarial',
	ActList:'../../sis_organigrama/control/CategoriaSalarial/listarCategoriaSalarial',
	id_store:'id_categoria_salarial',
	fields: [
		{name:'id_categoria_salarial', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_categoria_salarial',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	Grupos: [
            {
                layout: 'column',
                border: false,
                defaults: {
                   // columnWidth: '.5',
                    border: false
                },    
                items: [{
					        bodyStyle: 'padding-right:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: 'Datos principales',
					            autoHeight: true,
					            width: 450,
					            items: [],
						        id_grupo:1
					        },
					        {
					            xtype: 'fieldset',
					            title: 'Incremento Salarial por Categoria Salarial',
					            autoHeight: true,
					            width: 450,
					            items: [],
						        id_grupo:2
					        }]
					    }]
            }
        ],
	south:{
		  url:'../../../sis_organigrama/vista/escala_salarial/EscalaSalarial.php',
		  title:'Escala Salarial por Categoria', 
		  height:'50%',
		  cls:'EscalaSalarial'
	},
	
	onButtonEdit:function(){
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		
		this.adminGrupo({ocultar:[2],mostrar:[1]});
						
		this.Cmp.fecha_ini.allowBlank = true;
		this.Cmp.incremento.allowBlank = true;
		Phx.vista.CategoriaSalarial.superclass.onButtonEdit.call(this);
	},onButtonNew:function(){
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		Phx.vista.CategoriaSalarial.superclass.onButtonNew.call(this);
		this.adminGrupo({ocultar:[2],mostrar:[1]});
		this.Cmp.fecha_ini.allowBlank = true;
		this.Cmp.incremento.allowBlank = true;
		
		//alert(this.Cmp.id_categoria_salarial.getValue());
		
		
	},onButtonIncremento:function(){
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		this.Cmp.fecha_ini.allowBlank = false;
		this.Cmp.incremento.allowBlank = false;
		this.adminGrupo({ocultar:[1],mostrar:[2]});
		Phx.vista.CategoriaSalarial.superclass.onButtonEdit.call(this);
	},
	preparaMenu:function(n) {
		this.getBoton('btnIncrementoSalarial').enable();
		Phx.vista.CategoriaSalarial.superclass.preparaMenu.call(this,n);
	},
	liberaMenu : function () {
		this.getBoton('btnIncrementoSalarial').disable();
		Phx.vista.CategoriaSalarial.superclass.liberaMenu.call(this);
	}
	}
)
</script>
		
		