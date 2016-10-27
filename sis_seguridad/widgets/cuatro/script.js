'use strict';
$(document).ready(function() {
  try {
    var restServer = localStorage.getItem('server') + 'api/';
    //var restServer = 'http://192.168.88.213:3100/api/';
    var consumeRest = 'DgrpEntradas/abiertasXtipo';
    var dataset;

    //Load data from the server

    function loadData() {
      /*$.ajax({
        url: restServer + consumeRest
      }).then(function(data) {
        dataset = data;
        drawGraph(dataset);
      });*/
      dataset=[
          { y: '2006', a: 100, b: 90 },
          { y: '2007', a: 75,  b: 65 },
          { y: '2008', a: 50,  b: 40 },
          { y: '2009', a: 75,  b: 65 },
          { y: '2010', a: 50,  b: 40 },
          { y: '2011', a: 75,  b: 65 },
          { y: '2012', a: 100, b: 90 }
        ];
      drawGraph(dataset);
    }

    function drawGraph(data) {
      Morris.Bar({
        element: 'dash-pxp',
        data: data,
        xkey: 'y',
        ykeys: ['a', 'b'],
        labels: ['Series A', 'Series B']
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