<?php
/**
 * PARSERHTML - PHP5 HTML to PDF renderer
 *
 * File: $RCSfile: style.cls.php,v $
 * Created on: 2004-06-01
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
 * @contributor Helmut Tischer <htischer@weihenstephan.org>
 * @package parserhtml
 *
 * Changes
 * @contributor Helmut Tischer <htischer@weihenstephan.org>
 * @version 0.5.1.htischer.20090507
 * - Fix px to pt conversion according to DOMPDF_DPI
 * - Recognize css styles with !important attribute, and store !important attribute within style
 * - Propagate !important by inherit and sequences of styles with merge.
 * - Add missing style property cache flushes for consistent rendering, e.g. on explicte assignments
 * - Add important set/get for access from outside of class
 * - Fix font_family search path with multiple fonts list in css attribute:
 *   On missing font, do not immediately fall back to default font,
 *   but try subsequent fonts in search chain. Only when none found, explicitely
 *   refer to default font.
 * - Allow read of background individual properties
 * - Add support for individual styles background-position, background-attachment, background-repeat
 * - Complete style components of list-style
 * - Add support for combined styles in addition to individual styles
 *   like {border: red 1px solid;}, { border-width: 1px;}, { border-right-color: red; } ...
 *   for font, background
 * - Propagate attributes including !important from combined style to individual component
 *   for border, background, padding, margin, font, list_style
 * - Refactor common code of border, background, padding, margin, font, list_style
 * - Refactor common code of list-style-image and background-image
 * - special treatment of css images "none" instead of url(...), otherwise would prepend string "none" with path name
 * - Added comments
 * - Added debug output
 * @contributor Helmut Tischer <htischer@weihenstephan.org>
 * @version dompdf_trunk_with_helmut_mods.20090524
 * - Allow superflous white space and string delimiter in font search path.
 * - Restore lost change of default font of above
 * @version 20090610
 * - Allow absolute path from web server root as html image reference
 * - More accurate handling of css property cache consistency
 */

/* $Id: style.cls.php 355 2011-01-27 07:44:54Z fabien.menager $ */

/**
 * Represents CSS properties.
 *
 * The StyleParser class is responsible for handling and storing CSS properties.
 * It includes methods to resolve colours and lengths, as well as getters &
 * setters for many CSS properites.
 *
 * Actual CSS parsing is performed in the {@link StyleParsersheet} class.
 *
 * @package parserhtml
 */
class StyleParser {

  // All CSS 2.1 properties, and their default values
  static $aDefaultProperties = array(
    //"azimuth" => "center",
    //"background_attachment" => "scroll",
    "background_color" => "transparent",
    //"background_image" => "none",
    //"background_position" => "0% 0%",
    //"background_repeat" => "repeat",
    "background" => "",
    "border_collapse" => "separate",
    "border_color" => "",
    "border_spacing" => "0",
    "border_style" => "",
    "border_top" => "",
    "border_right" => "",
    "border_bottom" => "",
    "border_left" => "",
    "border_top_color" => "",
    "border_right_color" => "",
    "border_bottom_color" => "",
    "border_left_color" => "",
    "border_top_style" => "none",
    "border_right_style" => "none",
    "border_bottom_style" => "none",
    "border_left_style" => "none",
    "border_top_width" => "medium",
    "border_right_width" => "medium",
    "border_bottom_width" => "medium",
    "border_left_width" => "medium",
    "border_width" => "medium",
    "border" => "",
    //"bottom" => "auto",
    //"caption_side" => "top",
    //"clear" => "none",
    //"clip" => "auto",
    "color" => "#000000",
    //"content" => "normal",
    //"counter_increment" => "none",
    //"counter_reset" => "none",
    //"cue_after" => "none",
    //"cue_before" => "none",
    //"cue" => "",
    //"cursor" => "auto",
    "direction" => "ltr",
    "display" => "inline",
    //"elevation" => "level",
    //"empty_cells" => "show",
    "float" => "none",
    "font_family" => "serif",
    "font_size" => "medium",
    "font_style" => "normal",
    "font_variant" => "normal",
    "font_weight" => "normal",
    "font" => "",
    "height" => "auto",
    //"left" => "auto",
    //"letter_spacing" => "normal",
    "line_height" => "normal",
    //The list styles are not parsed by the time being
    //"list_style_image" => "none",
    //"list_style_position" => "outside",
    "list_style_type" => "disc",
    "list_style" => "",
    "margin_right" => "0",
    "margin_left" => "0",
    "margin_top" => "0",
    "margin_bottom" => "0",
    "margin" => "",
    //"max_height" => "none",
    //"max_width" => "none",
    //"min_height" => "0",
    //"min_width" => "0",
    //"opacity" => "1.0", // CSS3
    //"orphans" => "2",
    //"outline_color" => "", // "invert" special color is not supported
    //"outline_style" => "none",
    //"outline_width" => "medium",
    //"outline" => "",
    //"overflow" => "visible",
    "padding_top" => "0",
    "padding_right" => "0",
    "padding_bottom" => "0",
    "padding_left" => "0",
    "padding" => "",
    "page_break_after" => "auto",
    "page_break_before" => "auto",
    "page_break_inside" => "auto",
    //"pause_after" => "0",
    //"pause_before" => "0",
    //"pause" => "",
    //"pitch_range" => "50",
    //"pitch" => "medium",
    //"play_during" => "auto",
    //"position" => "static",
    //"quotes" => "",
    //"richness" => "50",
    //"right" => "auto",
    //"size" => "auto", // @page
    //"speak_header" => "once",
    //"speak_numeral" => "continuous",
    //"speak_punctuation" => "none",
    //"speak" => "normal",
    //"speech_rate" => "medium",
    //"stress" => "50",
    //"table_layout" => "auto",
    "text_align" => "left",
    "text_decoration" => "none",
    "text_indent" => "0",
    "text_transform" => "none",
    //"top" => "auto",
    //"transform" => "none", // CSS3
    //"transform_origin" => "50% 50%", // CSS3
    //"_webkit_transform" => $d["transform"], // CSS3
    //"_webkit_transform_origin" => $d["transform_origin"], // CSS3
    //"unicode_bidi" => "normal",
    "vertical_align" => "baseline",
    //"visibility" => "visible",
    //"voice_family" => "",
    //"volume" => "medium",
    //"white_space" = >"normal",
    //"widows" => "2",
    "width" => "auto",
    //"word_spacing" => "normal",
    //"z_index" => "auto",

    // for @font-face
    //"src" => "",
    //"unicode_range" => ""
  );

  /**
   * Default font size, in points.
   *
   * @var float
   */
  private $default_font_size = 12;

  /**
   * Default line height, as a fraction of the font size.
   *
   * @var float
   */
  private $default_line_height = 1.2;

  /**
   * Default "absolute" font sizes relative to the default font-size
   * http://www.w3.org/TR/css3-fonts/#font-size-the-font-size-property
   * @var array<float>
   */
  private $font_size_keywords = array(
    "xx-small" => 0.6,   // 3/5
    "x-small"  => 0.75,  // 3/4
    "small"    => 0.889, // 8/9
    "medium"   => 1,     // 1
    "large"    => 1.2,   // 6/5
    "x-large"  => 1.5,   // 3/2
    "xx-large" => 2.0,   // 2/1
  );

