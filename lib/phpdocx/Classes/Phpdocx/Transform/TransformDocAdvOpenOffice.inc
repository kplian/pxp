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

class TransformDocAdvOpenOffice extends TransformDocAdv
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
     * @param string $version 32, 64 or null (default). If null autodetect
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
        if (!isset($options['odfconverter'])) {
            $options['odfconverter'] = true;
        }
        if (!isset($options['debug'])) {
            $options['debug'] = false;
        }

        $destination = explode('.', $docDestination);
        $extension = strtolower(array_pop($destination));
        if (!in_array($extension, $this->_allowedExtensions)) {
            PhpdocxLogger::logger('The chosen extension is not supported', 'fatal');
        }

        if ($sourceExtension == 'docx') {
            // set path to OdfConverter: 32-bit or 64-bit
            $odfconverterPath = '';
            // set outputstring for debugging
            $outputDebug = '';
            if (PHP_OS == 'Linux') {
                if (!$options['debug']) {
                    $outputDebug = ' > /dev/null 2>&1';
                }
                if ($version == '32') {
                    $odfconverterPath = '/../../../lib/OdfConverter/32/OdfConverter';
                } elseif ($version == '64') {
                    $odfconverterPath = '/../../../lib/OdfConverter/64/OdfConverter';
                } else {
                    // detect if 32bit or 64bit
                    if (PHP_INT_SIZE * 8 == 64) {
                        $odfconverterPath = '/../../../lib/OdfConverter/64/OdfConverter';
                    } else {
                        $odfconverterPath = '/../../../lib/OdfConverter/32/OdfConverter';
                    }
                }
            } elseif (substr(PHP_OS, 0, 3) == 'Win' || substr(PHP_OS, 0, 3) == 'WIN') {
                if (!$options['debug']) {
                    $outputDebug = ' > nul 2>&1';
                }
                $odfconverterPath = '/../../../lib/OdfConverter/Windows/OdfConverter.exe';
            }

            $newDocx = $this->prepareDocx($docSource, $tempDir, $options);

            if (file_exists(dirname(__FILE__) . '/CreateChartImage.inc') && (file_exists(dirname(__FILE__) . '/../../../lib/jpgraph/') || file_exists(dirname(__FILE__) . '/../../../lib/ezcomponents'))) {
                $this->replaceChartsWithImages($newDocx);
            }

            if ($tempDir === null) {
                $tempDir = $this->getTempDirPath();
                $tempDoc = $tempDir . '/tempOdt_' . uniqid() . '.odt';
            } else {
                $tempDoc = $tempDir . '/tempOdt_' . uniqid() . '.odt';
            }

            if ($options['method'] == 'script') {
                passthru('php ' . dirname(__FILE__) . '/../../../lib/convert.php -s ' . $newDocx . ' -t ' . $tempDoc . ' -d ' . $docDestination . ' -o ' . $options['odfconverter'] . ' -p ' . $odfconverterPath . $outputDebug);
            } else {
                if ($extension != 'rtf' && $options['odfconverter']) {
                    passthru(dirname(__FILE__) . $odfconverterPath . ' /I ' . $newDocx . ' /O ' . $tempDoc . $outputDebug);
                } else {
                    copy($docSource, $tempDoc);
                }
                // How to start OpenOffice in headless mode: lib/openoffice/openoffice.org3/program/soffice -headless -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard;
                passthru('java -jar ' . dirname(__FILE__) . '/../../../lib/openoffice/jodconverter-2.2.2/lib/jodconverter-cli-2.2.2.jar ' . $tempDoc . ' ' . $docDestination . $outputDebug);
            }

            CleanTemp::clean($tempDoc);
        } else {
            if ($options['method'] == 'script') {
                passthru('php ' . dirname(__FILE__) . '/../../../lib/convert.php -s ' . $docSource . ' -d ' . $docDestination . $outputDebug);
            } else {
                // How to start OpenOffice in headless mode: lib/openoffice/openoffice.org3/program/soffice -headless -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard;
                passthru('java -jar ' . dirname(__FILE__) . '/../../../lib/openoffice/jodconverter-2.2.2/lib/jodconverter-cli-2.2.2.jar ' . $docSource . ' ' . $docDestination . $outputDebug);
            }
        }
    }

}
