var arrayData = ["John", "Mary", "Steve"]

var objectData = [
    {id:1, name:"John"}
    ,{id:2, name:"Mary"}
    ,{id:3, name:"Steve"}
];

Ext.onReady(function() {

    Ext.QuickTips.init();

	/*******************************************************************/
	/**** SIMPLE *******************************************************/
	/*******************************************************************/

	var form1 = new Ext.form.FormPanel({
		width:300
		,autoHeight:true
		,border:false
		,padding:"5"
		,items:[{
			xtype:"combo"
			,anchor:"0"
			,store:arrayData
			,fieldLabel:"ExtJS Combo"
		}, {
			xtype:"awesomecombo"
			,store:arrayData
			,anchor:"0"
			,fieldLabel:"Awesome Combo"
		}]
	}).render("form1");

	/*******************************************************************/
	/**** MULTIDIMENSIONAL ARRAY ***************************************/
	/*******************************************************************/

	var form2 = new Ext.form.FormPanel({
		width:300
		,autoHeight:true
		,border:false
		,padding:"5"
		,items:[{
			xtype:"combo"
			,anchor:"0"
			,store:Ext.exampledata.states
			,fieldLabel:"ExtJS Combo"
			,emptyText:"select a country..."
		}, {
			xtype:"awesomecombo"
			,store:Ext.exampledata.states
			,anchor:"0"
			,emptyText:"select a country..."
			,fieldLabel:"Awesome Combo"
		}]
	}).render("form2");
	
	form2.items.itemAt(0).setValue("NY");
	form2.items.itemAt(1).setValue("NY");
	
	/*******************************************************************/
	/**** LOCAL PAGING STORE *******************************************/
	/*******************************************************************/
	
	var form3 = new Ext.form.FormPanel({
		width:300
		,autoHeight:true
		,border:false
		,padding:"5"
		,items:[{
			xtype:"combo"
			,anchor:"0"
			,fieldLabel:"ExtJS Combo"
			,emptyText:"select a country..."
			,displayField:"name"
		    ,valueField:"id"
		    ,triggerAction:"all"
			,listWidth:230
		    ,pageSize:5
		    ,store:new Ext.data.Store({
		        reader:new Ext.data.ArrayReader({}, ["id", "name"])
		        ,proxy:new Ext.ux.data.PagingMemoryProxy(Ext.exampledata.states)
		    })
		}, {
			xtype:"awesomecombo"
			,triggerAction:"all"
		    ,pageSize:5
		    ,store:Ext.exampledata.states
			,anchor:"0"
			,emptyText:"select a country..."
			,fieldLabel:"Awesome Combo"
		}]
	}).render("form3");
	
	
	/*******************************************************************/
	/**** AJAX LOAD ****************************************************/
	/*******************************************************************/
	
	var form4 = new Ext.form.FormPanel({
		width:300
		,autoHeight:true
		,border:false
		,padding:"5"
		,items:[{
			xtype:"combo"
			,anchor:"0"
			,fieldLabel:"ExtJS Combo"
			,displayField:"name"
		    ,valueField:"id"
		    ,triggerAction:"all"
		    ,emptyText:"select a country..."
		    ,store:new Ext.data.JsonStore({
		        url:"php/data.php"
		        ,fields:["id", "name"]
		    })
		}, {
			xtype:"awesomecombo"
			,anchor:"0"
			,emptyText:"select a country..."
			,fieldLabel:"Awesome Combo"
			,displayField:"name"
	    ,valueField:"id"
	    ,triggerAction:"all"
	    ,store:new Ext.data.JsonStore({
	        url:"php/data.php"
	        ,fields:["id", "name"]
	    })
		}]
	}).render("form4");
	
	/*******************************************************************/
	/**** XTYPE STORE **************************************************/
	/*******************************************************************/
	
	var form5 = new Ext.form.FormPanel({
		width:300
		,autoHeight:true
		,border:false
		,padding:"5"
		,items:[{
			xtype:"combo"
			,anchor:"0"
			,fieldLabel:"ExtJS Combo"
			,displayField:"name"
		    ,valueField:"id"
		    ,triggerAction:"all"
		    ,emptyText:"select a country..."
		    ,store:{
		        xtype:"jsonstore"
		        ,url:"php/data.php"
		        ,fields:["id", "name"]
		    }
		}, {
			xtype:"awesomecombo"
			,anchor:"0"
			,fieldLabel:"Awesome Combo"
			,displayField:"name"
		    ,valueField:"id"
		    ,triggerAction:"all"
		    ,emptyText:"select a country..."
		    ,store:{
		        xtype:"jsonstore"
		        ,url:"php/data.php"
		        ,fields:["id", "name"]
		    }
		}]
	}).render("form5");
	
	    /*******************************************************************/
	    /**** MULTISELECT & LOCAL PAGING STORE *****************************/
	    /*******************************************************************/
	
	var form6 = new Ext.form.FormPanel({
		width:300
		,autoHeight:true
		,border:false
		,padding:"5"
		,items:[{
			xtype:"awesomecombo"
			,anchor:"0"
			,store:Ext.exampledata.states
			,fieldLabel:"Awesome Combo"
			,emptyText:"select a country..."
			,triggerAction:"all"
	        ,pageSize:5
	        ,enableMultiSelect:true
		}, {
			xtype:"awesomecombo"
			,anchor:"0"
			,emptyText:"select a country..."
			,fieldLabel:"Awesome Combo"
			,displayField:"name"
	        ,valueField:"id"
	        ,triggerAction:"all"
	        ,enableMultiSelect:true
	        ,store:{
	            xtype:"jsonstore"
	            ,url:"php/data.php"
	            ,fields:["id", "name"]
	        }
		}]
	}).render("form6");
	
	    /*******************************************************************/
	    /**** COMBOBOX IN A COMPOSITE FIELD ********************************/
	    /*******************************************************************/
	
	var form7 = new Ext.form.FormPanel({
		title:"Form Panel"
		,width:300
		,height:100
		,frame:true
		,padding:"5"
		,items:[{
			xtype:"compositefield"
			,fieldLabel:"ExtJS Combo"
			,items:[{
				xtype:"combo"
				,flex:2
			}, {
				xtype:"button"
				,text:"OK"
				,flex:1
			}]
		}, {
			xtype:"compositefield"
			,fieldLabel:"Awesome Combo"
			,items:[{
				xtype:"awesomecombo"
				,flex:2
			}, {
				xtype:"button"
				,text:"OK"
				,flex:1
			}]			
		}]
	}).render("form7");
	
	    /*******************************************************************/
	    /**** COMBOBOX IN A WINDOW *****************************************/
	    /*******************************************************************/
	
	new Ext.Button({
		text:"open window"
		,handler:function() {
			new Ext.Window({
				layout:"form"
				,title:"Window"
				,collapsed:true
				,expandOnShow:false
				,collapsible:true
				,width:300
				,autoHeight:true
				,padding:"5"
				,items:[{
					xtype:"combo"
					,anchor:"0"
					,fieldLabel:"ExtJS Combo"
				}, {
					xtype:"awesomecombo"
					,anchor:"0"
					,fieldLabel:"Awesome Combo"
				}]
			}).show();
		}
	}).render("button1");

	var form8 = new Ext.form.FormPanel({
		width:300
		,autoHeight:true
		,border:false
		,padding:"5"
		,items:[{
			xtype:"awesomecombo"
			,store:Ext.exampledata.states
			,anchor:"0"
			,emptyText:"select a country..."
			,fieldLabel:"Simple"
			,value: 'NY'
		}, {
			xtype:"awesomecombo"
			,store:Ext.exampledata.states
			,anchor:"0"
			,emptyText:"select a country..."
			,fieldLabel:"hideTrigger"
			,hideTrigger: true
			,value: 'NY'
		}, {
			xtype:"awesomecombo"
			,store:Ext.exampledata.states
			,anchor:"0"
			,emptyText:"select a country..."
			,fieldLabel:"disableClearButton"
			,disableClearButton: true
			,value: 'NY'
		}, {
			xtype:"awesomecombo"
			,store:Ext.exampledata.states
			,anchor:"0"
			,emptyText:"select a country..."
			,fieldLabel:"readOnly"
			,readOnly:true
			,value: 'NY'
		}, {
			xtype:"awesomecombo"
			,store:Ext.exampledata.states
			,anchor:"0"
			,emptyText:"select a country..."
			,fieldLabel:"disabled"
			,disabled:true
			,value: 'NY'
		}]
	}).render("form8");

});