  /**
   * List of valid border styles.  Should also really be a constant.
   *
   * @var array
   */
  private $BORDER_STYLES = array("none", "hidden", "dotted", "dashed", "solid",
                                "double", "groove", "ridge", "inset", "outset");

  /**
   * Default style values.
   *
   * @link http://www.w3.org/TR/CSS21/propidx.html
   *
   * @var array
   */
  static protected $_defaults = null;

  /**
   * List of inherited properties
   *
   * @link http://www.w3.org/TR/CSS21/propidx.html
   *
   * @var array
   */
  static protected $_inherited = null;

  /**
   * The stylesheet this style belongs to
   *
   * @see Stylesheet
   * @var Stylesheet
   */
  protected $_stylesheet; // stylesheet this style is attached to

  /**
   * Main array of all CSS properties & values
   *
   * @var array
   */
  protected $_props;

  /* var instead of protected would allow access outside of class */
  protected $_important_props;

  /**
   * Cached property values
   *
   * @var array
   */
  protected $_prop_cache;

  /**
   * Font size of parent element in document tree.  Used for relative font
   * size resolution.
   *
   * @var float
   */
  protected $_parent_font_size; // Font size of parent element

  // private members
  /**
   * True once the font size is resolved absolutely
   *
   * @var bool
   */
  private $__font_size_calculated; // Cache flag

  /**
   * Class constructor
   *
   * @param StyleParsersheet $stylesheet the stylesheet this StyleParser is associated with.
   */
  function __construct(StyleParsersheet $stylesheet) {

    $this->_props = array();
    $this->_important_props = array();
    $this->_stylesheet = $stylesheet;
    $this->_parent_font_size = null;
    $this->__font_size_calculated = false;

    if ( !isset(self::$_defaults) ) {

      // Shorthand
      $d =& self::$_defaults;

      foreach(self::$aDefaultProperties as $key => $value){
        $d[$key] = $value;
      };

      // Properties that inherit by default
      self::$_inherited = array(//"azimuth",
                                 "background_color",
                                 //"border_collapse",
                                 //"border_spacing",
                                 //"caption_side",
                                 "color",
                                 //"cursor",
                                 "direction",
                                 //"elevation",
                                 //"empty_cells",
                                 "font_family",
                                 "font_size",
                                 "font_style",
                                 "font_variant",
                                 "font_weight",
                                 "font",
                                 //"letter_spacing",
                                 "line_height",
                                 "list_style_image",
                                 "list_style_position",
                                 "list_style_type",
                                 "list_style",
                                 //"orphans",
                                 "page_break_inside",
                                 //"pitch_range",
                                 //"pitch",
                                 //"quotes",
                                 //"richness",
                                 //"speak_header",
                                 //"speak_numeral",
                                 //"speak_punctuation",
                                 //"speak",
                                 //"speech_rate",
                                 //"stress",
                                 "text_align",
                                 "text_indent",
                                 "text_transform",
                                 "text_decoration",
                                 "vertical_align", //TODO: check if this is a good general option
                                 //"visibility",
                                 //"voice_family",
                                 //"volume",
                                 //"white_space",
                                 //"widows",
                                 //"word_spacing"
                                 );
    }

  }

  /**
   * Converts any CSS length value into an absolute length in points.
   *
   * length_in_pt() takes a single length (e.g. '1em') or an array of
   * lengths and returns an absolute length.  If an array is passed, then
   * the return value is the sum of all elements.
   *
   * If a reference size is not provided, the default font size is used
   * ({@link $this->default_font_size}).
   *
   * @param float|array $length   the length or array of lengths to resolve
   * @param float       $ref_size  an absolute reference size to resolve percentage lengths
   * @return float
   */
  function length_in_pt($length, $ref_size = null) {

    if ( !is_array($length) )
      $length = array($length);

    if ( !isset($ref_size) )
      $ref_size = $this->default_font_size;

    $ret = 0;
    foreach ($length as $l) {

      if ( $l === "auto" )
        return "auto";
      
      if ( $l === "none" )
        return "none";

      // Assume numeric values are already in points
      if ( is_numeric($l) ) {
        $ret += $l;
        continue;
      }

      if ( $l === "normal" ) {
        $ret += $ref_size;
        continue;
      }

      // Border lengths
      if ( $l === "thin" ) {
        $ret += 0.5;
        continue;
      }

      if ( $l === "medium" ) {
        $ret += 1.5;
        continue;
      }

      if ( $l === "thick" ) {
        $ret += 2.5;
        continue;
      }

      if ( ($i = mb_strpos($l, "px"))  !== false ) {
        $ret += ( mb_substr($l, 0, $i)  * 72 ) / PARSERHTML_DPI;
        continue;
      }

      if ( ($i = mb_strpos($l, "pt"))  !== false ) {
        $ret += mb_substr($l, 0, $i);
        continue;
      }

      if ( ($i = mb_strpos($l, "em"))  !== false ) {
        $ret += mb_substr($l, 0, $i) * $this->__get("font_size");
        continue;
      }

      if ( ($i = mb_strpos($l, "%"))  !== false ) {
        $ret += mb_substr($l, 0, $i)/100 * $ref_size;
        continue;
      }

      if ( ($i = mb_strpos($l, "cm")) !== false ) {
        $ret += mb_substr($l, 0, $i) * 72 / 2.54;
        continue;
      }

      if ( ($i = mb_strpos($l, "mm")) !== false ) {
        $ret += mb_substr($l, 0, $i) * 72 / 25.4;
        continue;
      }

      // FIXME: em:ex ratio?
      if ( ($i = mb_strpos($l, "ex"))  !== false ) {
        $ret += mb_substr($l, 0, $i) * $this->__get("font_size");
        continue;
      }
      
      if ( ($i = mb_strpos($l, "in")) !== false ) {
        $ret += mb_substr($l, 0, $i) * 72;
        continue;
      }

      if ( ($i = mb_strpos($l, "pc")) !== false ) {
        $ret += mb_substr($l, 0, $i) / 12;
        continue;
      }

      // Bogus value
      $ret += $ref_size;
    }

    return $ret;
  }

  
  /**
   * Set inherited properties in this style using values in $parent
   *
   * @param StyleParser $parent
   */
  function inherit(StyleParser $parent) {


    // Set parent font size
    $this->_parent_font_size = $parent->get_font_size();

    foreach (self::$_inherited as $prop) {
      //inherit the !important property also.
      //if local property is also !important, don't inherit.
      if ( isset($parent->_props[$prop]) &&
           ( !isset($this->_props[$prop]) ||
             ( isset($parent->_important_props[$prop]) && !isset($this->_important_props[$prop]) )
           )
         ) {
        if ( isset($parent->_important_props[$prop]) ) {
          $this->_important_props[$prop] = true;
        }
        //see __set and __get, on all assignments clear cache!
        $this->_prop_cache[$prop] = null;
        $this->_props[$prop] = $parent->_props[$prop];
      }
    }

    foreach (array_keys($this->_props) as $prop) {
      if ( $this->_props[$prop] === "inherit" ) {
        if ( isset($parent->_important_props[$prop]) ) {
          $this->_important_props[$prop] = true;
        }
        //do not assign direct, but
        //implicite assignment through __set, redirect to specialized, get value with __get
        //This is for computing defaults if the parent setting is also missing.
        //Therefore do not directly assign the value without __set
        //set _important_props before that to be able to propagate.
        //see __set and __get, on all assignments clear cache!
        //$this->_prop_cache[$prop] = null;
        //$this->_props[$prop] = $parent->_props[$prop];
        //props_set for more obvious explicite assignment not implemented, because
        //too many implicite uses.
        // $this->props_set($prop, $parent->$prop);
        $this->$prop = $parent->$prop;
      }
    }

    return $this;
  }

