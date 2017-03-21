<?php
namespace Phpdocx;
/**
 * Repair a DOCX created in OpenOffice. When OpenOffice creates a DOCX,
 * and then changed by ZipArchive of PHP the ZIP file has errors that prevent to
 * be opened in Word. This function solves this error reading whole content and
 * adding it again to the ZIP.
 * 
 * @param string $file File path
 */
function repairZipOpenOffice($file)
{
    $fileRepaired = new ZipArchive();
    $fileRepaired->open($file);
    $this->_docxContent = array();
    for ($i = 0; $i < $fileRepaired->numFiles; $i++) {
        $this->_docxContent[$fileRepaired->getNameIndex($i)] = $fileRepaired->getFromName($fileRepaired->getNameIndex($i));
    }
    foreach ($this->_docxContent as $key => $value) {
        $fileRepaired->addFromString($key, $value);
    }
    // close DOCX to save all files
    $fileRepaired->close();
}
