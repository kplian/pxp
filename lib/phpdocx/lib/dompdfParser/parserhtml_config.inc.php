<?php
/**
 * DOMPDF - PHP5 HTML to PDF renderer
 *
 * File: $RCSfile: dompdf_config.inc.php,v $
 * Created on: 2004-08-04
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
 * @package dompdf
 *
 * Changes
 * @contributor Helmut Tischer <htischer@weihenstephan.org>
 * @version 0.5.1.htischer.20090507
 * - Allow overriding of configuration settings by calling php script.
 *   This allows replacing of dompdf by a new version in an application
 *   without any modification,
 * - Optionally separate font cache folder from font folder.
 *   This allows write protecting the entire installation
 * - Add settings to enable/disable additional debug output categories
 * - Change some defaults to more practical values
 * - Add comments about configuration parameter implications
 */

/* $Id: dompdf_config.inc.php 363 2011-02-17 21:18:25Z fabien.menager $ */

error_reporting(E_ALL & ~E_STRICT & ~E_NOTICE);

/**
 * The root of your DOMPDF installation
 */
define("PARSERHTML_DIR", str_replace(DIRECTORY_SEPARATOR, '/', realpath(dirname(__FILE__))));

/**
 * The location of the DOMPDF include directory
 */
define("PARSERHTML_INC_DIR", PARSERHTML_DIR . "/include");

/**
 * The location of the DOMPDF lib directory
 */
define("PARSERHTML_LIB_DIR", PARSERHTML_DIR . "/lib");

/**
 * Some installations don't have $_SERVER['DOCUMENT_ROOT']
 * http://fyneworks.blogspot.com/2007/08/php-documentroot-in-iis-windows-servers.html
 */
if( !isset($_SERVER['DOCUMENT_ROOT']) ) {
  $path = "";
  
  if ( isset($_SERVER['SCRIPT_FILENAME']) )
    $path = $_SERVER['SCRIPT_FILENAME'];
  elseif ( isset($_SERVER['PATH_TRANSLATED']) )
    $path = str_replace('\\\\', '\\', $_SERVER['PATH_TRANSLATED']);
    
  $_SERVER['DOCUMENT_ROOT'] = str_replace( '\\', '/', substr($path, 0, 0-strlen($_SERVER['PHP_SELF'])));
}

/** Include the custom config file if it exists */
if ( file_exists(PARSERHTML_DIR . "/parserhtml_config.custom.inc.php") ){
  require_once(PARSERHTML_DIR . "/parserhtml_config.custom.inc.php");
}

//FIXME: Some function definitions rely on the constants defined by DOMPDF. However, might this location prove problematic?
require_once(PARSERHTML_INC_DIR . "/functions_parser.inc.php");

/**
 * ==== IMPORTANT ====
 *
 * dompdf's "chroot": Prevents dompdf from accessing system files or other
 * files on the webserver.  All local files opened by dompdf must be in a
 * subdirectory of this directory.  DO NOT set it to '/' since this could
 * allow an attacker to use dompdf to read any files on the server.  This
 * should be an absolute path.
 * This is only checked on command line call by dompdf.php, but not by
 * direct class use like:
 * $dompdf = new DOMPDF();	$dompdf->load_html($htmldata); $dompdf->render(); $pdfdata = $dompdf->output();
 */
def_parser("PARSERHTML_CHROOT", realpath(PARSERHTML_DIR));

/**
 * The path to the tt2pt1 utility (used to convert ttf to afm)
 *
 * Not strictly necessary, but useful if you would like to install
 * additional fonts using the {@link load_font.php} utility.
 *
 * Windows users should use something like this:
 * define("TTF2AFM", "C:\\Program Files\\Ttf2Pt1\\bin\\ttf2pt1.exe");
 *
 * @link http://ttf2pt1.sourceforge.net/
 */
if ( strpos(PHP_OS, "WIN") === false )
  def_parser("TTF2AFM", PARSERHTML_LIB_DIR ."/ttf2ufm/ttf2ufm-src/ttf2pt1");
else
  def_parser("TTF2AFM", "C:\\Program Files\\GnuWin32\\bin\\ttf2pt1.exe");

/**
 * html target media view which should be rendered into pdf.
 * List of types and parsing rules for future extensions:
 * http://www.w3.org/TR/REC-html40/types.html
 *   screen, tty, tv, projection, handheld, print, braille, aural, all
 * Note: aural is deprecated in CSS 2.1 because it is replaced by speech in CSS 3.
 * Note, even though the generated pdf file is intended for print output,
 * the desired content might be different (e.g. screen or projection view of html file).
 * Therefore allow specification of content here.
 */
def_parser("PARSERHTML_DEFAULT_MEDIA_TYPE", "screen");