  /**
   * Override properties in this style with those in $style
   *
   * @param StyleParser $style
   */
  function merge(StyleParser $style) {

    //treat the !important attribute
    //if old rule has !important attribute, override with new rule only if
    //the new rule is also !important
    foreach($style->_props as $prop => $val ) {
      if (isset($style->_important_props[$prop])) {
        $this->_important_props[$prop] = true;
        //see __set and __get, on all assignments clear cache!
        $this->_prop_cache[$prop] = null;
        $this->_props[$prop] = $val;
      } else if ( !isset($this->_important_props[$prop]) ) {
        //see __set and __get, on all assignments clear cache!
        $this->_prop_cache[$prop] = null;
        $this->_props[$prop] = $val;
      }
    }

    if ( isset($style->_props["font_size"]) )
      $this->__font_size_calculated = false;
  }

  /**
   * Returns an array(r, g, b, "r"=> r, "g"=>g, "b"=>b, "hex"=>"#rrggbb")
   * based on the provided CSS colour value.
   *
   * function code from css_color.cls.php
   *
   * @param string $colour
   * @return array
   */
  function munge_colour($colour) {
    static $cssColorNames = array("aliceblue" => "F0F8FF", "antiquewhite" => "FAEBD7", "aqua" => "00FFFF","aquamarine" => "7FFFD4", "azure" => "F0FFFF",
    "beige" => "F5F5DC", "bisque" => "FFE4C4", "black" => "000000", "blanchedalmond" => "FFEBCD", "blue" => "0000FF", "blueviolet" => "8A2BE2", "brown" => "A52A2A",
    "burlywood" => "DEB887", "cadetblue" => "5F9EA0", "chartreuse" => "7FFF00", "chocolate" => "D2691E", "coral" => "FF7F50", "cornflowerblue" => "6495ED",
    "cornsilk" => "FFF8DC", "crimson" => "DC143C", "cyan" => "00FFFF", "darkblue" => "00008B", "darkcyan" => "008B8B", "darkgoldenrod" => "B8860B",
    "darkgray" => "A9A9A9", "darkgreen" => "006400", "darkgrey" => "A9A9A9", "darkkhaki" => "BDB76B", "darkmagenta" => "8B008B", "darkolivegreen" => "556B2F",
    "darkorange" => "FF8C00", "darkorchid" => "9932CC", "darkred" => "8B0000", "darksalmon" => "E9967A", "darkseagreen" => "8FBC8F", "darkslateblue" => "483D8B",
    "darkslategray" => "2F4F4F", "darkslategrey" => "2F4F4F", "darkturquoise" => "00CED1", "darkviolet" => "9400D3", "deeppink" => "FF1493",
    "deepskyblue" => "00BFFF", "dimgray" => "696969", "dimgrey" => "696969", "dodgerblue" => "1E90FF", "firebrick" => "B22222", "floralwhite" => "FFFAF0",
    "forestgreen" => "228B22", "fuchsia" => "FF00FF", "gainsboro" => "DCDCDC", "ghostwhite" => "F8F8FF", "gold" => "FFD700", "goldenrod" => "DAA520",
    "gray" => "808080", "green" => "008000", "greenyellow" => "ADFF2F", "grey" => "808080", "honeydew" => "F0FFF0", "hotpink" => "FF69B4", "indianred" => "CD5C5C",
    "indigo" => "4B0082", "ivory" => "FFFFF0", "khaki" => "F0E68C", "lavender" => "E6E6FA", "lavenderblush" => "FFF0F5", "lawngreen" => "7CFC00",
    "lemonchiffon" => "FFFACD", "lightblue" => "ADD8E6", "lightcoral" => "F08080", "lightcyan" => "E0FFFF", "lightgoldenrodyellow" => "FAFAD2",
    "lightgray" => "D3D3D3", "lightgreen" => "90EE90", "lightgrey" => "D3D3D3", "lightpink" => "FFB6C1", "lightsalmon" => "FFA07A", "lightseagreen" => "20B2AA",
    "lightskyblue" => "87CEFA", "lightslategray" => "778899", "lightslategrey" => "778899", "lightsteelblue" => "B0C4DE", "lightyellow" => "FFFFE0",
    "lime" => "00FF00", "limegreen" => "32CD32", "linen" => "FAF0E6", "magenta" => "FF00FF", "maroon" => "800000", "mediumaquamarine" => "66CDAA",
    "mediumblue" => "0000CD", "mediumorchid" => "BA55D3", "mediumpurple" => "9370DB", "mediumseagreen" => "3CB371", "mediumslateblue" => "7B68EE",
    "mediumspringgreen" => "00FA9A", "mediumturquoise" => "48D1CC", "mediumvioletred" => "C71585", "midnightblue" => "191970", "mintcream" => "F5FFFA",
    "mistyrose" => "FFE4E1", "moccasin" => "FFE4B5", "navajowhite" => "FFDEAD", "navy" => "000080", "oldlace" => "FDF5E6", "olive" => "808000",
    "olivedrab" => "6B8E23", "orange" => "FFA500", "orangered" => "FF4500", "orchid" => "DA70D6", "palegoldenrod" => "EEE8AA", "palegreen" => "98FB98",
    "paleturquoise" => "AFEEEE", "palevioletred" => "DB7093", "papayawhip" => "FFEFD5", "peachpuff" => "FFDAB9", "peru" => "CD853F", "pink" => "FFC0CB",
    "plum" => "DDA0DD", "powderblue" => "B0E0E6", "purple" => "800080", "red" => "FF0000", "rosybrown" => "BC8F8F", "royalblue" => "4169E1",
    "saddlebrown" => "8B4513", "salmon" => "FA8072", "sandybrown" => "F4A460", "seagreen" => "2E8B57", "seashell" => "FFF5EE", "sienna" => "A0522D",
    "silver" => "C0C0C0", "skyblue" => "87CEEB", "slateblue" => "6A5ACD", "slategray" => "708090", "slategrey" => "708090", "snow" => "FFFAFA",
    "springgreen" => "00FF7F", "steelblue" => "4682B4", "tan" => "D2B48C", "teal" => "008080", "thistle" => "D8BFD8", "tomato" => "FF6347", "turquoise" => "40E0D0",
    "violet" => "EE82EE", "wheat" => "F5DEB3", "white" => "FFFFFF", "whitesmoke" => "F5F5F5", "yellow" => "FFFF00", "yellowgreen" => "9ACD32"
    );

    if ( is_array($colour) )
      // Assume the array has the right format...
      // FIXME: should/could verify this.
      return $colour;

    $colour = strtolower($colour);

    if (isset($cssColorNames[$colour]))
      return $this->getArray($cssColorNames[$colour]);

    if ($colour === "transparent")
      return "transparent";

    $length = mb_strlen($colour);

    // #rgb format
    if ( $length == 4 && $colour[0] === "#" ) {
      return $this->getArray($colour[1].$colour[1].$colour[2].$colour[2].$colour[3].$colour[3]);

    // #rrggbb format
    } else if ( $length == 7 && $colour[0] === "#" ) {
      return $this->getArray(mb_substr($colour, 1, 6));

    // rgb( r,g,b ) format
    } else if ( mb_strpos($colour, "rgb") !== false ) {
      $i = mb_strpos($colour, "(");
      $j = mb_strpos($colour, ")");

      // Bad colour value
      if ($i === false || $j === false)
        return null;

      $triplet = explode(",", mb_substr($colour, $i+1, $j-$i-1));

      if (count($triplet) != 3)
        return null;

      foreach (array_keys($triplet) as $c) {
        $triplet[$c] = trim($triplet[$c]);
        
        if ( $triplet[$c][mb_strlen($triplet[$c]) - 1] === "%" )
          $triplet[$c] = round($triplet[$c] * 2.55);
      }

      return $this->getArray(vsprintf("%02X%02X%02X", $triplet));

    // cmyk( c,m,y,k ) format
    // http://www.w3.org/TR/css3-gcpm/#cmyk-colors
    } else if ( mb_strpos($colour, "cmyk") !== false ) {
      $i = mb_strpos($colour, "(");
      $j = mb_strpos($colour, ")");

      // Bad colour value
      if ($i === false || $j === false)
        return null;

      $values = explode(",", mb_substr($colour, $i+1, $j-$i-1));

      if (count($values) != 4)
        return null;

      foreach ($values as &$c) {
        $c = floatval(trim($c));
        if ($c > 1.0) $c = 1.0;
        if ($c < 0.0) $c = 0.0;
      }

      return $this->getArray($values);
    }
  }

