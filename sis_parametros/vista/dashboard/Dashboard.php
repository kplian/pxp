<?php
/**
 *@package pXP
 *@file gen-Depto.php
 *@author  )
 *@date 24-11-2011 15:52:20
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
//Ext.BLANK_IMAGE_URL = '../../resources/images/default/s.gif';

Ext.example = function(){
    var msgCt;

    function createBox(t, s){
        return ['<div class="msg">',
                '<div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div>',
                '<div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc"><h3>', t, '</h3>', s, '</div></div></div>',
                '<div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div>',
                '</div>'].join('');
    }
    return {
        msg : function(title, format){
            if(!msgCt){
                msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
            }
            msgCt.alignTo(document, 't-t');
            var s = String.format.apply(String, Array.prototype.slice.call(arguments, 1));
            var m = Ext.DomHelper.append(msgCt, {html:createBox(title, s)}, true);
            m.slideIn('t').pause(1).ghost("t", {remove:true});
        },

        init : function(){
            /*
            var t = Ext.get('exttheme');
            if(!t){ // run locally?
                return;
            }
            var theme = Cookies.get('exttheme') || 'aero';
            if(theme){
                t.dom.value = theme;
                Ext.getBody().addClass('x-'+theme);
            }
            t.on('change', function(){
                Cookies.set('exttheme', t.getValue());
                setTimeout(function(){
                    window.location.reload();
                }, 250);
            });*/

            var lb = Ext.get('lib-bar');
            if(lb){
                lb.show();
            }
        }
    };
}();

Ext.example.shortBogusMarkup = '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.';
Ext.example.bogusMarkup = '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br/><br/>Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.</p>';

Ext.onReady(Ext.example.init, Ext.example);

SampleGrid = function(limitColumns){

    function italic(value){
        return '<i>' + value + '</i>';
    }

    function change(val){
        if(val > 0){
            return '<span style="color:green;">' + val + '</span>';
        }else if(val < 0){
            return '<span style="color:red;">' + val + '</span>';
        }
        return val;
    }

    function pctChange(val){
        if(val > 0){
            return '<span style="color:green;">' + val + '%</span>';
        }else if(val < 0){
            return '<span style="color:red;">' + val + '%</span>';
        }
        return val;
    }


    var columns = [
        {id:'company',header: "Company", width: 160, sortable: true, dataIndex: 'company'},
        {header: "Price", width: 75, sortable: true, renderer: Ext.util.Format.usMoney, dataIndex: 'price'},
        {header: "Change", width: 75, sortable: true, renderer: change, dataIndex: 'change'},
        {header: "% Change", width: 75, sortable: true, renderer: pctChange, dataIndex: 'pctChange'},
        {header: "Last Updated", width: 85, sortable: true, renderer: Ext.util.Format.dateRenderer('m/d/Y'), dataIndex: 'lastChange'}
    ];

    // allow samples to limit columns
    if(limitColumns){
        var cs = [];
        for(var i = 0, len = limitColumns.length; i < len; i++){
            cs.push(columns[limitColumns[i]]);
        }
        columns = cs;
    }

    SampleGrid.superclass.constructor.call(this, {
        store: new Ext.data.Store({
            reader: new Ext.data.ArrayReader({}, [
                   {name: 'company'},
                   {name: 'price', type: 'float'},
                   {name: 'change', type: 'float'},
                   {name: 'pctChange', type: 'float'},
                   {name: 'lastChange', type: 'date', dateFormat: 'n/j h:ia'}
              ]),
            data: [
                ['3m Co',71.72,0.02,0.03,'9/1 12:00am'],
                ['Alcoa Inc',29.01,0.42,1.47,'9/1 12:00am'],
                ['Altria Group Inc',83.81,0.28,0.34,'9/1 12:00am'],
                ['American Express Company',52.55,0.01,0.02,'9/1 12:00am'],
                ['American International Group, Inc.',64.13,0.31,0.49,'9/1 12:00am'],
                ['AT&T Inc.',31.61,-0.48,-1.54,'9/1 12:00am'],
                ['Boeing Co.',75.43,0.53,0.71,'9/1 12:00am'],
                ['Caterpillar Inc.',67.27,0.92,1.39,'9/1 12:00am'],
                ['Citigroup, Inc.',49.37,0.02,0.04,'9/1 12:00am'],
                ['E.I. du Pont de Nemours and Company',40.48,0.51,1.28,'9/1 12:00am'],
                ['Exxon Mobil Corp',68.1,-0.43,-0.64,'9/1 12:00am'],
                ['General Electric Company',34.14,-0.08,-0.23,'9/1 12:00am'],
                ['General Motors Corporation',30.27,1.09,3.74,'9/1 12:00am'],
                ['Hewlett-Packard Co.',36.53,-0.03,-0.08,'9/1 12:00am'],
                ['Honeywell Intl Inc',38.77,0.05,0.13,'9/1 12:00am'],
                ['Intel Corporation',19.88,0.31,1.58,'9/1 12:00am'],
                ['International Business Machines',81.41,0.44,0.54,'9/1 12:00am'],
                ['Johnson & Johnson',64.72,0.06,0.09,'9/1 12:00am'],
                ['JP Morgan & Chase & Co',45.73,0.07,0.15,'9/1 12:00am'],
                ['McDonald\'s Corporation',36.76,0.86,2.40,'9/1 12:00am'],
                ['Merck & Co., Inc.',40.96,0.41,1.01,'9/1 12:00am'],
                ['Microsoft Corporation',25.84,0.14,0.54,'9/1 12:00am'],
                ['Pfizer Inc',27.96,0.4,1.45,'9/1 12:00am'],
                ['The Coca-Cola Company',45.07,0.26,0.58,'9/1 12:00am'],
                ['The Home Depot, Inc.',34.64,0.35,1.02,'9/1 12:00am'],
                ['The Procter & Gamble Company',61.91,0.01,0.02,'9/1 12:00am'],
                ['United Technologies Corporation',63.26,0.55,0.88,'9/1 12:00am'],
                ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am'],
                ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am']
            ]
        }),
        columns: columns,
        autoExpandColumn: 'company',
        height:250,
        width:600
    });


}

