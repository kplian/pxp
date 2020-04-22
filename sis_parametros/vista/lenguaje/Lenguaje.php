<?php
/****************************************************************************************
*@package pXP
*@file gen-Lenguaje.php
*@author  (admin)
*@date 21-04-2020 01:50:14
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema

HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #133                21-04-2020 01:50:14    admin            Creacion    
 #   

*******************************************************************************************/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Lenguaje=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.Lenguaje.superclass.constructor.call(this,config);
        this.init();
        this.addButton('gen_len',{text:'Generar Archivo JSON',iconCls: 'blist', disabled:false, handler: this.generar_codigo, tooltip: '<b>Generar Archivo JSON</b><br/>Genera el archivo de traducciones para el idioma seleccionado'});
	
        this.load({params:{start:0, limit:this.tam_pag}})
    },
            
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_lenguaje'
            },
            type:'Field',
            form:true 
        },
        {
            config:{
                name: 'codigo',
                fieldLabel: 'codigo',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:8
            },
                type:'TextField',
                filters:{pfiltro:'len.codigo',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
        },
        {
            config:{
                name: 'nombre',
                fieldLabel: 'nombre',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:50
            },
                type:'TextField',
                filters:{pfiltro:'len.nombre',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
        },
        {
            config:{
                name: 'defecto',
                fieldLabel: 'Defecto',
                allowBlank: false,
                anchor: '40%',
                gwidth: 50,
                maxLength:2,
                emptyText:'si/no...',                   
                   typeAhead: true,
                   triggerAction: 'all',
                   lazyRender:true,
                   mode: 'local',
                   valueField: 'defecto',  
                   store:['si','no']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{    
                        type: 'list',
                        pfiltro:'len.defecto',
                        options: ['si','no'],    
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
                filters:{pfiltro:'len.estado_reg',type:'string'},
                id_grupo:1,
                grid:true,
                form:false
        },
        {
            config:{
                name: 'id_usuario_ai',
                fieldLabel: '',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:4
            },
                type:'Field',
                filters:{pfiltro:'len.id_usuario_ai',type:'numeric'},
                id_grupo:1,
                grid:false,
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
                filters:{pfiltro:'len.fecha_reg',type:'date'},
                id_grupo:1,
                grid:true,
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
                filters:{pfiltro:'len.usuario_ai',type:'string'},
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
                type:'Field',
                filters:{pfiltro:'usu1.cuenta',type:'string'},
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
                filters:{pfiltro:'len.fecha_mod',type:'date'},
                id_grupo:1,
                grid:true,
                form:false
        }
    ],
    tam_pag:50,    
    title:'Lenguaje',
    ActSave:'../../sis_parametros/control/Lenguaje/insertarLenguaje',
    ActDel:'../../sis_parametros/control/Lenguaje/eliminarLenguaje',
    ActList:'../../sis_parametros/control/Lenguaje/listarLenguaje',
    id_store:'id_lenguaje',
    fields: [
        {name:'id_lenguaje', type: 'numeric'},
        {name:'codigo', type: 'string'},
        {name:'nombre', type: 'string'},
        {name:'defecto', type: 'string'},
        {name:'estado_reg', type: 'string'},
        {name:'id_usuario_ai', type: 'numeric'},
        {name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
        {name:'usuario_ai', type: 'string'},
        {name:'id_usuario_reg', type: 'numeric'},
        {name:'id_usuario_mod', type: 'numeric'},
        {name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
        {name:'usr_reg', type: 'string'},
        {name:'usr_mod', type: 'string'},
        
    ],
    sortInfo:{
        field: 'id_lenguaje',
        direction: 'ASC'
    },

    generar_codigo: function() { 
        var data=this.sm.getSelected().data;
        Phx.CP.loadingShow();
        Ext.Ajax.request({            
            url :'../../sis_parametros/control/Lenguaje/generarArchivo',
            params: {'id_lenguaje': data.id_lenguaje, codigo_lenguaje:  data.codigo},
            success : this.successExport,
            failure: this.conexionFailure,
            timeout:this.timeout,
            scope:this
        });
			
    },
    successExport:function(resp){
		Phx.CP.loadingHide();
        var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        var nomRep = objRes.ROOT.detalle.archivo_generado;
        if(Phx.CP.config_ini.x==1){  			
        	nomRep = Phx.CP.CRIPT.Encriptar(nomRep);
        }
        window.open('../../../reportes_generados/'+nomRep+'?t='+new Date().toLocaleTimeString())
	},    
    preparaMenu:function(tb){			
        this.getBoton('gen_len').enable(); 
        Phx.vista.Lenguaje.superclass.preparaMenu.call(this,tb)
        return tb
    },
    liberaMenu:function(tb){        
        this.getBoton('gen_len').disable();
        Phx.vista.Lenguaje.superclass.liberaMenu.call(this,tb);
        return tb
    },

    bdel:true,
    bsave:true
})
</script>
        
        