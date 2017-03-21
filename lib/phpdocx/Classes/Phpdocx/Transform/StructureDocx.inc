<?php
namespace Phpdocx\Transform;
/**
 * DOCX 2 PDF
 *
 * @category   Phpdocx
 * @package    transform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class StructureDocx
{

    /**
     * WordML dependencies
     * @var array
     * @access private
     */
    private $_dependencies;

    /**
     * Endnotes
     * @var array
     * @access private
     */
    private $_endnotes;

    /**
     * Footers
     * @var array
     * @access private
     */
    private $_footers;

    /**
     * Footnotes
     * @var array
     * @access private
     */
    private $_footnotes;

    /**
     * Headers
     * @var array
     * @access private
     */
    private $_headers;

    /**
     * Images
     * @var array
     * @access private
     */
    private $_images;

    /**
     * Sections
     * @var array
     * @access private
     */
    private $_sections;

    /**
     * Construct
     * 
     * @access public
     */
    public function __construct()
    {
        $this->_endnotes = array();
        $this->_footers = array();
        $this->_footnotes = array();
        $this->_headers = array();
        $this->_images = array();
        $this->_sections = array();
    }

    /**
     * Open DOCX.
     * 
     * @access public
     */
    public function openDocx($filePath)
    {
        if (!file_exists($filePath)) {
            throw new \Exception('File not exists');
        }
    }

}
