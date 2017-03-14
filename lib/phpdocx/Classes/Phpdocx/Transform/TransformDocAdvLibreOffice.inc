<?php
namespace Phpdocx\Transform;

use Phpdocx\Clean\CleanTemp;
use Phpdocx\Create\CreateDocx;
use Phpdocx\Logger\PhpdocxLogger;
use Phpdocx\Parse\RepairPDF;
use Phpdocx\Transform\TransformDocAdv;
use Phpdocx\Utilities\PhpdocxUtilities;

/**
 * Transform DOCX to PDF, ODT, SXW, RTF, DOC, TXT, HTML or WIKI
 *
 * @category   Phpdocx
 * @package    trasform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.08.04
 * @link       http://www.phpdocx.com
 */

require_once dirname(__FILE__) . '/TransformDocAdv.inc';

class TransformDocAdvLibreOffice extends TransformDocAdv
{

    /**
     * Transform DOCX to PDF, ODT, SXW, RTF, DOC, TXT, HTML or WIKI
     * Transforms all documents supported by OpenOffice
     *
     * @access public
     * @param $docSource
     * @param $docDestination
     * @param string $tempDir
     * @param array $options :
     *      · method : 'direct' (default), 'script' ; 'direct' method uses
     *                  passthru and 'script' uses a external script.
     *                  If you're using Apache and 'direct' doesn't work use 'script'
     *      · 'odfconverter' : true (default) or false. Use odf-converter.
     *      · 'debug' : false (default) or true. It shows debug information about the plugin conversion
     *      · 'toc' : false (default) or true. It generates the TOC before exporting the document
     *      · 'outdir' : set the outdir path. Useful when the PDF output path is not the same than the running script
     * @return void
     */
    public function transformDocument($docSource, $docDestination, $tempDir = null, $options = array(), $version = null)
    {
        // get the file info
        $sourceFileInfo = pathinfo($docSource);
        $sourceExtension = $sourceFileInfo['extension'];
        
        if (!isset($options['method'])) {
            $options['method'] = 'direct';
        }
        if (!isset($options['debug'])) {
            $options['debug'] = false;
        }
        if (!isset($options['toc'])) {
            $options['toc'] = false;
        }

        $destination = explode('.', $docDestination);
        $extension = strtolower(array_pop($destination));
        if (!in_array($extension, $this->_allowedExtensions)) {
            PhpdocxLogger::logger('The chosen extension is not supported', 'fatal');
        }

        $phpdocxconfig = PhpdocxUtilities::parseConfig();
        $libreOfficePath = $phpdocxconfig['transform']['path'];

        // set outputstring for debugging
        $outputDebug = '';
        if (PHP_OS == 'Linux' || PHP_OS == 'Darwin' || PHP_OS == ' FreeBSD') {
            if (!$options['debug']) {
                $outputDebug = ' > /dev/null 2>&1';
            }
        } elseif (substr(PHP_OS, 0, 3) == 'Win' || substr(PHP_OS, 0, 3) == 'WIN') {
            if (!$options['debug']) {
                $outputDebug = ' > nul 2>&1';
            }
        }

        // if the outdir option is set use it as target path, instead use the dir path 
        if (isset($options['outdir'])) {
            $outdir = $options['outdir'];
        } else {
            $outdir = $sourceFileInfo['dirname'];
        }

        if ($options['method'] == 'script') {
            passthru('php ' . dirname(__FILE__) . '/../lib/convertSimple.php -s ' . $docSource . ' -e ' . $extension . ' -p ' . $libreOfficePath . ' -t ' . $options['toc'] . ' -o ' . $outdir . $outputDebug);
        } else {
            if ($options['toc']) {
                passthru($libreOfficePath . ' --invisible "macro:///Standard.Module1.SaveToPdf(' . realpath($docSource) . ')" ' . ' --outdir ' . $outdir . $outputDebug);
            } else {
                passthru($libreOfficePath . ' --invisible --convert-to ' . $extension . ' ' . $docSource . ' --outdir ' . $outdir . $outputDebug);
            }
        }

        // get the converted document, this is the name of the source and the extension
        $newDocumentPath = $outdir . '/' . $sourceFileInfo['filename'] . '.' . $extension;
        // move the document to the guessed destination
        rename($newDocumentPath, $docDestination);

    }

}
