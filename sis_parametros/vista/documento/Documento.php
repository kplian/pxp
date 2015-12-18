<?php
/**
*@package pXP
*@file Documento.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar los departamentos
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Documento=function(config){

	this.Atributos=[
	       	{
	       		// configuracion del componente
	       		config:{
	       			labelSeparator:'',
	       			inputType:'hidden',
	       			name: 'id_documento'
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
	       				store: new Ext.data.JsonStore({

	    					url: '../../sis_seguridad/control/Subsistema/listarSubsistema',
	    					id: 'id_subsistema',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'nombre',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_subsistema','codigo','prefijo','nombre'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'nombre'}
	    				}),
	       				valueField: 'id_subsistema',
	       				displayField: 'nombre',
	       				gdisplayField:'desc_subsis',//mapea al store del grid
	       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p> </div></tpl>',
	       				hiddenName: 'id_subsistema',
	       				forceSelection:true,
	       				typeAhead: true,
	           			triggerAction: 'all',
	           			lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:1000,
	       				width:250,
	       				gwidth:400,
	       				minChars:2,
	       				renderer:function (value, p, record){return String.format('{0}', record.data['desc_subsis']);}
	       			},
	       			type:'ComboBox',
	       			id_grupo:0,
	       			filters:{	
	       				        pfiltro:'nombre',
	       						type:'string'
	       					},
	       		   
	       			grid:true,
	       			form:true
	       	},
	       	{
	       		config:{
	       			fieldLabel: "Código",
	       			gwidth: 120,
	       			name: 'codigo',
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
	       			fieldLabel: "Nombre",
	       			gwidth: 120,
	       			name: 'descripcion',
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
				name:'tipo_numeracion',
				fieldLabel:'Tipo Numeracion...',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		emptyText:'Seleccione Opcion...',
	    		selectOnFocus:true,
				mode:'local',
				store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['depto','Departamento'],	
	        			['uo','Unidad'],
	        			['depto_uo','Depto-Unidad'],
						['tabla','Tabla']]	        				
	    		}),
				valueField:'ID',
				displayField:'valor',
				width:150,			
				anchor:'70%'
			},
			type:'ComboBox',
			id_grupo:0,
			grid:true,
			form:true
		},
	 	{
			config:{
				name:'tipo',
				fieldLabel:'Tipo Corres.',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		emptyText:'Seleccione Opcion...',
	    		selectOnFocus:true,
				mode:'local',
				store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['interna','Interna'],	
	        			['entrante','Entrante'],
	        			['saliente','Saliente']]
	        				
	    		}),
				valueField:'ID',
				displayField:'valor',
				width:150,			
				anchor:'70%'
			},
			type:'ComboBox',
			form:true,
			grid:true,
			id_grupo:0
		},{  config:{
	       			name:'periodo_gestion',
	       			fieldLabel:'Numerar por...',
	       			allowBlank:false,
	       			emptyText:'Numerar por...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'periodo_gestion',
	       		   // displayField: 'descestilo',
	       		    store:['periodo','gestion']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['periodo','gestion'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
	      {
			config:{
				name:'formato',
				fieldLabel:'Formato Numeracion',
				typeAhead: true,
				allowBlank:true,
	    		selectOnFocus:true,
				
				
				width:150,			
				anchor:'70%'
			},
			type:'TextArea',
			form:true,
			grid:true,
			id_grupo:0
		}, 	
		 
	       	
	       
	       	{
	       		config:{
	       			name:'estado_reg',
	       			fieldLabel:'Estado',
	       			allowBlank:false,
	       			emptyText:'Estado...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'estado_reg',
	       		   // displayField: 'descestilo',
	       		    store:['activo','inactivo']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['activo','inactivo'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	}
	       	
	       	
	       	];
	    	
	Phx.vista.Documento.superclass.constructor.call(this,config);
	this.init();
	//this.getComponente();
	
	
	
	
	//this.getComponente('tipo_numeracion').on('select',onTipo);
	//this.getComponente();
	//var v_id_uo=this.getComponente('id_uo');
	//var v_id_depto=this.getComponente('id_depto');
	//var v_id_depto_uo=this.getComponente('id_depto_uo');
	
	
	
	
	var v_id_uo=this.getComponente('id_uo');
	var v_id_depto=this.getComponente('id_depto');
	var v_id_depto_uo=this.getComponente('id_depto_uo');
	function onTipo(c,r,e){
		/*console.log(r.data.ID);
		if(r.data.ID=='uo'){
			Phx.vista.documento.superclass.ocultarComponente(v_id_depto);
			Phx.vista.documento.superclass.mostrarComponente(v_id_uo);
			Phx.vista.documento.superclass.ocultarComponente(v_id_depto_uo);
			
		}else if(r.data.ID=='depto'){
			Phx.vista.documento.superclass.ocultarComponente(v_id_uo);
			Phx.vista.documento.superclass.ocultarComponente(v_id_depto_uo);
			Phx.vista.documento.superclass.mostrarComponente(v_id_depto);
			
		}else if(r.data.ID=='depto_uo'){
			Phx.vista.documento.superclass.ocultarComponente(v_id_uo);
			Phx.vista.documento.superclass.ocultarComponente(v_id_depto);
			Phx.vista.documento.superclass.mostrarComponente(v_id_depto_uo);
			
		}else{
			Phx.vista.documento.superclass.ocultarComponente(v_id_uo);
			Phx.vista.documento.superclass.ocultarComponente(v_id_depto);
			Phx.vista.documento.superclass.ocultarComponente(v_id_depto_uo);
		}*/
	}
	//this.getComponente('tipo_numeracion').on('select',onTipo);
	this.iniciarEventos();
	
	
	this.load({params:{start:0, limit:50}});
}

