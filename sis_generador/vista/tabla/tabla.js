<script>
Phx.vista.tabla=function(config){
var ds_subsistema =new Ext.data.JsonStore({

				url: '../../sis_seguridad/control/Subsistema/listarSubsistema',
				id: 'id_subsistema',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_subsistema','nombre','codigo'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'nombre'}
			});
var ds_tabla =new Ext.data.JsonStore({

				url: '../../sis_generador/control/Tabla/listarTablaCombo',
				id: 'oid_tabla',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['oid_tabla','nombre'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'c.relname'}
			});


function render_id_subsistema(value, p, record){return String.format('{0}', record.data['desc_subsistema']);}
var FormatoVista=function (value,p,record){return value?value.dateFormat('d/m/Y'):''}

	this.Atributos=[
	{
		//configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_tabla'
		},
		type:'Field',
		form:true 
		
	},
	{
			config:{
				name:'id_subsistema',
				fieldLabel:'Subsistema',
				allowBlank:false,
				emptyText:'Subsistema...',
				store:ds_subsistema,
				valueField: 'id_subsistema',
				displayField: 'codigo',
				gdisplayField:'desc_subsistema',
				hiddenName: 'id_subsistema',
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,
				minListWidth:'100%',
				renderer:render_id_subsistema
			},
			type:'ComboBox',
			id_grupo:0,
			filters:{	
		        pfiltro:'subsis.nombre',
				type:'string'
			},
			
			grid:true,
			form:true
	},
	 
	{
			config:{
				name:'nombre',
				fieldLabel:'Tabla',
				allowBlank:false,
				emptyText:'Tabla...',
				store:ds_tabla,
				valueField: 'nombre',
				displayField: 'nombre',
				gdisplayField:'nombre',
				hiddenName: 'nombre',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,
				minListWidth:'100%'
			},
			type:'ComboBox',
			id_grupo:0,
			filters:{	
		        pfiltro:'tabla.nombre',
				type:'string'
			},
			
			grid:true,
			form:true
	},
	 {
		config:{
			fieldLabel: "Titulo",
			gwidth: 130,
			name: 'titulo',
			allowBlank:false,	
			maxLength:100,
			minLength:1,
			anchor:'100%'
			
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel:"Alias",
			gwidth: 130,
			name: 'alias',
			allowBlank:false,	
			maxLength:8,
			minLength:3,/*aumentar el minimo*/
			anchor:'40%'
			
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	{
	       		config:{
	       			name:'reemplazar',
	       			fieldLabel:'Reemplazar Archivos',
	       			allowBlank:false,
	       			emptyText:'Reemplazar...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'reemplazar',
	       		   // displayField: 'descestilo',
	       		    store:['si','no']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'reemplazar',
	       				 options: ['si','no'],	
	       		 	},
	       		grid:true,
	       		form:false
	 },
	 {
	       		config:{
	       			name:'menu',
	       			fieldLabel:'Menu',
	       			allowBlank:false,
	       			emptyText:'Menu...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'menu',
	       		   // displayField: 'descestilo',
	       		    store:['si','no']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'menu',
	       				 options: ['si','no'],	
	       		 	},
	       		grid:true,
	       		form:false
	 },
	 {
		config:{
			fieldLabel:"Direccion",
			gwidth: 130,
			name: 'direccion',
			allowBlank:false,	
			maxLength:200,
			minLength:1,
			anchor:'100%'
			
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel:"Carpeta",
			gwidth: 130,
			name: 'nombre_carpeta',
			allowBlank:true,	
			maxLength:200,
			minLength:1
			
		},
		type:'Field',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:false
	},
	 {
		config:{
			fieldLabel:"#Grupos",
			gwidth: 130,
			name: 'cant_grupos',
			allowBlank:false,	
			minValue:1,
			anchor:'30%'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		id_grupo:0,
		grid:true,
		egrid:true,
		form:true
	}
	];

	Phx.vista.tabla.superclass.constructor.call(this,config);
	this.init();
	this.addButton('gen_cod',{text:'Generar Codigo',iconCls: 'blist',disabled:false,handler:f_generar_codigo,tooltip: '<b>Generar Código</b><br/>Genera automáicamente los archivos de Base de datos, Modelo, Control y Vista'});
	this.getComponente('id_subsistema').on('select',onSubsistemaSelect);
	var cmbNombre=this.getComponente('nombre')
	function onSubsistemaSelect(s,r,i){
		
		ds_tabla.baseParams.esquema=r.data.codigo;
         cmbNombre.reset();
        cmbNombre.modificado = true;
	
	}
	
	function successSinc(){
		Phx.CP.loadingHide();
		//this.reload();
	}
	
	function f_generar_codigo(){
		var data=this.sm.getSelected().data;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				// form:this.form.getForm().getEl(),
				url:'../../sis_generador/control/Generador/generarCodigo',
				params:{'id_tabla':data.id_tabla,'ordenacion:':'id_tabla','dir_ordenacion':'asc',
				'cantidad':50,'nombre_carpeta':data.nombre_carpeta,'reemplazar':data.reemplazar},
				success:successSinc,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
			
		}
	
	
	
		
	this.load({params:{start:0, limit:50}})



}

Ext.extend(Phx.vista.tabla,Phx.gridInterfaz,{
	title:'Tabla',
	ActSave:'../../sis_generador/control/Tabla/guardarTabla',
	ActDel:'../../sis_generador/control/Tabla/eliminarTabla',
	ActList:'../../sis_generador/control/Tabla/listarTabla',
	id_store:'id_tabla',
	fields: [
	{name:'id_tabla'},
	{name:'esquema', type: 'string'},
	{name:'nombre', type: 'string'},
	{name:'titulo', type: 'string'},
	{name:'id_subsistema'},
	{name:'desc_subsistema', type: 'string'},
	{name:'prefijo', type: 'string'},
	{name:'alias', type: 'string'},
	{name:'reemplazar', type: 'string'},
	{name:'menu', type: 'string'},
	{name:'direccion', type: 'string'},
	{name:'nombre_carpeta', type: 'string'},
	{name:'cant_grupos', type: 'numeric'}
		],
	sortInfo:{
		field: 'id_tabla',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	bsave:true,//boton para eliminar

	east:{
		  url:'../../../sis_generador/vista/columna/columna.js',
		  title:'Columnas', 
		  width:400,
		  cls:'columna'
		 }



})
</script>