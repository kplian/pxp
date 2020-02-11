<?php
/**
*@package pXP
*@file gen-Issues.php
*@author  (miguel.mamani)
*@date 09-01-2020 21:26:15
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020				 (miguel.mamani)				CREACION	

*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Issues=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Issues.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
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
					name: 'id_programador'
			},
			type:'Field',
			form:true
		},
        {
            config:{
                name: 'number_issues',
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
                name: 'title',
                fieldLabel: 'Titulo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 500
            },
            type:'TextField',
            filters:{pfiltro:'iss.title',type:'string'},
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
                maxLength:100
            },
            type:'TextField',
            filters:{pfiltro:'iss.author',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'state',
                fieldLabel: 'Estado',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:10,
                renderer: function(value,p,record){
                    var color = '';
                    if (record.data.state == 'open'){
                        color = 'green';
                    }else{
                        color = 'red';
                    }
                    return String.format('<font size = 2 color="'+color+'" >{0}</font>', value);
                }
            },
            type:'TextField',
            filters:{pfiltro:'iss.state',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'created_at',
				fieldLabel: 'Fecha Creacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'iss.created_at',type:'date'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'updated_at',
				fieldLabel: 'Fechar Mod.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'iss.updated_at',type:'date'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'closed_at',
				fieldLabel: 'Cerrado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'iss.closed_at',type:'date'},
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
                gwidth: 100
            },
            type:'TextField',
            filters:{pfiltro:'iss.html_url',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        }
	],
	tam_pag:50,	
	title:'Issues',
	ActSave:'../../sis_seguridad/control/Issues/insertarIssues',
	ActDel:'../../sis_seguridad/control/Issues/eliminarIssues',
	ActList:'../../sis_seguridad/control/Issues/listarIssues',
	id_store:'id_issues',
	fields: [
		{name:'id_issues', type: 'numeric'},
		{name:'id_programador', type: 'numeric'},
		{name:'html_url', type: 'string'},
		{name:'number_issues', type: 'numeric'},
		{name:'title', type: 'string'},
		{name:'author', type: 'string'},
		{name:'state', type: 'string'},
		{name:'created_at', type: 'date',dateFormat:'Y-m-d'},
		{name:'updated_at', type: 'date',dateFormat:'Y-m-d'},
		{name:'closed_at', type: 'date',dateFormat:'Y-m-d'},
		{name:'id_subsistema', type: 'numeric'}
		
	],
	sortInfo:{
		field: 'number_issues',
		direction: 'DESC'
	},
    bdel:false,
    bsave:false,
    bnew:false,
    bedit:false,
    loadValoresIniciales:function() {
        Phx.vista.Issues.superclass.loadValoresIniciales.call(this);
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
		
		