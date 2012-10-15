/*
**********************************************************
Nombre de la clase:	    arbInterfaz
Proposito:				clase generica para manejo de interfaces tipo arbol
Fecha de Creacion:		21 - 11 - 09
Version:				0
Autor:					Rensi Arteaga Copari
**********************************************************
*/
Ext.namespace('Phx','Phx.vista');
Phx.gmapInterfaz=Ext.extend(Phx.baseInterfaz,{

	//Componentes:NULL,
	enableGrid:false,
	encripForm:false,
	title:'gmap-Interfaz',
	
	markersArray:[],
	popupsArray:[],
	
	bsave:false,
	bnew:false,
	bedit:false,
	bdel:false,
	bact:false,
    bexcel:false,

    containerScroll:true,
    
    tipoInterfaz:'gmapInterfaz',
  	
	//para definir datos basicos que se manejan en todos los nodos
		
	//parametros propios
	
	swBtn:undefined,//esta variables se utiliza para identificar el boton orpimido
	
	paramsCheck:{},
 
	//Funcion nuevo del toolbar
	onButtonNew:function(){
		
		
	},
	//Funcion editar del toolbar
	onButtonEdit:function(){

		
	},
	
	
	//Funcion eliminar del toolbar
	onButtonDel:function(){ 
		
	},
	
	//Funcion actualizar del toolbar
	onButtonAct:function(){
		
		
	},
	
	
	/*
	 *  Inicia y contruye la interface tipo arbol 
	 *  con los parametros de la clase hija
	 * 
	 * */
	constructor: function(config){
	
		Phx.arbInterfaz.superclass.constructor.call(this,config);
		
         //inicia formulario con todos sus componentes
    	//si es tipo grilla editable tabien los inicia
    	this.definirComponentes();
    	//definir formulario tipo venatana
    	this.definirFormularioVentana();
		//definicion de la barra de meno
		this.defineMenu();
		
		
		//define panel google maps
		 this.gm = new  Ext.ux.GMapPanel({
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
       	   tbar:this.tbar,
       	   //autoWidth:true,
            plain: true,
            autoShow:true,
            
            border:true,
             gmapType: 'map',
                //closeAction: 'hide',
                //width:400,
                //height:400,
                //x: 40,
                //y: 60
            })
		
		
		
        // para capturar un error
		//this.loaderTree.on('loadexception',this.conexionFailure); //se recibe un error
		this.regiones = new Array();
		//agrega el treePanel
		this.regiones.push(this.gm);
		/*arma los panles de ventanas hijo*/
	    this.definirRegiones();
	    
	    this.gm.expand(true);
        this.panel.doLayout(true,true);
        
        this.geocoder = new google.maps.Geocoder();
        
        console.log('>>>>>  constructor')
	},//ubica los marcadores en el mapa
	
	
	colocarMarcadores:function(conf){
		//retira los marcadores actulaes silos tuviera
		this.quitarMarcadores()
     	var myMapa = this.gm.getMap();
     	var popup;
     	var popups = new Array();
     	//console.log('this.gm  111' ,this.gm)
        
     	myMapa.setCenter(new google.maps.LatLng(0,0),0);
        
     	/* Creamos un objeto vacio GLatLngBounds() */
        var bounds = new google.maps.LatLngBounds();
        
        var mostrarPopup =this.mostrarPopup;
		var myMarks = new Array();
		
		function closeInfoWindow() {
        	popup.close();
    	}
    	google.maps.event.addListener(myMapa, 'click', function(){
            closeInfoWindow();
        });
        
        
        
    	for(var i=0;i<conf.store.getCount();i++){    	 
			    pos=new google.maps.LatLng(conf.store.getAt(i).data[conf.lat],conf.store.getAt(i).data[conf.lon],true)
			    var titulo = 'incluir titulo aqui ' + i;
			    var myMark = new google.maps.Marker({
				            map: myMapa,
				            title: titulo, //conf.store.getAt(i).data[conf.lat],
				            position: pos,
				            zIndex: i
				        });
				popups[i] = '<table width="300" border="0" cellspacing="0" cellpadding="0" style="font-size:9px; font-family:Verdana, Geneva, sans-serif">' +
				  '<tr>'+
				    '<td width="67" height="67"><img src="http://www.trs-avl.com/icons/'+ (i+10) + '.png" alt="" width="67" height="67" /></td>'+
				    '<td width="233"><p>'+
				        '<strong>Vehiculo:</strong> i:=' + i +' <br />'+
				        '<strong>Chofer:</strong> ' + conf.store.getAt(i).data.rio + '<br />'+
				        '<strong>Lat:</strong> '+ conf.store.getAt(i).data[conf.lat] +' <br />'+
				        '<strong>Lon:</strong> '+ conf.store.getAt(i).data[conf.lon] +' <br />'+
				        '<strong>Estacion:</strong> ' + conf.store.getAt(i).data.id_estacion +
				        '</p>'  +
				     '</td> ' +
				  '</tr>'+
				'</table>' ;
				
	
				
				myMarks[myMark.zIndex] = myMark;
				
				this.markersArray[i] = myMark;
				
				
				google.maps.event.addListener(myMarks[myMark.zIndex], 'click', function(){
		            
		            if (popup){
		            	closeInfoWindow();
		            }
		             	popup = new google.maps.InfoWindow({
		             		content: popups[this.zIndex]
		             	});
		            popup.open(myMapa, this);
		            
		        });
		        
			     /* Por cada uno de los puntos a incluir en el mapa extendemos los l�mites del objeto */
				/* En este caso latlng deber�a ser un objeto GLatLng */
				/* Ejemplo: var latlng = new GLatLng(43, -2); */
				bounds.extend(pos);
				/* Cuando hayamos incluido todos los puntos seteamos el centro y el zoom usando el objeto 'bounds' */
				myMapa.fitBounds(bounds);
				myMapa.setZoom(Math.min(15,myMapa.getZoom()));
			
      } 
		 console.log('colocarMarcadores')
		 
		
	},
	
	quitarMarcadores:function() {
		console.log('quitar marcadores')
		  if (this.markersArray) {
		    for (var i in this.markersArray) {
		    	if(this.markersArray[i] && this.markersArray[i].setMap){
		            this.markersArray[i].setMap(null);
		    	}
		    }
		  }
  },
  
  colocarMarcadoresRuta:function(conf){
		//retira los marcadores actulaes si los tuviera
		this.quitarMarcadores();
		
		console.log(conf);
		
		var directionDisplay;
	  	var directionsService = new google.maps.DirectionsService();
	  	var map;
	  	var origin = null;
	  	var destination = null;
	  	var waypoints = [];
	  	var markers = [];
	  	var directionsVisible = false;
	  	var i=0;
		
		/* Creamos un objeto vacio GLatLngBounds() */
        var bounds = new google.maps.LatLngBounds();
		
		directionsDisplay = new google.maps.DirectionsRenderer();
		
		//reset();
		
	    var bolivia = new google.maps.LatLng(-16.719404338814694,-65.36918359375);
	    var myOptions = {
	      zoom:0,
	      mapTypeId: google.maps.MapTypeId.ROADMAP,
	      center: bolivia
	    }
	    map = this.gm.getMap();
	    directionsDisplay.setMap(map);
	    directionsDisplay.setPanel(null);
	    alert('XXXXXXXXXXXXXX')
	    
	    console.log('arma cordenas',conf.store.getCount())
	    
     	var posiciones = new Array;
     	
     	
     	
     	if(conf.store.getCount()==0 || conf.store.getCount()==1  ){
     		alert("No existen puntos para mostrar")
     		return false;
     	}
     
     	
     	for(i=0;i<conf.store.getCount();i++){
     		//var pos = new google.maps.LatLng(conf.store.getAt(i).data[conf.lat],conf.store.getAt(i).data[conf.lon],true);
     		posiciones[i]=new google.maps.LatLng(conf.store.getAt(i).data[conf.lat], conf.store.getAt(i).data[conf.lon], true);
     		
     		//var pos = posiciones[i];
     		if (origin == null) {
			    origin = posiciones[i];
			    addMarker(origin);
			  } else if (destination == null) {
			    destination = posiciones[i];
			    addMarker(destination);
			   } else {
		          waypoints.push({ location: destination, stopover: true });
		          destination = posiciones[i];
		          addMarker(destination);
			  }
		};
		
		bounds.extend(posiciones[i-1]);
		/* Cuando hayamos incluido todos los puntos seteamos el centro y el zoom usando el objeto 'bounds' */
		map.fitBounds(bounds);
		map.setZoom(Math.min(8,map.getZoom()));
	
		calcRoute();
    
		function addMarker(latlng) {
		    markers.push(new google.maps.Marker({
		      position: latlng, 
		      map: map,
		      icon: "http://maps.google.com/mapfiles/marker" + String.fromCharCode(markers.length + 65) + ".png"
		    }));    
		  };
		  
		 function calcRoute() {
		    if (origin == null) {
		      alert("no se ha cargado el punto inicial");
		      return;
		    }
		    
		    if (destination == null) {
		      alert("No se ha podido cargar el punto final");
		      return;
		    }
		    
		    var request = {
		        origin: origin,
		        destination: destination,
		        waypoints: waypoints,
		        travelMode: google.maps.DirectionsTravelMode.DRIVING,
		        optimizeWaypoints: true,
		        avoidHighways: true,
		        avoidTolls: true
		    	};
		    	
		    console.log('request', request);
		    
		    directionsService.route(request, function(response, status) {
		      if (status == google.maps.DirectionsStatus.OK) {
		        directionsDisplay.setDirections(response);
		      } else {
		      	alert('Direction status fail', google.maps.DirectionsStatus)
		      }
		      
		    });
		    
		    clearMarkers();
		    directionsVisible = true;
		 };
		  
		  function updateMode() {
		    if (directionsVisible) {
		      calcRoute();
		    }
		  };
		  
		  function clearMarkers() {
		    for (var i = 0; i < markers.length; i++) {
		      markers[i].setMap(null);
		    }
		  };
		  
		  function clearWaypoints() {
		    markers = [];
		    origin = null;
		    destination = null;
		    waypoints = [];
		    directionsVisible = false;
		  };
		  
		  function reset() {
		    clearMarkers();
		    clearWaypoints();
		    directionsDisplay.setMap(null);
		    directionsDisplay.setPanel(null);
		    directionsDisplay = new google.maps.DirectionsRenderer();
		    directionsDisplay.setMap(map);
		  };
		  
       	
		console.log('colocarMarcadoresRuta');
		 
	} //colocarMarcadoresRuta
   
   
   
});
