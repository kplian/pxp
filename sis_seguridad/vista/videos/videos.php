<!DOCTYPE html>

<html>
    <head>
        <title></title>

        <meta name="description" content="least.js is a Random &amp; Responsive jQuery, HTML 5 &amp; CSS3 Gallery with LazyLoad">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

        <link rel="author" href="https://plus.google.com/113595842256533600994" />

        <link href="css/style.min.css?22012014" rel="stylesheet" />
        <link href="css/least.min.css" rel="stylesheet" />
        <link href="css/prism.min.css" rel="stylesheet" />
        
        
         <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <link type="text/css"
		href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/redmond/jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.youtubepopup.min.js"></script>
    <script type="text/javascript">
		$(function () {
			$("a.youtube").YouTubePopup({ hideTitleBar: true,
					'youtubeId': '',
	'title': '',
	'useYouTubeTitle': true,
	'idAttribute': 'rel',
	'cssClass': '',
	'draggable': false,
	'modal': true,
	'width': 740,
	'height': 480,
	'hideTitleBar': false,
	'clickOutsideClose': false,
	'overlayOpacity': 0.5,
	'autohide': 2,
	'autoplay': 1,
	'color': 'red',
	'color1': 'FFFFFF',
	'color2': 'FFFFFF',
	'controls': 1,
	'fullscreen': 1,
	'loop': 0,
	'hd': 1,
	'showinfo': 0,
	'theme': 'light',
	'showBorder': true});
			
		});
    </script>
    
    
     <link href="http://ivaynberg.github.io/select2/select2-3.4.6/select2.css?ts=2014-04-05T09%3A05%3A31-07%3A00" rel="stylesheet"/>
<script src="http://ivaynberg.github.io/select2/select2-3.4.6/select2.js?ts=2014-04-05T09%3A05%3A31-07%3A00"></script>

 <script>
        $(document).ready(function() { $("#e1").select2(); });
    </script>
    
    </head>
    <body style="background-color: #CCCCCC;">

       
       <select id="e1" class="populate" style="width:300px; margin-top: -100px;" placeholder="select your beverage">
       	<option default>Selecciona el subsistema</option>
    </select>
    
        <!-- Geleria de Videos -->
        <section style="margin-top: -50px; background-color: #fff">
            <ul id="gallery">
			 </ul>
        </section>
        <!-- / Geleria de Videos -->
       
        
        
        
        <script src="js/least.min.js?03072013"></script>
        <script src="js/prism.js"></script>

        <script>
        $(document).ready(function(){
            $('#gallery').least();
            


            /* layer fade in */
            $('.layer').delay('5000').fadeIn();

            /* hide layer */
            $('.close').on(
                'click', 
                function(event) {
                    event.preventDefault();

                    $('.layer').fadeOut();
                }
            );

            $(document).keydown(function(event) {
                if(event.keyCode === 27){ $('.layer').fadeOut(); }
            });
        });
        </script>
        
        
        
        
        	
<script type="text/javascript">

	
	$.ajax({
		type: "POST",
		//url:"../../../../encomiendas/lib/lib_control/Intermediario.php", 
		url:"../../../lib/rest/seguridad/Subsistema/listarSubsistema",
		data: {"start":"0","limit":"100","sort":"id_subsistema","dir":"ASC"},
		 datatype: 'json',	
		success: function(resp)
		{  
	
				var ma = '';
				//var obj = jQuery.parseJSON(resp);*/
			
				 console.log(resp);
				 
				$.each(resp.datos, function(k, v) {
								
								console.log(v.nombre);
								
										
							ma += '<option value="'+v.id_subsistema+'">'+v.nombre+'</option>';

											
							});
											
				
			
			$("#e1").append(ma);
		}
		});
	
$('#e1').change(function(){
	
	var id_subsistema = $('#e1').val();
		$.ajax({
		type: "POST",
		url:"../../../lib/rest/seguridad/Video/listarVideo",
		data: {"start":"0","limit":"50","sort":"id_video","dir":"ASC","id_subsistema":id_subsistema},
		 datatype: 'json',	
		success: function(resp)
		{  
	
				var ma = '';
				
			
				 console.log(resp);
				 
				$.each(resp.datos, function(k, v) {
								
								console.log(v.url);
								
										
							ma += '<li>';
                    		ma += '<a class="youtube" rel="'+v.url+'" href="#" ></a>';
                    ma += '<img data-original="http://img.youtube.com/vi/'+v.url+'/1.jpg" src="img/effects/white.gif" width="240" height="150" alt="PXP" />';                    
                  ma += ' <div>'+v.titulo+'</div>';
                   ma += ' <div class="overLayer"></div>';
                   ma += ' <div class="infoLayer" style="color: #ccc">';
                     ma += '<ul>';
                           ma += '<li>';
                                ma += '<h2>';
                                    ma += ''+v.titulo+'';     
                                ma += '</h2>';
                            ma += '</li>';
                            ma += '<li>';
                                ma += '<p>';
                                   ma += v.descripcion;
                               ma += ' </p>';
                            ma += '</li>';
                        ma += '</ul>';
                    ma += '</div>';
                    
                    ma += '<p class="projectInfo">';
                        ma += '<strong>Day, Month, Year:</strong> sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.';
                    ma += '</p>';
                ma += '</li>';

											
							});
											
				
			$("#gallery").empty();
			$("#gallery").append(ma);
			
			
			$(document).ready(function(){
            $('#gallery').least();


            /* layer fade in */
            $('.layer').delay('100').fadeIn();
            
          $( ".infoLayer" ).hover(function() {
  $( this ).fadeOut( 100 );
  $( this ).fadeIn( 500 );
});

            /* hide layer */
            $('.close').on(
                'click', 
                function(event) {
                    event.preventDefault();

                    $('.layer').fadeOut();
                }
            );

            $(document).keydown(function(event) {
                if(event.keyCode === 27){ $('.layer').fadeOut(); }
            });
        });
        
        
			
			$(function () {
			$("a.youtube").YouTubePopup({ hideTitleBar: true,
					'youtubeId': '',
	'title': '',
	'useYouTubeTitle': true,
	'idAttribute': 'rel',
	'cssClass': '',
	'draggable': false,
	'modal': true,
	'width': 740,
	'height': 480,
	'hideTitleBar': false,
	'clickOutsideClose': false,
	'overlayOpacity': 0.5,
	'autohide': 2,
	'autoplay': 1,
	'color': 'red',
	'color1': 'FFFFFF',
	'color2': 'FFFFFF',
	'controls': 1,
	'fullscreen': 1,
	'loop': 0,
	'hd': 1,
	'showinfo': 0,
	'theme': 'light',
	'showBorder': true});
			
		});
		}
		});
	
})

</script>
        
        
    </body>
</html>
