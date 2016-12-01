<?php
/**
 *@package pXP
 *@file ConceptoIngasGestion.php
 *@author  Gonzalo Sarmiento
 *@date 01-12-2016
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.ConceptoIngasGestion=Ext.extend(Phx.gridInterfaz,{

            constructor:function(config){
                this.maestro=config.maestro;
                //llama al constructor de la clase padre
                this.initButtons = [this.cmbGestion];
                Phx.vista.ConceptoIngasGestion.superclass.constructor.call(this,config);
                this.init();
                //this.load({params:{start:0, limit:50}});
                /*
                this.cmbDepto.on('clearcmb', function() {
                    this.DisableSelect();
                    this.store.removeAll();
                }, this);

                this.cmbDepto.on('valid', function() {
                    if (this.cmbGestion.validate()) {
                        this.capturaFiltros();
                    }
                },*/
                this.cmbGestion.on('select', function(){
                    if( this.validarFiltros() ){
                        this.capturaFiltros();
                    }
                },this);

            },

            Atributos:[
                {
                    //configuracion del componente
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_concepto_ingas'
                    },
                    type:'Field',
                    grid:false,
                    form:false
                },
                {
                    config:{
                        name: 'desc_ingas',
                        fieldLabel: 'Descripcion',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 200,
                        maxLength:500
                    },
                    type:'TextArea',
                    filters:{pfiltro:'cg.desc_ingas',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true,
                    bottom_filter : true
                },
                {
                    config:{
                        name: 'codigo',
                        fieldLabel: 'Codigo Partida',
                        qtip: 'Código de partida',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:100
                    },
                    type:'TextField',
                    filters:{pfiltro:'par.codigo',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true,
                    bottom_filter : true
                },
                {
                    config:{
                        name: 'nombre_partida',
                        fieldLabel: 'Nombre Partida',
                        qtip: 'Nombre de partida',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:100
                    },
                    type:'TextField',
                    filters:{pfiltro:'par.nombre_partida',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true,
                    bottom_filter : true
                },
                {
                    config:{
                        name: 'descripcion',
                        fieldLabel: 'Descripcion Partida',
                        qtip: 'Descripcion partida',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:100
                    },
                    type:'TextField',
                    filters:{pfiltro:'par.descripcion',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true,
                    bottom_filter : true
                },
                {
                    config:{
                        name:'movimiento',
                        fieldLabel:'Movimiento',
                        allowBlank:false,
                        emptyText:'Tipo...',
                        typeAhead: true,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode: 'local',
                        gwidth: 100,
                        store:['recurso','gasto']
                    },
                    type:'ComboBox',
                    id_grupo:0,
                    filters:{
                        type: 'list',
                        pfiltro:'cg.movimiento',
                        options: ['recurso','gasto'],
                    },
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'tipo_partida',
                        fieldLabel: 'Tipo Partida',
                        qtip: 'Tipo de partida',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:100
                    },
                    type:'TextField',
                    filters:{pfiltro:'par.sw_movimiento',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true,
                    bottom_filter : true
                },
                {
                    config:{
                        name:'tipo',
                        fieldLabel:'Tipo',
                        allowBlank:false,
                        emptyText:'Tipo...',
                        typeAhead: true,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode: 'local',
                        valueField: 'estilo',
                        gwidth: 100,
                        store:['Bien','Servicio']
                    },
                    type:'ComboBox',
                    id_grupo:0,
                    filters:{
                        type: 'list',
                        pfiltro:'cg.tipo',
                        options: ['Bien','Servicio'],
                    },
                    grid:true,
                    form:true
                },
                {
                    config: {
                        name: 'activo_fijo',
                        fieldLabel: 'Activo Fijo?',
                        anchor: '100%',
                        tinit: false,
                        allowBlank: false,
                        origen: 'CATALOGO',
                        gdisplayField: 'activo_fijo',
                        gwidth: 100,
                        baseParams:{
                            cod_subsistema:'PARAM',
                            catalogo_tipo:'tgral__bandera_min'
                        },
                        renderer:function (value, p, record){return String.format('{0}', record.data['activo_fijo']);}
                    },
                    type: 'ComboRec',
                    id_grupo: 0,
                    filters:{pfiltro:'cg.activo_fijo',type:'string'},
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'almacenable',
                        fieldLabel: 'Almacenable?',
                        anchor: '100%',
                        tinit: false,
                        allowBlank: false,
                        origen: 'CATALOGO',
                        gdisplayField: 'almacenable',
                        gwidth: 100,
                        baseParams:{
                            cod_subsistema:'PARAM',
                            catalogo_tipo:'tgral__bandera_min'
                        },
                        renderer:function (value, p, record){return String.format('{0}', record.data['almacenable']);}
                    },
                    type: 'ComboRec',
                    id_grupo: 0,
                    filters:{pfiltro:'cg.almacenable',type:'string'},
                    grid: true,
                    form: true
                },{
                    config:{
                        name: 'exige_ot',
                        fieldLabel: 'Exige Ot',
                        qtip: 'Exige Ot',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:100
                    },
                    type:'TextField',
                    filters:{pfiltro:'cg.requiere_ot',type:'string'},
                    id_grupo:1,
                    grid:true,
                    form:true,
                    bottom_filter : true
                },
                {
                    config:{
                        name: 'sistemas',
                        fieldLabel: 'Autorizaciones',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 200,
                        maxLength:500
                    },
                    type:'TextArea',
                    id_grupo:1,
                    grid:true,
                    form:false
                }
            ],

            title:'Conceptos',
            ActList:'../../sis_parametros/control/ConceptoIngas/listarConceptoIngasPartidaGestion',
            id_store:'id_concepto_ingas',
            fields: [
                {name:'id_concepto_ingas', type: 'numeric'},
                {name:'desc_ingas', type: 'string'},
                {name:'codigo', type: 'string'},
                {name:'nombre_partida', type: 'string'},
                {name:'descripcion', type: 'string'},
                {name:'movimiento', type: 'string'},
                {name:'tipo_partida', type: 'string'},
                {name:'tipo', type: 'string'},
                {name:'activo_fijo', type: 'string'},
                {name:'almacenable', type: 'string'},
                'exige_ot','sistemas'

            ],
            sortInfo:{
                field: 'cg.id_concepto_ingas',
                direction: 'ASC'
            },
            bdel:false,
            bsave:false,
            bnew:false,
            bedit:false,

            cmbGestion: new Ext.form.ComboBox({
                fieldLabel: 'Gestion',
                grupo:[0,1,2],
                allowBlank: false,
                blankText:'... ?',
                emptyText:'Gestion...',
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

            capturaFiltros : function(combo, record, index) {
                //this.desbloquearOrdenamientoGrid();
                this.store.baseParams.id_gestion = this.cmbGestion.getValue();
                this.load();
            },

            validarFiltros : function() {
                if (this.cmbGestion.validate() ) {
                    return true;
                } else {
                    return false;
                }
            },
            onButtonAct : function() {
                if (!this.validarFiltros()) {
                    alert('Especifique los filtros antes')
                }
                else{
                    this.capturaFiltros();
                }
            },

            preparaMenu:function(n){
                var data = this.getSelectedData();
                var tb =this.tbar;

                Phx.vista.ConceptoIngasGestion.superclass.preparaMenu.call(this,n);
                return tb
            }

        }
    )
</script>