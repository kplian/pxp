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

class DiagramadorGanttWF{
	
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
		
		$dataset=$this->dataSource->getDataset();
		
		$tamanioDataset = count($dataset);
		
		$fecha_reg_ini = new DateTime();
        $fecha_reg_fin = new DateTime();
        $fechaInicio = new DateTime();
        $fechaFin = new DateTime();
        
        
		$data = array();
		$constrains = array();
		
		for ($i=0;$i<$tamanioDataset;$i++) {
		    //echo date_format(new DateTime($dataset[$i]['fecha_ini']),'Y-m-d H:i:s');
		    //exit;
			     						 
			 if($i==0){
		       $fechaInicio=  new DateTime($dataset[$i]['fecha_ini']);
		       $fechaFin = new DateTime($dataset[$i]['fecha_fin']);
		     
             }
             
             if ( $fechaFin  < new DateTime($dataset[$i]['fecha_ini'])  && $dataset[$i]['tipo'] =='estado_final' ){
                     
                $fechaFin = new DateTime($dataset[$i]['fecha_ini']);  
             }
		     
		     $actividad = array();
		     
            
			 array_push($actividad,$dataset[$i]['id']);	
			 
			 $prefijo = '';
			 
			 if ($dataset[$i]['tipo']=='proceso'){
			     $tipo = ACTYPE_GROUP;
             }
			 if ($dataset[$i]['tipo']=='estado'){
                 $tipo = ACTYPE_NORMAL;
                 $prefijo ='  ';
             }
             if ($dataset[$i]['tipo']=='estado_final'){
                 $tipo = ACTYPE_MILESTONE; 
                 $prefijo ='  '; 
             }  
             
             
             //arma cabecera
             
             $fecha_reg_ini = new DateTime($dataset[$i]['fecha_ini']);
             $fecha_reg_fin = new DateTime($dataset[$i]['fecha_fin']);
             
               
              
            
              $resp = ($dataset[$i]['funcionario']!='')?$dataset[$i]['funcionario']:$dataset[$i]['depto'];
              $resp = ($resp =='')?$dataset[$i]['cuenta']:$resp;
              
              
              //$resp = $dataset[$i]['depto'].'('.$dataset[$i]['cuenta'].") ->".$dataset[$i]['funcionario'];
              
              //$resp = $dataset[$i]['depto'].'('.$dataset[$i]['cuenta'].");
              
              
              $fini=$fecha_reg_ini->format('d M H:i:s');
              $ffin=$fecha_reg_fin->format('d M H:i:s');
              
              $start = strtotime($dataset[$i]['fecha_ini']);
              $end = strtotime($dataset[$i]['fecha_fin']);
              $days_between = round(($end - $start) / 86400);
              $desc_principal=utf8_decode($prefijo.$dataset[$i]['nombre']);
              
              if ($dataset[$i]['tipo']=='estado'){
                  $tiempo = $days_between.' dias';
               }  
              else{
                  if ($dataset[$i]['tipo']=='estado_final'){
                      $tiempo='--'; 
                      $ffin = $fini;    
                  }
                  else{
                     $resp = '--';
                     $tiempo = $days_between.' dias';
                     $desc_principal=$desc_principal;
                      
                  }
                 
              }
               
             //mostramos cuenta de usuario si existe
             if($dataset[$i]['cuenta']!=''){
                $desc_principal = $desc_principal.'('.$dataset[$i]['cuenta'].")" ; 
             }
             
             $cabecera = array($desc_principal,
                         utf8_decode($resp),
                        // utf8_decode($dataset[$i]['descripcion']),
                         utf8_decode("asdasd \n asdasd \n aasdas das  asd asd asd asd \\nasda sd"),
                         
                         
                         $tiempo, 
                         $fini ,
                         $ffin);
                
                 
			 array_push($actividad,$tipo);
			 array_push($actividad,$cabecera);
			 
			 array_push($actividad,$fecha_reg_ini->format('Y-m-d H:i:s'));
			 
			 if ($dataset[$i]['tipo']!='estado_final'){
			    array_push($actividad,$fecha_reg_fin->format('Y-m-d H:i:s'));
             }
             
             //array_push($actividad,utf8_decode($dataset[$i]['descripcion']));
             
             //array_push($actividad,$desc_principal);
             
             array_push($actividad,"asdasd \n asdasd \n aasdas das  asd asd asd asd \nasda sd </p>");
             
             
             
             array_push($actividad,'#'.$dataset[$i]['id']); 
             array_push($actividad,$fecha_reg_ini->format('Y-m-d H:i:s'));   
			 
			 //prepara las relaciones entre tipos
			 
			  if ($dataset[$i]['tipo']=='estado' && $dataset[$i]['id_siguiente'] != 0)
			    array_push($constrains, array($dataset[$i]['id'],$dataset[$i]['id_siguiente'],CONSTRAIN_ENDSTART));
			 
			 
			 array_push($data,$actividad);						 
		}	
		
		
		//definir scala en funcion al dia inicial y dia final
		
		
		$diferencia =  $fechaInicio->diff($fechaFin);
		
		 
		if ($diferencia->format('%m') >  6 ){
		              
		         //escala de meses 
		         $graph->ShowHeaders(GANTT_HYEAR | GANTT_HMONTH );
		         $graph->scale->week->SetStyle(HOURSTYLE_HM24);
		         $sw =1;
		          $fechaFin=$fechaFin->add(new DateInterval('PT1000H'));
		      
		 }
		 elseif ($diferencia->format('%m') >  1){
              //escala de semanas 
               $graph->ShowHeaders(GANTT_HYEAR | GANTT_HMONTH | GANTT_HWEEK   );
                $graph->scale->week->SetStyle(HOURSTYLE_HM24); 
                $sw =2; 
                $fechaFin=$fechaFin->add(new DateInterval('PT800H'));    
        }
        elseif ($diferencia->format('%m') > 0 ){
              //escala de dias
              $graph->ShowHeaders(GANTT_HYEAR | GANTT_HMONTH | GANTT_HWEEK | GANTT_HDAY  );
              $graph->scale->week->SetStyle(HOURSTYLE_HM24);
              $sw =3; 
              $fechaFin=$fechaFin->add(new DateInterval('PT500H'));        
        }
        elseif ($diferencia->format('%m') == 0 && $diferencia->format('%d') > 1){
              //escala de dias 
              $graph->ShowHeaders(GANTT_HMONTH | GANTT_HWEEK | GANTT_HDAY | GANTT_HHOUR ); 
              $graph->scale->week->SetStyle(HOURSTYLE_HM24);
              $graph->scale->hour->SetInterval(12);
              $sw =4; 
              $fechaFin=$fechaFin->add(new DateInterval('PT200H')); 
              //$fechaFin=$fechaInicio->diff(new DateInterval('PT24H'));  
        }
        else{
           //escala de horas 
           $graph->ShowHeaders( GANTT_HDAY | GANTT_HHOUR ); 
            $graph->scale->week->SetStyle(HOURSTYLE_HM24);
            $fechaFin=$fechaFin->add(new DateInterval('PT48H'));
            $sw =5;      
        }
		  