  //from css_color.cls.php
  private function getArray($colour) {

    //$c = array(null, null, null, null, "hex" => null);
    $c = array("hex" => null); //We only get the hex color
    if (is_array($colour)) {
      $c = $colour;
      /*$c["c"] = $c[0];
      $c["m"] = $c[1];
      $c["y"] = $c[2];
      $c["k"] = $c[3];*/
      $c["hex"] = "cmyk($c[0],$c[1],$c[2],$c[3])";
    }
    else {
      /*$c[0] = hexdec(mb_substr($colour, 0, 2)) / 0xff;
      $c[1] = hexdec(mb_substr($colour, 2, 2)) / 0xff;
      $c[2] = hexdec(mb_substr($colour, 4, 2)) / 0xff;
      $c["r"] = $c[0];
      $c["g"] = $c[1];
      $c["b"] = $c[2];*/
      $c["hex"] = "#$colour";
    }

    return $c;
  }

  /* direct access to _important_props array from outside would work only when declared as
   * 'var $_important_props;' instead of 'protected $_important_props;'
   * Don't call _set/__get on missing attribute. Therefore need a special access.
   * Assume that __set will be also called when this is called, so do not check validity again.
   * Only created, if !important exists -> always set true.
   */
  function important_set($prop) {

    $prop = str_replace("-", "_", $prop);
    $this->_important_props[$prop] = true;
  }

  /**
   * PHP5 overloaded setter
   *
   * This function along with {@link StyleParser::__get()} permit a user of the
   * StyleParser class to access any (CSS) property using the following syntax:
   * <code>
   *  StyleParser->margin_top = "1em";
   *  echo (StyleParser->margin_top);
   * </code>
   *
   * __set() automatically calls the provided set function, if one exists,
   * otherwise it sets the property directly.  Typically, __set() is not
   * called directly from outside of this class.
   *
   * On each modification clear cache to return accurate setting.
   * Also affects direct settings not using __set
   * For easier finding all assignments, attempted to allowing only explicite assignment:
   * Very many uses, e.g. frame_reflower.cls.php -> for now leave as it is
   * function __set($prop, $val) {
   *   throw new Exception("Implicite replacement of assignment by __set.  Not good.");
   * }
   * function props_set($prop, $val) { ... }
   *
   * @param string $prop  the property to set
   * @param mixed  $val   the value of the property
   *
   */
  function __set($prop, $val) {

    $prop = str_replace("-", "_", $prop);
    $this->_prop_cache[$prop] = null;

    if ( !isset(self::$_defaults[$prop]) ) {
      global $_parserhtml_warnings;
      $_parserhtml_warnings[] = "'$prop' is not a valid CSS2 property.";
      return;
    }

    if ( $prop !== "content" && $prop !== "font_family" && is_string($val) && strlen($val) > 5 && mb_strpos($val, "url") === false ) {
      $val = mb_strtolower(trim(str_replace(array("\n", "\t"), array(" "), $val)));
      $val = preg_replace("/([0-9]+) (pt|px|pc|em|ex|in|cm|mm|%)/S", "\\1\\2", $val);
    }

    $method = "set_$prop";

    if ( method_exists($this, $method) )
      $this->$method($val);
    else
      $this->_props[$prop] = $val;
  }

  /**
   * PHP5 overloaded getter
   *
   * Along with {@link StyleParser::__set()} __get() provides access to all CSS
   * properties directly.  Typically __get() is not called directly outside
   * of this class.
   *
   * On each modification clear cache to return accurate setting.
   * Also affects direct settings not using __set
   *
   * @param string $prop
   * @return mixed
   */
  function __get($prop) {

    if ( !isset(self::$_defaults[$prop]) ){
      //throw new Exception("'$prop' is not a valid CSS2 property.");
        return;
    }

    if ( isset($this->_prop_cache[$prop]) && $this->_prop_cache[$prop] != null )
      return $this->_prop_cache[$prop];

    $method = "get_$prop";

    // Fall back on defaults if property is not set
    if ( !isset($this->_props[$prop]) )
      $this->_props[$prop] = self::$_defaults[$prop];

    if ( method_exists($this, $method) )
      return $this->_prop_cache[$prop] = $this->$method();

    return $this->_prop_cache[$prop] = $this->_props[$prop];
  }

  /**
   * Getter para el array _props[]
   * Alguna informacion de estilo (como font_family) no se puede recuperar original, tal como se encuentra en el array _props[], este metodo lo permite
   * Devuelve false si no existe la propiedad pedida.
   *
   * @param string $prop Propiedad CSS a recuperar
   * @return string
   */
  function get_props($prop) {

	  if(isset($this->_prop_cache[$prop])) return($this->_prop_cache[$prop]);
	  elseif(isset($this->_props[$prop])) return($this->_props[$prop]);
	  else return(false);
  }