Ext.extend(SampleGrid, Ext.grid.GridPanel);


// old school cookie functions
var Cookies = {};
Cookies.set = function(name, value){
     var argv = arguments;
     var argc = arguments.length;
     var expires = (argc > 2) ? argv[2] : null;
     var path = (argc > 3) ? argv[3] : '/';
     var domain = (argc > 4) ? argv[4] : null;
     var secure = (argc > 5) ? argv[5] : false;
     document.cookie = name + "=" + escape (value) +
       ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
       ((path == null) ? "" : ("; path=" + path)) +
       ((domain == null) ? "" : ("; domain=" + domain)) +
       ((secure == true) ? "; secure" : "");
};

Cookies.get = function(name){
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	var j = 0;
	while(i < clen){
		j = i + alen;
		if (document.cookie.substring(i, j) == arg)
			return Cookies.getCookieVal(j);
		i = document.cookie.indexOf(" ", i) + 1;
		if(i == 0)
			break;
	}
	return null;
};

Cookies.clear = function(name) {
  if(Cookies.get(name)){
    document.cookie = name + "=" +
    "; expires=Thu, 01-Jan-70 00:00:01 GMT";
  }
};

Cookies.getCookieVal = function(offset){
   var endstr = document.cookie.indexOf(";", offset);
   if(endstr == -1){
       endstr = document.cookie.length;
   }
   return unescape(document.cookie.substring(offset, endstr));
};
	
Ext.define('Phx.vista.Dashboard',{		
	extend: 'Ext.util.Observable',
	name: 'baseInterfaz',	
	
	constructor: function(config) {
		
		Ext.apply(this, arguments[0]);
				
		this.callParent(arguments);
		
	    
	    this.panel = Ext.getCmp(this.idContenedor);
	    console.log('this.panel',this.panel);
	    
	    // create some portlet tools using built in Ext tool ids
	    var tools = [{
	        id:'gear',
	        handler: function(){
	            Ext.Msg.alert('Message', 'The Settings tool was clicked.');
	        }
	    },{
	        id:'close',
	        handler: function(e, target, panel){
	            panel.ownerCt.remove(panel, true);
	        }
	    }];
		  
	   
	    this.Border = new Ext.Container({
	        layout:'border',
	        items:[{
	            region:'west',
	            title:'West',
	            split:true,
	            width: 200,
	            minSize: 175,
	            maxSize: 400,
	            collapsible: true,
	            margins:'35 0 5 5',
	            cmargins:'35 5 5 5',
	            layout:'accordion',
	            layoutConfig:{
	                animate:true
	            },
	            items: [{
	                title:'Navigation',
	                autoScroll:true,
	                border:false,
	                iconCls:'nav'
	            },{
	                title:'Settings',
	                border:false,
	                autoScroll:true,
	                iconCls:'settings'
	            }]
	        },{
	            xtype:'portal',
	            region:'center',
	            margins:'35 5 5 0',
	            items:[{
		                columnWidth:.33,
		                style:'padding:10px 0 10px 10px',
		                items:[{
		                    title: 'Grid in a Portlet',
		                    layout:'fit',
		                    tools: tools,
		                    items: new SampleGrid([0, 2, 3])
		                },{
		                    title: 'Another Panel 1',
		                    tools: tools,
		                    html: Ext.example.shortBogusMarkup
		                }]
		            },{
		                columnWidth:.33,
		                style:'padding:10px 0 10px 10px',
		                items:[{
		                    title: 'Grid in a Portlet',
		                    layout:'fit',
		                    tools: tools,
		                    items: new SampleGrid([0, 2, 3])
		                },{
		                    title: 'Another Panel 1',
		                    tools: tools,
		                    html: Ext.example.shortBogusMarkup
		                }]
		            },{
		                columnWidth:.33,
		                style:'padding:10px 0 10px 10px',
		                items:[]
		            }]
	        }]
	    });
	    
	    
	    this.panel.add(this.Border);
	    this.panel.doLayout();
	    this.addEvents('init');
	    
	

	
	}
	
	
	
});

</script>