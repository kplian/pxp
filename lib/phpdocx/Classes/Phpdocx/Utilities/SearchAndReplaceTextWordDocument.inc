<?php
namespace Phpdocx\Utilities;
/**
 * This class allows to search and replace a string of text in an existing docx document
 * 
 * @category   Phpdocx
 * @package    utilities
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class SearchAndReplaceTextWordDocument
{

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_commentsDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_commentsXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_commentsXPath;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_documentDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_documentXML;

    /**
     *
     * @var ZipArchive
     * @access private
     */
    private $_docx;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_documentXPath;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_endnotesDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_endnotesXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_endnotesXPath;

    /**
     *
     * @var string
     * @access private
     */
    private $_footnotesXML;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_footnotesDOM;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_footnotesXPath;

    /**
     * Class constructor
     */
    public function __construct()
    {

        $this->_docx = new \ZipArchive();
        $this->_documentXML = '';
        $this->_footnotesXML = '';
        $this->_endnotesXML = '';
        $this->_commentsXML = '';
        $this->_commentsDOM = new \DOMDocument();
        $this->_documentDOM = new \DOMDocument();
        $this->_endnotesDOM = new \DOMDocument();
        $this->_footnotesDOM = new \DOMDocument();
    }

    /**
     * Class destructor
     */
    public function __destruct()
    {
        
    }

    /**
     * This is the main method that does all the needed manipulation to search
     * and replace text in a Word document
     * @access public
     * @param string $document path to the document
     * @param string $searchTerm string to be searched and replaced
     * @param string $replaceTerm string with the replacement text
     * @param array $options
     * @return void
     */
    public function searchAndReplace($document, $finalDocument, $searchTerm, $replaceTerm, $options)
    {
        //we make a copy of the the document into its final destination so we do not overwrite it
        copy($document, $finalDocument);
        //we extract (some) of the relevant files of the copy of the first document for manipulation
        $this->_docx->open($finalDocument);
        $this->_documentXML = $this->_docx->getFromName('word/document.xml');
        //$this->_footnotesXML = $this->_firstDocx->getFromName('word/footnotes.xml');
        //$this->_endnotesXML = $this->_firstDocx->getFromName('word/endnotes.xml');
        //$this->_commentsXML = $this->_firstDocx->getFromName('word/comments.xml');


        $this->_documentDOM->loadXML($this->_documentXML);



        //We prepare the document for XPath
        $this->_documentXPath = new \DOMXPath($this->_documentDOM);
        $this->_documentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');

        //Let us now get the paragraphs that contain the search term
        $query = '//w:p';

        //echo $query;
        $docPs = $this->_documentXPath->query($query);

        foreach ($docPs as $node) {
            $paragraphContents = $node->ownerDocument->saveXML($node);
            $paragraphText = strip_tags($paragraphContents);
            if (($pos = strpos($paragraphText, $searchTerm, 0)) !== false) {
                $this->replaceString($node, $searchTerm, $replaceTerm);
            }
        }

        $newDocumentXML = $this->_documentDOM->saveXML();
        $this->_docx->addFromString('word/document.xml', $newDocumentXML);

        //we finally close the zip file
        $this->_docx->close();
    }

    /**
     * This is the method that does all the needed manipulation to search
     * and higlight text in a Word document
     * @access public
     * @param string $document path to the document
     * @param string $searchTerm string to be searched and replaced
     * @param array $options for highlighting
     * @return void
     */
    public function searchAndHighlight($document, $finalDocument, $searchTerm, $options)
    {
        //we make a copy of the the document into its final destination so we do not overwrite it
        copy($document, $finalDocument);
        //we extract (some) of the relevant files of the copy of the first document for manipulation
        $this->_docx->open($finalDocument);
        $this->_documentXML = $this->_docx->getFromName('word/document.xml');
        //$this->_footnotesXML = $this->_firstDocx->getFromName('word/footnotes.xml');
        //$this->_endnotesXML = $this->_firstDocx->getFromName('word/endnotes.xml');
        //$this->_commentsXML = $this->_firstDocx->getFromName('word/comments.xml');


        $this->_documentDOM->loadXML($this->_documentXML);



        //We prepare the document for XPath
        $this->_documentXPath = new \DOMXPath($this->_documentDOM);
        $this->_documentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');

        //We prepare the document for XPath
        $this->_documentXPath = new \DOMXPath($this->_documentDOM);
        $this->_documentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');

        //Let us now get the paragraphs that contain the search term
        $query = '//w:p';

        //echo $query;
        $docPs = $this->_documentXPath->query($query);

        foreach ($docPs as $node) {
            $paragraphContents = $node->ownerDocument->saveXML($node);
            $paragraphText = strip_tags($paragraphContents);
            if (($pos = strpos($paragraphText, $searchTerm, 0)) !== false) {
                $this->highlightString($node, $searchTerm);
            }
        }

        //At this point we have got the DOM Document prepared for the final higlighting
        //We should select all runs with attribute highlight = 1 and include the higligthing

        $query = '//w:r[@highlight="1"]';

        $affectedRs = $this->_documentXPath->query($query);
        foreach ($affectedRs as $node) {
            //echo $node->ownerDocument->saveXML($node);
            $firstChild = $node->firstChild;
            $highlight = $this->_documentDOM->createElementNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'highlight');
            $highlight->setAttribute('w:val', $options['highlightColor']);

            if ($firstChild->nodeName == 'w:rPr') {
                $firstChild->appendChild($highlight);
            } else {
                $rPrNode = $this->_documentDOM->createElementNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'rPr');
                $node->insertBefore($rPrNode, $firstChild);
                $rPrNode->appendChild($highlight);
            }
            $node->removeAttribute('highlight');
        }

        $newDocumentXML = $this->_documentDOM->saveXML();
        $this->_docx->addFromString('word/document.xml', $newDocumentXML);

        //we finally close the zip file
        $this->_docx->close();
    }

    /**
     * This is the method that replaces the search term.
     * It takes into account that the text may be split among different runs
     * @access private
     * @param DOMNode $paragraph the node to be changed
     * @param string $searchTerm string to be searched and replaced
     * @param string $replaceTerm the replacement text
     * @param array $options for highlighting
     * @return void
     */
    private function replaceString($paragraph, $searchTerm, $replaceTerm)
    {
        $lengthSearchTerm = strlen($searchTerm);
        $lengthReplaceTerm = strlen($replaceTerm);
        $paragraphText = '';
        $textChilds = $paragraph->getElementsByTagName('t');
        foreach ($textChilds as $node) {
            $paragraphText .= $node->nodeValue;
        }
        //echo $paragraphText.PHP_EOL;
        $results = array();
        $results = $this->getIndexOf($paragraphText, $searchTerm);

        $position = 0;
        foreach ($textChilds as $node) {
            $text = strip_tags($node->ownerDocument->saveXML($node));
            //echo $text.PHP_EOL;
            $numChars = strlen($text);
            $offset = 0;
            $affectedNode = 0;
            for ($j = 0; $j < count($results); $j++) {
                //We first check if that particular run may be affected by the replacement
                if (($position + $numChars) > $results[$j] && $position < ($results[$j] + $lengthSearchTerm)) {
                    $affectedNode = 1;
                    //echo $affectedNode.PHP_EOL;
                    if ($position <= $results[$j] && ($position + $numChars) >= ($results[$j] + $lengthSearchTerm)) {
                        //In this case the string to be replaced falls completely within the scope of this run
                        //The we will extract that ocurrence of the searchTerm and replace it directly by the replaceTerm
                        $firstTextChunk = substr($text, 0, $results[$j] - $position + $offset);
                        $secondTextChunk = substr($text, $results[$j] - $position + $lengthSearchTerm + $offset);
                        $text = $firstTextChunk . $replaceTerm . $secondTextChunk;
                        //Whenever we make a substitution we have to take into account that the length of the text has changed
                        $offset += $lengthReplaceTerm - $lengthSearchTerm;
                    } else if ($position <= $results[$j] && ($position + $numChars) < ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced starts in this run but continues in next one
                        $firstTextChunk = substr($text, 0, $results[$j] - $position + $offset);
                        $text = $firstTextChunk . $replaceTerm;
                    } else if ($position > $results[$j] && ($position + $numChars) < ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced has started in a previous run and continue in other run
                        $text = '';
                    } else if ($position > $results[$j] && ($position + $numChars) >= ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced has started in a previous run and finish in this run
                        $text = substr($text, $results[$j] + $lengthSearchTerm - $position);
                        $offset = $results[$j] + $lengthSearchTerm - $position;
                    }
                    $node->nodeValue = $text;
                }
            }
            $position += $numChars;
        }
    }

    /**
     * This is the method that replaces the search term.
     * It takes into account that the text may be split among different runs
     * @access private
     * @param DOMNode $paragraph the node to be changed
     * @param string $searchTerm string to be searched and highlighted
     * @param array $options for highlighting
     * @return void
     */
    private function highlightString($paragraph, $searchTerm)
    {
        $lengthSearchTerm = strlen($searchTerm);
        $replaceTerm = $searchTerm;
        $lengthReplaceTerm = strlen($replaceTerm) + 16; //we have added the length of wrapper _$_highlight__$_
        $paragraphText = '';
        $textChilds = $paragraph->getElementsByTagName('t');
        foreach ($textChilds as $node) {
            $paragraphText .= $node->nodeValue;
        }
        $results = array();
        $results = $this->getIndexOf($paragraphText, $searchTerm);



        $position = 0;
        foreach ($textChilds as $node) {
            $text = strip_tags($node->ownerDocument->saveXML($node));
            //echo $text.PHP_EOL;
            $numChars = strlen($text);
            $offset = 0;
            $affectedNode = 0;
            for ($j = 0; $j < count($results); $j++) {
                //We first check if that particular run may be affected by the replacement
                if (($position + $numChars) > $results[$j] && $position < ($results[$j] + $lengthSearchTerm)) {
                    $affectedNode = 1;
                    //echo $affectedNode.PHP_EOL;
                    if ($position <= $results[$j] && ($position + $numChars) >= ($results[$j] + $lengthSearchTerm)) {
                        //In this case the string to be highlighted falls completely within the scope of this run
                        //The we will extract that ocurrence of the searchTerm and replace it directly by the replaceTerm
                        $firstTextChunk = substr($text, 0, $results[$j] - $position + $offset);
                        $secondTextChunk = substr($text, $results[$j] - $position + $lengthSearchTerm + $offset);
                        $text = $firstTextChunk . '_$_highlight_' . $replaceTerm . '_$_' . $secondTextChunk;
                        //Whenever we make a substitution we have to take into account that the length of the text has changed
                        $offset += $lengthReplaceTerm - $lengthSearchTerm;
                    } else if ($position <= $results[$j] && ($position + $numChars) < ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced starts in this run but continues in next one
                        $firstTextChunk = substr($text, 0, $results[$j] - $position + $offset);
                        $text = $firstTextChunk . '_$_highlight_' . substr($searchTerm, 0, ($position + $numChars - $results[$j])) . '_$_';
                    } else if ($position > $results[$j] && ($position + $numChars) < ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced has started in a previous run and continue in other run
                        $text = '_$_highlight_' . $text . '_$_';
                    } else if ($position > $results[$j] && ($position + $numChars) >= ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced has started in a previous run and finish in this run
                        $text = '_$_highlight_' . substr($text, 0, $results[$j] + $lengthSearchTerm - $position) . '_$_' . substr($text, $results[$j] + $lengthSearchTerm - $position);
                        $offset = $results[$j] + $lengthSearchTerm - $position;
                    }
                    $node->nodeValue = $text;
                }
            }
            $position += $numChars;
        }

        //Now we are going to run again all child nodes to separate the runs for the highlighted content

        $query = $paragraph->getNodePath() . '//w:r';
        $affectedRs = $this->_documentXPath->query($query);

        foreach ($affectedRs as $node) {
            $text = strip_tags($node->ownerDocument->saveXML($node));
            //echo $text.PHP_EOL;
            if (($pos = strpos($text, '_$_highlight', 0)) !== false) {
                $textArray = explode('_$_', $text);
                for ($k = 0; $k < count($textArray); $k++) {
                    $baseNode = $node->cloneNode(true);
                    if ($k < (count($textArray) - 1)) {
                        //we want to remove other siblings than rPr and t 
                        //in all but in the last run insertion
                        $baseNodeChilds = $baseNode->childNodes;
                        foreach ($baseNodeChilds as $tSibling) {
                            if ($tSibling->nodeName != 'w:rPr' && $tSibling->nodeName != 'w:t') {
                                $tSibling->parentNode->removeChild($tSibling);
                            }
                        }
                    }
                    $textNode = $baseNode->getElementsByTagName('t')->item(0);
                    if (($pos = strpos($textArray[$k], 'highlight_', 0)) !== false) {
                        $textArray[$k] = substr($textArray[$k], 10);
                        $baseNode->setAttribute('highlight', 1);
                    }
                    $textNode->nodeValue = $textArray[$k];
                    $textNode->setAttribute('xml:space', 'preserve');

                    $node->parentNode->insertBefore($baseNode, $node);
                }
                $node->setAttribute('remove', 1);
            }
        }


        $query = $paragraph->getNodePath() . '//w:r';
        $affectedRs = $this->_documentXPath->query($query);
        for ($n = ($affectedRs->length - 1); $n > 0; $n--) {
            $toRemove = $affectedRs->item($n)->getAttribute('remove');
            if ($toRemove == 1) {
                $affectedRs->item($n)->parentNode->removeChild($affectedRs->item($n));
            }
        }
    }

    /**
     * It returns the indexesz of all ocurrences of a needdle in a string
     * @access private
     * @param string $myString the string to be searched
     * @param string $search the text to be searched
     * @return array
     */
    private function getIndexOf($myString, $search)
    {
        $initialChar = 0;
        $charIndexes = array();
        $lengthSearchTerm = strlen($search);
        while (($pos = strpos($myString, $search, $initialChar)) !== false) {
            $charIndexes[] = $pos;
            $initialChar = $pos + $lengthSearchTerm;
        }
        return $charIndexes;
    }

}
