/*!
 * Ext JS Library 3.3.0
 * Copyright(c) 2006-2010 Ext JS, Inc.
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
/**
 * @class Ext.ux.GMapPanel
 * @extends Ext.Panel
 * @author Shea Frederick
 */
Ext.ux.GMapPanel = Ext.extend(Ext.Panel,{
	tipoMapa: 'ROADMAP',
	mapConfig:{ 
		zoom: 2,
        center: new google.maps.LatLng(18.2, -66.4),
        mapTypeId: google.maps.MapTypeId.SATELLITE,
        plain: true,
            //zoomLevel: 3,
            //: 180,
            // pitch: 0,
            //zoom: 0,
        border: false
            
            
        },
       // autoShow:true,
     //layout: 'fit',
       	   //forceLayout:true,
       	   //autoHeight:true,
       	   //autoDestroy:true,
       	  // autoWidth:true,
            //plain: true,
           // zoomLevel: 3,
            //yaw: 180,
            //pitch: 0,
           //zoom: 0,
            
            
     gmapType: 'map',
     border: false,  
	
	constructor:function(config){
		
		    
          console.log('config',config);
       
        
      
       console.log(this.mapConfig);
        
        Ext.applyIf(this,config);
        Ext.apply(this.mapConfig,config.mapConfig);
        
        console.log(this.mapConfig);
       
		Ext.ux.GMapPanel.superclass.constructor.call(this);
		
		
		
		
	},
	
	
	
    initComponent : function(){
        
       
        
        Ext.ux.GMapPanel.superclass.initComponent.call(this); 
        
        //this.gmap = new google.maps.Map(this.body.dom, this.defConfig);
        //this.gmap.setCenter(new google.maps.LatLng(18.2, -66.4))   
        
      
            

    },
    afterRender : function(){
        
        //var wh = this.ownerCt.getSize();
       // Ext.applyIf(this, wh);
       console.log('afterRender');
       
      
        
        Ext.ux.GMapPanel.superclass.afterRender.call(this);    
        

        this.gmap = new google.maps.Map(this.body.dom);
        
        this.gmap.setOptions(this.mapConfig);
        
        console.log(this.gmapType);
        
     
        	
        
        
   
        //this.gmap.setCenter(new google.maps.LatLng(18.2, -66.4)) 
        	
        	
           // this.gmap = new GMap2(this.body.dom);
            
            //this.gmap = new google.maps.Map(this.body.dom, this.defConfig);
             // this.gmap = new google.maps.Map(this.body.dom, this.defConfig);
             // this.gmap.setCenter(new google.maps.LatLng(18.2, -66.4))
              // this.gmap.setVisible(true)
              //google.maps.event.trigger(this.gmap, 'resize')
            

        /*
        if (this.gmapType === 'panorama'){
            this.gmap = new GStreetviewPanorama(this.body.dom);
        }
        
        if (typeof this.addControl == 'object' && this.gmapType === 'map') {
            this.gmap.addControl(this.addControl);
        }
        */
       // if (typeof this.setCenter === 'object') {
           // if (typeof this.setCenter.geoCodeAddr === 'string'){
           // //    this.geoCodeLookup(this.setCenter.geoCodeAddr);
           // }else{
                //if (this.gmapType === 'map'){
                 //   var point = new GLatLng(this.setCenter.lat,this.setCenter.lng);
                 //   this.gmap.setCenter(point, this.zoomLevel);    
              //  }
             //   if (typeof this.setCenter.marker === 'object' && typeof point === 'object'){
             //      this.addMarker(point,this.setCenter.marker,this.setCenter.marker.clear);
             //   }
           // }
            //if (this.gmapType === 'panorama'){
            //    this.gmap.setLocationAndPOV(new GLatLng(this.setCenter.lat,this.setCenter.lng), {yaw: this.yaw, pitch: this.pitch, zoom: this.zoom});
           // }
       // }

        google.maps.event.bind(this.gmap, 'tilesloaded', this, function(){
            this.onMapReady();
        });

    },
    onMapReady : function(){
    	
    	console.log('onMapReady');
       // this.addMarkers(this.markers);
        //this.addMapControls();
        //this.addOptions();  
    },
    onResize : function(w, h){

              
        Ext.ux.GMapPanel.superclass.onResize.call(this, w, h);
         if (typeof this.getMap() == 'object') {
           // this.gmap.checkResize();
           
           //this.gmap.event.trigger(map, 'resize')
             google.maps.event.trigger(this.gmap, 'resize');
           
        }
        

    },
    setSize : function(width, height, animate){
       
    	 Ext.ux.GMapPanel.superclass.setSize.call(this, width, height, animate); 
        if (typeof this.getMap() == 'object') {
            //this.gmap.checkResize();
            //this.gmap.event.trigger(map, 'resize')
            //this.gmap.event.trigger(this.gmap, 'resize')
            
            google.maps.event.trigger(this.gmap, 'resize');
            
        }
        
       
        
    },
    
    getMap : function(){
        
        return this.gmap;
        
    }
    
    
    
    /*
    getCenter : function(){
        
        return this.getMap().getCenter();
        
    },
    getCenterLatLng : function(){
        
        var ll = this.getCenter();
        return {lat: ll.lat(), lng: ll.lng()};
        
    },
    addMarkers : function(markers) {
        
        if (Ext.isArray(markers)){
            for (var i = 0; i < markers.length; i++) {
                var mkr_point = new GLatLng(markers[i].lat,markers[i].lng);
                this.addMarker(mkr_point,markers[i].marker,false,markers[i].setCenter, markers[i].listeners);
            }
        }
        
    },
    addMarker : function(point, marker, clear, center, listeners){
        
        Ext.applyIf(marker,G_DEFAULT_ICON);

        if (clear === true){
            this.getMap().clearOverlays();
        }
        if (center === true) {
            this.getMap().setCenter(point, this.zoomLevel);
        }

        var mark = new GMarker(point,marker);
        if (typeof listeners === 'object'){
            for (evt in listeners) {
                GEvent.bind(mark, evt, this, listeners[evt]);
            }
        }
        this.getMap().addOverlay(mark);

    },
    addMapControls : function(){
        
        if (this.gmapType === 'map') {
            if (Ext.isArray(this.mapControls)) {
                for(i=0;i<this.mapControls.length;i++){
                    this.addMapControl(this.mapControls[i]);
                }
            }else if(typeof this.mapControls === 'string'){
                this.addMapControl(this.mapControls);
            }else if(typeof this.mapControls === 'object'){
                this.getMap().addControl(this.mapControls);
            }
        }
        
    },
    addMapControl : function(mc){
        
        var mcf = window[mc];
        if (typeof mcf === 'function') {
            this.getMap().addControl(new mcf());
        }    
        
    },
    addOptions : function(){
        
        if (Ext.isArray(this.mapConfOpts)) {
            var mc;
            for(i=0;i<this.mapConfOpts.length;i++){
                this.addOption(this.mapConfOpts[i]);
            }
        }else if(typeof this.mapConfOpts === 'string'){
            this.addOption(this.mapConfOpts);
        }        
        
    },
    addOption : function(mc){
        
        var mcf = this.getMap()[mc];
        if (typeof mcf === 'function') {
            this.getMap()[mc]();
        }    
        
    },
    geoCodeLookup : function(addr) {
        
        this.geocoder = new GClientGeocoder();
        this.geocoder.getLocations(addr, this.addAddressToMap.createDelegate(this));
        
    },
    addAddressToMap : function(response) {
        
        if (!response || response.Status.code != 200) {
            Ext.MessageBox.alert('Error', 'Code '+response.Status.code+' Error Returned');
        }else{
            place = response.Placemark[0];
            addressinfo = place.AddressDetails;
            accuracy = addressinfo.Accuracy;
            if (accuracy === 0) {
                Ext.MessageBox.alert('Unable to Locate Address', 'Unable to Locate the Address you provided');
            }else{
                if (accuracy < 7) {
                    Ext.MessageBox.alert('Address Accuracy', 'The address provided has a low accuracy.<br><br>Level '+accuracy+' Accuracy (8 = Exact Match, 1 = Vague Match)');
                }else{
                    point = new GLatLng(place.Point.coordinates[1], place.Point.coordinates[0]);
                    if (typeof this.setCenter.marker === 'object' && typeof point === 'object'){
                        this.addMarker(point,this.setCenter.marker,this.setCenter.marker.clear,true, this.setCenter.listeners);
                    }
                }
            }
        }
        
    }*/
 
});

Ext.reg('gmappanel', Ext.ux.GMapPanel); 