		$graph->scale->actinfo->SetColTitles(
        array('Tipo','Responsable','Observaciones','Duracion','Inicio','Fin'),array(40,100));
        
		// Setup a horizontal grid
        $graph->hgrid->Show();
        $graph->hgrid->SetRowFillColor('darkblue@0.9'); 	
			
		$graph->SetDateRange($fechaInicio->format('Y-m-d H:i:s'),$fechaFin->format('Y-m-d H:i:s'));                  
         
        //$graph->SetDateRange('2013-06-04','2013-08-04');                  
        $graph->title->Set("Diagrama Gant Work Flow");
        //$graph->scale->week->SetStyle(MINUTESTYLE_MM);

        $graph->scale->week->SetFont(FF_FONT1);

        $progress = array();
		
        $graph->CreateSimple($data,$constrains,$progress);
		
		
	    $archivo = dirname(__FILE__).'/../../../reportes_generados/'.$filename;
	
		
		//$graph->StrokeCSIM();
		$graph->Stroke($archivo);
		
		
		/*
		
		echo ('<pre>');
		var_dump($sw);
		var_dump($fechaInicio->format('Y-m-d H:i:s'));
        var_dump($fechaFin->format('Y-m-d H:i:s'));
		
		var_dump($data);
		echo ('</pre>');
		
		echo ('<pre>');
		print_r($constrains);
		echo ('</pre>');*/
	
	}
}

?>