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
      	{label:'2016', value:'300'},
      	{label:'2015', value:'400'},
        {label:'2014', value:'200'},
        {label:'2013', value:'100'},

      ];
      drawGraph(dataset);
    }

    function drawGraph(data) {
      Morris.Donut({
        element: 'dash-pxp',
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