<?php
namespace Team2mdc\PhpdocxBundle\Classes;

use Phpdocx\Create\CreateDocx;
use Phpdocx\Create\CreateDocxFromTemplate;
use Phpdocx\Elements\WordFragment;

class PhpdocxBridge
{
    public function __construct()
    {
    }

    /**
     * @access public
     * @param string $baseTemplatePath. Optional, basicTemplate.docx as default
     * @param $docxTemplatePath. User custom template (preserves Word content)
     */
    public function createDocx($baseTemplatePath = PHPDOCX_BASE_TEMPLATE, $docxTemplatePath = '')
    {
        return new CreateDocx($baseTemplatePath, $docxTemplatePath);
    }

    /**
     * @access public
     * @param string $docxTemplatePath path to the template we wish to use
     * @param array $options
     * The available keys and values are:
     *  'preprocessed' (boolean) if true the variables will not be 'repaired'. Default value is false
     */
    public function createDocxFromTemplate($docxTemplatePath, $options = array())
    {
        return new CreateDocxFromTemplate($docxTemplatePath, $options);
    }

    /**
     * @access public
     * @param CreateDocx $docx
     * @param string $target document (default value), defaultHeader, firstHeader, evenHeader, defaultFooter, firstFooter, evenFooter, footnote, endnote, comment
     */
    public function wordFragment($docx = NULL, $target = 'document')
    {
        return new WordML($docx, $target);
    }
}