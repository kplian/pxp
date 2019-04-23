// ?????????????????????????????????????????????????????????????????????? \\
// ? Favio Figueroa Penarrieta - JavaScript Library                     ?
// ?????????????????????????????????????????????????????????????????????? \\
// ? Copyright © 2014 Disydes (http://disydes.com)                      ?
// ?????????????????????????????????????????????????????????????????????? \\
// ? Vista para automatizar cualquier front end basado en jQuery        ? plugin para hacer peticiones ajax
// ?????????????????????????????????????????????????????????????????????? \\

(function ($) {
    $.tipo = '';
    $.aurl = '';




    //clientRestPxp._url('kerp_capacitacion/pxp/lib/rest/seguridad/Persona/listarPersonaFoto');
    
    console.log();



    ajax_dyd = {


        url: "",
        tarea:"",
        type: "POST",
        data: "",
        dataType: "",
        respuesta:"",
        x:"",
        p:"",
        async:true,

        headers:clientRestPxp._headers,
        timeout_:3000,
        countError:0,


        peticion_ajax : function (callback) {

            //console.log(this);
            $.ajax({
                type: this.type,
                url: clientRestPxp._url(this.url),
                //data: 'x='+this.data,
                data:this.data,
                // contentType: 'application/json; charset=utf-8',
                dataType: this.dataType,
                // processdata: true,
                async: this.async,
                headers:this.headers,
                timeout:this.timeout_,
                success: function (resp) {
                    // return resp;


                    if(typeof callback === "function") callback(resp);
                },
                error: function(x, t, m) {

                    /*if(t==="timeout") {
                        alert("Problemas de red , esta demorando demasiado la peticion, actualizar por favor");
                    } else {
                        alert(t+" actualizar por favor");
                    }*/

                    var error = new Object({
                        "estado":"error",
                        "x":x,
                        "t":t,
                        "m":m
                    });
                    if(typeof callback === "function") callback(error);

                }
            });

            //return this.respuesta;
        },


        sesionPXP : function (callback) {

            //console.log(this);
            $.ajax({
                type: this.type,
                url: clientRestPxp._url(this.url),
                //data: 'x='+this.data,
                data:this.data,
                // contentType: 'application/json; charset=utf-8',
                dataType: this.dataType,
                // processdata: true,
                async: this.async,
                //headers:this.headers,
                success: function (resp) {
                    // return resp;

                    console.log('llega resp')

                    if(typeof callback === "function") callback(resp);
                },
                done:function(resp) {
                    console.log('llega resp')
                },
                error : function (resp) {
                    console.log('error')
                    if(typeof callback === "function") callback(resp);
                }
            });

            //return this.respuesta;
        },


        peticion_intermediario : function (callback) {

            //console.log(this);
            $.ajax({
                type: this.type,
                url: this.url,
                //data: 'x='+this.data,
                data:'p='+this.p
                +'&x='+this.x,
                // contentType: 'application/json; charset=utf-8',
                dataType: this.dataType,
                // processdata: true,
                async: this.async,
                success: function (resp) {
                    // return resp;


                    if(typeof callback === "function") callback(resp);
                }
            });

            //return this.respuesta;
        },



        peticion_ajax_get : function (callback) {

            //console.log(this);
            $.ajax({
                type: this.type,
                url: this.url,
                //data: 'x='+this.data,
                data:this.data,
                // contentType: 'application/json; charset=utf-8',
                dataType: this.dataType,
                // processdata: true,
                async: this.async,
                success: function (resp) {
                    // return resp;


                    if(typeof callback === "function") callback(resp);
                }
            });

            //return this.respuesta;
        }
    };








})
(jQuery);