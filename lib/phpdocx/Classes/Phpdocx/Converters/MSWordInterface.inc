<?php
namespace Phpdocx\Converters;
/**
 * If PHPDocX is installed in a server with a working copy of Word 2007 or newer you may
 * use it to do format conversions.
 * Supported formats, DOCX and DOC to PDF, RTF, HTML and DOC
 *
 * @category   Phpdocx
 * @package    converters
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class MSWordInterface
{

    /**
     * If PHPDocX is installed in a server with a working copy of Word 2007 or newer you may
     * use it to do format conversions.
     * Supported formats, DOCX and DOC to PDF, RTF, HTML and DOC
     * @access public
     * @param $docSource You should use the full Windows path to the docx (remember to escape backslashes)
     * @param $docDestination ou should use the full Windows path to the docx (remember to escape backslashes)
     * @return void
     */
    public function transformFormat($docSource, $docDestination)
    {
        $code = array(
            'doc' => 0,
            'pdf' => 17,
            'rtf' => 6,
            'html' => 8,
            'htm' => 8,
            'txt' => 5
        );
        //We now check the extension of $docDestination
        $extensionArray = explode('.', $docDestination);
        $extension = strtolower(array_pop($extensionArray));

        if (!array_key_exists($extension, $code)) {
            exit('This source extension is not supported');
        }
        //If the destination document exists we remove it
        if (file_exists($docDestination)) {
            @unlink($docDestination);
        }

        //Lets start a Word instance
        $MSWordInstance = new \COM("word.application") or exit('A working copy of Word was not found on this server');

        //We should check that the version of MS Word is 12 or higher
        if ($MSWordInstance->Version >= 12) {
            //We try to open the source document
            if (file_exists($docSource)) {
                $MSWordInstance->Documents->Open($docSource);
            } else {
                exit('Source file not found');
            }
            //Now we save the target document
            $MSWordInstance->Documents[1]->SaveAs($docDestination, $code[$extension]);
            //Now we close Word
            $MSWordInstance->Documents[1]->Close();
        } else {
            exit('The version of Word should be 12 (Word 2007) or higher');
        }
        $MSWordInstance->Quit();

        $MSWordInstance = null;
    }

}
