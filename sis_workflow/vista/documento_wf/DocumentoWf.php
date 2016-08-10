<?php
/**
*@package pXP
*@file gen-DocumentoWf.php
*@author  (admin)
*@date 15-01-2014 13:52:19
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DocumentoWf=Ext.extend(Phx.gridInterfaz,{
     lblDocProcCf:  'Solo del Proceso',
     lblDocProcSf:  'Todo del Trámite',
     todos_documentos: 'si',
     modoConsulta: 'no',
     pagos_relacionados: 'no', //solo para el caso de abrir ersta interface desde el plan de pagos
     //soporte para cuatro categorias
     bsaveGroups:[0,1,2,3],
     bnewGroups:[0,1,2,3],
     beditGroups:[0,1,2,3],
	 bdelGroups:[0,1,2,3],
	 bactGroups:[0,1,2,3],
	 btestGroups:[0,1,2,3],
	 bexcelGroups:[0,1,2,3],
	 stateful: false, 
	 //CheckSelectionModel: true,
	 //checkGrid: true,
	 
	 constructor: function(config){
	 	
	 	Ext.apply(this,config);
	 	this.esperarEventos = true;
	 	//busca  la configuracion de la interface, si necesita documentos fisicos, si necesita modifica, insercion pestañas
	 	Phx.CP.loadingShow();
	 	  //bandera para hacer que espera la palicacion de eventos
   		Ext.Ajax.request({
            url:'../../sis_workflow/control/DocumentoWf/verificarConfiguracion',
            params: { 'id_proceso_wf': config.id_proceso_wf},
            argument: {config: config},
            success: this.successInit,
            failure: this.conexionFailure,
            timeout:this.timeout,
            scope:this
        });
        
        
	 	
	 	
	 },
	 successInit:function(resp){
	 	var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
	 	Phx.CP.loadingHide();
	 	
	 	
	 	if(!resp.argument.config.gruposBarraTareas && reg.ROOT.datos.json_grupo_doc != ''){
	 		resp.argument.config.gruposBarraTareas = Ext.util.JSON.decode(Ext.util.Format.trim(reg.ROOT.datos.json_grupo_doc));
	 	 }
	 	 
	 	 this.arrayDefaultColumHidden = ['fecha_reg','fecha_mod','usr_reg','usr_mod','usr_upload','fecha_upload','estado_reg','fecha_reg'];
			 
	 	 if(this.modoConsulta == 'no'){
	 	 
		 	if(reg.ROOT.datos.sw_tiene_fisico == 'no'){
		 	 	  this.arrayDefaultColumHidden.push('chequeado_fisico');
		 	 	  this.bedit = false;
		 	 }  
		 	 else{
		 	 	 this.bedit = true;
		 	 }
		 	 
		 	 if(reg.ROOT.datos.sw_tiene_insertar == 'no'){
		 	 	 this.bnew = false;
		 	 }  
		 	 else{
		 	 	 this.bnew = true;
		 	 	 this.documentos_insertables = reg.ROOT.datos.id_tipo_documentos;
		 	 }
		 	 
		 	 if(reg.ROOT.datos.sw_tiene_modificar == 'no'){
		 	 	 this.arrayDefaultColumHidden.push('modificar')
		 	 }
		 	 
	 	 }
	 	 else{
	 	 	 this.bnew = false;
	 	 	 this.bedit = false;
	 	 	 this.arrayDefaultColumHidden.push('chequeado_fisico');
	 	 	 this.arrayDefaultColumHidden.push('modificar');
	 	 	 this.arrayDefaultColumHidden.push('upload');
		 	 
	 	 }
		
		this.initconstructor(resp.argument.config);
	 	
	 },
	 
	 cmpCheckModo : new Ext.form.Checkbox({
	 	        name: 'modo',
	 	        grupo:[0,1,2,3],
	 	        qtip: 'Tiqueado solo muestra los registros con documentos disponibles',
	 	        text: 'Exigir',
                allowBlank: true,
                anchor: '80%',
                style : {height:'37px', width:'37px'},
                gwidth: 65
	 	}),
	 	
	 
	
	 initconstructor:function(config){		
		
		 //declaracion de eventos
        this.addEvents('finalizarsol');
        this.addEvents('sigestado');
        this.maestro = config;
        this.initButtons = [{  
        	style: {
                'marginLeft': '10px',
                'marginRight': '10px',
                'font-size': '30px'
                
            },xtype: 'label', grupo:[0,1,2,3], text: ' Modo Consulta: '},this.cmpCheckModo];
          
		this.anulados = 'no';
        this.tbarItems = ['-',
           {
            text: 'Mostrar los documentos anulados',
            enableToggle: true,
            pressed: false,
            toggleHandler: function(btn, pressed) {
               
                if(pressed){
                	this.anulados = 'si';
                }
                else{
                   this.anulados = 'no' 
                }
                
                this.store.baseParams.anulados = this.anulados;
                this.onButtonAct();
             },
            scope: this
           }];
           
           
           var me = this;
           
           this.Atributos = [
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_documento_wf'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proceso_wf'
			},
			type:'Field',
			form:true 
		},
		{
       			config:{
       				name:'id_tipo_documentos',
       				fieldLabel:'Documentos',
       				allowBlank:true,
       				emptyText:'documentos...',
       				store: new Ext.data.JsonStore({
	                    url: '../../sis_workflow/control/TipoDocumento/listarTipoDocumento',
	                    id: 'id_tipo_documento',
	                    root: 'datos',
	                    sortInfo: {
	                        field: 'tipdw.codigo',
	                        direction: 'ASC'
	                    },
	                    totalProperty: 'total',
	                    fields: ['id_tipo_documento', 'codigo', 'nombre','descripcion'],
	                    // turn on remote sorting
	                    remoteSort: true,
	                    baseParams: {par_filtro: 'tipdw.nombre#tipdw.codigo'}
	                }),
       				valueField: 'id_tipo_documento',
       				displayField: 'nombre',
       				gdysplayfield: 'descripcion_tipo_documento',
       				forceSelection:true,
       				typeAhead: false,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:100,
       				queryDelay:1000,
       				width:250,
       				minChars:2,
       				qtip:'Muestra una lista de documentos que peude insertar en este estado',
	       			enableMultiSelect:true
       			},
       			type:'AwesomeCombo',
       			id_grupo:2,
       			grid:false,
       			form:true
       	},		
        {
            config:{
                name: 'modificar',
                fieldLabel: 'Exigir',
                allowBlank: true,
                anchor: '80%',
                gwidth: 65,
                scope: this,
                renderer:function (value, p, record, rowIndex, colIndex){  
                	     
                	       //check or un check row
                	       var checked = '',
                	       	    momento = 'no';
	                	   if(record.data['momento'] == 'exigir'){
	                	        	checked = 'checked';
	                	        	momento = 'si';
	                	   }
                	       
                	        if(record.data['modificar'] == 'si'){
                	       	   return  String.format('<div style="vertical-align:middle;text-align:center;"><input style="height:37px;width:37px;" type="checkbox"  {0}></div>',checked);
                	        }else{
                	       	   return   String.format('<div style="vertical-align:middle;text-align:center;"><input style="height:35px;width:30px;vertical-align:middle;text-align:center;" type="checkbox"  {0} disabled></div>',checked);
                	        }
                 }
            },
            type:'Checkbox',
            filters:{pfiltro:'dwf.modificar',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },		
        {
            config:{
                name: 'chequeado',
                fieldLabel: 'Doc. Digital',
                allowBlank: true,
                anchor: '80%',
                gwidth: 65,
                scope: this,
                renderer:function (value, p, record, rowIndex, colIndex){  
                	     
                	       if(record.data['chequeado'] == 'si') {
                            	return "<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Abrir Documento' src = '../../../lib/imagenes/icono_awesome/awe_print_good.png' align='center' width='30' height='30'></div>";
                            } else if(record.data.nombre_vista) {
                            	return "<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Generar Plantilla' src = '../../../lib/imagenes/icono_awesome/awe_template.png' align='center' width='30' height='30'></div>";
                            } 
                            else if (record.data['action'] != '') {
                                return "<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Vista Previa Documento Generado' src = '../../../lib/imagenes/icono_awesome/awe_print_good.png' align='center' width='30' height='30'></div>";
                            } else{ 
                            	return  String.format('{0}',"<div style='text-align:center'><img title='Documento No Escaneado' src = '../../../lib/imagenes/icono_awesome/awe_wrong.png' align='center' width='30' height='30'/></div>");  
                            }
                        },
            },
            type:'Checkbox',
            filters:{pfiltro:'dwf.chequeado',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'chequeado_fisico',
                fieldLabel: 'Físico',
                allowBlank: true,
                width: 65,
                gwidth: 65,
                valueField: 'momento',                  
                store:['si','no'],
                triggerAction: 'all',
                lazyRender:true,
                renderer:function (value, p, record){  
                            if(record.data['chequeado_fisico'] == 'si')
                                return  String.format('{0}',"<div style='text-align:center'><img title='Documento No Escaneado' src = '../../../lib/imagenes/icono_awesome/awe_ok.png' align='center' width='30' height='30'/></div>");
                            else
                                return  String.format('{0}',"<div style='text-align:center'><img title='Documento No Escaneado' src = '../../../lib/imagenes/icono_awesome/awe_wrong.png' align='center' width='30' height='30'/></div>");
                        },
            },
            type:'ComboBox',
            filters:{pfiltro:'dwf.chequeado_fisico',type:'string'},
            id_grupo:1,
            grid:true,
            egrid:true,
            form:true
        },
        /*{
            config:{
                name: 'momento',
                fieldLabel: 'momento',
                allowBlank: true,
                anchor: '80%',
                gwidth: 65,
                maxLength:255,
                renderer:function (value, p, record){  
                            if(record.data['momento'] == 'exigir')
                                return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/icono_dibu/dibu_lock.png' align='center' width='45' height='45'/></div>");
                            else
                                return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/icono_dibu/dibu_unlock.png' align='center' width='45' height='45'/></div>");
                        },
            },
                type:'TextField',
                filters:{pfiltro:'dwf.momento',type:'string'},
                id_grupo:1,
                grid:true,
                form:false
        },*/
		
		
        {
            config:{
                fieldLabel: "Subir",
                gwidth: 65,
                inputType:'file',
                name: 'upload',
                buttonText: '',   
                maxLength:150,
                anchor:'100%',
                renderer:function (value, p, record){
                		if (record.data['solo_lectura'] == 'no' && !record.data['id_proceso_wf_ori']) {  
                            if(record.data['extension'].length!=0) {                                
                                return  String.format('{0}',"<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Reemplazar Archivo' src = '../../../lib/imagenes/icono_awesome/awe_upload.png' align='center' width='30' height='30'></div>");
                            } else {
                            	return  String.format('{0}',"<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Subir Archivo' src = '../../../lib/imagenes/icono_awesome/awe_upload.png' align='center' width='30' height='30'></div>");
                            }
                        }
               },  
                
            },
            type:'Field',
            sortable:false,
            id_grupo:0,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'nombre_tipo_documento',
                fieldLabel: 'Nombre Doc.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 240,
                maxLength:250,
                renderer:function(value,p,record){
                         if( record.data.priorizacion==0||record.data.priorizacion==9){
                             return String.format('<b><font color="red">{0}***</font></b>', value);
                        }
                        else{
                            return String.format('{0}', value);
                        }},
                
            },
                type:'TextField',
                filters:{pfiltro:'td.nombre',type:'string'},
                id_grupo:1,
                grid:true,
                form:false,
				bottom_filter : true
        },
        
        {
            config:{
                name: 'descripcion_proceso_wf',
                fieldLabel: 'Descripcion Proceso',
                allowBlank: true,
                anchor: '80%',
                gwidth: 400,
                renderer:function(value,p,record){
                         if( record.data.demanda == 'si'){
                             return String.format('<b><font color="green">{0}</font></b>', value);
                        }
                        else{
                            return String.format('{0}', value);
                        }
                 }
                
            },
                type:'TextField',
                filters:{pfiltro:'pw.descripcion',type:'string'},
                id_grupo:1,
                grid:true,
                form:false,
				bottom_filter : true
        },
        
        {
            config:{
                name: 'nro_tramite_ori',
                fieldLabel: 'Documentos Previos',
                allowBlank: true,
                anchor: '80%',
                gwidth: 120,
                maxLength:200,
                renderer:function (value, p, record){  
                            if(record.data['id_proceso_wf_ori']) {                                
                                return  String.format("<div style='text-align:center'><a target=_blank align='center' width='70' height='70'>{0}</a></div>",record.data['nro_tramite_ori']);
                            }
                        },
            },
                type:'TextField',
                filters:{pfiltro:'dwf.nro_tramite_ori',type:'string'},
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
				filters:{pfiltro:'dwf.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
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
                filters:{pfiltro:'dwf.estado_reg',type:'string'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'dwf.fecha_mod',type:'date'},
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
                name: 'fecha_upload',
                fieldLabel: 'Fecha Escan.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                            format: 'd/m/Y', 
                            renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
            },
                type:'DateField',
                filters:{pfiltro:'dwf.fecha_mod',type:'date'},
                id_grupo:1,
                grid:true,
                form:false
        },
        {
            config:{
                name: 'usr_upload',
                fieldLabel: 'Escaneado por',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:4
            },
                type:'NumberField',
                filters:{pfiltro:'usu3.cuenta',type:'string'},
                id_grupo:1,
                grid:true,
                form:false
        }
	];
	    
	    
	   
    	//llama al constructor de la clase padre
		Phx.vista.DocumentoWf.superclass.constructor.call(this,config);
		this.esperarEventos = false; 
		
		//boton filtro del proceso
		this.addButton('btnDocProceso', {
				text : this.lblDocProcCf,
				grupo:[0,1,2,3],
				iconCls : 'bend',
				disabled : false,
				enableToggle : true,
				handler : this.onDocProceso,
				tooltip : '<b>Mostrar +/- Documentos</b> Aplica o quita el filtro de documentos del trámite'
			});
			
		if(this.todos_documentos == 'no'){
		   this.getBoton('btnDocProceso').toggle(true,true)	;
		}
			
		this.cambiarIconoDocPro(); 
               

        //this.grid.addListener('celldblclick', this.oncelldblclick, this);
        this.grid.addListener('cellclick', this.oncellclick,this);

        //si viene del formulario de solicitud agregamos un botono de finalizar
        if(config.tipo === 'solcom'){
        	this.tbar.add('->');
        	this.addButton('fin_solcom',{ grupo:[0,1,2,3], text:'Solo Guardar', iconCls: 'bok', disabled: false,
							        	  handler: function(){
							        	 	 this.panel.destroy();
							        	  }, 
							        	  tooltip: '<b>Solo guardar</b><br>Deja la sollicitud en borrador, permite continuar despues'});
            
        	this.addButton('fin_requerimiento',{ grupo:[0,1,2,3],  text:'Finalizar Solicitud', iconCls: 'badelante', disabled: false,
									        	 handler: function(){
									        	 	this.fireEvent('finalizarsol', this, this.maestro, true);
									        	 
									        	 }, 
									        	 tooltip: '<b>Finalizar</b><br>Finaliza la solicitud y la manda para aprobación'});
        	 
        	
        	
        }
        if(config.tipo === 'proins'){
        	this.tbar.add('->');        	
        	this.addButton('siguiente_estado',{ grupo:[0,1,2,3], text:'Siguiente Etapa', iconCls: 'badelante', disabled: false,
									        	 handler: function(){
									        	 	this.fireEvent('sigestado', this, this.maestro, true);
									        	 	this.panel.destroy();
									        	 }, 
									        	 tooltip: '<b>Siguiente</b><br>Pasa el proceso a la siguiente etapa'});
        	    	
        	
        }
        
        if(config.tipo === 'wizard'){
        	this.tbar.add('->');        	
        	this.addButton('siguiente_estado',{ grupo:[0,1,2,3], text:'Siguiente Etapa', iconCls: 'badelante', disabled: false,
									        	 handler: function(){
									        	 	this.fireEvent('loadWizard', this, this.maestro, true);
									        	 	this.panel.destroy();
									        	 }, 
									        	 tooltip: '<b>Siguiente</b><br>Pasa el proceso a la siguiente etapa'});
        	    	
        	
        }
        
        if(config.tipo === 'plan_pago'){
        	this.tbar.add('->');        	
        	this.addButton('btnPagoRel',
	            {
	                text: 'Pagos Relacionados',
	                grupo:[0,1,2,3], 
	                iconCls: 'binfo',
	                disabled: false,
	                handler: this.loadPagosRelacionados,
	                tooltip: '<b>Pagos Relacionados</b><br/>Abre una venta con pagos similares o relacionados.'
	            }
	        );
	        
	    }
	    
	    
        this.init(); 
        
        
                
        cm = this.grid.getColumnModel();       
        if(this.gruposBarraTareas && this.gruposBarraTareas.length == 0){
         	this.actualizarBasicos();
        } 
        else{
        	this.store.baseParams.categoria = this.gruposBarraTareas[0].name;
    	    this.actualizarBasicos();
        }
        
       this.finCons = true;
       
       
       if(this.modoConsulta == 'si'){
       	 this.cmpCheckModo.setValue(true);
       	 this.cmpCheckModo.disable();
       }
       
       this.cmpCheckModo.on('check',function(cmp,checked){
       	
	       	 this.modoConsulta = checked?'si':'no';
	       	 this.actualizarBasicos();
       	
       },this);
      
          	
          
    },
	 onDocProceso: function(b,e){
	 	  
	 	  
	 	  if (this.todos_documentos == 'si'){
	 	  	 this.todos_documentos = 'no';
	 	  }
	 	  else{
	 	  	 this.todos_documentos = 'si' 
	 	  }
	 	  this.cambiarIconoDocPro();
	 	  this.store.baseParams.todos_documentos = this.todos_documentos;
          this.onButtonAct();
	 	  
	 	
	 },
	
	cambiarIconoDocPro: function(){
		var btnPro = this.getBoton('btnDocProceso');
		if(this.todos_documentos == 'si'){
		    btnPro.setIconClass('bdocuments');
		    btnPro.setText(this.lblDocProcSf);
			//btnSwitchEstado.setTooltip('<b>Cerrar Periodo</b>');
		}
		else{
			
			btnPro.setIconClass('bend');
			btnPro.setText(this.lblDocProcCf) ;
			//btnSwitchEstado.setTooltip('<b>Abrir Periodo</b>');
		}
		
	},
	
	actualizarBasicos:function(){
		this.store.baseParams.modoConsulta = this.modoConsulta;
		this.store.baseParams.todos_documentos = this.todos_documentos;
        this.store.baseParams.anulados = this.anulados;
        this.store.baseParams.id_proceso_wf = this.id_proceso_wf;
        this.load({params:{
            start: 0, 
            limit: 50           
            }});
        
       if(this.maestro.esconder_toogle == 'si'){  
             this.getBoton('btnDocProceso').hide();
       }     
	},
	
	actualizarSegunTab: function(name, indice){
		if(this.finCons) {
			 this.store.baseParams.categoria = name;
    	     this.actualizarBasicos();
		}
    },
    rowExpander: new Ext.ux.grid.RowExpander({
	        tpl : new Ext.Template(
	            '<br>',
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Fecha de Registro:&nbsp;&nbsp;</b> {fecha_reg:date("d/m/Y")}</p>',
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Usuario de Registro:&nbsp;&nbsp;</b> {usr_reg}</p>',
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Estado:&nbsp;&nbsp;</b> {estado_reg}</p>',
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Fecha Ult. Modificacion:&nbsp;&nbsp;</b> {fecha_mod:date("d/m/Y")}</p>',
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Usuario Ult. Modificacion:&nbsp;&nbsp;</b> {usr_mod}</p>',	            
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Fecha Subida:&nbsp;&nbsp;</b> {fecha_upload:date("d/m/Y")}</p>',
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Usuario Subida:&nbsp;&nbsp;</b> {usr_upload}</p><br>'
	        )
    }),
    
    arrayDefaultColumHidden:['fecha_reg','fecha_mod','usr_reg','usr_mod','usr_upload','fecha_upload',
							'estado_reg','fecha_reg'],

    
	SubirArchivo : function(rec)
    {                   
        if(this.modoConsulta =='no'){
        	Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/SubirArchivoWf.php',
	        'Subir ' + rec.data.nombre_tipo_documento,
	        {
	            modal:true,
	            width:450,
	            height:150
	        },rec.data,this.idContenedor,'SubirArchivoWf');
	   }
	   else{
	   	  alert('en modo consulta no peude subir archivos');
	   }
    },
	
	oncellclick : function(grid, rowIndex, columnIndex, e) {
		
	    var record = this.store.getAt(rowIndex),
	        fieldName = grid.getColumnModel().getDataIndex(columnIndex); // Get field name

	    if (fieldName == 'nro_tramite_ori' && record.data.id_proceso_wf_ori) {
	    	//open documentos de origen
       		this.loadCheckDocumentosSolWf(record);
	    } else if (fieldName == 'upload') {
	    	if (record.data.solo_lectura == 'no' &&  !record.data.id_proceso_wf_ori) {
	    		this.SubirArchivo(record);
	    	}
	    } else if(fieldName == 'modificar') {
	       	if(record.data['modificar'] == 'si'){
	       	
	       	   this.cambiarMomentoClick(record);
	       	   		
	       	}
	    } 
	    else if (fieldName == 'chequeado') {
	    	if(record.data['extension'].length!=0) {
	    		//Escaneados
	            var data = "id=" + record.data['id_documento_wf'];
	            data += "&extension=" + record.data['extension'];
	            data += "&sistema=sis_workflow";
	            data += "&clase=DocumentoWf";
	            data += "&url="+record.data['url'];
	            //return  String.format('{0}',"<div style='text-align:center'><a target=_blank href = '../../../lib/lib_control/CTOpenFile.php?"+ data+"' align='center' width='70' height='70'>Abrir</a></div>");
	            window.open('../../../lib/lib_control/CTOpenFile.php?' + data);
	        } else if(record.data.nombre_vista){
	        	//Plantillas
	        	Phx.CP.loadingShow();
				Ext.Ajax.request({
					url : '../../sis_workflow/control/TipoDocumento/generarDocumento',
					params : {
						id_proceso_wf    		: record.data.id_proceso_wf,
						id_tipo_documento		: record.data.id_tipo_documento,
						nombre_vista	 		: record.data.nombre_vista,
						esquema_vista    		: record.data.esquema_vista,
						nombre_archivo_plantilla: record.data.nombre_archivo_plantilla
					},
					success : this.successExport,
					failure : this.conexionFailure,
					timeout : this.timeout,
					scope : this
				});
	        	
	        	
	        } else if (record.data['tipo_documento'] == 'generado') {
	        	//Reportes/Formularios
	        	Phx.CP.loadingShow();
	       		Ext.Ajax.request({
	                url:'../../'+record.data.action,
	                params:{'id_proceso_wf':record.data.id_proceso_wf, 'action':record.data.action},
	                success: this.successExport,
	                failure: this.conexionFailure,
	                timeout:this.timeout,
	                scope:this
	            });
	       	} else {
	       		alert('No se ha subido ningun archivo para este documento');
	       	} 
	    }
		
	},
	
	loadCheckDocumentosSolWf:function(rec) {
           
            Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/DocumentoWf.php',
                    'Documentos de Origen',
                    {
                        width:'90%',
                        height:500
                    },
                    { id_proceso_wf: rec.data.id_proceso_wf_ori,
                      nro_tramite: rec.data.nro_tramite_ori,
                      nombreVista: 'Documentos de Origen' },
                    this.idContenedor,
                    'DocumentoWf'
        )
    },
	
	tam_pag:50,	
	title:'Documento',
	ActSave:'../../sis_workflow/control/DocumentoWf/insertarDocumentoWf',
	ActDel:'../../sis_workflow/control/DocumentoWf/eliminarDocumentoWf',
	ActList:'../../sis_workflow/control/DocumentoWf/listarDocumentoWf',
	id_store:'id_documento_wf',
	fields: [
		{name:'id_documento_wf', type: 'numeric'},
		{name:'url', type: 'string'},
		{name:'num_tramite', type: 'string'},
		{name:'id_tipo_documento', type: 'numeric'},
		{name:'obs', type: 'string'},
		{name:'id_proceso_wf', type: 'numeric'},
		{name:'extension', type: 'string'},
		{name:'chequeado', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre_tipo_doc', type: 'string'},
		{name:'nombre_doc', type: 'string'},
		{name:'momento', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'priorizacion', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'codigo_tipo_proceso',
		'codigo_tipo_documento',
        'nombre_tipo_documento',
        'descripcion_tipo_documento',
        'nro_tramite',
        'codigo_proceso',
        'descripcion_proceso_wf',
        'nombre_estado',
        'chequeado_fisico',
        'usr_upload',
        'tipo_documento',
        'action','solo_lectura','id_documento_wf_ori','id_proceso_wf_ori','nro_tramite_ori',
        {name:'fecha_upload', type: 'date',dateFormat:'Y-m-d H:i:s.u'},'modificar','insertar','eliminar','demanda',
        'nombre_vista','esquema_vista','nombre_archivo_plantilla'
	],
	
    onButtonDel: function(){
    	if(confirm('¿Está seguro de eliminar estos documentos?')){
			//recupera los registros seleccionados
			var filas=this.sm.getSelections();
			var data= {},aux={};
			//console.log(filas,i)
			
            //arma una matriz de los identificadores de registros que se van a eliminar
            this.agregarArgsExtraSubmit();
            
			for(var i=0;i<this.sm.getCount();i++){
				if(filas[i].data['eliminar'] == 'si'){
					aux={};
					aux[this.id_store]=filas[i].data[this.id_store];
					data[i]=aux;
					data[i]._fila=this.store.indexOf(filas[i])+1
					//rac 22032012
					
					Ext.apply(data[i],this.argumentExtraSubmit);
				}
				
				
				
			}
			
	        Phx.CP.loadingShow();
			//llama el metodo en la capa de control para eliminación
			Ext.Ajax.request({
				url:this.ActDel,
				success:this.successDel,
				failure:this.conexionFailure,
				params:{_tipo:'matriz','row':Ext.util.JSON.encode(data)},
				timeout:this.timeout,
				scope:this
			})
		}
    },
    
   
    preparaMenu:function(tb){
        Phx.vista.DocumentoWf.superclass.preparaMenu.call(this,tb)
        var data = this.getSelectedData();
        if(data['eliminar'] ==  'si' ){
            this.getBoton('del').enable();
         
         }
         else{
              this.getBoton('del').disable();
         } 
	        
    },
    
    liberaMenu:function(tb){
        Phx.vista.DocumentoWf.superclass.liberaMenu.call(this,tb);
                    
    },
	
	sortInfo:{
		field: 'id_documento_wf',
		direction: 'ASC'
	},
	
	east:
         {
          url:'../../../sis_workflow/vista/documento_historico_wf/DocumentoHistoricoWf.php',
          title:'Histórico', 
          width: '30%',
          collapsed: true,
          cls:'DocumentoHistoricoWf'
         },
         
	south:
         {
          url: '../../../sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstadoWF.php',
          title: 'Estados por momento', 
          width: 400,
           height:'40%',
           collapsed:true,
          cls: 'TipoDocumentoEstadoWF'
         },
	
	cambiarMomento:function(){
	    Phx.CP.loadingShow();
	    var d = this.sm.getSelected().data;
        Ext.Ajax.request({
            url:'../../sis_workflow/control/DocumentoWf/cambiarMomento',
            params:{ id_documento_wf: d.id_documento_wf},
            success: this.successMomento,
            failure: this.conexionFailure,
            timeout: this.timeout,
            scope: this
        }); 
	    
	},
	cambiarMomentoClick: function(record){
		Phx.CP.loadingShow();
	    var d = record.data
        Ext.Ajax.request({
            url:'../../sis_workflow/control/DocumentoWf/cambiarMomento',
            params:{ id_documento_wf: d.id_documento_wf},
            success: this.successMomento,
            failure: this.conexionFailure,
            timeout: this.timeout,
            scope: this
        }); 
	},
	successMomento:function(resp){
       Phx.CP.loadingHide();
       var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
       if(!reg.ROOT.error){
         this.reload();
       }
    },
    
    onButtonNew:function(){
    	Phx.vista.DocumentoWf.superclass.onButtonNew.call(this); 
    	this.Cmp.id_tipo_documentos.store.baseParams.id_tipo_documentos = this.documentos_insertables;
    	this.Cmp.id_tipo_documentos.enable();
    	this.Cmp.id_tipo_documentos.show();
    	this.Cmp.chequeado_fisico.disable()
    	this.Cmp.chequeado_fisico.hide()
    	
    },
    onButtonEdit:function(){
    	Phx.vista.DocumentoWf.superclass.onButtonEdit.call(this); 
    	this.Cmp.id_tipo_documentos.disable();
    	this.Cmp.id_tipo_documentos.hide();
    	this.Cmp.chequeado_fisico.enable()
    	this.Cmp.chequeado_fisico.show()
    	
    },
    loadValoresIniciales:function(){
        this.Cmp.id_proceso_wf.setValue(this.id_proceso_wf);
        Phx.vista.DocumentoWf.superclass.loadValoresIniciales.call(this);
        
    },
    
     loadPagosRelacionados:  function() {
            Phx.CP.loadWindows('../../../sis_tesoreria/vista/plan_pago/RepFilPlanPago.php',
                    'Pagos similares',
                    {
                        width:'90%',
                        height:'90%'
                    },
                    this.tmp,
                    this.idContenedor,
                    'RepFilPlanPago'
        )
    },
    
      
	bdel:true,
	bsave:false
	}
)
</script>
		
		