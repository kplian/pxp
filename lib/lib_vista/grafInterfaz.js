Ext.namespace('Phx', 'Phx.vista');

Ext.chart.Chart.CHART_URL = '../../../lib/ext3/resources/charts.swf';

Phx.grafInterfaz = Ext.extend(Phx.baseInterfaz, {
	
	constructor: function(config){
		Phx.grafInterfaz.superclass.constructor.call(this,config);
		//inicia formulario con todos sus componentes
    	//si es tipo grilla editable tabien los inicia
    	this.definirComponentes();
    	//definir formulario tipo venatana
    	this.definirFormularioVentana();
		//definicion de la barra de meno
		this.defineMenu();
		
		this.graf = new Ext.Panel({
		        //title: 'ExtJS.com Visits Trend, 2007/2008 (No styling)',
				tbar: this.tbar,
				 width:500,
		        height:300,
		        region: 'center',
		        layout:'fit',
		        items: {
		            xtype: 'linechart',
		            store: new Ext.data.JsonStore({
		        fields:['name', 'visits', 'views'],
		        data: [
		            {name:'Jul 07', visits: 245000, views: 3000000},
		            {name:'Aug 07', visits: 240000, views: 3500000},
		            {name:'Sep 07', visits: 355000, views: 4000000},
		            {name:'Oct 07', visits: 375000, views: 4200000},
		            {name:'Nov 07', visits: 490000, views: 4500000},
		            {name:'Dec 07', visits: 495000, views: 5800000},
		            {name:'Jan 08', visits: 520000, views: 6000000},
		            {name:'Feb 08', visits: 620000, views: 7500000}
		        	]
		    	}),
		            xField: 'name',
		            yField: 'visits',
		           
					listeners: {
						itemclick: function(o){
							var rec = store.getAt(o.index);
							Ext.example.msg('Item Selected', 'You chose {0}.', rec.get('name'));
						}
					}
		        }
    });
		
		// extra extra simple
    	/*this.graf= new Ext.chart.LineChart({
        //title: 'ExtJS.com Visits Trend, 2007/2008 (No styling)',
        region: 'center',
        //renderTo: 'container',
        /*width:500,
        height:300,*/
		/*tbar: this.tbar,
        //layout:'fit',
        //store: this.store,
        store: new Ext.data.JsonStore({
        fields:['name', 'visits', 'views'],
        data: [
            {name:'Jul 07', visits: 245000, views: 3000000},
            {name:'Aug 07', visits: 240000, views: 3500000},
            {name:'Sep 07', visits: 355000, views: 4000000},
            {name:'Oct 07', visits: 375000, views: 4200000},
            {name:'Nov 07', visits: 490000, views: 4500000},
            {name:'Dec 07', visits: 495000, views: 5800000},
            {name:'Jan 08', visits: 520000, views: 6000000},
            {name:'Feb 08', visits: 620000, views: 7500000}
        	]
    	}),
        xField: 'name',
        yField: 'visits'
        
    });*/
    /*this.tbar.add('-', {
        	icon: 'lib/imagenes/arrow_rotate_clockwise.png', // icons can also be specified inline
        	cls: 'x-btn-icon',
        	tooltip: '<b>Quick Tips</b><br/>Icon only button with tooltip',
		listeners: {
				itemclick: function(o){
					var rec = store.getAt(o.index);
					Ext.example.msg('Item Selected', 'You chose {0}.', rec.get('name'));
				}
		}
    	     }, '-'
	);*/
	/*this.tbar.addField(this.fini);
	this.tbar.addField(this.ffin);
	this.tbar.addField(this.cmbVar);*/
	
	this.regiones= new Array();
		//ubica el grid en la region central
		this.regiones.push(this.graf);
		/*arma los panles de ventanas hijo*/
		this.definirRegiones();
		
		this.store=new Ext.data.JsonStore({
			// load using script tags for cross domain, if the data in on the
			// same domain as
			// this page, an HttpProxy would be better
			url: this.ActList,
			id: this.id_store,
			root: 'datos',
			sortInfo:this.sortInfo,
			totalProperty: 'total',
			fields:this.fields,
			// turn on remote sorting
			remoteSort: true
		});
		
		this.store.on('loadexception',this.conexionFailure);
		
	},
	load:function(p){
		var x={params:{start:0,limit:this.tam_pag}};
		var SelMod = this.sm;
		Ext.apply(x,p);
		this.store.load(x);
	}
	
	/*store: new Ext.data.JsonStore({
        fields:['name', 'visits', 'views'],
        data: [
            {name:'Jul 07', visits: 245000, views: 3000000},
            {name:'Aug 07', visits: 240000, views: 3500000},
            {name:'Sep 07', visits: 355000, views: 4000000},
            {name:'Oct 07', visits: 375000, views: 4200000},
            {name:'Nov 07', visits: 490000, views: 4500000},
            {name:'Dec 07', visits: 495000, views: 5800000},
            {name:'Jan 08', visits: 520000, views: 6000000},
            {name:'Feb 08', visits: 620000, views: 7500000}
        ]
    }),*/
    /*fini: new Ext.form.DateField({
		name: 'fini',
		label: 'Fecha Inicio',
		emptyText:'Fecha Inicio'
    }),
    ffin: new Ext.form.DateField({
		name: 'ffin',
		label: 'Fecha Final',
		emptyText:'Fecha Final'
    }),
    cmbVar: new Ext.form.ComboBox({
		name: 'variable',
		label: 'Variable',
		emptyText:'Escoja una variable...'
    })*/
	
	
	
})