  /**
   * Getter for the 'font-family' CSS property.
   *
   * Uses the {@link Font_Metrics} class to resolve the font family into an
   * actual font file.
   *
   * @link http://www.w3.org/TR/CSS21/fonts.html#propdef-font-family
   * @return string
   */
  function get_font_family() {

    $DEBUGCSS=DEBUGCSS; //=DEBUGCSS; Allow override of global setting for ad hoc debug

    // Select the appropriate font.  First determine the subtype, then check
    // the specified font-families for a candidate.

    // Resolve font-weight
    $weight = $this->__get("font_weight");

    if ( is_numeric($weight) ) {

      if ( $weight < 600 )
        $weight = "normal";
      else
        $weight = "bold";

    } else if ( $weight === "bold" || $weight === "bolder" ) {
      $weight = "bold";

    } else {
      $weight = "normal";

    }

    // Resolve font-style
    $font_style = $this->__get("font_style");

    if ( $weight === "bold" && ($font_style === "italic" || $font_style === "oblique") )
      $subtype = "bold_italic";
    else if ( $weight === "bold" && $font_style !== "italic" && $font_style !== "oblique" )
      $subtype = "bold";
    else if ( $weight !== "bold" && ($font_style === "italic" || $font_style === "oblique") )
      $subtype = "italic";
    else
      $subtype = "normal";

    // Resolve the font family
    if ($DEBUGCSS) {
      print "<pre>[get_font_family:";
      print '('.$this->_props["font_family"].'.'.$font_style.'.'.$this->__get("font_weight").'.'.$weight.'.'.$subtype.')';
    }
    $families = explode(",", $this->_props["font_family"]);
    $families = array_map('trim',$families);
    reset($families);

    $font = null;
    while ( current($families) ) {
      list(,$family) = each($families);
      //remove leading and trailing string delimiters, e.g. on font names with spaces;
      //remove leading and trailing whitespace
      $family=trim($family," \t\n\r\x0B\"'");
      if ($DEBUGCSS) print '('.$family.')';
      $font = Font_Metrics::get_font($family, $subtype);

      if ( $font ) {
        if ($DEBUGCSS)  print '('.$font.")get_font_family]\n</pre>";
        return $font;
      }
    }

    $family = null;
    if ($DEBUGCSS)  print '(default)';
    $font = Font_Metrics::get_font($family, $subtype);

    if ( $font ) {
      if ($DEBUGCSS) print '('.$font.")get_font_family]\n</pre>";
      return $font;
    }
    throw new Exception("Unable to find a suitable font replacement for: '" . $this->_props["font_family"] ."'");

  }

  /**
   * Returns the resolved font size, in points
   *
   * @link http://www.w3.org/TR/CSS21/fonts.html#propdef-font-size
   * @return float
   */
  function get_font_size() {

    if ( $this->__font_size_calculated )
      return $this->_props["font_size"];

    if ( !isset($this->_props["font_size"]) )
      $fs = self::$_defaults["font_size"];
    else
      $fs = $this->_props["font_size"];

    if ( !isset($this->_parent_font_size) )
      $this->_parent_font_size = $this->default_font_size;

    switch ($fs) {
    case "xx-small":
    case "x-small":
    case "small":
    case "medium":
    case "large":
    case "x-large":
    case "xx-large":
      $fs = $this->default_font_size * @$this->font_size_keywords[$fs];
      break;

    case "smaller":
      $fs = 8/9 * $this->_parent_font_size;
      break;

    case "larger":
      $fs = 6/5 * $this->_parent_font_size;
      break;

    default:
      break;
    }

    // Ensure relative sizes resolve to something
    if ( ($i = mb_strpos($fs, "em")) !== false )
      $fs = mb_substr($fs, 0, $i) * $this->_parent_font_size;

    else if ( ($i = mb_strpos($fs, "ex")) !== false )
      $fs = mb_substr($fs, 0, $i) * $this->_parent_font_size;

    else
      $fs = $this->length_in_pt($fs);

    //see __set and __get, on all assignments clear cache!
    $this->_prop_cache["font_size"] = null;
    $this->_props["font_size"] = $fs;
    $this->__font_size_calculated = true;
    return $this->_props["font_size"];

  }

  /**
   * @link http://www.w3.org/TR/CSS21/visudet.html#propdef-line-height
   * @return float
   */
  function get_line_height() {

    $line_height = $this->_props["line_height"];

    if ( $line_height === "normal" )
      return $this->default_line_height * $this->get_font_size();

    if ( is_numeric($line_height) )
      return $this->length_in_pt( $line_height . "em", $this->get_font_size());

    return $this->length_in_pt( $line_height, $this->get_font_size() );
  }

  /**
   * Returns the colour as an array
   *
   * The array has the following format:
   * <code>array(r,g,b, "r" => r, "g" => g, "b" => b, "hex" => "#rrggbb")</code>
   *
   * @link http://www.w3.org/TR/CSS21/colors.html#propdef-color
   * @return array
   */
  function get_color() {

    return $this->munge_colour( $this->_props["color"] );
  }

  /**
   * Returns the background colour as an array
   *
   * The returned array has the same format as {@link StyleParser::get_color()}
   *
   * @link http://www.w3.org/TR/CSS21/colors.html#propdef-background-color
   * @return array
   */
  function get_background_color() {

    return $this->munge_colour( $this->_props["background_color"] );
  }

  /**#@+
   * Returns the border colour as an array
   *
   * See {@link StyleParser::get_color()}
   *
   * @link http://www.w3.org/TR/CSS21/box.html#border-color-properties
   * @return array
   */
  function get_border_top_color() {

    if ( $this->_props["border_top_color"] === "" ) {
      //see __set and __get, on all assignments clear cache!
      $this->_prop_cache["border_top_color"] = null;
      $this->_props["border_top_color"] = $this->__get("color");
    }
    return $this->munge_colour($this->_props["border_top_color"]);
  }

  function get_border_right_color() {

    if ( $this->_props["border_right_color"] === "" ) {
      //see __set and __get, on all assignments clear cache!
      $this->_prop_cache["border_right_color"] = null;
      $this->_props["border_right_color"] = $this->__get("color");
    }
    return $this->munge_colour($this->_props["border_right_color"]);
  }

  function get_border_bottom_color() {

    if ( $this->_props["border_bottom_color"] === "" ) {
      //see __set and __get, on all assignments clear cache!
      $this->_prop_cache["border_bottom_color"] = null;
      $this->_props["border_bottom_color"] = $this->__get("color");
    }
    return $this->munge_colour($this->_props["border_bottom_color"]);
  }

  function get_border_left_color() {

    if ( $this->_props["border_left_color"] === "" ) {
      //see __set and __get, on all assignments clear cache!
      $this->_prop_cache["border_left_color"] = null;
      $this->_props["border_left_color"] = $this->__get("color");
    }
    return $this->munge_colour($this->_props["border_left_color"]);
  }
  

