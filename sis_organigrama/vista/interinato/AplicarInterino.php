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
Phx.vista.AplicarInterino = {
    bedit:false,
    bnew:false,
    bsave:false,
    bdel:false,
	require:'../../../sis_organigrama/vista/interinato/Interinato.php',
	requireclase:'Phx.vista.Interinato',
	title:'Aplica Interinato',
	nombreVista: 'AplicarInterinato',
	/*
	 *  Interface heredada para el sistema de adquisiciones para que el reposnable 
	 *  de adqusiciones registro los planes de pago , y ase por los pasos configurados en el WF
	 *  de validacion, aprobacion y registro contable
	 * */
	
	constructor: function(config) {
	   Phx.vista.AplicarInterino.superclass.constructor.call(this,config);	   
	     this.store.baseParams = {id_cargo_suplente:Phx.CP.config_ini.id_cargo, estado_reg:'activo'}      
      	this.load({params:{start:0, limit:this.tam_pag}});
	   this.addButton('aplicar_int',{text:'Sincronizar',iconCls: 'blist',disabled:true,handler:this.onAplicarInterinato,tooltip: '<b>Aplicar Cargo de Interinato</b><br/>Sinc '});
       
    },
    
    onAplicarInterinato:function(){
        var data=this.sm.getSelected().data;
        
        Phx.CP.loadingShow();
        Ext.Ajax.request({
            // form:this.form.getForm().getEl(),
            url:'../../sis_organigrama/control/Interinato/aplicarInterinato',
            params:{'id_interinato':data.id_interinato},
            success:this.successSinc,
            failure: this.conexionFailure,
            timeout:this.timeout,
            scope:this
        });
        
        
    },
    
    
    successSinc:function(resp){
            
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                Phx.CP.loadingShow();
                window.location.reload()
               
            }else{
                
                alert('ocurrio un error durante el proceso')
            }
     
     },
    
    preparaMenu:function(tb){
            
            this.getBoton('aplicar_int').enable();
            Phx.vista.AplicarInterino.superclass.preparaMenu.call(this,tb)
            return tb
        },
        
   liberaMenu:function(tb){
        
        this.getBoton('aplicar_int').disable();
        Phx.vista.AplicarInterino.superclass.liberaMenu.call(this,tb)
        return tb
    }
    
   
    
     
    
    
    
};
</script>
