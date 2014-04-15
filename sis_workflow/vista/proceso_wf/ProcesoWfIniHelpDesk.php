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
Phx.vista.ProcesoWfIniHD = {
	require:'../../../sis_workflow/vista/proceso_wf/ProcesoWf.php',
	requireclase:'Phx.vista.ProcesoWf',
	title:'Help Desk',
	nombreVista: 'ProcesoWfIniTra',
	bnew:true,
	bedit:false,
	bdel:false,
	bsave:false,
	constructor: function(config) {	
			this.cmbProcesoMacro.store.load({params:{start:0,limit:this.tam_pag,codigo_proceso:'SOPTE'}, 
		       callback : function (r) {
		       		if (r.length == 1 ) {	       				
		    			this.cmbProcesoMacro.setValue(r[0].data.id_proceso_macro);
		    			this.cmbProcesoMacro.fireEvent('select');
		    		} else {
		    			alert('No se ha definido un flujo para HelpDesk');
		    		}   
		    			    		
		    	}, scope : this
		    });
		    this.cmbProcesoMacro.setDisabled(true);
    		this.initButtons=[this.cmbProcesoMacro];
    		Phx.vista.ProcesoWfIniHD.superclass.constructor.call(this,config);
    		this.getBoton('btnChequeoDocumentosWf').setText('Archivos del Problema');
    		this.getBoton('btnChequeoDocumentosWf').setTooltip('Subir imágenes o archivos del problema');					
    },
	onButtonNew: function() {
        
        if(this.validarFiltros())
           {
           	 Phx.vista.ProcesoWfIniHD.superclass.onButtonNew.call(this);
           	 this.filtraAddEdit();
           	 this.Cmp.id_tipo_proceso.store.load({params:{start:0,limit:this.tam_pag}, 
			       callback : function (r) {
			       		if (r.length == 1 ) {	       				
			    			this.Cmp.id_tipo_proceso.setValue(r[0].data.id_tipo_proceso);
			    			this.Cmp.id_tipo_proceso.fireEvent('select');
			    		} 
			    			    		
			    	}, scope : this
			    });
			    
			 this.Cmp.id_persona.store.load({params:{start:0,limit:this.tam_pag,usuario_activo:'si'}, 
			       callback : function (r) {
			       		if (r.length == 1 ) {	       				
			    			this.Cmp.id_persona.setValue(r[0].data.id_persona);
			    			this.Cmp.id_persona.fireEvent('select');
			    		} 
			    			    		
			    	}, scope : this
			    });
			    
             
             this.enableDisable('persona');
             this.Cmp.fecha_ini.enable();
             this.Cmp.tipo_ini.disable();
             this.Cmp.id_persona.disable();
             this.Cmp.fecha_ini.setValue(new Date());
             this.Cmp.fecha_ini.disable();
             this.Cmp.id_tipo_proceso.disable();
            
            }
        else{
            alert('Seleccione el Trámite');
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
     filtraAddEdit:function(){
        this.cmpTipoProceso.store.baseParams.id_proceso_macro=this.cmbProcesoMacro.getValue();
        this.cmpTipoProceso.modificado=true;
            
        
    }
    
    
};
</script>
