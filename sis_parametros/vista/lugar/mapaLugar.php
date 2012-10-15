<?php
/**
*@package pXP
*@file gen-TipoEvento.php
*@author  (prueba1)
*@date 13-10-2011 11:22:31
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.mapaLugar=Ext.extend(Phx.gmapInterfaz,{
	autoLoad :true,
	
		mostrarDatos:function(datos){
		
	   },
	    
	    Atributos:[
	    ],
		

	constructor:function(config){
		this.maestro=config.maestro;
		
		
		Phx.vista.mapaLugar.superclass.constructor.call(this,config);
	
    
    
		
	
		
    	/*//llama al constructor de la clase padre
		Phx.vista.TipoEvento.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})*/
    	
    	/* this.gm = new  Ext.ux.GMapPanel({
    	 	region: 'center',
    	 	containerScroll: true,
                border: false,
                //layout: 'fit',
               forceLayout:true,
               mapConfig:{ 
				 mapTypeId: google.maps.MapTypeId.ROADMAP,
		      },
       	   //autoHeight:true,
       	   autoDestroy:true,
       	   //autoWidth:true,
            plain: true,
                autoShow:true,
                title: 'GMap Window',
                 border:true,
                gmapType: 'map',
                //closeAction: 'hide',
                //width:400,
                //height:400,
                //x: 40,
                //y: 60
               
                
            })*/
    	/*
    	 this.gm = new  Ext.ux.GMapPanel({
                layout: 'fit',
                title: 'GMap Window',
                closeAction: 'hide',
                width:400,
                height:400,
                x: 40,
                y: 60,
                items: {
                    xtype: 'gmappanel',
                    zoomLevel: 14,
                    gmapType: 'map',
                   // mapConfOpts: ['enableScrollWheelZoom','enableDoubleClickZoom','enableDragging'],
                   // mapControls: ['GSmallMapControl','GMapTypeControl','NonExistantControl'],
                    /*setCenter: {
						//geoCodeAddr: '4 Yawkey Way, Boston, MA, 02215-3409, USA',
						
						lat: -17.5384998321533,
	                    lng: -63.1627655029297,
						
                        marker: {title: 'Fenway Park'}
		                        },
                    markers: [{
                       lat: -17.5384998321533,
	                    lng: -63.1627655029297,
                        
                        //lat: -17,5384998321533,
	                    //lng: -63,1627655029297,
                        
                        
                        marker: {title: 'zzzzzzzzzzzzzzz zzzzzzzzzz'}
                   // }]
                }
            });*/
            
          
    	this.regiones = new Array();
		//agrega el treePanel
		this.regiones.push(this.gm);
		/*arma los panles de ventanas hijo*/
	    this.definirRegiones();
    	
            
           // this.panel.add(this.gm)
            
            console.log(this.gm.isVisible())
            //this.gm.syncSize() 
             console.log(this.gm.isVisible())
            
            this.gm.expand(true);
             console.log(this.gm.isVisible())
             
             
             this.panel.doLayout(true,true)
            
            
        //this.gm.gmap = new google.maps.Map( this.idContenedor,  this.gm.defConfig);
        //this.gm.gmap.setCenter(new google.maps.LatLng(18.2, -66.4)) 
            
            
            

            // this.gm.render();
            //this.gm.gmap.setCenter(new google.maps.LatLng(18.2, -66.4));
           
          //  this.gm.render();
            /*
          
           	this.a = [{
                        lat: 42.339641,
                        lng: -71.094224,
                        marker: {title: 'XXXXXXXXXXXXXXXXXXXXXX'},
                        listeners: {
                            click: function(e){
                                Ext.Msg.alert('Its fine', 'and its art.');
                            }
                        }
                    }]
		
           
		
		 var point = new GLatLng(-17.5384998321533,-63.1627655029297);
         //this.gm.gmap.setCenter(point,5);   
		
		this.gm.setCenter()
            
    	this.gm.addMarkers(this.a)*/
            
		 this.geocoder = new google.maps.Geocoder();
			/*  function initialize() {
			   
			    var latlng = new google.maps.LatLng(-34.397, 150.644);
			    var myOptions = {
			      zoom: 8,
			      center: latlng,
			      mapTypeId: google.maps.MapTypeId.ROADMAP
			    }
			    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
			  }*/
			
		
			  
			            
            
            

	},
	
	onReloadPage:function(dat){
		console.log(dat)
		
		
		//this.ubicarPos('Rio Btanco - Acre - Brasil');
		
	},
		
	ubicarPos:function(direc,zoom){
			var myMapa = this.gm.getMap()
			var address = direc;
			
			
			if(!this.marker){
			this.marker = new google.maps.Marker({
			            map: myMapa 
			        });
			        
			}  
			var marker = this.marker      
			        
			this.geocoder.geocode({ 'address': address}, function(results, status) {
			      if (status == google.maps.GeocoderStatus.OK) {
			        myMapa.setCenter(results[0].geometry.location);
			        myMapa.setZoom(zoom*3)
			        marker.setPosition(results[0].geometry.location)
			        
			      } else {
			        alert("No se pudo encontrar la direcci�n por este motivo: " + status);
			      }
			    });
		
		
	},
	getMarker:function(){
		return this.marker 
		
	}
	
		
	
	})
</script>