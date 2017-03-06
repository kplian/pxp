<?php
namespace Phpdocx\Elements;
/**
 * Interface for xlsx
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
interface InterfaceXlsx
{

    /**
     * Create a excel sheet
     *
     * @access public
     */
    public function createExcelSheet($dats);

    /**
     * Create a shared string file from the xlsx
     *
     * @access public
     */
    public function createExcelSharedStrings($dats);

    /**
     * return a table file from the xlsx
     *
     * @access public
     */
    public function createExcelTable($dats);
}
