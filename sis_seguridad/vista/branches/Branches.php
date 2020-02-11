<?php
/**
*@package pXP
*@file gen-Branches.php
*@author  (miguel.mamani)
*@date 09-01-2020 21:26:12
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020				 (miguel.mamani)				CREACION	

*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Branches=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Branches.superclass.constructor.call(this,config);
		this.init();
        var dataPadre = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData()
        if(dataPadre){
            this.onEnablePanel(this, dataPadre);
        }
        else
        {
            this.bloquearMenus();
        }
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_branches'
			},
			type:'Field',
			form:true 
		},
        {
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_subsistema'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'name',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
				type:'TextField',
				filters:{pfiltro:'bas.name',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'sha',
				fieldLabel: 'Sha',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
				type:'TextField',
				filters:{pfiltro:'bas.sha',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'url',
				fieldLabel: 'Url',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
			},
				type:'TextField',
				filters:{pfiltro:'bas.url',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'protected',
				fieldLabel: 'Protected',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
				type:'Checkbox',
				filters:{pfiltro:'bas.protected',type:'boolean'},
				id_grupo:1,
				grid:true,
				form:true
		}
	],
	tam_pag:50,	
	title:'branches',
	ActSave:'../../sis_seguridad/control/Branches/insertarBranches',
	ActDel:'../../sis_seguridad/control/Branches/eliminarBranches',
	ActList:'../../sis_seguridad/control/Branches/listarBranches',
	id_store:'id_branches',
	fields: [
		{name:'id_branches', type: 'numeric'},
		{name:'name', type: 'string'},
		{name:'sha', type: 'string'},
		{name:'url', type: 'string'},
		{name:'protected', type: 'boolean'},
		{name:'id_subsistema', type: 'numeric'}
		
	],
	sortInfo:{
		field: 'id_branches',
		direction: 'ASC'
	},
	bdel:false,
	bsave:false,
    bnew:false,
    bedit:false,
    tabsouth:[
        {
            url:'../../../sis_seguridad/vista/issues/Issues.php',
            title:'Issues',
            height:'50%',
            cls:'Issues'
        },
        {
            url:'../../../sis_seguridad/vista/commit/Commit.php',
            title:'Commit',
            height:'50%',
            cls:'Commit'
        }
    ],
    loadValoresIniciales:function() {
        Phx.vista.Branches.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_subsistema').setValue(this.maestro.id_subsistema);
    },
    onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_subsistema:this.maestro.id_subsistema};
        this.load({params:{start:0, limit:50}})
    }
	}
)
</script>
		
		