<?php
// Extend the TCPDF class to create custom MultiRow
class RTipoCcPdf extends  ReportePDF {
    var $datos_titulo;
    var $datos_detalle;
    var $ancho_hoja;
    var $gerencia;
    var $numeracion;
    var $ancho_sin_totales;
    var $cantidad_columnas_estaticas;
    var $s1;
    var $t1;
    var $tg1;
    var $total;
    var $datos_periodo;
    var $ult_codigo_partida;
    var $ult_concepto;



    function datosHeader ( $detalle) {
        $this->SetHeaderMargin(8);
        $this->SetAutoPageBreak(TRUE, 12);
        $this->ancho_hoja = $this->getPageWidth()-PDF_MARGIN_LEFT-PDF_MARGIN_RIGHT-10;
        $this->datos_detalle = $detalle;
        $this->subtotal = 0;
        $this->SetMargins(7, 30, 5);
    }

    function Header() {

        $this->Ln(3);

        //cabecera del reporte
        $this->Image(dirname(__FILE__).'/../../lib/imagenes/logos/logo.jpg', 10,5,35,20);
        $this->ln(5);

        $this->SetFont('','B',11);
        $this->Cell(0,5,"HISTORIAL DE MOVIMIENTOS",0,1,'C');


    }

    function generarReporte() {
        //$this->setFontSubsetting(false);
        $this->AddPage();

        $this->generarCuerpo($this->datos_detalle);

    }
    function generarCabecera(){

        //armca caecera de la tabla
        $conf_par_tablewidths=array(10,50,50,80,15,20,15,25);
        $conf_par_tablealigns=array('C','C','C','C','C','C','C','C');
        $conf_par_tablenumbers=array(0,0,0,0,0,0,0,0);
        $conf_tableborders=array();
        $conf_tabletextcolor=array();

        $this->tablewidths=$conf_par_tablewidths;
        $this->tablealigns=$conf_par_tablealigns;
        $this->tablenumbers=$conf_par_tablenumbers;
        $this->tableborders=$conf_tableborders;
        $this->tabletextcolor=$conf_tabletextcolor;

        //$this-> MultiRow($RowArray,false,1);

    }

    function generarCuerpo($detalle) {

        $count = 1;
        $sw = 0;
        $sw1 = 0;
        $this->ult_codigo_partida = '';
        $this->ult_concepto = '';
        $fill = 0;

        $this->total = count($detalle);

        $this->s1 = 0;
        $this->t1 = 0;
        $this->tg1 = 0;
        $arrayOperaciones=array("add" => "INSERCIÓN", "mod" => "MODIFICACIÓN", "del" => "ELIMINACIÓN");
        $arrayParametros=array("tipo" => "Tipo de Aplicacion: ", "id_ep" => "EP: ", "codigo" => "Codigo: ", "mov_pres" => "Ingreso / Egreso: ",
                              "operativo" => "Operativo: ", "movimiento" => "Transaccional: ", "descripcion" => "Descripcion: ", "fecha_inicio" => "Fecha inicio: ",
                              "fecha_final" => "Fecha final: ", "momento_pres" => "Momentos: ", "id_tipo_cc_fk" => "Padre: ", "control_partida" => "Controlar Partida: ",
                              "control_techo" => "Techo: ");

        $TipoCcList2 = Array();
        $TipoCcList = Array();
        for ($fe = 0; $fe < count($detalle); $fe++) {
            $value = $detalle[$fe];
            if(!in_array($value['id_tipo_cc'], $TipoCcList2)){
                $TipoCcList2[] = $value['id_tipo_cc'];
                $TipoCcList[] = array("id_tipo_cc" => $value['id_tipo_cc'],"titulo_cc" => $value['codigo_padre'].' - '.$value['descripcion']);
            }
        }

        for ($fi = 0; $fi < count($TipoCcList); $fi++) {
            $title = $TipoCcList[$fi];
            $tbl = '';
            $tbl .= '
                        <table border="1" style="font-size: 7pt; padding: 4px; margin-left: 50px;">
                        <tr align="center" style="background-color: #34495E; color: white;">
                            <td width="10%"><b>TIPO CC</b></td>
                            <td colspan="4"><b>'.$title['titulo_cc'].'</b></td>
                        </tr>
                        <tr align="center" style="background-color: #34495E; color: white;">
                            <td><b>FECHA Y HORA</b></td>
                            <td width="20%"><b>USUARIO</b></td>
                            <td width="10%"><b>OPERACIÓN</b></td>
                            <td colspan="2" width="50%"><b>DETALLE DE MOVIMIENTO (ANTIGUO | NUEVO)</b></td>
                        </tr>
                     ';

            for ($fe = 0; $fe < count($detalle); $fe++) {
                $this->SetLeftMargin(38);
                $value = $detalle[$fe];
                $antiguo = (array) json_decode($value['datos_antiguo'], true);
                $nuevo = (array) json_decode($value['datos_nuevo'], true);
                $parametrosLista = $this->parametros($antiguo, $nuevo, $value['operacion']);
                $i = 0;

                if($value['id_tipo_cc'] == $title['id_tipo_cc']){

                    if(!is_null($value['id_historico'])){
                        $tbl .= '
                        <tr align="center">
                            <td rowspan="'.count($parametrosLista).'">'.date_format(new DateTime($value['fecha_reg']), 'Y-m-d  H:i:s').'</td>
                            <td rowspan="'.count($parametrosLista).'">'.$value['desc_persona'].'</td>
                            <td rowspan="'.count($parametrosLista).'">'.$arrayOperaciones[$value['operacion']].'</td>
                              ';
                        foreach ($parametrosLista as $k => $v) {
                            if($i != 0){
                                $tbl .= '<tr align="center">';
                            }
                            if($value['operacion'] == 'mod'){
                                $tbl .= '
                            <td>'.$arrayParametros[$k].$v.'</td>
                            <td>'.$arrayParametros[$k].$nuevo[$k].'</td>
                            </tr>
                            ';
                            }else{
                                $tbl .= '
                                            <td></td>
                                            <td>'.$arrayParametros[$k].$v.'</td>
                                            </tr>
                            ';
                            }
                            $i++;
                        }
                    }else{
                        $tbl .= '
                        <tr align="center">
                            <td colspan="5"><b>SIN BITACORA</b></td>
                        </tr>
                     ';
                    }
                }
            }

            $tbl .= '</table>';
            $this->writeHTML ($tbl);
        }
    }

    function parametros($antiguo, $nuevo, $type){
        $lista = array();
        if($type == 'mod'){
            foreach ($antiguo as $k => $v) {
                if( $v != $nuevo[$k])
                    $lista[$k] = $antiguo[$k];
            }
        }else{
            $lista = $nuevo;
        }
        return $lista;
    }

}
?>