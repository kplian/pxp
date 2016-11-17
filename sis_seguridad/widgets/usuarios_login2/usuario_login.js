
$(document).ready(function() {
  try {
		   //Load data from the server
		    function loadData() {
		    
			 
			   function drawGraph(resp) {
			    var data = resp.datos;
			    console.log('----------------------resp.datos',resp.datos)
			      Morris.Area({
			        element: 'wid-user',
			        data: data,
			        xkey: 'periodo',
			        ykeys: ['exito', 'error'],
			        labels: ['Exito', 'Error']
			      });
			      $('#loading').remove();
			    };
			    
			    $.ajax({
			                type: 'POST',
			                url: '../../../pxp/lib/rest/seguridad/Log/listarCantidadXTransaccion',
			                data: {start: "0", limit: "50",sort:'id_usuario',gestion:'2016',transaccion:'SEG_VALUSU_SEG'},
			                dataType: 'json',
			                async: true,
			                success: drawGraph
			            });
			    
			    
			    
			   
			
			    //Onresize method for adjust size
			    $(window).on('resize', function() {
			      //drawGraph(dataset);
			    });
			} 
			    //Init
		loadData();
		console.log('llega ....')
		  
  
  }
  
  catch (e){
    console.log('widget error', e);
  }
});