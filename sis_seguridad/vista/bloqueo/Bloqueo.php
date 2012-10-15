<?php
/**
*@package pXP
*@file Actividad.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar el listado de bloqueos de usuario, IP, MAC, etc.
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.bloqueo=Ext.extend(Phx.gridInterfaz,{



	Atributos:[
	{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_bloqueo_notificacion'

		},
		type:'Field',
		form:true 
		
	},
	{
		config:{
			fieldLabel: "Notificación",
			gwidth: 150,
			name: 'nombre_patron'
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true
	},
	{
		config:{
			fieldLabel: "Tipo de Evento",
			gwidth: 150,
			name: 'tipo_evento'
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true
	},
	{
		config:{
			fieldLabel: "Nivel de Aplicación",
			gwidth: 150,
			name: 'aplicacion'
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true
	},
	{
		config:{
			fieldLabel: "Usuario",
			gwidth: 150,
			name: 'usuario'
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true
	},
	{
		config:{
			fieldLabel: "IP",
			gwidth: 150,
			name: 'ip'
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true
	},
	{
		config:{
			fieldLabel: "Fecha Registro",
			gwidth: 150,
			name: 'fecha_hora_ini'
		},
		type:'TextField',
		grid:true
	},
	{
		config:{
			fieldLabel: "Fecha Validez",
			gwidth: 150,
			name: 'fecha_hora_fin'
		},
		type:'TextField',
		grid:true
	}
	],

	title:'Bloqueos',
	ActList:'../../sis_seguridad/control/BloqueoNotificacion/ListarBloqueo',
	id_store:'id_bloqueo_notificacion',
	fields: [
	{name:'id_bloqueo_notificacion'},
	{name:'nombre_patron', type: 'string'},
	{name:'aplicacion', type: 'string'},
	{name:'tipo_evento', type: 'string'},
	{name:'usuario', type: 'string'},
	{name:'ip', type: 'string'},
	{name:'fecha_hora_ini', type: 'string'},
	{name:'fecha_hora_fin', type: 'string'}
	
	],
	sortInfo:{
		field: 'id_bloqueo_notificacion',
		direction: 'DESC'
	},
	
	
	constructor: function(config){
		//configuraci�n del data store
		

		Phx.vista.bloqueo.superclass.constructor.call(this,config);


		this.init();
		
		this.addButton('noti_verificada',{text:'Desbloquear',icon: '../../../lib/imagenes/lock_open.png',disabled:true,handler:noti_verificada,tooltip: '<b>Desbloquear usuario/ip</b>'});
		this.load({params:{start:0, limit:50}});
		function noti_verificada(){
			var data=this.sm.getSelected().data.id_bloqueo_notificacion;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				// form:this.form.getForm().getEl(),
				url:'../../sis_seguridad/control/BloqueoNotificacion/CambiarEstadoBloqueoNotificacion',
				params:{'id_bloqueo_notificacion':data},
				success:this.successVerif,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
			// _CP.loadWindows('../../../sis_legal/vista/garantia/garantia.php','Garantia',{width:800,height:500},this.sm.getSelected().data,this.idContenedor);
		}

	},
	
	bdel:false,//boton para eliminar
	bsave:false,//boton para eliminar
	bedit:false,
	bnew:false,
	successVerif:function(resp){
			
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if(!reg.ROOT.error){
				alert(reg.ROOT.detalle.mensaje)
				
			}else{
				
				alert('ocurrio un error durante el proceso')
			}
			

		

			this.reload();
			
	},

	//sobre carga de patron_evento
	preparaMenu:function(tb){
		//llamada patron_evento clace padre
		this.getBoton('noti_verificada').enable();
		Phx.vista.bloqueo.superclass.preparaMenu.call(this,tb);
		return tb;
	},
	liberaMenu:function(tb){
		this.getBoton('noti_verificada').disable();
		Phx.vista.bloqueo.superclass.liberaMenu.call(this,tb);
		return tb;
	}	


  }
)
</script>