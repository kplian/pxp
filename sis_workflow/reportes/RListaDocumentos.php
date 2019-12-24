<?php
/*
 HISTORIAL DE MODIFICACIONES:
ISSUE   FORK        FECHA       AUTHOR        DESCRIPCION
#98     EndeEtr     24/12/2019  JUAN          Reporte de lista de documentos en workflow con letras mas grandes
*/

/* #98 INICIO*/	
class RListaDocumentos extends  ReportePDF {
	var $datos_titulo;
	var $datos_detalle;
	var $ancho_hoja;
	var $gerencia;
	var $numeracion;
	var $ancho_sin_totales;
	var $cantidad_columnas_estaticas;
	var $s1;
	var $s2;
	var $s3;
	var $s4;
	var $s5;
	var $s6;
	var $t1;
	var $t2;
	var $t3;
	var $t4;
	var $t5;
	var $t6;
	var $total;
	var $datos_entidad;
	var $datos_periodo;

	function datosHeader ( $detalle, $totales) {
        $this->SetHeaderMargin(8);
        $this->SetAutoPageBreak(TRUE, 10);
		$this->ancho_hoja = $this->getPageWidth()-PDF_MARGIN_LEFT-PDF_MARGIN_RIGHT-10;
		$this->datos_detalle = $detalle;
		$this->datos_titulo = $totales;
		$this->datos_entidad = $entidad;
		$this->datos_periodo = $periodo;
		$this->subtotal = 0;
		//$this->SetMargins(20, 59, 5);
		$this->SetMargins(50, 59, 5);
	}
	
	function Header() {
		
		$white = array('LTRB' =>array('width' => 0.3, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(255, 255, 255)));
        $black = array('T' =>array('width' => 0.3, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0)));
        
		
		$this->Ln(3);
		//formato de fecha
		
		//cabecera del reporte
		$this->Image(dirname(__FILE__).'/../../lib/imagenes/logos/logo.jpg', 50,5,40,20);
		$this->ln(5);
		
		
	    $this->SetFont('','B',12);		
		$this->Cell(150,5,"DOCUMENTOS",0,1,'C');		

		
		$this->SetFont('','',10);
		
		$height = 5;
        $width1 = 5;
		$esp_width = 5;
        $width_c1= 55;
		$width_c2= 112;
        $width3 = 40;
        $width4 = 75;
		
		$this->Ln(8);

        $tramite="";
        $proceso="";
		foreach ($this->datos_detalle as $val) {
			$tramite=$val['nro_tramite'];
			$proceso=$val['codigo_proceso'];
		}

