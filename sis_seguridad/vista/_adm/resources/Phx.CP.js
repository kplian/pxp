Ext.chart.Chart.CHART_URL = '../../../lib/ext3/resources/charts.swf';
Ext.state.LocalProvider = Ext.extend(Ext.state.Provider, {

    constructor : function(config){
        Ext.state.LocalProvider.superclass.constructor.call(this);
        this.state = this.readLocal();
    },

    // private
    set : function(name, value){
        if(typeof value == "undefined" || value === null){
            this.clear(name);
            return;
        }
        this.setLocal(name, value);
        Ext.state.LocalProvider.superclass.set.call(this, name, value);
    },

    // private
    clear : function(name){
        this.clearLocal(name);
        Ext.state.LocalProvider.superclass.clear.call(this, name);
    },

    // private
    readLocal : function(){
        var status = {},
            name,
            value;

        for (var i = 0; i < localStorage.length; i++){
            value = localStorage.getItem(localStorage.key(i));
            status[localStorage.key(i)] = this.decodeValue(value);
        }
        return status;
    },

    // private
    setLocal : function(name, value){
        localStorage.setItem(name, this.encodeValue(value));
    },

    // private
    clearLocal : function(name){
        localStorage.removeItem(name);
    },
    clearAll: function(){
        localStorage.clear();
    }
});

///////////////////////////////
//		CLASE MENU		  	//
//////////////////////////////
/**
 * @class SamplePackage.SampleClass
 * @extends Ext.Panel This is a sample class <br/> UTF-8 Check: utf-8 <br/>
 *
 * @author Rensi Arteaga Copari
 * @version 0.1
 */
Ext.BLANK_IMAGE_URL = 'resources/s.gif';
Ext.FORMATO_MONETARIO = '0.000,00/i';

Ext.override(Ext.form.Field,
    {	afterRender : Ext.form.Field.prototype.afterRender.createSequence(function()
    {
        var qt = this.qtip;
        if (qt)
        {	Ext.QuickTips.register({
            target:  this,
            title: '',
            text: qt,
            enabled: true,
            showDelay: 20,
            dismissDelay:20000,
            draggable:true
        });
        }
    })
    });

//RCM: 18/11/2011 Vtype personalizado para validación de fechas por rango y de comparación de passwords
Ext.apply(Ext.form.VTypes, {
    daterange : function(val, field) {
        var date = field.parseDate(val);

        if(!date){
            return false;
        }
        if (field.startDateField && (!this.dateRangeMax || (date.getTime() != this.dateRangeMax.getTime()))) {
            var start = Ext.getCmp(field.startDateField);
            start.setMaxValue(date);
            start.validate();
            this.dateRangeMax = date;
        }
        else if (field.endDateField && (!this.dateRangeMin || (date.getTime() != this.dateRangeMin.getTime()))) {
            var end = Ext.getCmp(field.endDateField);
            end.setMinValue(date);
            end.validate();
            this.dateRangeMin = date;
        }
		/*
		 * Always return true since we're only using this vtype to set the
		 * min/max allowed values (these are tested for after the vtype test)
		 */
        return true;
    },

    password : function(val, field) {
        if (field.initialPassField) {
            var pwd = Ext.getCmp(field.initialPassField);
            return (val == pwd.getValue());
        }
        return true;
    },

    passwordText : 'Las contraseñas no son iguales',

    hex: function(val, field){
        var v=/^[0-9A-F]+$/i .test(val);;
        return /^[0-9A-F]+$/i .test(val);;
    },
    hexText:'El valor no está en Hexadecimal',
    hexMask : /[0-9A-F]/i
});
//FIN RCM


// /////////////////////////////////
// DEFINICON DE LA CLASE MENU //
// ////////////////////////////////
Menu=function(config){


    Menu.superclass.constructor.call(this,Ext.apply({},config,{
        region:'west',
        layout: 'accordion',
        varLog:false,

        split:true,
        width: 295,

        maxSize: 500,
        collapsible: true,
        collapseMode:'mini',
        // floatable:true,
        animCollapse:true,
        animate: true,
        lines:false,
        header: true,
        rootVisible:false,
        autoScroll: true,
        useArrows:true,// estilo vista
        // loader:iloader,
        enableDrag:true,
        containerScroll: true,
        loader:new  Ext.tree.TreeLoader({url:'../../sis_seguridad/control/Menu/listarPermisoArb',
            // baseParams :{_tipo:'direc'},
            // preloadChildren:true,

            clearOnLoad:false

        }),
        root:new Ext.tree.AsyncTreeNode({
            text:'Menú de navegación',
            draggable:false,
            expanded:true,
            iconCls:"xnd-icon",
            singleClickExpand :true,
            //children: [{iconCls:"xnd-icon"}],
            id:'id'
        }),
        collapseFirst:false
    }));
};
// la clase menu hereda de TreePanel
Ext.extend(Menu,Ext.tree.TreePanel,{

    selectClass : function(cls){
        if(cls){
            if(this.getNodeById(cls)){
                this.getSelectionModel().select(this.getNodeById(cls))
            }

        }
    },
    initComponent: function(){
        this.hiddenPkgs = [];
        Ext.apply(this, {
            tbar:[ ' ',
                new Ext.form.TextField({
                    width: 200,
                    emptyText:'Buscar...',
                    enableKeyEvents: true,
                    listeners:{
                        render: function(f){
                            this.filter = new Ext.tree.TreeFilter(this, {
                                clearBlank: true,
                                autoClear: true,
                                remove:true
                            });
                        },
                        keydown: {
                            fn: this.filterTree,
                            buffer: 350,
                            scope: this
                        },
                        scope: this
                    }
                }), ' ', ' ',
                {
                    iconCls: 'icon-expand-all',
                    tooltip: 'Expand All',
                    handler: function(){ this.root.expand(true); },
                    scope: this
                }, '-', {
                    iconCls: 'icon-collapse-all',
                    tooltip: 'Collapse All',
                    handler: function(){ this.root.collapse(true); },
                    scope: this
                }]
        })
        Menu.superclass.initComponent.call(this);
    },
    clearFiltered:function(){
        Ext.each(this.selectedNodes, function(n){
            if(n&&n.ui){
                n.setCls('')
            }
        });
        selectedNodes=new Array();

    },
    selectedNodes:new Array(),

    filterTree: function(t, e){
        var text = t.getValue();
        this.clearFiltered();
        var me = this;

        Ext.each(this.hiddenPkgs, function(n){
            if(n&&n.ui){
                n.ui.show();
            }
        });
        if(!text){
            this.filter.clear();

            return;
        }
        //this.expandAll();

        var re = new RegExp('^' + Ext.escapeRe(text), 'i');
        this.filter.filterBy(function(n){
            var resp =  re.test(n.text)|| re.test(n.attributes.descripcion);
            if(resp){

                n.setCls('light-node');
                me.selectedNodes.push(n);
            }

            //return  !n.attributes.leaf || resp;
            return   resp;

        });

        // hide empty packages that weren't filtered
        this.hiddenPkgs = [];

		/*this.root.cascade(function(n){
		 if(!n.attributes.leaf && n.ui.ctNode.offsetHeight < 3){
		 n.ui.hide();
		 me.hiddenPkgs.push(n);
		 }
		 });*/
    },
    tools:[{
        id:'refresh',
        qtip: 'Actualizar Menú',
        // hidden:true,
        handler: function(event, toolEl, panel){
            // refresh logic

            panel.getRootNode().reload()

        }
    },
        {
            id:'help',
            qtip: 'Get Help',
            handler: function(event, toolEl, panel){
                // whatever
            }
        }]

});


