<?php
/**
*@package pXP
*@file gen-ReporteColumna.php
*@author  (admin)
*@date 18-01-2014 02:56:10
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 * 
 * 
 * ISSUE            FECHA:		      AUTOR       DESCRIPCION
* # 56				02.09.2019		MZM			Detalle de pie de firma para reportes 
*
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PieFirmaDet=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PieFirmaDet.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_pie_firma_det'
			},
			type:'Field',
			form:true 
		},
		
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_pie_firma'
			},
			type:'Field',
			form:true 
		},
		
		{
			config: {
				name: 'id_cargo',
				fieldLabel: 'Nombre Cargo',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/Cargo/listarCargo',
					id: 'id_cargo',
					root: 'datos',
					sortInfo: {
						field: 'cargo.nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_cargo', 'nombre'],
					remoteSort: true,
					baseParams: {par_filtro: 'cargo.nombre'}
				}),
				valueField: 'id_cargo',
				displayField: 'nombre',
				gdisplayField: 'nombre',
				hiddenName: 'nombre',
				forceSelection: false,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 200,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'tcargo.nombre',type: 'string'},
			grid: true,
			form: true
		},	
		{
			config:{
				name: 'orden',
				fieldLabel: 'Orden',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'repcol.orden',type:'numeric'},
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
				filters:{pfiltro:'repcol.estado_reg',type:'string'},
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
				filters:{pfiltro:'repcol.fecha_reg',type:'date'},
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
				filters:{pfiltro:'repcol.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
		
	],
	tam_pag:50,	
	title:'Detalle Pie Firma',
	ActSave:'../../sis_parametros/control/PieFirmaDet/insertarPieFirmaDet',
	ActDel:'../../sis_parametros/control/PieFirmaDet/eliminarPieFirmaDet',
	ActList:'../../sis_parametros/control/PieFirmaDet/listarPieFirmaDet',
	id_store:'id_pie_firma_det',
	fields: [
		{name:'id_pie_firma_det', type: 'numeric'},
		{name:'id_pie_firma', type: 'numeric'},
		{name:'id_cargo', type: 'numeric'},
		{name:'nombre', type: 'string'},
		
		{name:'orden', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}
		
		
		
	],
	sortInfo:{
		field: 'orden',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_pie_firma:this.maestro.id_pie_firma}; //
		
		this.load({params:{start:0, limit:this.tam_pag}});
		//this.Cmp.codigo_columna.store.baseParams.id_tipo_planilla = this.maestro.id_tipo_planilla;			
	},
	loadValoresIniciales:function()
    {
    	//this.Cmp.tipo_columna.setValue('otro');  
    	this.Cmp.id_pie_firma.setValue(this.maestro.id_pie_firma);   
    	this.Cmp.id_cargo.store.baseParams.tipo='oficial';
    	
    	this.Cmp.id_cargo.modificado=true;   
        Phx.vista.PieFirmaDet.superclass.loadValoresIniciales.call(this); 
        
      
     
          
               
    },
    iniciarEventos:function(){
    	
    	
    }
	}
)
</script>
		
		