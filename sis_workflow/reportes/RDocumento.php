<?php

include_once(dirname(__FILE__).'/../../lib/PHPWord/src/PhpWord/Autoloader.php');
\PhpOffice\PhpWord\Autoloader::register();
Class RCartaAdjudicacion {
	
	private $dataSource;
    
    public function setDataSource(DataSource $dataSource) {
        $this->dataSource = $dataSource;
    }
    
    public function getDataSource() {
        return $this->dataSource;
    }

    function write($fileName) {
    	
		$phpWord = new \PhpOffice\PhpWord\PhpWord();
		$document = $phpWord->loadTemplate(dirname(__FILE__).'/template_carta_adj.docx');
		setlocale(LC_ALL,"es_ES@euro","es_ES","esp");
		$document->setValue('NUMOC', $this->getDataSource()->getParameter('num_tramite')); // On section/content
		$document->setValue('PROVEEDOR', $this->getDataSource()->getParameter('desc_proveedor')); // On section/content
		$document->setValue('OBJETIVO', $this->getDataSource()->getParameter('objeto')); // On section/content
		$document->setValue('FECHAOC', strftime("%d de %B de %Y", strtotime($this->getDataSource()->getParameter('fecha_oc')))); // On section/content

		
		
		$document->saveAs($fileName);
		        
    }
    
        
}
?>