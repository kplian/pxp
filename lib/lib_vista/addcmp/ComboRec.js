/**
*@package pXP
*@file Usuario.php
*@author KPLIAN (RAC)
*@date 30-06-2011
*@description Componente extendido del combo para mas un trigguer adiconal para llamadas a una interfaz
*/

Ext.form.ComboRec=function(config){
	    	

	    	var configini;
	    	if(config.origen=='PERSONA'){
	    		
	    		configini={
	    			 origen:'PERSONA',
	    			 tinit:false,
	    			 tasignacion:true,
	    			 tname:'id_persona',
	    			 tdisplayField:'nombre',
	    			 turl:'../../../sis_seguridad/vista/persona/Persona.php',
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
							url: '../../sis_seguridad/control/Persona/listarPersona',
							id: 'id_persona',
							root: 'datos',
							sortInfo:{
								field: 'nombre_completo1',
								direction: 'ASC'
							},
							totalProperty: 'total',
							fields: ['id_persona','nombre_completo1','ci'],
							// turn on remote sorting
							remoteSort: true,
							baseParams: Ext.apply({par_filtro:'nombre_completo1#ci'},config.baseParams)
						}),
		   				valueField: 'id_persona',
		   				displayField: 'nombre_completo1',
		   				
		   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre_completo1}</p><p>CI:{ci}</p> </div></tpl>',
		   				hiddenName: 'id_persona',
		   				forceSelection:true,
		   				typeAhead: true,
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
	    	if(config.origen=='USUARIO'){
	    		
	    		configini={
				    		origen:'USUARIO',
				    		tinit:false,
				    		tasignacion:true,
				    		tname:'id_usuario',
	    			        tdisplayField:'cuenta',
							name: 'id_usuario',
							fieldLabel: 'Usuario',
							allowBlank: false,
							emptyText:'Usuario...',
							store:new Ext.data.JsonStore(
							{
								url: '../../sis_seguridad/control/Usuario/listarUsuario',
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
							
							//hiddenName: 'id_administrador',
							forceSelection:true,
							typeAhead: true,
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
		       			    tasignacion:false,
		       			    //tname:'id_uo',
	    			        //tdisplayField:'cuenta',
		       				allowBlank:false,
		       				emptyText:'Unidad...',
		       				store: new Ext.data.JsonStore({
								url: '../../sis_recursos_humanos/control/Uo/listarUo',
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
		    					
		    					baseParams: Ext.apply({par_filtro:'nombre_unidad'},config.baseParams)
		    				}),
		       				valueField: 'id_uo',
		       				displayField: 'nombre_unidad',
		       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre_unidad}</p> </div></tpl>',
		       				hiddenName: 'id_uo',
		       				forceSelection:true,
		       				typeAhead: true,
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
	    	else if(config.origen=='FUNCIONARIOCAR'){
	    		
	    		configini={
		       				name:'id_funcionario',
		       			    tinit:false,
		       			    tasignacion:false,
		       			    emptyText:'Funcionario...',
		       				store: new Ext.data.JsonStore({  
			    					url: '../../sis_recursos_humanos/control/Funcionario/listarFuncionarioCargo',
		    					id: 'id_uo',
		    					root: 'datos',
		    					sortInfo:{
		    						field: 'desc_funcionario1', 
		    						direction: 'ASC'
		    					},
		    					totalProperty: 'total',
		    					fields: ['id_funcionario','id_uo','codigo','nombre_cargo','desc_funcionario1','email_empresa'],
		    					// turn on remote sorting
		    					remoteSort: true,
		    					baseParams: Ext.apply({par_filtro:'desc_funcionario1#email_empresa#codigo#nombre_cargo',estado_reg_asi:'activo'},config.baseParams)
		    					
		    				}),
		       				valueField: 'id_uo',
		       				displayField: 'desc_funcionario1',
		       				tpl:'<tpl for="."><div class="x-combo-list-item"><p> {codigo} {desc_funcionario1}</p><p>{nombre_cargo}</p><p>{email_empresa}</p> </div></tpl>',
		       				hiddenName: 'id_funcionario',
		       				forceSelection:true,
		       				typeAhead: true,
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
         
	    	else if(config.origen=='FUNCIONARIO'){
	    		
	    		configini=	{
		       				
		       				name:'id_funcionario',
		       			    tinit:false,
		       			    tasignacion:true,
		       			    tname:'id_funcionario',
	    			        tdisplayField:'desc_person',
		       				allowBlank:false,
		       				turl:'../../../sis_recursos_humanos/vista/funcionario/funcionario.php',
				   			ttitle:'Funcionarios',
				   			   // tconfig:{width:1800,height:500},
				   			tdata:{},
				   			tcls:'funcionario',
				   			pid:this.idContenedor,
		       				allowBlank:false,
		       				emptyText:'Funcionario...',
		       				store: new Ext.data.JsonStore({
		    					url: '../../sis_recursos_humanos/control/Funcionario/listarFuncionario',
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
		       				typeAhead: true,
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
	    			        tasignacion:false,
		       			    
			   				fieldLabel:'Gestion',
			   				allowBlank:true,
			   				emptyText:'Gestion...',
			   				store: new Ext.data.JsonStore({
			                    url: '../../sis_parametros/control/Gestion/listarGestion',
								id: 'id_gestion',
								root: 'datos',
								sortInfo:{
									field: 'gestion',
									direction: 'ASC'
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
			   				typeAhead: true,
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
	    			        
	    			        tasignacion:false,
			   				name:'id_depto',
			   				fieldLabel:'Departamento',
			   				allowBlank:true,
			   				emptyText:'Departamento...',
			   				store: new Ext.data.JsonStore({
			                     url: '../../sis_parametros/control/Depto/listarDepto',
								id: 'id_depto',
								root: 'datos',
								sortInfo:{
									field: 'nombre',
									direction: 'ASC'
								},
								totalProperty: 'total',
								fields: ['id_depto','nombre'],
								// turn on remote sorting
								remoteSort: true,
								baseParams:Ext.apply({par_filtro:'nombre'},config.baseParams)
							}),
			   				valueField: 'id_depto',
			   				displayField: 'nombre',
			   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p></div></tpl>',
			   				hiddenName: 'id_depto',
			   				forceSelection:true,
			   				typeAhead: true,
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
			                    url: '../../sis_parametros/control/Moneda/listarMoneda',
								id: 'id_moneda',
								root: 'datos',
								sortInfo:{
									field: 'moneda',
									direction: 'ASC'
								},
								totalProperty: 'total',
								fields: ['id_moneda','moneda','codigo'],
								// turn on remote sorting
								remoteSort: true,
								baseParams:Ext.apply({par_filtro:'moneda#codigo'},config.baseParams)
							}),
			   				valueField: 'id_moneda',
			   				displayField: 'moneda',
			   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Moneda:{moneda}</p><p>Codigo:{codigo}</p> </div></tpl>',
			   				hiddenName: 'id_moneda',
			   				forceSelection:true,
			   				typeAhead: true,
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
	    	
	    	
	    	if(config.origen=='CAJERO'){
	    		
	    		
	    		
	    		
	    	}
	       if(config.origen=='INSTITUCION'){
	    		
	    		configini={
	    			 origen:'INSTITUCION',
	    			 tinit:false,
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
							url: '../../sis_parametros/control/Institucion/listarInstitucion',
							id: 'id_institucion',
							root: 'datos',
							sortInfo:{
								field: 'nombre',
								direction: 'ASC'
							},
							totalProperty: 'total',
							fields: ['id_institucion','nombre','doc_id','codigo'],
							// turn on remote sorting
							remoteSort: true,
							baseParams: Ext.apply({par_filtro:'instit.codigo#instit.nombre#instit.doc_id'},config.baseParams)
							
						}),
		   				valueField: 'id_institucion',
		   				displayField: 'nombre',
		   				
		   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo}-{nombre}</p><p>NIT:{doc_id}</p> </div></tpl>',
		   				hiddenName: 'id_institucion',
		   				forceSelection:true,
		   				typeAhead: true,
		       			triggerAction: 'all',
		       			lazyRender:true,
		   				mode:'remote',
		   				pageSize:10,
		   				queryDelay:1000,
		   				width:250,
		   				minChars:2,
		   				listWidth:'280'
		   				
	           }
	    	}
	    	
	    	
	    	 
	    if(config.origen=='PROVEEDOR'){
	    		
	    		configini={
	    			 origen:'PROVEEDOR',
	    			 tinit:false,
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

							url: '../../sis_parametros/control/Proveedor/listarProveedorCombos',
							id: 'id_proveedor',
							root: 'datos',
							sortInfo:{
								field: 'desc_proveedor',
								direction: 'ASC'
							},
							totalProperty: 'total',
							fields: ['id_proveedor','desc_proveedor','codigo','nit'],
							// turn on remote sorting
							remoteSort: true,
							baseParams:Ext.apply({par_filtro:'desc_proveedor#codigo#nit'},config.baseParams)
							
						}),
		   				valueField: 'id_proveedor',
   				        displayField: 'desc_proveedor',
		   			    tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo}</p><p>{desc_proveedor}</p><p>NIT:{nit}</p> </div></tpl>',
   					    hiddenName: 'id_proveedor',
		   				forceSelection:true,
		   				typeAhead: true,
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
    			 tasignacion:false,
		         name:'id_clasificador',
	   			 fieldLabel:'Clasificacion',
	   				allowBlank:false,
	   				emptyText:'Clasificador...',
	   				store: new Ext.data.JsonStore({

    					url: '../../sis_seguridad/control/Clasificador/listarClasificador',
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
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				width:250,
       				minChars:2
    		}
    		

    	}
      
         Ext.apply(configini,config);
         Ext.apply(this,configini);
         
      //Ext.form.ComboRec.superclass.initComponent.call(configini);  
      Ext.form.ComboRec.superclass.constructor.call(this);  
        
       
       };

Ext.form.ComboRec = Ext.extend(Ext.form.ComboRec,Ext.form.TrigguerCombo,{})
	
	
