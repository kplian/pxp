
$(document).ready(function() {
    try {
        //Load data from the server
        function loadData() {


            function drawGraph(resp) {
                var data = resp.datos;
                //console.log(data);
                console.log('----------------------resp.datos',resp.datos)
                Morris.Donut({
                    element: 'wid-user',
                    data: data
                });
                $('#loading').remove();
            };

            $.ajax({
                type: 'POST',
                url: '../../../pxp/lib/rest/seguridad/Log/listarRest',
                data: {start: "0", limit: "50",sort:'id_reclamo',id_reclamo: 1},
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