/**
 * Image DPI setting
 *
 * This setting determines the default DPI setting for images and fonts.  The
 * DPI may be overridden for inline images by explictly setting the
 * image's width & height style attributes (i.e. if the image's native
 * width is 600 pixels and you specify the image's width as 72 points,
 * the image will have a DPI of 600 in the rendered PDF.  The DPI of
 * background images can not be overridden and is controlled entirely
 * via this parameter.
 *
 * For the purposes of DOMPDF, pixels per inch (PPI) = dots per inch (DPI).
 * If a size in html is given as px (or without unit as image size),
 * this tells the corresponding size in pt.
 * This adjusts the relative sizes to be similar to the rendering of the
 * html page in a reference browser.
 *
 * In pdf, always 1 pt = 1/72 inch
 *
 * Rendering resolution of various browsers in px per inch:
 * Windows Firefox and Internet Explorer:
 *   SystemControl->Display properties->FontResolution: Default:96, largefonts:120, custom:?
 * Linux Firefox:
 *   about:config *resolution: Default:96
 *   (xorg screen dimension in mm and Desktop font dpi settings are ignored)
 *
 * Take care about extra font/image zoom factor of browser.
 *
 * In images, <img> size in pixel attribute, img css style, are overriding
 * the real image dimension in px for rendering.
 *
 * @var int
 */
def_parser("PARSERHTML_DPI", 96);

/**
 * Enable remote file access
 *
 * If this setting is set to true, DOMPDF will access remote sites for
 * images and CSS files as required.
 * This is required for part of test case www/test/image_variants.html through www/examples.php
 *
 * Attention!
 * This can be a security risk, in particular in combination with PARSERHTML_ENABLE_PHP and
 * allowing remote access to dompdf.php or on allowing remote html code to be passed to
 * $dompdf = new DOMPDF(); $dompdf->load_html(...);
 * This allows anonymous users to download legally doubtful internet content which on
 * tracing back appears to being downloaded by your server, or allows malicious php code
 * in remote html pages to be executed by your server with your account privileges.
 *
 * @var bool
 */
def_parser("PARSERHTML_ENABLE_REMOTE", true);

/**
 * Enable CSS float
 *
 * Allows people to disabled CSS float support
 * @var bool
 */
def_parser("PARSERHTML_ENABLE_CSS_FLOAT", false);

include_once(PARSERHTML_DIR.'/include/frameparser.cls.php');
include_once(PARSERHTML_DIR.'/include/attribute_translator_parser.cls.php');
include_once(PARSERHTML_DIR.'/include/frameparser_tree.cls.php');
include_once(PARSERHTML_DIR.'/include/parserhtml.cls.php');
include_once(PARSERHTML_DIR.'/include/styleparser.cls.php');
include_once(PARSERHTML_DIR.'/include/styleparsersheet.cls.php');
include_once(PARSERHTML_DIR.'/include/functions_parser.inc.php');

/**
 * PARSERHTML autoload function
 *
 * If you have an existing autoload function, add a call to this function
 * from your existing __autoload() implementation.
 *
 * @param string $class
 */
/*function PARSERHTML_autoload($class) {
  $filename = PARSERHTML_INC_DIR . "/" . mb_strtolower($class) . ".cls.php";
  
  if ( is_file($filename) )
    require_once($filename);
}

// If SPL autoload functions are available (PHP >= 5.1.2)
if ( function_exists("spl_autoload_register") ) {
  $autoload = "PARSERHTML_autoload";
  $funcs = spl_autoload_functions();
  
  // No functions currently in the stack.
  if ( $funcs === false ) {
    spl_autoload_register($autoload);
  }
  
  // If PHP >= 5.3 the $prepend argument is available
  else if ( version_compare(PHP_VERSION, '5.3', '>=') ) {
    spl_autoload_register($autoload, true, true);
  }
  
  else {
    // Unregister existing autoloaders...
    $compat = version_compare(PHP_VERSION, '5.1.2', '<=') &&
              version_compare(PHP_VERSION, '5.1.0', '>=');
              
    foreach ($funcs as $func) {
      if (is_array($func)) {
        // :TRICKY: There are some compatibility issues and some
        // places where we need to error out
        $reflector = new ReflectionMethod($func[0], $func[1]);
        if (!$reflector->isStatic()) {
          throw new Exception('This function is not compatible with non-static object methods due to PHP Bug #44144.');
        }
        
        // Suprisingly, spl_autoload_register supports the
        // Class::staticMethod callback format, although call_user_func doesn't
        if ($compat) $func = implode('::', $func);
      }
      
      spl_autoload_unregister($func);
    }
    
    // Register the new one, thus putting it at the front of the stack...
    spl_autoload_register($autoload);
    
    // Now, go back and re-register all of our old ones.
    foreach ($funcs as $func) {
      spl_autoload_register($func);
    }
    
    // Be polite and ensure that userland autoload gets retained
    if ( function_exists("__autoload") ) {
      spl_autoload_register("__autoload");
    }
  }
}*/

//else if ( !function_exists("__autoload") ) {
  /**
   * Default __autoload() function
   *
   * @param string $class
   */
/*  function __autoload($class) {
    PARSERHTML_autoload($class);
  }
}*/

// ### End of user-configurable options ###


/**
 * Ensure that PHP is working with text internally using UTF8 character encoding.
 */
mb_internal_encoding('UTF-8');

/**
 * Global array of warnings generated by DomDocument parser and
 * stylesheet class
 *
 * @var array
 */
global $_dompdf_warnings;
$_dompdf_warnings = array();

/**
 * If true, $_dompdf_warnings is dumped on script termination when using
 * dompdf/dompdf.php or after rendering when using the DOMPDF class.
 * When using the class, setting this value to true will prevent you from
 * streaming the PDF.
 *
 * @var bool
 */
global $_dompdf_show_warnings;
$_dompdf_show_warnings = false;
