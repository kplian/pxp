/*
**********************************************************
Nombre de la clase:	    Paginaa
Proposito:				clase generica de interfaz con grilla
Fecha de Creacion:		02 - 05 - 09
Version:				0
Autor:					Rensi Arteaga Copari
**********************************************************
*/ 
Ext.namespace('Phx','Phx.vista');
Phx.mapInterfaz=Ext.extend(Phx.baseInterfaz,{
	// Componentes:NULL,
	title:'map-Interfaz',

	topBar:false,//barra de herramientas
	tipoInterfaz:'mapInterfaz',		
	markersArray:[],
	popupsArray:[],
	
	bsave:false,
	bnew:false,
	bedit:false,
	bdel:false,
	bact:true,
    bexcel:false,

	// funcion que corre cuando se guarda con exito
	successSave:function(resp){
        Phx.CP.loadingHide();
    },	
	// Funcion declinar del formulario
	onReset:function(){
		this.form.getForm().reset();
		this.loadValoresIniciales();
	},
	
	habilaPopup:true,
	plantillaPopup: new Ext.Template(['<p>','<span>{cuenca}</span>','</p>']),
    
	mostrarPopup:function(obj,myMapa,mark,tpl,dat){
    	
    	//si el popup no existe lo crea
    	if(!this.popup){
    	  this.popup = new google.maps.InfoWindow({zIndex:0})
    	}
    	
    	tpl.compile();
    	console.log('datos',dat)
        var c =tpl.apply(dat);
    	
		 this.popup.setContent(c)
		    
		 //var myMapa = this.gm.getMap();  
		 //console.log('this.gm 2222',this.gm)
		this.popup.open(myMapa, mark);
		
	},
	
	

	//ubica los marcadores en el mapa
	colocarMarcadores:function(conf){
		//retira los marcadores actulaes silos tuviera
		this.quitarMarcadores()
     	var myMapa = this.gm.getMap();
     	//console.log('this.gm  111' ,this.gm)
        
     	myMapa.setCenter(new google.maps.LatLng(0,0),0);
        
     	/* Creamos un objeto vacio GLatLngBounds() */
        var bounds = new google.maps.LatLngBounds();
        
        var mostrarPopup =this.mostrarPopup;

    	 for(var i=0;i<conf.store.getCount();i++){ 

	    	 	this.markersArray[i] = 	 new google.maps.Marker({
				            map: myMapa 
				        });

			    pos=new google.maps.LatLng(conf.store.getAt(i).data[conf.lat],conf.store.getAt(i).data[conf.lon],true)
			     /* Por cada uno de los puntos a incluir en el mapa extendemos los l�mites del objeto */
				/* En este caso latlng deber�a ser un objeto GLatLng */
				/* Ejemplo: var latlng = new GLatLng(43, -2); */
				bounds.extend(pos);
				/* Cuando hayamos incluido todos los puntos seteamos el centro y el zoom usando el objeto 'bounds' */
				myMapa.fitBounds(bounds);
				myMapa.setZoom(Math.min(15,myMapa.getZoom()));
			    this.markersArray[i].setPosition(pos)
			    var myMark=this.markersArray[i]
			    
            if(this.habilaPopup){
                //creacion de una funcion anonima
            	(function(o,fun,mp,mark,tpl,dat){

            		google.maps.event.addListener(mark,'dblclick',function(a,b,c){
            			console.log(a,b,c)
            			console.log('doble click');
			             fun(o,mp,mark,tpl,dat)
            		})
            	
            	}
			    )(this,this.mostrarPopup,myMapa,this.markersArray[i],this.plantillaPopup,conf.store.getAt(i).data)
            }
            
       ///////////
           /* (function(id, popup, marker){
            google.maps.event.addListener(popup, 'domready', function(){
                var div = document.createElement('div');
                div.style.width = '100%';
                div.style.height = '100%';
                var root = document.getElementById('contentInfoWindow' + id);
                root.appendChild(div);
 
                var divOptions = {
                    zoom: 17
                    , center: marker.getPosition()
                    , mapTypeId: google.maps.MapTypeId.HYBRID
                    , disableDefaultUI: true
                    , draggable: false
                };
 
                var divMap = new google.maps.Map(div, divOptions);
                var divMarker = new google.maps.Marker({
                    position: marker.getPosition()
                    , map: divMap
                    , clickable: false
                });
 
                google.maps.event.addDomListener(root, 'click', function(){
                    popup.setZIndex(n++);
                });
            })
        })(n++, popup, marker);*/
			    
			    
        /*
		 (function(id, popup){
            google.maps.event.addListener(popup, 'domready', function(){
                google.maps.event.addDomListener(document.getElementById('contentInfoWindow' + id), 'click', function(){
                    popup.setZIndex(i++);
                });
            })
        })(i, this.popupsArray[i]);*/
			    
	    
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
   	
	///////////////////
	//DEFINICON DEL CONSTRUCTOR
    ///////////////////
	constructor: function(config){
	
		Phx.mapInterfaz.superclass.constructor.call(this,config);
		
		//si es tipo grilla editable tabien los inicia
    	this.definirComponentes();
    	//definir formulario tipo venatana
    	this.definirFormularioVentana();
		
		//definicion de la barra de meno
		this.defineMenu();

		// recorre todos los atributos de la pagina y va creando los
		// componentes para despues poder agregarlo al formulario de la pagina
		// Se prepara el contenido del store, formulario y grid
       
//
	//		this.definirComponentes();
    	
    	//definicion de la barra de meno
	/*	if(this.topBar){
    	  this.defineMenu();
		}*/

		//crea formulario
		/*
    	this.form = new Ext.form.FormPanel({
			id:this.idContenedor+'_W_F',
			autoShow:true,
			//frame:true,
			layout: 'form',
			region: 'center',
			labelWidth:80,
			fileUpload:this.fileUpload,
			
			items:this.Grupos,
			//bodyStyle: 'padding:0 10px 0;',
			//autoWidth:true,
			autoDestroy:true,
			autoScroll:true,
			autoDestroy:true,
			tbar:this.tbar,
			buttons:[{
				text: 'Guardar',
				handler:this.onSubmit,
				argument:{'news':false},
				scope:this},
				{
				text: 'Reset',
				handler:this.onReset,
				scope:this}
               ]
		});
		// preparamos regiones
     	this.regiones= new Array();
		this.regiones.push(this.form);
	    this.definirRegiones();*/
	
	}

});
