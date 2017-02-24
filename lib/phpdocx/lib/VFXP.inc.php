<?php

// Package: VFXP - Very Fast XML Parser
// Author: Claudio Castelpietra
// Email: claudio@wopweb.com
// Web site: http://www.wopweb.com/
// License: "LGPL"
// Release history:
//   18/11/2005 - v.1.0 - First release.
//   24/01/2006 - v.1.1 - Some API added. Some php compatibility issues fixed.
// Description:
//   Very Fast XML Parser for PHP.
//   Completely standalone: no need for any PHP extension library.
//   Very fast processing, using iterative single-cycle parsing, instead of recursive or multi-step parsing.
//   Very useful for just loading simple application configuration parameters.
//   Strongly simplified and intuitive DOM API, with respect to the DOM Core Level 1
//   Works with PHP >= 3
//   Limitations in version 1.0:
//     XML version and encoding declaration tags are ignored.
//     DOCTYPE declaration tags are ignored.
// Notes:
//   I developed this class because the faster extension-independent PHP XML parser I've found took about 500 milliseconds to parse my configuration file, and this is not acceptable for a web page generation.
//   This class takes about 20 times less than the previous one.
//   Anyway, this it a PHP-interpreted class, so its performance cannot be compared to a C-compiled class. 
//


// The Document Class
//
  class VFXP_Document {

    // Parses XML from a file
    //
    function parseFromFile($filename) {

      $fp = fopen($filename, 'rb');
      $this->_docContentLength = filesize($filename);
      $this->_docContent = fread($fp, $this->_docContentLength);
      fclose($fp);

      $this->_parseContent();

      unset($this->_docContent);
    }

    // Parses XML from a string
    //
    function parseFromString($content) {
      $this->_docContent = $content;

      $this->_parseContent();

      unset($this->_docContent);
    }

    // Returns a reference to the root Element
    //
    function rootElement() {
      return $this->_docRoot;
    }


    // Private variables and methods:

    var $_docContent; // The XML content
    var $_docContentLength;
    var $_docRoot; // Reference to the root element

    // Iterative method for fast XML parsing
    //
    function _parseContent() {

      // Removing some tags we don't handle
      $this->_docContent = eregi_replace('<\?xml [^>]+\?>|<!doctype [^\\[>]+(\\[[^]]*\\])?>', '', $this->_docContent);

      $parseStack = array();
      $stacklen = 0;
      $currpos = 0;

      while (true) {

        // let's extract the next tag
        $tag = new VFXP_Tag();

        // find the begin of the tag
        $tag->pos_start = strpos($this->_docContent, '<', $currpos);
        if ($tag->pos_start === FALSE) {
          die("VFXP - Error: XML tag not found.");
        }

        // check and skip comments
        if (substr($this->_docContent, $tag->pos_start, 4) == '<!--') {
          // we found a comment, let's look for its end
          $tag->pos_end = strpos($this->_docContent, '-->', $tag->pos_start + 4) + 2;
          if ($tag->pos_end === FALSE) {
            die("VFXP - Error: incomplete XML comment");
          }
          // skipping comment tag
          $currpos = $tag->pos_end + 1;
          continue;
        }

        // check and skip CDATA sections
        if (substr($this->_docContent, $tag->pos_start, 9) == '<![CDATA[') {
          // we found a cdata section, let's look for its end
          $tag->pos_end = strpos($this->_docContent, ']]>', $tag->pos_start + 9) + 2;
          if ($tag->pos_end === FALSE) {
            die("VFXP - Error: incomplete XML CDATA section");
          }
          // skipping cdata section
          $currpos = $tag->pos_end + 1;
          continue;
        }

        // find the end of the tag
        $tag->pos_end = strpos($this->_docContent, '>', $tag->pos_start);
        if ($tag->pos_end === FALSE) {
          die("VFXP - Error: incomplete XML tag");
        }
        $currpos = $tag->pos_end + 1;

        // We have the tag. Let's check its type.
        if (substr($this->_docContent, $tag->pos_start + 1, 1) == '/') {
          $tag->is_opening = false;
          $tag->is_closing = true;
          $tag->name = substr($this->_docContent, $tag->pos_start + 2, $tag->pos_end - $tag->pos_start - 2);
          // $tag->attributes = array(); // will not be used
        } else {
          $tag->is_opening = true;
          if (substr($this->_docContent, $tag->pos_end - 1, 1) == '/') {
            $tag->is_closing = true;
            $tag->name = substr($this->_docContent, $tag->pos_start + 1, $tag->pos_end - $tag->pos_start - 2);
          } else {
            $tag->is_closing = false;
            $tag->name = substr($this->_docContent, $tag->pos_start + 1, $tag->pos_end - $tag->pos_start - 1);
          }
          // Tag attributes parsing
          ereg("^([^ \n\r\t/]+)([ \n\r\t/](.*))?$", $tag->name, $regs);
          $tag->name = $regs[1];

          $attr_string = $regs[3];

          $tag->attributes = array();
          while ($attr_string != '') {
            // magic regular expression for extracting the attributes one at a time
            if (ereg("[ \n\r\t]*([^ \n\r\t=]+)(=(\"(\"|([^\"]*[^\\])\")|[^ \n\r\t\"][^ \n\r\t]*))?([ \n\r\t].*)?$", $attr_string, $regs)) {
              if ($regs[5] != '') {
                $tag->attributes[$regs[1]] = $regs[5];
              } else {
                $tag->attributes[$regs[1]] = $regs[3];
              }
              $attr_string = $regs[6];
            } else {
              break;
            }
          }
        }

        // Let's check the tag against the parsing stack
        if ($tag->is_opening) {
          ;
          // building the element corresponding to the found opening tag
          $elem = new VFXP_Element();
          $elem->_name = $tag->name;
          $elem->_value = NULL;
          $elem->_attributes = $tag->attributes;
          $elem->_subelements = array();

          if ($stacklen == 0) {
            // This is the root element
            $this->_docRoot = $elem;
          }

          $tag->elem_ref = $elem; // saving a reference to the element into the opening tag

          array_push($parseStack, $tag); // pushing the opening tag onto the parsing stack
          ++$stacklen;

        }

        if ($tag->is_closing) {

          --$stacklen;
          $tag_top = array_pop($parseStack);

          if ($tag_top->name != $tag->name) {
            print("VFXP - Closing tag not matching. Tag:".$tag->name." Pos:".$tag->pos_start . "<br>\nParse Stack:<br>\n");
            print_r($parseStack);
            die();
          }

          // element complete
          // estraction of the element value - only if non self-closing or if without subelements
          if (!$tag->is_opening && count($tag_top->elem_ref->_subelements) == 0) {
            $tag_top->elem_ref->_value = substr($this->_docContent, $tag_top->pos_end + 1, $tag->pos_start - $tag_top->pos_end - 1);
            // processing CDATA sections
            if (substr($tag_top->elem_ref->_value, 0, 9) == '<![CDATA[') {
              $tag_top->elem_ref->_value = substr($tag_top->elem_ref->_value, 9, -3);
            }
          }
          else {
//            $strPatternTags = "/<\w+[1-6]?+>.+?<\/\w+[1-6]?+>/";
            $strPatternTags = "/<\w+[1-6]*?[\s]*?[\w]*?[\"=:;]*?[\w-_]*?[\"=:;\s\w]*?>.+?<\/\w+[1-6]*?>/";
            $strPatternSpaces = "/\s\s+/";
            $strTagValue = preg_replace($strPatternSpaces, ' ', trim(preg_replace($strPatternTags, '__TAG__', substr($this->_docContent, $tag_top->pos_end + 1, $tag->pos_start - $tag_top->pos_end - 1))));
            if(substr($strTagValue, 0, 1) != '<') {
              $tag_top->elem_ref->_value = $strTagValue;
            }
          }

          // let's add the element to the list of the subelements of the parent element
          if ($stacklen > 0) {
            $parseStack[$stacklen-1]->elem_ref->_subelements[] = $tag_top->elem_ref;
            //print($tag_top->elem_ref->name . ' child of ' . $parseStack[count($parseStack)-1]->elem_ref->name . "<br>\n");
          } else {
            // stack exausted - elaboration finished
            break;
          }
        }

      }

    }


  }


