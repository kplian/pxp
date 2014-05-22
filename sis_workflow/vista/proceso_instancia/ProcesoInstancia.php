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
		constructor:function(config) {
			//configuraciones iniciales
			this.maestro=config.maestro;
			this.config = config;
			//funcionalidad para listado de historicos
        	this.historico = 'no';
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
           
           //hacer ajax request para obtener datos del proceso en el estado actual
        	Ext.Ajax.request({
		        url:'../../sis_workflow/control/Tabla/cargarDatosTablaProceso',//cargarDatosTablaProceso
		        params:{'tipo_proceso':config.proceso, 'tipo_estado' : config.estado, 'limit' : 100, 'start' : 0},
		        success: this.successCargarDatos,
		        failure: this.conexionFailure,
		        timeout:this.timeout,
		        scope:this
		    }); 
		},
		
		successCargarDatos :function (resp) {
			Phx.CP.loadingHide();
	        var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
	        this.configProceso = objRes.datos;
	        
	        
	        this.armaColumnas();
	        			
			//armar ordenacion
			
	        //llama al constructor de la clase padre
	    	Phx.vista.ProcesoInstancia.superclass.constructor.call(this,this.config);
	    	this.init();			
			this.iniciarEventos();	 
			this.cargarBotones();   	
		},
		
		cargarBotones : function () {
			this.addButton('btnChequeoDocumentosWf',
	            {
	                text: 'Chequear Documentos',
	                iconCls: 'bchecklist',
	                disabled: true,
	                handler: this.loadCheckDocumentosWf,
	                tooltip: '<b>Documentos del Proceso</b><br/>Subir los documetos requeridos en el proceso seleccionada.'
	            }
	        ); 
	        
	       this.addButton('diagrama_gantt',{text:'',iconCls: 'bgantt',disabled:true,handler:this.diagramGantt,tooltip: '<b>Diagrama Gantt de proceso macro</b>'});
	  
	     
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
				{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},				
				{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
				{name:'usr_reg', type: 'string'},
				{name:'usr_mod', type: 'string'}];
				
						
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
									
			for (var i = 0 ;i < this.configProceso[this.config.indice].columnas.length; i++) {
				
				if (this.configProceso[this.config.indice].columnas[i].momento != 'ninguno') {
					
					//anadir campo en el store
					this.addStoreField(this.configProceso[this.config.indice].columnas[i]);
					
					//anadir campo como atributo
					var config_columna = {
						config : {
							anchor: '100%',
		                	gwidth: 100,
		                	allowBlank: true
		                },
		                id_grupo : 0,
		                grid : true,
		                form: false};
		            config_columna.config.fieldLabel = this.configProceso[this.config.indice].columnas[i].form_label;
		            config_columna.type = this.configProceso[this.config.indice].columnas[i].form_tipo_columna;
		            
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
		            
		            //validar el tamaño del campo en caso de que sea varchar, numeric o integer
		            if (this.configProceso[this.config.indice].columnas[i].form_tipo_columna == 'varchar') {
		            	if (this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != '' && 
		            		this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != undefined) {
		            			config_columna.config.maxLength = this.configProceso[this.config.indice].columnas[i].bd_tamano_columna;
		            		
		            	}
		            } else if (this.configProceso[this.config.indice].columnas[i].form_tipo_columna == 'integer') {
		            	config_columna.config.maxLength = 9;
		            } else if (this.configProceso[this.config.indice].columnas[i].form_tipo_columna == 'bigint') {
		            	config_columna.config.maxLength = 18;
		            } else if (this.configProceso[this.config.indice].columnas[i].form_tipo_columna == 'numeric') {
		            	if (this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != '' && 
		            		this.configProceso[this.config.indice].columnas[i].bd_tamano_columna != undefined) {
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
		            }
		            
		            if (this.configProceso[this.config.indice].columnas[i].form_comborec != '' && 
		            	this.configProceso[this.config.indice].columnas[i].form_comborec != undefined) {
		            	config_columna.config.origen = this.configProceso[this.config.indice].columnas[i].form_comborec;
		            	config_columna.type = 'ComboRec';
		            }
		            
		            
		            //Añadir la sobreescritura de config y filtro
		            if (this.configProceso[this.config.indice].columnas[i].form_sobreescribe_config != '' && 
		            	this.configProceso[this.config.indice].columnas[i].form_sobreescribe_config != undefined) {
			            var custom_config = Ext.util.JSON.decode(Ext.util.Format.trim(this.configProceso[this.config.indice].columnas[i].form_sobreescribe_config));
			            Ext.apply(config_columna.config,custom_config);
			        }
			        if (this.configProceso[this.config.indice].columnas[i].grid_sobreescribe_filtro != '' && 
		            	this.configProceso[this.config.indice].columnas[i].grid_sobreescribe_filtro != undefined) {
			            var custom_filter = Ext.util.JSON.decode(Ext.util.Format.trim(this.configProceso[this.config.indice].columnas[i].grid_sobreescribe_filtro));
			            Ext.apply(config_columna.filters,custom_filter);
			        }
			        this.Atributos.push(config_columna);			        
			    }
	            	            
	            
			}	
			this.Atributos.push({
				//configuracion del componente
				config:{
	                name: 'usr_reg',
	                fieldLabel: 'Creado por',
	                allowBlank: true,
	                anchor: '80%',
	                gwidth: 100,
	                maxLength:10
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
	                allowBlank: true,
	                anchor: '80%',
	                gwidth: 100,
	                maxLength:10
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
	                allowBlank: true,
	                anchor: '80%',
	                gwidth: 100,
	                format: 'd/m/Y', 
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
	                allowBlank: true,
	                anchor: '80%',
	                gwidth: 100,
	                maxLength:10
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
		        config_columna.grid_campos_adicionales != undefined) {
				var aux_extra_fields = config_columna.grid_campos_adicionales.split(',');
				
				for (var i = 0; i < aux_extra_fields; i++) {
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
		tam_pag:50,
		ActSave:'../../sis_workflow/control/ProcesoWf/insertarProcesoWf',
		ActDel:'../../sis_workflow/control/ProcesoWf/eliminarProcesoWf',
		ActList:'../../sis_workflow/control/ProcesoWf/listarProcesoWf',
		loadCheckDocumentosWf:function() {
	            var rec=this.sm.getSelected();
	            rec.data.nombreVista = this.nombreVista;
	            Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/DocumentoWf.php',
	                    'Chequear documento del WF',
	                    {
	                        width:'90%',
	                        height:500
	                    },
	                    rec.data,
	                    this.idContenedor,
	                    'DocumentoWf'
	        )
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
	                success:this.successSinc,
	                failure: this.conexionFailure,
	                timeout:this.timeout,
	                scope:this
	            }); 
	     },
	    
	    
	    successSinc:function(resp){
	        Phx.CP.loadingHide();
	        resp.argument.wizard.panel.destroy()
	        this.reload();
	     },
	     
	     penFormEstadoWf:function() {
        
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
	                          
	                        }],	                
	                scope:this
	             });	        
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
	      Phx.vista.ProcesoWf.superclass.preparaMenu.call(this,n); 
	     this.getBoton('btnChequeoDocumentosWf').setDisabled(false);
	     this.getBoton('diagrama_gantt').enable();
	       if(this.historico == 'no'){
	          
	          this.getBoton('sig_estado').enable();
	          this.getBoton('ant_estado').enable();          
	          
	          if(data.codigo_estado == 'borrador' ){ 
	             this.getBoton('ant_estado').disable();
	           
	          }
	          if(data.codigo_estado == 'finalizado' || data.codigo_estado =='anulado'){
	               this.getBoton('sig_estado').disable();
	               this.getBoton('ant_estado').disable();
	          }
	       }   
	      else{
	          this.desBotoneshistorico();
	          
	      }    
	      return tb;
	    },
	    
	    liberaMenu:function(){
	        var tb = Phx.vista.ProcesoWf.superclass.liberaMenu.call(this);
	        this.getBoton('btnChequeoDocumentosWf').setDisabled(true);
	        if(tb){
	            this.getBoton('sig_estado').disable();
	            this.getBoton('ant_estado').disable();
	            this.getBoton('diagrama_gantt').disable();
	           
	        }
	        return tb
	    }
	}
)
</script>
		
		