// //////////////////////////////////////////////////
// DEFINICON DE LA CLASE CONTENEDOR PRINCIPAL //
// /////////////////////////////////////////////////

MainPanel = function(config){
    MainPanel.superclass.constructor.call(this, Ext.apply({},config,{

        region:'center',
        // margins:'0 5 5 0',
        resizeTabs: false,
        //minTabWidth: 135,
        //tabWidth: 135,
        plugins: new Ext.ux.TabCloseMenu(),
        enableTabScroll: true,
        //activeTab: 0,


    }));


};

Ext.extend(MainPanel, Ext.TabPanel,{

    loadClass : function(href, cls, title,icono,ruta,clase,params){

        var objConfig = {
            'href':href,
            'cls':cls,
            'title':title,
            'icono':icono,
            'ruta':ruta,
            'clase':clase,
            'params':params,
            'vaMyCls':[]
        };

        objConfig.vaMyCls.push(clase);

        //jrr si es uan vista autogenerada el id es diferente
        if (objConfig.params != undefined && objConfig.params.proceso != undefined && objConfig.params.estado != undefined) {
            var id = 'docs-' + objConfig.params.proceso + '_' + objConfig.params.estado;
        } else {
            var id = 'docs-' + cls;
        }
        var tab = this.getComponent(id);
        //si el tab existe toma el foco

        if(tab){
            this.setActiveTab(tab);

        }else{
            var iconCls='icon-folder';
            if(icono){
                Ext.util.CSS.createStyleSheet('.cls-'+cls+'{background: url('+icono+') no-repeat top left ;background-size:25px 25px!important;}');
                iconCls='cls-'+cls;


            }

            var p = this.add(new Ext.Panel({
                id: id,
                layout: 'fit',
                title: title,
                closable: true,
                autoScroll: false,
                autoHeight : false,
                cclass : cls,
                //stateful:true,
                //allowDomMove:false,
                //bufferResize:true,
                iconCls:iconCls,
                listeners:{
                    scope:this,
                    'close':function(){
                        Phx.CP.removeStateGui(clase)
                    }

                },
                autoLoad: {
                    url: href,
                    params:{idContenedor:id,_tipo:'direc', mycls:clase},
                    showLoadIndicator: "Cargando...",
                    arguments:objConfig,
                    callback: this.callbackTab,
                    scope:this,
                    scripts :true}
            }));
            this.setActiveTab(p);
        }
    },
    callbackTab : function (r,a,o) {

        var objConfig = o.argument.options.arguments;
        var me = this;
        var mycls = o.argument.params.mycls;
        ;
        if(Phx.vista[mycls]){
            if(Phx.vista[mycls].requireclase){

                //trae la clase padre
                //en el callback ejecuta la rerencia
                //e instanca la clase hijo
                var wid= Ext.id();
                Ext.DomHelper.append(document.body, {html:'<div id="'+wid+'"></div>'});

                var el = Ext.get(wid); // Get Ext.Element object
                var u = el.getUpdater();

                var inter = Phx.vista[mycls];
                objConfig.vaMyCls.push(inter.requireclase.split(".")[2]);
                o.argument.params.mycls = inter.requireclase.split(".")[2];

                u.update(
                    {url:Phx.vista[mycls].require,
                        params:o.argument.params,
                        arguments:objConfig,
                        scripts :true,
                        showLoadIndicator: "Cargando...2",
                        scope:this,
                        callback: this.callbackTab
                    });

            }
            else {
                //jrr 22/05/2014 se anade parametros
                if (objConfig.params != undefined && objConfig.params != null && objConfig.params != "") {
                    objConfig.params = Ext.util.JSON.decode(Ext.util.Format.trim(objConfig.params));
                }
                //jrr 22/05/2014 para vistas autogeneradas si tiene como parametros el proceso y el estado
                if (objConfig.params != undefined && objConfig.params.proceso != undefined && objConfig.params.estado != undefined) {
                    Phx.CP.crearPaginaDinamica(Ext.apply(objConfig.params,o.argument.params),objConfig);

                } else {
                    if (objConfig.vaMyCls.length > 1) {
                        for (var i = objConfig.vaMyCls.length-1; i >= 1; i--) {
                            var inter = Phx.vista[objConfig.vaMyCls[i-1]];

                            eval('Phx.vista.'+objConfig.vaMyCls[i-1]+'= Ext.extend(Phx.vista.'+objConfig.vaMyCls[i]+',inter)')

                        }
                    }


                    o.argument.params.mycls = objConfig.vaMyCls[0];


                    if ( objConfig.params != undefined && objConfig.params != null && objConfig.params != "" ) {
                        Phx.CP.setPagina(new Phx.vista[objConfig.vaMyCls[0]](Ext.apply(objConfig.params,o.argument.params)),objConfig);
                    } else {
                        Phx.CP.setPagina(new Phx.vista[objConfig.vaMyCls[0]](o.argument.params),objConfig);
                    }
                }
            }
        }

    }
});