		$this->Cell($width1, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $this->Cell($width_c1, $height, 'Numero Tramite:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $this->SetFont('', '');
        $this->SetFillColor(192,192,192, true);
        $this->Cell($width_c2, $height, $tramite, 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $this->Ln(5);

		$this->Cell($width1, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $this->Cell($width_c1, $height, 'Codigo proceso:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $this->SetFont('', '');
        $this->SetFillColor(192,192,192, true);
        $this->Cell($width_c2, $height, $proceso, 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$this->Ln(21);
	
		
		$this->SetFont('','B',6);
		$this->generarCabecera();
	}
	
	function Footer() {
		
		$this->setY(-15);
		$ormargins = $this->getOriginalMargins();
		$this->SetTextColor(0, 0, 0);
		//set style for cell border
		$line_width = 0.85 / $this->getScaleFactor();
		$this->SetLineStyle(array('width' => $line_width, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0)));
		$ancho = round(($this->getPageWidth() - $ormargins['left'] - $ormargins['right']) / 3);
		$this->Ln(2);
		$cur_y = $this->GetY();
		
		$this->Cell($ancho, 0, '', '', 0, 'L');
		$pagenumtxt = 'Página'.' '.$this->getAliasNumPage().' de '.$this->getAliasNbPages();
		$this->Cell($ancho, 0, $pagenumtxt, '', 0, 'C');
		$this->Cell($ancho, 0, '', '', 0, 'R');
		$this->Ln();
		$fecha_rep = date("d-m-Y H:i:s");
		$this->Cell($ancho, 0, '', '', 0, 'L');
		$this->Ln($line_width);
				
	
	}
	
   
   function generarReporte() {
		$this->setFontSubsetting(false);
		$this->AddPage();
		
	    $sw = false;
		$concepto = '';
		
		$this->generarCuerpo($this->datos_detalle);
		
		if($this->s1 != 0){
			$this->SetFont('','B',6);
			//$this->cerrarCuadro();	
			// para el ultimo
		    //$this->cerrarCuadroTotal();
		}
		
		$this->Ln(4);
		
		
	} 
    function generarCabecera(){
    	
		
		
		//arma cabecera de la tabla  17  - 13   20   -    ;  (15,  14  21,   2,,4,6)
		$conf_par_tablewidths=array(10,30,60,70);
        $conf_par_tablealigns=array('C','C','C','C');
        $conf_par_tablenumbers=array(0,0,0,0);

        $conf_tableborders=array();
        $conf_tabletextcolor=array();
		
		$this->tablewidths=$conf_par_tablewidths;
        $this->tablealigns=$conf_par_tablealigns;
        $this->tablenumbers=$conf_par_tablenumbers;
        $this->tableborders=$conf_tableborders;
        $this->tabletextcolor=$conf_tabletextcolor;
		$this->SetFont('','B',8);

        $RowArray = array(
        		's0' => 'Nº',
        		's2' => "Doc. Digital",        //ingreso_colectas
        		's4' => 'Nombre Doc.',
        		's5' => 'Descripcion Proceso');
		
		$this->MultiRow($RowArray, false, 1);
    }
	
	function generarCuerpo($detalle){
		
		$count = 1;
		$sw = 0;
		$ult_region = '';
		$fill = 0;
		
		$this->total = count($detalle);
		$this->s1 = 0;
		$this->s2 = 0;
		$this->s3 = 0;
		$this->s4 = 0;
		$this->s5 = 0;
		$this->s6 = 0;
		foreach ($detalle as $val) {
			$this->imprimirLinea($val,$count,$fill);
			$count = $count + 1;
			$this->total = $this->total -1;
			$this->revisarfinPagina();
		}
	}	
	
	function imprimirLinea($val,$count,$fill){
	
		$fill = !$fill;

		$this->SetFillColor(255, 255, 255);
		$this->SetTextColor(0);
		$this->SetFont('','',8);
       

		$conf_par_tablewidths=array(10,30,60,70);
        $conf_par_tablealigns=array('C','C','C','C');
        $conf_par_tablenumbers=array(0,0,0,0);

        $conf_tableborders=array();
        $conf_tabletextcolor=array();
		
		$this->tablewidths=$conf_par_tablewidths;
        $this->tablealigns=$conf_par_tablealigns;
        $this->tablenumbers=$conf_par_tablenumbers;
        $this->tableborders=$conf_tableborders;
        $this->tabletextcolor=$conf_tabletextcolor;
		

		$RowArray = array(
            			's0'  => $count,
                        's2' => $val['chequeado'] ,
                        's4' => $val['nombre_tipo_documento'] ,
                        's5' => $val['descripcion_proceso_wf'] 
						);
		

		$this-> MultiRow($RowArray,$fill,1);
			
	}


    function revisarfinPagina(){
		$dimensions = $this->getPageDimensions();
		$hasBorder = false; //flag for fringe case
		
		$startY = $this->GetY();
		$this->getNumLines($row['cell1data'], 80);

        if ($startY > 190) {

            //$this->cerrarCuadro();
            //$this->cerrarCuadroTotal();

            if($this->total!= 0){
                $this->AddPage();
            }

        }


    }
	
	
	
	function caclularMontos($val){

	}
    function cerrarCuadro(){

	
    }

    function cerrarCuadroTotal(){

    }
  
 
}
/* #98 FIN*/	
?>
