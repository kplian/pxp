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
Phx.vista.ProveedorInicio = {
    bedit:true,
    bnew:true,
    bsave:false,
    bdel:true,
	require:'../../../sis_parametros/vista/proveedor/Proveedor.php',
	requireclase:'Phx.vista.proveedor',
	title:'Proveedor',
	nombreVista: 'ProveedorInicio',
	
	swEstado : 'borrador',
    gruposBarraTareas:[{name:'borrador',title:'<H1 align="center"><i class="fa fa-thumbs-o-down"></i> Borradores</h1>', grupo:0,height:0},
                       {name:'en_proceso',title:'<H1 align="center"><i class="fa fa-eye"></i> En Proceso</h1>', grupo:1,height:0},
                       {name:'finalizados',title:'<H1 align="center"><i class="fa fa-file-o"></i> Finalizados</h1>', grupo:2,height:0}],
	
     beditGroups: [0,1,2],     
     bactGroups:  [0,1,2],
     btestGroups: [0],
     bexcelGroups: [0,1,2],
	
	
	constructor: function(config) {
	    
	    Phx.vista.ProveedorInicio.superclass.constructor.call(this,config);
	    this.bloquearOrdenamientoGrid();
	    
        
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
		this.finCons = true; 
   },
  
	
    getParametrosFiltro: function(){    	
        this.store.baseParams.prov_estado = this.swEstado;
        this.store.baseParams.tipo_interfaz = this.nombreVista;
        this.store.baseParams.tipo = this.cmbProveedor.getValue();
    },
	
	
	capturaFiltros:function(combo, record, index){
		this.getParametrosFiltro();
        this.load({params:{start:0, limit:50}});
		
		
	},
	
	actualizarSegunTab: function(name, indice){
    	if(this.finCons){
    		 
    		 this.getParametrosFiltro();
    		 this.store.baseParams.prov_estado = name;
    		 Phx.vista.ProveedorInicio.superclass.onButtonAct.call(this);
    	     //this.load({params:{start:0, limit:this.tam_pag}});
    	   }
    },
    
	
	
	
    
    preparaMenu:function(n){
	 	  var data = this.getSelectedData();
          var tb =this.tbar;
          
          Phx.vista.ProveedorInicio.superclass.preparaMenu.call(this,n);
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
    	var tb = Phx.vista.ProveedorInicio.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnIniTra').disable();
            this.getBoton('fin_registro').disable();
            this.getBoton('ant_estado').disable(); 
            this.getBoton('btnChequeoDocumentosWf').disable();
            this.getBoton('diagrama_gantt').disable();  
            
            
            
        }
    }
      
};
</script>
