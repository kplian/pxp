<?php
/**
*@package pXP
*@file gen-ProcesoWf.php
*@author  (admin)
*@date 18-04-2013 09:01:51
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ProcesoInstancia = Ext.extend(Phx.gridInterfaz,{
		Atributos : [],
		nombreVista : 'ProcesoInstancia',
		btnReclamar: false,
		
		constructor:function(config) {			
			this.config = config;
			this.formulario_wizard = 'no';
			
			//configuraciones iniciales
			this.maestro=config.maestro;
			this.configProceso = config.configProceso;
			
			//funcionalidad para listado de historicos
        	this.historico = 'no';
        	if (this.configProceso[this.config.indice].atributos.vista_tipo == 'maestro') {
	        	this.tbarItems = ['-',{
	            text: 'Histórico',
	            enableToggle: true,
	            pressed: false,
	            toggleHandler: function(btn, pressed) {               
	                if(pressed){
	                    this.historico = 'si';
	                     this.desBotoneshistorico();
	                }
	                else{
	                   this.historico = 'no' 
	                }
	                
	                this.store.baseParams.historico = this.historico;
	                this.onButtonAct();
	             },
	            scope: this
	           }];
	       }
           this.armaColumnas();	        			
			//armar ordenacion y otros detalles
			this.armaOrdenacionyOtros();
			this.armaDetalles();			
	        //llama al constructor de la clase padre
	    	Phx.vista.ProcesoInstancia.superclass.constructor.call(this,config);
	    	this.init();			
			this.iniciarEventos();	 
			this.cargarBotones();
            this.argumentExtraSubmit = {id_tabla : this.configProceso[this.config.indice].atributos.id_tabla,tipo_proceso :this.config.proceso,tipo_estado:this.config.estado};
			this.store.baseParams.id_tabla = this.configProceso[this.config.indice].atributos.id_tabla;
			this.store.baseParams.tipo_proceso = this.config.proceso;  
			this.store.baseParams.tipo_estado = this.config.estado;
			if (this.configProceso[this.config.indice].atributos.vista_tipo != 'detalle') {
				this.load({params:{start:0, limit:50}}); 
			}
						
		},	
		
		armaDetalles : function() {
			var detalles = this.configProceso[this.config.indice].detalles
			for (var i = 0 ; i<detalles.length; i++ ) {
				
				if (detalles[i].atributos.vista_tipo == 'detalle') {
					
					//cambiar por la tabla el proceso y el estado
					var clase_generada = detalles[i].atributos.bd_nombre_tabla + '_' + this.config.proceso + '_' + this.config.estado;
	        		 	
					Phx.vista[clase_generada] = {};
					if (detalles[i].atributos.vista_scripts_extras != '' && 
				        detalles[i].atributos.vista_scripts_extras != undefined && 
				        detalles[i].atributos.vista_scripts_extras != null) {
				        Ext.apply(Phx.vista[clase_generada], Ext.util.JSON.decode(Ext.util.Format.trim(detalles[i].atributos.vista_scripts_extras)));
					} 
					
				  	eval('Phx.vista[clase_generada]= Ext.extend(Phx.vista.ProcesoInstancia,Phx.vista[clase_generada])');
				  	
					//aqui se define los detalles tipo south, tabsouth, east, etc.
					this[detalles[i].atributos.vista_posicion] = {
						url:'../../../sis_workflow/vista/proceso_instancia/ProcesoInstancia.php',
					  	title:detalles[i].atributos.bd_descripcion, 
					  	height:'50%',
					  	cls:clase_generada,
					  	params: {
					  		proceso: this.config.proceso,
					  		estado: this.config.estado,
					  		indice: i,
					  		configProceso : detalles}
					  };
				}
			}
			
		},
		
		loadValoresIniciales:function()
	    {
	    	
	    	if (this.configProceso[this.config.indice].atributos.vista_tipo != 'maestro') {
	        	this.Cmp[this.configProceso[this.config.indice].atributos.vista_campo_maestro].setValue(this.maestro[this.configProceso[this.config.indice].atributos.vista_campo_maestro]);
	        } 
	        Phx.vista.ProcesoInstancia.superclass.loadValoresIniciales.call(this);
	    },
		
		armaOrdenacionyOtros : function() {
			this.title = this.configProceso[this.config.indice].atributos.menu_nombre;
			this.sortInfo = {
				field: this.configProceso[this.config.indice].atributos.vista_campo_ordenacion,
				direction: this.configProceso[this.config.indice].atributos.vista_dir_ordenacion
			};
			//verificar el boton de edicion y el boton de eliminacion
			var estados_new = this.configProceso[this.config.indice].atributos.vista_estados_new.split(',');
			var estados_delete = this.configProceso[this.config.indice].atributos.vista_estados_delete.split(',');
			
			if (estados_new.indexOf(this.config.estado) != -1) {
				this.bnew = true;
			} else {
				this.bnew = false;
			}
			
			if (estados_delete.indexOf(this.config.estado) != -1) {
				this.bdel = true;
			} else {
				this.bdel = false;
			}
			this.id_store = 'id_' + this.configProceso[this.config.indice].atributos.bd_nombre_tabla;
		},
		
		cargarBotones : function () { 
			if (this.configProceso[this.config.indice].atributos.vista_tipo == 'maestro') {
				this.addButton('btnChequeoDocumentosWf',
		            {
		                text: 'Documentos del Proceso',
		                iconCls: 'bchecklist',
		                disabled: true,
		                handler: this.loadCheckDocumentosWf,
		                tooltip: '<b>Documentos del Proceso</b><br/>Subir los documetos requeridos en el proceso seleccionado.'
		            }
		        ); 
		        
		       this.addButton('diagrama_gantt',{text:'Diagrama Gantt',iconCls: 'bgantt',disabled:true,handler:this.diagramGantt,tooltip: '<b>Diagrama Gantt de proceso macro</b>'});
		       this.addButton('imprimir_tramite',{text:'Imprimir #',iconCls: 'bpdf32',disabled:true,handler:this.imprimirTramite,tooltip: '<b>Imprime el # de Trámite</b>'});
		  
		     
		        this.addButton('ant_estado',{
		                    text:'Anterior',
		                    iconCls:'batras',
		                    disabled:true,
		                    handler:this.openAntFormEstadoWf,
		                    tooltip: '<b>Retroceder un estado</b>'});
		        
		        
		        this.addButton('sig_estado',{
		                    text:'Siguiente',
		                    iconCls:'badelante',
		                    disabled:true,
		                    handler:this.openFormEstadoWf,
		                    tooltip: '<b>Cambiar al siguientes estado</b>'});
		         this.addButton('btnObs',{
                    text :'Observaciones al Trámite',
                    iconCls : 'bchecklist',
                    disabled: true,
                    handler : this.onOpenObs,
                    tooltip : '<b>Observaciones</b><br/><b>Observaciones del WF</b>'
                });
                
                if(this.btnReclamar) {
                    this.addButton('btnReclamar',
                        {
                            text: 'Reclamar Caso',
                            iconCls: 'bchecklist',
                            disabled: true,
                            handler: this.ReclamarCaso,
                            tooltip: '<b>Reclamar caso</b><br/>Autoasignarse la realización de la tarea seleccionada.'
                        }
                    ); 
                }
                		                 
			}
		},
		
		armaColumnas : function () {
				
			//iniciar store
			this.fields = [
				{name:'id_' + this.configProceso[this.config.indice].atributos.bd_nombre_tabla, type: 'numeric'},
				{name:'id_proceso_wf', type: 'numeric'},
				{name:'id_estado_wf', type: 'numeric'},
				{name:'id_usuario_reg', type: 'numeric'},
				{name:'id_usuario_mod', type: 'numeric'},
				{name:'estado_reg', type: 'string'},
				{name:'estado', type: 'string'},
				{name:'obs', type: 'string'},
				{name:'nro_tramite', type: 'string'},
				{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},				
				{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
				{name:'usr_reg', type: 'string'},
				{name:'usr_mod', type: 'string'},
				{name:'tiene_observaciones', type: 'numeric'},
				{name:'desc_funcionario', type: 'string'}];
			
			this.Atributos = [];			
			this.Atributos.push({
				//configuracion del componente
				config:{
						labelSeparator:'',
						inputType:'hidden',
						name: 'id_' + this.configProceso[this.config.indice].atributos.bd_nombre_tabla
				},
				type:'Field',
				form:true 
			});
			if (this.configProceso[this.config.indice].atributos.vista_tipo != 'maestro') {
				this.Atributos.push({
					//configuracion del componente
					config:{
							labelSeparator:'',
							inputType:'hidden',
							name: this.configProceso[this.config.indice].atributos.vista_campo_maestro
					},
					type:'Field',
					form:true 
				});
			}
			
			this.Atributos.push({
				//configuracion del componente
				config:{
						labelSeparator:'',
						inputType:'hidden',
						name: 'id_proceso_wf'
				},
				type:'Field',
				form:true 
			});
			
			this.Atributos.push({
				//configuracion del componente
				config:{
						labelSeparator:'',
						inputType:'hidden',
						name: 'id_estado_wf'
				},
				type:'Field',
				form:true 
			});
			
			this.Atributos.push({
				//configuracion del componente
				config:{
	                name: 'nro_tramite',
	                fieldLabel: 'Nro Trámite',	                
	                gwidth: 130,
	                renderer:function (value,p,record){
	                   if (record.data.tiene_observaciones == 1) {
	                        return String.format('<div title="Tiene observaciones abiertas para este tramite"><b><font color="red">{0}</font></b></div>', value);
	                   } else {
	                       return  value;
	                   } 
	               }
	            },
	            type:'TextField',
	            filters:{pfiltro:'pw.nro_tramite',type:'string'},	            
	            grid:true,
	            form:false,
	            bottom_filter: true 
				});
			
			this.Atributos.push({
                //configuracion del componente
                config:{
                    name: 'desc_funcionario',
                    fieldLabel: 'Asignado a',                   
                    gwidth: 130
                },
                type:'TextField',
                filters:{pfiltro:'fun.desc_funcionario2',type:'string'},
                id_grupo:0,
                grid:true,
                form:false 
                }); 
			
			this.Atributos.push({
				//configuracion del componente
				config:{
	                name: 'obs',
	                fieldLabel: 'Observaciones del Estado Anterior',	                
	                gwidth: 170,
	                anchor:'80%',
	                readOnly:true,
	                allowBlank:true
	            },
	            type:'TextArea',
	            filters:{pfiltro:'ew.obs',type:'string'},
	            id_grupo:1,
	            grid:true,
	            form:true 
				});
						
			for (var i = 0 ;i < this.configProceso[this.config.indice].columnas.length; i++) {
				
				if (this.configProceso[this.config.indice].columnas[i].momento != 'ninguno') {
					
					//anadir campo en el store
					this.addStoreField(this.configProceso[this.config.indice].columnas[i]);
					var filter_name =  this.configProceso[this.config.indice].atributos.bd_codigo_tabla + '.' + this.configProceso[this.config.indice].columnas[i].bd_nombre_columna
					
					//anadir campo como atributo
					var config_columna = {
						config : {
							anchor: '100%',
		                	gwidth: 100,
		                	allowBlank: true
		                },
		                id_grupo : 1,
		                grid : true,
		                filters : {pfiltro : filter_name , type:'string'},
		                form: false};
		            config_columna.config.name = this.configProceso[this.config.indice].columnas[i].bd_nombre_columna;
		            
		            
		            if (this.configProceso[this.config.indice].columnas[i].form_grupo != '' && 
		            this.configProceso[this.config.indice].columnas[i].form_grupo != null &&
		            this.configProceso[this.config.indice].columnas[i].form_grupo != undefined) {		            	
		            	config_columna.id_grupo = this.configProceso[this.config.indice].columnas[i].form_grupo;
		            }
		            if (this.configProceso[this.config.indice].columnas[i].bd_descripcion_columna != '' && 
		            		this.configProceso[this.config.indice].columnas[i].bd_descripcion_columna != undefined &&
		            		this.configProceso[this.config.indice].columnas[i].bd_descripcion_columna != null) {
		            	config_columna.config.qtip = this.configProceso[this.config.indice].columnas[i].bd_descripcion_columna;
		            }
		            config_columna.config.fieldLabel = this.configProceso[this.config.indice].columnas[i].form_label;
		            config_columna.type = this.configProceso[this.config.indice].columnas[i].form_tipo_columna;
		            
		            		            
		            //validar el tamaño del campo en caso de que sea varchar, numeric o integer
		            if (this.configProceso[this.config.indice].columnas[i].bd_tipo_columna == 'varchar') {
		            	if (this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != '' && 
		            		this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != undefined
		            		&& this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != null) {
		            			config_columna.config.maxLength = this.configProceso[this.config.indice].columnas[i].bd_tamano_columna;
		            		
		            	}
		            } else if (this.configProceso[this.config.indice].columnas[i].bd_tipo_columna == 'integer') {
		            	config_columna.config.maxLength = 9;
		            } else if (this.configProceso[this.config.indice].columnas[i].bd_tipo_columna == 'bigint') {
		            	config_columna.config.maxLength = 18;
		            } else if (this.configProceso[this.config.indice].columnas[i].bd_tipo_columna == 'numeric') {
		            	if (this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != '' && 
		            		this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != undefined &&
		            		this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != null) {
		            			var aux_array = this.configProceso[this.config.indice].columnas[i].bd_tamano_columna.split('_');
		            			config_columna.config.maxLength = aux_array[0];
		            			if (aux_array[1] != undefined) {
		            				config_columna.config.decimaPrecision = aux_array[1];
		            			}
		            		
		            	}
		            }
		            
		            //Verificar si se trata de un comborec o un combobox
		            if (this.configProceso[this.config.indice].columnas[i].form_es_combo == 'si') {
		            	config_columna.type = 'ComboBox';
		            	config_columna.config.maxLength = 500;
		            }
		            
		            if (this.configProceso[this.config.indice].columnas[i].form_combo_rec != '' && 
		            	this.configProceso[this.config.indice].columnas[i].form_combo_rec != undefined &&
		            	this.configProceso[this.config.indice].columnas[i].form_combo_rec != null) {
		            	
		            	console.log('asas 2',this.configProceso[this.config.indice].columnas[i])
		            	config_columna.config.origen = this.configProceso[this.config.indice].columnas[i].form_comborec;
		            	config_columna.type = 'ComboRec';
		            	config_columna.config.maxLength = 500;
		            }

		            //RCM: verifica si es un combo con tipo de dato array para predefinir el componente a AwsomeCombo
		            var tipoDato = this.configProceso[this.config.indice].columnas[i].bd_tipo_columna_comp;
		            if(this.configProceso[this.config.indice].columnas[i].form_es_combo == 'si'&&(tipoDato=='integer[]'||tipoDato=='varchar[]')){
		                config_columna.type = 'AwesomeCombo';
		            } 
		            
		            
		            //Añadir la sobreescritura de config y filtro
		            if (this.configProceso[this.config.indice].columnas[i].form_sobreescribe_config != '' && 
		            	this.configProceso[this.config.indice].columnas[i].form_sobreescribe_config != undefined &&
		            	this.configProceso[this.config.indice].columnas[i].form_sobreescribe_config != null) {
			            var custom_config = Ext.util.JSON.decode(Ext.util.Format.trim(this.configProceso[this.config.indice].columnas[i].form_sobreescribe_config));
			            config_columna = Phx.CP.merge(config_columna,custom_config);
			            console.log(config_columna.config);
			            //Ext.apply(config_columna.config,custom_config);
			        }
			        if (this.configProceso[this.config.indice].columnas[i].grid_sobreescribe_filtro != '' && 
		            	this.configProceso[this.config.indice].columnas[i].grid_sobreescribe_filtro != undefined &&
		            	this.configProceso[this.config.indice].columnas[i].grid_sobreescribe_filtro != null) {
			            var custom_filter = Ext.util.JSON.decode(Ext.util.Format.trim(this.configProceso[this.config.indice].columnas[i].grid_sobreescribe_filtro));
			            Ext.apply(config_columna.filters,custom_filter);
			        }
			        //verificar si entra al formulario y si es obligatorio
		            if (this.configProceso[this.config.indice].columnas[i].momento == 'registrar') {
		            	config_columna.form = true; 
		            } else if (this.configProceso[this.config.indice].columnas[i].momento == 'exigir') {
		            	config_columna.form = true;
		            	config_columna.config.allowBlank = false;
		            } else if (this.configProceso[this.config.indice].columnas[i].momento == 'mostrar_formulario') {
		            	config_columna.form = true;
		            	config_columna.config.readOnly = true;
		            }
		            
			        this.Atributos.push(config_columna);			        
			    }
	            	            
	            
			} //termina for de columnas
			
			this.Atributos.push({
				//configuracion del componente
				config:{
	                name: 'estado',
	                fieldLabel: 'Estado',	                
	                gwidth: 100
	            },
	            type:'TextField',
	            filters:{pfiltro:'usu1.cuenta',type:'string'},
	            id_grupo:0,
	            grid:true,
	            form:false 
				});
				
			this.Atributos.push({
				//configuracion del componente
				config:{
	                name: 'usr_reg',
	                fieldLabel: 'Creado por',	                
	                gwidth: 100
	            },
	            type:'TextField',
	            filters:{pfiltro:'usu1.cuenta',type:'string'},
	            id_grupo:0,
	            grid:true,
	            form:false 
				});
			
			this.Atributos.push({
				//configuracion del componente
				config:{
	                name: 'estado_reg',
	                fieldLabel: 'Estado Reg.',
	                gwidth: 100
	            },
	            type:'TextField',
	            filters:{pfiltro:this.configProceso[this.config.indice].atributos.bd_codigo_tabla + '.estado_reg',type:'string'},
	            id_grupo:0,
	            grid:true,
	            form:false 
				});
				
			this.Atributos.push({
				//configuracion del componente
				config:{
	                name: 'fecha_mod',
	                fieldLabel: 'Fecha Modif',	                
	                gwidth: 100,
					renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
	            },
	            type:'DateField',
	            filters:{pfiltro:this.configProceso[this.config.indice].atributos.bd_codigo_tabla + '.fecha_mod',type:'date'},
	            id_grupo:0,
	            grid:true,
	            form:false 
				});
			
			this.Atributos.push({
				//configuracion del componente
				config:{
	                name: 'usr_mod',
	                fieldLabel: 'Modificado por',	                
	                gwidth: 100
	            },
	            type:'TextField',
	            filters:{pfiltro:'usu2.cuenta',type:'string'},
	            id_grupo:0,
	            grid:true,
	            form:false 
				});	
					
		
		},
		addStoreField : function (config_columna) {
			//si es numeric
			if (config_columna.bd_tipo_columna == 'numeric' || config_columna.bd_tipo_columna == 'integer' || config_columna.bd_tipo_columna == 'bigint') {
				this.fields.push({name: config_columna.bd_nombre_columna,
								type: 'numeric'});
			}
			//si es string
			if (config_columna.bd_tipo_columna == 'varchar' || config_columna.bd_tipo_columna == 'text') {
				this.fields.push({name: config_columna.bd_nombre_columna,
								type: 'string'});
			}
			//si es date
			if (config_columna.bd_tipo_columna == 'date' ) {
				this.fields.push({name: config_columna.bd_nombre_columna,
								type: 'date', dateFormat:'Y-m-d'});
			}
			
			//si es timepstamp
			if (config_columna.bd_tipo_columna == 'timestamp' ) {
				this.fields.push({name: config_columna.bd_nombre_columna,
								type: 'date', dateFormat:'Y-m-d H:i:s.u'});
			}
			
			//si es boolean
			if (config_columna.bd_tipo_columna == 'boolean' ) {
				this.fields.push({name: config_columna.bd_nombre_columna,
								type: 'boolean'});
			}
			
			//add extra fields
			if (config_columna.grid_campos_adicionales != '' && 
		        config_columna.grid_campos_adicionales != undefined &&
		        config_columna.grid_campos_adicionales != null) {
				var aux_extra_fields = config_columna.grid_campos_adicionales.split(',');
				
				for (var i = 0; i < aux_extra_fields.length; i++) {
					var aux_extra_fields_definition = aux_extra_fields[i].split(' ');
					if (aux_extra_fields_definition[1] == 'date') {
						this.fields.push({name: aux_extra_fields_definition[0],
								type: aux_extra_fields_definition[1], dateFormat:aux_extra_fields_definition[2]});
					} else {
						this.fields.push({name: aux_extra_fields_definition[0],
								type: aux_extra_fields_definition[1]});
					}
				}
			}
			
			//add subquerys fields
            if (config_columna.bd_campos_subconsulta != '' && 
                config_columna.bd_campos_subconsulta != undefined &&
                config_columna.bd_campos_subconsulta != null) {
                var aux_subquery_fields = config_columna.bd_campos_subconsulta.split(';');
                
                for (var i = 0; i < aux_subquery_fields.length; i++) {
                    var ind = aux_subquery_fields[i].lastIndexOf(' ');
                    var aux_extra_fields_definition = new Array();
                    
                    //Obtiene la cadena del tipo de dato, desde el indice encontrado hasta el final de la cadena
                    var aux = aux_subquery_fields[i].substring(0,ind);
                    aux_extra_fields_definition[1] = aux_subquery_fields[i].substring(ind+1,aux_subquery_fields[i].length)
                    //Obtiene la cadena del medio con el nombre de la columna
                    ind = aux.lastIndexOf(' ');
                    aux_extra_fields_definition[0] = aux.substring(ind+1,aux.length);
                    
                    if (aux_extra_fields_definition[1] == 'date') {
                        this.fields.push({name: aux_extra_fields_definition[0],
                                type: aux_extra_fields_definition[1], dateFormat:aux_extra_fields_definition[2]});
                    } else {
                        this.fields.push({name: aux_extra_fields_definition[0],
                                type: aux_extra_fields_definition[1]});
                    }
                }
            }
		},
		
	    diagramGantt:function (){         
            var data=this.sm.getSelected().data.id_proceso_wf;
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                url:'../../sis_workflow/control/ProcesoWf/diagramaGanttTramite',
                params:{'id_proceso_wf':data},
                success:this.successExport,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });         
		},
		
		imprimirTramite:function (){         
            var data=this.sm.getSelected().data;
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                url:'../../sis_workflow/control/ProcesoWf/imprimirNumeroTramite',
                params:{'id_proceso_wf':data.id_proceso_wf, 'nro_tramite' : data.nro_tramite},
                success:this.successExport,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });         
		},
		tam_pag:50,
		ActSave:'../../sis_workflow/control/Tabla/insertarTablaInstancia',
		ActDel:'../../sis_workflow/control/Tabla/eliminarTablaInstancia',
		ActList:'../../sis_workflow/control/Tabla/listarTablaInstancia',
		loadCheckDocumentosWf:function() {
	            var rec=this.sm.getSelected();
	            rec.data.nombreVista = this.nombreVista;
	            
	            if ('gruposBarraTareasDocumento' in this) {	            	
	            	rec.data.gruposBarraTareas = this.gruposBarraTareasDocumento;
	            }
	            
	            if (this.formulario_wizard == 'si') {
	            	rec.data.tipo = 'proins'
	            } 
	            Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/DocumentoWf.php',
	                    'Documentos del Proceso',
	                    {
	                        width:'90%',
	                        height:500
	                    },
	                    rec.data,
	                    this.idContenedor,
	                    'DocumentoWf',
	                    {
	                        config:[{
	                                  event:'sigestado',
	                                  delegate: this.openFormEstadoWf,
	                                  
	                                }],
	                        
	                        scope:this
	                     }
	       );
	       this.formulario_wizard = 'no';
	    },
	    onAntEstado:function(wizard,resp){
	            Phx.CP.loadingShow();
	            Ext.Ajax.request({
	                url:'../../sis_workflow/control/ProcesoWf/anteriorEstadoProcesoWf',
	                params:{id_proceso_wf:resp.id_proceso_wf, 
	                        id_estado_wf:resp.id_estado_wf, 
	                        operacion: 'cambiar',
	                        obs:resp.obs},
	                argument:{wizard:wizard},        
	                success:this.successSincAnt,
	                failure: this.conexionFailure,
	                timeout:this.timeout,
	                scope:this
	            }); 
	     },
	    
	    
	    successSincAnt:function(resp){
	        Phx.CP.loadingHide();
	        resp.argument.wizard.panel.destroy()
	        this.reload();
	     },
	     
	     openFormEstadoWf:function() {
        
	        var rec=this.sm.getSelected();	
     
	            Phx.CP.loadWindows('../../../sis_workflow/vista/estado_wf/FormEstadoWf.php',
	            'Estado de Wf',
	            {
	                modal:true,
	                width:700,
	                height:450
	            }, {data:rec.data}, this.idContenedor,'FormEstadoWf',
	            {
	                config:[{
	                          event:'beforesave',
	                          delegate: this.onSaveWizard,
	                          
	                        },
	                        {
	                          event:'requirefields',
	                          delegate: function () {
		                          	this.onButtonEdit();
						        	this.window.setTitle('Registre los campos antes de pasar al siguiente estado');
						        	this.formulario_wizard = 'si';
	                          },
	                          
	                        }],
	                
	                scope:this
	             });	        
	    },	    
	    openAntFormEstadoWf:function(){
	         var rec=this.sm.getSelected();
	            Phx.CP.loadWindows('../../../sis_workflow/vista/estado_wf/AntFormEstadoWf.php',
	            'Estado de Wf',
	            {
	                modal:true,
	                width:450,
	                height:250
	            }, {data:rec.data}, this.idContenedor,'AntFormEstadoWf',
	            {
	                config:[{
	                          event:'beforesave',
	                          delegate: this.onAntEstado,
	                        }
	                        ],
	               scope:this
	             })
	   },
	   
	   
	   successSave : function(resp){
	    	Phx.vista.ProcesoInstancia.superclass.successSave.call(this,resp);
	    	if (this.formulario_wizard == 'si') {
	    		this.openFormEstadoWf();	    		
	    		this.formulario_wizard = 'no';	    		
	    	}
	    	
	    },
	    
	   
	    successWizard:function(resp){
	        Phx.CP.loadingHide();
	        resp.argument.wizard.panel.destroy()
	        this.reload();
	     },
	    
	    onSaveWizard:function(wizard,resp){	        
	        Phx.CP.loadingShow();
	        Ext.Ajax.request({
	            url:'../../sis_workflow/control/ProcesoWf/siguienteEstadoProcesoWf',
	            params:{
	                
	                id_proceso_wf_act:  resp.id_proceso_wf_act,
	                id_estado_wf_act:  resp.id_estado_wf_act,
	                id_tipo_estado:     resp.id_tipo_estado,
	                id_funcionario_wf:  resp.id_funcionario_wf,
	                id_depto_wf:        resp.id_depto_wf,
	                obs:                resp.obs,
	                json_procesos:      Ext.util.JSON.encode(resp.procesos)
	                },
	            success:this.successWizard,
	            failure: this.conexionFailure,
	            argument:{wizard:wizard},
	            timeout:this.timeout,
	            scope:this
	        });
	         
	    },
	    
	    onReloadPage:function(m){       
			this.maestro=m;
			var parametros = {};
			parametros['start'] = 0;
			parametros['limit'] = this.tam_pag;
			parametros[this.configProceso[this.config.indice].atributos.vista_campo_maestro] = 
						this.maestro[this.configProceso[this.config.indice].atributos.vista_campo_maestro];
			
			this.load({params:parametros});	
		},
	    
	    //deshabilitas botones para informacion historica
	    desBotoneshistorico:function(){
	          
	          this.getBoton('ant_estado').disable();
	          this.getBoton('sig_estado').disable();
	          
	          if(this.bedit){
	            this.getBoton('edit').disable();  
	          }
	          
	          if(this.bdel){
	               this.getBoton('del').disable();
	          }
	          if(this.bnew){
	               this.getBoton('new').disable();
	          }	          
	    },
	    
	    preparaMenu:function(n){
	      var data = this.getSelectedData();
	      var tb =this.tbar;
	      Phx.vista.ProcesoInstancia.superclass.preparaMenu.call(this,n); 
	      if (this.configProceso[this.config.indice].atributos.vista_tipo == 'maestro') {
		     this.getBoton('btnChequeoDocumentosWf').setDisabled(false);
		     this.getBoton('diagrama_gantt').enable();
		     this.getBoton('imprimir_tramite').enable();
		     this.getBoton('btnObs').enable();  
		       if(this.historico == 'no'){
		          
		          this.getBoton('sig_estado').enable();
		          this.getBoton('ant_estado').enable(); 
		          this.getBoton('btnReclamar').enable();         
		          
		          if(data.estado == 'borrador' ){ 
		             this.getBoton('ant_estado').disable();
		           
		          }
		          
		          if(data.estado == 'finalizado' || data.estado =='anulado'){
		          	
		               this.getBoton('sig_estado').disable();
		               //this.getBoton('ant_estado').disable();
		               this.getBoton('btnReclamar').disable();
		          }
		       }   
		      else{
		          this.desBotoneshistorico();
		          
		      }
		  }    
	      return tb;
	    },
	    
	    liberaMenu:function(){
	        var tb = Phx.vista.ProcesoInstancia.superclass.liberaMenu.call(this);
	        if (this.configProceso[this.config.indice].atributos.vista_tipo == 'maestro') {
		        this.getBoton('btnChequeoDocumentosWf').setDisabled(true);
		        if(tb){
		            this.getBoton('sig_estado').disable();
		            this.getBoton('btnObs').disable();  
		            this.getBoton('ant_estado').disable();
		            this.getBoton('diagrama_gantt').disable();
		            this.getBoton('imprimir_tramite').disable();
		            this.getBoton('btnReclamar').disable();
		        }
		    }
	        return tb
	    },
	    onButtonNew:function(){
			//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
			this.window.setTitle(this.configProceso[this.config.indice].atributos.menu_nombre);
			this.ocultarComponente(this.Cmp.obs);
			Phx.vista.ProcesoInstancia.superclass.onButtonNew.call(this);
		},
		onButtonEdit:function(){
			//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
			this.window.setTitle(this.configProceso[this.config.indice].atributos.menu_nombre);
			this.mostrarComponente(this.Cmp.obs);
			Phx.vista.ProcesoInstancia.superclass.onButtonEdit.call(this);
		},
		
		ReclamarCaso: function(){
		    var rec=this.sm.getSelected();
		    rec.data.reclaim= true;
		             
            Phx.CP.loadWindows('../../../sis_workflow/vista/estado_wf/FormEstadoWf.php',
            'Estado de Wf',
            {
                modal:true,
                width:700,
                height:450
            }, {data:rec.data}, this.idContenedor,'FormEstadoWf',
            {
                config:[{
                          event:'beforesave',
                          delegate: this.onSaveWizard,
                          
                        }],
                scope:this
             });     
		},
		
		onOpenObs:function() {
            var rec=this.sm.getSelected();
            
            var data = {
                id_proceso_wf: rec.data.id_proceso_wf,
                id_estado_wf: rec.data.id_estado_wf,
                num_tramite: rec.data.num_tramite
            }
            
            
            Phx.CP.loadWindows('../../../sis_workflow/vista/obs/Obs.php',
                    'Observaciones del WF',
                    {
                        width:'80%',
                        height:'70%'
                    },
                    data,
                    this.idContenedor,
                    'Obs'
            )
        },
		
		successReclamar: function(){
		    Phx.CP.loadingHide();
            this.reload();
		}
	}
)
</script>
		
		
