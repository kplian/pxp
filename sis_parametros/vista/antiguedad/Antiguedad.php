<?php
/**
*@package pXP
*@file Antiguedad.php
*@author  (szambrana)
*@date 17-10-2019 14:41:21
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				17-10-2019				 (szambrana)				CREACION	

*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Antiguedad=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.idContenedor = config.idContenedor;
		//this.maestro=config.maestro;
		this.maestro = config;
    	//llama al constructor de la clase padre
		this.initButtons=[this.cmbGestion];
		Phx.vista.Antiguedad.superclass.constructor.call(this,config);

		//this.load({params:{start:0, limit:this.tam_pag}})
		this.cmbGestion.on('select', function(combo, record, index){
				console.log(combo, record, index);
				this.capturaFiltros();
		},this);	
		this.init();
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_antiguedad'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_gestion'
			},
			type:'Field',
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
				filters:{pfiltro:'antig.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'categoria_antiguedad',
				fieldLabel: 'Categoria de la antiguedad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'antig.categoria_antiguedad',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'dias_asignados',
				fieldLabel: 'Dias asignados',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'antig.dias_asignados',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'desde_anhos',
				fieldLabel: 'Desde (años)',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'antig.desde_anhos',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'hasta_anhos',
				fieldLabel: 'Hasta (años)',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'antig.hasta_anhos',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'obs_antiguedad',
				fieldLabel: 'Obs. antiguedad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:250
			},
				type:'TextField',
				filters:{pfiltro:'antig.obs_antiguedad',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
        {
            config:{
                name: 'gestion',
                fieldLabel: 'Gestion',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:100,
                renderer:function(value, p, record){
                    return String.format('<div align="center"><b><font size=2 >{0}</font></b></div>',value);
                }
            },
            type:'TextField',
            filters:{pfiltro:'g.gestion',type:'string'},
            id_grupo:1,
            grid:true,
            bottom_filter:true,
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
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
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
				filters:{pfiltro:'antig.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'antig.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'antig.usuario_ai',type:'string'},
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
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
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
				filters:{pfiltro:'antig.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Antiguedad',
	ActSave:'../../sis_parametros/control/Antiguedad/insertarAntiguedad',
	ActDel:'../../sis_parametros/control/Antiguedad/eliminarAntiguedad',
	ActList:'../../sis_parametros/control/Antiguedad/listarAntiguedad',
	id_store:'id_antiguedad',
	fields: [
		{name:'id_antiguedad', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'categoria_antiguedad', type: 'numeric'},
		{name:'dias_asignados', type: 'numeric'},
		{name:'desde_anhos', type: 'numeric'},
		{name:'hasta_anhos', type: 'numeric'},
		{name:'obs_antiguedad', type: 'string'},
		{name:'id_gestion', type: 'numeric'},
		{name:'gestion', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_antiguedad',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
    onButtonNew:function(){
        if(!this.validarFiltros()){
            alert('Especifique la Gestion')
        }else{
            Phx.vista.Antiguedad.superclass.onButtonNew.call(this);//habilita el boton y se abre
            this.Cmp.id_gestion.setValue(this.cmbGestion.getValue());
            //this.Cmp.id_funcionario.store.baseParams ={id_periodo:this.cmbPeriodo.getValue(),par_filtro: 'fun.codigo#pe.nombre_completo1'};  //#8
        }
    },
    capturaFiltros:function(combo, record, index){
       // this.desbloquearOrdenamientoGrid();
        if(this.validarFiltros()){
            this.store.baseParams.id_gestion = this.cmbGestion.getValue();
            this.load();
        }

    },
    validarFiltros:function(){
		console.log(this.cmbGestion.validate());
        if(this.cmbGestion.validate()){
            console.log('bien');
            return true;
        } else{
            console.log('mal');
            return false;

        }
    },
    onButtonAct:function(){
        this.store.baseParams.id_gestion=this.cmbGestion.getValue();
        Phx.vista.Antiguedad.superclass.onButtonAct.call(this);
    },	
	 onButtonNew:function(){
        if(!this.validarFiltros()){
            alert('Especifique el año')
        }else{
            Phx.vista.Antiguedad.superclass.onButtonNew.call(this);//habilita el boton y se abre
            this.Cmp.id_gestion.setValue(this.cmbGestion.getValue());
        }
    },

	//creamos el combo gestion
	cmbGestion: new Ext.form.ComboBox({
        fieldLabel: 'Gestion',
        allowBlank: false,
        emptyText:'Gestion...',
        blankText: 'Año',
        store:new Ext.data.JsonStore(
            {
                url: '../../sis_parametros/control/Gestion/listarGestion',
                id: 'id_gestion',
                root: 'datos',
                sortInfo:{
                    field: 'gestion',
                    direction: 'DESC'
                },
                totalProperty: 'total',
                fields: ['id_gestion','gestion'],
                // turn on remote sorting
                remoteSort: true,
                baseParams:{par_filtro:'gestion'}
            }),
    valueField: 'id_gestion',
    triggerAction: 'all',
    displayField: 'gestion',
    hiddenName: 'id_gestion',
    mode:'remote',
    pageSize:50,
    queryDelay:500,
    listWidth:'280',
    width:80
    }),
	}	
)
</script>
		
		