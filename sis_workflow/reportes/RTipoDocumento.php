<?php

include_once(dirname(__FILE__).'/../../lib/PHPWord/src/PhpWord/Autoloader.php');
\PhpOffice\PhpWord\Autoloader::register();
Class RTipoDocumento {
	
	private $dataSource;
    private $plantilla; //Ruta relativa para incluir la plantilla
    
    public function __construct($PlantillaReporte) {
        $this->plantilla = $PlantillaReporte;
    }
    
    public function setDataSource(DataSource $dataSource) {
        $this->dataSource = $dataSource;
    }
    
    public function getDataSource() {
        return $this->dataSource;
    }

    function write($fileName) {
		$phpWord = new \PhpOffice\PhpWord\PhpWord();
        //echo dirname(__FILE__).'/'.$this->plantilla;exit;
		$document = $phpWord->loadTemplate(dirname(__FILE__).'/'.$this->plantilla);
		setlocale(LC_ALL,"es_ES@euro","es_ES","esp");
        
        //var_dump($this->dataSource);
        foreach($this->dataSource->getParameters() as $col=>$val){
            //echo 'kkk:'. $col .' '.$val;
            $document->setValue($col, $val); // On section/content
        }
		//echo 'iiiiiooooooo: '.$fileName;exit;
		$document->saveAs($fileName);
        
		        
    }
    
        
}
?>