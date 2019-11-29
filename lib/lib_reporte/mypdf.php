<?php
// Extend the TCPDF class to create custom MultiRow
//#64	ETR		10.10.2019		MZM		Modificar el number_format miles con punto, decimales con coma
//#69	ETR		29.10.2019		MZM		Modificacion para que cuando el valor 0 se omita y vaya el campo en vacio
//#77	ETR		15.11.2019		MZM		Interlineado
//#84	ETR		15.11.2019		MZM		Interlineado
//#87	ETR		20.11.2019		MZM							Cambio en paginacion de comboRec PERIODO
class MYPDF extends TCPDF {
    //Page header
    var $tablewidths=array();
	var $tablealigns=array();
	var $tablenumbers=array();
	var $tableborders=array();
	var $tabletextcolor=array();
	
	var $tablewidthsHD=array();
	var $tablealignsHD=array();
	var $tablenumbersHD=array();
	var $tablebordersHD=array();
	var $tabletextcoloHDr=array();
	
	/* RAC
	 * 05/01/2017
	 * Dibuja la fila calculando de manera exacta la altura 
	 * este metodo es mas lento que MultiRow,  por que usa startTransaction 
	 *
	 * */
	 public function MultiRow2($row, $fill = false, $border = 1, $textcolor = array(0,0,0), $aux  = 0) {    	
        $index = 0;
		$index_aux = 0;
		$height_base = 3;
		$height_aux = 0;
		$sw = true;
		//$page_aux = 0;
		//$y_pos_aux = 0;
		$column_aux = '';
		//$page_ini = $this->getPage();
		$numbers = false;
		if (count ($this->tablenumbers) > 0 ) {
			$numbers = true;
		}	
		
		
		/****************************************************
		 * IMPRIME LA FILA 
		 ****************************************************/
		 if($aux == 0){
			 $this->startTransaction(); 
			 $start_page = $this->getPage();   
		 }
		 $start_y = $this->GetY();
		 $aux_end_y = $start_y;
		 $end_y = $start_y;
		
		foreach ($row as $data) {			
		
            if ($numbers && $this->tablenumbers[$index] > 0) {
            	$data = number_format ( $data , $this->tablenumbers[$index] , '.' , ',' );
            }	
			
			if($sw){
				
				if($aux == 0 ){
				    $height_aux = $this->getHeightV4($data, $this->tablewidths[$index]);
				}
				else{
					$height_aux = $aux;
				}
				$this->CheckPageBreak($height_aux);
				$sw = false;
			}			
			
			 	
			//definicion de border
			$border_final = (isset($this->tableborders[$index])?$this->tableborders[$index]:$border);						
			//definicion de cambio de color
			$textcolor_final = (isset($this->tabletextcolor[$index])?$this->tabletextcolor[$index]:$textcolor);				
			$this->setTextColorArray($textcolor_final);			
			$this->MultiCell($this->tablewidths[$index], $height_aux, $data, $border_final,$this->tablealigns[$index], $fill, 2);
			$index++;
			
			$aux_end_y = $this->GetY(); 
			if($aux_end_y - $start_y > $end_y - $start_y){
				$end_y = $aux_end_y;
			}
			$this->SetY($start_y, false);
			//echo '$start_y='.$start_y.'..$end_y='.$end_y. '  $aux_end_y='.$aux_end_y.'  $height_aux='.$height_aux;
			//echo "\n";
        }
		
		
		$end_page = $this->getPage(); 
		if($aux == 0){
				$aux_tam = $this->calcularTamano($end_page,$start_page,$end_y,$start_y);			    
				if($aux_tam > $height_aux  ){
					$this->rollbackTransaction(true);
					$this->MultiRow2($row, $fill, $border , $textcolor , $aux_tam);
					$this->ln();
				}
				else{
					$this->commitTransaction();
					$this->ln();
					
				}
		}else{
			$this->ln();
		}
		
    }

    public function calcularTamano($end_page,$start_page,$end_y,$start_y){
    	$height = 0;	
    	if ($end_page == $start_page) {
			$height = $end_y - $start_y; 
		} else {
			for ($page=$start_page; $page <= $end_page; $page++) {
				    $this->setPage($page); 
				 	if ($page == $start_page) {
				 		 $height = $this->h - $start_y - $this->bMargin; 						 
					} elseif ($page == $end_page) {
						 $height = $height + $end_y - $this->tMargin; 
					} else {
						 $height = $height + $this->h - $this->tMargin - $this->bMargin; 
					} 
			} 
		}
		return $height;
    }