 /**
  * Returns the border width, as it is currently stored
  *
  * @link http://www.w3.org/TR/CSS21/box.html#border-width-properties
  * @return float|string
  */
  function get_border_top_width() {

    $style = $this->__get("border_top_style");
    return $style !== "none" && $style !== "hidden" ? $this->length_in_pt($this->_props["border_top_width"]) : 0;
  }

  function get_border_right_width() {

    $style = $this->__get("border_right_style");
    return $style !== "none" && $style !== "hidden" ? $this->length_in_pt($this->_props["border_right_width"]) : 0;
  }

  function get_border_bottom_width() {

    $style = $this->__get("border_bottom_style");
    return $style !== "none" && $style !== "hidden" ? $this->length_in_pt($this->_props["border_bottom_width"]) : 0;
  }

  function get_border_left_width() {

    $style = $this->__get("border_left_style");
    return $style !== "none" && $style !== "hidden" ? $this->length_in_pt($this->_props["border_left_width"]) : 0;
  }

  /**
   * Return a single border property
   *
   * @return mixed
   */
  protected function _get_border($side) {
    $color = $this->__get("border_" . $side . "_color");

    return $this->__get("border_" . $side . "_width") . " " .
      $this->__get("border_" . $side . "_style") . " " . $color["hex"];
  }

  /**
   * Return full border properties as a string
   *
   * Border properties are returned just as specified in CSS:
   * <pre>[width] [style] [color]</pre>
   * e.g. "1px solid blue"
   *
   * @link http://www.w3.org/TR/CSS21/box.html#border-shorthand-properties
   * @return string
   */
  function get_border_top() { return $this->_get_border("top"); }
  function get_border_right() { return $this->_get_border("right"); }
  function get_border_bottom() { return $this->_get_border("bottom"); }
  function get_border_left() { return $this->_get_border("left"); }

  /*
   !important attribute
   For basic functionality of the !important attribute with overloading
   of several styles of an element, changes in inherit(), merge() and _parse_properties()
   are sufficient [helpers var $_important_props, __construct(), important_set(), important_get()]

   Only for combined attributes extra treatment needed. See below.

   div { border: 1px red; }
   div { border: solid; } // Not combined! Only one occurence of same style per context
   //
   div { border: 1px red; }
   div a { border: solid; } // Adding to border style ok by inheritance
   //
   div { border-style: solid; } // Adding to border style ok because of different styles
   div { border: 1px red; }
   //
   div { border-style: solid; !important} // border: overrides, even though not !important
   div { border: 1px dashed red; }
   //
   div { border: 1px red; !important }
   div a { border-style: solid; } // Need to override because not set

   Special treatment:
   At individual property like border-top-width need to check whether overriding value is also !important.
   Also store the !important condition for later overrides.
   Since not known who is initiating the override, need to get passed !importan as parameter.
   !important Paramter taken as in the original style in the css file.
   When poperty border !important given, do not mark subsets like border_style as important. Only
   individual properties.

   Note:
   Setting individual property directly from css with e.g. set_border_top_style() is not needed, because
   missing set funcions handled by a generic handler __set(), including the !important.
   Setting individual property of as sub-property is handled below.

   Implementation see at _set_style_side_type()
   Callers _set_style_sides_type(), _set_style_type, _set_style_type_important()

   Related functionality for background, padding, margin, font, list_style
  */

  /* Generalized set function for individual attribute of combined style.
   * With check for !important
   * Applicable for background, border, padding, margin, font, list_style
   * Note: $type has a leading underscore (or is empty), the others not.
   */
  protected function _set_style_side_type($style,$side,$type,$val,$important) {

    $prop = $style.'_'.$side.$type;

    if ( !isset($this->_important_props[$prop]) || $important) {
      //see __set and __get, on all assignments clear cache!
      $this->_prop_cache[$prop] = null;
      if ($important) {
        $this->_important_props[$prop] = true;
      }
      $this->_props[$prop] = $val;
    }
  }

  protected function _set_style_sides_type($style,$top,$right,$bottom,$left,$type,$important) {

      $this->_set_style_side_type($style,'top',$type,$top,$important);
      $this->_set_style_side_type($style,'right',$type,$right,$important);
      $this->_set_style_side_type($style,'bottom',$type,$bottom,$important);
      $this->_set_style_side_type($style,'left',$type,$left,$important);
  }

  protected function _set_style_type($style,$type,$val,$important) {

    $arr = explode(" ", $val);
    switch (count($arr)) {
    case 1:
      $this->_set_style_sides_type($style,$arr[0],$arr[0],$arr[0],$arr[0],$type,$important);
      break;
    case 2:
      $this->_set_style_sides_type($style,$arr[0],$arr[1],$arr[0],$arr[1],$type,$important);
      break;
    case 3:
      $this->_set_style_sides_type($style,$arr[0],$arr[1],$arr[2],$arr[1],$type,$important);
      break;
    case 4:
      $this->_set_style_sides_type($style,$arr[0],$arr[1],$arr[2],$arr[3],$type,$important);
      break;
    default:
      break;
    }
    //see __set and __get, on all assignments clear cache!
    $this->_prop_cache[$style.$type] = null;
    $this->_props[$style.$type] = $val;
  }

  protected function _set_style_type_important($style,$type,$val) {

    $this->_set_style_type($style,$type,$val,isset($this->_important_props[$style.$type]));
  }

  /* Anyway only called if _important matches and is assigned
   * E.g. _set_style_side_type($style,$side,'',str_replace("none", "0px", $val),isset($this->_important_props[$style.'_'.$side]));
   */
  protected function _set_style_side_width_important($style,$side,$val) {

    //see __set and __get, on all assignments clear cache!
    $this->_prop_cache[$style.'_'.$side] = null;
    $this->_props[$style.'_'.$side] = str_replace("none", "0px", $val);
  }

  protected function _set_style($style,$val,$important) {
    if ( !isset($this->_important_props[$style]) || $important) {
      if ($important) {
        $this->_important_props[$style] = true;
      }
      //see __set and __get, on all assignments clear cache!
      $this->_prop_cache[$style] = null;
      $this->_props[$style] = $val;
    }
  }

  protected function _image($val) {

    if ( mb_strpos($val, "url") === false ) {
      $path = "none"; //Don't resolve no image -> otherwise would prefix path and no longer recognize as none
    } else {
      $val = preg_replace("/url\(['\"]?([^'\")]+)['\"]?\)/","\\1", trim($val));

      // Resolve the url now in the context of the current stylesheet
      $parsed_url = explode_url_parser($val);
      if ( $parsed_url["protocol"] == "" && $this->_stylesheet->get_protocol() == "" ) {
        if ($parsed_url["path"][0] === '/' || $parsed_url["path"][0] === '\\' ) {
          $path = $_SERVER["DOCUMENT_ROOT"].'/';
        } else {
          $path = $this->_stylesheet->get_base_path();
        }
        $path .= $parsed_url["path"] . $parsed_url["file"];
        $path = realpath($path);
        // If realpath returns FALSE then specifically state that there is no background image
        if (!$path) { $path = 'none'; }
      } else {
        $path = build_url_parser($this->_stylesheet->get_protocol(),
                          $this->_stylesheet->get_host(),
                          $this->_stylesheet->get_base_path(),
                          $val);
      }
    }
    return $path;
  }

