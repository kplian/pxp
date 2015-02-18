<?php
/**
 *@package pXP
 *@file gen-SistemaDist.php
 *@author  rcm
 *@date 19/08/2013
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.EstructuraUoCheck = {
		require : '../../../sis_organigrama/vista/estructura_uo/EstructuraUo.php',
		requireclase : 'Phx.vista.EstructuraUo',
		title : 'Organigrama',
		bdel : false,
		bedit : false,
		bnew : false,
		constructor : function(config) {
			Phx.vista.EstructuraUoCheck.superclass.constructor.call(this, config);
			this.init();
			 this.getBoton('triguerreturn').enable();
		},
		ActList : '../../sis_organigrama/control/EstructuraUo/listarEstructuraUoCheck',
		btriguerreturn:true,
		onButtonTriguerreturn: function(){
			this.seleccionNodos(this.root);
			Phx.CP.getPagina(this.idContenedorPadre).uo.setValue(this.desc_uo);
			Phx.CP.getPagina(this.idContenedorPadre).id_estructura_uo.setValue(this.id_estructura_uo);
			Phx.CP.getPagina(this.idContenedorPadre).id_uo.setValue(this.id_uo);
			this.panel.close();
		},
		getAllChildNodes: function(node){
	        var allNodes = new Array();
	            if(!Ext.value(node,false)){ 
				return []; 
	        } 
	        if(!node.hasChildNodes()){ 
	            return node; 
	        } else{ 
	            allNodes.push(node); 
	            node.eachChild(function(Mynode){
	            	allNodes = allNodes.concat(this.getAllChildNodes(Mynode));
	            	if(Mynode.attributes.checked){
	            		console.log(Mynode.attributes)
	            		var _id = ','+Mynode.attributes.id_estructura_uo;
	            		var _iduo = ','+Mynode.attributes.id_uo;
	            		var _desc = ', '+Mynode.attributes.text;
	            		this.id_estructura_uo = this.id_estructura_uo + _id;
	            		this.id_uo = this.id_uo + _iduo;
	            		this.desc_uo = this.desc_uo + _desc;  
	            	}
	            },this);         
	        } 
	        return allNodes; 
		},
		seleccionNodos: function(node){
			this.id_estructura_uo='';
			this.id_uo='';
			this.desc_uo='';
			var nodes = this.getAllChildNodes(node);
			this.id_estructura_uo = this.id_estructura_uo.substring(1,this.id_estructura_uo.length)
			this.id_uo = this.id_uo.substring(1,this.id_uo.length)
			this.desc_uo = this.desc_uo.substring(1,this.desc_uo.length)
			console.log(this.id_uo)
		},
		id_estructura_uo:'',
		id_uo:'',
		desc_uo:''
	}; 
</script>
