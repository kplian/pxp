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
      });

      dataset= [
        {label: "Usuarios bloqueados", value: 12},
        {label: "Usuarios logueados", value: 30},
        {label: "Usuarios activos", value: 20}
      ];
      drawGraph(dataset);*/

      clientRestPxp.setCredentialsPxp('admin', md5('123'));
      var contra = clientRestPxp._user;

      config.tipo_ruta = "IP";
      config.IP.ip = 'tienda.kplian.com';
      config.IP.carpeta = 'kerp';
      config.init();

      ajax_dyd.data = {usuario: 'admin', contrasena:contra};
      ajax_dyd.type = 'POST';
      ajax_dyd.url = 'pxp/lib/rest/seguridad/Auten/verificarCredenciales';
      ajax_dyd.dataType = 'json';
      ajax_dyd.async = true;
      
      ajax_dyd.sesionPXP(function (resp) {
          if(resp&&resp.success){
              console.log('good',resp);
              ajax_dyd.data = {start: "0", limit: "50",sort:'id_usuario',gestion:'2016',transaccion:'SEG_VALUSU_SEG'};
              ajax_dyd.type = 'POST';
              //ajax_dyd.url = 'pxp/lib/rest/seguridad/Usuario/ListarUsuario';
              ajax_dyd.url = 'pxp/lib/rest/seguridad/Log/listarCantidadXTransaccion';
              ajax_dyd.dataType = 'json';
              ajax_dyd.async = true;
              ajax_dyd.peticion_ajax(function (callback) {
                drawGraph(callback.datos);
              })
          } else {
              console.log('Credenciales invalidas');
          }
      });
    }

    function drawGraph(data) {
      Morris.Area({
        element: 'wid-user',
        data: data,
        xkey: 'periodo',
        ykeys: ['exito', 'error'],
        labels: ['Exito', 'Error']
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