  /**
   * Sets colour
   *
   * The colour parameter can be any valid CSS colour value
   *
   * @link http://www.w3.org/TR/CSS21/colors.html#propdef-color
   * @param string $colour
   */
  function set_color($colour) {

    $col = $this->munge_colour($colour);

    if ( is_null($col) ) {
      $col = self::$_defaults["color"];
    }

    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["color"] = null;
    if (is_array($col)) {
        $this->_props["color"] = $col["hex"];
    } else {
        $this->_props["color"] = $col;
    }
  }

  /**
   * Sets the background colour
   *
   * @link http://www.w3.org/TR/CSS21/colors.html#propdef-background-color
   * @param string $colour
   */
  function set_background_color($colour) {

    $col = $this->munge_colour($colour);
    if ( is_null($col) )
      $col = self::$_defaults["background_color"];

    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["background_color"] = null;
    $this->_props["background_color"] = is_array($col) ? $col["hex"] : $col;
  }

  /**
   * Sets the background - combined options
   *
   * @link http://www.w3.org/TR/CSS21/colors.html#propdef-background
   * @param string $val
   */
  function set_background($val) {
    $col = null;
    $pos = array();
    $tmp = preg_replace("/\s*\,\s*/", ",", $val); // when rgb() has spaces
    $tmp = explode(" ", $tmp);
    $important = isset($this->_important_props["background"]);

    foreach($tmp as $attr) {
      if (($col = $this->munge_colour($attr)) != null ) {
        $this->_set_style("background_color", is_array($col) ? $col["hex"] : $col, $important);
      } else {
        $pos[] = $attr;
      }
    }

    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    /*
    //FIXME inheritance problems: background: #ccc; in <table> overwrite background-color in <tr>, <td>, ...
    $this->_prop_cache["background"] = null;
    $this->_props["background"] = $val;
    /**/
  }

  /**
   * Sets the font size
   *
   * $size can be any acceptable CSS size
   *
   * @link http://www.w3.org/TR/CSS21/fonts.html#propdef-font-size
   * @param string|float $size
   */
  function set_font_size($size) {

    $this->__font_size_calculated = false;
    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["font_size"] = null;
    $this->_props["font_size"] = $size;
  }

  /**
   * Sets the font style
   *
   * combined attributes
   * set individual attributes also, respecting !important mark
   * exactly this order, separate by space. Multiple fonts separated by comma:
   * font-style, font-variant, font-weight, font-size, line-height, font-family
   *
   * Other than with border and list, existing partial attributes should
   * reset when starting here, even when not mentioned.
   * If individual attribute is !important and explicite or implicite replacement is not,
   * keep individual attribute
   *
   * require whitespace as delimiters for single value attributes
   * On delimiter "/" treat first as font height, second as line height
   * treat all remaining at the end of line as font
   * font-style, font-variant, font-weight, font-size, line-height, font-family
   *
   * missing font-size and font-family might be not allowed, but accept it here and
   * use default (medium size, enpty font name)
   *
   * @link http://www.w3.org/TR/CSS21/generate.html#propdef-list-style
   * @param $val
   */
  function set_font($val) {
    $this->__font_size_calculated = false;
    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["font"] = null;
    $this->_props["font"] = $val;

    $important = isset($this->_important_props["font"]);

    if ( preg_match("/^(italic|oblique|normal)\s*(.*)$/i",$val,$match) ) {
      $this->_set_style("font_style", $match[1], $important);
      $val = $match[2];
    } else {
      $this->_set_style("font_style", self::$_defaults["font_style"], $important);
    }

    if ( preg_match("/^(small-caps|normal)\s*(.*)$/i",$val,$match) ) {
      $this->_set_style("font_variant", $match[1], $important);
      $val = $match[2];
    } else {
      $this->_set_style("font_variant", self::$_defaults["font_variant"], $important);
    }

    //matching numeric value followed by unit -> this is indeed a subsequent font size. Skip!
    if ( preg_match("/^(bold|bolder|lighter|100|200|300|400|500|600|700|800|900|normal)\s*(.*)$/i",$val,$match) &&
         !preg_match("/^(?:pt|px|pc|em|ex|in|cm|mm|%)/",$match[2])
       ) {
      $this->_set_style("font_weight", $match[1], $important);
      $val = $match[2];
    } else {
      $this->_set_style("font_weight", self::$_defaults["font_weight"], $important);
    }

    if ( preg_match("/^(xx-small|x-small|small|medium|large|x-large|xx-large|smaller|larger|\d+\s*(?:pt|px|pc|em|ex|in|cm|mm|%))\s*(.*)$/i",$val,$match) ) {
      $this->_set_style("font_size", $match[1], $important);
      $val = $match[2];
      if (preg_match("/^\/\s*(\d+\s*(?:pt|px|pc|em|ex|in|cm|mm|%))\s*(.*)$/i",$val,$match) ) {
        $this->_set_style("line_height", $match[1], $important);
        $val = $match[2];
      } else {
        $this->_set_style("line_height", self::$_defaults["line_height"], $important);
      }
    } else {
      $this->_set_style("font_size", self::$_defaults["font_size"], $important);
      $this->_set_style("line_height", self::$_defaults["line_height"], $important);
    }

    if(strlen($val) != 0) {
      $this->_set_style("font_family", $val, $important);
    } else {
      $this->_set_style("font_family", self::$_defaults["font_family"], $important);
    }
  }

  /**
   * Sets page break properties
   *
   * @link http://www.w3.org/TR/CSS21/page.html#page-breaks
   * @param string $break
   */
  function set_page_break_before($break) {
    if ($break === "left" || $break === "right")
      $break = "always";

    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["page_break_before"] = null;
    $this->_props["page_break_before"] = $break;
  }

  function set_page_break_after($break) {
    if ($break === "left" || $break === "right")
      $break = "always";

    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["page_break_after"] = null;
    $this->_props["page_break_after"] = $break;
  }

  /**
   * Sets the margin size
   *
   * @link http://www.w3.org/TR/CSS21/box.html#margin-properties
   * @param $val
   */
  function set_margin_top($val) {

    $this->_set_style_side_width_important('margin','top',$val);
  }

  function set_margin_right($val) {

    $this->_set_style_side_width_important('margin','right',$val);
  }

  function set_margin_bottom($val) {

    $this->_set_style_side_width_important('margin','bottom',$val);
  }

  function set_margin_left($val) {

    $this->_set_style_side_width_important('margin','left',$val);
  }

  function set_margin($val) {

    $val = str_replace("none", "0px", $val);
    $this->_set_style_type_important('margin','',$val);
  }

  /**
   * Sets the padding size
   *
   * @link http://www.w3.org/TR/CSS21/box.html#padding-properties
   * @param $val
   */
  function set_padding_top($val) {
    $this->_set_style_side_width_important('padding','top',$val);
  }

