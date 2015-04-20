<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite 
*dar el visto a solicitudes de compra
*
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AsignarInterino = {
    bedit:true,
    bnew:true,
    bsave:false,
    bdel:true,
	require:'../../../sis_organigrama/vista/interinato/Interinato.php',
	requireclase:'Phx.vista.Interinato',
	title:'Asignar Interinato',
	nombreVista: 'AsignarInterino',
	/*
	 *  Interface heredada para el sistema de adquisiciones para que el reposnable 
	 *  de adqusiciones registro los planes de pago , y ase por los pasos configurados en el WF
	 *  de validacion, aprobacion y registro contable
	 * */
	
	constructor: function(config) {
	   
	  this.Atributos[this.getIndAtributo('id_cargo_titular')].form=false;
 
	  Phx.vista.AsignarInterino.superclass.constructor.call(this,config); 
	   this.store.baseParams = {estado_reg:'activo'}      
      	this.load({params:{start:0, limit:this.tam_pag}});
    },
    
    ActSave:'../../sis_organigrama/control/Interinato/asignarMiSuplente',
    ActList:'../../sis_organigrama/control/Interinato/listarMisSuplentes',
    
 
};
</script>
