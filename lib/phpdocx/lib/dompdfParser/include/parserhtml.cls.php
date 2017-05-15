<?php
/**
 * PARSERHTML - PHP5 HTML to PDF renderer
 *
 * File: $RCSfile: parserhtml.cls.php,v $
 * Created on: 2004-06-09
 *
 * Copyright (c) 2004 - Benj Carson <benjcarson@digitaljunkies.ca>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library in the file LICENSE.LGPL; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 * 02111-1307 USA
 *
 * Alternatively, you may distribute this software under the terms of the
 * PHP License, version 3.0 or later.  A copy of this license should have
 * been distributed with this file in the file LICENSE.PHP .  If this is not
 * the case, you can obtain a copy at http://www.php.net/license/3_0.txt.
 *
 * The latest version of DOMPDF might be available at:
 * http://www.dompdf.com/
 *
 * @link http://www.dompdf.com/
 * @copyright 2004 Benj Carson
 * @author Benj Carson <benjcarson@digitaljunkies.ca>
 * @package dompdf

 */

/* $Id: dompdf.cls.php 362 2011-02-16 22:17:28Z fabien.menager $ */

/**
 * PARSERHTML - PHP5 HTML to PDF renderer
 *
 * DOMPDF loads HTML and does its best to render it as a PDF.  It gets its
 * name from the new DomDocument PHP5 extension.  Source HTML is first
 * parsed by a DomDocument object.  DOMPDF takes the resulting DOM tree and
 * attaches a {@link FrameParser} object to each node.  {@link FrameParser} objects store
 * positioning and layout information and each has a reference to a {@link
 * StyleParser} object.
 *
 * StyleParser information is loaded and parsed (see {@link StyleParsersheet}) and is
 * applied to the frames in the tree by using XPath.  CSS selectors are
 * converted into XPath queries, and the computed {@link StyleParser} objects are
 * applied to the {@link FrameParser}s.
 *
 * {@link FrameParser}s are then decorated (in the design pattern sense of the
 * word) based on their CSS display property ({@link
 * http://www.w3.org/TR/CSS21/visuren.html#propdef-display}).
 * FrameParser_Decorators augment the basic {@link FrameParser} class by adding
 * additional properties and methods specific to the particular type of
 * {@link FrameParser}.  For example, in the CSS layout model, block frames
 * (display: block;) contain line boxes that are usually filled with text or
 * other inline frames.  The Block_FrameParser_Decorator therefore adds a $lines
 * property as well as methods to add {@link FrameParser}s to lines and to add
 * additional lines.  {@link FrameParser}s also are attached to specific
 * Positioner and {@link FrameParser_Reflower} objects that contain the
 * positioining and layout algorithm for a specific type of frame,
 * respectively.  This is an application of the Strategy pattern.
 *
 * Layout, or reflow, proceeds recursively (post-order) starting at the root
 * of the document.  Space constraints (containing block width & height) are
 * pushed down, and resolved positions and sizes bubble up.  Thus, every
 * {@link FrameParser} in the document tree is traversed once (except for tables
 * which use a two-pass layout algorithm).  If you are interested in the
 * details, see the reflow() method of the Reflower classes.
 *
 * Rendering is relatively straightforward once layout is complete. {@link
 * FrameParser}s are rendered using an adapted {@link Cpdf} class, originally
 * written by Wayne Munro, http://www.ros.co.nz/pdf/.  (Some performance
 * related changes have been made to the original {@link Cpdf} class, and
 * the {@link CPDF_Adapter} class provides a simple, stateless interface to
 * PDF generation.)  PDFLib support has now also been added, via the {@link
 * PDFLib_Adapter}.
 *
 *
 * @package parserhtml
 */
class PARSERHTML {