// The Document Element
//
  class VFXP_Element {

    // Returns the name of the element
    //
    function name() {
      return $this->_name;
    }

    // Returns the value of the element
    //
    function value() {
      return trim($this->_value);
    }

    // Returns true if there is at least one child with the given name
    //
    function hasChildren($elementname = NULL) {
      if ($elementname) {
        return ($this->firstChild($elementname) != NULL);
      } else {
        return isset($this->_subelements[0]);
      }
    }

    // Returns a reference to the first element with the given name, or NULL if not found.
    //
    function firstChild($elementname = NULL) {
      if ($elementname) {
        for ($pos = 0; $pos < count($this->_subelements); ++$pos) {
          if ($this->_subelements[$pos]->_name == $elementname) {
            return $this->_subelements[$pos];
          }
        }
      } else {
        if (isset($this->_subelements[0])) {
          return $this->_subelements[0];
        }
      }
      $tmp0 = NULL;
      $tmp = $tmp0;
      return $tmp;
    }

    // Returns the value of the first child with the given name, or NULL if not found.
    //
    function childValue($elementname = NULL) {
      $elem = $this->firstChild($elementname);
      if ($elem) {
        return $elem->_value;
      } else {
        return NULL;
      }
    }

    // Returns an array of references to the subelements having a given name.
    //
    function children($elementname = NULL) {
      if ($elementname) {
        $tmparr = array();
        for ($pos = 0; $pos < count($this->_subelements); ++$pos) {
          if ($this->_subelements[$pos]->_name == $elementname) {
            $tmparr[] = $this->_subelements[$pos];
          }
        }
        return $tmparr;
      } else {
        return $this->_subelements;
      }
    }

    // Returns an associative array of couples (child-name => child-value)
    //
    function childrenAssociative() {
      $tmparr = array();
      for ($pos = 0; $pos < count($this->_subelements); ++$pos) {
        $tmparr[$this->_subelements[$pos]->_name] = $this->_subelements[$pos]->_value;
      }
      return $tmparr;
    }

    // Returns a reference to the array-map of the attribute-name=>attribute-value pairs
    //
    function attributes() {
      return $this->_attributes;
    }

    // Returns the value of the given attribute, or NULL if not found
    //
    function attributeValue($attributename) {
      if (isset($this->_attributes[$attributename])) {
        return $this->_attributes[$attributename];
      } else {
        return NULL;
      }
    }


    var $_name;
    var $_value; // string value, or NULL if self-closing tag of if has children
    var $_attributes; // attributes array-map
    var $_subelements; // subelements array

  }


// Temporary tag objects for parsing
//
  class VFXP_Tag {
    var $pos_start; // first tag character
    var $pos_end; // last tag character
    var $is_opening;
    var $is_closing;
    var $name;
    var $attributes; // array-map of the tag attributes
    var $elem_ref; // reference to the corresponding element
  }


?>
