<?php
namespace Phpdocx\Elements;
/**
 * Embed documents in DOCX.
 *
 * @category   Phpdocx
 * @package    elements
 * @package    transform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
interface EmbedDocument
{

    /**
     * Return current Id.
     *
     * @abstract
     * @return void
     */
    function getId();

    /**
     * Embed content or file.
     *
     * @abstract
     * @return void
     */
    function embed($matchSource = null);

    /**
     * Generate w:altChunk.
     *
     * @abstract
     * @return void
     */
    function generateALTCHUNK($matchSource = null);
}
