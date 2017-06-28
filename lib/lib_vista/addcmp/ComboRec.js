/**
*@package pXP
*@file Usuario.php
*@author KPLIAN (RAC)
*@date 30-06-2011
*@description Componente extendido del combo con  un trigguer adiconal para llamadas a una interfaz
*/

Ext.form.ComboRec=function(config){
	    	

	    	var configini;
	    	
	    	
	    	if (config.sysorigen) {
	    		configini = Phx.comborec[config.sysorigen].configini(config);
									    		
	    	} else {
	    	
			    	if(config.origen=='PERSONA'){
			    		
			    		configini = {
			    			 origen:'PERSONA',
			    			 tinit:false,
			    			 resizable:true,
			    			 tasignacion:true,
			    			 tname:'id_persona',
			    			 tdisplayField:'nombre',
			    			 turl:config.url?config.url:'../../../sis_seguridad/vista/persona/Persona.php',
				   			 ttitle:'Personas',
				   			   // tconfig:{width:1800,height:500},
				   			 tdata:{},
				   			 tcls:'persona',
				   			 pid:this.idContenedor,
			    			 name:'id_persona',
				   			 fieldLabel:'Persona',
				   				allowBlank:false,
				   				emptyText:'Persona...',
				   				store: new Ext.data.JsonStore({
									url: config.url?config.url:'../../sis_seguridad/control/Persona/listarPersona',
									id: 'id_persona',
									root: 'datos',
									sortInfo:{
										field: 'nombre_completo1',
										direction: 'ASC'
									},
									totalProperty: 'total',
									fields: ['id_persona','nombre_completo1','ci','nombre','ap_paterno','ap_materno','correo','celular1','telefono1','telefono2','celular2',{name:'fecha_nacimiento', type: 'date', dateFormat:'Y-m-d'},'genero','direccion'],
									// turn on remote sorting
									remoteSort: true,
									baseParams: Ext.apply({par_filtro:'p.nombre_completo1#p.ci'},config.baseParams)
								}),
				   				valueField: 'id_persona',
				   				displayField: 'nombre_completo1',
				   				
				   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre_completo1}</p><p>CI:{ci}</p> </div></tpl>',
				   				hiddenName: 'id_persona',
				   				forceSelection:true,
				   				typeAhead: false,
				       			triggerAction: 'all',
				       			lazyRender:true,
				   				mode:'remote',
				   				pageSize:20,
				   				queryDelay:1000,
				   				width:250,
				   				listWidth:'280',
				   				minChars:2
			
			    		}
			    		
			
			    	}
			    	if(config.origen=='USUARIO'){
			    		
			    		configini={
						    		origen:'USUARIO',
						    		tinit:false,
						    		resizable:true,
						    		tasignacion:true,
						    		tname:'id_usuario',
			    			        tdisplayField:'cuenta',
									name: 'id_usuario',
									fieldLabel: 'Usuario',
									allowBlank: false,
									emptyText:'Usuario...',
									store:new Ext.data.JsonStore(
									{
										url:config.url?config.url: '../../sis_seguridad/control/Usuario/listarUsuario',
										id: 'id_usuario',
										root:'datos',
										sortInfo:{
											field:'desc_person',
											direction:'ASC'
										},
										totalProperty:'total',
										fields: ['id_usuario','cuenta','desc_person'],
										// turn on remote sorting
										remoteSort: true,
										baseParams: Ext.apply({par_filtro:'cuenta#PERSON.nombre_completo2'},config.baseParams)
									}),
									valueField: 'id_usuario',
									displayField: 'desc_person',
									turl:'../../../sis_seguridad/vista/usuario/Usuario.php',
					       			ttitle:'Unidades de Medida',
					       			tdata:{},
				       			    tcls:'usuario',
				       			    pid:this.idContenedor,
									//hiddenName: 'id_administrador',
									forceSelection:true,
									typeAhead: false,
					    			triggerAction: 'all',
					    			lazyRender:true,
									mode:'remote',
									pageSize:50,
									queryDelay:500,
									width:210,
									listWidth:'280',
									gwidth:220,
									minChars:2
								}
						    		
			    		
			    		
			    		
			    	}
			    	
			    	else if(config.origen=='UO'){
			    		
			    		configini=	{
				       				name:'id_uo',
				       			    tinit:false,
				       			    resizable:true,
				       			    tasignacion:false,
				       			    //tname:'id_uo',
			    			        //tdisplayField:'cuenta',
				       				allowBlank:false,
				       				emptyText:'Unidad...',
				       				store: new Ext.data.JsonStore({
										url: config.url?config.url:'../../sis_organigrama/control/Uo/listarUo',
				    					id: 'id_uo',
				    					root: 'datos',
				    					sortInfo:{
				    						field: 'nombre_unidad',
				    						direction: 'ASC'
				    					},
				    					totalProperty: 'total',
				    					fields: ['id_uo','codigo','nombre_unidad','nombre_cargo','presupuesta','correspondencia'],
				    					// turn on remote sorting
				    					remoteSort: true,
				    					
				    					baseParams: Ext.apply({par_filtro:'nombre_unidad#codigo'},config.baseParams)
				    				}),
				       				valueField: 'id_uo',
				       				displayField: 'nombre_unidad',
				       				tpl:'<tpl for="."><div class="x-combo-list-item">{codigo}<p>{nombre_unidad}</p> </div></tpl>',
				       				hiddenName: 'id_uo',
				       				forceSelection:true,
				       				typeAhead: false,
				           			triggerAction: 'all',
				           			lazyRender:false,
				       				mode:'remote',
				       				pageSize:10,
				       				queryDelay:1000,
				       				width:250,
				       				listWidth:'280',
				       				minChars:2
				
				       	}	
			
			    	}
			    	else if(config.origen=='FUNCIONARIOCAR'){
			    		
			    		configini={
				       				name:'id_funcionario',
				       			    tinit:false,
				       			    resizable:true,
				       			    tasignacion:false,
				       			    emptyText:'Funcionario...',
				       			    pid:this.idContenedor,
				       				store: new Ext.data.JsonStore({  
					    				url: config.url?config.url:'../../sis_organigrama/control/Funcionario/listarFuncionarioCargo',
				    					id: 'id_uo',
				    					root: 'datos',
				    					sortInfo:{
				    						field: 'desc_funcionario1', 
				    						direction: 'ASC'
				    					},
				    					totalProperty: 'total',
				    					fields: ['id_funcionario','id_uo','codigo','nombre_cargo','desc_funcionario1','email_empresa','id_lugar','id_oficina','lugar_nombre','oficina_nombre'],
				    					// turn on remote sorting
				    					remoteSort: true,
				    					baseParams: Ext.apply({par_filtro:'desc_funcionario1#email_empresa#codigo#nombre_cargo'},config.baseParams)
				    					
				    				}),
				       				valueField: 'id_uo',
				       				displayField: 'desc_funcionario1',
				       				tpl: '<tpl for="."><div class="x-combo-list-item"><p><b>{desc_funcionario1}</b></p><p>{codigo}</p><p>{nombre_cargo}</p><p>{email_empresa}</p><p>{oficina_nombre} - {lugar_nombre}</p> </div></tpl>',
				       				hiddenName: 'id_funcionario',
				       				forceSelection: true,
				       				typeAhead: false,
				           			triggerAction: 'all',
				           			lazyRender: true,
				       				mode: 'remote',
				       				pageSize: 10,
				       				queryDelay: 1000,
				       				width: 250,
				       				listWidth: '280',
				       				minChars: 2
				       	}	
			
			    	}
		         
			    	else if(config.origen=='FUNCIONARIO'){
			    		
			    		configini=	{
				       				
				       				name:'id_funcionario',
				       			    tinit:false,
				       			    resizable:true,
				       			    tasignacion:true,
				       			    tname:'id_funcionario',
			    			        tdisplayField:'desc_person',
				       				allowBlank:false,
				       				turl:'../../../sis_organigrama/vista/funcionario/Funcionario.php',
						   			ttitle:'Funcionarios',
						   			   // tconfig:{width:1800,height:500},
						   			tdata:{},
						   			tcls:'funcionario',
						   			pid:this.idContenedor,
				       				allowBlank:false,
				       				emptyText:'Funcionario...',
				       				store: new Ext.data.JsonStore({
				    					url: config.url?config.url:'../../sis_organigrama/control/Funcionario/listarFuncionario',
				    					id: 'id_funcionario',
				    					root: 'datos',
				    					sortInfo:{
				    						field: 'desc_person',
				    						direction: 'ASC'
				    					},
				    					totalProperty: 'total',
				    					fields: ['id_funcionario','codigo','desc_person','ci','documento','telefono','celular','correo'],
				      					// turn on remote sorting
				    					remoteSort: true,
				    					baseParams: Ext.apply({par_filtro:'funcio.codigo#nombre_completo1'},config.baseParams)
						    		
				    				}),
				    				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo} - Sis: {codigo_sub} </p><p>{desc_person}</p><p>CI:{ci}</p> </div></tpl>',
					       			valueField: 'id_funcionario',
				       				displayField: 'desc_person',
				       				hiddenName: 'id_funcionario',
				       				forceSelection:true,
				       				typeAhead: false,
				           			triggerAction: 'all',
				           			lazyRender:true,
				       				mode:'remote',
				       				pageSize:10,
				       				queryDelay:1000,
				       				listWidth:'280',
				       				width:250,
				       				minChars:2
				
				       	}	
			
			    	}	
			    	
			    	//RAC 30112011
			    	else if(config.origen=='GESTION'){
			    		configini=	{
			    			
			    			        name:'id_gestion',
			    			        tinit:false,
			    			        resizable:true,
			    			        tasignacion:false,
				       			    
					   				fieldLabel:'Gestion',
					   				allowBlank:true,
					   				emptyText:'Gestion...',
					   				store: new Ext.data.JsonStore({
					                    url: config.url?config.url:'../../sis_parametros/control/Gestion/listarGestion',
										id: 'id_gestion',
										root: 'datos',
										sortInfo:{
											field: 'gestion',
											direction: 'DESC'
										},
										totalProperty: 'total',
										fields: ['id_gestion','gestion'],
										// turn on remote sorting
										remoteSort: true,
										baseParams: Ext.apply({par_filtro:'gestion'},config.baseParams)
						    		
									}),
					   				valueField: 'id_gestion',
					   				displayField: 'gestion',
					   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{gestion}</p></div></tpl>',
					   				hiddenName: 'id_gestion',
					   				forceSelection:true,
					   				typeAhead: false,
					       			triggerAction: 'all',
					       			lazyRender:true,
					   				mode:'remote',
					   				pageSize:10,
					   				queryDelay:1000,
					   				listWidth:'280',
					   				minChars:2
					   	}	
			         }
			         //RAC 30112011
			    	else if(config.origen=='PERIODO'){
			    		configini=	{
			    			
			    			        name:'id_periodo',
			    			        tinit:false,
			    			        resizable:true,
			    			        tasignacion:false,
				       			    
					   				fieldLabel:'Periodo',
					   				allowBlank:true,
					   				emptyText:'Periodo...',
					   				store: new Ext.data.JsonStore({
					                    url: config.url?config.url:'../../sis_parametros/control/Periodo/listarPeriodo',
										id: 'id_periodo',
										root: 'datos',
										sortInfo:{
											field: 'periodo',
											direction: 'ASC'
										},
										totalProperty: 'total',
										fields: ['id_periodo','periodo'],
										// turn on remote sorting
										remoteSort: true,
										baseParams: Ext.apply({par_filtro:'periodo'},config.baseParams)
						    		
									}),
					   				valueField: 'id_periodo',
					   				displayField: 'periodo',
					   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{periodo}</p></div></tpl>',
					   				hiddenName: 'id_periodo',
					   				forceSelection:true,
					   				typeAhead: false,
					       			triggerAction: 'all',
					       			lazyRender:true,
					   				mode:'remote',
					   				pageSize:10,
					   				queryDelay:1000,
					   				listWidth:'280',
					   				minChars:2
					   	}	
			         }
			         //RAC 30112011
			         else if(config.origen=='DEPTO'){
			    		configini=	{
			    			        tinit:false,
			    			        resizable:true,
			    			        tasignacion:false,
					   				name: 'id_depto',
					   				fieldLabel: 'Departamento',
					   				allowBlank:true,
					   				emptyText:  'Departamento...',
					   				store: new Ext.data.JsonStore({
					                     url:config.url?config.url:'../../sis_parametros/control/Depto/listarDeptoFiltradoDeptoUsuario',
										id: 'id_depto',
										root: 'datos',
										sortInfo:{
											field: 'deppto.nombre',
											direction: 'ASC'
										},
										totalProperty: 'total',
										fields: ['id_depto','nombre','codigo','prioridad'],
										// turn on remote sorting
										remoteSort: true,
										baseParams:Ext.apply({par_filtro:'deppto.nombre#deppto.codigo'},config.baseParams)
									}),
					   				valueField: 'id_depto',
					   				displayField: 'nombre',
					   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p></div></tpl>',
					   				hiddenName: 'id_depto',
					   				forceSelection:true,
					   				typeAhead: false,
					       			triggerAction: 'all',
					       			lazyRender:true,
					   				mode:'remote',
					   				pageSize:10,
					   				queryDelay:1000,
					   				width:250,
					   				listWidth:'280',
					   				minChars:2
					   	}	
			         }		
			    	  //RAC 01122011
			    	 else if(config.origen=='MONEDA'){
			    		configini=	{
			    			        tinit:false,
			    			        
			    			        tasignacion:false,
			    			        name:'id_moneda',
					   				fieldLabel:'Moneda',
					   				allowBlank:false,
					   				emptyText:'Moneda...',
					   				store: new Ext.data.JsonStore({
					                    url: config.url?config.url:'../../sis_parametros/control/Moneda/listarMoneda',
										id: 'id_moneda',
										root: 'datos',
										sortInfo:{
											field: 'moneda',
											direction: 'ASC'
										},
										totalProperty: 'total',
										fields: ['id_moneda','moneda','codigo','tipo_moneda','codigo_internacional'],
										// turn on remote sorting
										remoteSort: true,
										baseParams:Ext.apply({par_filtro:'moneda#codigo',filtrar:'si'},config.baseParams)
									}),
					   				valueField: 'id_moneda',
					   				displayField: 'moneda',
					   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Moneda:{moneda}</p><p>Codigo:{codigo}</p> <p>Codigo Internacional:{codigo_internacional}</p></div></tpl>',
					   				hiddenName: 'id_moneda',
					   				forceSelection:true,
					   				typeAhead: false,
					       			triggerAction: 'all',
					       			lazyRender:true,
					   				mode:'remote',
					   				pageSize:10,
					   				queryDelay:1000,
					   				width:250,
					   				listWidth:'280',
					   				resizable:true,
					   			    minChars:2
		   				}	
			         }		
			    	
			    
			       if(config.origen=='INSTITUCION'){
			    		
			    		configini={
			    			 origen:'INSTITUCION',
			    			 tinit:false,
			    			 resizable:true,
			    			 tasignacion:true,
			    			 tname:'id_institucion',
			    			 tdisplayField:'nombre',
			    			 turl:'../../../sis_parametros/vista/institucion/Institucion.php',
				   			 ttitle:'Instituciones',
				   			   // tconfig:{width:1800,height:500},
				   			 tdata:{},
				   			 tcls:'Institucion',
				   			 pid:this.idContenedor,
					         name:'id_institucion',
				   			 fieldLabel:'Institucion',
				   				allowBlank:false,
				   				emptyText:'Institucion...',
				   				store: new Ext.data.JsonStore({
									url: config.url?config.url:'../../sis_parametros/control/Institucion/listarInstitucion',
									id: 'id_institucion',
									root: 'datos',
									sortInfo:{
										field: 'nombre',
										direction: 'ASC'
									},
									totalProperty: 'total',
									fields: ['id_institucion','nombre','doc_id','codigo','doc_id','casilla','telefono1','telefono2',
									'celular1','celular2','fax','email1','email2','pag_web','observaciones','id_persona','desc_persona',
									'direccion','codigo_banco'],
									// turn on remote sorting
									remoteSort: true,
									baseParams: Ext.apply({par_filtro:'instit.codigo#instit.nombre#instit.doc_id'},config.baseParams)
									
								}),
				   				valueField: 'id_institucion',
				   				displayField: 'nombre',
				   				
				   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo}-{nombre}</p><p>NIT:{doc_id}</p> </div></tpl>',
				   				hiddenName: 'id_institucion',
				   				forceSelection:true,
				   				typeAhead: false,
				       			triggerAction: 'all',
				       			lazyRender:true,
				       			listWidth:'280',
				   				mode:'remote',
				   				pageSize:10,
				   				queryDelay:1000,
				   				width:250,
				   				minChars:2
				   				
			           }
			    	}
			    	
			    	
			    	 
			    if(config.origen=='PROVEEDOR'){
			    		
			    		configini={
			    			 origen:'PROVEEDOR',
			    			 tinit:false,
			    			 resizable:true,
			    			 tasignacion:true,
			    			 turl:'../../../sis_parametros/vista/proveedor/Proveedor.php',
				   			 ttitle:'Proveedor',
				   			   // tconfig:{width:1800,height:500},
				   			 tdata:{},
				   			 tcls:'proveedor',
				   			 pid:this.idContenedor,
					         name:'id_proveedor',
				   			 fieldLabel:'Proveedor',
				   			 allowBlank:false,
				   			 tdisplayField:'codigo',
				   			 emptyText:'Proveedor...',
				   			 store: new Ext.data.JsonStore({
		
									url: config.url?config.url:'../../sis_parametros/control/Proveedor/listarProveedorCombos',
									id: 'id_proveedor',
									root: 'datos',
									sortInfo:{
										field: 'rotulo_comercial',
										direction: 'ASC'
									},
									totalProperty: 'total',
									fields: ['id_proveedor','desc_proveedor','codigo','nit','rotulo_comercial','lugar','email'],
									// turn on remote sorting
									remoteSort: true,
									baseParams:Ext.apply({par_filtro:'desc_proveedor#codigo#nit#rotulo_comercial'},config.baseParams)
									
								}),
				   			  valueField: 'id_proveedor',
		   				      displayField: 'desc_proveedor',
				   			  tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo}</p><p><b>{rotulo_comercial}</b></p><p>{desc_proveedor}</p><p>NIT:{nit}</p><p>Lugar:{lugar}</p><p>Email: {email}</p></div></tpl>',
		   					  hiddenName: 'id_proveedor',
				   			  forceSelection:true,
				   			  typeAhead: false,
				       		  triggerAction: 'all',
				       		  lazyRender:true,
				   			  mode:'remote',
				   			  pageSize:10,
				   			  queryDelay:1000,
				   			  minChars:2,
				   			  listWidth:'280'
				   				
			
			    		}
			    		
			
			    	}
			    	
			    	//27/12/2011 RAC
			    if(config.origen=='CLASIFICADOR'){
		    		
		    		configini={
		    			 origen:'CLASIFICADOR',
		    			 tinit:false,
		    			 resizable:true,
		    			 tasignacion:false,
				         name:'id_clasificador',
			   			 fieldLabel:'Clasificacion',
			   				allowBlank:false,
			   				emptyText:'Clasificador...',
			   				store: new Ext.data.JsonStore({
		
		    					url: config.url?config.url:'../../sis_seguridad/control/Clasificador/listarClasificador',
		    					id: 'id_clasificador',
		    					root: 'datos',
		    					sortInfo:{
		    						field: 'prioridad',
		    						direction: 'ASC'
		    					},
		    					totalProperty: 'total',
		    					fields: ['id_clasificador','codigo','descripcion'],
		    					// turn on remote sorting
		    					remoteSort: true,
		    					baseParams:Ext.apply({par_filtro:'odigo#descripcion'},config.baseParams)
		    					
		    				}),    				
		    				valueField: 'id_clasificador',
		       				displayField: 'descripcion',
		       				gdisplayField: 'descripcion',
		       				hiddenName: 'id_clasificador',
		       				forceSelection:true,
		       				typeAhead: false,
		           			triggerAction: 'all',
		           			lazyRender:true,
		       				mode:'remote',
		       				pageSize:10,
		       				queryDelay:1000,
		       				listWidth:'280',
		       				width:250,
		       				minChars:2
		    		}
		    		
		
		    	}
		    	
		    	if(config.origen=='UNIDADMEDIDA'){
		    		if (config.tipo == undefined || config.tipo == '') {
		    			config.tipo = 'Tiempo';
		    		}
		    		configini={
		    			
		    			 origen:'UNIDADMEDIDA',
		    			 tinit:false,
		    			 resizable:true,
		    			 tasignacion:false,
				         name:'id_unidad_medida',
			   			 fieldLabel:'Unidad de Medida',
			   				allowBlank:false,
			   				emptyText:'Seleccione una unidad...',
			   				store: new Ext.data.JsonStore({
		
		    					url: config.url?config.url:'../../sis_parametros/control/UnidadMedida/listarUnidadMedida',
		    					id: 'id_unidad_medida',
		    					root: 'datos',
		    					sortInfo:{
		    						field: 'descripcion',
		    						direction: 'ASC'
		    					},
		    					totalProperty: 'total',
		    					fields: ['id_unidad_medida','codigo','descripcion','tipo'],
		    					// turn on remote sorting
		    					remoteSort: true,
		    					baseParams:Ext.apply({par_filtro:'codigo#descripcion',tipo:config.tipo},config.baseParams)
		    				}),
		    				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Nombre: {descripcion} [{codigo}] </p><p>Magnitud: {tipo}</p></div></tpl>',    				
		    				valueField: 'id_unidad_medida',
		       				displayField: 'descripcion',
		       				gdisplayField: 'descripcion',
		       				hiddenName: 'id_unidad_medida',
		       				forceSelection:true,
		       				typeAhead: false,
		           			triggerAction: 'all',
		           			lazyRender:true,
		       				mode:'remote',
		       				pageSize:10,
		       				queryDelay:1000,
		       				width:250,
		       				minChars:2,
		       				turl:'../../../sis_parametros/vista/unidad_medida/UnidadMedida.php',
			       			ttitle:'Unidades de Medida',
			       			tdata:{},
		       			    tcls:'UnidadMedida',
		       			    pid:this.idContenedor
		    		}
		    		
		
		    	}
		    	
		    	if(config.origen=='CATALOGO'){
		    		
		    		configini={
						origen:'CATALOGO',
						tinit:false,
						resizable:true,
						tasignacion:false,
				        name:'catalogo',
			   			fieldLabel:'Catálogo',
			   			turl:'../../../sis_parametros/vista/catalogo/Catalogo.php',
			   			ttitle:'Catálogo',
		       			tdata:{},
		   			    tcls:'Catalogo',
		   				allowBlank:false,
		   				emptyText:'Seleccione un catálogo...',
		   				store: new Ext.data.JsonStore({
							url: config.url?config.url:'../../sis_parametros/control/Catalogo/listarCatalogoCombo',
							id: 'id_catalogo',
							root: 'datos',
							sortInfo:{
								field: 'descripcion',
								direction: 'ASC'
							},
							totalProperty: 'total',
							fields: ['id_catalogo','codigo','descripcion'],
							// turn on remote sorting
							remoteSort: true,
							baseParams: Ext.apply({par_filtro:'descripcion'},config.baseParams)
						}),    				
						valueField: 'descripcion',
		   				displayField: 'descripcion',
		   				gdisplayField: 'catalogo',
		   				hiddenName: 'catalogo',
		   				forceSelection:true,
		   				typeAhead: false,
		       			triggerAction: 'all',
		       			lazyRender:true,
		   				mode:'remote',
		   				pageSize:10,
		   				queryDelay:1000,
		   				width:250,
		   				minChars:2
		    		}
		    		
		
		    	}
		    	
		    	if(config.origen=='EP'){    		
		    		
		    		configini={
		   			    origen:'EP',
		   			    tinit:false,
		   			    resizable:true,
						tasignacion:false,
		   				name:'id_ep',
		   				fieldLabel:'EP',
		   				allowBlank:true,
		   				emptyText:'EP...',
		   				store: new Ext.data.JsonStore({
		
							url: config.url?config.url:'../../sis_parametros/control/Ep/listarEp',
							id: 'id_ep',
							root: 'datos',
							sortInfo:{
								field: 'id_ep',
								direction: 'ASC'
							},
							totalProperty: 'total',
							fields: ['id_ep','ep','nombre_financiador','nombre_regional','nombre_programa','nombre_proyecto','nombre_actividad'],
							// turn on remote sorting
							remoteSort: true,
							baseParams:{par_filtro:'ep#nombre_financiador#nombre_regional#nombre_programa#nombre_proyecto#nombre_actividad'}
						}),
						tpl:'<tpl for="."><div class="x-combo-list-item"><p>{ep}</p><p>Finaciador: {nombre_financiador}</p><p>Regional: {nombre_regional}</p><p>Programa: {nombre_programa}</p><p>Proyecto: {nombre_proyecto}</p><p>Actividad: {nombre_actividad}</p></div></tpl>',    				
		    			valueField: 'id_ep',
		   				displayField: 'ep',
		   				
		   				hiddenName: 'id_ep',
		   				forceSelection:true,
		   				typeAhead: false,
					       triggerAction: 'all',
					       lazyRender:true,
		   				mode:'remote',
		   				pageSize:10,
		   				queryDelay:1000,
		   				listWidth:'280',
		   				width:250,
		   				minChars:2,
		   			    renderer:function(value, p, record){return String.format('{0}', record.data['desc_ep']);}
		
		   			
			       }
		    	
		    	}
		    	
		    	if(config.origen=='SUBSISTEMA'){    		
		    		
		    		configini={
		    			 origen:'SUBSISTEMA',
		    			 tinit:false,
		    			 resizable:true,
		    			 tasignacion:false,
				         name:'id_subsistema',
			   			 fieldLabel:'Sistema',
			   				allowBlank:false,
			   				emptyText:'Sistema...',
			   				store: new Ext.data.JsonStore({
		
		    					url: config.url?config.url:'../../sis_seguridad/control/Subsistema/listarSubsistema',
		    					id: 'id_subsistema',
		    					root: 'datos',
		    					sortInfo:{
		    						field: 'nombre',
		    						direction: 'ASC'
		    					},
		    					totalProperty: 'total',
		    					fields: ['id_subsistema','codigo','nombre'],
		    					// turn on remote sorting
		    					remoteSort: true,
		    					baseParams:Ext.apply({par_filtro:'codigo#nombre'},config.baseParams)
		    					
		    				}),    				
		    				valueField: 'id_subsistema',
		       				displayField: 'nombre',
		       				gdisplayField: 'nombre',
		       				hiddenName: 'id_subsistema',
		       				forceSelection:true,
		       				typeAhead: false,
		           			triggerAction: 'all',
		           			lazyRender:true,
		       				mode:'remote',
		       				pageSize:10,
		       				queryDelay:1000,
		       				listWidth:'280',
		       				width:250,
		       				minChars:2
		    		}
		    		
		
		    	}
		    	
		    	 				
		    			   	
		    	
		    	
		    	
		    	if(config.origen=='CENTROCOSTO'){  
		    		
		    		var tpl = new Ext.XTemplate([
				     '<tpl for=".">',
		    		'<div class="x-combo-list-item">',
		    		  '<tpl if="movimiento_tipo_pres == \'gasto\'">',
		    		      '<p><b><font color="green">{codigo_cc}</font></b></p>',
		    		   '</tpl>',
		    		   '<tpl if="movimiento_tipo_pres == \'recurso\'">',
		    		      '<p><b><font color="orange">{codigo_cc}</font></b></p>',
		    		   '</tpl>',
		    		   '<tpl if="movimiento_tipo_pres == \'administrativo\'">',
		    		      '<p><b><font color="red">{codigo_cc}</font></b></p>',
		    		   '</tpl>',
		    		   '<p>Gestion: {gestion}</p>',
		    		   '<p>Reg: {nombre_regional}</p>',
		    		   '<p>Fin.: {nombre_financiador}</p>',
		    		   '<p>Proy.: {nombre_programa}</p>',
		    		   '<p>Act.: {nombre_actividad}</p>',
		    		   '<p>UO: {nombre_uo}</p>',
		    		 '</div></tpl>'				     
				    ]);  		
		    		
		    		configini={
		    			 origen:'CENTROCOSTO',
		    			 tinit:false,
		    			 resizable:true,
		    			 tasignacion:false,
				         name:'id_centro_costo',
			   			 fieldLabel:'Centro de Costos',
			   				allowBlank:false,
			   				emptyText:'Centro de Costos...',
			   				store: new Ext.data.JsonStore({
		
		    					url: config.url?config.url:'../../sis_parametros/control/CentroCosto/listarCentroCosto',
		    					id: 'id_centro_costo',
		    					root: 'datos',
		    					sortInfo:{
		    						field: 'codigo_cc',
		    						direction: 'ASC'
		    					},
		    					totalProperty: 'total',
		    					fields: ['id_centro_costo','codigo_cc','codigo_uo','ep','gestion','nombre_uo',
		    					          'nombre_programa','nombre_proyecto','nombre_financiador','nombre_regional',
		    					         'nombre_actividad','movimiento_tipo_pres'],
		    					// turn on remote sorting
		    					remoteSort: true,
		    					baseParams:Ext.apply({tipo_pres:"gasto,administrativo",par_filtro:'id_centro_costo#codigo_cc#codigo_uo#nombre_uo#nombre_actividad#nombre_programa#nombre_proyecto#nombre_regional#nombre_financiador'},config.baseParams)
		    					
		    				}), 
		    				tpl: tpl,	
		    				valueField: 'id_centro_costo',
		       				displayField: 'codigo_cc',
		       				gdisplayField: 'desc_cc',
		       				hiddenName: 'id_centro_costo',
		       				forceSelection:true,
		       				typeAhead: false,
		           			triggerAction: 'all',
		           			lazyRender:true,
		       				mode:'remote',
		       				pageSize:10,
		       				queryDelay:1000,
		       				listWidth:'320',
		       				width:290,
		       				minChars:2
		    		}
		    		
		
		    	}
		    	
		    	if(config.origen=='TIPOCC'){ 
		    		
		    		var tpl = new Ext.XTemplate([
				     	'<tpl for=".">',
				     	'<div class="x-combo-list-item">',
				    		'<tpl if="tipo == \'centro\'">',
			    		      '<p><b><font color="green">{codigo}</font></b></p>',
			    		    '</tpl>',
			    		    '<tpl if="tipo == \'proyecto\'">',
			    		      '<p><b><font color="orange">{codigo}</font></b></p>',
			    		    '</tpl>',
			    		    '<tpl if="tipo == \'orden\'">',
			    		      '<p><b><font color="red">{codigo}</font></b></p>',
			    		    '</tpl>',
			    		    '<tpl if="tipo == \'estadistica\'">',
			    		      '<p><b><font color="blue">{codigo}</font></b></p>',
			    		    '</tpl>',
			    		    '<p><b>Desc: {descripcion}</b></p>',		   
			    		    '<p>Tipo: {tipo}</p>',			    		    
			    		    '<p>Ini: {fecha_inicio:date("d/m/Y")}</p>',
			    		    '<p>Fin.: {fecha_final:date("d/m/Y")}</p>',	
			    		    '<p>EP: {desc_ep}</p>',	    		   
			    		 '</div></tpl>'			     
					   ]);   		
		    		
		    		configini={
		    			origen:'TIPOCC',
		    			tinit:false,
		    			resizable:true,
		    			tasignacion:false,
				        name:'id_tipo_cc',
			   			fieldLabel:'Tipo Centro',
			   			llowBlank:false,
			   			emptyText:'Tipo de Centro...',
			   			baseParams: {movimiento:'si'},
			   			store: new Ext.data.JsonStore({		
		    					url: config.url?config.url:'../../sis_parametros/control/TipoCc/listarTipoCc',
		    					id: 'id_tipo_cc',
		    					root: 'datos',
		    					sortInfo:{
		    						field: 'codigo',
		    						direction: 'ASC'
		    					},
		    					totalProperty: 'total',
		    					fields: [
										'id_tipo_cc','codigo','control_techo','mov_pres','estado_reg', 
										'movimiento', 'id_ep','id_tipo_cc_fk','descripcion','tipo', 
										'control_partida','momento_pres','desc_ep',
										{name:'fecha_inicio', type: 'date',dateFormat:'Y-m-d'},
										{name:'fecha_final', type: 'date',dateFormat:'Y-m-d'}],
		    					// turn on remote sorting
		    					remoteSort: true,
		    					baseParams:Ext.apply({par_filtro:'tcc.id_tipo_cc#tcc.codigo#tcc.descripcion#tcc.desc_ep'}, config.baseParams)
		    					
		    				}), 
	    				tpl: tpl,	
	    				valueField: 'id_tipo_cc',
	       				displayField: 'codigo',
	       				gdisplayField: 'desc_tcc',
	       				hiddenName: 'id_tipo_cc',
	       				forceSelection:true,
	       				typeAhead: false,
	           			triggerAction: 'all',
	           			lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:1000,
	       				listWidth:'320',
	       				width:290,
	       				minChars:2
		    		}
		    	}
		    	
		    	else if(config.origen=='FUNCUENTABANC'){
			    		
			    		configini=	{
				       				
				       				name:'id_funcionario_cuenta_bancaria',
				       			    tinit:false,
				       			    resizable:true,
				       			    allowBlank:false,
				       				pid:this.idContenedor,
				       				allowBlank:false,
				       				emptyText:'Cuenta Bancaria...',
				       				store: new Ext.data.JsonStore({
				    					url: config.url?config.url:'../../sis_organigrama/control/FuncionarioCuentaBancaria/listarFuncionarioCuentaBancaria',
				    					id: 'id_funcionario_cuenta_bancaria',
				    					root: 'datos',
				    					sortInfo:{
				    						field: 'nro_cuenta',
				    						direction: 'ASC'
				    					},
				    					totalProperty: 'total',
				    					fields: ['id_funcionario_cuenta_bancaria','nro_cuenta','id_institucion','fecha_fin','fecha_ini','nombre'],
				      					// turn on remote sorting
				    					remoteSort: true,
				    					baseParams: Ext.apply({par_filtro:'funcio.codigo#nombre_completo1'},config.baseParams)
						    		
				    				}),
				    				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nro_cuenta} -  {nombre} </p> </div></tpl>',
					       			valueField: 'id_funcionario_cuenta_bancaria',
				       				displayField: 'nro_cuenta',
				       				hiddenName: 'id_funcionario_cuenta_bancaria',
				       				forceSelection:true,
				       				typeAhead: false,
				           			triggerAction: 'all',
				           			lazyRender:true,
				       				mode:'remote',
				       				pageSize:10,
				       				queryDelay:1000,
				       				listWidth:'280',
				       				width:250,
				       				minChars:2
				       	}	
			    	}
 			}     
         Ext.apply(configini, config);
         Ext.apply(this, configini);
         
      //Ext.form.ComboRec.superclass.initComponent.call(configini);  
      Ext.form.ComboRec.superclass.constructor.call(this);  
        
       
       };

Ext.form.ComboRec = Ext.extend(Ext.form.ComboRec,Ext.form.TrigguerCombo,{})
	
	
