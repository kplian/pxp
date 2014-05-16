<?php
/**
*@package pXP
*@file gen-GrupoEp.php
*@author  (admin)
*@date 22-04-2013 14:49:40
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.GrupoEp=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.GrupoEp.superclass.constructor.call(this,config);
		this.init();
		this.addButton('add_ep',{text:'Todas las EP\'s', iconCls: 'blist',disabled:true,handler:this.sinc_ep,tooltip: '<b>EP\'s</b><br/>Adicionar todas las EP\'s '});
        this.addButton('add_uo',{text:'Todas las UO\'s', iconCls: 'blist',disabled:true,handler:this.sinc_uo,tooltip: '<b>EP\'s</b><br/>Adicionar todas las UO\'s '});
        
       
        this.bloquearMenus();

    
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_grupo_ep'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_grupo',
				inputType:'hidden'
			},
			type:'Field',
			form:true
		},
        {
            config:{
                    name:'id_ep',
                    origen:'EP',
                    fieldLabel:'EP',
                    allowBlank:true,
                    gdisplayField:'ep',//mapea al store del grid
                    gwidth:200,
                    renderer:function (value, p, record){return String.format('{0}', record.data['ep']);}
                },
            type:'ComboRec',
            id_grupo:0,
            filters:{pfiltro:'ep',type:'string'},
            grid:true,
            form:true
        },
        {
            config:{
                name:'id_uo',
                origen:'UO',
                 allowBlank:true,
                fieldLabel:'Unidad',
                gdisplayField:'desc_uo',//mapea al store del grid
                gwidth:200,
                baseParams:{presupuesta:'si'},
                renderer:function (value, p, record){return String.format('{0}', record.data['desc_uo']);}     },
                type:'ComboRec',
                id_grupo:0,
                filters:{   
                            pfiltro:'nombre_unidad',
                            type:'string'
                        },
               
                grid:true,
                form:true
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
            filters:{pfiltro:'gqp.estado_reg',type:'string'},
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
			filters:{pfiltro:'gqp.fecha_reg',type:'date'},
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
			filters:{pfiltro:'gqp.fecha_mod',type:'date'},
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
		}
	],
	
	title:'Grupo EP',
	ActSave:'../../sis_parametros/control/GrupoEp/insertarGrupoEp',
	ActDel:'../../sis_parametros/control/GrupoEp/eliminarGrupoEp',
	ActList:'../../sis_parametros/control/GrupoEp/listarGrupoEp',
	id_store:'id_grupo_ep',
	fields: [
		{name:'id_grupo_ep', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_grupo', type: 'numeric'},
		{name:'id_ep', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'ep','desc_uo','id_uo'
	],
	sortInfo:{
		field: 'id_grupo_ep',
		direction: 'ASC'
	},
	loadValoresIniciales:function(){
        Phx.vista.GrupoEp.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_grupo').setValue(this.maestro.id_grupo);
    },
    
    onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_grupo:this.maestro.id_grupo};
        this.load({params:{start:0, limit:50}})
        
    },
    
    sinc_ep:function(){
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                url:'../../sis_parametros/control/GrupoEp/sincUoEp',
                params:{'id_grupo':this.maestro.id_grupo, 'config':'ep'},
                success:this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });
   },
   sinc_uo:function(){
           Phx.CP.loadingShow();
            Ext.Ajax.request({
                url:'../../sis_parametros/control/GrupoEp/sincUoEp',
                params:{'id_grupo':this.maestro.id_grupo, 'config':'uo'},
                success:this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });
   },
   
    successSinc:function(resp){
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                alert(reg.ROOT.datos.msg)
                
            }else{
                alert('ocurrio un error durante el proceso')
            }
            this.reload();
    },
    
    
	bdel:true,
	bsave:true
	}
)
</script>
		
		