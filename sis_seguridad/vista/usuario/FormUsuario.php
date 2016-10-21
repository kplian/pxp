<?php
/**
*@package pXP
*@file    SubirArchivo.php
*@author  Rensi ARteaga Copari
*@date    27-03-2014
*@description permites subir archivos a la tabla de documento_sol
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FormUsuario=Ext.extend(Phx.frmInterfaz,{
    ActSave:'../../sis_workflow/control/DocumentoWf/subirArchivoWf',
    layout: 'fit',
    maxCount: 0,
    constructor:function(config){   
        Phx.vista.FormUsuario.superclass.constructor.call(this,config);
        this.init(); 
        this.loadValoresIniciales();
        
    },
   
    Atributos:[{
   			config:{
   				name:'id_usuario',
   				fieldLabel:'Usuario',
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
       	}      
    ],
    title:'Usuario',    
    onSubmit:function(){
       //TODO passar los datos obtenidos del wizard y pasar  el evento save 
       if (this.form.getForm().isValid()) {
           this.fireEvent('beforesave', this, this.getValues());
       }
    },
    getValues:function(){
    	var resp = {id_usuario: this.Cmp.id_usuario.getValue(),
                   data: this.data};
        return resp;   
    }   
})    
</script>
