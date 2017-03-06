<?php
/**
 * PARSERHTML - PHP5 HTML to PDF renderer
 *
 * File: $RCSfile: frame.cls.php,v $
 * Created on: 2004-06-02
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
 * @package parserhtml

 */

/* $Id: frame.cls.php 359 2011-02-05 12:15:06Z fabien.menager $ */

/**
 * The main FrameParser class
 *
 * This class represents a single HTML element.  This class stores
 * positioning information as well as containing block location and
 * dimensions. StyleParser information for the element is stored in a {@link
 * StyleParser} object.  Tree structure is maintained via the parent & children
 * links.
 *
 * @access protected
 * @package parserhtml
 */
class FrameParser {
  
  /**
   * The DOMNode object this frame represents
   *
   * @var DOMNode
   */
  protected $_node;

  /**
   * Unique identifier for this frame.  Used to reference this frame
   * via the node.
   *
   * @var string
   */
  protected $_id;

  /**
   * Unique id counter
   */
  static protected $ID_COUNTER = 0;
  
  /**
   * This frame's calculated style
   *
   * @var StyleParser
   */
  protected $_style;
  
  /**
   * This frame's parent in the document tree.
   *
   * @var FrameParser
   */
  protected $_parent;

  /**
   * This frame's first child.  All children are handled as a
   * doubly-linked list.
   *
   * @var FrameParser
   */
  protected $_first_child;

  /**
   * This frame's last child.
   *
   * @var FrameParser
   */
  protected $_last_child;

  /**
   * This frame's previous sibling in the document tree.
   *
   * @var FrameParser
   */
  protected $_prev_sibling;

  /**
   * This frame's next sibling in the document tree.
   *
   * @var FrameParser
   */
  protected $_next_sibling;
  
  /**
   * This frame's containing block (used in layout): array(x, y, w, h)
   *
   * @var array
   */
  protected $_containing_block;

  /**
   * Position on the page of the top-left corner of the margin box of
   * this frame: array(x,y)
   *
   * @var array
   */
  protected $_position;

  /**
   * Class constructor
   *
   * @param DOMNode $node the DOMNode this frame represents
   */
  function __construct(DomNode $node) {

    $this->_node = $node;
      
    $this->_parent = null;
    $this->_first_child = null;
    $this->_last_child = null;
    $this->_prev_sibling = $this->_next_sibling = null;
    
    $this->_style = null;

    $this->_containing_block = array(
      "x" => null,
      "y" => null,
      "w" => null,
      "h" => null,
    );
    
    $this->_containing_block[0] =& $this->_containing_block["x"];
    $this->_containing_block[1] =& $this->_containing_block["y"];
    $this->_containing_block[2] =& $this->_containing_block["w"];
    $this->_containing_block[3] =& $this->_containing_block["h"];
    
    $this->_position = array(
      "x" => null,
      "y" => null,
    );
    
    $this->_position[0] =& $this->_position["x"];
    $this->_position[1] =& $this->_position["y"];

    $this->set_id( self::$ID_COUNTER++ );
  }

  // Accessor methods
  /**
   * @return DOMNode
   */
  function get_node() {
return $this->_node; }
  
  /**
   * @return string
   */
  function get_id() {
return $this->_id; }
  
  /**
   * @return StyleParser
   */
  function get_style() {
return $this->_style; }

  /**
   * @return FrameParser
   */
  function get_parent() {
return $this->_parent; }

  /**
   * @return FrameParser
   */
  function get_first_child() {
return $this->_first_child; }
  
  /**
   * @return FrameParser
   */
  function get_last_child() {
return $this->_last_child; }
  
  /**
   * @return FrameParser
   */
  function get_prev_sibling() {
return $this->_prev_sibling; }
  
  /**
   * @return FrameParser
   */
  function get_next_sibling() {
return $this->_next_sibling; }
  
  /**
   * @return FrameParserList
   */
  function get_children() {
return new FrameParserList($this); }

  // Layout property accessors

  // Set methods
  function set_id($id) {

    $this->_id = $id;

    // We can only set attributes of DOMElement objects (nodeType == 1).
    // Since these are the only objects that we can assign CSS rules to,
    // this shortcoming is okay.
    if ( $this->_node->nodeType == XML_ELEMENT_NODE )
      $this->_node->setAttribute("frame_id", $id);
  }

  function set_style(StyleParser $style) {

    /*if ( is_null($this->_style) )//PHPDOCX
      $this->_original_style = clone $style;*/
    
    //$style->set_frame($this);
    $this->_style = $style;
  }

//

