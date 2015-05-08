<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ProcesoWfVb = {
	require:'../../../sis_workflow/vista/proceso_wf/ProcesoWf.php',
	requireclase:'Phx.vista.ProcesoWf',
	title:'Visto bueno de Tramite',
	nombreVista: 'ProcesoWfVb',
	
	constructor: function(config) {
    		this.initButtons=[this.cmbProcesoMacro];
    		Phx.vista.ProcesoWfVb.superclass.constructor.call(this,config);
    },
     
   /* preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
      Phx.vista.ProcesoWfVb.superclass.preparaMenu.call(this,n); 
          this.getBoton('sig_estado').enable(); 
          this.getBoton('ant_estado').enable();
          this.getBoton('diagrama_gantt').enable();
         
          return tb 
     }, 
     liberaMenu:function(){
        var tb = Phx.vista.ProcesoWfVb.superclass.liberaMenu.call(this);
        if(tb){
           
            this.getBoton('ant_estado').disable();
            this.getBoton('sig_estado').disable();
            this.getBoton('diagrama_gantt').disable();
           
        }
        return tb
    },*/
    bedit:false,
    bnew:false,
    bdel:true
    
};
</script>