// ////////////////////////////////////////
// CLASE CP (o Contenedor Principal)     //
// ////////////////////////////////////////
Ext.namespace('Phx','Phx.vista');
Phx.CP=function(){
    var menu,hd,mainPanel,win_login,form_login,sw_auten=false,sw_auten_veri=false,estilo_vista;
    // para el filtro del menu
    var filter,hiddenPkgs=[];
    var contNodo = 0;
    if (typeof window.localStorage != "undefined") {
        this.localProvider = new Ext.state.LocalProvider();
        Ext.state.Manager.setProvider(this.localProvider);
    }


    return{

        evaluateHash:function(action,token_inicio){
            //verificamos la accion
            if(action=='main-tabs'){
                if (token_inicio == '' || token_inicio == 'PXPWELCOME') {
                    this.getMainPanel().loadClass('../../../sis_seguridad/vista/inicio/tabInicial.php','PXPWELCOME', 'Inicio','','../../../sis_seguridad/vista/inicio/tabInicial.php','tabInicial');
                } else {
                    var node = menu.getNodeById(token_inicio);
                    if (node) {
                        node.fireEvent('click', node);
                    } else {
                        //buscar el nodo con una peticion ajax si se encuentra se abre si no se encuentra se lanza una excepcion
                        Ext.Ajax.request({
                            url:'../../sis_seguridad/control/Menu/listarPermisoArb',
                            params:{node:'id', busqueda : 'si', codigo : token_inicio},
                            success : function(response, opts) {
                                var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(response.responseText));
                                if(regreso.length > 1){
                                    var interfaz = regreso[0];
                                    this.getMainPanel().loadClass('../../../' + interfaz.ruta, interfaz.codigo_gui, interfaz.nombre,'','',interfaz.clase_vista,interfaz.json_parametros);

                                } else {
                                    alert('No se encontro la interfaz del token enviado en la URL');
                                }


                            },
                            failure: this.conexionFailure,
                            timeout:this.timeout,
                            scope:this
                        });
                    }
                }
            }
            else{
                //si la accion es procesar una alertar recuperamos el datos
                if(action=='alerta'){
                    Ext.Ajax.request({
                        url:'../../sis_parametros/control/Alarma/getAlarma',
                        params:{'alarma':token_inicio},
                        success : function(response, opts) {
                            var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(response.responseText)).datos;

                            if(regreso.length > 0){
                                var interfaz = regreso[0];
                                var par = Ext.util.JSON.decode(Ext.util.Format.trim(interfaz.parametros))
                                Phx.CP.loadWindows(interfaz.acceso_directo, interfaz.titulo, {
                                    modal : true,
                                    width : '90%',
                                    height : '90%',
                                    auxNoClose: true
                                }, par, this.idContenedor, interfaz.clase)
                            }
                            else{
                                alert('No se encontro el acceso, la alerta fue eliminada')
                            }

                        },
                        failure: this.conexionFailure,
                        timeout:this.timeout,
                        scope:this
                    });
                }
            }
        },

        // funcion que se ejcuta despues de una autentificacion exitosa
        // para dibujar los paneles de menu y mainpanel
        init:function(){

            //ffp iniciamos la conexion del websocket
            Phx.CP.webSocket.iniciarWebSocket();



            Ext.QuickTips.init();
            Ext.History.init();
            Ext.History.on('change', function(token){
                if(token && token != 'null') {
                    var parts = token.split(':'),
                        tabId = 'docs-' + parts[1],
                        action = parts[0],
                        tab = mainPanel.getComponent(tabId);

                    //cerramos todas las ventanas abiertas con loadWindows menos alertar y aplicacion de interinato
                    //comentado por que se cerraban las ventas iniciaales de alertaas , parametros y otros
					/*Ext.WindowMgr.each(function(w){
					 //if(w.is_page){}
					 console.log('CLOSE', w)
					 if(w.auxNoClose===false){
					 w.close();
					 alert('close 1')
					 }
					 else{
					 alert('close 2')
					 }
					 },this);*/

                    if(action=='main-tabs'){
                        //si el tab existe toma el foco
                        if(tab){
                            mainPanel.setActiveTab(tab);
                        }
                        else if (parts[1] == 'PXPWELCOME') {
                            mainPanel.loadClass('../../../sis_seguridad/vista/inicio/tabInicial.php','PXPWELCOME', 'Inicio','','../../../sis_seguridad/vista/inicio/tabInicial.php','tabInicial');
                        }
                        else {
                            var node = menu.getNodeById(parts[1]);
                            if (node) {
                                node.fireEvent('click', node);
                            } else {
                                //buscar el nodo con una peticion ajax si se encuentra se abre si no se encuentra se lanza una excepcion
                                Ext.Ajax.request({
                                    url:'../../sis_seguridad/control/Menu/listarPermisoArb',
                                    params:{node:'id', busqueda : 'si', codigo : parts[1]},
                                    success : function(response, opts) {
                                        var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(response.responseText));
                                        if(regreso.length > 1){
                                            var interfaz = regreso[0];
                                            mainPanel.loadClass('../../../' + interfaz.ruta, interfaz.codigo_gui, interfaz.nombre,'','',interfaz.clase_vista,interfaz.json_parametros);

                                        } else {
                                            alert('No se encontro la interfaz del token enviado en la URL');
                                        }

                                    },
                                    failure: this.conexionFailure,
                                    timeout: this.timeout,
                                    scope: this
                                });
                            }
                        }
                    }
                    else{
                        Phx.CP.evaluateHash(action,parts[1]);
                    }
                }
            });
            // definicion de la instancia de la clase menu
            menu=new Menu({});
            menu.on('beforeload',function(){
                if(contNodo==0){
                    Ext.getBody().mask('Loading...', 'x-mask-loading').dom.style.zIndex = '9999';

                }
                contNodo++;
            },this)

            menu.on('load',function(){
                if(contNodo==1){
                    Ext.getBody().unmask();
                }
                contNodo--;
            },this)


            // manejo de errores
            menu.loader.addListener('loadexception',Phx.CP.conexionFailure);
            // menu contextual
            var ctxMenu = new Ext.menu.Menu({
                id:'copyCtx',

                items: [{
                    id:'expand',
                    handler:expandAll,
                    icon:'../../../lib/imagenes/arrow-down.gif',
                    text:'Expandir todos'
                },{
                    id:'collapse',
                    handler:collapseAll,
                    icon:'../../../lib/imagenes/arrow-up.gif',
                    text:'Colapsar todos'
                },{
                    id:'reload',
                    handler:actualizarNodo,
                    icon:'../../../lib/imagenes/act.png',
                    text:'Actualizar nodo'

                }]
            });
            function actualizarNodo(){
                ctxMenu.hide();
                var n = menu.getSelectionModel().getSelectedNode();
                setTimeout(function(){
                    if(!n.leaf){n.reload()}
                }, 10);
            }

            function collapseAll(){
                var n = menu.getSelectionModel().getSelectedNode();
                ctxMenu.hide();
                setTimeout(function(){
                    n.collapseChildNodes(true)
                }, 10);
            }

            function expandAll(){
                var n = menu.getSelectionModel().getSelectedNode();
                ctxMenu.hide();
                setTimeout(function(){
                    n.expand(true);
                }, 10);
            }

            menu.on('contextmenu', function (node, e){
                node.select();
                ctxMenu.showAt(e.getXY())
            });


            menu.on('click', function(node, e){
                if(node.isLeaf()){
                    if (e != undefined) {
                        e.stopEvent();
                    }
                    var naux=node,icono,ruta='';

                    if(node.text=='Salir'){
                        window.location.href=node.attributes.ruta
                    }
                    else{
                        // sacasmos el nombre y la ruta del subsistema subiendo
                        // a los nodos superiores

                        while(naux.parentNode){
                            if(naux.parentNode.id=='id'){
                                icono=naux.attributes.icon
                            }
                            ruta= '/'+naux.id+ruta;
                            naux=naux.parentNode
                        }

                        mainPanel.loadClass('../../../' + node.attributes.ruta,node.attributes.codigo_gui,node.attributes.nombre,icono,ruta,node.attributes.clase_vista,node.attributes.json_parametros)
                    }
                }
            });

            // definicion de una instacia de la clase MainPanel
            mainPanel = new MainPanel({menuTree:menu});

            //windowManager = new Ext.WindowGroup(),
            mainPanel.on('tabchange', function(tp, tab){
                if(tab){
                    var aux = tab.id.split('-');
                    var token_id = aux[1];
                    if (token_id != 'salir') {
                        Ext.History.add('main-tabs:' + token_id);
                        menu.selectClass(tab.cclass);
                    }
                }
            });


            // declaricion del panel SUR
            // var d_pie = Ext.DomHelper.append(document.body, {tag:
            // 'div',id:'estado'/*,class:"x-layout-panel-hd"*/});
            // pie=new Ext.Panel(d_pie ,"Estado");
            // pie.load({url:'layoutPie.php',scripts:true});


            // Contruye el marco de los paneles,
            // introduce el menu y el mainpanel
            var viewport = new Ext.Viewport({
                id:'Phx.CP',
                layout:'border',
                items:[
                    {
                        region: 'north',
                        border: true,
                        layout:'fit',
                        autoHeight:true,
                        margins: '0 0 0 0',
                        split:false,
                        bbar:[
                            {xtype:'label',
                                width: 500,
                                html:' <a href="http://www.kplian.com" target="_blank"><img src="'+Phx.CP.config_ini.mini_logo+'"  style="margin-left:5px;margin-top:1px;margin-bottom:1px"/> </a>',
                                border: false
                            },
                            '->',
                            {
                                xtype:'label',
                                iconCls:'user_suit',
                                html:'<div id="1rn" align="right"><font >Usuario: </font><font ><b>'+Phx.CP.config_ini.nombre_usuario+'</b></font></div>'
                            },'-',
                            {
                                xtype:'label',
                                html:'<div id="2rn" align="right"><img src="../../../lib/imagenes/NoPerfilImage.jpg" align="center" width="35" height="35"  style="margin-left:5px;margin-top:1px;margin-bottom:1px"/></div>'
                            },
                            {
                                tooltip: 'Deja el estado de la interfaz con los valores por defecto <br>borra los filtros y restaura columnas visibles',
                                text: '<i class="fa fa-cogs"></i>',
                                handler: function() {
                                    localStorage.clear();
                                    location.reload();
                                }
                            },'-',
                            {
                                text: 'Cerrar sesion',
                                icon: '../../../lib/images/exit.png',
                                tooltip:'Cerrar sesion',
                                handler: function() {
                                    window.location = '../../control/auten/cerrar.php';
                                }
                            }

                        ]
                    },
                    menu,
                    mainPanel]
            });

            viewport.doLayout();

            //evalua hash de la url inicial
            var tokenDelimiter = ':',
                action,
                token_inicio = "",
                aux = window.location.hash.substr(1);

            if (aux) {
                var arreglo_aux = aux.split(tokenDelimiter);
                token_inicio = arreglo_aux[1];
                action = arreglo_aux[0];
            }
            else{
                action = 'main-tabs';
                token_inicio = 'PXPWELCOME';
            }

            Phx.CP.evaluateHash(action,token_inicio);
            //Phx.CP.generarAlarma(Phx.CP.config_ini.id_usuario, Phx.CP.config_ini.id_funcionario);


            if(Phx.CP.config_ini.cont_interino*1 > 0){

                this.loadWindows('../../../sis_organigrama/vista/interinato/AplicarInterino.php','Aplicar Interinato',{
                        width:550,
                        height:250,
                        modal:false,
                        auxNoClose: true
                    },{id_usuario:Phx.CP.config_ini.id_usuario},
                    'Phx.CP','AplicarInterino');

            }
            else{
                //si usuario tiene alertas iniciamos la ventana
                if(Phx.CP.config_ini.cont_alertas > 0){

                    this.loadWindows('../../../sis_parametros/vista/alarma/AlarmaFuncionario.php','Alarmas',{
                            width:900,
                            height:400,
                            modal:false,
                            auxNoClose: true
                        },
                        { id_usuario: Phx.CP.config_ini.id_usuario },
                        'Phx.CP','AlarmaFuncionario');


					/*
					 url: donde se encuentra el js de la ventana que se quiere abrir
					 title: titulo de la ventanan que se abrira
					 config: configuracion de la venta
					 params: parametros que se le pasaran al js
					 pid: identificador de la ventana padre
					 cls: nombre de la clase que se va ejecutar
					 */
                }
            }


            Phx.CP.obtenerFotoPersona(Phx.CP.config_ini.id_usuario,
                function(resp){
                    setTimeout(function(){
                        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                        var _im ='../../../lib/imagenes/NoPerfilImage.jpg';
                        if(reg.datos[0].extension){
                            _im ='../../../sis_seguridad/control/foto_persona/'+reg.datos[0].foto;
                        }
                        Ext.Element.get('2rn').update('<img src="'+_im+'" align="center" width="35" height="35"  style="margin-left:5px;margin-top:1px;margin-bottom:1px"/> ');

                    },3000);
                });

        },
        //para capturar variables enviadas por get


        // vector que contiene los parametros de configuracion inicial pasados
        // por el servidor en la autentificacion
        config_ini:new Array(),
        // este metodo contruye la ventana de login
        // se ejecuta al cargar el index
        iniciarLogin:function(x,regreso,z){
            Ext.QuickTips.init();
            Ext.form.Field.prototype.msgTarget = 'side';
            // formulario
            form_login = new Ext.form.FormPanel({
                bodyStyle:'padding:30px 0px 40px 15px;',
                labelAlign:'right',
                url:'../../sis_seguridad/control/Auten/verificarCredenciales',
                defaultType: 'textfield',
                defaults: {width: 100},
                items: [{
                    fieldLabel: 'Usuario',
                    allowBlank:false,
                    name:'usuario',
                    id:'_usu'
                },{
                    fieldLabel: 'Contraseña',
                    name:'contrasena',
                    allowBlank:false,
                    inputType: 'password'
                }],
                bbar: new Ext.ux.StatusBar({
                    id: 'basic-statusbar',
                    defaultText: '',
                    text: 'Ready',
                    iconCls: 'x-status-valid'
                })
            });

            // ventana para el login
            win_login = new Ext.Window({
                title: 'PXP',
                modal:true,
                width:320,
                height:180,
                shadow:true,
                closable:false,
                minWidth:300,
                minHeight:180,
                layout: 'fit',
                items: form_login,
                buttons: [{
                    text:'Entrar',
                    handler:Phx.CP.entrar
                }],
                keys:[{ key:Ext.EventObject.ENTER, handler: Phx.CP.entrar }]
            });

            this.win_login = win_login;


            if(x=='activa'){
                Phx.CP.CRIPT = new Phx.Encriptacion({ encryptionExponent: regreso.e,
                    modulus: regreso.m,
                    permutacion: regreso.p,
                    k: regreso.k });
                Phx.CP.config_ini.x = regreso.x;
                sw_auten_veri = false;


                if(regreso.success){
                    // copia configuracion inicial recuperada
                    Ext.apply(Phx.CP.config_ini,regreso.parametros);
                    //aplica el estilo de vista del usuario
                    Phx.CP.setEstiloVista(Phx.CP.config_ini.estilo_vista);
                    //si s la primera vez inicia el entorno
                    if(!sw_auten){
                        Phx.CP.init();
                        sw_auten = true;
                    }
                    //recuperamos la variable de sesion
                    Phx.CP.session = Ext.util.Cookies.get('PHPSESSID');
                }








            }
            else{
                Phx.CP.getPlublicKey();
            }

            setTimeout(function(){
                Ext.get('loading').remove();
                Ext.get('loading-mask').fadeOut({remove:true});
                if(Ext.get('_usu')){
                    Ext.get('_usu').focus();
                }

            }, 1000);

        },
        // para mostrar ventana de autenticación
        loadLogin:function(){
            Phx.CP.getPlublicKey();

        },
        key_m:"99809143352650341179",
        key_e:'7',
        key_k:'1',
        key_p:'2314',


        getPlublicKey:function(){

            Ext.Ajax.request({
                url:'../../sis_seguridad/control/Auten/getPublicKey',
                params:{_tipo:'inter' },
                success:function(resp){
                    var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                    if(regreso.success==true){
                        // crea la clase de encriptacion
                        Phx.CP.CRIPT=new Phx.Encriptacion({
                            encryptionExponent:regreso.e,
                            modulus:regreso.m,
                            permutacion:regreso.p,
                            k:regreso.k});

                        Phx.CP.config_ini.x=regreso.x;
                        win_login.show();


                    }else{

                        alert("error al optener llave pública")
                    }
                },
                failure:Phx.CP.conexionFailure
            });


        },

        prepararLlavesSession:function(){

            Phx.CP.config_ini.xtmp = Phx.CP.config_ini.x;
            Phx.CP.config_ini.x = 0;
            Ext.Ajax.request({
                url:'../../sis_seguridad/control/Auten/prepararLlavesSession',
                params:{_tipo:'inter',sessionid:Phx.CP.session },
                success:function(resp){
                    var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                    if(regreso.success==true){
                        Phx.CP.config_ini.x = Phx.CP.config_ini.xtmp;
                        Phx.CP.win_login.show();
                    }else{
                        alert("error al optener llave pública")
                    }
                },
                failure:Phx.CP.conexionFailure
            });


        },
        entrar:function(){
            // usuario ya fue autentificaco por lo menos una vez?
            //verifica que nose intente ingresa una segunda vez sin antez haber obtenido una respuesta
            if(!sw_auten_veri){
                sw_auten_veri=true;
                var ajax={
                    success:function(resp){
                        var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                        sw_auten_veri=false;
                        if(regreso.success){
                            // copia configuracion inicial recuperada
                            Ext.apply(Phx.CP.config_ini,regreso);
                            //muestra nombre de usuario y base de datos

                            //aplica el estilo de vista del usuario
                            Phx.CP.setEstiloVista(Phx.CP.config_ini.estilo_vista);
                            win_login.hide();

                            var cookiUser = Ext.util.Cookies.get('usuario');
                            if(cookiUser == Phx.CP.config_ini.nombre_usuario){
                                this.arrayInterfaces = [];
                            }
                            else{
                                Ext.util.Cookies.set('usuario',Phx.CP.config_ini.nombre_usuario);
                            }

                            //recuperamos la variable de sesion
                            Phx.CP.session = Ext.util.Cookies.get('PHPSESSID');
                            //si s la primera vez inicia el entorno
                            if(!sw_auten){
                                Phx.CP.init();
                                sw_auten = true;
                            }
                            form_login.setTitle("LOGIN");
                            form_login.getForm().findField('usuario').disable();
                            form_login.getForm().findField('contrasena').reset();
                            Phx.CP.loadingHide();


                        }
                        else{
                            if(regreso.mensaje){

                                var sb = Ext.getCmp('basic-statusbar');
                                sb.setStatus({
                                    text: regreso.mensaje,
                                    iconCls: 'x-status-error',
                                    clear: true // auto-clear after a set interval
                                });
                            }
                            ajax.failure();
                        }

                    },
                    failure:function(form,action,resp){
                        sw_auten_veri=false;
                        // ocultamos el loading
                        Phx.CP.loadingHide();
                        win_login.setTitle("Error en los Datos");
                        Ext.get('_usu').focus();
                    }
                };


                if(form_login.getForm().isValid()){
                    Phx.CP.loadingShow();
                    Ext.Ajax.defaultHeaders={
                        'Powered-By': 'Pxp'
                    };
                    // Envia crendenciales al servidor
                    console.log(Phx.Encriptacion);
                    Ext.Ajax.request({
                        url:form_login.url,
                        params:{
                            _tipo:'auten',
                            //se quita el md5 de la contraseña, si la encripacion esta activada no se encripta en este paso, si no esta activada se encripta
                            contrasena: Phx.CP.config_ini.x=='1'?form_login.getForm().findField('contrasena').getValue():Phx.CP.CRIPT.Encriptar(form_login.getForm().findField('contrasena').getValue()),
                            usuario:form_login.getForm().findField('usuario').getValue()

                        },
                        method:'POST',
                        success:ajax.success,
                        failure:ajax.failure
                    });
                }
                else{
                    sw_auten_veri=false;
                }
            }
        },
        // manejo de errores
        conexionFailure:function(resp1,resp2,resp3,resp4,resp5){

            Phx.CP.loadingHide();

            resp = resp1;// error conexion

            if(resp3!=null){
                resp = resp3;
            }
            // error conexion en store de combos
            if(resp5!=null){
                resp = resp5;
            }


            var mensaje;
            if(resp.status == 777){
                // usuario no autentificado
                // No existe el archivo requerido
                mensaje="<p><br/> Status: " + resp.statusText +"<br/> Error del Navegador</p>"

                return
            }
            else if(resp.status==401){
                // usuario no autentificado
                Phx.CP.loadLogin();
                return
            }
            else if(resp.status==404){
                // No existe el archivo requerido
                mensaje="<p><br/> Status: " + resp.statusText +"<br/> No se encontro el Action requerido</p>"
            }

            else if(resp.status==406){


                // No aceptable
                var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));

                if(reg.ROOT.detalle.mensaje == 'sesion no iniciada'){

                    //consulta para preparar llave seugn el sid perdido
                    //TODO RAC 15/12/2016 ... por que este if parace no tener sentido
                    //queda comentado
                    //if(Phx.CP.contador == 0){
                    Phx.CP.prepararLlavesSession();
                    Phx.CP.contador = Phx.CP.contador + 1;
                    return;
                    //}

                }

                if(Phx.CP.config_ini.mensaje_tec==1){
                    mensaje="<p><br/> <b>Mensaje:</b> " + reg.ROOT.detalle.mensaje +"<br/><b>Capa:</b> " + reg.ROOT.detalle.capa +"<br/><b>Origen:</b> " + reg.ROOT.detalle.origen +"<br/><b>Procedimiento:</b> " + reg.ROOT.detalle.procedimiento +"<br/><b>Transacción:</b> " + reg.ROOT.detalle.transaccion+"<br/><b>Consulta:</b> " + reg.ROOT.detalle.consulta +"<br/><b>Mensaje Técnico:</b> " + reg.ROOT.detalle.mensaje_tec +"</p>";
                }
                else{
                    mensaje="<p><br/> Mensaje: " + reg.ROOT.detalle.mensaje +"<br/> </p>"
                }
            }

            else if(resp.status==-1){
                // tiempo de espera agotado
                mensaje="<p>HTTP status: " + resp.status +"<br/> Status: " + resp.statusText +"<br/> Tiempo de espera agotado</p>"
            }
            else{
                // repuesta no reconocida
                mensaje = "respuesta indefinida, error en la transmision <br> respuesta obtenida:<br>"+ resp.responseText;
            }

            if(Phx.CP.varLog){

                window.open('../../../lib/lib_vista/log.php?log='+mensaje+'&titulo='+Phx.CP.varLogTitle,'LOG')

            }
            else{

                Ext.Msg.show({
                    title: 'AVISO ... ',
                    icon:Ext.MessageBox.INFO,
                    msg:mensaje,
                    buttons: Ext.Msg.OK,
                    minWidth:500,
                    minHeight:100,
                    modal:true

                });
                Ext.MessageBox.getDialog().getEl().setStyle('z-index','19999');

            }
        },
        contador: 0,
        obtenerFotoPersona:function(id_usu,callback){
            Ext.Ajax.request({
                url:'../../sis_seguridad/control/Persona/obtenerPersonaFoto',
                params:{'id_usuario':id_usu},
                success:callback,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });
        },

        generarAlarma:function(id_usu,id_fun){
            var that = this;
            var myTimer = setInterval(function() {
                Ext.Ajax.request({
                    url:'../../sis_parametros/control/Alarma/listarAlarma',
                    params : {start:0,limit:100,sort:'alarm.fecha_reg',dir:"ASC",id_usuario:id_usu,id_funcionario:id_fun,minutos:1},
                    success:function(resp) {
                        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                        for (var i = 0; i < reg.total;i++) {
                            if (reg.datos[i].titulo_correo != '') {
                                that.notificar(reg.datos[i].titulo,reg.datos[i].titulo_correo);
                            } else {
                                that.notificar('Notificacion ERP',reg.datos[i].titulo);
                            }
                        }
                    },
                    failure: function (resp1,resp2,resp3,resp4,resp5) {
                        clearInterval(myTimer);
                        that.conexionFailure(resp1,resp2,resp3,resp4,resp5);
                        alert('Ha ocurrido un error y las notificaciones automáticas del sistema han sido deshabilitadas, para volver a habilitarlas refresque el navegador.')
                    },

                    timeout:that.timeout,
                    scope:that
                });
            }, 150000);

        },
        notificar : function(titulo,mensaje) {
            // Let's check if the browser supports notifications
            if (!("Notification" in window)) {
                alert("This browser does not support desktop notification");
            }

            // Let's check if the user is okay to get some notification
            else if (Notification.permission === "granted") {
                // If it's okay let's create a notification
                var notification = new Notification(titulo,{icon:Phx.CP.config_ini.icono_notificaciones ,body: mensaje} );
                document.getElementById('notification_sound').play();
                notification.onclick = function(event) {
                    // Show user the screen.
                    window.focus();

                    // Close notification.
                    notification.close();
                }

                notification.onshow = function(event) {
                    setTimeout(function(){
                        notification.close();
                    }, 10800000);
                }

            }

            // Otherwise, we need to ask the user for permission
            // Note, Chrome does not implement the permission static property
            // So we have to check for NOT 'denied' instead of 'default'
            else if (Notification.permission !== 'denied') {
                Notification.requestPermission(function (permission) {

                    // Whatever the user answers, we make sure we store the information
                    if(!('permission' in Notification)) {
                        Notification.permission = permission;
                    }

                    // If the user is okay, let's create a notification
                    if (permission === "granted") {
                        var notification = new Notification(titulo,{icon:Phx.CP.config_ini.favicon ,body: mensaje});
                        document.getElementById('notification_sound').play();
                        notification.onclick = function(event) {
                            // Show user the screen.
                            window.focus();

                            // Close notification.
                            notification.close();
                        }

                        notification.onshow = function(event) {
                            setTimeout(function(){
                                notification.close();
                            }, 10800000);
                        }
                    }
                });
            }

            // At last, if the user already denied any notification, and you
            // want to be respectful there is no need to bother him any more.
        },

        sleep:function (milliseconds) {
            var start = new Date().getTime();
            for (var i = 0; i>-1; i++) {
                if ((new Date().getTime() - start) > milliseconds){
                    break;
                }
            }
        },
        pressChar:function (character,cmpEl){

            // Create the key press event.
            var pressEvent = document.createEvent('KeyboardEvent');
            pressEvent.initKeyEvent("keypress", true, true, window,
                false, false, false, false,
                0, character.charCodeAt(0));
            cmpEl.dispatchEvent(pressEvent); // Press the key.

        },

        keyEvent:function(character,evento){
            var keyboardEvent = document.createEvent("KeyboardEvent");
            var initMethod = typeof keyboardEvent.initKeyboardEvent !== 'undefined' ? "initKeyboardEvent" : "initKeyEvent";


            keyboardEvent[initMethod](
                evento, // event type : keydown, keyup, keypress
                true, // bubbles
                true, // cancelable
                window, // viewArg: should be window
                false, // ctrlKeyArg
                false, // altKeyArg
                false, // shiftKeyArg
                false, // metaKeyArg
                character.charCodeAt(0), // keyCodeArg : unsigned long the virtual key code, else 0
                character.charCodeAt(0)// charCodeArgs : unsigned long the Unicode character associated with the depressed key, else 0
            );

            return keyboardEvent;

        },


        loadMask:new Ext.LoadMask(Ext.getBody(), { msg: "Espere por favor ..." }),

        loadingShow:function(){
            Ext.getBody().mask('Loading...', 'x-mask-loading').dom.style.zIndex = '9999';
        },

        loadingHide:function(){
            Ext.getBody().unmask();
        },

        // Para cambiar el estilo de la vista
        setEstiloVista:function(val){
            Ext.util.CSS.removeStyleSheet('theme');
            Ext.util.CSS.refreshCache();
            //estilo_vista='xtheme-black.css'
            Ext.util.CSS.swapStyleSheet('theme','../../../lib/ext3/resources/css/'+val);
        },
        getMainPanel:function(){
            return mainPanel;
        },
        merge :function(target, src) {
            var array = Array.isArray(src);
            var dst = array && [] || {};
            var that = this;
            if (array) {
                target = target || [];
                dst = dst.concat(target);
                src.forEach(function(e, i) {
                    if (typeof dst[i] === 'undefined') {
                        dst[i] = e;
                    } else if (typeof e === 'object') {
                        dst[i] = that.merge(target[i], e);
                    } else {
                        if (target.indexOf(e) === -1) {
                            dst.push(e);
                        }
                    }
                });
            } else {
                if (target && typeof target === 'object') {
                    Object.keys(target).forEach(function (key) {
                        dst[key] = target[key];
                    })
                }
                Object.keys(src).forEach(function (key) {
                    if (typeof src[key] !== 'object' || !src[key]) {
                        dst[key] = src[key];
                    }
                    else {
                        if (!target[key]) {
                            dst[key] = src[key];
                        } else {
                            dst[key] = that.merge(target[key], src[key]);
                        }
                    }
                });
            }

            return dst;
        },

		/*getWindowManager:function(){
		 return windowManager;
		 },*/


        elementos:new Array(),

        initMode:true,
        setPagina:function(e,objConfig){
            this.elementos.push(e);
            if(objConfig){
                //si el level es 0 guardamos en la cookie
                if(objConfig.clase!='tabInicial'){
                    this.saveStateGui(objConfig)
                }
            }
            return e;
        },
        //jrr crear la pgina dinamicamente
        crearPaginaDinamica:function(params, objConfig){
            var params_to_send = {'objConfig' : objConfig,'params':params};
            //hacer ajax request para obtener datos del proceso en el estado actual
            Ext.Ajax.request({
                url:'../../sis_workflow/control/Tabla/cargarDatosTablaProceso',//cargarDatosTablaProceso
                params:{'tipo_proceso':params.proceso, 'tipo_estado' : params.estado, 'limit' : 100, 'start' : 0},
                success: Phx.CP.successCrearPaginaDinamica,
                arguments : params_to_send,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });


        },

        successCrearPaginaDinamica :function (resp, o ) {

            var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText)).datos;

            var clase_generada = o.arguments.params.proceso + '_' + o.arguments.params.estado;

            o.arguments.params.indice = 0;
            o.arguments.params.clase_generada = clase_generada;
            o.arguments.params.configProceso = objRes;

            Phx.vista[clase_generada] = {};
            if (objRes[0].atributos.vista_scripts_extras != '' &&
                objRes[0].atributos.vista_scripts_extras != undefined &&
                objRes[0].atributos.vista_scripts_extras != null) {
                Ext.apply(Phx.vista[clase_generada], Ext.util.JSON.decode(Ext.util.Format.trim(objRes[0].atributos.vista_scripts_extras)));
            }

            eval('Phx.vista[clase_generada]= Ext.extend(Phx.vista.ProcesoInstancia,Phx.vista[clase_generada])');
            Phx.CP.setPagina(new Phx.vista[clase_generada](o.arguments.params),o.arguments.objConfig);
        },

        getPagina:function(e){
            for (var i=0;i<=this.elementos.length;i++){
                if(this.elementos[i]&&this.elementos[i].idContenedor==e){
                    return this.elementos[i];
                }
            }
        },
        arrayInterfaces:[],
        saveStateGui:function(objConfig){
            if(!(objConfig.cookie)){
                this.arrayInterfaces.push(objConfig)
                Ext.util.Cookies.set('arrayInterfaces',JSON.stringify(this.arrayInterfaces));
            }
        },

        removeStateGui:function(clase){
            var index = this.findArrayInterfaces(clase)
            if(index != -1){
                this.arrayInterfaces.splice(index, 1);
                Ext.util.Cookies.set('arrayInterfaces',JSON.stringify(this.arrayInterfaces));
            }
        },
        findArrayInterfaces:function(clase){
            var i = 0;
            for (var i = 0; i <  this.arrayInterfaces.length ;i++){
                if (this.arrayInterfaces[i].clase == clase){
                    return i;
                }
            }
            return  -1;
        },

		/*getStateGui:function(){
		 temp = Ext.util.Cookies.get('arrayInterfaces')
		 this.arrayInterfaces=JSON.parse(temp)
		 if(!this.arrayInterfaces){
		 this.arrayInterfaces = [];
		 }


		 if(this.arrayInterfaces.length > 0){
		 var ind =  this.arrayInterfaces.length -1
		 var obj = this.arrayInterfaces[ind]
		 Phx.CP.getMainPanel().loadClass(obj.href,obj.cls, obj.title,obj.icono,obj.ruta,obj.clase,true,this.arrayInterfaces,ind);
		 }
		 },*/

        // para destruir paginas
        destroyPage:function(id){
            for(var i=0;i<this.elementos.length;i++){
                if(this.elementos[i].idContenedor==id){
                    Ext.destroyMembers(this.elementos[i]);
                    Ext.destroy(this.elementos[i]);
                    delete this.elementos[i];
                    this.elementos.splice(i,1);
                    break
                }
            }

            //borrar el evento del websocket

            if(Phx.CP.webSocket.habilitado == 'si'){
                Phx.CP.webSocket.eleminarEvento(id);

            }




        },
        _getType:function( inp ) {
            var type = typeof inp, match;
            var key;
            if (type == 'object' && !inp) {
                return 'null';
            }
            if (type == "object") {
                if (!inp.constructor) {
                    return 'object';
                }
                var cons = inp.constructor.toString();
                if (match = cons.match(/(\w+)\(/)) {
                    cons = match[1].toLowerCase();
                }
                var types = ["boolean", "number", "string", "array"];
                for (key in types) {
                    if (cons == types[key]) {
                        type = types[key];
                        break;
                    }
                }
            }
            return type;
        },


		/*RAC 20/01/2012
		 * esta funcion ejecuta la clase cargada en los contenedores
		 */

        callbackWindows:function(r,a,o){

            //si existe la variable mycls  (deherencia )la aplica
            //RAC 3-11-2012: bug al combinar arboles con openwindow, se solapan variables
            var me= this,
                mycls = o.argument.params.mycls?o.argument.params.mycls:o.argument.params.cls;

            if(Phx.vista[mycls].requireclase){

                o.argument.params.mycls = Phx.vista[mycls].requireclase.split(".")[2];
                //trae la clase padre
                //en el callback ejecuta la herencia
                //e instanca la clase hijo
                var owid= Ext.id();
                Ext.DomHelper.append(document.body, {html:'<div id="'+owid+'"></div>'});

                var el = Ext.get(owid), // este div esta quemado en el codigo html
                    u = el.getUpdater(),
                    inter = Phx.vista[mycls];


                o.argument.params.vaMyCls.push(inter.requireclase.split(".")[2]);

                u.update(
                    { url: inter.require,
                        params: o.argument.params,
                        scripts : true,
                        listeners: o.argument.options.listeners	,
                        showLoadIndicator: "Cargando...2",
                        callback: this.callbackWindows,
                        scope:this
                    })
            }
            else{

                // Al retorno de de cargar la ventana
                // ejecuta la clase que llega en el parametro
                // cls

                if (o.argument.params.vaMyCls.length > 1) {
                    for (var i = o.argument.params.vaMyCls.length-1; i >= 1; i--) {

                        var inter = Phx.vista[o.argument.params.vaMyCls[i-1]];

                        eval('Phx.vista.'+o.argument.params.vaMyCls[i-1]+'= Ext.extend(Phx.vista.'+o.argument.params.vaMyCls[i]+',inter)')
                    }
                }

                o.argument.params.mycls = o.argument.params.vaMyCls[0];
                var obj = Phx.CP.setPagina(new Phx.vista[o.argument.params.mycls](o.argument.params));

                //adciona eventos al objeto interface si existen
                if(o.argument.options.listeners){
                    if(obj.esperarEventos === true){
                        obj.setListeners(o.argument.options.listeners);
                    }
                    else{
                        var ev = o.argument.options.listeners;
                        for (var i = 0; i < ev.config.length; i++) {
                            obj.on(ev.config[i].event,ev.config[i].delegate,ev.scope)
                        }
                    }

                }
            }
        },





        // para cargar ventanas hijo
        loadWindows:function(url,title,config,params,pid,mycls,listeners){
			/*
			 * url: donde se encuentra el js de la ventana que se quiere abrir
			 * title: titulo de la ventanan que se abrira
			 * config: configuracion de la venta
			 * params: parametros que se le pasaran al js
			 * pid: identificador de la ventana padre
			 * cls: nombre de la clase que se va ejecutar
			 */

            var sw=false// ,_url=url.split('?');

            // Busca si la ventana ya fue abierta para recarla - comentado temporalmente
			/*
			 * for(var i=0;i<pagHijo.length;i++){ if(pagHijo[i].url==_url[0]){
			 * var paginaHijo=Phx.CP.getPagina(pagHijo[i].idContenedor);
			 * if(!paginaHijo){
			 * paginaHijo=Phx.CP.getPagina(idContenedor).pagina.getPagina(pagHijo[i].idContenedor) }
			 * paginaHijo.pagina.reload(_url[1]); pagHijo[i].ventana.show();
			 * sw=true; idVentana=pagHijo[i].idContenedor; break } }
			 *
			 */
            if(!sw){
                // crea una nueva ventana
                var	Ventana={
                    modal:true,
                    title:title,
                    auxNoClose:config.auxNoClose?true:false,
                    width:'60%',
                    height:'60%',
                    shadow:true,
                    minWidth:300,
                    minHeight:300,
                    layout:'fit',
                    border: false,
                    //parseMargins:'50 50 50 50',
                    minimizable: false,
                    maximizable: true,
                    proxyDrag:true
                };

                Ext.apply(Ventana,config);

                if(this._getType(Ventana.height)== 'string'){
                    Ventana.height=Ext.getBody().getHeight()*(parseInt(Ventana.height.substr(0,Ventana.height.indexOf('%')))/100)
                }


                var wid = Ext.id();
                vaMyCls = [];

                vaMyCls.push(mycls);
                console.log('listeners.......',listeners)
                var Win = new Ext.Window(Ext.apply(Ventana,{
                    id: wid,// manager: this.windows,
                    autoDestroy: true,
                    autoLoad:{ url: url,
                        params:Ext.apply({_tipo:'direc','idContenedor':wid, 'idContenedorPadre': pid, 'mycls':mycls, 'vaMyCls': vaMyCls },params),
                        text: "Cargando...",
                        showLoadIndicator: "Cargando...",
                        scripts :true,
                        listeners: listeners,
                        callback: this.callbackWindows,
                        scope:this
                    }
                }));
                Win.show();
                Win.is_page=true;
                return wid;
            }

        },

        log: function(){
            if( typeof window.console != 'undefined' ){
                console.log.apply(null,arguments);
            }
        },

        /***********************************************
         *  Funciones extra de proposito general
         ***************************************************/

        setValueCombo: function(cmb, id_combo, value_combo){
            if (!cmb.store.getById(id_combo)) {
                var recTem = new Array();
                recTem[cmb.valueField] = id_combo;
                recTem[cmb.displayField] = value_combo;
                cmb.store.add(new Ext.data.Record(recTem, id_combo));
                cmb.store.commitChanges();
            }
            cmb.setValue(id_combo);

        },

        removeArray: function (arr) {
            var what, a = arguments, L = a.length, ax;
            while (L > 1 && arr.length) {
                what = a[--L];
                while ((ax= arr.indexOf(what)) !== -1) {
                    arr.splice(ax, 1);
                }
            }
            return arr;
        },

        /***********************************************
         *  WebSocket por favio figueroa
         ***************************************************/

        //sessionWebSocket conexionwWebSocket guiPXP evento
        webSocket: {
            scopeVistas:[],
            habilitado:'no',
            iniciarWebSocket : function () {


                var hostname = window.location.hostname;
                Phx.CP.webSocket.conn = new WebSocket('ws://'+hostname+':'+Phx.CP.config_ini.puerto_websocket+'?sessionIDPXP='+Ext.util.Cookies.get('PHPSESSID'));
                console.log(Phx.CP.webSocket.conn);
                Phx.CP.webSocket.conn.onopen = function (e) {
                    console.log(e)
                    console.log("Conecion establecida");
                    Phx.CP.webSocket.habilitado = 'si';

                    //una vez establecida la conexion debemos mandar el nombre del usuario, y el id_usuario

                    //crear json
                    var json = JSON.stringify({
                        data: {"id_usuario": Phx.CP.config_ini.id_usuario },
                        tipo: "registrarUsuarioSocket"

                    });
                    Phx.CP.webSocket.conn.send(json);




                };

                Phx.CP.webSocket.conn.onmessage = function (e) {

                    var jsonData = JSON.parse(e.data);

                    //es el mensaje que mostrara a todos los que estan escuchando
                    var mensaje = jsonData.mensaje;

                    //obtenemos el data de la configuracion al lanzar el evento escucharEvento esos datos los tenemos aca
                    var data = jsonData.data;

                   // console.log(mensaje)
                    //console.log(data)


                    if(data.id_contenedor != undefined){
                        var f ='Phx.CP.webSocket.scopeVistas["'+data.id_contenedor+'"].'+data.metodo+'.call(Phx.CP.webSocket.scopeVistas["'+data.id_contenedor+'"],mensaje)';
                        eval(f);
                    }else{
                        var f = 'Phx.CP.webSocket.'+data.metodo+'(mensaje)';
                        eval(f);
                    }





                };

                Phx.CP.webSocket.conn.onerror = function (e,a) {

                    if(Phx.CP.webSocket.habilitado = 'no'){
                        alert('webscket no esta escuchando contáctate con el administrador')
                    }
                };



            },

            //x es el this de la vista es el scope que tendremos
            escucharEvento:function(evento,id_contenedor,metodo,scope){


                console.log(scope)
                this.scopeVistas[id_contenedor] = scope;

                //crear json
                var json = JSON.stringify({
                    data: {"id_usuario": Phx.CP.config_ini.id_usuario,"nombre_usuario":Phx.CP.config_ini.nombre_usuario ,"evento": evento,"id_contenedor":id_contenedor,"metodo":metodo},
                    tipo: "escucharEvento"

                });

                Phx.CP.webSocket.conn.send(json);

                console.log(this.scopeVistas)

            },
            eleminarEvento:function (id_contenedor) {

                var json = JSON.stringify({
                    data: {"id_contenedor":id_contenedor},
                    tipo: "eleminarEvento"

                });

                Phx.CP.webSocket.conn.send(json);
            },
            enviarMensajeUsuario:function(mensaje){

                if(mensaje.tipo_mensaje == "alert"){
                    alert(mensaje.mensaje)
                }else{
                    Phx.CP.notificar(mensaje.titulo,mensaje.mensaje);
                }


            },
            actualizarVistaUsuario:function(mensaje){


                //alert('se actualizara');
                window.location.reload(true);
            },
            cierreSocket:function(mensaje){

                alert(mensaje.mensaje);

            },

        }


    }
}();