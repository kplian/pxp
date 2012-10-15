#!/usr/bin/env php
<?php

$data = array(
	'@version' => '0.1.3',
	'@author' => 'Revolunet'
);

$replace = array('{{classname}}' => 'Ext.ux.AwesomeCombo',
                 '{{xtype}}' => 'awesomecombo');

$root = dirname(__FILE__).'/';
$output = 'Ext.ux.AwesomeCombo.js';

$files = array(
	'core.js',
	'override.js',
	'events.js',
	'tooltip.js',
	'format.js'
);

$src = array();
foreach ($files as $file) {
  $content = file_get_contents($root.'src/'.$file);
  foreach ($data as $key => $value) {
    $content = str_replace($key, $key.' '.$value, $content);
  }
  foreach ($replace as $key => $value) {
    $content = str_replace($key, $value, $content);
  }
  $src[] = $content;
}

file_put_contents($root.$output, implode(chr(10), $src));
echo '[+] "', $root, $output, '" generated.', chr(10);
