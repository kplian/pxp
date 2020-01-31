<?php
/**
 *@package sis_asistencia
 *@file    FormReporteIssues.php
 *@author  APS
 *@date    25/11/2019
 *@description Reporte
 * HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.FormReporteIssues = Ext.extend(Phx.frmInterfaz, {
        Atributos : [
            {
                config: {
                    name: 'id_subsistema',
                    fieldLabel: 'Repositorio',
                    allowBlank: false,
                    emptyText: 'Elija una opción...',
                    store: new Ext.data.JsonStore({
                        url: '../../sis_seguridad/control/Reporte/listarRepo',
                        id: 'id_subsistema',
                        root: 'datos',
                        sortInfo: {
                            field: 'nombre',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_subsistema','nombre','organizacion_git'],
                        remoteSort: true,
                        baseParams: {par_filtro: 'nombre',_adicionar :'si'}
                    }),
                    valueField: 'id_subsistema',
                    displayField: 'nombre',
                    gdisplayField: 'organizacion_git',
                    forceSelection: true,
                    typeAhead: false,
                    triggerAction: 'all',
                    lazyRender: true,
                    mode: 'remote',
                    pageSize: 15,
                    queryDelay: 1000,
                    width : 300,
                    gwidth: 150,
                    minChars: 2
                },
                type: 'ComboBox',
                form: true
            },
            {
                config: {
                    name: 'id_branches',
                    fieldLabel: 'Branch',
                    allowBlank: true,
                    emptyText: 'Elija una opción...',
                    store: new Ext.data.JsonStore({
                        url: '../../sis_seguridad/control/Reporte/listarBranch',
                        id: 'id_branches',
                        root: 'datos',
                        sortInfo: {
                            field: 'name',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_branches','id_subsistema','name'],
                        remoteSort: true,
                        baseParams: {par_filtro: 'name'}
                    }),
                    valueField: 'name',
                    displayField: 'name',
                    gdisplayField: 'name',
                    forceSelection: true,
                    typeAhead: false,
                    triggerAction: 'all',
                    lazyRender: true,
                    mode: 'remote',
                    pageSize: 15,
                    queryDelay: 1000,
                    width : 300,
                    gwidth: 150,
                    minChars: 2
                },
                type: 'ComboBox',
                form: true
            },
            {
                config:{
                    name: 'estado',
                    fieldLabel: 'Estados',
                    allowBlank: true,
                    width : 100,
                    typeAhead: true,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode: 'local',
                    store:['all','open','closed']
                },
                type:'ComboBox',
                valorInicial: 'all',
                form: true
            },
            {
                config: {
                    name: 'id_programador',
                    fieldLabel: 'Programador',
                    allowBlank: true,
                    emptyText: 'Elija una opción...',
                    store: new Ext.data.JsonStore({
                        url: '../../sis_seguridad/control/Programador/listarProgramador',
                        id: 'id_programador',
                        root: 'datos',
                        sortInfo: {
                            field: 'nombre_completo',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_programador','nombre_completo','alias_codigo_1'],
                        remoteSort: true,
                        baseParams: {par_filtro: 'nombre_completo'}
                    }),
                    valueField: 'id_programador',
                    displayField: 'nombre_completo',
                    gdisplayField: 'nombre_completo',
                    forceSelection: true,
                    typeAhead: false,
                    triggerAction: 'all',
                    lazyRender: true,
                    mode: 'remote',
                    pageSize: 500,
                    queryDelay: 1000,
                    width: 300,
                    gwidth:200,
                    minChars: 2,
                    enableMultiSelect: true
                },
                type: 'AwesomeCombo',
                form: true
            },
            {
                config : {
                    name : 'fecha_ini',
                    fieldLabel : 'Fecha Desde',
                    allowBlank : true,
                    format : 'd/m/Y',
                    width : 300
                },
                type : 'DateField',
                form : true
            },
            {
                config : {
                    name : 'fecha_fin',
                    fieldLabel: 'Fecha Hasta',
                    allowBlank: true,
                    format: 'd/m/Y',
                    width : 300
                },
                type : 'DateField',
                form : true
            }

        ],
        title : 'Generar Reporte',
        ActSave : '../../sis_seguridad/control/Reporte/ReporteIssues',
        topBar : true,
        botones : false,
        labelSubmit : 'Generar',
        tooltipSubmit : '<b>Generar Excel</b>',
        constructor : function(config) {
            Phx.vista.FormReporteIssues.superclass.constructor.call(this, config);
            this.init();
            this.Cmp.id_subsistema.on('select', function(combo, record, index){
                this.Cmp.id_branches.reset();
                this.Cmp.id_branches.baseParams = Ext.apply(this.Cmp.id_branches.store.baseParams, {id_subsistema: record.data.id_subsistema});
                this.Cmp.id_branches.modificado = true;
            },this);
        },
        tipo : 'reporte',
        clsSubmit : 'bprint',
        onApiRest : function (repo) {
            return new Promise(function (resolve, reject) {
                var arrayStore = {Seleccion:[]};
                var request = new XMLHttpRequest();
                request.open('GET', 'https://api.github.com/users/'+repo+'/repos', true);
                request.onload = function() {
                    var data = JSON.parse(this.response);
                    arrayStore.Seleccion.push(['todos','Todos']);
                    if (request.status >= 200 && request.status < 400) {
                        data.forEach(issues => {
                            arrayStore.Seleccion.push([issues.name,issues.name]);
                    });
                        if (arrayStore.Seleccion.length > 0){
                            resolve(arrayStore.Seleccion);
                        }else{
                            reject({statusText: request.statusText});
                        }
                    } else {
                        console.log('error')
                    }
                };
                request.send();
            });
        }
    })
</script>
