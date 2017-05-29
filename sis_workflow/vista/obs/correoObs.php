<?php
/**
 *@package pXP
 *@file    SolModPresupuesto.php
 *@author  Rensi Arteaga Copari
 *@date    30-01-2014
 *@description permites subir archivos a la tabla de documento_sol
 */
header("content-type: text/javascript; charset=UTF-8");
?>

<script>
    Phx.vista.correoObs=Ext.extend(Phx.frmInterfaz,{
        ActSave:'../../sis_workflow/control/Obs/SolicitarCierreObs',

        constructor:function(config){

            this.maestro = config;
            Phx.vista.correoObs.superclass.constructor.call(this,config);
            this.init();
            this.loadValoresIniciales();
            //this.obtenerCorreo();


        },

        /*obtenerCorreo:function(){
         Phx.CP.loadingShow();
         Ext.Ajax.request({
         // form:this.form.getForm().getEl(),
         url:'../../sis_organigrama/control/Funcionario/getEmailEmpresa',
         params:{id_funcionario: this.id_funcionario},
         success:this.successSinc,
         failure: this.conexionFailure,
         timeout:this.timeout,
         scope:this
         });


         },


         successSinc:function(resp){
         Phx.CP.loadingHide();
         var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
         if(reg.ROOT.datos.resultado!='falla'){
         if(!reg.ROOT.datos.email_notificaciones_2){

         alert('Confgure el EMAIL de notificaciones 1, en el archivo de datos generales');
         }

         this.getComponente('email').setValue(reg.ROOT.datos.email_notificaciones_2);
         this.getComponente('email_cc').setValue(reg.ROOT.datos.email_empresa);

         }else{
         alert(reg.ROOT.datos.mensaje)
         }
         },*/

        Atributos:[
            {
                config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_solicitud'
                },
                type:'Field',
                form:true
            },
            {
                config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'estado'
                },
                type:'Field',
                form:true
            },



            {
                config:{
                    name: 'email',
                    fieldLabel: 'Para',
                    allowBlank: true,
                    anchor: '90%',
                    gwidth: 100,
                    maxLength: 100,
                    readOnly :false
                },
                type:'TextField',
                id_grupo:1,
                form:true
            },
            {
                config:{
                    name: 'email_cc',
                    fieldLabel: 'CC',
                    allowBlank: true,
                    anchor: '90%',
                    gwidth: 100,
                    maxLength: 100,
                    readOnly :false
                },
                type:'TextField',
                id_grupo:1,
                form:true
            },
            {
                config:{
                    name: 'asunto',
                    fieldLabel: 'Asunto',
                    allowBlank: true,
                    anchor: '90%',
                    gwidth: 100,
                    maxLength: 100
                },
                type:'TextField',
                id_grupo:1,
                form:true
            },
            {
                config:{
                    name: 'body',
                    fieldLabel: 'Mensaje',
                    anchor: '90%'
                },
                type:'HtmlEditor',
                id_grupo:1,
                form:true
            },



        ],
        title:'Sol. de Cierre Observación',

        loadValoresIniciales:function()
        {
            console.log('mastercool:',this.maestro);
            //var record =  this.sm.getSelected().data;
            var recordParent = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
            //console.log('vanesa',recordParent);
            this.getComponente('email').setValue(recordParent.email_empresa);
            var CuerpoCorreo = " <b>Observación Resuelta<br></b><br>" ;
            CuerpoCorreo+= '<b>Estimad@: <br>'+ recordParent.desc_fun_obs+'<br></b> Se procedio a dar cumplimiento a las observaciones hechas al: <br>';
            CuerpoCorreo+='<b>Tramite: </b>'+ this.num_tramite+'<br>';
            CuerpoCorreo+='<b>Numero: </b>'+this.numero+'</BR> Deseandole mucho exito en sus actividades , se procedio a cerrar su Observación para dar seguimiento a este Tramite. <br>';
            CuerpoCorreo+='<br>Resuelto por: <br> '+Phx.CP.config_ini.nombre_usuario+'<br>';//solicito encarecidamente cerrar su Observación y dar seguimiento a este Tramite.


            Phx.vista.correoObs.superclass.loadValoresIniciales.call(this);



            //this.getComponente('id_cotizacion').setValue(this.id_cotizacion);


            this.getComponente('asunto').setValue('ADQ: Solicitud de Cierre de Observación: '+this.numero);
            this.getComponente('body').setValue(CuerpoCorreo);

            this.getComponente('id_solicitud').setValue(this.id_solicitud);
            this.getComponente('estado').setValue(this.estado);

        },

        /*onSubmit: function (o,x, force) {
            var id_obs  = this.maestro.id_obs;
            Ext.Ajax.request({
             url:'../../sis_workflow/control/Obs/cerrarObs',
             params: { id_obs: id_obs },
             success: function (resp) {
                 //var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                 console.log('EXITO');
             },
             failure: this.conexionFailure,
             timeout: this.timeout,
             scope: this
             });
            Phx.vista.correoObs.superclass.onSubmit.call(this, o);
        },*/

        /*successObs: function(resp){
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                this.reload();
            }
        },*/

        successSave:function(resp)
        {
            var id_obs  = this.maestro.id_obs;
            Ext.Ajax.request({
                url:'../../sis_workflow/control/Obs/cerrarObs',
                params: { id_obs: id_obs },
                success: function (resp) {
                    //var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                    console.log('EXITO');
                },
                failure: this.conexionFailure,
                timeout: this.timeout,
                scope: this
            });
            Phx.CP.loadingHide();
            Phx.CP.getPagina(this.idContenedorPadre).reload();
            this.panel.close();
        }

    })
</script>