  function set_padding_right($val) {
    $this->_set_style_side_width_important('padding','right',$val);
  }

  function set_padding_bottom($val) {
    $this->_set_style_side_width_important('padding','bottom',$val);
  }

  function set_padding_left($val) {
    $this->_set_style_side_width_important('padding','left',$val);
  }

  function set_padding($val) {

    $val = str_replace("none", "0px", $val);
    $this->_set_style_type_important('padding','',$val);
  }

  /**
   * Sets a single border
   *
   * @param string $side
   * @param string $border_spec  ([width] [style] [color])
   */
  protected function _set_border($side, $border_spec, $important) {

    $border_spec = preg_replace("/\s*\,\s*/", ",", $border_spec);
    //$border_spec = str_replace(",", " ", $border_spec); // Why did we have this ?? rbg(10, 102, 10) > rgb(10  102  10)
    $arr = explode(" ", $border_spec);

    // FIXME: handle partial values
 
    //For consistency of individal and combined properties, and with ie8 and firefox3
    //reset all attributes, even if only partially given
    $this->_set_style_side_type('border',$side,'_style',self::$_defaults['border_'.$side.'_style'],$important);
    $this->_set_style_side_type('border',$side,'_width',self::$_defaults['border_'.$side.'_width'],$important);
    $this->_set_style_side_type('border',$side,'_color',self::$_defaults['border_'.$side.'_color'],$important);

    foreach ($arr as $value) {
      $value = trim($value);
      if ( in_array($value, $this->BORDER_STYLES) ) {
        $this->_set_style_side_type('border',$side,'_style',$value,$important);

      } else if ( preg_match("/[.0-9]+(?:px|pt|pc|em|ex|%|in|mm|cm)|(?:thin|medium|thick)/", $value ) ) {
        $this->_set_style_side_type('border',$side,'_width',$value,$important);

      } else {
        // must be colour
        $this->_set_style_side_type('border',$side,'_color',$value,$important);
      }
    }

    //see __set and __get, on all assignments clear cache!
    $this->_prop_cache['border_'.$side] = null;
    $this->_props['border_'.$side] = $border_spec;
  }

  /**
   * Sets the border styles
   *
   * @link http://www.w3.org/TR/CSS21/box.html#border-properties
   * @param string $val
   */
  function set_border_top($val) {
$this->_set_border("top", $val, isset($this->_important_props['border_top'])); }
  function set_border_right($val) {
$this->_set_border("right", $val, isset($this->_important_props['border_right'])); }
  function set_border_bottom($val) {
$this->_set_border("bottom", $val, isset($this->_important_props['border_bottom'])); }
  function set_border_left($val) {
$this->_set_border("left", $val, isset($this->_important_props['border_left'])); }

  function set_border($val) {

    $important = isset($this->_important_props["border"]);
    $this->_set_border("top", $val, $important);
    $this->_set_border("right", $val, $important);
    $this->_set_border("bottom", $val, $important);
    $this->_set_border("left", $val, $important);
    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["border"] = null;
    $this->_props["border"] = $val;
  }

  function set_border_width($val) {
    $this->_set_style_type_important('border','_width',$val);
  }

  function set_border_color($val) {
    $this->_set_style_type_important('border','_color',$val);
  }

  function set_border_style($val) {
    $this->_set_style_type_important('border','_style',$val);
  }

  /**
   * Sets the border spacing
   *
   * @link http://www.w3.org/TR/CSS21/box.html#border-properties
   * @param float $val
   */
  function set_border_spacing($val) {

    $arr = explode(" ", $val);

    if ( count($arr) == 1 )
      $arr[1] = $arr[0];

    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["border_spacing"] = null;
    $this->_props["border_spacing"] = "$arr[0] $arr[1]";
  }

  /**
   * Sets the list style image
   *
   * @link http://www.w3.org/TR/CSS21/generate.html#propdef-list-style-image
   * @param $val
   */
  function set_list_style_image($val) {
    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["list_style_image"] = null;
    $this->_props["list_style_image"] = $this->_image($val);
  }

  /**
   * Sets the list style
   *
   * @link http://www.w3.org/TR/CSS21/generate.html#propdef-list-style
   * @param $val
   */
  function set_list_style($val) {
    $important = isset($this->_important_props["list_style"]);
    $arr = explode(" ", str_replace(",", " ", $val));

    static $types = array(
      "disc", "circle", "square",
      "decimal-leading-zero", "decimal", "1",
      "lower-roman", "upper-roman", "a", "A",
      "lower-greek",
      "lower-latin", "upper-latin",
      "lower-alpha", "upper-alpha",
      "armenian", "georgian", "hebrew",
      "cjk-ideographic", "hiragana", "katakana",
      "hiragana-iroha", "katakana-iroha", "none"
    );

    static $positions = array("inside", "outside");

    foreach ($arr as $value) {
      /* http://www.w3.org/TR/CSS21/generate.html#list-style
       * A value of 'none' for the 'list-style' property sets both 'list-style-type' and 'list-style-image' to 'none'
       */
      if ($value === "none") {
         $this->_set_style("list_style_type", $value, $important);
         $this->_set_style("list_style_image", $value, $important);
        continue;
      }

      //On setting or merging or inheriting list_style_image as well as list_style_type,
      //and url exists, then url has precedence, otherwise fall back to list_style_type
      //Firefox is wrong here (list_style_image gets overwritten on explicite list_style_type)
      //Internet Explorer 7/8 and dompdf is right.

      if (mb_substr($value, 0, 3) === "url") {
        $this->_set_style("list_style_image", $this->_image($value), $important);
        continue;
      }

      if ( in_array($value, $types) ) {
        $this->_set_style("list_style_type", $value, $important);
      } else if ( in_array($value, $positions) ) {
        $this->_set_style("list_style_position", $value, $important);
      }
    }

    //see __set and __get, on all assignments clear cache, not needed on direct set through __set
    $this->_prop_cache["list_style"] = null;
    $this->_props["list_style"] = $val;
  }

  function set_size($val) {

    $length_re = "/(\d+\s*(?:pt|px|pc|em|ex|in|cm|mm|%))/";

    $val = mb_strtolower($val);

    if ( $val === "auto" ) {
      return;
    }

    $parts = preg_split("/\s+/", $val);

    $computed = array();
    if ( preg_match($length_re, $parts[0]) ) {
      $computed[] = $this->length_in_pt($parts[0]);

      if ( isset($parts[1]) && preg_match($length_re, $parts[1]) ) {
        $computed[] = $this->length_in_pt($parts[1]);
      }
      else {
        $computed[] = $computed[0];
      }
    }
    elseif ( isset(CPDF_Adapter::$PAPER_SIZES[$parts[0]]) ) {
      $computed = array_slice(CPDF_Adapter::$PAPER_SIZES[$parts[0]], 2, 2);

      if ( isset($parts[1]) && $parts[1] === "landscape" ) {
        $computed = array_reverse($computed);
      }
    }
    else {
      return;
    }

    $this->_props["size"] = $computed;
  }

}