	public function getHeight($w=0, $h=0, $txt, $border=1, $align='L', $fill=false, $ln=1, $x='', $y='', $reseth=true, $stretch=0, $ishtml=false, $autopadding=true, $maxh=0) {
		// store current object 
        $this->startTransaction(); 
        //$res = array();
        // store starting values 
        $start_y = $this->GetY(); 
		//echo $start_y.'       ';
        $start_page = $this->getPage(); 
		//echo $start_page.' ';
        // call your printing functions with your parameters
		$this->MultiCell($w, $h, $txt, $border, $align, $fill, $ln, $x, $y, $reseth, $stretch, $ishtml, $autopadding, $maxh);
		// get the new Y 
		$end_y = $this->GetY(); 
		$end_page = $this->getPage(); 
		$resp[0] = $end_y;
		$resp[1] = $end_page;
		
		// calculate height 
		$height = 0; 
		if ($end_page == $start_page) {
			$height = $end_y - $start_y; 
		} else {
			for ($page=$start_page; $page <= $end_page; $page++) {
				 $this->setPage($page); 
				 	if ($page == $start_page) {
				 		 // first page 
				 		 $height = $this->h - $start_y - $this->bMargin; 						 
					} elseif ($page == $end_page) {
						 // last page 
						 $height = $height + $end_y - $this->tMargin; 
					} else {
						 $height = $height + $this->h - $this->tMargin - $this->bMargin; 
					} 
			} 
		} 
		$resp[2] = $height;
		// restore previous object 
		$this->rollbackTransaction(true);		
		return $resp;
	}
	
    public function MultiRow($row, $fill = false, $border = 1, $textcolor = array(0,0,0)) {    	
        $index = 0;
		$index_aux = 0;
		$height_base = 3;
		$height_aux = 0;
		//$page_aux = 0;
		//$y_pos_aux = 0;
		$column_aux = '';
		//$page_ini = $this->getPage();
		$numbers = false;
		if (count ($this->tablenumbers) > 0 ) {
			$numbers = true;
		}	
		
		/*****************************************************
		 *   RECUPERA EL TAMAÑO DE LA COLUMNA MAS ALTA
		 *   
		 *****************************************************/
		
        foreach ($row as $column) {
            if ($numbers && $this->tablenumbers[$index] > 0) {
            	$column = number_format ( $column , $this->tablenumbers[$index] , '.' , ',' );
            }
			//$datos_res = $this->getHeight($this->tablewidths[$index], $height_base, $column, $border);			
			$datos_res = $this->getHeightV2($column, $this->tablewidths[$index]);
			 
			 if ($datos_res > $height_aux) {
				$height_aux = $datos_res;
				$index_aux = $index;
				$column_aux = $column;
				
			 }
			
				
			$index++;
			
        }
		
		
		////////RAC 04/01/2016  temporalmente completado ...esta linea hace lentos los reportes
		//$resp = $this->getHeight($this->tablewidths[$index_aux], $height_base, $column_aux, $border);
		//$height_aux = $resp[2];
		
		//RAC 04/01/2016... buscar una alternativa para calcular a altur amaxima de las columnas
		$height_aux = $this->getHeightV3($column_aux, $this->tablewidths[$index_aux]) * $height_aux;
		
		
		
		$this->CheckPageBreak($height_aux);
		$index = 0;
		
		//echo $height_aux;
		//exit;
		
		//var_dump($row); exit;
		
		/****************************************************
		 * 
		 *    IMPRIME LA FILA CON LA ALTUR AENCONTRADA
		 * 
		 ****************************************************/
		foreach ($row as $data) {			
		
            if ($numbers && $this->tablenumbers[$index] > 0) {
            	$data = number_format ( $data , $this->tablenumbers[$index] , '.' , ',' );
            }			
			//definicion de border
			$border_final = (isset($this->tableborders[$index])?$this->tableborders[$index]:$border);						
			//definicion de cambio de color
			$textcolor_final = (isset($this->tabletextcolor[$index])?$this->tabletextcolor[$index]:$textcolor);				
			$this->setTextColorArray($textcolor_final);			
			$this->MultiCell($this->tablewidths[$index], $height_aux, $data, $border_final,$this->tablealigns[$index], $fill, 0, '','' , true);
			$index++;
			
        }
		
		$this->ln();
    }

/*
 * Autor: RAC
 * Fecha: 21/03/2017
 * Desc: Multifila para el header para evitar que los aprametros de acho, y demas estilos se sobrepongan
 * 
 * */
    public function MultiRowHeader($row, $fill = false, $border = 1, $textcolor = array(0,0,0)) {    	
        $index = 0;
		$index_aux = 0;
		$height_base = 3;
		$height_aux = 0;
		//$page_aux = 0;
		//$y_pos_aux = 0;
		$column_aux = '';
		//$page_ini = $this->getPage();
		$numbers = false;
		if (count ($this->tablenumbersHD) > 0 ) {
			$numbers = true;
		}	
		
		/*****************************************************
		 *   RECUPERA EL TAMAÑO DE LA COLUMNA MAS ALTA
		 *   
		 *****************************************************/
		
        foreach ($row as $column) {
            if ($numbers && $this->tablenumbers[$index] > 0) {
            	$column = number_format ( $column , $this->tablenumbersHD[$index] , '.' , ',' );
            }
			$datos_res = $this->getHeightV2($column, $this->tablewidthsHD[$index]);			 
			 if ($datos_res > $height_aux) {
				$height_aux = $datos_res;
				$index_aux = $index;
				$column_aux = $column;				
			 }
			$index++;
			
        }		
		
		////////RAC 04/01/2016  temporalmente completado ...esta linea hace lentos los reportes
		//$resp = $this->getHeight($this->tablewidths[$index_aux], $height_base, $column_aux, $border);
		//$height_aux = $resp[2];
		
		//RAC 04/01/2016... buscar una alternativa para calcular a altur amaxima de las columnas
		$height_aux = $this->getHeightV3($column_aux, $this->tablewidthsHD[$index_aux]) * $height_aux;
		
		
		
		$this->CheckPageBreak($height_aux);
		$index = 0;
		
		//echo $height_aux;
		//exit;
		
		//var_dump($row); exit;
		
		/****************************************************
		 * 
		 *    IMPRIME LA FILA CON LA ALTUR AENCONTRADA
		 * 
		 ****************************************************/
		foreach ($row as $data) {			
		
            if ($numbers && $this->tablenumbersHD[$index] > 0) {
            	$data = number_format ( $data , $this->tablenumbersHD[$index] , '.' , ',' );
            }			
			//definicion de border
			$border_final = (isset($this->tablebordersHD[$index])?$this->tablebordersHD[$index]:$border);						
			//definicion de cambio de color
			$textcolor_final = (isset($this->tabletextcolorHD[$index])?$this->tabletextcolorHD[$index]:$textcolor);				
			$this->setTextColorArray($textcolor_final);			
			$this->MultiCell($this->tablewidthsHD[$index], $height_aux, $data, $border_final,$this->tablealignsHD[$index], $fill, 0, '','' , true);
			$index++;
			
        }
		
		$this->ln();
    }

