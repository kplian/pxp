<?php
/**
*@package pXP
*@file    SubirArchivo.php
*@author  Rensi ARteaga Copari
*@date    27-03-2014
*@description permites subir archivos a la tabla de documento_sol
 *  ISSUE            FECHA:              AUTOR                 DESCRIPCION  
  #97            17/06/2019        RAC                 interface para copiar roles de usaurio
 * 
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FormRolUsuario=Ext.extend(Phx.frmInterfaz,{
    ActSave:'../../sis_seguridad/control/Usuario/copiarRoles',
    layout: 'fit',
    maxCount: 0,
    constructor:function(config) {   
        Phx.vista.FormRolUsuario.superclass.constructor.call(this,config);
        this.init(); 
        
    },
   
    Atributos:[{
	   			config:{
	   				name:'id_usuario_origen',
	   				fieldLabel:'Usuario Origen',
	   				qtip:'Usuario desde donde copiaremos los roles/eps',
	   				allowBlank:false,
	   				emptyText:'Usuario...',
	   				store: new Ext.data.JsonStore({
	
						url: '../../sis_seguridad/control/Usuario/listarUsuario',
						id: 'id_persona',
						root: 'datos',
						sortInfo:{
							field: 'desc_person',
							direction: 'ASC'
						},
						totalProperty: 'total',
						fields: ['id_usuario','desc_person','cuenta'],
						// turn on remote sorting
						remoteSort: true,
						baseParams:{par_filtro:'PERSON.nombre_completo2#cuenta'}
					}),
	   				valueField: 'id_usuario',
	   				displayField: 'desc_person',
	   				gdisplayField:'desc_usuario',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
	   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{desc_person}</p><p>CI:{ci}</p> </div></tpl>',
	   				hiddenName: 'id_usuario',
	   				forceSelection:true,
	   				typeAhead: true,
	       			triggerAction: 'all',
	       			lazyRender:true,
	   				mode:'remote',
	   				pageSize:10,
	   				queryDelay:1000,
	   				width:250,
	   				gwidth:280,
	   				minChars:2
	   			},
	   			type:'ComboBox',
	   			id_grupo:0,
	   			form:true
	       	},
	       	{
	       		// configuracion del componente
	       		config:{
	       			labelSeparator:'',
	       			inputType:'hidden',
	       			name: 'id_usuario_destino'

	       		},
	       		type:'Field',
	       		form:true 
	       	},
			{
				config:{
					name: 'copy_rol',
					fieldLabel: 'Copiar Roles?',
					allowBlank: false,
					anchor: '100%',
					gwidth: 50,
					maxLength:2,
					emptyText:'si/no...',       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'inicio',       
	       		    store:['si','no']
				},
				valorInicial: 'si',
				type:'ComboBox',
				id_grupo:1,
				grid:true,
				form:true
			},
			{
				config:{
					name: 'copy_ep',
					fieldLabel: 'Copiar EP?',
					allowBlank: false,
					anchor: '100%',
					gwidth: 50,
					maxLength:2,
					emptyText:'si/no...',       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'inicio',       
	       		    store:['si','no']
				},
				type:'ComboBox',
				valorInicial: 'si',
				id_grupo:1,
				grid:true,
				form:true
			}          
    ],
    title:'Usuario',  
    loadValoresIniciales: function () {
    	Phx.vista.FormRolUsuario.superclass.loadValoresIniciales.call(this);
    	
    	console.log('datos obj', this)
    	this.Cmp.id_usuario_destino.setValue(this.data.data_usuario.id_usuario)
    },
    
    successSave:function(resp) {
            Phx.CP.loadingHide();
            Phx.CP.getPagina(this.idContenedorPadre).reload();
            this.panel.close();
    }   
})    
</script>
