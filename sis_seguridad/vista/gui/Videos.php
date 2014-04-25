<?php
/**
*@package pXP
*@file Gui.php 
*@author KPLIAN favio figueroa (admin) 
*@date 14-02-2011
*@description  Vista para registrar la vistas para el uso del manual
*/

header("content-type: text/javascript; charset=UTF-8");
?>

<script>

/*var valor_para_el_manual2 = function(m)
{
	alert(m);
}*/

Phx.vista.Videos=Ext.extend(Ext.util.Observable, {
	

onReloadPage:function(m){
/*alert('fa');*/

console.log(m);
console.log(m.id_gui); 
var dato_manual = m.id_gui;

 frames.iframe_manual.document.getElementById('IdDivFrame').innerHTML = dato_manual; // prueba de envio
 frames.iframe_manual.document.frm_ver_idgui.txt_idgui.value = dato_manual; // envia un dato al textbox del iframe
 frames.iframe_manual.document.frm_ver_idgui.prueba.click(); // esto realiza click en a la funcion que existe en el iframe

},


constructor: function(config) {
	
	
		Phx.baseInterfaz.superclass.constructor.call(this, config);
        Ext.apply(this, config);
        delete config;
        this.panel = Ext.getCmp(this.idContenedor);
		this.addEvents('init');
	

}
	
		
});
</script>

<iframe width="100%" height="100%" src="../videos/videos.php" name="iframe_manual"></iframe>
<!--<input id="parentTextbox" type="text" value="red" /> -->