 	//#77 //#84
	public function UniRow($row, $fill = false, $border = 1, $alto=5,$textcolor = array(0,0,0)) {    	//#77
        //$index = 0;
		//$height_base = 3;
		//$height_aux = 0;
		//$page_aux = 0;
		//$y_pos_aux = 0;
			
		$index = 0;
		$numbers = false;
		if (count ($this->tablenumbers) > 0 ) {
			$numbers = true;
		}	
		foreach ($row as $data) {
		    if ($numbers && $this->tablenumbers[$index] > 0) {
		    	if($data == 0){//#69
            		$data='';
            	}else{
            		$data = number_format ( $data , $this->tablenumbers[$index] , '.' , ',' );//#64	//#87
            	}
				
            	
            }
			
			//definicion de border
			$border_final = (isset($this->tableborders[$index])?$this->tableborders[$index]:$border);
						
			//definicion de cambio de color
			$textcolor_final = (isset($this->tabletextcolor[$index])?$this->tabletextcolor[$index]:$textcolor);			
			
			$this->setTextColorArray($textcolor_final);
			//#77
			$this->Cell($this->tablewidths[$index], $alto, $data, $border_final,0,$this->tablealigns[$index], $fill);
			$index++;
			
        }		
		$this->ln();
		 
    }
	
	
	public function getHeightV2( $data, $width){
		return $this->getNumLines($data, $width, false, true,'',1);
	}
	
	public function getHeightV3( $data, $width){
		return $this->getStringHeight($data, $width, false, true,'',1);
	}
	
	public function getHeightV4( $data, $width){
		return $this->getStringHeight($data, $width, false, true,'',1) * $this->getNumLines($data, $width, false, true,'',1);
	}
	
	
	
	
}
?>