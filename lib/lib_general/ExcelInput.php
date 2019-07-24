<?php
/**
 *@file ExcelInput.php
 *@author  Gonzalo Sarmiento Sejas
 *@date 19-12-2016
 *@description Clase que recupera las columnas excel
 * HISTORIAL DE MODIFICACIONES:
 * #ISSUE				FECHA				AUTOR				DESCRIPCION
 * #29	ERT			02/07/2019 				 MMV			Obtener el valor de la formula en excel para archivos excel
 * #36	ERT		24/07/2019 		MMV			Opción otros en casos para identificar si es una formula o dato ingresado manualmente

 */

include_once(dirname(__FILE__).'/../../lib/lib_control/CTincludes.php');
include_once(dirname(__FILE__).'/../../sis_parametros/modelo/MODColumnasArchivoExcel.php');
include_once(dirname(__FILE__).'/../../sis_parametros/modelo/MODPlantillaArchivoExcel.php');
require_once(dirname(__FILE__).'/../../lib/PHPExcel/Classes/PHPExcel/IOFactory.php');

class ExcelInput{

    private $codigoArchivo;
    private $arrayColumnas=array();
    private $objectReader;
    private $archivo;
    private $nombreHoja;
    private $filaInicio;
    private $filaFin;
    private $filasExcluidas=array();
    private $tipoArchivo;
    private $delimitador;

    function __construct($archivo, $codigoArchivo){
        $this->setArchivo($archivo);
        $this->setCodigoArchivo($codigoArchivo);
        $this->configuracionArchivoInicial($codigoArchivo);
    }

    public function setArchivo($archivo){
        $this->archivo= $archivo;
    }

    public function getArchivo()
    {
        return $this->archivo;
    }

    function setCodigoArchivo($codigo){
        $this->codigoArchivo = $codigo;
    }

    function getCodigoArchivo(){
        return $this->codigoArchivo;
    }

    function setArrayColumnas($arrayColumnas){
        $this->arrayColumnas = $arrayColumnas;
    }

    function getArrayColumnas(){
        return $this->arrayColumnas;
    }

    public function getNombreHoja()
    {
        return $this->nombreHoja;
    }

    public function setNombreHoja($nombreHoja)
    {
        $this->nombreHoja = $nombreHoja;
    }

    public function getFilaInicio()
    {
        return $this->filaInicio;
    }

    public function setFilaInicio($filaInicio)
    {
        $this->filaInicio = $filaInicio;
    }

    public function setFilaFin($filaFin)
    {
        $this->filaFin = $filaFin;
    }

    public function getFilaFin()
    {
        return $this->filaFin;
    }

    public function setFilasExcluidas($filasExcluidas)
    {
        $this->filasExcluidas = $filasExcluidas;
    }

    public function getFilasExcluidas()
    {
        return $this->filasExcluidas;
    }

    public function setValidarTipo($validarTipo)
    {
        $this->validarTipo = $validarTipo;
    }

    public function getValidarTipo()
    {
        return $this->validarTipo;
    }

    public function setTipoArchivo($tipoArchivo)
    {
        $this->tipoArchivo = $tipoArchivo;
    }

    public function getTipoArchivo()
    {
        return $this->tipoArchivo;
    }

    public function setDelimitador($delimitador)
    {
        $this->delimitador = $delimitador;
    }

    public function getDelimitador()
    {
        return $this->delimitador;
    }

    function recuperarColumnasExcel(){

        $objPostData = new CTPostData();

        //$arr_unlink = array();
        $aPostData = $objPostData->getData();

        $_SESSION["_PETICION"]=serialize($aPostData);
        $objParam = new CTParametro($aPostData['p'],null,null);

        $objParam->addParametro('codigo',$this->codigoArchivo);

        $objFunc=new MODColumnasArchivoExcel($objParam);
        $res = $objFunc->listarColumnasArchivoExcelporCodigoArchivo();
        $this->setArrayColumnas($res->datos);
    }