  /**
     *
     * @access public
     * @static
     * @var array
     */
  public static $noDiv = array('p', 'li', 'span', 'strong', 'em', 'u', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6');
  /**
   * DomDocument representing the HTML document
   *
   * @var DomDocument
   */
  protected $_xml;

  /**
   * FrameParser_Tree derived from the DOM tree
   *
   * @var FrameParser_Tree
   */
  protected $_tree;

  /**
   * StyleParsersheet for the document
   *
   * @var StyleParsersheet
   */
  protected $_css;

  /**
   * Actual PDF renderer
   *
   * @var Canvas
   */
  protected $_pdf;

  /**
   * Desired paper size ('letter', 'legal', 'A4', etc.)
   *
   * @var string
   */
  protected $_paper_size;

  /**
   * Paper orientation ('portrait' or 'landscape')
   *
   * @var string
   */
  protected $_paper_orientation;

  /**
   * Callbacks on new page and new element
   *
   * @var array
   */
  protected $_callbacks;

  /**
   * Experimental caching capability
   *
   * @var string
   */
  private $_cache_id;

  /**
   * Base hostname
   *
   * Used for relative paths/urls
   * @var string
   */
  protected $_base_host;

  /**
   * Absolute base path
   *
   * Used for relative paths/urls
   * @var string
   */
  protected $_base_path;

  /**
   * If "advanced" parse floating divs as tables, no floating divs as p
   *
   * @var string
   */
  private $parseDivs;

  /**
   * Protcol used to request file (file://, http://, etc)
   *
   * @var string
   */
  protected $_protocol;
  
  /**
   * Timestamp of the script start time
   *
   * @var int
   */
  private $_start_time = null;
  
  /**
   * @var string The system's locale
   */
  private $_system_locale = null;
  
  /**
   * @var bool Tells if the system's locale is the C standard one
   */
  private $_locale_standard = false;

	/**
	 * Simple DOMPdf tree
	 *
	 * @var array
	 * @access private
	 * @see dompdf_treeOut::getDompdfTree()
	 */
	private $aDompdfTree;

	/**
	 * HTML file url
	 *
	 * @var string
	 * @access private
	 */
	private $htmlFile;

	/**
	 * Resolved domains for relative files
	 *
	 * @var string
	 * @access private
	 */
	private $aDomainsResolved;

  /**
   * Class constructor
   */
  function __construct() {
    $this->_locale_standard = sprintf('%.1f', 1.0) == '1.0';

    $this->save_locale();

    $this->_messages = array();
    $this->_xml = new DOMDocument();
    $this->_xml->preserveWhiteSpace = true;
    $this->_tree = new FrameParser_Tree($this->_xml);
    $this->_css = new StyleParsersheet();
    $this->_pdf = null;
    $this->_paper_size = "letter";
    $this->_paper_orientation = "portrait";
    $this->_base_protocol = "";
    $this->_base_host = "";
    $this->_base_path = "";
    $this->_callbacks = array();
    $this->_cache_id = null;
    $this->parseDivs = false;
    $this->aDompdfTree = array();
    $this->htmlFile = 'http://'.$_SERVER['HTTP_HOST'].dirname($_SERVER['SCRIPT_NAME']); //TODO better protocol resolution
    $this->aDomainsResolved = array();

    $this->restore_locale();
  }

  /**
   * Class destructor
   */
  function __destruct() {
    clear_object_parser($this);
  }

  /**
   * Save the system's locale configuration and
   * set the right value for numeric formatting
   */
  private function save_locale() {
    if ( $this->_locale_standard ) return;

    $this->_system_locale = setlocale(LC_NUMERIC, "C");
  }

  /**
   * Restore the system's locale configuration
   */
  private function restore_locale() {
    if ( $this->_locale_standard ) return;

    setlocale(LC_NUMERIC, $this->_system_locale);
  }

  /**
   * Loads an HTML file
   *
   * Parse errors are stored in the global array _dompdf_warnings.
   *
   * @param string $file a filename or url to load
   */
  function load_html_file($file) {
		$this->save_locale();

		// Store parsing warnings as messages (this is to prevent output to the
		// browser if the html is ugly and the dom extension complains,
		// preventing the pdf from being streamed.)
		if ( !$this->_protocol && !$this->_base_host && !$this->_base_path )
			list($this->_protocol, $this->_base_host, $this->_base_path) = explode_url_parser($file);

		if ( !PARSERHTML_ENABLE_REMOTE && ($this->_protocol != "" && $this->_protocol !== "file://" ) )
			throw new Exception("Remote file requested, but PARSERHTML_ENABLE_REMOTE is false.");

		if ($this->_protocol == "" || $this->_protocol === "file://") {

			$realfile = realpath($file);
			if ( !$file )
				throw new Exception("File '$file' not found.");

			if ( strpos($realfile, PARSERHTML_CHROOT) !== 0 )
				throw new Exception("Permission denied on $file.");

			// Exclude dot files (e.g. .htaccess)
			if ( substr(basename($realfile),0,1) === "." )
				throw new Exception("Permission denied on $file.");

			$file = $realfile;
		}

		$context = stream_context_create(array('http'=>array(
			'method' => 'GET',
			'header' => "Cache-Control: no-cache"
				."Connection: close\r\n"
				."Referer: http://".$_SERVER['HTTP_HOST']."\r\n"
			,
			//'user_agent' => 'PHPDocX/2.5 ('.$_SERVER['HTTP_HOST'].'; '.PHP_OS.') HTML2WordML/load_html_file',
			'timeout' => '10'
		)));
		$contents = @file_get_contents(urldecode($file), false, $context);
		if($contents === false){/*var_dump($http_response_header);*/throw new Exception('Issue reading: '.$file);}
		if(strpos($file, 'http') === 0) $this->htmlFile = $file; //saves url for relative url when parsing
		$encoding = null;

		// See http://the-stickman.com/web-development/php/getting-http-response-headers-when-using-file_get_contents/
		if ( isset($http_response_header) ) {
			foreach($http_response_header as $_header) {
				if ( preg_match("@Content-Type:\s*[\w/]+;\s*?charset=([^\s]+)@i", $_header, $matches) ) {
					$encoding = strtoupper($matches[1]);
					break;
				}
			}
		}

		$this->restore_locale();

		$this->load_html($contents, $encoding);
  }

  /**
   * Loads an HTML string
   *
   * Parse errors are stored in the global array _dompdf_warnings.
   *
   * @param string $str HTML text to load
   */
  function load_html($str, $encoding = null) {
		$this->save_locale();

		$encoding = mb_detect_encoding($str, mb_list_encodings(), true);
		//var_dump('ini: '.$encoding);
		if ($encoding !== 'UTF-8') {
			$metatags = array(
			'@<meta\s+http-equiv="Content-Type"\s+content="(?:[\w/]+)(?:;\s*?charset=([^\s"]+))?@i',
			'@<meta\s+content="(?:[\w/]+)(?:;\s*?charset=([^\s"]+))"?\s+http-equiv="Content-Type"@i',
			);
			foreach($metatags as $metatag) {
				if (preg_match($metatag, $str, $matches)) break;
			}
			//redetecta segun metas
			if (empty($encoding)) {
				if (isset($matches[1])) {
					$encoding = strtoupper($matches[1]);
				} else {
					$encoding = 'UTF-8';
				}
			} else {
				if (isset($matches[1])) {
					$encoding = strtoupper($matches[1]);
				} else {
					$encoding = 'auto';
				}
			}

			if($encoding != 'UTF-8') $str = mb_convert_encoding($str, 'UTF-8', $encoding);

			if (isset($matches[1])) {
				$str = preg_replace('/charset=([^\s"]+)/i','charset=UTF-8', $str);
			} else {
				$str = str_replace('<head>', '<head><meta http-equiv="Content-Type" content="text/html;charset=UTF-8">', $str);
			}
		}

		// if the document contains non utf-8 with a utf-8 meta tag chars and was
		// detected as utf-8 by mbstring, problems could happen.
		// http://devzone.zend.com/article/8855
		if ( $encoding === 'UTF-8' ) {
			$str = preg_replace("/<meta([^>]+)>/", "", $str);
		}

		$str = $this->_load_html($str);

		// Store parsing warnings as messages
		set_error_handler("record_warnings_parser");
		$str = mb_convert_encoding($str, 'HTML-ENTITIES', 'UTF-8'); //DOMDocument::loadHTML tiene problemas con cadenas en utf 8
		$this->_xml->loadHTML($str);
		restore_error_handler();

		$this->restore_locale();
  }

	/**
	 * Normalizes an HTML string
	 *
	 * @param string $str HTML text to load
	 */
	private function _load_html($str){
		//$str = mb_detect_encoding($str, 'UTF-8', true) == 'UTF-8' ? utf8_decode($str) : $str;

		if(class_exists('tidy')){
			try{
				$tidy = new tidy();
				$tidy = tidy_parse_string($str, array('output-xhtml' => true, 'markup' => false, 'wrap' => 0, 'wrap-asp' => false, 'wrap-jste' => false, 'wrap-php' => false, 'wrap-sections' => false), 'utf8');
				//echo $tidy->errorBuffer;
				//$tidy->cleanRepair();
				$html = $tidy->html();
				$str = $html->value;
			}
			catch(Exception $e){
				throw new Exception('Problem with Tidy validation. Verify HTML source Tidy installation.');
			}
		}else{
                        require_once dirname(__FILE__) . '/../../htmlawed/htmLawed.php';
                        $str = htmLawed($str);
                        $str = preg_replace('/\s\s+/', ' ', $str);
                        $str = preg_replace('~>\s*\n\s*<~', '><', $str);
                        $str = preg_replace('~>\s*<~', '><', $str);
			$doc = new DOMDocument();
			$doc->preserveWhiteSpace = false;
			$doc->formatOutput = false;
			$str = str_replace("\r\n"," ",$str);
			$str = str_replace("\n"," ",$str);
			$str = preg_replace( '/\s+/', ' ', $str );
			@$doc->loadHTML($str);
			$str = @$doc->saveHTML();
		}

                $str = preg_replace_callback(
                        '/>(\s*$\s*)</m',
                        create_function('$matches', "return strpos('$matches[0]', ' ') === false?'><':'> <';"),
                        $str
                        );

		$str = str_replace('</body>', '<close></body>', $str);

		return($str);
	}
        
  /**
   * Builds the {@link FrameParser_Tree}, loads any CSS and applies the styles to
   * the {@link FrameParser_Tree}
   */
  protected function _process_html($filter = '*') {
    $this->save_locale();

    $this->_tree->build_tree($filter);

    $this->_css->load_css_file(StyleParsersheet::DEFAULT_STYLESHEET);

    $acceptedmedia = StyleParsersheet::$ACCEPTED_GENERIC_MEDIA_TYPES;
    if ( defined("PARSERHTML_DEFAULT_MEDIA_TYPE") ) {
      $acceptedmedia[] = PARSERHTML_DEFAULT_MEDIA_TYPE;
    } else {
      $acceptedmedia[] = StyleParsersheet::$ACCEPTED_DEFAULT_MEDIA_TYPE;
    }

    // load <link rel="STYLESHEET" ... /> tags
    $links = $this->_xml->getElementsByTagName("link");
    foreach ($links as $link) {
      if ( mb_strtolower($link->getAttribute("rel")) === "stylesheet" ||
           mb_strtolower($link->getAttribute("type")) === "text/css" ) {
        //Check if the css file is for an accepted media type
        //media not given then always valid
        $formedialist = preg_split("/[\s\n,]/", $link->getAttribute("media"),-1, PREG_SPLIT_NO_EMPTY);
        if ( count($formedialist) > 0 ) {
          $accept = false;
          foreach ( $formedialist as $type ) {
            if ( in_array(mb_strtolower(trim($type)), $acceptedmedia) ) {
              $accept = true;
              break;
            }
          }
          if (!$accept) {
            //found at least one mediatype, but none of the accepted ones
            //Skip this css file.
            continue;
          }
        }

        $url = $link->getAttribute("href");
        $url = build_url_parser($this->_protocol, $this->_base_host, $this->_base_path, $url);

        $this->_css->load_css_file($url);
      }

    }

    // load <style> tags
    $styles = $this->_xml->getElementsByTagName("style");
    foreach ($styles as $style) {

      // Accept all <style> tags by default (note this is contrary to W3C
      // HTML 4.0 spec:
      // http://www.w3.org/TR/REC-html40/present/styles.html#adef-media
      // which states that the default media type is 'screen'
      if ( $style->hasAttributes() &&
           ($media = $style->getAttribute("media")) &&
           !in_array($media, $acceptedmedia) )
        continue;

      $css = "";
      if ( $style->hasChildNodes() ) {

        $child = $style->firstChild;
        while ( $child ) {
          $css .= $child->nodeValue; // Handle <style><!-- blah --></style>
          $child = $child->nextSibling;
        }

      } else
        $css = $style->nodeValue;

      // Set the base path of the StyleParsersheet to that of the file being processed
      $this->_css->set_protocol($this->_protocol);
      $this->_css->set_host($this->_base_host);
      $this->_css->set_base_path($this->_base_path);

      $this->_css->load_css($css);
    }

    $this->restore_locale();
  }

  /**
   * Renders the HTML to PDF
   */
  function render($filter = '*') {
    
		$this->_process_html($filter);
    
		$this->_css->apply_styles($this->_tree);

		foreach($this->_tree->get_frames() as $frame){
			$this->aDompdfTree = $this->_render($frame);
			break;
		}

		//print_r($this->getDompdfTree());
		return(true);
  }

	/**
	 * Render frames recursively
	 *
	 * @param FrameParser $frame The frame to render
	 */
	private function _render(FrameParser $frame, $filter = false){
		$aDompdfTree = array();

		$node = $frame->get_node();

		switch($node->nodeName){
			case 'caption': //ignore these tags
			case 'meta':
			case 'script':
			case 'title':
				break;
			case 'div':
				//converts floating divs to floating tables
				/*$nodeTable = false;
				$attributes = $this->getProperties($frame->get_style());
				if(isset($attributes['float']) && ($attributes['float'] == 'right' || $attributes['float'] == 'left')){
					$nodeTable = true;
				}*/

				if($this->parseDivs == 'table'/* && $nodeTable*/){
					//TODO move float childs
					/*foreach($frame->get_children() as $child){
						$attributes = $this->getProperties($child->get_style());
						if(isset($attributes['float']) && ($attributes['float'] == 'right' || $attributes['float'] == 'left')){
							// $childNode = $child->get_node();
							// $childNode = $node->removeChild($childNode);
							// $node->appendChild($childNode);
							//$frame->append_child($child);
						}
					}*/

					$aDompdfTree['nodeName'] = 'table';
					//$aDompdfTree['nodeValue'] = $node->nodeValue;
					$aDompdfTree['attributes'] = $this->getAttributes($node);
					$aDompdfTree['properties'] = $this->getProperties($frame->get_style());

					$filter = ($filter == '*' || (isset($aDompdfTree['attributes']['class']) && in_array('_phpdocx_filter_paint_', $aDompdfTree['attributes']['class'])))?'*':false;
					$sTempFilter = ($filter != '*')?'_noPaint':'';
					$aDompdfTree['nodeName'] .= $sTempFilter;

					$aDompdfTree['children'][] = array('nodeName' => 'tr'.$sTempFilter, 'attributes' => array('border' => 0), 'properties' => array('background_color' => 'transparent'));
					$aDompdfTree['children'][0]['children'][] = array('nodeName' => 'td'.$sTempFilter, 'nodeValue' => $node->nodeValue, 'attributes' => array('colspan' => '1', 'rowspan' => '1', 'border' => 0), 'properties' => array('background_color' => 'transparent'));

					$aTempTree = array();
					foreach($frame->get_children() as $child){
						/*$attributes = $this->getProperties($child->get_style());
						//TODO extract to parent; make next sibling of this
						if(isset($attributes['float']) && ($attributes['float'] == 'right' || $attributes['float'] == 'left')){
							var_dump($attributes['float'], $child->get_node());
							$node->parentNode->appendChild($child->get_node());
							continue;
						}*/

						$aTemp = $this->_render($child, $filter);
						if(!empty($aTemp)) $aTempTree[] = $aTemp;
					}
					$aDompdfTree['children'][0]['children'][0]['children'] = empty($aTempTree)?array():$aTempTree;
					return($aDompdfTree);
					break;
				}
				//elseif($this->parseDivs) $aDompdfTree['nodeName'] = 'p';/**/
			case '#text':
			case 'a':
			case 'br':
			case 'dd':
			case 'dl':
			case 'dt':
			case 'h1':
			case 'h2':
			case 'h3':
			case 'h4':
			case 'h5':
			case 'h6':
			case 'img':
			case 'img_inner':
			case 'input':
			case 'label':
			case 'li':
			case 'ol':
			case 'option':
			case 'p':
			case 'samp':
			case 'select':
			case 'span':
			case 'sub':
			case 'sup':
			case 'table':
			case 'td':
			case 'th':
			case 'tr':
			case 'u':
			case 'ul':
                                
				if($this->parseDivs == 'paragraph' && $node->nodeName == 'div'){
                                    if(!in_array($node->parentNode->nodeName, self::$noDiv)){
                                     $aDompdfTree['nodeName'] = 'p';
                                    }
                                }
				else $aDompdfTree['nodeName'] = $node->nodeName;

				$aDompdfTree['nodeValue'] = $node->nodeValue;
				$aDompdfTree['attributes'] = $this->getAttributes($node);
				$aDompdfTree['properties'] = $this->getProperties($frame->get_style());

				$filter = ($filter == '*' || (isset($aDompdfTree['attributes']['class']) && in_array('_phpdocx_filter_paint_', $aDompdfTree['attributes']['class'])))?'*':false;
				if($filter != '*') $aDompdfTree['nodeName'] .= '_noPaint';

				$aTempTree = array();
				foreach($frame->get_children() as $child){
					$aTemp = $this->_render($child, $filter);
					if(!empty($aTemp)) $aTempTree[] = $aTemp;
				}
				$aDompdfTree['children'] = empty($aTempTree)?array():$aTempTree;
				return($aDompdfTree);
				break;
			case 'close':
				$aDompdfTree['nodeName'] = $node->nodeName;
				foreach($frame->get_children() as $child){
					$aTemp = $this->_render($child, false);
					if(!empty($aTemp)) $aTempTree[] = $aTemp;
				}
				$aDompdfTree['children'] = empty($aTempTree)?array():$aTempTree;
				return($aDompdfTree);
				break;
			default:
				$aDompdfTree['nodeName'] = $node->nodeName;
				$aDompdfTree['attributes'] = $this->getAttributes($node);

				$filter = ($filter == '*' || (isset($aDompdfTree['attributes']['class']) && in_array('_phpdocx_filter_paint_', $aDompdfTree['attributes']['class'])))?'*':false;
				if($filter != '*') $aDompdfTree['nodeName'] .= '_noPaint';

				foreach($frame->get_children() as $child){
					$aTemp = $this->_render($child, $filter);
					if(!empty($aTemp)) $aTempTree[] = $aTemp;
				}
				$aDompdfTree['children'] = empty($aTempTree)?array():$aTempTree;
				return($aDompdfTree);
				break;
		}

		return(false);
	}

	private function resolve_uri($href){
		if(!$href) return(false); //file url

		$base_parsed = parse_url($this->htmlFile);
		$base_parsed['path'] = isset($base_parsed['path'])?$base_parsed['path']:'';

		$rel_parsed = parse_url($href);
		if(array_key_exists('scheme', $rel_parsed)) return $href; //fqdn
		elseif(strpos($href, '//') === 0) return('http:'.$href); //url like "//domain.tld/path/file" or "//domain.tld/path/file.ext"; must be "http://domain.tld/path/file" or "http://domain.tld/path/file.ext"
		elseif(strpos($href, '/') === 0) return($base_parsed['scheme'].'://'.$base_parsed['host'].$href); //url like "/path/file" or "/path/file.ext"; must be "http://domain.tld/path/file" or "http://domain.tld/path/file.ext"
		elseif(isset($this->aDomainsResolved[$this->htmlFile])) return($this->aDomainsResolved[$this->htmlFile].$href);

		//$aTypes = array('gif' => 'image/gif', 'jpeg' => 'image/jpeg', 'jpg' => 'image/jpeg', 'png' => 'image/png'); //Content-Type
		$sFileExt = substr($href, strrpos($href, '.') + 1);
		if(empty($sFileExt)/* || empty($aTypes[$sFileExt])*/) return(false); //unknown image type

		if(function_exists('stream_context_set_default')) stream_context_set_default(array('http' => array('method' => 'HEAD', 'max_redirects' => 1, 'ignore_errors' => 1)));

		$url = $base_parsed['scheme'].'://'.$base_parsed['host'].dirname($base_parsed['path']).'/'.$href; //TODO if the server redirect bad request this is not correct
		$hdrs = @get_headers($url);
    if ($hdrs) {
  		//$file = strpos(implode('#', $hdrs), $aTypes[$sFileExt]);
  		$file = strpos(implode('#', $hdrs), '200 OK');
  		//$file = is_array($hdrs)?preg_match('/^HTTP\\/\\d+\\.\\d+\\s+2\\d\\d\\s+.*$/',$hdrs[0]):false;
  		if($file) $this->aDomainsResolved[$this->htmlFile] = $base_parsed['scheme'].'://'.$base_parsed['host'].dirname($base_parsed['path']).'/';
  		else{
  			$url = $base_parsed['scheme'].'://'.$base_parsed['host'].$base_parsed['path'].'/'.$href;
  			$hdrs = @get_headers($url);
  			//$file = strpos(implode('#', $hdrs), $aTypes[$sFileExt]);
  			$file = strpos(implode('#', $hdrs), '200 OK');
  			//$file = is_array($hdrs)?preg_match('/^HTTP\\/\\d+\\.\\d+\\s+2\\d\\d\\s+.*$/',$hdrs[0]):false;
  			if($file) $this->aDomainsResolved[$this->htmlFile] = $base_parsed['scheme'].'://'.$base_parsed['host'].$base_parsed['path'].'/';
  		}
  		//returns bad url if not found (ms word can show a placeholder)

  		if(function_exists('stream_context_set_default')) stream_context_set_default(array('http' => array('method' => 'GET', 'max_redirects' => 20, 'ignore_errors' => 0)));
  		return($url);
    } else {
      return($href);
    }
	}

	private function getAttributes($node){
		$aRet = array();
		$temp = false;

		switch($node->nodeName){
			case '#text':
				return($aRet);
				break;
			case 'a':
                                $aRet['dir'] = (string)$node->getAttribute('dir');
				$aRet['href'] = (string)$node->getAttribute('href');
				break;
			case 'form':
				$action = $node->getAttribute('action');
				$aRet['action'] = empty($action)?'#':$action;
				$method = $node->getAttribute('method');
				$aRet['method'] = empty($method)?'post':$method;
				$aRet['id'] = (string)$node->getAttribute('id');
				break;
			case 'img':
				$aRet['src'] = (string)$node->getAttribute('src');
                                if($this->baseURL == ''){
                                    $aRet['src'] = $this->resolve_uri($aRet['src']); //try to resolve relative url
                                }
				$aRet['width'] = (string)$node->getAttribute('width');
				$aRet['height'] = (string)$node->getAttribute('height');
				break;
			case 'img_inner':
				$aRet['src'] = (string)$node->getAttribute('src');
				break;
			case 'input':
                                $aRet['dir'] = (string)$node->getAttribute('dir');	
                                $aRet['type'] = (string)$node->getAttribute('type');
				$aRet['name'] = (string)$node->getAttribute('name');
				$aRet['id'] = (string)$node->getAttribute('id');
				$aRet['value'] = (string)$node->getAttribute('value');
				$aRet['size'] = (string)$node->getAttribute('size');
				if($node->hasAttribute('checked')) $aRet['checked'] = true;
				else $aRet['checked'] = false;
				break;
			case 'option':
				if($node->hasAttribute('selected')) $aRet['selected'] = true;
				else $aRet['selected'] = false;
                                $aRet['dir'] = (string)$node->getAttribute('dir');
				break;
                        case 'p':
				$aRet['dir'] = (string)$node->getAttribute('dir');
				break;
			case 'table':
				$aRet['border'] = (string)$node->getAttribute('border');
				$aRet['align'] = (string)$node->getAttribute('align');
				$aRet['width'] = (string)$node->getAttribute('width');
				$aRet['height'] = (string)$node->getAttribute('height');
                                $aRet['dir'] = (string)$node->getAttribute('dir');
				break;
			case 'td':
			case 'th':
                                $aRet['dir'] = (string)$node->getAttribute('dir');
				$colspan = (int)$node->getAttribute('colspan');
				$aRet['colspan'] = empty($colspan)?1:$colspan;
				$rowspan = (int)$node->getAttribute('rowspan');
				$aRet['rowspan'] = empty($rowspan)?1:$rowspan;
				break;
			default:
		}

		$temp = $node->getAttribute('id');
		if($temp){$aRet['id'] = $temp;$temp = false;}

		$temp = $node->getAttribute('name');
		if($temp){$aRet['name'] = $temp;$temp = false;}

		$temp = $node->getAttribute('title');
		if($temp){$aRet['title'] = $temp;$temp = false;}

		$temp = $node->getAttribute('alt');
		if($temp){$aRet['alt'] = $temp;$temp = false;}

		$temp = $node->getAttribute('class');
		if($temp){
			$aRet['class'] = explode(' ', $temp);
			$temp = false;
		}

		return($aRet);
	}

	private function getProperties($properties){
		$aRet = array();

		//valid styles
		/*$aStyleParsers = array('azimuth', 'background_attachment', 'background_color', 'background_image', 'background_position', 'background_repeat',
		'background', 'border_collapse', 'border_color', 'border_spacing', 'border_style', 'border_top', 'border_right', 'border_bottom', 'border_left',
		'border_top_color', 'border_right_color', 'border_bottom_color', 'border_left_color', 'border_top_style', 'border_right_style', 'border_bottom_style',
		'border_left_style', 'border_top_width', 'border_right_width', 'border_bottom_width', 'border_left_width', 'border_width', 'border', 'bottom',
		'caption_side', 'clear', 'clip', 'color', 'content', 'counter_increment', 'counter_reset', 'cue_after', 'cue_before', 'cue', 'cursor', 'direction',
		'display', 'elevation', 'empty_cells', 'float', 'font_family', 'font_size', 'font_style', 'font_variant', 'font_weight', 'font', 'height', 'left',
		'letter_spacing', 'line_height', 'list_style_image', 'list_style_position', 'list_style_type', 'list_style', 'margin_right', 'margin_left', 'margin_top',
		'margin_bottom', 'margin', 'max_height', 'max_width', 'min_height', 'min_width', 'orphans', 'outline_color', 'outline_style', 'outline_width', 'outline',
		'overflow', 'padding_top', 'padding_right', 'padding_bottom', 'padding_left', 'padding', 'page_break_after', 'page_break_before', 'page_break_inside',
		'pause_after', 'pause_before', 'pause', 'pitch_range', 'pitch', 'play_during', 'position', 'quotes', 'richness', 'right', 'speak_header', 'speak_numeral',
		'speak_punctuation', 'speak', 'speech_rate', 'stress', 'table_layout', 'text_align', 'text_decoration', 'text_indent', 'text_transform', 'top',
		'unicode_bidi', 'vertical_align', 'visibility', 'voice_family', 'volume', 'white_space', 'widows', 'width', 'word_spacing', 'z_index');/**/
		//valid styles
		$aStyleParsers = array_keys(StyleParser::$aDefaultProperties);

		foreach($aStyleParsers as $style){
			if($style == 'font_family') $sTemp = $properties->get_props($style);
			else{
				try{$sTemp = $properties->$style;}
				catch(Exception $e){$sTemp = '';}
			}
			if($sTemp != ''){
				$aRet[$style] = $sTemp;
			}
		}

		return($aRet);
	}

	public function getDompdfTree($html = '', $isfile = false, $filter = '*', $parseDivs = false, $baseURL = ''){
		$this->parseDivs = ($parseDivs == 'table' || $parseDivs == 'paragraph')?$parseDivs:false;
                $this->baseURL = $baseURL;
		if(!empty($html)){
			//if($xpath !== false && preg_match('/^[:_A-Za-z][-.:_A-Za-z0-9]*/', $xpath)){
			//	$xpath = "//*[@$xpath]";
			//}
			if($isfile) {
        $this->load_html_file($html);
      } else {
        $this->load_html($html);
      }

			$this->render($filter);
		} elseif (empty($this->aDompdfTree)) {
      $this->render($filter);
    }

		return($this->aDompdfTree);
	}

}

