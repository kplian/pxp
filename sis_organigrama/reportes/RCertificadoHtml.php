<?php
require_once(dirname(__FILE__).'/../../lib/tcpdf/tcpdf_barcodes_2d.php');
class RCertificadoHtml{
    var $html;
    function generarHtml ($datos) {
      
        setlocale(LC_ALL,"es_ES@euro","es_ES","esp");
        if ($datos['genero'] == 'Sr'){
            $tipo = 'al interesado';
            $gen = 'el';
            $tra = 'trabajor';
            $tipol = 'al interesado';
        }else{
            $tipo = 'a la interesada';
            $gen = 'la';
            $tra = 'trabajadora';
            $tipol = 'a la interesada';
        }

        $cadena = 'Numero Tramite: '.$datos['nro_tramite']."\n".'Fecha Solicitud: '.$datos['fecha_solicitud']."\n".'Funcionario: '.$datos['nombre_funcionario']."\n".'Firmado Por: '.$datos['jefa_recursos']."\n".'Emitido Por: '.$datos['fun_imitido'];
        $barcodeobj = new TCPDF2DBarcode($cadena, 'QRCODE,M');
        $this->html.='<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
					   "http://www.w3.org/TR/html4/strict.dtd">
					<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
						<title>&nbsp;&nbsp;</title>
						<meta name="author" content="kplian">
					  <link rel="stylesheet" href="../../../sis_ventas_facturacion/control/print.css" type="text/css" media="print" charset="utf-8">
					</head>
					<body>
					<br>
<br>
<table style="width: 100%;" border="0" >
<tbody>
<tr>
<td style="width: 130px;">&nbsp;</td>
<td><p style="text-align: center;"> <FONT FACE="Century Gothic" SIZE=6 ><u><b>CERTIFICADO</b></u></FONT></p></td>
<td style="width: 50px;">&nbsp;</td>
</tr>
<tr>
<td >&nbsp;</td>
<td><p style="text-align: justify"> <FONT FACE="Century Gothic" >La suscrita Lic. '.$datos['jefa_recursos'].' <b>Jefe de Recursos Humanos</b> de la Empresa Pública Nacional Estratégica "Boliviana de Aviación - BoA", a solicitud '.$tipo.'</FONT></p>
</td>
<td>&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><FONT FACE="Century Gothic" ><b>CERTIFICA:</b></FONT></td>
<td>&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><p style="text-align: justify"><FONT FACE="Century Gothic" >Que, de la revisión de la carpeta que cursa en el Área de Recursos Humanos, se evidencia que '.$gen.' <b>'.$datos['genero'].'. '.$datos['nombre_funcionario'].'</b> con C.I. '.$datos['ci'].' '.$datos['expedicion'].', ingresó a la Empresa Pública Nacional Estratégica "Boliviana de Aviación - BoA"
         el '.$this->fechaLiteral($datos['fecha_contrato']).', y actualmente ejerce el cargo de <b>'.$datos['nombre_cargo'].'</b>, dependiente de la '.$datos['nombre_unidad'].', con una remuneración mensual de Bs. '.number_format($datos['haber_basico'],2,",",".") .'.- ('.$datos['haber_literal'].' Bolivianos).</FONT></p>
</td>
<td>&nbsp;</td>
</tr>';
        if ($datos['tipo_certificado'] =='Con viáticos de los últimos tres meses') {
            $this->html .= '<tr>
<td>&nbsp;</td>
<td align="justify">
<FONT FACE="Century Gothic">Asimismo a solicitud expresa se informa que '.$gen.' '.$tra.' ha percibido en los últimos tres meses por concepto de viáticos un promedio mensual de '.number_format($datos['importe_viatico'],2,",",".").'.- ('.$datos['literal_importe_viatico'].' Bolivianos) aclarándose que el <b>Viático</b> es la suma que reconoce la empresa a la persona comisionada, <b>para cubrir gastos del viaje.</b></FONT>
</td>
<td>&nbsp;</td>
</tr>';
        }

        $this->html.='<tr>
<td>&nbsp;</td>
<td align="justify"><FONT FACE="Century Gothic">Es cuando se certifica, para fines de derecho que convengan '.$tipol.'.<br><br>Cochabamba '.$this->fechaLiteral($datos['fecha_solicitud']).'.</FONT>
</td>
<td>&nbsp;</td>
</tr>
</tbody>
</table>
<table style="width: 100%;" border="0">
<tbody>
<tr style="height: 80px;">
<td >&nbsp;</td>
<td></td>
<td align="right"><img src = "../../../sis_organigrama/media/firma.png" align= "right " width="120" height="120" title="impreso"/></td>
<td align="left">'.$barcodeobj->getBarcodeSVGcode(2, 2, 'black').' </td>
</tr>
<tr style="height: 38px;">
<td style="height: 38px; width: 14.3061%;">&nbsp;</td>
<td align="center"><FONT FACE="Century Gothic" SIZE=1 >GAG/'.$datos['iniciales'].'<br/>Cc/Arch</FONT>
<td style="height: 38px; width: 34%;">&nbsp;</td>
<td style="height: 38px; width: 10%;">&nbsp;</td>
</tr>
</tbody>
</table>

<script language="VBScript">
						Sub Print()
						       OLECMDID_PRINT = 6
						       OLECMDEXECOPT_DONTPROMPTUSER = 2
						       OLECMDEXECOPT_PROMPTUSER = 1
						       call WB.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER,1)
						End Sub
						document.write "<object ID="WB" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>"
</script>
						
						<script type="text/javascript"> 
						setTimeout(function(){
							 self.print();
							 
							}, 1000);					
						
						setTimeout(function(){
							 self.close();							 
							}, 2000);	
						</script> 
						
</body>
</html>';


            return  $this->html;
    }
    function fechaLiteral($va){
        setlocale(LC_ALL,"es_ES@euro","es_ES","esp");
        $fecha = strftime("%d de %B de %Y", strtotime($va));
        return $fecha;
    }
}
?>