    function configuracionArchivoInicial($codigo){

        $objPostData = new CTPostData();

        //$arr_unlink = array();
        $aPostData = $objPostData->getData();

        $_SESSION["_PETICION"]=serialize($aPostData);
        $objParam = new CTParametro($aPostData['p'],null,null);

        $objParam->defecto('ordenacion','nombre');
        $objParam->defecto('dir_ordenacion','asc');
        $objParam->defecto('cantidad',50);
        $objParam->defecto('puntero',0);
        $objParam->defecto('filtro','0=0');

        $objParam-> addFiltro('arxls.codigo =\'\''.$codigo.'\'\'');

        $objFunc=new MODPlantillaArchivoExcel($objParam);
        $res = $objFunc->listarPlantillaArchivoExcel();
        $plantilla = $res->datos;

        if(count($plantilla)==0){
            throw new Exception('No se parametrizo la plantilla de archivo para '.$codigo);
        }
        
        $this->setNombreHoja($plantilla[0]['hoja_excel']);
        $this->setFilaInicio($plantilla[0]['fila_inicio']);
        $this->setFilaFin($plantilla[0]['fila_fin']);
        $this->setTipoArchivo($plantilla[0]['tipo_archivo']);
        $this->setDelimitador($plantilla[0]['delimitador']);

        if($plantilla[0]['filas_excluidas'] !='') {
            $this->setFilasExcluidas(explode(',', $plantilla[0]['filas_excluidas']));
        }
    }

    function leerColumnasArchivoExcel()
    {
        $this->objectReader = PHPExcel_IOFactory::createReaderForFile($this->getArchivo());

        $objPHPExcel = $this->objectReader->load($this->getArchivo());

        if($this->getNombreHoja() == '') {
            $worksheet = $objPHPExcel->getActiveSheet();
        }else {
            $worksheet = $objPHPExcel->getSheetByName($this->getNombreHoja());;
        }
        if($worksheet==''){
            throw new Exception(__METHOD__.': Verifique el nombre de la hoja del archivo excel');
        }

        if($this->getFilaFin()!=''){
            $highestRow = $this->getFilaFin();
        }else {
            $highestRow = $worksheet->getHighestRow();
        }

        $arrayArchivo = array();

        $inicio = $this->getFilaInicio();


        if(get_class($this->objectReader) == 'PHPExcel_Reader_CSV'){    //csv
            $delimitador = $this->objectReader->getDelimiter();

            if ($delimitador != $this->getDelimitador()){
                throw new Exception(__METHOD__.': El delimitador del archivo Excel es otro cambie la configuracion');
            }
            /*else{
                $this->objectReader->setDelimiter("\t");
            }*/

            for($i = $inicio; $i <= $highestRow; $i++){
                if(in_array($i,$this->getFilasExcluidas())){
                    continue;
                }
                $arrayFila = array();
                $fila = $worksheet->getCellByColumnAndRow(0,$i)->getValue();
                $arrayCelda = str_replace('"','',explode($this->getDelimitador().'"',$fila));
                foreach($this->getArrayColumnas() as $columna){
                    if($columna['sw_legible']=='si') {
                        $celda = $arrayCelda[$columna['numero_columna']-1];
                        if($columna['tipo_valor'] == 'date') {
                            $valorColumna = $this->formatearFecha($celda,$columna['formato_fecha'],$columna['anio_fecha']);
                        }else{
                            if($columna['tipo_valor']=='numeric'){
                                $valorColumna = $this->formatearNumero($celda,$columna['punto_decimal']);
                            }else{
                                $valorColumna = $celda;
                            }
                        }
                        if ($valorColumna == null)
                            break;
                        $arrayFila[$columna['nombre_columna_tabla']]= $valorColumna;
                    }
                }
                array_push($arrayArchivo,$arrayFila);
            }

        }else{              //no csv
            if ($highestRow != 1) {            //para validar archivos sin datos
                for ($i = $inicio; $i <= $highestRow; $i++) {
                    if(in_array($i,$this->getFilasExcluidas())){
                        continue;
                    }
                    $arrayFila = array();
                    foreach($this->getArrayColumnas() as $columna){
                        if($columna['sw_legible']=='si') {
                            $celda = $worksheet->getCellByColumnAndRow($columna['numero_columna']-1, $i);
                            if($columna['tipo_valor'] == 'date') {
                                $valorColumna = $this->formatearFecha($celda->getValue(),$columna['formato_fecha'],$columna['anio_fecha']);
                            }else{
                                //#29 Se  aumento la condicon  formula numeric
                                switch ($columna['tipo_valor']) {
                                    case 'numeric': // cuando el valor de la columna se un entero o numeric
                                        $valorColumna = $this->formatearNumero($celda->getValue(),$columna['punto_decimal']);
                                        break;
                                    case 'formula_entero': // cuando el valor de la columna es un formuna pero aqui se obtine el valor de la formula cuando es un entero
                                        $valorColumna = $celda->getOldCalculatedValue();
                                        break;
                                    case 'formula_numeric': // cuando el valor de la columna es un formuna pero aqui se obtine el valor de la formula
                                        $valorColumna = $this->formatearNumero($celda->getOldCalculatedValue(),$columna['punto_decimal']);
                                        break;
                                    case 'formula_string': // cuando el valor de la columna es un formuna pero aqui se obtine el valor de la formula cuando es un string
                                        $valorColumna = $celda->getOldCalculatedValue();
                                        break;
                                    case 'otro': // #36 Opción otros en casos para identificar si es una formula o dato ingresado manualmente
                                        if (str_split($celda->getValue())[0] == '='){
                                            $valorColumna= $celda->getOldCalculatedValue();
                                        }else{
                                            $valorColumna = $celda->getValue();
                                        }
                                        break;
                                    default: //aqui obtenemos el valor por defecto de la columna string o entero
                                        $valorColumna = $celda->getValue();
                                }
                            }
                            if ($worksheet->getCellByColumnAndRow($columna[0], $i)->getValue() == null
                                  && $worksheet->getCellByColumnAndRow($columna[1], $i)->getValue() == null
                                  && $worksheet->getCellByColumnAndRow($columna[2], $i)->getValue() == null)
                                break;
                            $arrayFila[$columna['nombre_columna_tabla']]= $valorColumna;
                        }
                    }
                    array_push($arrayArchivo,$arrayFila);
                }
            }
        }
        return array_filter($arrayArchivo,"count");
    }

