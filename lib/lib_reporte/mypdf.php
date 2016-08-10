<?php
// Extend the TCPDF class to create custom MultiRow
class MYPDF extends TCPDF {
    //Page header
    var $tablewidths=array();
	var $tablealigns=array();
	var $tablenumbers=array();
	var $tableborders=array();
	var $tabletextcolor=array();
	
    public function MultiRow($row, $fill = false, $border = 1, $textcolor = array(0,0,0)) {    	
        $index = 0;
		$index_aux = 0;
		$height_base = 3;
		$height_aux = 0;
		$page_aux = 0;
		$y_pos_aux = 0;
		$column_aux = '';
		$page_ini = $this->getPage();
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
		
		
		$resp = $this->getHeight($this->tablewidths[$index_aux], $height_base, $column_aux, $border);
		$height_aux = $resp[2];
		//$height_aux = $this->getHeightV3($column_aux, $this->tablewidths[$index_aux]);
		
		
		
		$this->CheckPageBreak($height_aux);
		$index = 0;
		
		//echo $height_aux;
		//exit;
		
		//var_dump($row); exit;
		
		/****************************************************
		 * 
		 *    IMPRIME LA COLUMNA CON LA ALTUR AENCONTRADA
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
		//$this->setPage($page_aux);		
		
        //$this->SetXY($this->getX(),$y_pos_aux); 
    }

	public function UniRow($row, $fill = false, $border = 1, $textcolor = array(0,0,0)) {    	
        $index = 0;
		$height_base = 3;
		$height_aux = 0;
		$page_aux = 0;
		$y_pos_aux = 0;
			
		$index = 0;
		$numbers = false;
		if (count ($this->tablenumbers) > 0 ) {
			$numbers = true;
		}	
		foreach ($row as $data) {
		    if ($numbers && $this->tablenumbers[$index] > 0) {
            	$data = number_format ( $data , $this->tablenumbers[$index] , '.' , ',' );
            }
			
			//definicion de border
			$border_final = (isset($this->tableborders[$index])?$this->tableborders[$index]:$border);
						
			//definicion de cambio de color
			$textcolor_final = (isset($this->tabletextcolor[$index])?$this->tabletextcolor[$index]:$textcolor);			
			
			$this->setTextColorArray($textcolor_final);
			
			$this->Cell($this->tablewidths[$index], 4, $data, $border_final,0,$this->tablealigns[$index], $fill);
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
	
	
	
	
	public function getHeight($w=0, $h=0, $txt, $border=1, $align='L', $fill=false, $ln=1, $x='', $y='', $reseth=true, $stretch=0, $ishtml=false, $autopadding=true, $maxh=0) {
		// store current object 
        $this->startTransaction(); 
        $res = array();
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
}
?>