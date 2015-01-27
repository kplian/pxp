<?php
/**
*@package pXP
*@file DiagramadorGanttTramite.php
*@author  Rensi Arteaga Copari
*@date 14-05-2013
*@description Clase que que genera el diagrama Gantt con ayuda de la libreria jpgraph
*/
require_once(dirname(__FILE__).'/../../pxpReport/DataSource.php');
require_once (dirname(__FILE__).'/../../lib/jpgraph/src/jpgraph.php');
require_once (dirname(__FILE__).'/../../lib/jpgraph/src/jpgraph_gantt.php');

class DiagramadorGanttTramite{
	
    private $dataSource;
    
    public function setDataSource(DataSource $dataSource) {
        $this->dataSource = $dataSource;
    }
    
    public function getDataSource() {
        return $this->dataSource;
    }
	
	public function graficar($filename){
		
		
		$graph = new GanttGraph();
		$graph->SetShadow();
		$graph->SetBox();
		
		// Only show part of the Gantt
		
		$graph = new GanttGraph(1000);
		/*
		$graph->title->Set('Proceso '.$this->dataSource->getParameter('desc_proceso_macro')."\n".
																					'Seguimiento de Solicitud '.$this->dataSource->getParameter('numero')."\n".
																					'Unidad '.$this->dataSource->getParameter('desc_uo'));
		$graph->title->SetFont(FF_ARIAL,FS_BOLD,6);
		*/
		define('UTF-8',$locale_char_set);
		
		// Setup some "very" nonstandard colors
		$graph->SetMarginColor('lightgreen@0.8');
		$graph->SetBox(true,'yellow:0.6',2);
		$graph->SetFrame(true,'darkgreen',4);
		$graph->scale->divider->SetColor('yellow:0.6');
		$graph->scale->dividerh->SetColor('yellow:0.6');
		
		// Explicitely set the date range 
		// (Autoscaling will of course also work)
		
		// Display month and year scale with the gridlines
		$graph->ShowHeaders(GANTT_HMONTH | GANTT_HYEAR | GANTT_HDAY);
		$graph->scale->month->grid->SetColor('gray');
		$graph->scale->month->grid->Show(true);
		$graph->scale->year->grid->SetColor('gray');
		$graph->scale->year->grid->Show(true);	
		
		// Setup a horizontal grid
        $graph->hgrid->Show();
        $graph->hgrid->SetRowFillColor('darkblue@0.9');				
		
		// Setup activity info
		
		// For the titles we also add a minimum width of 100 pixels for the Task name column
		$graph->scale->actinfo->SetColTitles(
		array('Tipo','Estado','Responsable','Duracion','Inicio','Fin'),array(40,100));
		
		$graph->scale->actinfo->SetBackgroundColor('green:0.5@0.5');
		$graph->scale->actinfo->SetFont(FF_ARIAL,FS_NORMAL,10);
		
		$data = array();
		$dataset=$this->dataSource->getDataset();
		
		$tamanioDataset = count($dataset);
		$fechaInicio=0;
		$fechaFin=0;
		
		
		
		for ($i=0;$i<$tamanioDataset;$i++) {						 
			 if($i==0)
				   $fechaInicio=	$dataset[$i]['fecha_reg'];
				/*
				if($dataset[$i]['nombre_estado']=='En_Proceso'||$dataset[$i]['nombre_estado']=='Habilitado para pagar'||$dataset[$i]['nombre_estado']=='En Pago'){
						$milestone = new MileStone($i,$dataset[$i]['nombre_estado'],$dataset[$i]['fecha_reg'],$dataset[$i]['fecha_reg']);
						$milestone->title->SetColor("black");
						$milestone->title->SetFont(FF_FONT1,FS_BOLD);
						$graph->Add($milestone);
						continue;
				}
				*/				 
			 $actividad = array();
			 array_push($actividad,$i);							
				if($i==($tamanioDataset-1))
							$fechaFin = $dataset[$i]['fecha_reg'];
				else
							$fechaFin = $dataset[$i+1]['fecha_reg'];
				$startLiteral = new DateTime($dataset[$i]['fecha_reg']);
				$endLiteral = new DateTime($fechaFin);
				$start = strtotime($dataset[$i]['fecha_reg']);
				$end = strtotime($fechaFin);
				$days_between = round(($end - $start) / 86400);
				$cabecera = array($dataset[$i]['proceso'],$dataset[$i]['estado'],($dataset[$i]['funcionario']!='-')?$dataset[$i]['func']:$dataset[$i]['depto'],"$days_between".' dias', $startLiteral->format('d M Y') ,$endLiteral->format('d M Y'));
				array_push($actividad,$cabecera);
				array_push($actividad, $dataset[$i]['fecha_reg']);
				array_push($actividad, $fechaFin);
				array_push($actividad, FF_ARIAL);
				array_push($actividad, FS_NORMAL);
				array_push($actividad, 8);
				array_push($data,$actividad);								 
		}			
		// Create the bars and add them to the gantt chart
		for($i=0; $i<count($data); $i++) {
			$bar = new GanttBar($data[$i][0],$data[$i][1],$data[$i][2],$data[$i][3],"[100%]",10);
			if( count($data[$i])>4 )
				$bar->title->SetFont($data[$i][4],$data[$i][5],$data[$i][6]);
			$bar->SetPattern(BAND_RDIAG,"yellow");
			$bar->SetFillColor("gray");
			$bar->progress->Set(1);
			$bar->progress->SetPattern(GANTT_SOLID,"darkgreen");
			$graph->Add($bar);
		}
		
		//$graph->SetDateRange($fechaInicio,$fechaFin);					 
	    $archivo = dirname(__FILE__).'/../../../reportes_generados/'.$filename;
	    
	    //$graph->StrokeCSIM();
	    //exit;
		$graph->Stroke($archivo);
	
	}
}

?>