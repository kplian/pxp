<?php

/**
 * Tutorial example
 *
 * @category   Phpdocx
 * @package    tutorial
 * @subpackage easy
 * @copyright  Copyright (c) 2009-2011 Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    1.8
 * @link       http://www.phpdocx.com
 * @since      01/03/2012
 */
require_once '../../classes/CreateDocx.inc';


$docx = new CreateDocx('../word_documents/frontPageTemplate.docx');//You should include the path to your base template

$docx->addTemplate('../word_documents/myTestTemplate.docx');
$docx->addTemplateVariable('NAME', 'John Smith');
$docx->createDocx('../word_documents/test_template');




