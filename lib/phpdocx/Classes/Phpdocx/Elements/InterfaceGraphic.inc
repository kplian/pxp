<?php
namespace Phpdocx\Elements;
/**
 * Interface for charts
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
interface InterfaceGraphic
{

    /**
     * Create embedded xml chart
     *
     * @access public
     */
    public function createEmbeddedXmlChart();

    /**
     * return the tags where the data is written
     *
     * @access public
     */
    public function dataTag();

    /**
     * return the object type of the xlsx
     *
     * @access public
     */
    public function getXlsxType();
}