  /**
   * Inserts a new child at the beginning of the Frame
   *
   * @param $child Frame The new Frame to insert
   * @param $update_node boolean Whether or not to update the DOM
   */
  function prepend_child(FrameParser $child, $update_node = true) {
    if ( $update_node )
      $this->_node->insertBefore($child->_node, $this->_first_child ? $this->_first_child->_node : null);

    // Remove the child from its parent
    if ( $child->_parent )
      $child->_parent->remove_child($child, false);
    
    $child->_parent = $this;
    $child->_prev_sibling = null;

    // Handle the first child
    if ( !$this->_first_child ) {
      $this->_first_child = $child;
      $this->_last_child = $child;
      $child->_next_sibling = null;
    } else {
      $this->_first_child->_prev_sibling = $child;
      $child->_next_sibling = $this->_first_child;
      $this->_first_child = $child;
    }
  }

  /**
   * Inserts a new child at the end of the FrameParser
   *
   * @param $child FrameParser The new FrameParser to insert
   * @param $update_node boolean Whether or not to update the DOM
   */
  function append_child(FrameParser $child, $update_node = true) {

    if ( $update_node )
      $this->_node->appendChild($child->_node);

    // Remove the child from its parent
    if ( $child->_parent )
      $child->_parent->remove_child($child, false);

    $child->_parent = $this;
    $child->_next_sibling = null;
    
    // Handle the first child
    if ( !$this->_last_child ) {
      $this->_first_child = $child;
      $this->_last_child = $child;
      $child->_prev_sibling = null;
    } else {
      $this->_last_child->_next_sibling = $child;
      $child->_prev_sibling = $this->_last_child;
      $this->_last_child = $child;
    }
  }

  //

}

//------------------------------------------------------------------------

/**
 * Linked-list IteratorAggregate
 *
 * @access private
 * @package parserhtml
 */
class FrameParserList implements IteratorAggregate {
  protected $_frame;

  function __construct($frame) {
$this->_frame = $frame; }
  function getIterator() {
return new FrameParserListIterator($this->_frame); }
}
  
/**
 * Linked-list Iterator
 *
 * Returns children in order and allows for list to change during iteration,
 * provided the changes occur to or after the current element
 *
 * @access private
 * @package parserhtml
 */
class FrameParserListIterator implements Iterator {

  /**
   * @var FrameParser
   */
  protected $_parent;
  
  /**
   * @var FrameParser
   */
  protected $_cur;
  
  /**
   * @var int
   */
  protected $_num;

  function __construct(FrameParser $frame) {

    $this->_parent = $frame;
    $this->_cur = $frame->get_first_child();
    $this->_num = 0;
  }

  function rewind() {

    $this->_cur = $this->_parent->get_first_child();
    $this->_num = 0;
  }

  /**
   * @return bool
   */
  function valid() {

    return isset($this->_cur);// && ($this->_cur->get_prev_sibling() === $this->_prev);
  }
  
  function key() {
return $this->_num; }

  /**
   * @return FrameParser
   */
  function current() {
return $this->_cur; }

  /**
   * @return FrameParser
   */
  function next() {


    $ret = $this->_cur;
    if ( !$ret )
      return null;
    
    $this->_cur = $this->_cur->get_next_sibling();
    $this->_num++;
    return $ret;
  }
}

//------------------------------------------------------------------------

/**
 * Pre-order IteratorAggregate
 *
 * @access private
 * @package parserhtml
 */
class FrameParserTreeList implements IteratorAggregate {
  /**
   * @var FrameParser
   */
  protected $_root;
  
  function __construct(FrameParser $root) {
$this->_root = $root; }
  
  /**
   * @return FrameParserTreeIterator
   */
  function getIterator() {
return new FrameParserTreeIterator($this->_root); }
}

/**
 * Pre-order Iterator
 *
 * Returns frames in preorder traversal order (parent then children)
 *
 * @access private
 * @package parserhtml
 */
class FrameParserTreeIterator implements Iterator {
  /**
   * @var FrameParser
   */
  protected $_root;
  protected $_stack = array();
  
  /**
   * @var int
   */
  protected $_num;
  
  function __construct(FrameParser $root) {

    $this->_stack[] = $this->_root = $root;
    $this->_num = 0;
  }

  function rewind() {

    $this->_stack = array($this->_root);
    $this->_num = 0;
  }
  
  /**
   * @return bool
   */
  function valid() {
return count($this->_stack) > 0; }
  
  /**
   * @return int
   */
  function key() {
return $this->_num; }

  /**
   * @var FrameParser
   */
  function current() {
return end($this->_stack); }

  /**
   * @var FrameParser
   */
  function next() {

    $b = end($this->_stack);
    
    // Pop last element
    unset($this->_stack[ key($this->_stack) ]);
    $this->_num++;
    
    // Push all children onto the stack in reverse order
    if ( $c = $b->get_last_child() ) {
      $this->_stack[] = $c;
      while ( $c = $c->get_prev_sibling() )
        $this->_stack[] = $c;
    }
    return $b;
  }
}
