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
		$height_base = 3;
		$height_aux = 0;
		$page_aux = 0;
		$y_pos_aux = 0;
		$page_ini = $this->getPage();
		if (count ($this->tablenumbers) > 0 ) {
			$numbers = true;
		}	
        foreach ($row as $column) {
            if ($numbers && $this->tablenumbers[$index] > 0) {
            	$column = number_format ( $column , $this->tablenumbers[$index] , '.' , ',' );
            }
			
			$datos_res = $this->getHeight($this->tablewidths[$index], $height_base, $column, $border);
			
			if ($datos_res[2] > $height_aux) {
				$height_aux = $datos_res[2];
				$page_aux = $datos_res[1];
				$y_pos_aux = $datos_res[0];
				
			}			
			$index++;
			
        }
		
		$index = 0;
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
		$this->setPage($page_aux);		
		
        $this->SetXY($this->getX(),$y_pos_aux); 
    }

	public function UniRow($row, $fill = false, $border = 1, $textcolor = array(0,0,0)) {    	
        $index = 0;
		$height_base = 3;
		$height_aux = 0;
		$page_aux = 0;
		$y_pos_aux = 0;
			
		$index = 0;
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