'use strict';
$(document).ready(function() {
  try {
    var restServer = 'http://192.168.88.213:3100/api/';
    var service = 'DgrpEntradas/abiertasXtipo';
    var dataset;

    //Load data from the server
    function loadData() {
      /*$.ajax({
        url: restServer + service
      }).then(function(resp) {
        dataset = resp;
        drawGraph(dataset);
      });*/

      dataset= [
        {label: "Usuarios bloqueados", value: 12},
        {label: "Usuarios logueados", value: 30},
        {label: "Usuarios activos", value: 20}
      ];
      drawGraph(dataset);
    }

    function drawGraph(data) {
      Morris.Donut({
        element: 'wid-user',
        data: data,
        resize: true,
        redraw: true
      });
    };

    //Onresize method for adjust size
    $(window).on('resize', function() {
      //drawGraph(dataset);
    });

    //Init
    loadData();
  } catch (e){
    console.log('widget error', e);
  }
});