<?php
namespace Phpdocx\Resources;
/**
 * This class contains a series of static variables with useful OOXML structure info
 * 
 * @category   Phpdocx
 * @package    Resources
 * @copyright  Copyright (c) 2009-2013 Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class OOXMLResources
{

    /**
     * @access public
     * @var string
     * @static
     */
    public static $commentsXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                                    <w:comments xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                                    xmlns:o="urn:schemas-microsoft-com:office:office" 
                                    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
                                    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
                                    xmlns:v="urn:schemas-microsoft-com:vml" 
                                    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
                                    xmlns:w10="urn:schemas-microsoft-com:office:word" 
                                    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
                                    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">
                                    </w:comments>';

    /**
     * @access public
     * @var string
     * @static
     */
    public static $customProperties = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
                                        <Properties xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes" 
                                        xmlns="http://schemas.openxmlformats.org/officeDocument/2006/custom-properties">
                                        </Properties>';

    /**
     * @access public
     * @var string
     * @static
     */
    public static $defaultPHPDOCXStyles = array('Default Paragraph Font PHPDOCX', //This is the default paragraph font style used in multiple places
        'List Paragraph PHPDOCX', //This is the style used for the defolt ordered and unorderd lists
        'Title PHPDOCX', //This style is used by the addTitle method
        'Subtitle PHPDOCX', //This style is used by the addTitle method
        'Normal Table PHPDOCX', //This style is used for the basic table
        'Table Grid PHPDOCX', //This style is for basic tables and is also used to embed HTML tables with border="1"
        'footnote Text PHPDOCX', //This style is used for default footnotes
        'footnote text Car PHPDOCX', //The character style for footnotes
        'footnote Reference PHPDOCX', // The style for the footnote
        'endnote Text PHPDOCX', //This style is used for default endnotes
        'endnote text Car PHPDOCX', //The character style for endnotes
        'endnote Reference PHPDOCX', // The style for the endnote
        'annotation reference PHPDOCX', //styles for comments
        'annotation text PHPDOCX', //styles for comments
        'Comment Text Char PHPDOCX', //styles for comments
        'annotation subject PHPDOCX', //styles for comments
        'Comment Subject Char PHPDOCX', //styles for comments
        'Balloon Text PHPDOCX', //styles for comments
        'Balloon Text Char PHPDOCX'); //styles for comments
    /**
     * @access public
     * @var string
     * @static
     */
    public static $endnotesXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                                    <w:endnotes xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                                    xmlns:o="urn:schemas-microsoft-com:office:office" 
                                    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
                                    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
                                    xmlns:v="urn:schemas-microsoft-com:vml" 
                                    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
                                    xmlns:w10="urn:schemas-microsoft-com:office:word" 
                                    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
                                    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">
                                        <w:endnote w:type="separator" w:id="-1">
                                            <w:p w:rsidR="006E0FDA" w:rsidRDefault="006E0FDA" w:rsidP="006E0FDA">
                                                <w:pPr>
                                                    <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                                </w:pPr>
                                                <w:r>
                                                    <w:separator/>
                                                </w:r>
                                            </w:p>
                                        </w:endnote>
                                        <w:endnote w:type="continuationSeparator" w:id="0">
                                            <w:p w:rsidR="006E0FDA" w:rsidRDefault="006E0FDA" w:rsidP="006E0FDA">
                                                <w:pPr>
                                                    <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                                </w:pPr>
                                                <w:r>
                                                    <w:continuationSeparator/>
                                                </w:r>
                                            </w:p>
                                        </w:endnote>
                                    </w:endnotes>';

    /**
     * @access public
     * @var string
     * @static
     */
    public static $notesXMLRels = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                                <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
                                </Relationships>';

    /**
     * @access public
     * @var string
     * @static
     */
    public static $footnotesXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                                    <w:footnotes xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                                    xmlns:o="urn:schemas-microsoft-com:office:office" 
                                    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
                                    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
                                    xmlns:v="urn:schemas-microsoft-com:vml" 
                                    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
                                    xmlns:w10="urn:schemas-microsoft-com:office:word" 
                                    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
                                    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">
                                        <w:footnote w:type="separator" w:id="-1">
                                            <w:p w:rsidR="006E0FDA" w:rsidRDefault="006E0FDA" w:rsidP="006E0FDA">
                                                <w:pPr>
                                                    <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                                </w:pPr>
                                                <w:r>
                                                    <w:separator/>
                                                </w:r>
                                            </w:p>
                                        </w:footnote>
                                        <w:footnote w:type="continuationSeparator" w:id="0">
                                            <w:p w:rsidR="006E0FDA" w:rsidRDefault="006E0FDA" w:rsidP="006E0FDA">
                                                <w:pPr>
                                                    <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                                </w:pPr>
                                                <w:r>
                                                    <w:continuationSeparator/>
                                                </w:r>
                                            </w:p>
                                        </w:footnote>
                                    </w:footnotes>';

    /**
     * @access public
     * @var string
     * @static
     */
    public static $notesRels = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                                <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
                                </Relationships>';

    /**
     * @access public
     * @var string
     * @static
     */
    public static $PHPDOCXStyles = '<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" >
                                        <w:style w:type="character" w:styleId="DefaultParagraphFontPHPDOCX">
                                            <w:name w:val="Default Paragraph Font PHPDOCX"/>
                                            <w:uiPriority w:val="1"/>
                                            <w:semiHidden/>
                                            <w:unhideWhenUsed/>
                                        </w:style>
                                        <w:style w:type="paragraph" w:styleId="ListParagraphPHPDOCX">
                                            <w:name w:val="List Paragraph PHPDOCX"/>
                                            <w:basedOn w:val="Normal"/>
                                            <w:uiPriority w:val="34"/>
                                            <w:qFormat/>
                                            <w:rsid w:val="00DF064E"/>
                                            <w:pPr>
                                                <w:ind w:left="720"/>
                                                <w:contextualSpacing/>
                                            </w:pPr>
                                        </w:style>
                                        <w:style w:type="paragraph" w:styleId="TitlePHPDOCX">
                                            <w:name w:val="Title PHPDOCX"/>
                                            <w:basedOn w:val="Normal"/>
                                            <w:next w:val="Normal"/>
                                            <w:link w:val="TitleCarPHPDOCX"/>
                                            <w:uiPriority w:val="10"/>
                                            <w:qFormat/>
                                            <w:rsid w:val="00DF064E"/>
                                            <w:pPr>
                                                <w:pBdr>
                                                    <w:bottom w:val="single" w:sz="8" w:space="4" w:color="4F81BD" w:themeColor="accent1"/>
                                                </w:pBdr>
                                                <w:spacing w:after="300" w:line="240" w:lineRule="auto"/>
                                                <w:contextualSpacing/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:asciiTheme="majorHAnsi" w:eastAsiaTheme="majorEastAsia" w:hAnsiTheme="majorHAnsi" w:cstheme="majorBidi"/>
                                                <w:color w:val="17365D" w:themeColor="text2" w:themeShade="BF"/>
                                                <w:spacing w:val="5"/>
                                                <w:kern w:val="28"/>
                                                <w:sz w:val="52"/>
                                                <w:szCs w:val="52"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="character" w:customStyle="1" w:styleId="TitleCarPHPDOCX">
                                            <w:name w:val="Title Car PHPDOCX"/>
                                            <w:basedOn w:val="DefaultParagraphFontPHPDOCX"/>
                                            <w:link w:val="TitlePHPDOCX"/>
                                            <w:uiPriority w:val="10"/>
                                            <w:rsid w:val="00DF064E"/>
                                            <w:rPr>
                                                <w:rFonts w:asciiTheme="majorHAnsi" w:eastAsiaTheme="majorEastAsia" w:hAnsiTheme="majorHAnsi" w:cstheme="majorBidi"/>
                                                <w:color w:val="17365D" w:themeColor="text2" w:themeShade="BF"/>
                                                <w:spacing w:val="5"/>
                                                <w:kern w:val="28"/>
                                                <w:sz w:val="52"/>
                                                <w:szCs w:val="52"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="paragraph" w:styleId="SubtitlePHPDOCX">
                                            <w:name w:val="Subtitle PHPDOCX"/>
                                            <w:basedOn w:val="Normal"/>
                                            <w:next w:val="Normal"/>
                                            <w:link w:val="SubtitleCarPHPDOCX"/>
                                            <w:uiPriority w:val="11"/>
                                            <w:qFormat/>
                                            <w:rsid w:val="00DF064E"/>
                                            <w:pPr>
                                                <w:numPr>
                                                    <w:ilvl w:val="1"/>
                                                </w:numPr>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:asciiTheme="majorHAnsi" w:eastAsiaTheme="majorEastAsia" w:hAnsiTheme="majorHAnsi" w:cstheme="majorBidi"/>
                                                <w:i/>
                                                <w:iCs/>
                                                <w:color w:val="4F81BD" w:themeColor="accent1"/>
                                                <w:spacing w:val="15"/>
                                                <w:sz w:val="24"/>
                                                <w:szCs w:val="24"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="character" w:customStyle="1" w:styleId="SubtitleCarPHPDOCX">
                                            <w:name w:val="Subtitle Car PHPDOCX"/>
                                            <w:basedOn w:val="DefaultParagraphFontPHPDOCX"/>
                                            <w:link w:val="SubtitlePHPDOCX"/>
                                            <w:uiPriority w:val="11"/>
                                            <w:rsid w:val="00DF064E"/>
                                            <w:rPr>
                                                <w:rFonts w:asciiTheme="majorHAnsi" w:eastAsiaTheme="majorEastAsia" w:hAnsiTheme="majorHAnsi" w:cstheme="majorBidi"/>
                                                <w:i/>
                                                <w:iCs/>
                                                <w:color w:val="4F81BD" w:themeColor="accent1"/>
                                                <w:spacing w:val="15"/>
                                                <w:sz w:val="24"/>
                                                <w:szCs w:val="24"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="table" w:styleId="NormalTablePHPDOCX">
                                            <w:name w:val="Normal Table PHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:unhideWhenUsed/>
                                            <w:qFormat/>
                                            <w:pPr>
                                                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                            </w:pPr>
                                            <w:tblPr>
                                                <w:tblInd w:w="0" w:type="dxa"/>
                                                <w:tblCellMar>
                                                    <w:top w:w="0" w:type="dxa"/>
                                                    <w:left w:w="108" w:type="dxa"/>
                                                    <w:bottom w:w="0" w:type="dxa"/>
                                                    <w:right w:w="108" w:type="dxa"/>
                                                </w:tblCellMar>
                                            </w:tblPr>
                                        </w:style>
                                        <w:style w:type="table" w:styleId="TableGridPHPDOCX">
                                            <w:name w:val="Table Grid PHPDOCX"/>
                                            <w:uiPriority w:val="59"/>
                                            <w:rsid w:val="00493A0C"/>
                                            <w:pPr>
                                                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                            </w:pPr>
                                            <w:tblPr>
                                                <w:tblInd w:w="0" w:type="dxa"/>
                                                <w:tblBorders>
                                                    <w:top w:val="single" w:sz="4" w:space="0" w:color="auto"/>
                                                    <w:left w:val="single" w:sz="4" w:space="0" w:color="auto"/>
                                                    <w:bottom w:val="single" w:sz="4" w:space="0" w:color="auto"/>
                                                    <w:right w:val="single" w:sz="4" w:space="0" w:color="auto"/>
                                                    <w:insideH w:val="single" w:sz="4" w:space="0" w:color="auto"/>
                                                    <w:insideV w:val="single" w:sz="4" w:space="0" w:color="auto"/>
                                                </w:tblBorders>
                                                <w:tblCellMar>
                                                    <w:top w:w="0" w:type="dxa"/>
                                                    <w:left w:w="108" w:type="dxa"/>
                                                    <w:bottom w:w="0" w:type="dxa"/>
                                                    <w:right w:w="108" w:type="dxa"/>
                                                </w:tblCellMar>
                                            </w:tblPr>
                                        </w:style>
                                        <w:style w:type="character" w:styleId="CommentReferencePHPDOCX">
                                            <w:name w:val="annotation reference PHPDOCX"/>
                                            <w:basedOn w:val="DefaultParagraphFontPHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:unhideWhenUsed/>
                                            <w:rsid w:val="00E139EA"/>
                                            <w:rPr>
                                                <w:sz w:val="16"/>
                                                <w:szCs w:val="16"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="paragraph" w:styleId="CommentTextPHPDOCX">
                                            <w:name w:val="annotation text PHPDOCX"/>
                                            <w:basedOn w:val="Normal"/>
                                            <w:link w:val="CommentTextCharPHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:unhideWhenUsed/>
                                            <w:rsid w:val="00E139EA"/>
                                            <w:pPr>
                                                <w:spacing w:line="240" w:lineRule="auto"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:sz w:val="20"/>
                                                <w:szCs w:val="20"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="character" w:customStyle="1" w:styleId="CommentTextCharPHPDOCX">
                                            <w:name w:val="Comment Text Char PHPDOCX"/>
                                            <w:basedOn w:val="DefaultParagraphFontPHPDOCX"/>
                                            <w:link w:val="CommentTextPHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:rsid w:val="00E139EA"/>
                                            <w:rPr>
                                                <w:sz w:val="20"/>
                                                <w:szCs w:val="20"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="paragraph" w:styleId="CommentSubjectPHPDOCX">
                                            <w:name w:val="annotation subject PHPDOCX"/>
                                            <w:basedOn w:val="CommentTextPHPDOCX"/>
                                            <w:next w:val="CommentTextPHPDOCX"/>
                                            <w:link w:val="CommentSubjectCharPHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:unhideWhenUsed/>
                                            <w:rsid w:val="00E139EA"/>
                                            <w:rPr>
                                                <w:b/>
                                                <w:bCs/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="character" w:customStyle="1" w:styleId="CommentSubjectCharPHPDOCX">
                                            <w:name w:val="Comment Subject Char PHPDOCX"/>
                                            <w:basedOn w:val="CommentTextCharPHPDOCX"/>
                                            <w:link w:val="CommentSubjectPHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:rsid w:val="00E139EA"/>
                                            <w:rPr>
                                                <w:b/>
                                                <w:bCs/>
                                                <w:sz w:val="20"/>
                                                <w:szCs w:val="20"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="paragraph" w:styleId="BalloonTextPHPDOCX">
                                            <w:name w:val="Balloon Text PHPDOCX"/>
                                            <w:basedOn w:val="Normal"/>
                                            <w:link w:val="BalloonTextCharPHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:unhideWhenUsed/>
                                            <w:rsid w:val="00E139EA"/>
                                            <w:pPr>
                                                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Tahoma" w:hAnsi="Tahoma" w:cs="Tahoma"/>
                                                <w:sz w:val="16"/>
                                            <w:szCs w:val="16"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="character" w:customStyle="1" w:styleId="BalloonTextCharPHPDOCX">
                                            <w:name w:val="Balloon Text Char PHPDOCX"/>
                                            <w:basedOn w:val="DefaultParagraphFontPHPDOCX"/>
                                            <w:link w:val="BalloonTextPHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:rsid w:val="00E139EA"/>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Tahoma" w:hAnsi="Tahoma" w:cs="Tahoma"/>
                                                <w:sz w:val="16"/>
                                                <w:szCs w:val="16"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="paragraph" w:styleId="footnoteTextPHPDOCX">
                                            <w:name w:val="footnote Text PHPDOCX"/>
                                            <w:basedOn w:val="Normal"/>
                                            <w:link w:val="footnoteTextCarPHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:unhideWhenUsed/>
                                            <w:rsid w:val="006E0FDA"/>
                                            <w:pPr>
                                                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:sz w:val="20"/>
                                                <w:szCs w:val="20"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="character" w:customStyle="1" w:styleId="footnoteTextCarPHPDOCX">
                                            <w:name w:val="footnote Text Car PHPDOCX"/>
                                            <w:basedOn w:val="DefaultParagraphFontPHPDOCX"/>
                                            <w:link w:val="footnoteTextPHPDOCX"/>
                                            <w:uiPriority w:val="99"/>
                                            <w:semiHidden/>
                                            <w:rsid w:val="006E0FDA"/>
                                            <w:rPr>
                                                <w:sz w:val="20"/>
                                                <w:szCs w:val="20"/>
                                            </w:rPr>
                                        </w:style>
                                        <w:style w:type="character" w:styleId="footnoteReferencePHPDOCX">
                                        <w:name w:val="footnote Reference PHPDOCX"/>
                                        <w:basedOn w:val="DefaultParagraphFontPHPDOCX"/>
                                        <w:uiPriority w:val="99"/>
                                        <w:semiHidden/>
                                        <w:unhideWhenUsed/>
                                        <w:rsid w:val="006E0FDA"/>
                                        <w:rPr>
                                            <w:vertAlign w:val="superscript"/>
                                        </w:rPr>
                                    </w:style>
                                    <w:style w:type="paragraph" w:styleId="endnoteTextPHPDOCX">
                                        <w:name w:val="endnote Text PHPDOCX"/>
                                        <w:basedOn w:val="Normal"/>
                                        <w:link w:val="endnoteTextCarPHPDOCX"/>
                                        <w:uiPriority w:val="99"/>
                                        <w:semiHidden/>
                                        <w:unhideWhenUsed/>
                                        <w:rsid w:val="006E0FDA"/>
                                        <w:pPr>
                                            <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                        </w:pPr>
                                        <w:rPr>
                                            <w:sz w:val="20"/>
                                            <w:szCs w:val="20"/>
                                        </w:rPr>
                                    </w:style>
                                    <w:style w:type="character" w:customStyle="1" w:styleId="endnoteTextCarPHPDOCX">
                                        <w:name w:val="endnote Text Car PHPDOCX"/>
                                        <w:basedOn w:val="DefaultParagraphFontPHPDOCX"/>
                                        <w:link w:val="endnoteTextPHPDOCX"/>
                                        <w:uiPriority w:val="99"/>
                                        <w:semiHidden/>
                                        <w:rsid w:val="006E0FDA"/>
                                        <w:rPr>
                                            <w:sz w:val="20"/>
                                            <w:szCs w:val="20"/>
                                        </w:rPr>
                                    </w:style>
                                    <w:style w:type="character" w:styleId="endnoteReferencePHPDOCX">
                                        <w:name w:val="endnote Reference PHPDOCX"/>
                                        <w:basedOn w:val="DefaultParagraphFontPHPDOCX"/>
                                        <w:uiPriority w:val="99"/>
                                        <w:semiHidden/>
                                        <w:unhideWhenUsed/>
                                        <w:rsid w:val="006E0FDA"/>
                                        <w:rPr>
                                            <w:vertAlign w:val="superscript"/>
                                        </w:rPr>
                                    </w:style>
                                 </w:styles>';

    /**
     * @access public
     * @var string
     * @static
     */
    public static $unorderedListStyle = '<w:abstractNum w:abstractNumId="" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" >
                                        <w:multiLevelType w:val="hybridMultilevel"/>
                                        <w:lvl w:ilvl="0" w:tplc="">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="bullet"/>
                                            <w:lvlText w:val=""/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="720" w:hanging="360"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Symbol" w:hAnsi="Symbol" w:hint="default"/>
                                            </w:rPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="1" w:tplc="0C0A0003" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="bullet"/>
                                            <w:lvlText w:val="o"/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="1440" w:hanging="360"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Courier New" w:hAnsi="Courier New" w:cs="Courier New" w:hint="default"/>
                                            </w:rPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="2" w:tplc="0C0A0005" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="bullet"/>
                                            <w:lvlText w:val=""/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="2160" w:hanging="360"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Wingdings" w:hAnsi="Wingdings" w:hint="default"/>
                                            </w:rPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="3" w:tplc="0C0A0001" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="bullet"/>
                                            <w:lvlText w:val=""/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="2880" w:hanging="360"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Symbol" w:hAnsi="Symbol" w:hint="default"/>
                                            </w:rPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="4" w:tplc="0C0A0003" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="bullet"/>
                                            <w:lvlText w:val="o"/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="3600" w:hanging="360"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Courier New" w:hAnsi="Courier New" w:cs="Courier New" w:hint="default"/>
                                            </w:rPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="5" w:tplc="0C0A0005" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="bullet"/>
                                            <w:lvlText w:val=""/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="4320" w:hanging="360"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Wingdings" w:hAnsi="Wingdings" w:hint="default"/>
                                            </w:rPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="6" w:tplc="0C0A0001" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="bullet"/>
                                            <w:lvlText w:val=""/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="5040" w:hanging="360"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Symbol" w:hAnsi="Symbol" w:hint="default"/>
                                            </w:rPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="7" w:tplc="0C0A0003" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="bullet"/>
                                            <w:lvlText w:val="o"/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="5760" w:hanging="360"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Courier New" w:hAnsi="Courier New" w:cs="Courier New" w:hint="default"/>
                                            </w:rPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="8" w:tplc="0C0A0005" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="bullet"/>
                                            <w:lvlText w:val=""/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="6480" w:hanging="360"/>
                                            </w:pPr>
                                            <w:rPr>
                                                <w:rFonts w:ascii="Wingdings" w:hAnsi="Wingdings" w:hint="default"/>
                                            </w:rPr>
                                        </w:lvl>
                                    </w:abstractNum>';

    /**
     * @access public
     * @var ostring
     * @static
     */
    public static $orderedListStyle = '<w:abstractNum w:abstractNumId="" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" >
                                        <w:multiLevelType w:val="hybridMultilevel"/>
                                        <w:lvl w:ilvl="0" w:tplc="">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="decimal"/>
                                            <w:lvlText w:val="%1."/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="720" w:hanging="360"/>
                                            </w:pPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="1" w:tplc="" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="lowerLetter"/>
                                            <w:lvlText w:val="%2."/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="1440" w:hanging="360"/>
                                            </w:pPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="2" w:tplc="" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="lowerRoman"/>
                                            <w:lvlText w:val="%3."/>
                                            <w:lvlJc w:val="right"/>
                                            <w:pPr>
                                                <w:ind w:left="2160" w:hanging="180"/>
                                            </w:pPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="3" w:tplc="" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="decimal"/>
                                            <w:lvlText w:val="%4."/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="2880" w:hanging="360"/>
                                            </w:pPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="4" w:tplc="" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="lowerLetter"/>
                                            <w:lvlText w:val="%5."/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="3600" w:hanging="360"/>
                                            </w:pPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="5" w:tplc="" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="lowerRoman"/>
                                            <w:lvlText w:val="%6."/>
                                            <w:lvlJc w:val="right"/>
                                            <w:pPr>
                                                <w:ind w:left="4320" w:hanging="180"/>
                                            </w:pPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="6" w:tplc="" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="decimal"/>
                                            <w:lvlText w:val="%7."/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="5040" w:hanging="360"/>
                                            </w:pPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="7" w:tplc="" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="lowerLetter"/>
                                            <w:lvlText w:val="%8."/>
                                            <w:lvlJc w:val="left"/>
                                            <w:pPr>
                                                <w:ind w:left="5760" w:hanging="360"/>
                                            </w:pPr>
                                        </w:lvl>
                                        <w:lvl w:ilvl="8" w:tplc="" w:tentative="1">
                                            <w:start w:val="1"/>
                                            <w:numFmt w:val="lowerRoman"/>
                                            <w:lvlText w:val="%9."/>
                                            <w:lvlJc w:val="right"/>
                                            <w:pPr>
                                                <w:ind w:left="6480" w:hanging="180"/>
                                            </w:pPr>
                                        </w:lvl>
                                    </w:abstractNum>';

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $paragraphProperties = array('w:pStyle',
        'w:keepNext',
        'w:keepLines',
        'w:pageBreakBefore',
        'w:framePr',
        'w:widowControl',
        'w:numPr',
        'w:suppressLineNumbers',
        'w:pBdr',
        'w:shd',
        'w:tabs',
        'w:suppressAutoHyphens',
        'w:kinsoku',
        'w:wordWrap',
        'w:overflowPunct',
        'w:topLinePunct',
        'w:autoSpaceDE',
        'w:autoSpaceDN',
        'w:bidi',
        'w:adjustRightInd',
        'w:snapToGrid',
        'w:spacing',
        'w:ind',
        'w:contextualSpacing',
        'w:mirrorIndents',
        'w:suppressOverlap',
        'w:jc',
        'w:textDirectio',
        'w:textAlignment',
        'w:textboxTightWrap',
        'w:outlineLvl',
        'w:divId',
        'w:cnfStyle',
        'w:rPr',
        'w:sectPr',
        'w:pPrChange'
    );

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $runProperties = array('w:rStyle',
        'w:rFonts',
        'w:b',
        'w:bCs',
        'w:i',
        'w:iCs',
        'w:caps',
        'w:smallCaps',
        'w:strike',
        'w:dstrike',
        'w:outline',
        'w:shadow',
        'w:emboss',
        'w:imprint',
        'w:noProof',
        'w:snapToGrid',
        'w:vanish',
        'w:webHidden',
        'w:color',
        'w:spacin',
        'w:w',
        'w:kern',
        'w:position',
        'w:sz',
        'w:szCs',
        'w:highlight',
        'w:u',
        'w:effect',
        'w:bdr',
        'w:shd',
        'w:fitText',
        'w:vertAlign',
        'w:rtl',
        'w:cs',
        'w:em',
        'w:lang',
        'w:eastAsianLayout',
        'w:specVanish',
        'w:oMath'
    );

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $sectionProperties = array('w:footnotePr',
        'w:endnotePr',
        'w:type',
        'w:pgSz',
        'w:pgMar',
        'w:paperSrc',
        'w:pgBorders',
        'w:lnNumType',
        'w:pgNumType',
        'w:cols',
        'w:formProt',
        'w:vAlign',
        'w:noEndnote',
        'w:titlePg',
        'w:textDirection',
        'w:bidi',
        'w:rtlGutter',
        'w:docGrid',
        'w:printerSettings',
        'w:sectPrChange'
    );

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $settings = array('w:writeProtection',
        'w:view',
        'w:zoom',
        'w:removePersonalInformation',
        'w:removeDateAndTime',
        'w:doNotDisplayPageBoundaries',
        'w:displayBackgroundShape',
        'w:printPostScriptOverText',
        'w:printFractionalCharacterWidth',
        'w:printFormsData',
        'w:embedTrueTypeFonts',
        'w:embedSystemFonts',
        'w:saveSubsetFonts',
        'w:saveFormsData',
        'w:mirrorMargins',
        'w:alignBordersAndEdges',
        'w:bordersDoNotSurroundHeader',
        'w:bordersDoNotSurroundFooter',
        'w:gutterAtTop',
        'w:hideSpellingErrors',
        'w:hideGrammaticalErrors',
        'w:activeWritingStyle',
        'w:proofState',
        'w:formsDesign',
        'w:attachedTemplate',
        'w:linkStyles',
        'w:stylePaneFormatFilter',
        'w:stylePaneSortMethod',
        'w:documentType',
        'w:mailMerge',
        'w:revisionView',
        'w:trackRevisions',
        'w:doNotTrackMoves',
        'w:doNotTrackFormatting',
        'w:documentProtection',
        'w:autoFormatOverride',
        'w:styleLockTheme',
        'w:styleLockQFSet',
        'w:defaultTabStop',
        'w:autoHyphenation',
        'w:consecutiveHyphenLimit',
        'w:hyphenationZone',
        'w:doNotHyphenateCaps',
        'w:showEnvelope',
        'w:summaryLength',
        'w:clickAndTypeStyle',
        'w:defaultTableStyle',
        'w:evenAndOddHeaders',
        'w:bookFoldRevPrinting',
        'w:bookFoldPrinting',
        'w:bookFoldPrintingSheets',
        'w:drawingGridHorizontalSpacing',
        'w:drawingGridVerticalSpacing',
        'w:displayHorizontalDrawingGridEvery',
        'w:displayVerticalDrawingGridEvery',
        'w:doNotUseMarginsForDrawingGridOrigin',
        'w:drawingGridHorizontalOrigin',
        'w:drawingGridVerticalOrigin',
        'w:doNotShadeFormData',
        'w:noPunctuationKerning',
        'w:characterSpacingControl',
        'w:printTwoOnOne',
        'w:strictFirstAndLastChars',
        'w:noLineBreaksAfter',
        'w:noLineBreaksBefore',
        'w:savePreviewPicture',
        'w:doNotValidateAgainstSchema',
        'w:saveInvalidXml',
        'w:ignoreMixedContent',
        'w:alwaysShowPlaceholderText',
        'w:doNotDemarcateInvalidXml',
        'w:saveXmlDataOnly',
        'w:useXSLTWhenSaving',
        'w:saveThroughXslt',
        'w:showXMLTags',
        'w:alwaysMergeEmptyNamespace',
        'w:updateFields',
        'w:hdrShapeDefaults',
        'w:footnotePr',
        'w:endnotePr',
        'w:compat',
        'w:docVars',
        'w:rsids',
        'm:mathPr',
        'w:uiCompat97To2003',
        'w:attachedSchema',
        'w:themeFontLang',
        'w:clrSchemeMapping',
        'w:doNotIncludeSubdocsInStats',
        'w:doNotAutoCompressPictures',
        'w:forceUpgrade',
        'w:captions',
        'w:readModeInkLockDown',
        'w:smartTagType',
        'sl:schemaLibrary',
        'w:shapeDefaults',
        'w:doNotEmbedSmartTags',
        'w:decimalSymbol',
        'w:listSeparator'
    );

    /**
     * Class constructor
     */
    public function __construct()
    {
        
    }

    /**
     * Class destructor
     */
    public function __destruct()
    {
        
    }

    /**
     * @access public
     * @static
     * @param int $integer 
     * @param bool $uppercase
     * @return string
     */
    public static function integer2Letter($integer, $uppercase = false)
    {
        $letter = '';
        $integer = $integer - 1;
        $letter = chr(($integer % 26) + 97);
        $letter .= (floor($integer / 26) > 0) ? str_repeat($letter, floor($integer / 26)) : '';
        if ($uppercase)
            $letter = strtoupper($letter);
        return $letter;
    }

    /**
     * @access public
     * @static
     * @param int $integer 
     * @param bool $uppercase
     * @return string
     */
    public static function integer2RomanNumeral($integer, $uppercase = false)
    {
        $roman = '';
        $baseTransform = array('m' => 1000,
            'cm' => 900,
            'd' => 500,
            'cd' => 400,
            'c' => 100,
            'xc' => 90,
            'l' => 50,
            'xl' => 40,
            'x' => 10,
            'ix' => 9,
            'v' => 5,
            'iv' => 4,
            'i' => 1);
        foreach ($baseTransform as $key => $value) {
            $result = floor($integer / $value);
            $roman .= str_repeat($key, $result);
            $integer = $integer % $value;
        }
        if ($uppercase)
            $roman = strtoupper($roman);
        return $roman;
    }

    /**
     * @access public
     * @param DOMNode $targetNode this is the node where we want to insert the new child
     * @param DOMNode $sourceNode the child to be inserted
     * @param array $XMLSequence the sequence of childs given by the corresponding Schema for the target node
     * @param $type it can be ignore (if the node already exists jus leave silently, default value) or replace to overwrite the current node
     * @static
     */
    public static function insertNodeIntoSequence($targetNode, $sourceNode, $XMLSequence, $type = 'ignore')
    {
        //make sure that the $newNode belongs to the same DOM document as the $targetNode
        $newNode = $targetNode->ownerDocument->importNode($sourceNode, true);
        $nodeName = $newNode->nodeName;
        if ($nodeName == '#document-fragment') {
            $baseString = $newNode->ownerDocument->saveXML($newNode);
            $fragArray = explode(' ', $baseString);
            $nodeName = trim(str_replace('<', '', $fragArray[0]));
        }
        $sequenceIndex = array_search($nodeName, $XMLSequence);
        if (empty($sequenceIndex)) {
            //PhpdocxLogger::logger('The new node does not belong to the  given XML sequence', 'fatal');
        }
        $childNodes = $targetNode->childNodes;
        $append = true;
        foreach ($childNodes as $node) {
            $name = $node->nodeName;
            $index = array_search($node->nodeName, $XMLSequence);
            if ($index == $sequenceIndex) {
                if ($type == 'ignore') {
                    $append = false;
                    break;
                } else {
                    $node->parentNode->insertBefore($newNode, $node);
                    $node->parentNode->removeChild($node);
                    $append = false;
                    break;
                }
            } else if ($index > $sequenceIndex) {
                $node->parentNode->insertBefore($newNode, $node);
                $append = false;
                break;
            }
        }
        //in case no node was found we should append the node
        if ($append) {
            $targetNode->appendChild($newNode);
        }
    }

    /**
     * The child elements of the second node are added to the first node. If overwrite is set to true coincident nodes
     * will be overwritten
     * @access public
     * @param DOMNode $firstNode
     * @param DOMNode $secondNode
     * @param array $XMLSequence the sequence of childs given by the corresponding Schema for the given nodes
     * @param string $overwrite can take the values:
     * ignore (if the node already exists jus leave silently, default value) or replace to overwrite the current node
     * @param array $exceptions exceptions to teh overwrite rule
     * @static
     */
    public static function mergeXMLNodes($firstNode, $secondNode, $XMLSequence, $overwrite = false, $exceptions = array())
    {
        $childs = $secondNode->childNodes;
        foreach ($childs as $child) {
            $name = $child->nodeName;
            if ($overwrite) {
                if (!in_array($name, $exceptions)) {
                    OOXMLResources::insertNodeIntoSequence($firstNode, $child, $XMLSequence, $type = 'replace');
                } else {
                    OOXMLResources::insertNodeIntoSequence($firstNode, $child, $XMLSequence);
                }
            } else {
                if (!in_array($name, $exceptions)) {
                    OOXMLResources::insertNodeIntoSequence($firstNode, $child, $XMLSequence);
                } else {
                    OOXMLResources::insertNodeIntoSequence($firstNode, $child, $XMLSequence, $type = 'replace');
                }
            }
        }
    }

}
