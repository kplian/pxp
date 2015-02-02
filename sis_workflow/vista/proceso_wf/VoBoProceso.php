<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (rac)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.VoBoProceso = {
	require:'../../../sis_workflow/vista/proceso_wf/ProcesoWf.php',
	requireclase:'Phx.vista.ProcesoWf',
	title:'Visto bueno de Tramite',
	nombreVista: 'ProcesoWfVb',
	
	constructor: function(config) {
        Phx.vista.VoBoProceso.superclass.constructor.call(this,config);
        this.store.baseParams={tipo_interfaz:'VoBoProceso'};
        this.load({params:{start:0, limit:this.tam_pag}});
    },
     
   
    bedit:false,
    bnew:false,
    bdel:true
    
};
</script>
