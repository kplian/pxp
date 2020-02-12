<?php
/**
*@package pXP
*@file gen-Commit.php
*@author  (miguel.mamani)
*@date 09-01-2020 21:26:18
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020				 (miguel.mamani)				CREACION	

*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Commit=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Commit.superclass.constructor.call(this,config);
		this.init();
        var dataPadre = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
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
					name: 'id_commit'
			},
			type:'Field',
			form:true 
		},
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
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_issues'
			},
			type:'Field',
			form:true
		},
        {
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_programador'
			},
			type:'Field',
			form:true
		},
        {
            config:{
                name: 'issues',
                fieldLabel: '#Issues',
                allowBlank: true,
                anchor: '80%',
                gwidth: 80
            },
            type:'NumberField',
            filters:{pfiltro:'iss.number_issues',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'message',
                fieldLabel: 'Titulo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 500
            },
            type:'TextField',
            filters:{pfiltro:'com.message',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'author',
                fieldLabel: 'Autor',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:50
            },
            type:'TextField',
            filters:{pfiltro:'com.author',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },

        {
            config:{
                name: 'fecha',
                fieldLabel: 'Fecha',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                format: 'd/m/Y',
                renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
            },
            type:'DateField',
            filters:{pfiltro:'com.fecha',type:'date'},
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
				gwidth: 100
			},
				type:'TextField',
				filters:{pfiltro:'com.sha',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'html_url',
				fieldLabel: 'Url',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'com.html_url',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		}
	],
	tam_pag:50,	
	title:'Commit',
	ActSave:'../../sis_seguridad/control/Commit/insertarCommit',
	ActDel:'../../sis_seguridad/control/Commit/eliminarCommit',
	ActList:'../../sis_seguridad/control/Commit/listarCommit',
	id_store:'id_commit',
	fields: [
		{name:'id_commit', type: 'numeric'},
		{name:'id_issues', type: 'numeric'},
		{name:'sha', type: 'string'},
		{name:'html_url', type: 'string'},
		{name:'author', type: 'string'},
		{name:'id_programador', type: 'numeric'},
		{name:'message', type: 'string'},
		{name:'fecha', type: 'date',dateFormat:'Y-m-d'},
		{name:'id_subsistema', type: 'numeric'},
        {name:'id_branches', type: 'numeric'},
        {name:'issues', type: 'numeric'}
		
	],
	sortInfo:{
		field: 'issues',
		direction: 'DESC'
	},
    bdel:false,
    bsave:false,
    bnew:false,
    bedit:false,
    loadValoresIniciales:function() {
        Phx.vista.Commit.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_subsistema').setValue(this.maestro.id_subsistema);
    },
    onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_branches:this.maestro.id_branches};
        this.load({params:{start:0, limit:50}})
    }
	}
)
</script>
		
		