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
Phx.vista.ProcesoWfIniTra = {
	require:'../../../sis_workflow/vista/proceso_wf/ProcesoWf.php',
	requireclase:'Phx.vista.ProcesoWf',
	title:'Inicio de Tramite',
	nombreVista: 'ProcesoWfIniTra',
	
	constructor: function(config) {
    		this.initButtons=[this.cmbProcesoMacro];
    		Phx.vista.ProcesoWfIniTra.superclass.constructor.call(this,config);
    				
						
    },
	onButtonNew: function() {
        
        if(this.validarFiltros())
           {Phx.vista.ProcesoWfIniTra.superclass.onButtonNew.call(this);
             this.filtraAddEdit();
             this.enableDisable('persona');
             this.Cmp.fecha_ini.enable();
             this.Cmp.id_tipo_proceso.enable();
            
            }
        else{
            alert('Seleccione el Trámite');
        }
        
       
    },
     onButtonEdit:function(){
       
        Phx.vista.ProcesoWfIniTra.superclass.onButtonEdit.call(this); 
        var data = this.getSelectedData();
        Phx.vista.ProcesoWfIniTra.superclass.onButtonEdit.call(this);
        this.filtraAddEdit();
        this.enableDisable(data.tipo_ini);
        
        this.Cmp.fecha_ini.disable();
        this.Cmp.id_tipo_proceso.disable();
                
        
    },
     
     enableDisable:function(val){
      if(val =='institucion'){
            
            this.cmpIdPersona.disable();
            this.cmpIdPersona.reset()
            this.cmpIdInstitucion.enable();
            this.cmpIdPersona.setVisible(false);
            this.cmpIdInstitucion.setVisible(true);
        }
        else{
            this.cmpIdPersona.enable();
            this.cmpIdInstitucion.disable();
            this.cmpIdInstitucion.reset();
            this.cmpIdPersona.setVisible(true);
            this.cmpIdInstitucion.setVisible(false);
            
         }
         
     },
    
     iniciarEventos:function(){
          
          this.cmpTipoProceso=this.getComponente('id_tipo_proceso');
          
          this.cmpTipoIni=this.getComponente('tipo_ini');
          
          this.cmpIdPersona=this.getComponente('id_persona');
          this.cmpIdInstitucion=this.getComponente('id_institucion');
          
        
         this.cmpTipoIni.on('change',function(groupRadio,radio){
                        if(radio.inputValue){
                            this.enableDisable(radio.inputValue);
                        }
                    },this); 
                    
    },
   /* preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
      Phx.vista.ProcesoWfIniTra.superclass.preparaMenu.call(this,n);  
         
         this.getBoton('diagrama_gantt').enable();
         if(data.tipo_estado_inicio=='si'){
            this.getBoton('sig_estado').enable();
          }
          else{
              this.getBoton('sig_estado').disable();  
          }
          this.getBoton('diagrama_gantt').enable(); 
          return tb 
     }, 
     liberaMenu:function(){
        var tb = Phx.vista.ProcesoWf.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('sig_estado').disable();
            this.getBoton('diagrama_gantt').disable();
            this.getBoton('diagrama_gantt').disable();
           
        }
        return tb
    },*/
    
     filtraAddEdit:function(){
        this.cmpTipoProceso.store.baseParams.id_proceso_macro=this.cmbProcesoMacro.getValue();
        this.cmpTipoProceso.modificado=true;
            
        
    }
    
};
</script>
