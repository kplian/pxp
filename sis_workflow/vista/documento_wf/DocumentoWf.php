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

	constructor:function(config){
		
		this.check_fisico = 'no';
		if (config.hasOwnProperty('check_fisico')) {
			if (config.check_fisico == 'si') {
				this.check_fisico = 'si';
			}
		}
		
		 //declaracion de eventos
        this.addEvents('finalizarsol');
        this.maestro = config;
        
		this.todos_documentos = 'si';
		this.anulados = 'no';
        this.tbarItems = ['-',{
            text: 'Mostrar solo los documentos del proceso actual',
            enableToggle: true,
            pressed: false,
            toggleHandler: function(btn, pressed) {
               
                if(pressed){
                	
                    this.todos_documentos = 'no';
                    this.desBotonesTodo();
                }
                else{
                   this.todos_documentos = 'si' 
                }
                
                this.store.baseParams.todos_documentos = this.todos_documentos;
                this.onButtonAct();
             },
            scope: this
           },
           {
            text: 'Mostrar los documentos anulados',
            enableToggle: true,
            pressed: false,
            toggleHandler: function(btn, pressed) {
               
                if(pressed){
                	
                    this.anulados = 'si';
                    this.desBotonesTodo();
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
            config:{
                name: 'chequeado',
                fieldLabel: 'Escaneado',
                allowBlank: true,
                anchor: '80%',
                gwidth: 65,
                renderer:function (value, p, record){  
                            if(record.data['chequeado'] == 'si') {
                                return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/icono_dibu/dibu_ok.png' align='center' width='45' height='45'/></div>");
                            } else if  (record.data['action'] != '') {
                                return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/icono_dibu/dibu_preview.png' align='center' width='45' height='45'/></div>");
                            } else{ 
                            	return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/icono_dibu/dibu_eli.png' align='center' width='45' height='45'/></div>");  
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
                                return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/icono_dibu/dibu_ok.png' align='center' width='45' height='45'/></div>");
                            else
                                return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/icono_dibu/dibu_eli.png' align='center' width='45' height='45'/></div>");
                        },
            },
            type:'ComboBox',
            filters:{pfiltro:'dwf.chequeado_fisico',type:'string'},
            id_grupo:1,
            grid:true,
            egrid:true,
            form:true
        },
        {
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
        },
		
		
        {
            config:{
                fieldLabel: "Subir",
                gwidth: 110,
                inputType:'file',
                name: 'upload',
                buttonText: '',   
                maxLength:150,
                anchor:'100%',
                renderer:function (value, p, record){
                		if (record.data['tipo_documento'] == 'escaneado') {  
                            if(record.data['extension'].length!=0) {                                
                                return  String.format('{0}',"<div style='text-align:center'><a target=_blank align='center' width='70' height='70'>Reemplazar Archivo</a></div>");
                            } else {
                            	return  String.format('{0}',"<div style='text-align:center'><a target=_blank align='center' width='70' height='70'>Subir Archivo</a></div>");
                            }
                        }
                        },  
                buttonCfg: {
                    iconCls: 'upload-icon'
                }
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
                gwidth: 150,
                maxLength:200,
                renderer:function(value,p,record){
                         if( record.data.priorizacion==0||record.data.priorizacion==9){
                             return String.format('<b><font color="red">{0}***</font></b>', value);
                        }
                        else{
                            return String.format('{0}', value);
                        }},
                
            },
                type:'TextField',
                filters:{pfiltro:'t.descripcion_tipo_documento',type:'string'},
                id_grupo:1,
                grid:true,
                form:false
        },
        
        {
            config:{
                name: 'descripcion_proceso_wf',
                fieldLabel: 'Descripcion Proceso',
                allowBlank: true,
                anchor: '80%',
                gwidth: 150
                
            },
                type:'TextField',
                filters:{pfiltro:'pw.descripcion',type:'string'},
                id_grupo:1,
                grid:true,
                form:false
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
		
		/*this.addButton('btnUpload', {
                text : 'Subir Documento',
                iconCls : 'bupload1',
                disabled : true,
                handler : SubirArchivo,
                tooltip : '<b>Cargar Documento</b><br/>Al subir el archivo, el registro sera marcado como Chequeado OK'
        });*/
        
        if (this.check_fisico == 'si') {
	        this.addButton('btnMomento', {
	                text : 'Cambiar Modo',
	                iconCls : 'bunlock',
	                disabled : true,
	                handler : this.cambiarMomento,
	                tooltip : '<b>Hacer Obligatorio/Quitar axigencia</b><br/>Se verifica este estado si el documento  tiene al menos un estado de verificacón'
	        });
	    }
        

        this.grid.addListener('celldblclick',this.oncelldblclick,this);
        this.grid.addListener('cellclick',this.oncellclick,this);

        //si viene del formulario de solicitud agregamos un botono de finalizar
        if(config.tipo === 'solcom'){
        	this.tbar.add('->');
        	this.addButton('fin_solcom',{ text:'Solo Guardar', iconCls: 'bok', disabled: false,
							        	  handler: function(){
							        	 	 this.panel.destroy();
							        	  }, 
							        	  tooltip: '<b>Solo guardar</b><br>Deja la sollicitud en borrador, permite continuar despues'});
            
        	this.addButton('fin_requerimiento',{ text:'Finalizar Solicitud', iconCls: 'badelante', disabled: false,
									        	 handler: function(){
									        	 	this.fireEvent('finalizarsol', this, this.maestro, true);
									        	 
									        	 }, 
									        	 tooltip: '<b>Finalizar</b><br>Finaliza la solicitud y la manda para aprobación'});
        	 
        	
        	
        }
            
       
        
       this.init();
       
       cm = this.grid.getColumnModel();
       
       
       if (this.check_fisico == 'no') {
       		cm.setHidden(2,true);
       		cm.setHidden(3,true);
       }
       
       this.store.baseParams.todos_documentos = this.todos_documentos;
       this.store.baseParams.anulados = this.anulados;
        this.load({params:{
            start:0, 
            limit:50,
            id_proceso_wf: this.id_proceso_wf            
            }});
            
                
       
       
       
	},
	SubirArchivo : function(rec)
    {                   
        
        Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/SubirArchivoWf.php',
        'Subir Archivo',
        {
            modal:true,
            width:450,
            height:150
        },rec.data,this.idContenedor,'SubirArchivoWf')
    },
	
	oncellclick : function(grid, rowIndex, columnIndex, e) {
	    var record = this.store.getAt(rowIndex);  // Get the Record
	    var fieldName = grid.getColumnModel().getDataIndex(columnIndex); // Get field name
	    
	    if (fieldName == 'nro_tramite_ori' && record.data.id_proceso_wf_ori) {
	    	//open documentos de origen
       		this.loadCheckDocumentosSolWf(record);
	    } else if (fieldName == 'upload') {
	    	if (record.data.tipo_documento == 'escaneado') {
	    		this.SubirArchivo(record);
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
	
	oncelldblclick : function (grid,index) {
		record = this.store.getAt(index);
		if(record.data['extension'].length!=0) {
            var data = "id=" + record.data['id_documento_wf'];
            data += "&extension=" + record.data['extension'];
            data += "&sistema=sis_workflow";
            data += "&clase=DocumentoWf";
            data += "&url="+record.data['url'];
            //return  String.format('{0}',"<div style='text-align:center'><a target=_blank href = '../../../lib/lib_control/CTOpenFile.php?"+ data+"' align='center' width='70' height='70'>Abrir</a></div>");
            window.open('../../../lib/lib_control/CTOpenFile.php?' + data);
        } else if (record.data['tipo_documento'] == 'generado') {
        	
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
        {name:'fecha_upload', type: 'date',dateFormat:'Y-m-d H:i:s.u'}
		
		
	],
	
	preparaMenu:function(tb){
        Phx.vista.DocumentoWf.superclass.preparaMenu.call(this,tb)
        var data = this.getSelectedData();
       // if(this.todos_documentos == 'no'){
	        //this.getBoton('btnUpload').enable();
	        if (this.check_fisico == 'si') {
		        this.getBoton('btnMomento').enable(); 
		        
		        
		        if(data['momento']== 'exigir'){
		            this.getBoton('btnMomento').setIconClass('bunlock')
		        }
		        else{
		            this.getBoton('btnMomento').setIconClass('block')
		        }
		    }        
	        
	        if(data.nombre_estado.toLowerCase()=='anulada'||data.nombre_estado.toLowerCase()=='anulado'||data.nombre_estado.toLowerCase()=='cancelado'){
	           //this.getBoton('btnUpload').disable();
	           if (this.check_fisico == 'si') { 
	           	this.getBoton('btnMomento').disable();
	           }
	        }
	        if(data.solo_lectura.toLowerCase() == 'si'){
	        	this.desBotonesTodo();
	        }
	   // } else {
	   // 	
	   // }      
    },
    
    desBotonesTodo:function(){
          if (this.check_fisico == 'si') {
          	this.getBoton('btnMomento').disable();
          }
          //this.getBoton('btnUpload').disable();
          this.getBoton('edit').disable();
          this.getBoton('save').disable();
    },
    
    liberaMenu:function(tb){
        Phx.vista.DocumentoWf.superclass.liberaMenu.call(this,tb);
       // if(this.todos_documentos == 'no'){
	        if (this.check_fisico == 'si') {
	          	this.getBoton('btnMomento').disable();
	          
	        	this.getBoton('btnMomento').disable();
	        }
	   //		this.desBotonesTodo();
	   //}
             
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
	successMomento:function(resp){
       Phx.CP.loadingHide();
       var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
       if(!reg.ROOT.error){
         this.reload();
       }
    },
    
      
	bdel:false,
	bnew:false,
	bsave:true
	}
)
</script>
		
		