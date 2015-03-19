
	<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite 
*el inico de procesos de compra a partir de las solicitude aprobadas
*
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoDocumentoEstadoWF = {
    bedit: false,
    bnew:  false,
    bsave: false,
    bdel:  false,
    require: '../../../sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstado.php',
    requireclase: 'Phx.vista.TipoDocumentoEstado',
    title: 'Estados...',
    constructor: function(config) {
    	Phx.vista.TipoDocumentoEstadoWF.superclass.constructor.call(this,config);
    }
  };
</script>  	