Ext.extend(Phx.vista.Documento,Phx.gridInterfaz,{
	title:'Documentos',
	ActSave:'../../sis_parametros/control/Documento/guardarDocumento',
	ActDel:'../../sis_parametros/control/Documento/eliminarDocumento',
	ActList:'../../sis_parametros/control/Documento/listarDocumento',
	id_store:'id_documento',
	fields: [
	{name:'id_documento'},
	{name:'codigo',type:'string'},
	{name:'descripcion',type:'string'},
	{name:'estado_reg', type: 'string'},
	{name:'fecha_reg', mapping: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d'},
	{name:'fecha_mod', mapping: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d'},
	{name:'id_subsistema'},
	{name:'id_usuario_mod'},
	{name:'id_usuario_reg'},
	{name:'desc_subsis',type:'string'},
	{name:'nombre_subsis', type:'string'},
	{name:'usureg', type:'string'},
	{name:'usumod', type:'string'},
	{name:'tipo_numeracion', type:'string'},
	{name:'periodo_gestion', type:'string'},
	{name:'tipo', type:'string'},
	{name:'formato', type:'string'}
	
	],
	sortInfo:{
		field: 'DOCUME.codigo',
		direction: 'ASC'
	},
	iniciarEventos:function(){ 
		this.getComponente('tipo_numeracion').on('select',function(combo,record,index){
			
			//var nodoSel = this.sm.getSelectedNode();
			//alert(record.json[0]);
			/*if(record.json[0]=='depto'){
					this.mostrarComponente(this.getComponente('id_parametro'));
					
					this.getComponente('sw_agrupador').setValue('si');
			}*/
		}
			,this);


	    //para habilitar el tipo de correspondecia para el sistema corres

		this.getComponente('id_subsistema').on('select',function(combo,record,index){

            if(record.data.codigo=='CORRES'){
				
				this.getComponente('tipo').enable();
				this.getComponente('tipo').show();
			}
			else{
				this.getComponente('tipo').disable();
				this.getComponente('tipo').hide();
				
			}
               
        		
        		
    			
		},this);
 
        
        
		
		
	
	},




	onButtonEdit:function(){
			
			var data = this.getSelectedData();
			Phx.vista.Documento.superclass.onButtonEdit.call(this);
			
			if(data.codigo=='CORRES'){
                
                this.getComponente('tipo').enable();
                this.getComponente('tipo').show();
            }
            else{
                this.getComponente('tipo').disable();
                this.getComponente('tipo').hide();
                
            }
			
		},	
	

	bdel:true,// boton para eliminar
	bsave:true,// boton para eliminar
	bedit:true
		  
		 
})
</script>