    function formatearFecha($fecha, $formato_fecha, $anio_fecha){

        switch ($formato_fecha) {
            case "yyyymmdd":
                $fechaFormateada = substr($fecha,6)."-".substr($fecha,4,2)."-".substr($fecha,0,4);
                break;
            case "dd-mm-yyyy":
                $fechaFormateada = $fecha;
                break;
            case "dd/mm/yyyy":
                $fechaFormateada = $fecha;
                break;
            case "dd/mm":
                $fechaFormateada = substr($fecha,0,5)."/".$anio_fecha;
                break;
            case "mm/dd/yyyy":
                $fechaFormateada  = substr($fecha,3,2)."/".substr($fecha,0,2)."/".substr($fecha,6);
                break;

            case "dd-mm-yyyy hh:mm":
                $fechaFormateada = $fecha;
                break;
            case "dd/mm/yyyy hh:mm":
                $fechaFormateada = $fecha;
                break;

            default:
                throw new Exception(__METHOD__.': Formato de fecha no definido');
        }

        if($formato_fecha == "dd-mm-yyyy hh:mm" || $formato_fecha == "dd/mm/yyyy hh:mm"){
            return PHPExcel_Style_NumberFormat::toFormattedString($fechaFormateada, 'dd/mm/yyyy hh:mm:ss');
        }else{
            return PHPExcel_Style_NumberFormat::toFormattedString($fechaFormateada, 'dd/mm/yyyy');
        }

    }

    function formatearNumero($numero, $dec_point){
        if($dec_point == '.'){
            $res = str_replace(',','',$numero);
        }else if($dec_point == ',') {
            $res = $numero;
        }else{
            throw new Exception(__METHOD__.': No se definio el punto decimal para la columna de valor numeric');
        }
        return $res;
    }
}
?>