Ext.onReady(function(){
	var bd = Ext.getBody();
	var viewMovRap = new Ext.Viewport({
		layout: 'border',
		items: [/*{
			//region: 'north',
			html:'fass fass'
		},*/{
		    layout: 'hbox',
		    region: 'center',
		    items: [{

		        xtype: 'panel', // TabPanel itself has no title
		        items: {
		            html: 'Uno',
		            height: 500
		        }
		    }, {

		        xtype: 'panel', // TabPanel itself has no title
		        items: [{
		            xtype: 'panel',
		            layout: 'vbox',
		            height: 500,
		            align: 'center',
		            items: [
		            	{ xtype: 'tbspacer', flex: 1},
		            	{ xtype:'button',text:'<i class="fa fa-backward" aria-hidden="true"></i>', width:30},
		            	{ xtype:'button',text:'<i class="fa fa-caret-left" aria-hidden="true"></i>', width:30},
		            	{ xtype:'button',text:'<i class="fa fa-caret-right" aria-hidden="true"></i>', width:30},
		            	{ xtype:'button',text:'<i class="fa fa-forward" aria-hidden="true"></i>', width:30},
		            	{ xtype: 'tbspacer', flex: 1}
		            ]
		        }
		        ]
		    }, {

		        xtype: 'panel', // TabPanel itself has no title
		        items: {
		            html: 'Tres',
		            height: 500
		        }
		    }],
		}],
		renderTo: bd
	});

	/*var form = new Ext.form.FormPanel({
        items: [viewMovRap],
        padding: this.paddingForm,
        bodyStyle: this.bodyStyleForm,
        border: this.borderForm,
        frame: this.frameForm, 
        autoScroll: false,
        autoDestroy: true,
        autoScroll: true,
        region: 'center',
        renderTo: bd
	});*/

});