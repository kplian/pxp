<?php
/**
 *@package pXP
 *@file UsuarioRol.php
 *@author KPLIAN (admin)
 *@date 14-02-2011
 *@description  Vista para asociar roles a usuarios
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

    Phx.vista.rol_usuario=function(config){

        var ds_rol =new Ext.data.JsonStore({

            url: '../../sis_seguridad/control/Usuario/listarUsuario',
            id: 'id_usuario',
            root: 'datos',
            sortInfo:{
                field: 'usuario',
                direction: 'ASC'
            },
            totalProperty: 'total',
            fields: ['id_usuario','usuario'],
            // turn on remote sorting
            remoteSort: true,
            baseParams:{par_filtro:'usuario'}

        });


        function render_id_usuario(value, p, record){return String.format('{0}', record.data['usuario']);}
        var FormatoVista=function (value,p,record){return value?value.dateFormat('d/m/Y'):''}

        this.Atributos=[
            {
                //configuraci�n del componente
                config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_usuario_rol'

                },
                type:'Field',
                form:true

            },{
                //configuraci�n del componente
                config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_rol'

                },
                type:'Field',
                form:true

            },{
                config:{
                    name:'id_usuario',
                    fieldLabel:'Usuario',
                    allowBlank:false,
                    emptyText:'Usuario...',
                    store:ds_rol,
                    valueField: 'id_usuario',
                    displayField: 'usuario',
                    hiddenName: 'id_usuario',
                    forceSelection:true,
                    typeAhead: true,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode:'remote',
                    pageSize:50,
                    queryDelay:500,
                    width:220,
                    gwidth:220,
                    //minListWidth:'200',
                    renderer:render_id_usuario
                },
                type:'ComboBox',
                id_grupo:0,
                filters:{	pfiltro:'usuario',
                    type:'string'
                },
                grid:true,
                //bottom_filter:true,
                form:true
            },

            {
                config:{
                    fieldLabel: "fecha_reg",
                    gwidth: 110,
                    name:'fecha_reg',
                    renderer:FormatoVista
                },
                type:'DateField',
                filters:{type:'date'},
                grid:true,
                form:false
            }
        ];

        Phx.vista.usuario_rol.superclass.constructor.call(this,config);
        this.init();

        this.grid.getTopToolbar().disable();
        this.grid.getBottomToolbar().disable();



    }

    Ext.extend(Phx.vista.rol_usuario,Phx.gridInterfaz,{
        tabEnter:true,
        title:'Usuario',
        ActSave:'../../sis_seguridad/control/UsuarioRol/guardarUsuarioRol',
        ActDel:'../../sis_seguridad/control/UsuarioRol/eliminarUsuarioRol',
        ActList:'../../sis_seguridad/control/UsuarioRol/listarUsuarioRol',
        ActList:'../../sis_seguridad/control/UsuarioRol/listarRolUsuario',
        id_store:'id_usuario_rol',
        fields: [
            'id_usuario_rol','id_usuario',
            'usuario',
            {name:'fecha_reg',type: 'date', dateFormat: 'Y-m-d'},
            'nombre'],
        sortInfo:{
            field: 'usuario',
            direction: 'ASC'
        },
        bdel:true,//boton para eliminar
        bsave:false,//boton para eliminar
        bedit:false,//boton para editar


        loadValoresIniciales:function(){
            Phx.vista.rol_usuario.superclass.loadValoresIniciales.call(this);
            this.getComponente('id_rol').setValue(this.maestro.id_rol);
        },

        onReloadPage:function(m){
            this.maestro=m;
            this.store.baseParams={id_rol:this.maestro.id_rol};
            this.load({params:{start:0, limit:50}})

        },
        reload:function(p){
            Phx.CP.getPagina(this.idContenedorPadre).reload()
        }


    })
</script>