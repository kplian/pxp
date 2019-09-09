<?php
/**
*@package pXP
*@file Persona.php
*@author KPLIAN (JRR)
*@date 14-02-2011
*@description  Vista para regitro de datos de persona 
ISSUE            FECHA:         EMPRESA     AUTOR               DESCRIPCION  
  #40            31-07-2019     ETR		     MZM                Adicion de campos matricula, historia_clinica en tabla con sus correspondientes cambios en funciones. Adicion de campo fecha_nacimiento a vista
  #55			02.09.2019		ETR			MZM					Adicion de campo abreviatura_titulo
  #59 			09.09.2019		ETR			MZM					Adicion de campo profesion
 * */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.persona=Ext.extend(Phx.gridInterfaz,{
    //tabEnter:true,
	Atributos:[
	{
   	  config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_persona'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Nombre",
			gwidth: 130,
			name: 'nombre',
			allowBlank:false,	
			maxLength:150,
			minLength:2,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		bottom_filter : true,
		id_grupo:0,
		grid:true,
		form:true,
		egrid:true
	},
	 {
		config:{
			fieldLabel: "Apellido Paterno",
			gwidth: 130,
			name: 'ap_paterno',
			allowBlank:false,	
			maxLength:150,
			
			anchor:'100%'
		},
		type:'TextField',
		filters:{pfiltro:'p.apellido_paterno',type:'string'},
		bottom_filter : true,
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Apellido Materno",
			gwidth: 130,
			name: 'ap_materno',
			allowBlank:true,	
			maxLength:150,
			anchor:'100%'
		},
		type:'TextField',
		filters:{pfiltro:'p.apellido_materno',type:'string'},//p.apellido_paterno
		bottom_filter : true,
		id_grupo:0,
		grid:true,
		form:true
	},{ //#40: adicion en vista de campo fecha_nacimiento (Para ingreso de informacion de los dependientes)
	       		config:{
	       			fieldLabel: "Fecha de Nacimiento",
	       			gwidth: 120,
	       			name: 'fecha_nacimiento',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			format:'d/m/Y',
	       			anchor:'100%',
	       			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
				},
	       		type:'DateField',
	       		filters:{type:'date'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       	{
	       		config:{
	       			name:'genero',
	       			fieldLabel:'Genero',
	       			allowBlank:true,
	       			emptyText:'Genero...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['masculino','femenino']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['masculino','femenino']
	       		 	},
	       		grid:true,       		
	       		form:true
	       	},
	       	
	       	
	       	// fin #40
	 {
		config:{
			fieldLabel: "Foto",
			gwidth: 130,
			inputType:'file',
			name: 'foto',
			//allowBlank:true,
			  buttonText: '',	
			maxLength:150,
			anchor:'100%',
			renderer:function (value, p, record){	
						var momentoActual = new Date();
					
						var hora = momentoActual.getHours();
						var minuto = momentoActual.getMinutes();
						var segundo = momentoActual.getSeconds();
						
						hora_actual = hora+":"+minuto+":"+segundo;
						
					
						
						//return  String.format('{0}',"<div style='text-align:center'><img src = ../../control/foto_persona/"+ record.data['foto']+"?"+record.data['nombre_foto']+hora_actual+" align='center' width='70' height='70'/></div>");
						var splittedArray = record.data['foto'].split('.');
						if (splittedArray[splittedArray.length - 1] != "") {
							return  String.format('{0}',"<div style='text-align:center'><img src = '../../control/foto_persona/ActionArmafoto.php?nombre="+ record.data['foto']+"&asd="+hora_actual+"' align='center' width='70' height='70'/></div>");
						} else {
							return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/NoPerfilImage.jpg' align='center' width='70' height='70'/></div>");
						}
						
					},	
			buttonCfg: {
                iconCls: 'upload-icon'
            }
		},
		//type:'FileUploadField',
		type:'Field',
		sortable:false,
		//filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:false
	},
	{
	       		config:{
	       			name:'tipo_documento',
	       			fieldLabel:'Tipo Documento',
	       			allowBlank:true,
	       			emptyText:'Tipo Doc...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['documento_identidad','pasaporte','Ninguno']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['documento_identidad','pasaporte'],	
	       		 	},
	       		grid:true,
	       		valorInicial:'documento_identidad',
	       		form:true
	       	},
	 {
		config:{
			fieldLabel: "CI",
			gwidth: 80,
			name: 'ci',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
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
	       			name:'expedicion',
	       			fieldLabel:'Expedido En',
	       			allowBlank:true,
	       			emptyText:'Expedido En...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['CB','LP','BN','CJ','PT','CH','TJ','SC','OR','OTRO']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['CB','LP','BN','CJ','PT','CH','TJ','SC','OR','OTRO'],	
	       		 	},
	       		grid:true,
	       		valorInicial:'expedicion',
	       		form:true
	       	},
	
	 {
		config:{
			fieldLabel: "Telefono",
			gwidth: 120,
			name: 'telefono1',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
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
			fieldLabel: "Celular",
			gwidth: 120,
			name: 'celular1',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
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
			fieldLabel: "Correo",
			gwidth: 150,
			name: 'correo',
			allowBlank:true,
			vtype:'email',	
			maxLength:100,
			minLength:5,
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
			fieldLabel: "Telefono 2",
			gwidth: 120,
			name: 'telefono2',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
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
			fieldLabel: "Celular 2",
			gwidth: 120,
			name: 'celular2',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
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
			fieldLabel: "Matricula",
			gwidth: 120,
			name: 'matricula',
			allowBlank:true,	
			maxLength:20,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},{
		config:{
			fieldLabel: "Historia Clinica",
			gwidth: 120,
			name: 'historia_clinica',
			allowBlank:true,	
			maxLength:20,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},{
	       		config:{
	       			name:'grupo_sanguineo',
	       			fieldLabel:'Grupo Sanguineo',
	       			allowBlank:true,
	       			emptyText:'Grupo Sanguineo...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['O Rh+','O Rh-','A Rh+','A Rh-','B Rh+','B Rh-','AB Rh+','AB Rh-']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['O Rh+','O Rh-','A Rh+','A Rh-','B Rh+','B Rh-','AB Rh+','AB Rh-'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	}
	   ,{//#55 (I)
	       		config:{
	       			name:'abreviatura_titulo',
	       			fieldLabel:'Titulo (abrev)',
	       			allowBlank:true,
	       			emptyText:'Abreviatura de Titulo...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['Lic.','Ing.','Msc.','Ph.D.','Tec.','Sr.']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['Lic.','Ing.','Msc.','Ph.D.','Tec.','Sr.'],	
	       		 	},
	       		grid:true,
	       		form:true
	       } //#55(F)
	    ,{//#59
		config:{
			fieldLabel: "Profesion",
			gwidth: 120,
			name: 'profesion',
			allowBlank:true,	
			maxLength:50,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	}//#59 (F)
	       	
	],


    //fileUpload:true,
	title:'Persona',
	ActSave:'../../sis_seguridad/control/Persona/guardarPersona',
	ActDel:'../../sis_seguridad/control/Persona/eliminarPersona',
	ActList:'../../sis_seguridad/control/Persona/listarPersonaFoto',
	id_store:'id_persona',
	fields: [
	{name:'id_persona'},
	{name:'nombre', type: 'string'},
	{name:'tipo_documento', type: 'string'},
	{name:'expedicion', type: 'string'},
	{name:'ap_paterno', type: 'string'},
	{name:'ap_materno', type: 'string'},
	{name:'ci', type: 'string'},
	{name:'correo', type: 'string'},
	{name:'celular1'},
	{name:'telefono1'},
	{name:'telefono2'},
	{name:'celular2'},
	{name:'foto'}
	//#40: adicion de campos
	,
	{name:'matricula', type: 'string'},
	{name:'historia_clinica', type: 'string'},
	{name:'fecha_nacimiento', type: 'date', dateFormat:'Y-m-d'},
	{name:'genero', type: 'string'}
	//fin #40
	//#55 - 02.09.2019
	,{name:'abreviatura_titulo', type: 'string'}
	,{name:'profesion', type: 'string'} //#59 - 09.09.2019
		],
	sortInfo:{
		field: 'id_persona',
		direction: 'ASC'
	},
	bdel:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
    bsave:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
    bnew:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
    bedit:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
	
	
	fheight: 350,
	fwidth: 400,
	
	
    

	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.persona.superclass.preparaMenu.call(this,tb)
		this.getBoton('aSubirFoto').enable();
		//this.getBoton('x').enable();
	},
	
	liberaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.persona.superclass.liberaMenu.call(this,tb)
		this.getBoton('aSubirFoto').disable();
		//this.getBoton('x').disable();
		
	},
	
	// Funcion guardar del formulario
    onSubmit: function(o, x, force) {    	
    	var me = this;
    	if (me.form.getForm().isValid()) {

            Phx.CP.loadingShow();
            // arma json en cadena para enviar al servidor
            Ext.apply(me.argumentSave, o.argument); 
            
            Ext.Ajax.request({
                url: '../../sis_seguridad/control/Persona/validarPersona',
                params: { 	'id_persona': this.Cmp.id_persona.getValue(),
                			'nombre' :  this.Cmp.nombre.getValue() + this.Cmp.ap_paterno.getValue()+ this.Cmp.ap_materno.getValue(),
                			'tipo_documento' :  this.Cmp.tipo_documento.getValue(),
                			'ci' :  this.Cmp.ci.getValue()},                
                success: me.successValidar,                
                failure: me.conexionFailure,
                timeout: me.timeout,
                argument: {'o':o,'x':x,'force':false},
                scope: me
            }); 

        }

    },
    successValidar : function(resp) {
    	var me = this;
    	var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
    	if (reg.ROOT.datos.tipo_mensaje == 'exito') {
    		Phx.vista.persona.superclass.onSubmit.call(this,resp.argument.o,resp.argument.x,resp.argument.force);
    	} else if (reg.ROOT.datos.tipo_mensaje == 'error') {
    		Phx.CP.loadingHide();
    		alert(reg.ROOT.datos.mensaje_error);    		
    	} else {
    		Phx.CP.loadingHide();
    		// Show a dialog using config options:
			Ext.Msg.show({
			   title:'ALERTA!',
			   msg: reg.ROOT.datos.mensaje_error,
			   buttons: Ext.Msg.YESNO,
			   fn: function(btn){
			   		if (btn == 'no') {
			   			
			   		} else {
			   			Phx.vista.persona.superclass.onSubmit.call(me,resp.argument.o,resp.argument.x,resp.argument.force);			   			
			   		}
				    
			   },
			   animEl: 'elId',
			   icon: Ext.MessageBox.QUESTION
			});
    	}
	},

	/*
	 * Grupos:[{
	 * 
	 * xtype:'fieldset', border: false, //title: 'Checkbox Groups', autoHeight:
	 * true, layout: 'form', items:[], id_grupo:0 }],
	 */

	constructor: function(config){
		// configuracion del data store
		Phx.vista.persona.superclass.constructor.call(this,config);

        this.addButton('archivo', {
            argument: {imprimir: 'archivo'},
            text: '<i class="fa fa-thumbs-o-up fa-2x"></i> archivo', /*iconCls:'' ,*/
            disabled: false,
            handler: this.archivo
        });

   		
       
        
        this.init();
		// this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip:
		// '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50}})
		//agregamos boton para mostrar ventana hijo
		this.addButton('aSubirFoto',{name:'subirFoto',text:'Subir Foto',iconCls: 'baddphoto',disabled:true,handler:this.SubirFoto,tooltip: '<b>Subir Foto</b><br/>Permite actualizar la foto de la persona'});
		this.iniciarEventos();
	},
	SubirFoto(){					
			var rec=this.sm.getSelected();
			Phx.CP.loadWindows('../../../sis_seguridad/vista/persona/subirFotoPersona.php',
			'Subir foto',
			{
				modal:true,
				width:400,
				height:150
		    },rec.data,this.idContenedor,'subirFotoPersona')
	},iniciarEventos(){
	   	this.Cmp.tipo_documento.on('select',function(combo,record,index){
	    	if(combo.getValue()=='Ninguno'){
	    		this.Cmp.ci.reset();
	    		this.Cmp.ci.disable();
	    		this.Cmp.expedicion.reset();
	    		this.Cmp.expedicion.disable();
	    		this.Cmp.ci.modificado=true;
	    		this.Cmp.expedicion.modificado=true;	
	    	}else{
	    		this.Cmp.ci.enable();
	    		this.Cmp.expedicion.enable();
	    		this.Cmp.ci.modificado=true;
	    		this.Cmp.expedicion.modificado=true;
	    	}	    	
	   	},this)
   },

    archivo : function (){



        var rec = this.getSelectedData();

        //enviamos el id seleccionado para cual el archivo se deba subir
        rec.datos_extras_id = rec.id_persona;
        //enviamos el nombre de la tabla
        rec.datos_extras_tabla = 'tpersona';
        //enviamos el codigo ya que una tabla puede tener varios archivos diferentes como ci,pasaporte,contrato,slider,fotos,etc
        rec.datos_extras_codigo = 'ci_persona';

        //esto es cuando queremos darle una ruta personalizada
        //rec.datos_extras_ruta_personalizada = './../../../uploaded_files/favioVideos/videos/';

        Phx.CP.loadWindows('../../../sis_parametros/vista/archivo/Archivo.php',
            'Archivo',
            {
                width: 900,
                height: 400
            }, rec, this.idContenedor, 'Archivo');

    }
})
</script>