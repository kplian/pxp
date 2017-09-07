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
Phx.vista.ProveedorVb = {
    bedit:false,
    bnew:false,
    bsave:false,
    bdel:false,
	require:'../../../sis_parametros/vista/proveedor/Proveedor.php',
	requireclase:'Phx.vista.proveedor',
	title:'Presupuesto',
	nombreVista: 'ProveedorVb',
	ActList:'../../sis_parametros/control/Proveedor/listarProveedorWf',
	
	
	
	
	
	constructor: function(config) {
	   Phx.vista.ProveedorVb.superclass.constructor.call(this,config);
	   
	   this.addButton('btnIniTra',{grupo:[0],text: 'Iniciar',iconCls: 'bchecklist',disabled: true,handler: this.iniTramite,tooltip: '<b>Iniciar Trámite</b><br/>Inicia el trámite de formulación para el presupuesto'});
       this.addButton('ant_estado',{
         	  grupo:[4],
              argument: {estado: 'anterior'},
              text: 'Retroceder',
              iconCls: 'batras',
              disabled: true,
              handler: this.antEstado,
              tooltip: '<b>Pasar al Anterior Estado</b>'
        });
          
        this.addButton('fin_registro', { grupo:[0], text:'Siguiente', iconCls: 'badelante', disabled:true,handler:this.fin_registro,tooltip: '<b>Siguiente</b><p>Pasa al siguiente estado, si esta en borrador comprometera presupuesto</p>'});
        
         this.addButton('btnChequeoDocumentosWf',
            {
                text: 'Documentos',
                grupo:[0,1,2],
                iconCls: 'bchecklist',
                disabled: true,
                handler: this.loadCheckDocumentosSolWf,
                tooltip: '<b>Documentos de la Solicitud</b><br/>Subir los documetos requeridos en la solicitud seleccionada.'
            }
        );
		this.addButton('diagrama_gantt',{ grupo:[0,1,2], text: 'Gantt', iconCls: 'bgantt', disabled: true, handler: this.diagramGantt, tooltip: '<b>Diagrama gantt de proceso macro</b>'});

	   
       this.init();
       //this.load({params:{start:0, limit:this.tam_pag, tipo_interfaz: this.nombreVista }});
       
       
        
   },
    
    preparaMenu:function(n){
	 	  var data = this.getSelectedData();
          var tb =this.tbar;
          
          Phx.vista.ProveedorVb.superclass.preparaMenu.call(this,n);
          if(data['estado'] == 'borrador'){
          	 this.getBoton('btnIniTra').enable();
          }
          else{
          	 this.getBoton('btnIniTra').disable();
          }
          
          if (data['estado']!= 'borrador' && data['estado']!= 'aprobado' && data['nro_tramite']!=''){
             this.getBoton('ant_estado').enable(); 
          }
          else{
          	this.getBoton('ant_estado').disable();
          }
          
          if (data['estado']!= 'aprobado'&& data['nro_tramite']!=''&& data['nro_tramite']!=undefined){
              	 this.getBoton('fin_registro').enable();
          }
          else{
          	this.getBoton('fin_registro').disable();
          }
          
          this.getBoton('btnChequeoDocumentosWf').enable(); 
          this.getBoton('diagrama_gantt').enable(); 
          
          
    },
    
    liberaMenu:function(){
    	var tb = Phx.vista.ProveedorVb.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnIniTra').disable();
            this.getBoton('fin_registro').disable();
            this.getBoton('ant_estado').disable(); 
            this.getBoton('btnChequeoDocumentosWf').disable();
            this.getBoton('diagrama_gantt').disable();  
            
            
            
        }
    },

};
</script>