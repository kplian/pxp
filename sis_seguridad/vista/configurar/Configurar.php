<?php
/**
*@package pXP
*@file Configurar.php
*@author  (mflores)
*@date 29-11-2011
*@description Para configurar la cuenta
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Configurar = Ext.extend(Phx.frmInterfaz,
{
	constructor: function(config)
	{
		Phx.vista.Configurar.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();	
	},	
	
	Atributos:
	[
       	{
			//configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_usuario'
			},
			type:'Field',
			form:true 
		},
       	{
       		config:{
	       		name: 'autentificacion',
				fieldLabel: 'Autentificación',
				    allowBlank: false,
					typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    store:['local','ldap']	       		    
       		},
       		type:'ComboBox',
       		id_grupo:0,
       		form:true
	    },
	    {
       		config:{
	       		name: 'modificar_clave',
				fieldLabel: 'Cambiar contraseña',
				    allowBlank: false,
					typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    store:['SI','NO']	       		    
       		},
       		type:'ComboBox',
       		id_grupo:1,
       		form:true
	    },	    
	    {
			config:{
				name: 'clave_anterior',
				fieldLabel: 'Contraseña anterior',
				allowBlank: true,
				anchor: '35%',
				gwidth: 100,
				inputType: 'password',
				maxLength:500
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'clave_nueva',
				fieldLabel: 'Nueva contraseña',
				allowBlank: true,
				anchor: '35%',
				gwidth: 100,
				inputType: 'password',
				showCapsWarning: false,
				showStrengthMeter: true,
				maxLength:500,
				validateValue:
				
					function(pw)
					{							
						function tiene_numeros(pw)
						{
							var expreg=/^.*[0-9]+.*$/;
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}						
						
						function tiene_letras(pw)
						{
						   var expreg=/^.*[a-zA-Z������������]+.*$/;
						  
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}
							
						function tiene_minusculas(pw)
						{
						   var expreg=/^.*[a-z������]+.*$/;
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}
					
						function tiene_mayusculas(pw)
						{
						   var expreg=/^.*[A-Z������]+.*$/;
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}
						
						function tiene_especial(pw)
						{
						   var expreg=/^.*\W+.*$/;	   //[^a-zA-Z0-9������������]
							if(expreg.test(pw))
						    	return 1;
						  	return 0;
						}		
						
						var x = '';
						var seguridad = 0;												
											
						if(tiene_numeros(pw)==1)
							seguridad += 18;
						else
							x += 'No contiene números<br>';
															
						if(tiene_minusculas(pw)==1)
							seguridad += 18;
						else
							x += 'No contiene minúsculas<br>';
									
						
						if(tiene_mayusculas(pw)==1)
							seguridad += 18;
						else
							x += 'No contiene mayúsculas<br>';
									
						
						if(tiene_especial(pw)==1)
							seguridad += 18;
						else
							x += 'No contiene especiales<br>';
											
						if(pw.length > 8)
							seguridad += 18;
						else
							x += '8 caracteres mínimamente<br>';
						
						this.markInvalid(x);
						
						if(pw.length == 0)
							seguridad = 0;
							
						if(x=='')
							return true
						else
						    return false				
					}																			
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'clave_confirmacion',
				fieldLabel: 'Confirmación',
				allowBlank: true,
				anchor: '35%',
				gwidth: 100,
				inputType: 'password',
				maxLength:500
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'clave_windows',
				fieldLabel: 'Contraseña actual de Windows',
				allowBlank: true,
				anchor: '35%',
				gwidth: 100,
				inputType: 'password',
				maxLength:500
			},
			type:'TextField',
			id_grupo:0,
			grid:true,
			form:true
		},
		{
       		config:{ 
	       		name: 'estilo',
				fieldLabel: 'Estilo de vista',
				    allowBlank: false,
					typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    store:['xtheme-blue.css','xtheme-gray.css','xtheme-access.css','verdek/css/xtheme-verdek.css','lilamarti/css/xtheme-lilamarti.css','rosaguy/css/xtheme-rosaguy.css']	       		    
       		},
       		type:'ComboBox',
       		id_grupo:0,
       		form:true
	    }
	],
	title:'Configuración',
	ActSave:'../../sis_seguridad/control/Configurar/configurar',
	topBar:true,
	botones:false,
	borientacion:false,
	bformato:false,
	btamano:false,
	labelReset:'Limpiar',
	tooltipSubmit:'<b>Guardar cambios</b>',
	tooltipReset:'<b>Limpiar campos</b>',	
	//iconSubmit:'../../../lib/imagenes/guardar.jpg',				
	
	Grupos: 
	[
    	{
            xtype:'tabpanel',
            plain:true,
            activeTab: 0,
            height:400,
            
            //  By turning off deferred rendering we are guaranteeing that the
            //  form fields within tabs that are not activated will still be rendered.
            //  This is often important when creating multi-tabbed forms.
            
           // deferredRender: false,
            defaults:{bodyStyle:'padding:10px 10px 9px 70px'},
            items:[{
                title:'Preferencias',
                layout:'form',
                id:'tab1-Phx.vista.Configurar-13579',
                items: [],
				id_grupo: 0
            },{
                //cls:'x-plain',
                title:'Cambio de contraseña',
                layout:'form',
                id:'tab2-Phx.vista.Configurar-02468',
                items: [],
				id_grupo: 1
            }]
        }
    ],
    
    onSubmit:function(o)
    {    
    	if (this.form.getForm().isValid()) {
    	
        	if(this.getComponente('clave_nueva').getValue() != this.getComponente('clave_confirmacion').getValue())
        	{
        		Ext.Msg.alert('ERROR', 'Confirmación no coincide con la contraseña nueva.');   
        		         
            }
        	
        	Phx.CP.loadingShow();
            // arma json en cadena para enviar al servidor
            Ext.apply(this.argumentSave, o.argument);
            //console.log(this.argumentSave,o.argument)
            
            
             if(this.getComponente('modificar_clave').getValue() == 'SI'){
            	
            	Ext.Ajax.request({
	                    url: this.ActSave,
	                    //params:this.form.getForm().getValues(),
	                    params: {
	                        autentificacion:this.getComponente('autentificacion').getValue(),
	                        modificar_clave:this.getComponente('modificar_clave').getValue(),
	                        clave_anterior: md5(this.getComponente('clave_anterior').getValue()),
	                        clave_nueva: md5(this.getComponente('clave_nueva').getValue()),
	                        clave_confirmacion: md5(this.getComponente('clave_confirmacion').getValue()),
	                        clave_windows: md5(this.getComponente('clave_windows').getValue()),
	                        estilo:this.getComponente('estilo').getValue()
	                    },
	                    isUpload: this.fileUpload,
	                    success: this.successSave,
	                    argument: this.argumentSave,
	                    failure: this.conexionFailure,
	                    timeout: this.timeout,
	                    scope: this
	            });
            }
            else{
            	
	            	Ext.Ajax.request({
	                    url: this.ActSave,
	                    //params:this.form.getForm().getValues(),
	                    params: {
	                        autentificacion:this.getComponente('autentificacion').getValue(),
	                        modificar_clave:this.getComponente('modificar_clave').getValue(),
	                        estilo:this.getComponente('estilo').getValue()
	                    },
	                    isUpload: this.fileUpload,
	                    success: this.successSave,
	                    argument: this.argumentSave,
	                    failure: this.conexionFailure,
	                    timeout: this.timeout,
	                    scope: this
	            });
            	
            	
            }
            
            
            
           

        }
    },
    
    successSave:function(r)
    {		
		this.getComponente('clave_nueva').setValue("");
		this.getComponente('clave_anterior').setValue("");		
		this.getComponente('clave_confirmacion').setValue("");
		this.getComponente('clave_windows').setValue("");
		this.getComponente('modificar_clave').setValue("NO");
		
		Phx.vista.Configurar.superclass.successSave.call(this,r);	
		
		var auten = '';
		if(this.getComponente('autentificacion').getValue() == 'ldap')
		{
			auten = 'ldap';
		} 
		else
		{
			auten = 'local';
		}
		
		Phx.CP.config_ini.autentificacion = auten;	
		
		if(Phx.CP.config_ini.autentificacion == 'ldap')
		{
			this.getComponente('autentificacion').setValue("ldap");
		}
		else
		{
			this.getComponente('autentificacion').setValue("local");
		}
		
		this.getComponente('clave_nueva').disable();
		this.getComponente('clave_anterior').disable();		
		this.getComponente('clave_confirmacion').disable();
		this.getComponente('clave_windows').disable();
		this.ocultarComponente(this.getComponente('clave_anterior'));
		this.ocultarComponente(this.getComponente('clave_nueva'));
		this.ocultarComponente(this.getComponente('clave_confirmacion'));
		this.ocultarComponente(this.getComponente('clave_windows'));
	},
	
	conexionFailure:function(resp1,resp2,resp3,resp4,resp5)
	{		
		this.getComponente('clave_nueva').setValue("");
		this.getComponente('clave_anterior').setValue("");		
		this.getComponente('clave_confirmacion').setValue("");
		this.getComponente('clave_windows').setValue("");
		Phx.vista.Configurar.superclass.conexionFailure.call(this,resp1,resp2,resp3,resp4,resp5)
	},
	
	iniciarEventos:function()
	{		
		var tab2 = Ext.getCmp('tab2-Phx.vista.Configurar-02468');
		this.getComponente('clave_nueva').disable();
		this.getComponente('clave_anterior').disable();		
		this.getComponente('clave_confirmacion').disable();
		this.getComponente('clave_windows').disable();
		
		this.ocultarComponente(this.getComponente('clave_anterior'));
		this.ocultarComponente(this.getComponente('clave_nueva'));
		this.ocultarComponente(this.getComponente('clave_confirmacion'));
		this.ocultarComponente(this.getComponente('clave_windows'));
								
		if(Phx.CP.config_ini.autentificacion == 'local')
		{
			this.getComponente('autentificacion').setValue('local');
			tab2.enable();
		}
		else
		{
			this.getComponente('autentificacion').setValue('ldap');
			tab2.disable();
		}					
		
		this.getComponente('modificar_clave').setValue('NO');
		this.getComponente('estilo').setValue(Phx.CP.config_ini.estilo_vista);
		
		this.getComponente('autentificacion').on('select',function(c,r,i)
		{				
			if(i==1) //contraseña windows
			{
				this.mostrarComponente(this.getComponente('clave_windows'));
				this.getComponente('clave_windows').enable();
				tab2.disable();
			}
			else //contraseña endesis
			{
				this.ocultarComponente(this.getComponente('clave_windows'));
				this.getComponente('clave_windows').disable();
				tab2.enable();
			}
		},this);
		
		this.getComponente('modificar_clave').on('select',function(c,r,i)
		{				
			if(i==0) //cambiar clave -- SI
			{
				this.mostrarComponente(this.getComponente('clave_anterior'));
				this.mostrarComponente(this.getComponente('clave_nueva'));
				this.mostrarComponente(this.getComponente('clave_confirmacion'));
				this.getComponente('clave_nueva').enable();
				this.getComponente('clave_anterior').enable();		
				this.getComponente('clave_confirmacion').enable();
			}
			else //NO
			{
				this.ocultarComponente(this.getComponente('clave_anterior'));
				this.ocultarComponente(this.getComponente('clave_nueva'));
				this.ocultarComponente(this.getComponente('clave_confirmacion'));
				this.getComponente('clave_nueva').disable();
				this.getComponente('clave_anterior').disable();		
				this.getComponente('clave_confirmacion').disable();
			}
		},this);			
		
		this.getComponente('estilo').on('select',function(c,r,i)
		{
			Phx.CP.setEstiloVista(this.getComponente('estilo').getValue());
		},this);
			
	},			
})
</script>