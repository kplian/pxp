<?php
/**
*@package pXP
*@file gen-Firma.php
*@author  (admin)
*@date 11-07-2013 15:32:07
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Firma=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Firma.superclass.constructor.call(this,config);
		this.init();
		this.bloquearMenus();
        if(Phx.CP.getPagina(this.idContenedorPadre)){
         var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
         if(dataMaestro){ 
            this.onEnablePanel(this,dataMaestro)
            }
         }
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_firma'
			},
			type:'Field',
			form:true 
		},
        {
            config:{
                name: 'id_depto',
                inputType:'hidden'
               
            },
            type:'Field',
            grid:false,
            form:true
        },
         {
            config:{
                name:'id_funcionario',
                 hiddenName: 'id_funcionario',
                origen:'FUNCIONARIOCAR',
                fieldLabel:'Funcionario',
                allowBlank:false,
                gwidth:200,
                valueField: 'id_funcionario',
                gdisplayField: 'desc_funcionario1',
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario1']);}
             },
            type:'ComboRec',//ComboRec
            id_grupo:0,
            filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
            grid:true,
            form:true
         },
        
		{
			config:{
				name: 'desc_firma',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:250
			},
			type:'TextField',
			filters:{pfiltro:'fir.desc_firma',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'prioridad',
                fieldLabel: 'Prioridad',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
            type:'NumberField',
            filters:{pfiltro:'fir.prioridad',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'monto_min',
				fieldLabel: 'Monto Min.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1
			},
			type:'NumberField',
			filters:{pfiltro:'fir.monto_min',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'monto_max',
				fieldLabel: 'Monto Max.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'NumberField',
			filters:{pfiltro:'fir.monto_max',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name:'id_documento',
                fieldLabel:'Documento',
                allowBlank:false,
                emptyText:'Documento...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Documento/listarDocumento',
                    id: 'id_documento',
                    root: 'datos',
                    sortInfo:{
                        field: 'codigo',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_documento','codigo','descripcion'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'DOCUME.codigo#DOCUME.descripcion'}
                }),
                valueField: 'id_documento',
                displayField: 'descripcion',
                gdisplayField:'desc_documento',//mapea al store del grid
                tpl:'<tpl for="."><div class="x-combo-list-item"><p>({codigo}) {descripcion}</p> </div></tpl>',
                hiddenName: 'id_documento',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                minListWidth :280,
                width:250,
                gwidth:250,
                minChars:2,
                renderer:function (value, p, record){return String.format('{0}', record.data['desc_documento']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                        pfiltro:'doc.descripcion#doc.codigo',
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
            filters:{pfiltro:'fir.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'fir.fecha_reg',type:'date'},
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
			filters:{pfiltro:'fir.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Firma',
	ActSave:'../../sis_parametros/control/Firma/insertarFirma',
	ActDel:'../../sis_parametros/control/Firma/eliminarFirma',
	ActList:'../../sis_parametros/control/Firma/listarFirma',
	id_store:'id_firma',
	fields: [
		{name:'id_firma', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'desc_firma', type: 'string'},
		{name:'monto_min', type: 'numeric'},
		{name:'prioridad', type: 'numeric'},
		{name:'monto_max', type: 'numeric'},
		{name:'id_documento', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'id_depto', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_funcionario1','desc_documento'
		
	],
	 onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_depto:this.maestro.id_depto};
      
        this.load({params:{start:0, limit:this.tam_pag}})
    },
    loadValoresIniciales:function(){
        Phx.vista.Firma.superclass.loadValoresIniciales.call(this);
        this.Cmp.id_depto.setValue(this.maestro.id_depto);
    },
	sortInfo:{
		field: 'id_firma',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		