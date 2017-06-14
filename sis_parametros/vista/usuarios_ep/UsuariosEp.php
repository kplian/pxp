<?php
/**
 *@package pXP
 *@file Usuario.php
 *@author Miguel Alejandro Mamani Villegas
 *@date 06-03-2017
 *@description  Vista para desplegar lista de usuarios
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.UsuariosEp=Ext.extend(Phx.gridInterfaz,{
        constructor:function(config){
            this.maestro=config.maestro;
            Phx.vista.UsuariosEp.superclass.constructor.call(this,config);
            this.init();
        },


        tabEnter:true,
        Atributos:[
            {
                // configuracion del componente
                config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_usuario'

                },
                type:'Field',
                form:true

            },
            {
                config:{
                    name:'id_persona',
                    fieldLabel:'Persona',
                    allowBlank:false,
                    emptyText:'Persona...',
                    store: new Ext.data.JsonStore({

                        url: '../../sis_seguridad/control/Persona/listarPersona',
                        id: 'id_persona',
                        root: 'datos',
                        sortInfo:{
                            field: 'nombre_completo1',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_persona','nombre_completo1','ci'],
                        // turn on remote sorting
                        remoteSort: true,
                        baseParams:{par_filtro:'p.nombre_completo1#p.ci'}
                    }),
                    valueField: 'id_persona',
                    displayField: 'nombre_completo1',
                    gdisplayField:'desc_person',//mapea al store del grid
                    tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre_completo1}</p><p>CI:{ci}</p> </div></tpl>',
                    hiddenName: 'id_persona',
                    forceSelection:true,
                    typeAhead: true,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode:'remote',
                    pageSize:10,
                    queryDelay:1000,
                    width:250,
                    gwidth:280,
                    minChars:2,
                    turl:'../../../sis_seguridad/vista/persona/Persona.php',
                    ttitle:'Personas',
                    // tconfig:{width:1800,height:500},
                    tdata:{},
                    tcls:'persona',
                    pid:this.idContenedor,

                    renderer:function (value, p, record){return String.format('{0}', record.data['desc_person']);}
                },
                type:'TrigguerCombo',
                bottom_filter:true,
                id_grupo:0,
                filters:{
                    pfiltro:'nombre_completo1',
                    type:'string'
                },

                grid:true,
                form:true
            },

            {
                config:{
                    name:'id_clasificador',
                    fieldLabel:'Clasificador',
                    allowBlank:true,
                    emptyText:'Clasificador...',
                    store: new Ext.data.JsonStore({

                        url: '../../sis_seguridad/control/Clasificador/listarClasificador',
                        id: 'id_clasificador',
                        root: 'datos',
                        sortInfo:{
                            field: 'prioridad',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_clasificador','codigo','descripcion'],
                        // turn on remote sorting
                        remoteSort: true,
                        baseParams:{par_filtro:'codigo#descripcion'}
                    }),
                    valueField: 'id_clasificador',
                    displayField: 'descripcion',
                    gdisplayField: 'descripcion',
                    hiddenName: 'id_clasificador',
                    forceSelection:true,
                    typeAhead: true,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode:'remote',
                    pageSize:10,
                    queryDelay:1000,
                    width:250,
                    minChars:2,
                    enableMultiSelect:true,

                    renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}

                },
                type:'ComboBox',
                id_grupo:0,
                filters:{   pfiltro:'descripcion',
                    type:'string'
                },
                grid:true,
                form:true
            },

            {
                config:{
                    fieldLabel: "Cuenta",
                    gwidth: 120,
                    name: 'cuenta',
                    allowBlank:false,
                    maxLength:100,
                    minLength:1,
                    anchor:'100%'
                },
                type:'TextField',
                filters:{type:'string'},
                id_grupo:0,
                bottom_filter:true,
                grid:true,
                form:true
            },
            {
                config:{
                    id:'contrasena_'+this.idContenedor,
                    fieldLabel: "Contrasena",
                    name: 'contrasena',
                    allowBlank:false,
                    maxLength:100,
                    minLength:1,
                    anchor:'100%',
                    inputType:'password'


                },
                type:'TextField',
                filters:{type:'string'},
                id_grupo:0,
                grid:false,
                form:true
            },
            {
                config:{
                    fieldLabel: "Confirmar Contrasena",
                    name: 'conf_contrasena',
                    mapeo:'contrasena',
                    allowBlank:false,
                    maxLength:100,
                    minLength:1,
                    anchor:'100%',
                    inputType:'password',
                    initialPassField:'contrasena_'+this.idContenedor,
                    vtype: 'password'
                },
                type:'TextField',
                filters:{type:'string'},
                id_grupo:0,
                grid:false,
                form:true
            },
            {
                // configuracion del componente
                config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'contrasena_old',
                    mapeo:'contrasena'

                },
                type:'Field',
                form:true

            }
            ,

            {
                config:{
                    fieldLabel: "Fecha Caducidad",
                    gwidth: 110,
                    allowBlank:false,
                    name:'fecha_caducidad',
                    renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
                    anchor:'70%',
                    format:'Y-m-d'
                },
                type:'DateField',
                filters:{type:'date'},
                grid:true,
                form:true,
                dateFormat:'m-d-Y'
            },
            {
                config:{
                    name:'estilo',
                    fieldLabel:'Estilo Interfaz',
                    allowBlank:false,
                    emptyText:'Estilo...',

                    typeAhead: true,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode: 'local',
                    //readOnly:true,
                    valueField: 'estilo',
                    // displayField: 'descestilo',
                    store:['xtheme-blue.css','xtheme-gray.css','xtheme-access.css','verdek/css/xtheme-verdek.css','lilamarti/css/xtheme-lilamarti.css','rosaguy/css/xtheme-rosaguy.css']

                },
                type:'ComboBox',
                id_grupo:0,
                filters:{
                    type: 'list',
                    options: ['xtheme-blue.css','xtheme-gray.css','xtheme-access.css','verdek/css/xtheme-verdek.css','lilamarti/css/xtheme-lilamarti.css','rosaguy/css/xtheme-rosaguy.css'],
                },
                grid:true,
                form:true
            },
            {
                config:{
                    name:'autentificacion',
                    fieldLabel:'Autentificación',
                    allowBlank:false,
                    emptyText:'Auten...',

                    typeAhead: true,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode: 'local',
                    //readOnly:true,
                    valueField: 'autentificacion',
                    // displayField: 'descestilo',
                    store:['local','ldap']

                },
                type:'ComboBox',
                id_grupo:0,
                filters:{
                    type: 'list',
                    options: ['local','ldap'],
                },
                grid:true,
                form:true
            },

            {
                config:{
                    fieldLabel: "fecha_reg",
                    gwidth: 110,
                    name:'fecha_reg',
                    renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
                },
                type:'DateField',
                filters:{pfiltro:'USUARI.fecha_reg',type:'date'},
                grid:true,
                form:false
            },

            {
                config:{
                    name:'id_roles',
                    fieldLabel:'Roles',
                    allowBlank:true,
                    emptyText:'Roles...',
                    store: new Ext.data.JsonStore({
                        url: '../../sis_seguridad/control/Rol/listarRol',
                        id: 'id_rol',
                        root: 'datos',
                        sortInfo:{
                            field: 'rol',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_rol','rol','descripcion'],
                        // turn on remote sorting
                        remoteSort: true,
                        baseParams:{par_filtro:'rol'}

                    }),
                    valueField: 'id_rol',
                    displayField: 'rol',
                    forceSelection:true,
                    typeAhead: true,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode:'remote',
                    pageSize:10,
                    queryDelay:1000,
                    width:250,
                    minChars:2,
                    enableMultiSelect:true

                    //renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}

                },
                type:'AwesomeCombo',
                id_grupo:0,
                grid:false,
                form:true
            }],
        title:'Usuario',
        ActList:'../../sis_seguridad/control/Usuario/listarGrupoUsuario',
        id_store:'id_usuario',
        fields: [
            {name:'id_usuario'},
            {name:'id_persona'},
            {name:'id_clasificador'},
            {name:'cuenta', type: 'string'},
            {name:'contrasena', type: 'string'},
            {name:'fecha_caducidad', mapping: 'fecha_caducidad', type: 'date', dateFormat: 'Y-m-d'},
            {name:'fecha_reg', mapping: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d'},
            {name:'desc_person', type: 'string'},
            {name:'descripcion', type: 'string'},
            {name:'estilo'},
            'autentificacion','id_grupo'


        ],
        sortInfo:{
            field: 'desc_person',
            direction: 'ASC'
        },

        bdel:false,// boton para eliminar
        bsave:false,// boton para eliminar
        bedit:false,
        bnew:false,

        loadValoresIniciales:function(){
            Phx.vista.UsuariosEp.superclass.loadValoresIniciales.call(this);
            this.getComponente('id_grupo').setValue(this.maestro.id_grupo);
        },

        onReloadPage:function(m){
            this.maestro=m;
            this.store.baseParams={id_grupo:this.maestro.id_grupo};
            this.load({params:{start:0, limit:50}})
        }





    })
</script>