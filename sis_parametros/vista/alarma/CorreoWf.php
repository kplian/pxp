<?php
/**
*@package pXP
*@file gen-Alarma.php
*@author  (fprudencio)
*@date 18-11-2011 11:59:10
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.CorreoWf = Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.CorreoWf.superclass.constructor.call(this,config);
		this.init();
		this.addButton('btnRenvio',{
                    text :'Reenviar/Enviar',
                    iconCls : 'bemail',
                    disabled: true,
                    handler : this.onReenviar,
                    tooltip : '<b>Reenviar</b><br/><b>Marca el correo para ser reenviado</b>'
          });
        
        this.store.baseParams = { id_proceso_wf: this.id_proceso_wf }; 
        this.load({ params: { start:0, limit: 50, id_usuario: Phx.CP.config_ini.id_usuario }})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_alarma'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'correos',
				fieldLabel: 'Destino',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200
			},
			type:'TextArea',
			filters:{pfiltro:'alarm.acceso_directo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'titulo_correo',
				fieldLabel: 'Asunto',
				allowBlank: true,
				gwidth: 500
			},
			type:'TextArea',
			filters: { pfiltro:'alarm.titulo_correo', type:'string'},
			id_grupo:1,
			grid: true,
			form: false
		},
		
		{
			config:{
				name: 'estado_envio',
				fieldLabel: 'Estado Envio',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10,
				renderer: function(value, p, record) {
                        if(record.data.sw_correo == 1){
                              return String.format('<b><font color="green">{0}</font></b>', 'Enviado');
                         }
                         else{
                         	if(record.data.estado_envio == 'falla'){
                               return String.format('<b><font color="red">{0}</font></b>', 'Fallido');
                            }
                            else if(record.data.estado_envio == 'bloqueado'){
                               return String.format('<b><font color="orange">{0}</font></b>', 'Bloqueado');
                            }
                            else{
                               return String.format('<b><font color="black">{0}</font></b>', 'Pendiente');
                            }
                         	
                         }
                 
                        
                },
			},
			type:'TextField',
			//filters:{pfiltro:'alarm.estado_envio',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'recibido',
				fieldLabel: 'Recibido',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'alarm.recibido',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_recibido',
				fieldLabel: 'Fecha Acuse',
				allowBlank: true,
				anchor: '80%',
				gwidth: 130,
				format: 'd/m/Y', 
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'alarm.fecha_recibido',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
		
		
	],
	title:'Alarmas',
	ActSave:'../../sis_parametros/control/Alarma/alterarDestino',
	ActList:'../../sis_parametros/control/Alarma/listarAlarmaWF',
	id_store:'id_alarma',
	
	fields: [
		{name:'id_alarma', type: 'numeric'},
		'id_alarma',
        'sw_correo',
        'correos',
        'descripcion',
        'recibido',
        {name:'fecha_recibido', type: 'date',dateFormat:'Y-m-d H:i:s'},
        'estado_envio',
        'desc_falla',
        'titulo_correo',
        'dias'
		
	],
	
	onReenviar: function(){
         
            var d= this.sm.getSelected().data;
            Phx.CP.loadingShow();
            
            Ext.Ajax.request({
                // form:this.form.getForm().getEl(),
                url:'../../sis_parametros/control/Alarma/reenviarCorreo',
                params: { id_alarma: d.id_alarma },
                success: this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });
    }, 
    successSinc:function(resp){
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                 this.reload();
               
            }else{
                
                alert('ocurrio un error')
            } 
    },
	rowExpander: new Ext.ux.grid.RowExpander({
	        tpl : new Ext.Template(
	            '<div style="margin-left:45px; width:100%;"><br>',
	            '<p>{descripcion}</p><br><br>',
	            '<p>{desc_falla}</p><br></div>'
	        )
    }),
    preparaMenu:function(n){
          var data = this.getSelectedData();
          var tb =this.tbar;
          Phx.vista.CorreoWf.superclass.preparaMenu.call(this,n);
          this.getBoton('btnRenvio').enable();
          return tb 
    },
     liberaMenu:function(){
        var tb = Phx.vista.CorreoWf.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnRenvio').disable();
         }
       
      
       return tb
    },
	sortInfo:{
		field: 'id_alarma',
		direction: 'ASC'
	},
	bdel:false,
	bnew: false,
	bedit: true,
	bsave:false
	}
)
</script>
		
		